Received: from eggs.gnu.org ([2001:4830:134:3::10]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d6bkK-0002cK-My
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d6bkH-0007nr-GQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:50:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:54119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d6bkH-0007nd-9X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:50:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d6bkF-0004Mg-Ax
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 11:49:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 72D732E80D8
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 11:49:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 May 2017 11:39:23 -0000
From: Thomas Huth <778032@bugs.launchpad.net>
Reply-To: Bug 778032 <778032@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110505180701.14074.17686.malonedeb@wampee.canonical.com>
Message-Id: <20170505113923.13031.44591.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 778032] Re: qemu spinning on serial port writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU have you been using here? Can you still reproduce
this problem with the latest version of QEMU (currently version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/778032

Title:
  qemu spinning on serial port writes

Status in QEMU:
  Incomplete

Bug description:
  As originally found at http://www.mail-
  archive.com/kvm@vger.kernel.org/msg08745.html from 3 years ago!

  Basically qemu seizes up in the event that the file descriptor for its
  emulated serial port has a full buffer, i.e. write() returns EAGAIN.
  For me, this happened when the serial port was being directed through
  a UNIX socket, with a default-sized 4KB buffer.  Just the normal
  output from a Linux kernel boot caused it to seize up, and stop the
  main emulation / select loop.

  My suggestion is to remove the detection of EAGAIN in qemu-char.c:521,
  so that if the buffer is full, KVM discards the byte(s) it was trying
  to write.  This is a surely better outcome than the process spinning
  forever.

  I will submit a separate patch to control the buffer sizes when
  creating UNIX sockets, which will help allow slow-reading processes to
  tune things so that they don't miss any output.

  Additionally, in the context of a hosted environment, if the -serial
  option is used, this could be a small security issue. An untrusted
  user of a guest system, knowing their serial output is going via a
  small buffer, could spew output to their /dev/ttyS0 at a rate fast
  enough to trigger this bug and eat a CPU core on the host.

  To quote David S. Ahern's original bug report (mine was the same, only
  with the latest version from git, so line numbers may have changed -
  my suggested fix above is accurate though):

  I am trying to redirect a guest's boot output through the host's serial
  port.  Shortly after launching qemu, the main thread is spinning on:

  write(9, "0", 1)   =3D -1 EAGAIN (Resource temporarily unavailable)

  fd 9 is the serial port, ttyS0.

  =

  The backtrace for the thread is:

  #0  0x00002ac3433f8c0b in write () from /lib64/libpthread.so.0
  #1  0x0000000000475df9 in send_all (fd=3D9, buf=3D<value optimized out>,
  len1=3D1) at qemu-char.c:477
  #2  0x000000000043a102 in serial_xmit (opaque=3D<value optimized out>) at
  /root/kvm-81/qemu/hw/serial.c:311
  #3  0x000000000043a591 in serial_ioport_write (opaque=3D0x14971790,
  addr=3D<value optimized out>, val=3D48)
      at /root/kvm-81/qemu/hw/serial.c:366
  #4  0x00000000410eeedc in ?? ()
  #5  0x0000000000129000 in ?? ()
  #6  0x0000000014821fa0 in ?? ()
  #7  0x0000000000000007 in ?? ()
  #8  0x00000000004a54c5 in tlb_set_page_exec (env=3D0x10ab4,
  vaddr=3D46912496956816, paddr=3D1, prot=3D-1, mmu_idx=3D0, is_softmmu=3D1)
      at /root/kvm-81/qemu/exec.c:388
  #9  0x0000000000512f3b in tlb_fill (addr=3D345446292, is_write=3D1,
  mmu_idx=3D-1, retaddr=3D0x0)
      at /root/kvm-81/qemu/target-i386/op_helper.c:4690
  #10 0x00000000004a6bd2 in __ldb_cmmu (addr=3D9, mmu_idx=3D0) at
  /root/kvm-81/qemu/softmmu_template.h:135
  #11 0x00000000004a879b in cpu_x86_exec (env1=3D<value optimized out>) at
  /root/kvm-81/qemu/cpu-exec.c:628
  #12 0x000000000040ba29 in main (argc=3D12, argv=3D0x7fff67f7a398) at
  /root/kvm-81/qemu/vl.c:3816

  send_all() invokes unix_write() which by design is not breaking out on
  EAGAIN.

  The following command is enough to show the problem:

  qemu-system-x86_64 -m 256 -smp 1 -no-kvm \
      -drivefile=3D/dev/cciss/c0d0,if=3Dscsi,cache=3Doff,boot=3Don \
      -vnc :1 -serial /dev/ttyS0

  =

  The guest is running RHEL3 with the parameter 'console=3DttyS0' added to
  grub.conf; the problem appears to be with qemu, so I would expect it to
  show with any linux guest. This particular host is running RHEL5.2 with
  kvm-81, but I have also seen the problem with Fedora-9 as the host OS.

  Yes, the serial port of the server is connected to another system via a
  null modem. If I change the serial argument to '-serial udp::4555' and
  use  'nc -u -l  localhost 4555  > /dev/ttyS0' I see the guest's boot
  output show up on the second system as expected. I'd prefer to be able
  to use the serial port connection directly without nc as a proxy.
  Suggestions?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/778032/+subscriptions

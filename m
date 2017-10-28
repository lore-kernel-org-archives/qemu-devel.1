Received: from eggs.gnu.org ([2001:4830:134:3::10]:36443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RPw-00030i-0D
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RPs-0003EL-1P
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:54230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RPr-0003DE-OJ
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RPq-0005bw-O5
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:44:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A4E5F2E80CC
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:44:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:31:21 -0000
From: Thomas Huth <1310714@bugs.launchpad.net>
Reply-To: Bug 1310714 <1310714@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140421171532.32087.66530.malonedeb@soybean.canonical.com>
Message-Id: <150919748115.8561.8769199001277339061.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1310714] Re: User mode networking SLIRP rapid
 memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1310714

Title:
  User mode networking SLIRP rapid memory leak

Status in QEMU:
  Incomplete

Bug description:
  QEMU compiled from git HEAD at
  2d03b49c3f225994c4b0b46146437d8c887d6774 and reproducible at tag
  v2.0.0. I first noticed this bug using Ubuntu Trusty's QEMU 2.0.0~rc1.
  I used to run QEMU 1.7 without this problem.

  This is the command I ran:

  qemu-system-x86_64 -enable-kvm -smp 2 -m 1G -usbdevice tablet -net
  nic,model=3De1000 -net user -vnc localhost:99 -drive
  if=3Dide,file=3Dtest.img,cache=3Dnone -net nic -net user,tftp=3D/tmp/tftp=
data
  -no-reboot

  The guest is Windows 7 64-bit. The VM starts off normally, but after a
  couple of minutes, the memory usage starts to swell. If let running,
  it eventually consumes all host memory and grinds the host to a halt
  due to heavy swapping.

  When running under gdb, I set a breakpoint on mmap, and this is the
  stack trace I obtained.

  Breakpoint 1, mmap64 () at ../sysdeps/unix/syscall-template.S:81
  81	in ../sysdeps/unix/syscall-template.S
  (gdb) where
  #0  mmap64 () at ../sysdeps/unix/syscall-template.S:81
  #1  0x00007ffff0e65091 in new_heap (size=3D135168, size@entry=3D1728, =

      top_pad=3D<optimized out>) at arena.c:554
  #2  0x00007ffff0e687b2 in sysmalloc (av=3D0x7fffd0000020, nb=3D1664)
      at malloc.c:2386
  #3  _int_malloc (av=3D0x7fffd0000020, bytes=3D1650) at malloc.c:3740
  #4  0x00007ffff0e69f50 in __GI___libc_malloc (bytes=3D1650) at malloc.c:2=
855
  #5  0x00005555557a091a in m_get (slirp=3D0x5555561fe960)
      at /src/qemu/slirp/mbuf.c:73
  #6  0x00005555557a3151 in slirp_input (slirp=3D0x5555561fe960, =

      pkt=3D0x7ffff7e94b20 "RU\n", pkt_len=3D<optimized out>)
      at /src/qemu/slirp/slirp.c:747
  #7  0x0000555555758b24 in net_slirp_receive (nc=3D<optimized out>, =

      buf=3D<optimized out>, size=3D54) at /src/qemu/net/slirp.c:113
  #8  0x00005555557567d1 in qemu_deliver_packet (sender=3D<optimized out>, =

      flags=3D<optimized out>, data=3D<optimized out>, size=3D<optimized ou=
t>, =

      opaque=3D<optimized out>) at /src/qemu/net/net.c:471
  #9  0x00005555557588d3 in qemu_net_queue_deliver (size=3D54, =

      data=3D0x7ffff7e94b20 "RU\n", flags=3D0, sender=3D0x5555561fe5e0, =

      queue=3D0x5555561fe1d0) at /src/qemu/net/queue.c:157
  #10 qemu_net_queue_send (queue=3D0x5555561fe1d0, sender=3D0x5555561fe5e0,=
 flags=3D0, =

      data=3D0x7ffff7e94b20 "RU\n", size=3D54, sent_cb=3D<optimized out>)
      at /src/qemu/net/queue.c:192
  ---Type <return> to continue, or q <return> to quit---
  #11 0x000055555575536b in net_hub_receive (len=3D54, buf=3D0x7ffff7e94b20=
 "RU\n", =

      source_port=3D0x5555561fe310, hub=3D<optimized out>) at /src/qemu/net=
/hub.c:55
  #12 net_hub_port_receive (nc=3D0x5555561fe310, buf=3D0x7ffff7e94b20 "RU\n=
", len=3D54)
      at /src/qemu/net/hub.c:114
  #13 0x00005555557567d1 in qemu_deliver_packet (sender=3D<optimized out>, =

      flags=3D<optimized out>, data=3D<optimized out>, size=3D<optimized ou=
t>, =

      opaque=3D<optimized out>) at /src/qemu/net/net.c:471
  #14 0x00005555557588d3 in qemu_net_queue_deliver (size=3D54, =

      data=3D0x7ffff7e94b20 "RU\n", flags=3D0, sender=3D0x555556531920, =

      queue=3D0x5555561fe090) at /src/qemu/net/queue.c:157
  #15 qemu_net_queue_send (queue=3D0x5555561fe090, sender=3D0x555556531920,=
 flags=3D0, =

      data=3D0x7ffff7e94b20 "RU\n", size=3D54, sent_cb=3D<optimized out>)
      at /src/qemu/net/queue.c:192
  #16 0x00005555556db95d in xmit_seg (s=3D0x7ffff7e72010)
      at /src/qemu/hw/net/e1000.c:628
  #17 0x00005555556dbd38 in process_tx_desc (dp=3D0x7fffdf7fda30, s=3D0x7ff=
ff7e72010)
      at /src/qemu/hw/net/e1000.c:723
  #18 start_xmit (s=3D0x7ffff7e72010) at /src/qemu/hw/net/e1000.c:778
  #19 set_tctl (s=3D0x7ffff7e72010, index=3D<optimized out>, val=3D<optimiz=
ed out>)
      at /src/qemu/hw/net/e1000.c:1142
  #20 0x0000555555840fb0 in access_with_adjusted_size (addr=3D14360, =

      value=3D0x7fffdf7fdb10, size=3D4, access_size_min=3D<optimized out>, =

      access_size_max=3D<optimized out>, =

  ---Type <return> to continue, or q <return> to quit---
      access=3D0x555555841160 <memory_region_write_accessor>, mr=3D0x7ffff7=
e747c0)
      at /src/qemu/memory.c:478
  #21 0x00005555558462fe in memory_region_dispatch_write (size=3D4, data=3D=
454, =

      addr=3D14360, mr=3D0x7ffff7e747c0) at /src/qemu/memory.c:990
  #22 io_mem_write (mr=3D0x7ffff7e747c0, addr=3D14360, val=3D<optimized out=
>, size=3D4)
      at /src/qemu/memory.c:1744
  #23 0x00005555557e8717 in address_space_rw (
      as=3D0x555556159c80 <address_space_memory>, addr=3D4273485848, =

      buf=3D0x7ffff7fed028 "\306\001", len=3D4, is_write=3Dtrue)
      at /src/qemu/exec.c:2034
  #24 0x000055555583ff65 in kvm_cpu_exec (cpu=3D<optimized out>)
      at /src/qemu/kvm-all.c:1704
  #25 0x00005555557ddb6c in qemu_kvm_cpu_thread_fn (arg=3D0x55555651b730)
      at /src/qemu/cpus.c:873
  #26 0x00007ffff11b6182 in start_thread (arg=3D0x7fffdf7fe700)
      at pthread_create.c:312
  #27 0x00007ffff0ee1b2d in clone ()
      at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

  Let me know if you have any questions. Thanks.

  liulk

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1310714/+subscriptions

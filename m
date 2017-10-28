Received: from eggs.gnu.org ([2001:4830:134:3::10]:35287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RL5-0000Wx-Py
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RL4-0005rC-7c
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:39:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:53998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RL4-0005pa-09
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:39:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RL2-0004hv-07
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:39:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFCCC2E80CD
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:39:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:26:14 -0000
From: Thomas Huth <1314857@bugs.launchpad.net>
Reply-To: Bug 1314857 <1314857@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140501000512.26604.21360.malonedeb@gac.canonical.com>
Message-Id: <150919717424.19943.7176967002687048236.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1314857] Re: seg fault in ivshmem when using
 ioeventfd=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix had been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De9d21c436f716603b3

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1314857

Title:
  seg fault in ivshmem when using ioeventfd=3Don

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Confirmed

Bug description:
  When launching qemu with the ivshmem device and the nahanni guest
  server there is segmentation fault in the setup_ioeventfds function of
  ivshmem.c. If the ioeventfd=3Don flag is set the pci_ivshmem_init will
  call setup_ioeventfds at line 668. This function relies on the 'peers'
  member of the server info which is not allocated until line 669.

  To reproduce you will need the nahanni guest server code. The driver
  code is not needed. You will also need a qcow2 or other bootable image
  to use for launching qemu. The error occurs before the actual image
  launch.

  Start the nahanni ivshmem server with a small global memory space ( altho=
ugh the bug is not allocation specific )
  ivshmem -m 1 -n 2 -p /tmp/ivshmem_socket

  Next launch qemu with initialization for the ivshmem device.
  qemu-system-x86_64 -hda test_iso.qcow2 -localtime -boot c -chardev socket=
,path=3D"/tmp/ivshmem_socket",id=3Divshmem_socket -device ivshmem,chardev=
=3Divshmem_socket,size=3D1,ioeventfd=3Don

  If gdb is used the following error is recorded:
  Program received signal SIGSEGV, Segmentation fault.
  0x000055555579dd52 in setup_ioeventfds (s=3D0x555556619580)
      at /home/genes/work/ubuntu/qemu-kvm-1.0+noroms/hw/ivshmem.c:367
  367             for (j =3D 0; j < s->peers[i].nb_eventfds; j++) {
  (gdb) print s->peers
  $2 =3D (Peer *) 0x0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1314857/+subscriptions

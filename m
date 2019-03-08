Received: from eggs.gnu.org ([209.51.188.92]:37734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h29V3-0002S5-UP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h29Uz-0001Q4-To
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:37622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h29Uy-0001Gw-Ne
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:00:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h29Uu-0000tC-JS
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 07:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 906C52E8037
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 07:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2019 06:52:24 -0000
From: cavanxg <1819108@bugs.launchpad.net>
Reply-To: Bug 1819108 <1819108@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155202794501.28960.14152482675587823273.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1819108] [NEW] qemu-bridge-helper failure but
 qemu not exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When qemu-bridge-helper run failed, its parent process qemu is still alive.
This is my command line:

qemu-system-x86_64 -curses -enable-kvm -cpu host -smp 4 -m 4096 \
  -vnc :1 \
  -kernel /data/xugang_vms/boot/vmlinuz \
  -initrd /data/xugang_vms/boot/initram \
  -append 'module_blacklist=3Ddrm,evbug net.ifnames=3D0 biosdevname=3D0 ROO=
TDEV=3Drootfs' \
  -drive file=3D/data/xugang_vms/instances/vn7/rootfs.img,format=3Dqcow2,if=
=3Dvirtio \
  -monitor unix:/data/xugang_vms/var/monitor/vn7.sock,server,nowait \
  -netdev bridge,br=3Dvmbr99,helper=3D"/root/bridgehelper --ns=3Dkvm_1 ",id=
=3Dn1 -device virtio-net,netdev=3Dn1,mac=3D92:99:98:76:01:07

"/root/bridgehelper" is self defined helper binary by me. But after
bridge-helper exited with failure(not send fd to qemu process yet), the
linux vm's console will be messed up. I checked the qemu source code(at
net/tap.c) and found following snip:

=3D=3D=3D>
do {
            fd =3D recv_fd(sv[0]);
        } while (fd =3D=3D -1 && errno =3D=3D EINTR);
        saved_errno =3D errno;

        close(sv[0]);

        while (waitpid(pid, &status, 0) !=3D pid) {
            /* loop */
        }
<=3D=3D=3D=3D=3D=3D=3D=3D=3D

why recv_fd will infinitely wait for recv? Maybe it shall waitpid and
then recv_fd ?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819108

Title:
  qemu-bridge-helper failure but qemu not exit

Status in QEMU:
  New

Bug description:
  When qemu-bridge-helper run failed, its parent process qemu is still aliv=
e.
  This is my command line:

  qemu-system-x86_64 -curses -enable-kvm -cpu host -smp 4 -m 4096 \
    -vnc :1 \
    -kernel /data/xugang_vms/boot/vmlinuz \
    -initrd /data/xugang_vms/boot/initram \
    -append 'module_blacklist=3Ddrm,evbug net.ifnames=3D0 biosdevname=3D0 R=
OOTDEV=3Drootfs' \
    -drive file=3D/data/xugang_vms/instances/vn7/rootfs.img,format=3Dqcow2,=
if=3Dvirtio \
    -monitor unix:/data/xugang_vms/var/monitor/vn7.sock,server,nowait \
    -netdev bridge,br=3Dvmbr99,helper=3D"/root/bridgehelper --ns=3Dkvm_1 ",=
id=3Dn1 -device virtio-net,netdev=3Dn1,mac=3D92:99:98:76:01:07

  "/root/bridgehelper" is self defined helper binary by me. But after
  bridge-helper exited with failure(not send fd to qemu process yet),
  the linux vm's console will be messed up. I checked the qemu source
  code(at net/tap.c) and found following snip:

  =3D=3D=3D>
  do {
              fd =3D recv_fd(sv[0]);
          } while (fd =3D=3D -1 && errno =3D=3D EINTR);
          saved_errno =3D errno;

          close(sv[0]);

          while (waitpid(pid, &status, 0) !=3D pid) {
              /* loop */
          }
  <=3D=3D=3D=3D=3D=3D=3D=3D=3D

  why recv_fd will infinitely wait for recv? Maybe it shall waitpid and
  then recv_fd ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819108/+subscriptions

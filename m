Received: from eggs.gnu.org ([2001:4830:134:3::10]:34874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTaBG-0006mv-Cx
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTaBB-0004jp-AN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:16:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTaBB-0004jU-4F
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:16:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTaB9-0002zd-PS
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 20:16:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A1E282E80C9
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 20:16:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 20:02:41 -0000
From: "P.Constantine" <1414466@bugs.launchpad.net>
Reply-To: Bug 1414466 <1414466@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150125172405.12316.8764.malonedeb@soybean.canonical.com>
Message-Id: <20170117200241.20740.33326.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1414466] Re: -net user,
 hostfwd=... is not working(qemu-system-aarch64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Redirect does happen, but no packets appear on guest interface: checked
by iptables rule for `NEW` on `tcpport 22` inside guest.

On host:

$ sudo lsof -itcp | grep 2851
packer    24233      kit    6u  IPv4 1532725      0t0  TCP localhost:52822-=
>localhost:2851 (ESTABLISHED)
qemu-syst 24286      kit   12u  IPv4 1530169      0t0  TCP *:2851 (LISTEN)
qemu-syst 24286      kit   21u  IPv4 1575945      0t0  TCP localhost:2851->=
localhost:52820 (CLOSE_WAIT)
qemu-syst 24286      kit   22u  IPv4 1532726      0t0  TCP localhost:2851->=
localhost:52822 (ESTABLISHED)
qemu-syst 24286      kit   23u  IPv4 1532645      0t0  TCP localhost:2851->=
localhost:52812 (CLOSE_WAIT)
qemu-syst 24286      kit   24u  IPv4 1532646      0t0  TCP localhost:2851->=
localhost:52814 (CLOSE_WAIT)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1414466

Title:
  -net user,hostfwd=3D... is not working(qemu-system-aarch64)

Status in QEMU:
  Confirmed

Bug description:
  QEMU version: git a46b3aaf6bb038d4f6f192a84df204f10929e75c

   /opt/qemu.git/bin/qemu-system-aarch64 --version
  QEMU emulator version 2.2.50, Copyright (c) 2003-2008 Fabrice Bellard

  Hosts:
  ovs - host machine (Ubuntu 14.04.1, x86_64)
  debian8-arm64 - guest =


  Guest start:
  user@ovs:~$ /opt/qemu.git/bin/qemu-system-aarch64 -machine virt -cpu cort=
ex-a57 -nographic -smp 1 -m 512 -kernel vmlinuz-run -initrd initrd-run.img =
-append "root=3D/dev/sda2 console=3DttyAMA0" -global virtio-blk-device.scsi=
=3Doff -device virtio-scsi-device,id=3Dscsi -drive file=3Ddebian8-arm64.img=
,id=3Drootimg,cache=3Dunsafe,if=3Dnone -device scsi-hd,drive=3Drootimg -net=
dev user,id=3Dunet -device virtio-net-device,netdev=3Dunet -net user,hostfw=
d=3Dtcp:127.0.0.1:1122-:22

  root@debian8-arm64:~# netstat -ntplu | grep ssh
  tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTE=
N      410/sshd        =

  tcp6       0      0 :::22                   :::*                    LISTE=
N      410/sshd       =


  (no firewall in guest vm)

  user@ovs:~$ netstat -ntplu | grep 1122
  tcp        0      0 127.0.0.1:1122          0.0.0.0:*               LISTE=
N      18722/qemu-system-a

  user@ovs:~$ time ssh user@127.0.0.1 -p 1122
  ssh_exchange_identification: read: Connection reset by peer

  real	1m29.341s
  user	0m0.005s
  sys	0m0.000s

  Inside guest vm sshd works fine:
  root@debian8-arm64:~# ssh user@127.0.0.1 -p 22
  user@127.0.0.1's password: =

  ....
  user@debian8-arm64:~$ exit
  logout
  Connection to 127.0.0.1 closed.

  root@debian8-arm64:~# ssh user@10.0.2.15 -p 22
  user@10.0.2.15's password: =

  ...
  user@debian8-arm64:~$ exit
  logout
  Connection to 10.0.2.15 closed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1414466/+subscriptions

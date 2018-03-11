Received: from eggs.gnu.org ([2001:4830:134:3::10]:49827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euyYv-0008K2-G1
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 06:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euyYq-00062M-LD
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 06:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1euyYq-000620-EK
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 06:50:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1euyYp-0002G5-6H
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 10:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 28C832E80C8
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 10:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Mar 2018 10:38:46 -0000
From: =?utf-8?b?5p2O56mX5oGS?= <1754542@bugs.launchpad.net>
Reply-To: Bug 1754542 <1754542@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
Message-Id: <152076472672.31174.6291875975039362682.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754542] Re: colo: vm crash with segmentation
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- colo: secondary vm crash when execute x-colo-lost-heartbeat
+ colo:  vm crash with segmentation fault

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754542

Title:
  colo:  vm crash with segmentation fault

Status in QEMU:
  New

Bug description:
  I use Arch Linux x86_64
  Zhang Chen's(https://github.com/zhangckid/qemu/commits/colo-with-virtio-n=
et-internal-jul10)
  Following document 'COLO-FT.txt',
  I test colo feature on my hosts

  I run this command
  Primary:
  sudo qemu-system-x86_64 -boot c   -enable-kvm -m 2048 -smp 2  -qmp stdio =
 -name primary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
  -drive if=3Dvirtio,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vo=
te-threshold=3D1,children.0.file.filename=3D/var/lib/libvirt/images/1.raw,c=
hildren.0.driver=3Draw -S

  Secondary:
  sudo qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qmp stdio  -n=
ame secondary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
  -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/images/=
2.raw,driver=3Draw,node-name=3Dnode0 \
  -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondar=
y,\
  file.driver=3Dqcow2,top-id=3Dactive-disk0,\
  file.file.filename=3D/mnt/ramfs/active_disk.img,\
  file.backing.driver=3Dqcow2,\
  file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
  file.backing.backing=3Dcolo-disk0 \
  -incoming tcp:0:8888

  Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
  =C2=A0=C2=A0'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.=
168.0.33', 'port': '8889'} } }
  }
  {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 'writ=
able': true } }

  Primary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'human-monitor-command',
  =C2=A0=C2=A0'arguments': {'command-line': 'drive_add -n buddy driver=3Dre=
plication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.34,file.po=
rt=3D8889,file.export=3Dcolo-disk0,node-name=3Dnbd_client0'}}
  { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'no=
de': 'nbd_client0' } }
  { 'execute': 'migrate-set-capabilities',
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'arguments': {'capabilities': [ {'cap=
ability': 'x-colo', 'state': true } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
  { 'execute': 'migrate-set-parameters' , 'arguments':{ 'x-checkpoint-delay=
': 2000 } }

  And two VM with cash
  Primary:
  {"timestamp": {"seconds": 1520763655, "microseconds": 511415}, "event": "=
RESUME"}
  [1]    329 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -bo=
ot c -enable-kvm -m 2048 -smp 2 -qm

  Secondary:
  {"timestamp": {"seconds": 1520763655, "microseconds": 510907}, "event": "=
RESUME"}
  [1]    367 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -bo=
ot c -enable-kvm -m 2048 -smp 2 -qm


  =

  ---------------------------------------------------------------------
  if use qemu 2.11.1
  The sync will success,but when Secondary VM execute x-colo-lost-heartbeat=
,Secondary VM will crash
  Secondary:
   { 'execute': 'nbd-server-stop' }
   { 'execute': 'x-colo-lost-heartbeat' }{"return": {}}
  qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file bef=
ore all bytes were read

  {"return": {}}
  qemu-system-x86_64: Can't receive COLO message: Input/output error
  **
  ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref: assertio=
n failed (obj->ref > 0): (0 > 0)
  [1]    1276 abort      sudo /usr/bin/qemu-system-x86_64 -boot c -enable-k=
vm -m 2048 -smp 2 -qmp stdi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions

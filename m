Received: from eggs.gnu.org ([2001:4830:134:3::10]:45650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evBzI-0003AL-HS
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 21:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evBzF-0006Go-8L
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 21:10:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:34836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1evBzE-0006G0-Ul
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 21:10:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1evBzD-0008QP-Uf
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 01:10:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E6DC12E80C7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 01:10:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Mar 2018 00:58:48 -0000
From: =?utf-8?b?5p2O56mX5oGS?= <1754542@bugs.launchpad.net>
Reply-To: Bug 1754542 <1754542@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
Message-Id: <152081632883.3145.5285440686329891821.launchpad@gac.canonical.com>
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

** Description changed:

  I use Arch Linux x86_64
  Zhang Chen's(https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10)
  Following document 'COLO-FT.txt',
  I test colo feature on my hosts
  =

  I run this command
  Primary:
- sudo qemu-system-x86_64 -boot c   -enable-kvm -m 2048 -smp 2  -qmp stdio =
 -name primary \
+ sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp st=
dio -name primary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
- -drive if=3Dvirtio,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vo=
te-threshold=3D1,children.0.file.filename=3D/var/lib/libvirt/images/1.raw,c=
hildren.0.driver=3Draw -S
+ -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3Dfifo=
,vote-threshold=3D1,\
+ children.0.file.filename=3D/var/lib/libvirt/images/1.raw,\
+ children.0.driver=3Draw -S
  =

  Secondary:
- sudo qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qmp stdio  -n=
ame secondary \
+ sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp st=
dio -name secondary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
- -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/images/=
2.raw,driver=3Draw,node-name=3Dnode0 \
+ -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D/var/lib/libvirt/im=
ages/2.raw,driver=3Draw,node-name=3Dnode0 \
  -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondar=
y,\
  file.driver=3Dqcow2,top-id=3Dactive-disk0,\
  file.file.filename=3D/mnt/ramfs/active_disk.img,\
  file.backing.driver=3Dqcow2,\
  file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
- file.backing.backing=3Dcolo-disk0 \
+ file.backing.backing=3Dsecondary-disk0 \
  -incoming tcp:0:8888
  =

  Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
- =C2=A0=C2=A0'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.=
168.0.34', 'port': '8889'} } }
+   'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.34',=
 'port': '8889'} } }
  }
- {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 'writ=
able': true } }
+ {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', =
'writable': true } }
  =

  Primary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'human-monitor-command',
- =C2=A0=C2=A0'arguments': {'command-line': 'drive_add -n buddy driver=3Dre=
plication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.34,file.po=
rt=3D8889,file.export=3Dcolo-disk0,node-name=3Dnbd_client0'}}
- { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'no=
de': 'nbd_client0' } }
+   'arguments': {'command-line': 'drive_add -n buddy driver=3Dreplication,=
mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.34,file.port=3D8889,=
file.export=3Dsecondary-disk0,node-name=3Dnbd_client0'}}
+ { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', =
'node': 'nbd_client0' } }
  { 'execute': 'migrate-set-capabilities',
- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'arguments': {'capabilities': [ {'cap=
ability': 'x-colo', 'state': true } ] } }
+       'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': t=
rue } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
- =

- =

  And two VM with cash
  Primary:
  {"timestamp": {"seconds": 1520763655, "microseconds": 511415}, "event": "=
RESUME"}
  [1]    329 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -bo=
ot c -enable-kvm -m 2048 -smp 2 -qm
  =

  Secondary:
  {"timestamp": {"seconds": 1520763655, "microseconds": 510907}, "event": "=
RESUME"}
  [1]    367 segmentation fault  sudo /usr/local/bin/qemu-system-x86_64 -bo=
ot c -enable-kvm -m 2048 -smp 2 -qm

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
  Zhang Chen's(https://github.com/zhangckid/qemu/tree/qemu-colo-18mar10)
  Following document 'COLO-FT.txt',
  I test colo feature on my hosts

  I run this command
  Primary:
  sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp st=
dio -name primary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
  -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3Dfifo=
,vote-threshold=3D1,\
  children.0.file.filename=3D/var/lib/libvirt/images/1.raw,\
  children.0.driver=3Draw -S

  Secondary:
  sudo /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 2048 -smp 2 -qmp st=
dio -name secondary \
  -device piix3-usb-uhci \
  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
  -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D/var/lib/libvirt/im=
ages/2.raw,driver=3Draw,node-name=3Dnode0 \
  -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondar=
y,\
  file.driver=3Dqcow2,top-id=3Dactive-disk0,\
  file.file.filename=3D/mnt/ramfs/active_disk.img,\
  file.backing.driver=3Dqcow2,\
  file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
  file.backing.backing=3Dsecondary-disk0 \
  -incoming tcp:0:8888

  Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
    'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.34',=
 'port': '8889'} } }
  }
  {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', =
'writable': true } }

  Primary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'human-monitor-command',
    'arguments': {'command-line': 'drive_add -n buddy driver=3Dreplication,=
mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.34,file.port=3D8889,=
file.export=3Dsecondary-disk0,node-name=3Dnbd_client0'}}
  { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', =
'node': 'nbd_client0' } }
  { 'execute': 'migrate-set-capabilities',
        'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': t=
rue } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
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

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eu8RD-0000I8-O9
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eu8R0-0002IE-GE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:11:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:48482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eu8R0-0002Gi-0t
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:11:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eu8Qx-0002AO-9D
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:11:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 722172E80D7
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 03:11:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Mar 2018 02:54:18 -0000
From: =?utf-8?b?5p2O56mX5oGS?= <1754542@bugs.launchpad.net>
Reply-To: Bug 1754542 <1754542@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754542] [NEW] colo: secondary vm crash when
 execute x-colo-lost-heartbeat
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

I use Arch Linux x86_64
both qemu 2.11.1 and Zhang Chen's(https://github.com/zhangckid/qemu/commits=
/colo-with-virtio-net-internal-jul10)
Following document 'COLO-FT.txt',
I test colo feature on my hosts

I run this command
Primary:
sudo qemu-system-x86_64 -boot c   -enable-kvm -m 2048 -smp 2  -qmp stdio  -=
name primary \
-device piix3-usb-uhci \
-device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
-device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
-drive if=3Dvirtio,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote=
-threshold=3D1,children.0.file.filename=3D/var/lib/libvirt/images/1.raw,chi=
ldren.0.driver=3Draw -S

Secondary:
sudo qemu-system-x86_64 -boot c -enable-kvm -m 2048 -smp 2 -qmp stdio  -nam=
e secondary \
-device piix3-usb-uhci \
-device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
-device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
-drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/images/2.=
raw,driver=3Draw,node-name=3Dnode0 \
-drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondary,\
file.driver=3Dqcow2,top-id=3Dactive-disk0,\
file.file.filename=3D/mnt/ramfs/active_disk.img,\
file.backing.driver=3Dqcow2,\
file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
file.backing.backing=3Dcolo-disk0 \
-incoming tcp:0:8888

Secondary:
{'execute':'qmp_capabilities'}
{ 'execute': 'nbd-server-start',
=C2=A0=C2=A0'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.16=
8.0.33', 'port': '8889'} } }
}
{'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 'writab=
le': true } }

Primary:
{'execute':'qmp_capabilities'}
{ 'execute': 'human-monitor-command',
=C2=A0=C2=A0'arguments': {'command-line': 'drive_add -n buddy driver=3Drepl=
ication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.34,file.port=
=3D8889,file.export=3Dcolo-disk0,node-name=3Dnbd_client0'}}
{ 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'node=
': 'nbd_client0' } }
{ 'execute': 'migrate-set-capabilities',
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'arguments': {'capabilities': [ {'capab=
ility': 'x-colo', 'state': true } ] } }
{ 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.34:8888' } }
{ 'execute': 'migrate-set-parameters' , 'arguments':{ 'x-checkpoint-delay':=
 2000 } }

Above are all OK.Two VM syncing.

Primary:
{ 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0', 'ch=
ild': 'children.1'}}
{ 'execute': 'human-monitor-command','arguments': {'command-line': 'drive_d=
el blk-buddy0'}}

Secondary:
{ 'execute': 'nbd-server-stop' }
{ 'execute': 'x-colo-lost-heartbeat' }

But When I execute x-colo-lost-heartbeat.Primary run Secondary cash

=C2=A0{ 'execute': 'nbd-server-stop' }
{"return": {}}
qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file befor=
e all bytes were read
=C2=A0{ 'execute': 'x-colo-lost-heartbeat' }
{"return": {}}
qemu-system-x86_64: Can't receive COLO message: Input/output error
**
ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref: assertion =
failed (obj->ref > 0): (0 > 0)
[1]    2972 abort      sudo /usr/bin/qemu-system-x86_64 -boot c -enable-kvm=
 -m 2048 -smp 2 -qmp stdi

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: colo

** Description changed:

  I use Arch Linux x86_64
- both qemu 2.11.1 Zhang Chen's(https://github.com/zhangckid/qemu/commits/c=
olo-with-virtio-net-internal-jul10)
+ both qemu 2.11.1 and Zhang Chen's(https://github.com/zhangckid/qemu/commi=
ts/colo-with-virtio-net-internal-jul10)
  Following document 'COLO-FT.txt',
  I test colo feature on my hosts
  =

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
  =

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
  =

  Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
-   'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.33',=
 'port': '8889'} } }
+ =C2=A0=C2=A0'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.=
168.0.33', 'port': '8889'} } }
  }
  {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 'writ=
able': true } }
  =

  Primary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'human-monitor-command',
-   'arguments': {'command-line': 'drive_add -n buddy driver=3Dreplication,=
mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.33,file.port=3D8889,=
file.export=3Dcolo-disk0,node-name=3Dnbd_client0'}}
+ =C2=A0=C2=A0'arguments': {'command-line': 'drive_add -n buddy driver=3Dre=
plication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.33,file.po=
rt=3D8889,file.export=3Dcolo-disk0,node-name=3Dnbd_client0'}}
  { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'no=
de': 'nbd_client0' } }
  { 'execute': 'migrate-set-capabilities',
-       'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': t=
rue } ] } }
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0'arguments': {'capabilities': [ {'cap=
ability': 'x-colo', 'state': true } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.33:8888' } }
  { 'execute': 'migrate-set-parameters' , 'arguments':{ 'x-checkpoint-delay=
': 2000 } }
  =

  Above are all OK.Two VM syncing.
  =

  Primary:
  { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0', '=
child': 'children.1'}}
  { 'execute': 'human-monitor-command','arguments': {'command-line': 'drive=
_del blk-buddy0'}}
  =

  Secondary:
  { 'execute': 'nbd-server-stop' }
  { 'execute': 'x-colo-lost-heartbeat' }
  =

  But When I execute x-colo-lost-heartbeat.Primary run Secondary cash
  =

- =

-  { 'execute': 'nbd-server-stop' }
+ =C2=A0{ 'execute': 'nbd-server-stop' }
  {"return": {}}
  qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file bef=
ore all bytes were read
-  { 'execute': 'x-colo-lost-heartbeat' }
+ =C2=A0{ 'execute': 'x-colo-lost-heartbeat' }
  {"return": {}}
  qemu-system-x86_64: Can't receive COLO message: Input/output error
  **
  ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref: assertio=
n failed (obj->ref > 0): (0 > 0)
  [1]    2972 abort      sudo /usr/bin/qemu-system-x86_64 -boot c -enable-k=
vm -m 2048 -smp 2 -qmp stdi

** Tags added: colo

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754542

Title:
  colo: secondary vm crash when execute x-colo-lost-heartbeat

Status in QEMU:
  New

Bug description:
  I use Arch Linux x86_64
  both qemu 2.11.1 and Zhang Chen's(https://github.com/zhangckid/qemu/commi=
ts/colo-with-virtio-net-internal-jul10)
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

  Above are all OK.Two VM syncing.

  Primary:
  { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0', '=
child': 'children.1'}}
  { 'execute': 'human-monitor-command','arguments': {'command-line': 'drive=
_del blk-buddy0'}}

  Secondary:
  { 'execute': 'nbd-server-stop' }
  { 'execute': 'x-colo-lost-heartbeat' }

  But When I execute x-colo-lost-heartbeat.Primary run Secondary cash

  =C2=A0{ 'execute': 'nbd-server-stop' }
  {"return": {}}
  qemu-system-x86_64: Disconnect client, due to: Unexpected end-of-file bef=
ore all bytes were read
  =C2=A0{ 'execute': 'x-colo-lost-heartbeat' }
  {"return": {}}
  qemu-system-x86_64: Can't receive COLO message: Input/output error
  **
  ERROR:/build/qemu/src/qemu-2.11.1/qom/object.c:907:object_unref: assertio=
n failed (obj->ref > 0): (0 > 0)
  [1]    2972 abort      sudo /usr/bin/qemu-system-x86_64 -boot c -enable-k=
vm -m 2048 -smp 2 -qmp stdi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754542/+subscriptions

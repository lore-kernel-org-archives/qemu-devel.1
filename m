Received: from eggs.gnu.org ([2001:4830:134:3::10]:45687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exkKt-0006aL-8t
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 22:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exkKp-00022a-6v
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 22:15:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:56796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1exkKo-000222-UH
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 22:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1exkKn-0006KP-Gj
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 02:15:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A12E2E80CC
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 02:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Mar 2018 02:08:55 -0000
From: =?utf-8?b?5p2O56mX5oGS?= <1754542@bugs.launchpad.net>
Reply-To: Bug 1754542 <1754542@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152056405865.7543.8980677605113063936.malonedeb@wampee.canonical.com>
Message-Id: <152142533512.7381.1938340023148732379.malone@soybean.canonical.com>
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

Hi Zhang Chen=EF=BC=8C
I follow the https://wiki.qemu.org/Features/COLO, And Vm no crash.
But SVM rebooting constantly after print RESET, PVM normal startup.

Secondary:
{"timestamp": {"seconds": 1521421788, "microseconds": 541058}, "event": "RE=
SUME"}
{"timestamp": {"seconds": 1521421808, "microseconds": 493484}, "event": "ST=
OP"}
{"timestamp": {"seconds": 1521421808, "microseconds": 686466}, "event": "RE=
SUME"}
{"timestamp": {"seconds": 1521421808, "microseconds": 696152}, "event": "RE=
SET", "data": {"guest": true}}
{"timestamp": {"seconds": 1521421808, "microseconds": 740653}, "event": "RE=
SET", "data": {"guest": true}}
{"timestamp": {"seconds": 1521421818, "microseconds": 742222}, "event": "ST=
OP"}
{"timestamp": {"seconds": 1521421818, "microseconds": 969883}, "event": "RE=
SUME"}
{"timestamp": {"seconds": 1521421818, "microseconds": 979986}, "event": "RE=
SET", "data": {"guest": true}}
{"timestamp": {"seconds": 1521421819, "microseconds": 22652}, "event": "RES=
ET", "data": {"guest": true}}


The command(I run two VM in sample machine):

Primary:
sudo /home/lee/Documents/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm=
 -boot c -m 2048 -smp 2 -qmp stdio  -name primary -cpu qemu64,+kvmclock -de=
vice piix3-usb-uhci -device usb-tablet \
    -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D/=
etc/qemu-ifdown -device rtl8139,id=3De0,netdev=3Dhn0 \
    -chardev socket,id=3Dmirror0,host=3D192.168.0.33,port=3D9003,server,now=
ait \
    -chardev socket,id=3Dcompare1,host=3D192.168.0.33,port=3D9004,server,wa=
it \
    -chardev socket,id=3Dcompare0,host=3D192.168.0.33,port=3D9001,server,no=
wait \
    -chardev socket,id=3Dcompare0-0,host=3D192.168.0.33,port=3D9001 \
    -chardev socket,id=3Dcompare_out,host=3D192.168.0.33,port=3D9005,server=
,nowait \
    -chardev socket,id=3Dcompare_out0,host=3D192.168.0.33,port=3D9005 \
    -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0 \
    -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3D=
compare_out \
    -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=
=3Dcompare0 \
    -object iothread,id=3Diothread1 \
    -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3D=
compare1,outdev=3Dcompare_out0,iothread=3Diothread1 \
    -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vot=
e-threshold=3D1,children.0.file.filename=3D/var/lib/libvirt/images/1.raw,ch=
ildren.0.driver=3Draw -S

Secondary:
sudo /home/lee/Documents/qemu/x86_64-softmmu/qemu-system-x86_64 -boot c -m =
2048 -smp 2 -qmp stdio  -name secondary -enable-kvm -cpu qemu64,+kvmclock \
    -device piix3-usb-uhci -device usb-tablet \
    -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D/=
etc/qemu-ifdown \
    -device rtl8139,netdev=3Dhn0 \
    -chardev socket,id=3Dred0,host=3D192.168.0.33,port=3D9003,reconnect=3D1=
 \
    -chardev socket,id=3Dred1,host=3D192.168.0.33,port=3D9004,reconnect=3D1=
 \
    -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \
    -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1=
 \
    -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
    -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D/var/lib/libvirt/image=
s/2.raw,driver=3Draw,node-name=3Dnode0 \
    -drive if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondary=
,file.driver=3Dqcow2,top-id=3Dactive-disk0,file.file.filename=3D/mnt/ramfs/=
active_disk.img,file.backing.driver=3Dqcow2,file.backing.file.filename=3D/m=
nt/ramfs/hidden_disk.img,file.backing.backing=3Dcolo-disk0 \
    -incoming tcp:0:8888

Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
    'arguments': {'addr': {'type': 'inet', 'data': {'host': '192.168.0.33',=
 'port': '8889'} } }
  }
  {'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 'writ=
able': true } }
  {'execute': 'trace-event-set-state', 'arguments': {'name': 'colo*', 'enab=
le': true} }


Primary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'human-monitor-command',
    'arguments': {'command-line': 'drive_add -n buddy driver=3Dreplication,=
mode=3Dprimary,file.driver=3Dnbd,file.host=3D192.168.0.33,file.port=3D8889,=
file.export=3Dcolo-disk0,node-name=3Dnode0'}}
  { 'execute':'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'no=
de': 'node0' } }
  { 'execute': 'migrate-set-capabilities',
        'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': t=
rue } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:192.168.0.33:8888' } }

Thanks
Suiheng

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

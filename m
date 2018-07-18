Received: from eggs.gnu.org ([2001:4830:134:3::10]:55300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffh4y-0008Rc-IL
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffh4v-0001F3-BJ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:40:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:32896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ffh4u-0001CV-Lb
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ffh4s-0003ec-OE
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9F8732E80D4
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jul 2018 07:30:13 -0000
From: PJ Tsao <pjtsao@itri.org.tw>
Reply-To: Bug 1782300 <1782300@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153189901344.31406.13269648308515707918.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1782300] [NEW] COLO unable to failover to
 secondary VM
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

I test COLO feature on my host following docs/COLO-FT.txt in qemu folder, b=
ut fail to failover to secondary VM. =

Is there any mistake in my execution steps?

Execution environment:
QEMU v2.12.0-rc4
OS:     Ubuntu 16.04.3 LTS
Kernel: Linux 4.4.35
Secondary VM IP: noted as "a.b.c.d"

Execution steps:
# Primary
${COLO_PATH}/x86_64-softmmu/qemu-system-x86_64 \
    -enable-kvm \
    -m 512M \
    -smp 2 \
    -qmp stdio \
    -vnc :7 \
    -name primary \
    -device piix3-usb-uhci \
    -device usb-tablet \
    -netdev tap,id=3Dtap0,vhost=3Doff \
    -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dtap0 \
    -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3Dfi=
fo,vote-threshold=3D1,\
        children.0.file.filename=3D${IMG_PATH},\
        children.0.driver=3Draw -S

# Secondary
${COLO_PATH}/x86_64-softmmu/qemu-system-x86_64 \
    -enable-kvm \
    -m 512M \
    -smp 2 \
    -qmp stdio \
    -vnc :8 \
    -name secondary \
    -device piix3-usb-uhci \
    -device usb-tablet \
    -netdev tap,id=3Dtap1,vhost=3Doff \
    -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dtap1 \
    -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D${IMG_PATH},drive=
r=3Draw,node-name=3Dnode0 \
    -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecond=
ary,\
        file.driver=3Dqcow2,top-id=3Dactive-disk0,\
        file.file.filename=3D$ACTIVE_DISK,\
        file.backing.driver=3Dqcow2,\
        file.backing.file.filename=3D$HIDDEN_DISK,\
        file.backing.backing=3Dsecondary-disk0 \
    -incoming tcp:0:8888

# Enter into Secondary:
{'execute':'qmp_capabilities'}
{ 'execute': 'nbd-server-start',
    'arguments': {'addr': {'type': 'inet', 'data': {'host': 'a.b.c.d', 'por=
t': '8889'} } }
}
{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', 'w=
ritable': true } }

# Enter into Primary:
{'execute':'qmp_capabilities'}
{'execute': 'human-monitor-command',
    'arguments': {
        'command-line': 'drive_add -n buddy driver=3Dreplication,mode=3Dpri=
mary,file.driver=3Dnbd,file.host=3Da.b.c.d,file.port=3D8889,file.export=3Ds=
econdary-disk0,node-name=3Dnbd_client0'
    }
}
{ 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', 'n=
ode': 'nbd_client0' } }
{ 'execute': 'migrate-set-capabilities',
    'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': true =
} ] } }
{ 'execute': 'migrate', 'arguments': {'uri': 'tcp:a.b.c.d:8888' } }

# To test failover
Primary
{ 'execute': 'x-blockdev-change', 'arguments': {'parent': 'primary-disk0', =
'child': 'children.1'}}
{ 'execute': 'human-monitor-command','arguments': {'command-line': 'drive_d=
el nbd_client0'}}

Secondary
{ 'execute': 'nbd-server-stop' }

Stop Primary
Send ^C signal to terminate PVM.

Secondary
{ "execute": "x-colo-lost-heartbeat" }


# Result:
Primary (Use ^C to terminate)
qemu-system-x86_64: Can't receive COLO message: Input/output error
qemu-system-x86_64: terminating on signal 2
{"timestamp": {"seconds": 1531815575, "microseconds": 997696}, "event": "SH=
UTDOWN", "data": {"guest":false}}

Secondary
{ 'execute': 'nbd-server-stop' }
{"return": {}}
{ "execute": "x-colo-lost-heartbeat" }
{"return": {}}
qemu-system-x86_64: Can't receive COLO message: Input/output error
Segmentation fault

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: colo

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1782300

Title:
  COLO unable to failover to secondary VM

Status in QEMU:
  New

Bug description:
  I test COLO feature on my host following docs/COLO-FT.txt in qemu folder,=
 but fail to failover to secondary VM. =

  Is there any mistake in my execution steps?

  Execution environment:
  QEMU v2.12.0-rc4
  OS:     Ubuntu 16.04.3 LTS
  Kernel: Linux 4.4.35
  Secondary VM IP: noted as "a.b.c.d"

  Execution steps:
  # Primary
  ${COLO_PATH}/x86_64-softmmu/qemu-system-x86_64 \
      -enable-kvm \
      -m 512M \
      -smp 2 \
      -qmp stdio \
      -vnc :7 \
      -name primary \
      -device piix3-usb-uhci \
      -device usb-tablet \
      -netdev tap,id=3Dtap0,vhost=3Doff \
      -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dtap0 \
      -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3D=
fifo,vote-threshold=3D1,\
          children.0.file.filename=3D${IMG_PATH},\
          children.0.driver=3Draw -S

  # Secondary
  ${COLO_PATH}/x86_64-softmmu/qemu-system-x86_64 \
      -enable-kvm \
      -m 512M \
      -smp 2 \
      -qmp stdio \
      -vnc :8 \
      -name secondary \
      -device piix3-usb-uhci \
      -device usb-tablet \
      -netdev tap,id=3Dtap1,vhost=3Doff \
      -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dtap1 \
      -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D${IMG_PATH},dri=
ver=3Draw,node-name=3Dnode0 \
      -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dseco=
ndary,\
          file.driver=3Dqcow2,top-id=3Dactive-disk0,\
          file.file.filename=3D$ACTIVE_DISK,\
          file.backing.driver=3Dqcow2,\
          file.backing.file.filename=3D$HIDDEN_DISK,\
          file.backing.backing=3Dsecondary-disk0 \
      -incoming tcp:0:8888

  # Enter into Secondary:
  {'execute':'qmp_capabilities'}
  { 'execute': 'nbd-server-start',
      'arguments': {'addr': {'type': 'inet', 'data': {'host': 'a.b.c.d', 'p=
ort': '8889'} } }
  }
  {'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', =
'writable': true } }

  # Enter into Primary:
  {'execute':'qmp_capabilities'}
  {'execute': 'human-monitor-command',
      'arguments': {
          'command-line': 'drive_add -n buddy driver=3Dreplication,mode=3Dp=
rimary,file.driver=3Dnbd,file.host=3Da.b.c.d,file.port=3D8889,file.export=
=3Dsecondary-disk0,node-name=3Dnbd_client0'
      }
  }
  { 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', =
'node': 'nbd_client0' } }
  { 'execute': 'migrate-set-capabilities',
      'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': tru=
e } ] } }
  { 'execute': 'migrate', 'arguments': {'uri': 'tcp:a.b.c.d:8888' } }

  # To test failover
  Primary
  { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'primary-disk0'=
, 'child': 'children.1'}}
  { 'execute': 'human-monitor-command','arguments': {'command-line': 'drive=
_del nbd_client0'}}

  Secondary
  { 'execute': 'nbd-server-stop' }

  Stop Primary
  Send ^C signal to terminate PVM.

  Secondary
  { "execute": "x-colo-lost-heartbeat" }

  =

  # Result:
  Primary (Use ^C to terminate)
  qemu-system-x86_64: Can't receive COLO message: Input/output error
  qemu-system-x86_64: terminating on signal 2
  {"timestamp": {"seconds": 1531815575, "microseconds": 997696}, "event": "=
SHUTDOWN", "data": {"guest":false}}

  Secondary
  { 'execute': 'nbd-server-stop' }
  {"return": {}}
  { "execute": "x-colo-lost-heartbeat" }
  {"return": {}}
  qemu-system-x86_64: Can't receive COLO message: Input/output error
  Segmentation fault

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1782300/+subscriptions

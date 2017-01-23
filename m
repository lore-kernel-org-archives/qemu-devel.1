Received: from eggs.gnu.org ([2001:4830:134:3::10]:56248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVckU-0005CX-5r
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVckQ-00045c-Qn
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:25:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:45515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVckQ-00043p-Ia
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:25:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVckP-0000Tn-90
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:25:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 42CB92E80AE
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:25:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 11:11:02 -0000
From: Thomas Huth <1192499@bugs.launchpad.net>
Reply-To: Bug 1192499 <1192499@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130619090511.29840.85811.malonedeb@wampee.canonical.com>
Message-Id: <20170123111102.29584.64332.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1192499] Re: virsh migration copy-storage-all
 fails with "Unable to read from monitor: Connection reset by peer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is there still something left to do here, or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1192499

Title:
  virsh migration copy-storage-all  fails with "Unable to read from
  monitor: Connection reset by peer"

Status in QEMU:
  Incomplete
Status in libvirt package in Ubuntu:
  Invalid
Status in libvirt package in Fedora:
  Unknown

Bug description:
  virsh migration copy-storage-all  fails with "Unable to read from
  monitor: Connection reset by peer" and shut downs the guest on the
  source host.

  Kernel Version:  3.10.0-rc5+

  Libvirt Version: 1.0.6

  Qemu Version: 1.5.50

  Steps to reproduce the issue:
  ----------------------------------------
  1. Created the qemu-img create -f qcow2 vm.qcow2 11G on the destination h=
ost which is same as the source.
  2. Started the guest on the source
  3. Started the vncdisplay to monitor the guest
  4. Initiated the migration "virsh migrate --live VM1 qemu+ssh://host-ip/s=
ystem tcp://host-ip --verbose --copy-storage-all"
  5. It started the copying the storage from souce to destination (conitino=
usly monitored it was growing)
  6. Guest on the destination was paused and was running on the source
  7. At some point the VM on the source got shutdown and migration failed w=
ith "Unable to read from monitor: Connection reset by peer"

  Attached the libvirt debug logs.

  The debug logs shows :

  2013-06-19 08:43:12.253+0000: 4026: debug : virEventPollInterruptLocked:7=
16 : Interrupting
  2013-06-19 08:43:12.253+0000: 4026: debug : virEventPollAddTimeout:248 : =
EVENT_POLL_ADD_TIMEOUT: timer=3D1 frequency=3D0 cb=3D0x7fe930baa960 opaque=
=3D(nil) ff=3D(nil)

  Note: The virsh live migration works fine with nfs storage from source to=
 destination and vice versa.
  With libvirt 1.0.5 and qemu 1.5 also we were facing the same issue, but w=
ith that even "Live migration with nfs also was not working".

  Guest XML:
  ----------------

  <domain type=3D'kvm'>
    <name>VM1</name>
    <uuid>47feb0e1-0c23-9be9-da12-2ead34864de2</uuid>
    <memory unit=3D'KiB'>4096000</memory>
    <currentMemory unit=3D'KiB'>2048000</currentMemory>
    <vcpu placement=3D'auto'>1</vcpu>
    <numatune>
      <memory mode=3D'strict' nodeset=3D'0'/>
    </numatune>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-1.5'>hvm</type>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/local/bin/qemu-system-x86_64</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2' cache=3D'none'/>
        <source file=3D'/home/images/VM1.qcow2'/>
        <target dev=3D'hda' bus=3D'ide'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <disk type=3D'block' device=3D'cdrom'>
        <driver name=3D'qemu' type=3D'raw'/>
        <target dev=3D'hdc' bus=3D'ide'/>
        <readonly/>
        <address type=3D'drive' controller=3D'0' bus=3D'1' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <controller type=3D'usb' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'ide' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <interface type=3D'network'>
        <mac address=3D'52:54:00:9d:cf:bb'/>
        <source network=3D'default'/>
        <model type=3D'rtl8139'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <target port=3D'0'/>
      </serial>
      <console type=3D'pty'>
        <target type=3D'serial' port=3D'0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' listen=3D'127.0.0=
.1'>
        <listen type=3D'address' address=3D'127.0.0.1'/>
      </graphics>
      <video>
        <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0'/>
      </memballoon>
    </devices>
    <seclabel type=3D'none' model=3D'selinux'/>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1192499/+subscriptions

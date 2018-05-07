Received: from eggs.gnu.org ([2001:4830:134:3::10]:37745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFnLJ-0000jz-Jv
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFnLG-0004O5-Ej
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:06:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fFnLG-0004Np-96
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:06:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fFnLF-0007An-Bn
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 21:06:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 524BA2E80C8
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 21:06:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 May 2018 20:51:04 -0000
From: Alex Williamson <alex.l.williamson@gmail.com>
Reply-To: Bug 1456819 <1456819@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150519225552.30578.95682.malonedeb@chaenomeles.canonical.com>
Message-Id: <152572626580.32662.8340281984174726036.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1456819] Re: OVMF, Hyper-V, virtio,
 Win7 incompatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1456819

Title:
  OVMF, Hyper-V, virtio, Win7 incompatibility

Status in QEMU:
  Invalid

Bug description:
  Host kernel: v4.1-rc4
  QEMU: qemu.git tag v2.3.0
  OVMF: edk2.git-ovmf-x64-0-20150518.b1004.g54ae9c0.noarch
  libvirt: 1.2.13.1-1.fc21.x86_64
  Guest: en_windows_7_professional_with_sp1_x64_dvd_u_676939.iso

  If I attempt to use the above software versions to start a VM install,
  I hit one of two problems:

  (a) If I use a virtio NIC, the VM aborts with an error similar to:

  qemu-system-x86_64: Guest moved used index from 22 to 0

  (b) If I use an emulated (e1000) NIC, the VM switches to a black
  screen when I should have the dancing windows boot animation logo

  Both of these are resolved by switching off ALL Hyper-V enlightenments
  as shown in the below XML.  Enabling any one of them results in the
  above behavior.

  This problem is only seen with OVMF, removing the loader and nvram
  directives below allows all Hyper-V enlightenments to be enabled, with
  or without a virtio NIC.

  <domain type=3D'kvm'>
    <name>win7-ovmf-demo</name>
    <uuid>a42b96e9-e95d-42c6-9f4a-0236f3d38d95</uuid>
    <memory unit=3D'KiB'>4194304</memory>
    <currentMemory unit=3D'KiB'>4194304</currentMemory>
    <vcpu placement=3D'static'>2</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-2.3'>hvm</type>
      <loader readonly=3D'yes' type=3D'pflash'>/usr/share/edk2.git/ovmf-x64=
/OVMF_CODE-pure-efi.fd</loader>
      <nvram>/var/lib/libvirt/qemu/nvram/win7-ovmf-demo_VARS.fd</nvram>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
      <hyperv>
        <relaxed state=3D'off'/>
        <vapic state=3D'off'/>
        <spinlocks state=3D'off'/>
      </hyperv>
    </features>
    <clock offset=3D'localtime'>
      <timer name=3D'rtc' tickpolicy=3D'catchup'/>
      <timer name=3D'pit' tickpolicy=3D'delay'/>
      <timer name=3D'hpet' present=3D'no'/>
      <timer name=3D'hypervclock' present=3D'no'/>
    </clock>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <pm>
      <suspend-to-mem enabled=3D'no'/>
      <suspend-to-disk enabled=3D'no'/>
    </pm>
    <devices>
      <emulator>/usr/local/bin/qemu-system-x86_64</emulator>
      <disk type=3D'file' device=3D'cdrom'>
        <driver name=3D'qemu' type=3D'raw'/>
        <source file=3D'/var/lib/libvirt/images/MSDN/en_windows_7_professio=
nal_with_sp1_x64_dvd_u_676939.iso'/>
        <target dev=3D'hdb' bus=3D'ide'/>
        <readonly/>
        <boot order=3D'1'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'1'/>
      </disk>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x7'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
        <master startport=3D'0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0' multifunction=3D'on'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
        <master startport=3D'2'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
        <master startport=3D'4'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <controller type=3D'ide' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <interface type=3D'network'>
        <mac address=3D'52:54:00:9b:49:b9'/>
        <source network=3D'default'/>
        <model type=3D'e1000'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <input type=3D'tablet' bus=3D'usb'/>
      <input type=3D'mouse' bus=3D'ps2'/>
      <input type=3D'keyboard' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes'/>
      <video>
        <model type=3D'vga' vram=3D'16384' heads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'none'/>
    </devices>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1456819/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elijahs@mellanox.com>) id 1fdW6Q-000518-UN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elijahs@mellanox.com>) id 1fdW6J-0004g8-0c
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:33:26 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com
	([40.107.2.59]:24847
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elijahs@mellanox.com>)
	id 1fdW6I-0004eJ-Cn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 03:33:18 -0400
From: Elijah Shakkour <elijahs@mellanox.com>
Date: Thu, 12 Jul 2018 07:33:14 +0000
Message-ID: <DB5PR05MB1160093E018FD91787E80A79D5590@DB5PR05MB1160.eurprd05.prod.outlook.com>
References: <DB5PR05MB11605C65D7D734C9354F0421D54F0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<1407239306.11199051.1530240887935.JavaMail.zimbra@redhat.com>
	<20180705194311-mutt-send-email-mst@kernel.org>
	<DB5PR05MB1160D84E747DA480435B6605D5440@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<DB5PR05MB1160BB381473C723C8336EC2D55A0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<AM5PR0501MB2499CB4F2D01BCDA47C0ACB6C95A0@AM5PR0501MB2499.eurprd05.prod.outlook.com>
In-Reply-To: <AM5PR0501MB2499CB4F2D01BCDA47C0ACB6C95A0@AM5PR0501MB2499.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Question: SRIOV support over Win Hyper-V VM running in
 QEMU process on Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Tal Attaly <talat@mellanox.com>

Hey,

Our team is adding a NIC functional  emulation to QEMU.
One of the features we are adding to this NIC is SRIOV.

Here is the error message I get when checking SRIOV support of  our emulate=
d NIC on Win2016 server (the hyper-v VM).
"
SR-IOV cannot be used on this system as the PCI Express hardware does not s=
upport Access Control Services (ACS) at any root port. Contact your system =
vendor for further information.
"

Could you please advise about what could be the issue here?

BTW: I use same configuration (VM XML file attached) when running linux VM =
(RH7.2) image (instead of Win Hyper-V) over the same host and SRIOV is work=
ing for me there.

Here the XML file I use to define the VM (our emulated NIC is added at the =
end of XML):
"
<domain type=3D'kvm' xmlns:qemu=3D'http://libvirt.org/schemas/domain/qemu/1=
.0'>
  <name>nst105</name>
  <uuid>0249a525-2ee2-432b-a1f5-a6db83b089a3</uuid>
  <memory unit=3D'KiB'>8388608</memory>
  <currentMemory unit=3D'KiB'>8388608</currentMemory>
  <vcpu placement=3D'static'>8</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-q35-2.11'>hvm</type>
  </os>
  <features>
    <acpi/>
    <apic/>
    <hyperv>
      <relaxed state=3D'on'/>
      <vapic state=3D'on'/>
      <spinlocks state=3D'on' retries=3D'8191'/>
    </hyperv>
  </features>
  <cpu mode=3D'custom' match=3D'exact' check=3D'none'>
    <model fallback=3D'forbid'>SandyBridge</model>
    <feature policy=3D'require' name=3D'hypervisor'/>
    <feature policy=3D'require' name=3D'vmx'/>
  </cpu>
  <clock offset=3D'localtime'>
    <timer name=3D'rtc' tickpolicy=3D'catchup'/>
    <timer name=3D'pit' tickpolicy=3D'delay'/>
    <timer name=3D'hpet' present=3D'no'/>
    <timer name=3D'hypervclock' present=3D'yes'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled=3D'no'/>
    <suspend-to-disk enabled=3D'no'/>
  </pm>
  <devices>
    <emulator>/opt/qemu/bin/qemu-system-x86_64</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/images/nst105.qcow2'/>
      <target dev=3D'sda' bus=3D'sata'/>
      <boot order=3D'2'/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=
=3D'0'/>
    </disk>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1d' fu=
nction=3D'0x7'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
      <master startport=3D'0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1d' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
      <master startport=3D'2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1d' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
      <master startport=3D'4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1d' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'sata' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1f' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pcie-root'/>
    <controller type=3D'pci' index=3D'1' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'1' port=3D'0x10'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'2' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'2' port=3D'0x11'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'3' port=3D'0x12'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'4' model=3D'dmi-to-pci-bridge'>
      <model name=3D'i82801b11-bridge'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1e' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'5' model=3D'pci-bridge'>
      <model name=3D'pci-bridge'/>
      <target chassisNr=3D'5'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <interface type=3D'bridge'>
      <mac address=3D'00:50:56:1b:dd:6f'/>
      <source bridge=3D'br0'/>
      <model type=3D'virtio'/>
      <boot order=3D'1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <target port=3D'0'/>
    </serial>
    <console type=3D'pty'>
      <target type=3D'serial' port=3D'0'/>
    </console>
    <input type=3D'tablet' bus=3D'usb'>
      <address type=3D'usb' bus=3D'0' port=3D'1'/>
    </input>
    <input type=3D'mouse' bus=3D'ps2'/>
    <input type=3D'keyboard' bus=3D'ps2'/>
    <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' listen=3D'127.0.0.1=
' keymap=3D'en-us'>
      <listen type=3D'address' address=3D'127.0.0.1'/>
    </graphics>
    <video>
      <model type=3D'vga' vram=3D'16384' heads=3D'1' primary=3D'yes'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x0'/>
    </video>
    <memballoon model=3D'virtio'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </memballoon>
  </devices>
  <seclabel type=3D'none' model=3D'none'/>
  <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'/>
  <qemu:commandline>
    <qemu:arg value=3D'-device'/>
    <qemu:arg value=3D'pcie-root-port,pref64-reserve=3D500M,slot=3D0,id=3Dp=
cie_port.1'/>
    <qemu:arg value=3D'-netdev'/>
    <qemu:arg value=3D'tap,id=3Dtap5,ifname=3Dtap5,script=3Dno,downscript=
=3Dno'/>
    <qemu:arg value=3D'-device'/>
    <qemu:arg value=3D'my_emu_nic,netdev=3Dtap5,bus=3Dpcie_port.1'/>
  </qemu:commandline>
</domain>
"
______________________
General info:
Host OS: RH7.0 (Kernel: 4.14.13)
QEMU version: 2.11
libvirt version: 3.2.0
Running the following on the host shows that both nested and IOMMU are
enabled:
~]#: cat /sys/module/kvm_intel/parameters/nested
Y
~]# dmesg | grep -e DMAR -e IOMMU
[    0.000000] DMAR: IOMMU enabled

Thanks,
Elijah

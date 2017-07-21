Received: from eggs.gnu.org ([2001:4830:134:3::10]:40472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1dYco2-0001yJ-4t
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1dYcnz-0006lu-0G
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:37:42 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com
	([40.107.0.116]:51278
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Alexandru.Avadanii@enea.com>)
	id 1dYcny-0006ed-Gq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:37:38 -0400
From: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Date: Fri, 21 Jul 2017 18:37:26 +0000
Message-ID: <DB6PR07MB3157C27C077C91BE92846021F5A40@DB6PR07MB3157.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] virtio-net-pci possible limitation on AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: svc-armband <svc-armband@enea.com>

Hi,
I ran into an interesting limitation (or possibly bug) while trying to atta=
ch more than 3 (three) virtio-net-pci NICs to an AArch64 guest.
I created 4 network with virsh (see below for xml defitions) - nothing fanc=
y, only 2 of them use NAT.

Attaching a virtio-net-pci NIC for each network works well, VMs can be spaw=
ned, all devices are properly detected by the guest OS.
The first 3 guest interfaces work perfectly, however I can't get any traffi=
c on the 4th one (in my case the public one).

QEMU version: 2.9.0
Libvirt: tested with both 1.3.4 and 3.5.0, although I don't think libvirt i=
s to blame here
Host OS: Ubuntu Xenial 16.04.2 LTS
Guest OS: Ubuntu Xenial Cloud Image (latest available)
Reproducibility rate: 100% with below config

VM is created with (also domain XML attached at the end of this mail):
$ virt-install --name cfg01 --ram 4096 --vcpus 6 --cpu host-passthrough --a=
ccelerate \
--network network:pxe,model=3Dvirtio-net-pci \
--network network:mgmt,model=3Dvirtio-net-pci \
--network network:internal,model=3Dvirtio-net-pci \
--network network:public,model=3Dvirtio-net-pci \
--console pty --autostart --noreboot --noautoconsole --video=3Dvga --noauto=
console [...]

You might notice I had to disable legacy virtio in the domain XML, or the g=
uest would complain about a missing F_... property and no guest network int=
erfaces would be detected.

For now, since we only need 4 guest interfaces, we switched one of them bac=
k to virtio-mmio, and everything is working as expected.
Unfortunately I can't investigate this myself right now, but I can provide =
additional details if needed for someone else to look into it.

BR,
Alex

---
Network definitions:
---
<network>
  <name>pxe</name>
  <forward mode=3D'nat'/>
  <bridge name=3D'pxe' stp=3D'on' delay=3D'0'/>
  <ip address=3D'192.168.10.1' netmask=3D'255.255.255.0'>
    <dhcp>
      <range start=3D'192.168.10.100' end=3D'192.168.10.254'/>
    </dhcp>
  </ip>
</network>

<network>
  <name>mgmt</name>
  <bridge name=3D'mgmt' stp=3D'on' delay=3D'0'/>
  <ip address=3D'172.16.10.1' netmask=3D'255.255.255.0'>
  </ip>
</network>

<network>
  <name>internal</name>
  <bridge name=3D'internal' stp=3D'on' delay=3D'0'/>
</network>

<network>
  <name>public</name>
  <forward mode=3D'nat'/>
  <bridge name=3D'public' stp=3D'on' delay=3D'0'/>
  <ip address=3D'10.16.0.1' netmask=3D'255.255.255.0'>
  </ip>
</network>

---
Domain XML:
---
<domain type=3D'kvm' id=3D'28' xmlns:qemu=3D'http://libvirt.org/schemas/dom=
ain/qemu/1.0'>
  <name>cfg01</name>
  <uuid>3f8415d1-963a-46aa-8a63-1c6558775b92</uuid>
  <memory unit=3D'KiB'>4194304</memory>
  <currentMemory unit=3D'KiB'>4194304</currentMemory>
  <vcpu placement=3D'static'>6</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch=3D'aarch64' machine=3D'virt-2.9'>hvm</type>
    <loader readonly=3D'yes' type=3D'pflash'>/usr/share/AAVMF/AAVMF_CODE.fd=
</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/cfg01_VARS.fd</nvram>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <gic version=3D'3'/>
  </features>
  <cpu mode=3D'host-passthrough' check=3D'none'/>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <devices>
    <emulator>/usr/bin/kvm</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D'native'/>
      <source file=3D'/home/jenkins/alav/armband/upstream/fuel/mcp/scripts/=
images/mcp_cfg01.qcow2'/>
      <backingStore/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <alias name=3D'virtio-disk0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'cdrom'>
      <driver name=3D'qemu' type=3D'raw'/>
      <source file=3D'/home/jenkins/alav/armband/upstream/fuel/mcp/scripts/=
images/mcp_cfg01.iso'/>
      <backingStore/>
      <target dev=3D'sda' bus=3D'scsi'/>
      <readonly/>
      <alias name=3D'scsi0-0-0-0'/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=
=3D'0'/>
    </disk>
    <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
      <alias name=3D'scsi0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pcie-root'>
      <alias name=3D'pcie.0'/>
    </controller>
    <controller type=3D'pci' index=3D'1' model=3D'dmi-to-pci-bridge'>
      <model name=3D'i82801b11-bridge'/>
      <alias name=3D'pci.1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'2' model=3D'pci-bridge'>
      <model name=3D'pci-bridge'/>
      <target chassisNr=3D'2'/>
      <alias name=3D'pci.2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'3' port=3D'0x10'/>
      <alias name=3D'pci.3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'4' port=3D'0x11'/>
      <alias name=3D'pci.4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'5' port=3D'0x12'/>
      <alias name=3D'pci.5'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x2'/>
    </controller>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:ae:48:81'/>
      <source network=3D'pxe' bridge=3D'pxe'/>
      <target dev=3D'vnet0'/>
      <model type=3D'virtio-net-pci'/>
      <alias name=3D'net0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x01' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:36:2c:a9'/>
      <source network=3D'mgmt' bridge=3D'mgmt'/>
      <target dev=3D'vnet1'/>
      <model type=3D'virtio-net-pci'/>
      <alias name=3D'net1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:43:ce:03'/>
      <source network=3D'internal' bridge=3D'internal'/>
      <target dev=3D'vnet2'/>
      <model type=3D'virtio-net-pci'/>
      <alias name=3D'net2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x03' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:37:e6:0e'/>
      <source network=3D'public' bridge=3D'public'/>
      <target dev=3D'vnet3'/>
      <model type=3D'virtio-net-pci'/>
      <alias name=3D'net3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x04' fu=
nction=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <source path=3D'/dev/pts/0'/>
      <target port=3D'0'/>
      <alias name=3D'serial0'/>
    </serial>
    <console type=3D'pty' tty=3D'/dev/pts/0'>
      <source path=3D'/dev/pts/0'/>
      <target type=3D'serial' port=3D'0'/>
      <alias name=3D'serial0'/>
    </console>
    <graphics type=3D'vnc' port=3D'5900' autoport=3D'yes' listen=3D'127.0.0=
.1'>
      <listen type=3D'address' address=3D'127.0.0.1'/>
    </graphics>
    <video>
      <model type=3D'vga' vram=3D'16384' heads=3D'1' primary=3D'yes'/>
      <alias name=3D'video0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x05' fu=
nction=3D'0x0'/>
    </video>
  </devices>
  <seclabel type=3D'dynamic' model=3D'apparmor' relabel=3D'yes'>
    <label>libvirt-3f8415d1-963a-46aa-8a63-1c6558775b92</label>
    <imagelabel>libvirt-3f8415d1-963a-46aa-8a63-1c6558775b92</imagelabel>
  </seclabel>
  <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
    <label>+113:+115</label>
    <imagelabel>+113:+115</imagelabel>
  </seclabel>
  <qemu:commandline>
    <qemu:arg value=3D'-global'/>
    <qemu:arg value=3D'virtio-pci.disable-legacy=3Don'/>
  </qemu:commandline>
</domain>

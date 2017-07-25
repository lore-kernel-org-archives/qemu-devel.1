Received: from eggs.gnu.org ([2001:4830:134:3::10]:39605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1dZnsN-00031c-6o
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 20:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1dZnsI-0003L5-80
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 20:39:03 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com
	([104.47.0.97]:59459
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Alexandru.Avadanii@enea.com>)
	id 1dZnsH-0003Ir-Im
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 20:38:58 -0400
From: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Date: Tue, 25 Jul 2017 00:38:52 +0000
Message-ID: <DB6PR07MB3157D70FE3489F35F11DCABCF5B80@DB6PR07MB3157.eurprd07.prod.outlook.com>
References: <DB6PR07MB3157C27C077C91BE92846021F5A40@DB6PR07MB3157.eurprd07.prod.outlook.com>
	<20170724150213.slecgwbi7cjuxxog@kamzik.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] virtio-net-pci possible limitation on AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, svc-armband <svc-armband@enea.com>

Hi, Andrew,
I tried rebuilding virtinst (1.3.2), but that made no difference.

However, changing "model=3Dvirtio-net-pci" to simply "model=3Dvirtio"  (and=
 letting the default kick in via libvirt)
made a whole lot of difference (see domain xml at the end).

The interfaces are now on separate buses, all 4 work as expected, and the v=
irtio legacy disable is no longer needed.

I am a bit curious what goes wrong with the original XML, but not that much=
 to investigate it further.

Thank you,
Alex

New domain XML
---
<domain type=3D'kvm' id=3D'38'>
  <name>cfg01</name>
  <uuid>e4489f63-34a3-47f7-88c6-f6fb60a2aac0</uuid>
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
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x06' slot=3D'0x00' fu=
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
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x05' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pcie-root'>
      <alias name=3D'pcie.0'/>
    </controller>
    <controller type=3D'pci' index=3D'1' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'1' port=3D'0x8'/>
      <alias name=3D'pci.1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'2' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'2' port=3D'0x9'/>
      <alias name=3D'pci.2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'3' port=3D'0xa'/>
      <alias name=3D'pci.3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'4' port=3D'0xb'/>
      <alias name=3D'pci.4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x3'/>
    </controller>
    <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'5' port=3D'0xc'/>
      <alias name=3D'pci.5'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x4'/>
    </controller>
    <controller type=3D'pci' index=3D'6' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'6' port=3D'0xd'/>
      <alias name=3D'pci.6'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x5'/>
    </controller>
    <controller type=3D'pci' index=3D'7' model=3D'dmi-to-pci-bridge'>
      <model name=3D'i82801b11-bridge'/>
      <alias name=3D'pci.7'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'8' model=3D'pci-bridge'>
      <model name=3D'pci-bridge'/>
      <target chassisNr=3D'8'/>
      <alias name=3D'pci.8'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'9' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'9' port=3D'0xe'/>
      <alias name=3D'pci.9'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x6'/>
    </controller>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:2f:9e:f0'/>
      <source network=3D'pxe' bridge=3D'pxe'/>
      <target dev=3D'vnet0'/>
      <model type=3D'virtio'/>
      <alias name=3D'net0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:87:d5:81'/>
      <source network=3D'mgmt' bridge=3D'mgmt'/>
      <target dev=3D'vnet1'/>
      <model type=3D'virtio'/>
      <alias name=3D'net1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:2f:9a:e5'/>
      <source network=3D'internal' bridge=3D'internal'/>
      <target dev=3D'vnet2'/>
      <model type=3D'virtio'/>
      <alias name=3D'net2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:64:41:45'/>
      <source network=3D'public' bridge=3D'public'/>
      <target dev=3D'vnet3'/>
      <model type=3D'virtio'/>
      <alias name=3D'net3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' fu=
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
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x08' slot=3D'0x01' fu=
nction=3D'0x0'/>
    </video>
  </devices>
  <seclabel type=3D'dynamic' model=3D'apparmor' relabel=3D'yes'>
    <label>libvirt-e4489f63-34a3-47f7-88c6-f6fb60a2aac0</label>
    <imagelabel>libvirt-e4489f63-34a3-47f7-88c6-f6fb60a2aac0</imagelabel>
  </seclabel>
  <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
    <label>+113:+115</label>
    <imagelabel>+113:+115</imagelabel>
  </seclabel>
</domain>

> -----Original Message-----
> From: Alexandru Avadanii
> Sent: Monday, July 24, 2017 6:53 PM
> To: 'Andrew Jones'
> Cc: qemu-devel@nongnu.org; svc-armband
> Subject: RE: [Qemu-devel] virtio-net-pci possible limitation on AArch64
>=20
> Hi, Andrew,
> Thank you for looking at this.
> Comments inline.
>=20
> > -----Original Message-----
> > From: Andrew Jones [mailto:drjones@redhat.com]
> > Sent: Monday, July 24, 2017 6:02 PM
> > To: Alexandru Avadanii
> > Cc: qemu-devel@nongnu.org; svc-armband
> > Subject: Re: [Qemu-devel] virtio-net-pci possible limitation on
> > AArch64
> >
> > On Fri, Jul 21, 2017 at 06:37:26PM +0000, Alexandru Avadanii wrote:
> > > Hi,
> > > I ran into an interesting limitation (or possibly bug) while trying
> > > to attach
> > more than 3 (three) virtio-net-pci NICs to an AArch64 guest.
> > > I created 4 network with virsh (see below for xml defitions) -
> > > nothing fancy,
> > only 2 of them use NAT.
> > >
> > > Attaching a virtio-net-pci NIC for each network works well, VMs can
> > > be
> > spawned, all devices are properly detected by the guest OS.
> > > The first 3 guest interfaces work perfectly, however I can't get any
> > > traffic
> > on the 4th one (in my case the public one).
> > >
> > > QEMU version: 2.9.0
> > > Libvirt: tested with both 1.3.4 and 3.5.0, although I don't think
> > > libvirt is to blame here
> >
> > 1.3.4 is way too old for AArch64 guests - 3.0.0 was the first release
> > that contained basic support. The XML below doesn't show what I'd
> > expect for the PCIe topology either (see [*]), and that's likely the
> > problem. I suggest you try a fresh VM creation using latest libvirt and=
 virt
> tools.
> > If it still doesn't work, then confirm it's not a bridging issue by
> > checking that it's always the forth network by changing their order.
>=20
> I also tried libvirt 3.5.0, but maybe I missed something, like newer virt=
-tools. I
> will redo the test.
> In my previous tests, I tried changing the order, and it was always the f=
ourth
> interface having issues.
>=20
> >
> > [*] QEMU doc: docs/config/mach-virt-graphical.cfg
> >
> > > Host OS: Ubuntu Xenial 16.04.2 LTS
> > > Guest OS: Ubuntu Xenial Cloud Image (latest available)
> > > Reproducibility
> > > rate: 100% with below config
> > >
> > > VM is created with (also domain XML attached at the end of this mail)=
:
> > > $ virt-install --name cfg01 --ram 4096 --vcpus 6 --cpu
> > > host-passthrough --accelerate \ --network
> > > network:pxe,model=3Dvirtio-net-pci \ --network
> > > network:mgmt,model=3Dvirtio-net-pci \ --network
> > > network:internal,model=3Dvirtio-net-pci \ --network
> > > network:public,model=3Dvirtio-net-pci \ --console pty --autostart
> > > --noreboot --noautoconsole --video=3Dvga --noautoconsole [...]
> > >
> > > You might notice I had to disable legacy virtio in the domain XML,
> > > or the
> > guest would complain about a missing F_... property and no guest
> > network interfaces would be detected.
> >
> > You shouldn't need to do this disable-legacy stuff when using PCIe
> > ports, as the virtio devices will automatically use virtio-1.0 ("modern=
").
> >
> > >
> > > For now, since we only need 4 guest interfaces, we switched one of
> > > them
> > back to virtio-mmio, and everything is working as expected.
> > > Unfortunately I can't investigate this myself right now, but I can
> > > provide
> > additional details if needed for someone else to look into it.
> >
> > I just checked on my setup (RH qemu based on 2.9, RH libvirt based on
> > 3.2). I used Fedora 26's virt-manager from my x86 notebook, remotely
> > connecting to my AArch64 host, in order to create four networks and a
> > guest that has them all attached to four virtio nics. It worked without=
 a hitch.
>=20
> Good to know this is specific to my setup, I was afraid this is a real is=
sue.
> I'll retest using all suggestions above and get back with the rootcause.
>=20
> Thank you,
> Alex
>=20
> >
> > Thanks,
> > drew
> >
> > >
> > > BR,
> > > Alex
> > >
> > > ---
> > > Network definitions:
> > > ---
> > > <network>
> > >   <name>pxe</name>
> > >   <forward mode=3D'nat'/>
> > >   <bridge name=3D'pxe' stp=3D'on' delay=3D'0'/>
> > >   <ip address=3D'192.168.10.1' netmask=3D'255.255.255.0'>
> > >     <dhcp>
> > >       <range start=3D'192.168.10.100' end=3D'192.168.10.254'/>
> > >     </dhcp>
> > >   </ip>
> > > </network>
> > >
> > > <network>
> > >   <name>mgmt</name>
> > >   <bridge name=3D'mgmt' stp=3D'on' delay=3D'0'/>
> > >   <ip address=3D'172.16.10.1' netmask=3D'255.255.255.0'>
> > >   </ip>
> > > </network>
> > >
> > > <network>
> > >   <name>internal</name>
> > >   <bridge name=3D'internal' stp=3D'on' delay=3D'0'/> </network>
> > >
> > > <network>
> > >   <name>public</name>
> > >   <forward mode=3D'nat'/>
> > >   <bridge name=3D'public' stp=3D'on' delay=3D'0'/>
> > >   <ip address=3D'10.16.0.1' netmask=3D'255.255.255.0'>
> > >   </ip>
> > > </network>
> > >
> > > ---
> > > Domain XML:
> > > ---
> > > <domain type=3D'kvm' id=3D'28'
> > xmlns:qemu=3D'http://libvirt.org/schemas/domain/qemu/1.0'>
> > >   <name>cfg01</name>
> > >   <uuid>3f8415d1-963a-46aa-8a63-1c6558775b92</uuid>
> > >   <memory unit=3D'KiB'>4194304</memory>
> > >   <currentMemory unit=3D'KiB'>4194304</currentMemory>
> > >   <vcpu placement=3D'static'>6</vcpu>
> > >   <resource>
> > >     <partition>/machine</partition>
> > >   </resource>
> > >   <os>
> > >     <type arch=3D'aarch64' machine=3D'virt-2.9'>hvm</type>
> > >     <loader readonly=3D'yes'
> > type=3D'pflash'>/usr/share/AAVMF/AAVMF_CODE.fd</loader>
> > >     <nvram>/var/lib/libvirt/qemu/nvram/cfg01_VARS.fd</nvram>
> > >     <boot dev=3D'hd'/>
> > >   </os>
> > >   <features>
> > >     <acpi/>
> > >     <gic version=3D'3'/>
> > >   </features>
> > >   <cpu mode=3D'host-passthrough' check=3D'none'/>
> > >   <clock offset=3D'utc'/>
> > >   <on_poweroff>destroy</on_poweroff>
> > >   <on_reboot>restart</on_reboot>
> > >   <on_crash>restart</on_crash>
> > >   <devices>
> > >     <emulator>/usr/bin/kvm</emulator>
> > >     <disk type=3D'file' device=3D'disk'>
> > >       <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D'nativ=
e'/>
> > >       <source
> > file=3D'/home/jenkins/alav/armband/upstream/fuel/mcp/scripts/images/mcp
> > _cfg01.qcow2'/>
> > >       <backingStore/>
> > >       <target dev=3D'vda' bus=3D'virtio'/>
> > >       <alias name=3D'virtio-disk0'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x=
00'
> > function=3D'0x0'/>
> > >     </disk>
> > >     <disk type=3D'file' device=3D'cdrom'>
> > >       <driver name=3D'qemu' type=3D'raw'/>
> > >       <source
> > file=3D'/home/jenkins/alav/armband/upstream/fuel/mcp/scripts/images/mcp
> > _cfg01.iso'/>
> > >       <backingStore/>
> > >       <target dev=3D'sda' bus=3D'scsi'/>
> > >       <readonly/>
> > >       <alias name=3D'scsi0-0-0-0'/>
> > >       <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0'=
 unit=3D'0'/>
> > >     </disk>
> > >     <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
> > >       <alias name=3D'scsi0'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x=
00'
> > function=3D'0x0'/>
> > >     </controller>
> > >     <controller type=3D'pci' index=3D'0' model=3D'pcie-root'>
> > >       <alias name=3D'pcie.0'/>
> > >     </controller>
> > >     <controller type=3D'pci' index=3D'1' model=3D'dmi-to-pci-bridge'>
> > >       <model name=3D'i82801b11-bridge'/>
> > >       <alias name=3D'pci.1'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x=
01'
> > function=3D'0x0'/>
> > >     </controller>
> > >     <controller type=3D'pci' index=3D'2' model=3D'pci-bridge'>
> > >       <model name=3D'pci-bridge'/>
> > >       <target chassisNr=3D'2'/>
> > >       <alias name=3D'pci.2'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x=
00'
> > function=3D'0x0'/>
> > >     </controller>
> > >     <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
> > >       <model name=3D'pcie-root-port'/>
> > >       <target chassis=3D'3' port=3D'0x10'/>
> > >       <alias name=3D'pci.3'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x=
02'
> > function=3D'0x0' multifunction=3D'on'/>
> > >     </controller>
> > >     <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
> > >       <model name=3D'pcie-root-port'/>
> > >       <target chassis=3D'4' port=3D'0x11'/>
> > >       <alias name=3D'pci.4'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x=
02'
> > function=3D'0x1'/>
> > >     </controller>
> > >     <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
> > >       <model name=3D'pcie-root-port'/>
> > >       <target chassis=3D'5' port=3D'0x12'/>
> > >       <alias name=3D'pci.5'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x=
02'
> > function=3D'0x2'/>
> > >     </controller>
> > >     <interface type=3D'network'>
> > >       <mac address=3D'52:54:00:ae:48:81'/>
> > >       <source network=3D'pxe' bridge=3D'pxe'/>
> > >       <target dev=3D'vnet0'/>
> > >       <model type=3D'virtio-net-pci'/>
> > >       <alias name=3D'net0'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x=
01'
> > function=3D'0x0'/>
> > >     </interface>
> > >     <interface type=3D'network'>
> > >       <mac address=3D'52:54:00:36:2c:a9'/>
> > >       <source network=3D'mgmt' bridge=3D'mgmt'/>
> > >       <target dev=3D'vnet1'/>
> > >       <model type=3D'virtio-net-pci'/>
> > >       <alias name=3D'net1'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x=
02'
> > function=3D'0x0'/>
> > >     </interface>
> > >     <interface type=3D'network'>
> > >       <mac address=3D'52:54:00:43:ce:03'/>
> > >       <source network=3D'internal' bridge=3D'internal'/>
> > >       <target dev=3D'vnet2'/>
> > >       <model type=3D'virtio-net-pci'/>
> > >       <alias name=3D'net2'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x=
03'
> > function=3D'0x0'/>
> > >     </interface>
> > >     <interface type=3D'network'>
> > >       <mac address=3D'52:54:00:37:e6:0e'/>
> > >       <source network=3D'public' bridge=3D'public'/>
> > >       <target dev=3D'vnet3'/>
> > >       <model type=3D'virtio-net-pci'/>
> > >       <alias name=3D'net3'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x=
04'
> > function=3D'0x0'/>
> > >     </interface>
> > >     <serial type=3D'pty'>
> > >       <source path=3D'/dev/pts/0'/>
> > >       <target port=3D'0'/>
> > >       <alias name=3D'serial0'/>
> > >     </serial>
> > >     <console type=3D'pty' tty=3D'/dev/pts/0'>
> > >       <source path=3D'/dev/pts/0'/>
> > >       <target type=3D'serial' port=3D'0'/>
> > >       <alias name=3D'serial0'/>
> > >     </console>
> > >     <graphics type=3D'vnc' port=3D'5900' autoport=3D'yes' listen=3D'1=
27.0.0.1'>
> > >       <listen type=3D'address' address=3D'127.0.0.1'/>
> > >     </graphics>
> > >     <video>
> > >       <model type=3D'vga' vram=3D'16384' heads=3D'1' primary=3D'yes'/=
>
> > >       <alias name=3D'video0'/>
> > >       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x=
05'
> > function=3D'0x0'/>
> > >     </video>
> > >   </devices>
> > >   <seclabel type=3D'dynamic' model=3D'apparmor' relabel=3D'yes'>
> > >     <label>libvirt-3f8415d1-963a-46aa-8a63-1c6558775b92</label>
> > >     <imagelabel>libvirt-3f8415d1-963a-46aa-8a63-
> > 1c6558775b92</imagelabel>
> > >   </seclabel>
> > >   <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
> > >     <label>+113:+115</label>
> > >     <imagelabel>+113:+115</imagelabel>
> > >   </seclabel>
> > >   <qemu:commandline>
> > >     <qemu:arg value=3D'-global'/>
> > >     <qemu:arg value=3D'virtio-pci.disable-legacy=3Don'/>
> > >   </qemu:commandline>
> > > </domain>
> > >

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dZeyM-0003ii-LC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dZeyJ-0004fz-5i
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1dZeyI-0004f7-S5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:08:35 -0400
Date: Mon, 24 Jul 2017 17:02:13 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170724150213.slecgwbi7cjuxxog@kamzik.brq.redhat.com>
References: <DB6PR07MB3157C27C077C91BE92846021F5A40@DB6PR07MB3157.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR07MB3157C27C077C91BE92846021F5A40@DB6PR07MB3157.eurprd07.prod.outlook.com>
Subject: Re: [Qemu-devel] virtio-net-pci possible limitation on AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, svc-armband <svc-armband@enea.com>

On Fri, Jul 21, 2017 at 06:37:26PM +0000, Alexandru Avadanii wrote:
> Hi,
> I ran into an interesting limitation (or possibly bug) while trying to attach more than 3 (three) virtio-net-pci NICs to an AArch64 guest.
> I created 4 network with virsh (see below for xml defitions) - nothing fancy, only 2 of them use NAT.
> 
> Attaching a virtio-net-pci NIC for each network works well, VMs can be spawned, all devices are properly detected by the guest OS.
> The first 3 guest interfaces work perfectly, however I can't get any traffic on the 4th one (in my case the public one).
> 
> QEMU version: 2.9.0
> Libvirt: tested with both 1.3.4 and 3.5.0, although I don't think libvirt is to blame here

1.3.4 is way too old for AArch64 guests - 3.0.0 was the first release that
contained basic support. The XML below doesn't show what I'd expect for
the PCIe topology either (see [*]), and that's likely the problem. I
suggest you try a fresh VM creation using latest libvirt and virt tools.
If it still doesn't work, then confirm it's not a bridging issue by
checking that it's always the forth network by changing their order.

[*] QEMU doc: docs/config/mach-virt-graphical.cfg

> Host OS: Ubuntu Xenial 16.04.2 LTS
> Guest OS: Ubuntu Xenial Cloud Image (latest available)
> Reproducibility rate: 100% with below config
> 
> VM is created with (also domain XML attached at the end of this mail):
> $ virt-install --name cfg01 --ram 4096 --vcpus 6 --cpu host-passthrough --accelerate \
> --network network:pxe,model=virtio-net-pci \
> --network network:mgmt,model=virtio-net-pci \
> --network network:internal,model=virtio-net-pci \
> --network network:public,model=virtio-net-pci \
> --console pty --autostart --noreboot --noautoconsole --video=vga --noautoconsole [...]
> 
> You might notice I had to disable legacy virtio in the domain XML, or the guest would complain about a missing F_... property and no guest network interfaces would be detected.

You shouldn't need to do this disable-legacy stuff when using PCIe ports,
as the virtio devices will automatically use virtio-1.0 ("modern").

> 
> For now, since we only need 4 guest interfaces, we switched one of them back to virtio-mmio, and everything is working as expected.
> Unfortunately I can't investigate this myself right now, but I can provide additional details if needed for someone else to look into it.

I just checked on my setup (RH qemu based on 2.9, RH libvirt based on
3.2). I used Fedora 26's virt-manager from my x86 notebook, remotely
connecting to my AArch64 host, in order to create four networks and
a guest that has them all attached to four virtio nics. It worked
without a hitch.

Thanks,
drew

> 
> BR,
> Alex
> 
> ---
> Network definitions:
> ---
> <network>
>   <name>pxe</name>
>   <forward mode='nat'/>
>   <bridge name='pxe' stp='on' delay='0'/>
>   <ip address='192.168.10.1' netmask='255.255.255.0'>
>     <dhcp>
>       <range start='192.168.10.100' end='192.168.10.254'/>
>     </dhcp>
>   </ip>
> </network>
> 
> <network>
>   <name>mgmt</name>
>   <bridge name='mgmt' stp='on' delay='0'/>
>   <ip address='172.16.10.1' netmask='255.255.255.0'>
>   </ip>
> </network>
> 
> <network>
>   <name>internal</name>
>   <bridge name='internal' stp='on' delay='0'/>
> </network>
> 
> <network>
>   <name>public</name>
>   <forward mode='nat'/>
>   <bridge name='public' stp='on' delay='0'/>
>   <ip address='10.16.0.1' netmask='255.255.255.0'>
>   </ip>
> </network>
> 
> ---
> Domain XML:
> ---
> <domain type='kvm' id='28' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
>   <name>cfg01</name>
>   <uuid>3f8415d1-963a-46aa-8a63-1c6558775b92</uuid>
>   <memory unit='KiB'>4194304</memory>
>   <currentMemory unit='KiB'>4194304</currentMemory>
>   <vcpu placement='static'>6</vcpu>
>   <resource>
>     <partition>/machine</partition>
>   </resource>
>   <os>
>     <type arch='aarch64' machine='virt-2.9'>hvm</type>
>     <loader readonly='yes' type='pflash'>/usr/share/AAVMF/AAVMF_CODE.fd</loader>
>     <nvram>/var/lib/libvirt/qemu/nvram/cfg01_VARS.fd</nvram>
>     <boot dev='hd'/>
>   </os>
>   <features>
>     <acpi/>
>     <gic version='3'/>
>   </features>
>   <cpu mode='host-passthrough' check='none'/>
>   <clock offset='utc'/>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>restart</on_crash>
>   <devices>
>     <emulator>/usr/bin/kvm</emulator>
>     <disk type='file' device='disk'>
>       <driver name='qemu' type='qcow2' cache='none' io='native'/>
>       <source file='/home/jenkins/alav/armband/upstream/fuel/mcp/scripts/images/mcp_cfg01.qcow2'/>
>       <backingStore/>
>       <target dev='vda' bus='virtio'/>
>       <alias name='virtio-disk0'/>
>       <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
>     </disk>
>     <disk type='file' device='cdrom'>
>       <driver name='qemu' type='raw'/>
>       <source file='/home/jenkins/alav/armband/upstream/fuel/mcp/scripts/images/mcp_cfg01.iso'/>
>       <backingStore/>
>       <target dev='sda' bus='scsi'/>
>       <readonly/>
>       <alias name='scsi0-0-0-0'/>
>       <address type='drive' controller='0' bus='0' target='0' unit='0'/>
>     </disk>
>     <controller type='scsi' index='0' model='virtio-scsi'>
>       <alias name='scsi0'/>
>       <address type='pci' domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
>     </controller>
>     <controller type='pci' index='0' model='pcie-root'>
>       <alias name='pcie.0'/>
>     </controller>
>     <controller type='pci' index='1' model='dmi-to-pci-bridge'>
>       <model name='i82801b11-bridge'/>
>       <alias name='pci.1'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
>     </controller>
>     <controller type='pci' index='2' model='pci-bridge'>
>       <model name='pci-bridge'/>
>       <target chassisNr='2'/>
>       <alias name='pci.2'/>
>       <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
>     </controller>
>     <controller type='pci' index='3' model='pcie-root-port'>
>       <model name='pcie-root-port'/>
>       <target chassis='3' port='0x10'/>
>       <alias name='pci.3'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0' multifunction='on'/>
>     </controller>
>     <controller type='pci' index='4' model='pcie-root-port'>
>       <model name='pcie-root-port'/>
>       <target chassis='4' port='0x11'/>
>       <alias name='pci.4'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x1'/>
>     </controller>
>     <controller type='pci' index='5' model='pcie-root-port'>
>       <model name='pcie-root-port'/>
>       <target chassis='5' port='0x12'/>
>       <alias name='pci.5'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x2'/>
>     </controller>
>     <interface type='network'>
>       <mac address='52:54:00:ae:48:81'/>
>       <source network='pxe' bridge='pxe'/>
>       <target dev='vnet0'/>
>       <model type='virtio-net-pci'/>
>       <alias name='net0'/>
>       <address type='pci' domain='0x0000' bus='0x02' slot='0x01' function='0x0'/>
>     </interface>
>     <interface type='network'>
>       <mac address='52:54:00:36:2c:a9'/>
>       <source network='mgmt' bridge='mgmt'/>
>       <target dev='vnet1'/>
>       <model type='virtio-net-pci'/>
>       <alias name='net1'/>
>       <address type='pci' domain='0x0000' bus='0x02' slot='0x02' function='0x0'/>
>     </interface>
>     <interface type='network'>
>       <mac address='52:54:00:43:ce:03'/>
>       <source network='internal' bridge='internal'/>
>       <target dev='vnet2'/>
>       <model type='virtio-net-pci'/>
>       <alias name='net2'/>
>       <address type='pci' domain='0x0000' bus='0x02' slot='0x03' function='0x0'/>
>     </interface>
>     <interface type='network'>
>       <mac address='52:54:00:37:e6:0e'/>
>       <source network='public' bridge='public'/>
>       <target dev='vnet3'/>
>       <model type='virtio-net-pci'/>
>       <alias name='net3'/>
>       <address type='pci' domain='0x0000' bus='0x02' slot='0x04' function='0x0'/>
>     </interface>
>     <serial type='pty'>
>       <source path='/dev/pts/0'/>
>       <target port='0'/>
>       <alias name='serial0'/>
>     </serial>
>     <console type='pty' tty='/dev/pts/0'>
>       <source path='/dev/pts/0'/>
>       <target type='serial' port='0'/>
>       <alias name='serial0'/>
>     </console>
>     <graphics type='vnc' port='5900' autoport='yes' listen='127.0.0.1'>
>       <listen type='address' address='127.0.0.1'/>
>     </graphics>
>     <video>
>       <model type='vga' vram='16384' heads='1' primary='yes'/>
>       <alias name='video0'/>
>       <address type='pci' domain='0x0000' bus='0x02' slot='0x05' function='0x0'/>
>     </video>
>   </devices>
>   <seclabel type='dynamic' model='apparmor' relabel='yes'>
>     <label>libvirt-3f8415d1-963a-46aa-8a63-1c6558775b92</label>
>     <imagelabel>libvirt-3f8415d1-963a-46aa-8a63-1c6558775b92</imagelabel>
>   </seclabel>
>   <seclabel type='dynamic' model='dac' relabel='yes'>
>     <label>+113:+115</label>
>     <imagelabel>+113:+115</imagelabel>
>   </seclabel>
>   <qemu:commandline>
>     <qemu:arg value='-global'/>
>     <qemu:arg value='virtio-pci.disable-legacy=on'/>
>   </qemu:commandline>
> </domain>
> 

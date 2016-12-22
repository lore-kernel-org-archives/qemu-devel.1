Received: from eggs.gnu.org ([2001:4830:134:3::10]:57022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jferlan@redhat.com>) id 1cKBQv-00019D-U0
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 17:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jferlan@redhat.com>) id 1cKBQs-00056l-Rl
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 17:01:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jferlan@redhat.com>) id 1cKBQs-00053a-Jc
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 17:01:50 -0500
References: <CA+scX6nh8NeTWZ44KG85T_ywzVnSc6bMhO69hhGhzbh8ZLnwOg@mail.gmail.com>
From: John Ferlan <jferlan@redhat.com>
Message-ID: <db89d6ca-f832-aece-27d4-70408b5851b6@redhat.com>
Date: Thu, 22 Dec 2016 17:01:46 -0500
MIME-Version: 1.0
In-Reply-To: <CA+scX6nh8NeTWZ44KG85T_ywzVnSc6bMhO69hhGhzbh8ZLnwOg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Cannot add iothreads label in libvirt
 xml configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>, libvir-list@redhat.com
Cc: qemu-devel@nongnu.org



On 12/21/2016 12:11 PM, Weiwei Jia wrote:
> Hi,
> 
> I cannot add iothreads
> (https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation) in
> the libvirt xml configuration file. Once I add
> "<iothreads>4</iothreads>" and other related config for IOthreads into
> the libvirt xml configuration file with virsh command and save it,
> these iothreads related configuration will disappear after I open
> libvirt xml configuration file again for double-check.
> 
> The current libvirt xml configuration file is like following.
> 

If I try to just cut-n-paste the following xml into a buffer, then run
virsh define kvm1.xml, I get:

error: Failed to define domain from kvm1.xml
error: Cannot check QEMU binary /usr/bin/kvm-spice: No such file or
directory

In order to support iothreads, it requires an "-object iothread"... The
"shortest" command line using qemu-kvm would be "qemu-kvm -object
iothread,id=xxx1", so you could try the same with that
/usr/bin/kvm-spice image and see what you get.

You could try to figure out from the
/var/cach/libvirt/qemu/capabilities/*.xml files whether or not the
"iothread" object exists... I would think though that the reason why
this is failing for you is that the kvm-spice emulator doesn't have the
required capability (I forget if there's a magic incantation to ask the
emulator image what it supports, especially for objects).

John

> # virsh dumpxml kvm1
> <domain type='kvm'>
>   <name>kvm1</name>
>   <uuid>20811918-9057-4496-aa03-0fe9d1bcaf78</uuid>
>   <memory unit='KiB'>8194304</memory>
>   <currentMemory unit='KiB'>8194304</currentMemory>
>   <vcpu placement='static'>6</vcpu>
>   <cputune>
>     <vcpupin vcpu='0' cpuset='0'/>
>     <vcpupin vcpu='1' cpuset='1'/>
>     <vcpupin vcpu='2' cpuset='2'/>
>     <vcpupin vcpu='3' cpuset='3'/>
>     <vcpupin vcpu='4' cpuset='4'/>
>     <vcpupin vcpu='5' cpuset='5'/>
>     <emulatorpin cpuset='12-15'/>
>   </cputune>
>   <resource>
>     <partition>/machine</partition>
>   </resource>
>   <os>
>     <type arch='x86_64' machine='pc-i440fx-2.0'>hvm</type>
>     <boot dev='hd'/>
>   </os>
>   <features>
>     <acpi/>
>     <apic/>
>     <pae/>
>   </features>
>   <clock offset='utc'/>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>restart</on_crash>
>   <devices>
>     <emulator>/usr/bin/kvm-spice</emulator>
>     <disk type='file' device='disk'>
>       <driver name='qemu' type='raw' cache='none' io='native'/>
>       <source file='/var/lib/libvirt/images/kvm1.img'/>
>       <target dev='vda' bus='virtio'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x06'
> function='0x0'/>
>     </disk>
>     <disk type='block' device='cdrom'>
>       <driver name='qemu' type='raw'/>
>       <target dev='hdc' bus='ide'/>
>       <readonly/>
>       <address type='drive' controller='0' bus='1' target='0' unit='0'/>
>     </disk>
>     <controller type='usb' index='0'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
> function='0x2'/>
>     </controller>
>     <controller type='pci' index='0' model='pci-root'/>
>     <controller type='scsi' index='0'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
> function='0x0'/>
>     </controller>
>     <controller type='ide' index='0'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
> function='0x1'/>
>     </controller>
>     <interface type='network'>
>       <mac address='52:54:00:a7:67:eb'/>
>       <source network='default'/>
>       <model type='virtio'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
> function='0x0'/>
>     </interface>
>     <serial type='pty'>
>       <target port='0'/>
>     </serial>
>     <console type='pty'>
>       <target type='serial' port='0'/>
>     </console>
>     <input type='mouse' bus='ps2'/>
>     <input type='keyboard' bus='ps2'/>
>     <graphics type='vnc' port='-1' autoport='yes' listen='127.0.0.1'>
>       <listen type='address' address='127.0.0.1'/>
>     </graphics>
>     <video>
>       <model type='cirrus' vram='9216' heads='1'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
> function='0x0'/>
>     </video>
>     <memballoon model='virtio'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05'
> function='0x0'/>
>     </memballoon>
>   </devices>
>   <seclabel type='none'/>
> </domain>
> 
> 
> 
> 
> 
> I want to config above xml file to be like following but once I save
> it, the iothreads related configuration will disappear (like above)
> after I re-open the libvirt xml for double-check.
> 
> <domain  type='kvm' id='1'
> xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
>   <name>kvm1</name>
>   <memory unit='KiB'>8194304</memory>
>   <currentMemory unit='KiB'>8194304</currentMemory>
>   <vcpu placement='static'>6</vcpu>
>   <iothreads>4</iothreads>
>   <iothreadids>
>  <iothread id="2"/>
>  <iothread id="4"/>
>  <iothread id="6"/>
>  <iothread id="8"/>
>   </iothreadids>
>   <cputune>
>     <vcpupin vcpu='0' cpuset='0'/>
>     <vcpupin vcpu='1' cpuset='1'/>
>     <vcpupin vcpu='2' cpuset='2'/>
>     <vcpupin vcpu='3' cpuset='3'/>
>     <vcpupin vcpu='4' cpuset='4'/>
>     <vcpupin vcpu='5' cpuset='5'/>
> <emulatorpin cpuset="12-15"/>
> <iothreadpin iothread="2" cpuset="7"/>
> <iothreadpin iothread="4" cpuset="8"/>
> <iothreadpin iothread="6" cpuset="9"/>
> <iothreadpin iothread="8" cpuset="10"/>
>   </cputune>
>   <resource>
>     <partition>/machine</partition>
>   </resource>
>   <os>
>     <type arch='x86_64' machine='pc-i440fx-2.0'>hvm</type>
>     <boot dev='hd'/>
>   </os>
>   <features>
>     <acpi/>
>     <apic/>
>     <pae/>
>   </features>
>   <clock offset='utc'/>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>restart</on_crash>
>   <devices>
>     <emulator>/usr/bin/kvm-spice</emulator>
>     <disk type='file' device='disk'>
>       <driver name='qemu' type='raw' cache='none' io='native' iothread='2-8'/>
>  <source file='/home/wj47/ssd1/kvm1.img'/>
>       <target dev='vda' bus='virtio'/>
>       <alias name='virtio-disk0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x06'
> function='0x0'/>
>     </disk>
>     <disk type='block' device='cdrom'>
>       <driver name='qemu' type='raw'/>
>       <target dev='hdc' bus='ide'/>
>       <readonly/>
>       <alias name='ide0-1-0'/>
>       <address type='drive' controller='0' bus='1' target='0' unit='0'/>
>     </disk>
>     <controller type='usb' index='0'>
>       <alias name='usb0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
> function='0x2'/>
>     </controller>
>     <controller type='pci' index='0' model='pci-root'>
>       <alias name='pci.0'/>
>     </controller>
>     <controller type='scsi' index='0'>
>       <alias name='scsi0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
> function='0x0'/>
>     </controller>
>     <controller type='ide' index='0'>
>       <alias name='ide0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
> function='0x1'/>
>     </controller>
>     <interface type='network'>
>       <source network='default'/>
>       <target dev='vnet0'/>
>       <model type='virtio'/>
>       <alias name='net0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
> function='0x0'/>
>     </interface>
>     <serial type='pty'>
>       <source path='/dev/pts/11'/>
>       <target port='0'/>
>       <alias name='serial0'/>
>     </serial>
>     <console type='pty' tty='/dev/pts/11'>
>       <source path='/dev/pts/11'/>
>       <target type='serial' port='0'/>
>       <alias name='serial0'/>
>     </console>
>     <input type='mouse' bus='ps2'/>
>     <input type='keyboard' bus='ps2'/>
>     <graphics type='vnc' port='5900' autoport='yes' listen='127.0.0.1'>
>       <listen type='address' address='127.0.0.1'/>
>     </graphics>
>     <video>
>       <model type='cirrus' vram='9216' heads='1'/>
>       <alias name='video0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
> function='0x0'/>
>     </video>
>     <memballoon model='virtio'>
>       <alias name='balloon0'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05'
> function='0x0'/>
>     </memballoon>
>   </devices>
>   <seclabel type='none'/>
> </domain>
> 
> 
> 
> 
> 
> Another concern is like this: can I config 4 dedicated IOthreads for
> one drive. Just like above, I want to start 4 IOthreads for
> virtio-disk0. If true, is my config like above correct? Thank you.
> 
> Best,
> Weiwei Jia
> 
> --
> libvir-list mailing list
> libvir-list@redhat.com
> https://www.redhat.com/mailman/listinfo/libvir-list
> 

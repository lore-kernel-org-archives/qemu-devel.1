Received: from eggs.gnu.org ([2001:4830:134:3::10]:48201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWYY5-0005F9-DM
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWYY2-0002w4-7s
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:12:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWYY1-0002vF-SY
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:12:54 -0500
Date: Wed, 3 Jan 2018 10:12:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103021226.GA19709@localhost.localdomain>
References: <CAOBqJ54HDeQNOv++XjimiSfmLTyNgy2AjBdpO6_SChVGfr5U+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBqJ54HDeQNOv++XjimiSfmLTyNgy2AjBdpO6_SChVGfr5U+A@mail.gmail.com>
Subject: Re: [Qemu-devel] Problem to start VM with libiscsi + qemu upstream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roy Shterman <roy.shterman@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, pl@kamp.de, ronnie sahlberg <ronniesahlberg@gmail.com>

On Tue, 01/02 21:58, Roy Shterman wrote:
> Hi all,
> 
> I'm trying to get VM started with libiscsi (iSCSI initiator) device. Every
> thing seems good from iSCSI point of view, but I'm stuck in VM boot,
> "Booting from Hard Disk".
> Any idea what can get wrong? how I can assure that the boot itself is from
> the wanted disk.
> Also will be helpful if someone can tell me how can I debug issues like
> that.

Do you still hit the hang if you remove the iscsi lun and only have the system
disk?

> 
> below my xml part of disks:
> 
> <domain type='kvm'>
>   <name>client</name>
>   <uuid>d4e60885-22be-4270-94ca-1be8209686d2</uuid>
>   <memory unit='KiB'>1048576</memory>
>   <currentMemory unit='KiB'>1048576</currentMemory>
>   <vcpu placement='static'>1</vcpu>
>   <os>
>     <type arch='x86_64' machine='pc-i440fx-2.7'>hvm</type>
>     <bootmenu enable='yes'/>
>   </os>
>   <features>
>     <acpi/>
>     <apic/>
>     <vmport state='off'/>
>   </features>
>   <cpu mode='host-model' check='partial'>
>     <model fallback='allow'/>
>   </cpu>
>   <clock offset='utc'>
>     <timer name='rtc' tickpolicy='catchup'/>
>     <timer name='pit' tickpolicy='delay'/>
>     <timer name='hpet' present='no'/>
>   </clock>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>restart</on_crash>
>   <devices>
>     <emulator>/usr/bin/qemu-system-x86_64</emulator>
>     <disk type='file' device='disk'>
>       <driver name='qemu' type='qcow2'/>
>       <source file='/var/lib/libvirt/images/4.7-rc2_client.qcow2'/>
>       <target dev='vda' bus='virtio'/>
>       <boot order='1'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x07'
> function='0x0'/>
>     </disk>
>     <disk type='network' device='disk'>
>       <driver name='qemu' type='raw'/>
>       <source protocol='iscsi' name='iqn.2001-04.com.client-tgt-1/0'>
>         <host name='192.168.64.75' port='3260'/>
>       </source>
>       <target dev='vdb' bus='virtio'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x06'
> function='0x0'/>

My wild guess is this disk's PCI addr is lower than the system disk. Can you
swap "slot='0x06'" with the previous "slot='0x07'" and try again?

(Stuck may be from an unfunctional MBR in the iscsi lun?)

Fam

>     </disk>
>     <controller type='pci' index='0' model='pci-root'/>
>     <controller type='usb' index='0' model='piix3-uhci'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
> function='0x2'/>
>     </controller>
>     <controller type='scsi' index='0'>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
> function='0x0'/>
>     </controller>
>     <interface type='bridge'>
>       <mac address='52:54:00:bf:6c:56'/>
>       <source bridge='br0'/>
>       <model type='virtio'/>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
> function='0x0'/>
>     </interface>
> 
> Thanks,
> Roy

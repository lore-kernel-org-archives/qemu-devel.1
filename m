Received: from eggs.gnu.org ([209.51.188.92]:33508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guFFI-0002cW-7F
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guFFG-0005xy-PX
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:32:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1guFFE-0005hn-He
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:31:58 -0500
Date: Thu, 14 Feb 2019 12:31:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190214123140.53d3cdf6@redhat.com>
In-Reply-To: <c6e1d704-e0da-215e-40c7-6db3daa66da1@linux.intel.com>
References: <49127da6-814d-4675-21a5-48a8aa764e34@linux.intel.com>
	<20190205164716.79b9cd08@Igors-MacBook-Pro.local>
	<c6e1d704-e0da-215e-40c7-6db3daa66da1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Issues] PCI hotplug does not work well on pc
 platform?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: yang.zhong@intel.com, qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Wed, 13 Feb 2019 15:40:57 +0800
"Liu, Jing2" <jing2.liu@linux.intel.com> wrote:

> Hi Igor,
> 
> Thanks for your reply!
> 
> On 2/5/2019 11:47 PM, Igor Mammedov wrote:
> > On Wed, 30 Jan 2019 21:02:10 +0800
> > "Liu, Jing2" <jing2.liu@linux.intel.com> wrote:
> >   
> >> Hi everyone,
> >>
> >> I have two questions.
> >> 1. PCI hotplug on pci.0 must manually rescan in guest. The ACPI hotplug
> >> handler sends the GPE event to guest but it seems guest doesn't receive
> >> it? I tried to open ACPI debug level/layer to 0xffffffff, in order to
> >> see if there is any message after device_add in monitor, but no message
> >> comes out until I manually rescan. Also tried printk in
> >> acpi_ev_gpe_xrupt_handler() and acpi_ev_sci_xrupt_handler(). No output
> >> in dmesg.
> >> (I'm sure that CONFIG_HOTPLUG_PCI_PCIE=y, CONFIG_HOTPLUG_PCI_CPCI=y,
> >> CONFIG_HOTPLUG_PCI=y, CONFIG_HOTPLUG_PCI_ACPI=y)
> >>
> >> Whether this is a kind of design or a known issue? Does guest receive
> >> the request, where can I find the  
> > does it work with known to work kernels (RHEL7)?
> > 
> > Also sharing used QEMU version and command line could help.
> >   
> Is there any key config of kernel in guest, besides those I listed above?
Maybe Marcel knows something about it
(CCed)

> 
> I used guest kernel v4.18 and qemu upstream v3.1.0
> Command line:
> sudo /home/xxx/qemu/x86_64-softmmu/qemu-system-x86_64  \
> -machine pc,accel=kvm,kernel_irqchip -cpu host -m 1G,slots=2,maxmem=10G \
> -nographic -no-user-config -nodefaults -vga none \
> -drive file=/home/xxx/image/clear-24690-kvm.img,if=virtio,format=raw \
>   -smp sockets=1,cpus=4,cores=2,maxcpus=8 \
> -device virtio-serial-pci,id=virtio-serial0,disable-modern,addr=0x5 \
> -monitor tcp:0.0.0.0:5000,nowait,server \
> -chardev stdio,id=charconsole0 -device 
> virtconsole,chardev=charconsole0,id=console0  \
> -kernel /home/xxx/linux-stable/arch/x86/boot/bzImage \
> -append 'root=/dev/vda3 rw rootfstype=ext4 data=ordered 
> rcupdate.rcu_expedited=1 pci=lastbus=0 pci=realloc=on tsc=reliable 
> no_timer_check reboot=t noapictimer console=hvc0 iommu=off  panic=1 
> initcall_debug acpi.debug_layer=0x40000 acpi.debug_level=4 ' \
> -device pci-bridge,bus=pci.0,id=br1,chassis_nr=1,shpc=on,addr=6  \
> 
> >>
> >> 2. I want to try hotplugging on pci-bridge on pc platform, using shpc. I
> >> set shpc=on, but when I do device_add, qemu still calls
> >> acpi_pcihp_device_plug_cb? Why it does not call pci_bridge_dev_hotplug_cb?
> >> (CONFIG_HOTPLUG_PCI_SHPC=y)  
> > 
> > try to disable ACPI hotplug for bridges
> >   -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
> >   
> I'll try it!
> 
> Thanks!
> Jing
> >   
> 

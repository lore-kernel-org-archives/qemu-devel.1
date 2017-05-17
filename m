Received: from eggs.gnu.org ([2001:4830:134:3::10]:49075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAoBl-0006Mi-07
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAoBh-0007Q4-1a
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:55:45 -0400
Date: Wed, 17 May 2017 09:55:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170517015530.GD27669@lemon.lan>
References: <20170516072414.19025-1-famz@redhat.com>
	<20170516080737.GB27669@lemon.lan>
	<e780d3d8-43f1-f46d-2858-7554a334246b@redhat.com>
	<20170516122528.GC27669@lemon.lan>
	<3799c1f5-5b22-fe05-4c98-4cd76c716551@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3799c1f5-5b22-fe05-4c98-4cd76c716551@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio: Move memory_listener_unregister
 to .unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, 05/16 14:44, Paolo Bonzini wrote:
> 
> 
> On 16/05/2017 14:25, Fam Zheng wrote:
> > You are right. Having had another look, I think it's because of this:
> > VirtIODevice is an embeded member of VirtIOSCSIPCI therefore it is never
> > "finalized" through QOM reference directly.  Am I right?
> 
> What I would expect is:
> 
> virtio_instance_init_common:
> - create the VirtIODevice with refcount 1
> - create a child property for the VirtIODevice (refcount is now 2)
> - unref the VirtIODevice (refcount is again 1)
> 
> virtio_pci_realize:
> - virtio_pci_bus_new creates the virtio bus
> - the virtio bus is added as a child property
> 
> virtio_scsi_pci_realize:
> - qdev_set_parent_bus links the device to the bus (bus and VirtIODevice
> refcounts are now 3)
> - the VirtIODevice is realized
> 
> ...
> at hot-unplug time:
> - the device is unrealized
> - the bus is unparented (calling bus_unparent)
>   - the device is unparented (calling device_unparent)
>     - bus_remove_child is called (bus and VirtIODevice refcounts are now 1)
>     - the VirtIODevice child property is deleted by object_unparent and
> the VirtIODevice is finalized
>   - the bus child property is deleted by object_unparent and the
> VirtIODevice is finalized

Sorry I don't understand. From my debugging, VirtIODevice is not finalized,
because it is embeded as VirtIOSCSIPCI.vdev.parent_obj.parent_obj, in non-zero
offset.

As I understand it, it's the VirtIOSCSIPCI instance that is being finalized, but
not VirtIODevice. Because the object_unparent is actually called on the
containing object:

Thread 4 "qemu-system-x86" hit Breakpoint 1, device_unparent (obj=0x559449824f40) at /stor/work/qemu/hw/core/qdev.c:1078
1078	    DeviceState *dev = DEVICE(obj);
(gdb) bt
#0  0x00005594455f11df in device_unparent (obj=0x559449824f40) at /stor/work/qemu/hw/core/qdev.c:1078
#1  0x00005594457be582 in object_finalize_child_property (obj=0x559447f0d320, name=0x5594498306e0 "scsi1", opaque=0x559449824f40) at /stor/work/qemu/qom/object.c:1369
#2  0x00005594457bc34a in object_property_del_child (obj=0x559447f0d320, child=0x559449824f40, errp=0x0) at /stor/work/qemu/qom/object.c:428
#3  0x00005594457bc42a in object_unparent (obj=0x559449824f40) at /stor/work/qemu/qom/object.c:447
#4  0x00005594455acf19 in acpi_pcihp_eject_slot (s=0x55944967c440, bsel=0, slots=16) at /stor/work/qemu/hw/acpi/pcihp.c:138
#5  0x00005594455ad542 in pci_write (opaque=0x55944967c440, addr=8, data=16, size=4) at /stor/work/qemu/hw/acpi/pcihp.c:272
#6  0x0000559445437667 in memory_region_write_accessor (mr=0x55944967d050, addr=8, value=0x7fdfa7569838, size=4, shift=0, mask=4294967295, attrs=...)
    at /stor/work/qemu/memory.c:526
#7  0x000055944543787f in access_with_adjusted_size (addr=8, value=0x7fdfa7569838, size=4, access_size_min=1, access_size_max=4, access=
    0x55944543757d <memory_region_write_accessor>, mr=0x55944967d050, attrs=...) at /stor/work/qemu/memory.c:592
#8  0x0000559445439fdb in memory_region_dispatch_write (mr=0x55944967d050, addr=8, data=16, size=4, attrs=...) at /stor/work/qemu/memory.c:1319
#9  0x00005594453dfa77 in address_space_write_continue (as=0x559445f1fce0 <address_space_io>, addr=44552, attrs=..., buf=0x7fdfb77d2000 "\020", len=4, addr1=8, l=4, mr=0x55944967d050) at /stor/work/qemu/exec.c:2822
#10 0x00005594453dfc31 in address_space_write (as=0x559445f1fce0 <address_space_io>, addr=44552, attrs=..., buf=0x7fdfb77d2000 "\020", len=4) at /stor/work/qemu/exec.c:2879
#11 0x00005594453dffbd in address_space_rw (as=0x559445f1fce0 <address_space_io>, addr=44552, attrs=..., buf=0x7fdfb77d2000 "\020", len=4, is_write=true)
    at /stor/work/qemu/exec.c:2981
#12 0x0000559445433797 in kvm_handle_io (port=44552, attrs=..., data=0x7fdfb77d2000, direction=1, size=4, count=1) at /stor/work/qemu/kvm-all.c:1803
#13 0x0000559445433e87 in kvm_cpu_exec (cpu=0x559447f0d560) at /stor/work/qemu/kvm-all.c:2032
#14 0x0000559445419cc6 in qemu_kvm_cpu_thread_fn (arg=0x559447f0d560) at /stor/work/qemu/cpus.c:1118
#15 0x00007fdfb56ba6ca in start_thread () at /lib64/libpthread.so.0
#16 0x00007fdfb1382f7f in clone () at /lib64/libc.so.6
(gdb) p *obj.class.type
$1 = {name = 0x559447e57a20 "virtio-scsi-pci", class_size = 280, instance_size = 34688, class_init = 0x55944573573e <virtio_scsi_pci_class_init>, class_base_init = 0x0, 
  class_finalize = 0x0, class_data = 0x0, instance_init = 0x559445735837 <virtio_scsi_pci_instance_init>, instance_post_init = 0x0, instance_finalize = 0x0, 
  abstract = false, parent = 0x559447e57a40 "virtio-pci", parent_type = 0x559447e57520, class = 0x559447e7add0, num_interfaces = 0, interfaces = {{
      typename = 0x0} <repeats 32 times>}}

Am I missing something?

Fam

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fuIeq-0001eQ-E3
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fuISF-0007pk-To
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:25:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fuISF-0007oW-Lq
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:25:19 -0400
Date: Mon, 27 Aug 2018 16:25:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180827162512.14fff54b@redhat.com>
In-Reply-To: <20180827160239.54cc993a@bahia.lan>
References: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
	<20180827160239.54cc993a@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that guest isn't able to
 unplug the first cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, david@redhat.com, cohuck@redhat.com

On Mon, 27 Aug 2018 16:02:39 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 27 Aug 2018 13:07:10 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > The first cpu unplug wasn't ever supported and corresponding
> > monitor/qmp commands refuse to unplug it. However guest is able
> > to issue eject request either using following command:
> >   # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject  
> 
> I can't reproduce the issue with a pc guest and current master...
> 
> All I seem to get is an error in dmesg:
> 
> [   97.435446] processor cpu0: Offline failed.

To be able to unplug CPU0 one need to set CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
(I've tested it with a RHLE7 kernel)
 
> > or directly writing to cpu hotplug registers, which makes
> > qemu crash with SIGSEGV following back trace:
> > 
> >    kvm_flush_coalesced_mmio_buffer ()
> >        while (ring->first != ring->last)
> >    ...
> >    qemu_flush_coalesced_mmio_buffer
> >    prepare_mmio_access
> >    flatview_read_continue
> >    flatview_read
> >    address_space_read_full
> >    address_space_rw
> >    kvm_cpu_exec(cpu!0)
> >    qemu_kvm_cpu_thread_fn
> > 
> > the reason for which is that ring == KVMState::coalesced_mmio_ring
> > happens to be a part of 1st CPU that was uplugged by guest.
> > 
> > Fix it by forbidding 1st cpu unplug from guest side and in addition
> > remove CPU0._EJ0 ACPI method to make clear that unplug of the first
> > CPU is not supported.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CCing spapr and s390x folks in case targets need to prevent 1st CPU unplug as well
> >   
> 
> A spapr guest can _release_ the first cpu by doing something like:
> 
> # echo -n "/cpus/PowerPC,POWER8@0" > /sys/devices/system/cpu/release
> 
> But AFAIK, this doesn't unplug the cpu from a QEMU standpoint.
Good,
so only x86 fix should be fixed.


> > CC: mst@redhat.com
> > CC: pbonzini@redhat.com
> > CC: david@gibson.dropbear.id.au
> > CC: groug@kaod.org
> > CC: david@redhat.com
> > CC: cohuck@redhat.com
> > ---
> >  hw/acpi/cpu.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > index 5ae595e..4bb8371 100644
> > --- a/hw/acpi/cpu.c
> > +++ b/hw/acpi/cpu.c
> > @@ -117,7 +117,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
> >              DeviceState *dev = NULL;
> >              HotplugHandler *hotplug_ctrl = NULL;
> >  
> > -            if (!cdev->cpu) {
> > +            if (!cdev->cpu || cdev->cpu == first_cpu) {
> >                  trace_cpuhp_acpi_ejecting_invalid_cpu(cpu_st->selector);
> >                  break;
> >              }
> > @@ -541,9 +541,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> >                  aml_buffer(madt_buf->len, (uint8_t *)madt_buf->data)));
> >              g_array_free(madt_buf, true);
> >  
> > -            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> > -            aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
> > -            aml_append(dev, method);
> > +            if (CPU(arch_ids->cpus[i].cpu) != first_cpu) {
> > +                method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> > +                aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
> > +                aml_append(dev, method);
> > +            }
> >  
> >              method = aml_method("_OST", 3, AML_SERIALIZED);
> >              aml_append(method,  
> 

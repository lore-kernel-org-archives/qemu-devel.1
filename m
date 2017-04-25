Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d31d4-0003Oc-VE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d31d3-0000RJ-Rz
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:39:47 -0400
Date: Tue, 25 Apr 2017 16:39:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170425163931.396bfbe1@Igors-MacBook-Pro.local>
In-Reply-To: <20170425140926.jufnkmtjgnzdxjos@kamzik.brq.redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-3-git-send-email-imammedo@redhat.com>
	<20170425140926.jufnkmtjgnzdxjos@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 02/23] hw/arm/virt: extract
 mp-affinity calculation in separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 25 Apr 2017 16:09:26 +0200
Andrew Jones <drjones@redhat.com> wrote:

> On Wed, Mar 22, 2017 at 02:32:27PM +0100, Igor Mammedov wrote:
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/arm/virt.c | 59 ++++++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 5f62a03..484754e 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1194,6 +1194,45 @@ void virt_machine_done(Notifier *notifier, void *data)
> >      virt_build_smbios(vms);
> >  }
> >  
> > +static uint64_t virt_idx2mp_affinity(VirtMachineState *vms, int idx)
> 
> I think I'd prefer virt_cpu_mp_affinity, or anything without a '2' in it
> for the name.
I'll fix it in v2

> 
> > +{
> > +    uint64_t mp_affinity;
> > +    uint8_t clustersz;
> > +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> > +
> > +    if (!vmc->disallow_affinity_adjustment) {
> > +        uint8_t aff0, aff1;
> 
> The else part also needs aff0, aff1; might as well move them up.
sure

> 
> > +
> > +        if (vms->gic_version == 3) {
> > +            clustersz = GICV3_TARGETLIST_BITS;
> > +        } else {
> > +            clustersz = GIC_TARGETLIST_BITS;
> > +        }
> > +
> > +        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> > +         * GIC's target-list limitations. 32-bit KVM hosts currently
> > +         * always create clusters of 4 CPUs, but that is expected to
> > +         * change when they gain support for gicv3. When KVM is enabled
> > +         * it will override the changes we make here, therefore our
> > +         * purposes are to make TCG consistent (with 64-bit KVM hosts)
> > +         * and to improve SGI efficiency.
> > +         */
> > +        aff1 = idx / clustersz;
> > +        aff0 = idx % clustersz;
> > +        mp_affinity = (aff1 << ARM_AFF1_SHIFT) | aff0;
> > +    } else {
> > +        /* This cpu-id-to-MPIDR affinity is used only for TCG;
> > +         * KVM will override it. We don't support setting cluster ID
> > +         * ([16..23]) (known as Aff2 in later ARM ARM versions), or any of
> > +         * the higher affinity level fields, so these bits always RAZ.
> > +         */
> > +        uint32_t Aff1 = idx / ARM_DEFAULT_CPUS_PER_CLUSTER;
> > +        uint32_t Aff0 = idx % ARM_DEFAULT_CPUS_PER_CLUSTER;
> > +        mp_affinity = (Aff1 << ARM_AFF1_SHIFT) | Aff0;
> > +    }
> 
> Maybe we should create an ARM CPU function
> 
>  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
>  {
>    uint32_t Aff1 = idx / clustersz;
>    uint32_t Aff0 = idx % clustersz;
>    return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
>  }
I'll add and use it in v2

> which we'd use in arm_cpu_realizefn() and here
> 
>  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>  {
>    if (VIRT_MACHINE_GET_CLASS(vms)->disallow_affinity_adjustment) {
>       return arm_cpu_mp_affinity(idx, ARM_DEFAULT_CPUS_PER_CLUSTER);
>    }
> 
>    /* ...big comment... */
>    return arm_cpu_mp_affinity(idx, vms->gic_version == 3 ?
>                           GICV3_TARGETLIST_BITS : GIC_TARGETLIST_BITS);
>  }
> 
> > +    return mp_affinity;
> > +}
> > +
> >  static void machvirt_init(MachineState *machine)
> >  {
> >      VirtMachineState *vms = VIRT_MACHINE(machine);
> > @@ -1210,7 +1249,6 @@ static void machvirt_init(MachineState *machine)
> >      CPUClass *cc;
> >      Error *err = NULL;
> >      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> > -    uint8_t clustersz;
> >  
> >      if (!cpu_model) {
> >          cpu_model = "cortex-a15";
> > @@ -1263,10 +1301,8 @@ static void machvirt_init(MachineState *machine)
> >       */
> >      if (vms->gic_version == 3) {
> >          virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
> > -        clustersz = GICV3_TARGETLIST_BITS;
> >      } else {
> >          virt_max_cpus = GIC_NCPU;
> > -        clustersz = GIC_TARGETLIST_BITS;
> >      }
> >  
> >      if (max_cpus > virt_max_cpus) {
> > @@ -1326,20 +1362,9 @@ static void machvirt_init(MachineState *machine)
> >  
> >      for (n = 0; n < smp_cpus; n++) {
> >          Object *cpuobj = object_new(typename);
> > -        if (!vmc->disallow_affinity_adjustment) {
> > -            /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> > -             * GIC's target-list limitations. 32-bit KVM hosts currently
> > -             * always create clusters of 4 CPUs, but that is expected to
> > -             * change when they gain support for gicv3. When KVM is enabled
> > -             * it will override the changes we make here, therefore our
> > -             * purposes are to make TCG consistent (with 64-bit KVM hosts)
> > -             * and to improve SGI efficiency.
> > -             */
> > -            uint8_t aff1 = n / clustersz;
> > -            uint8_t aff0 = n % clustersz;
> > -            object_property_set_int(cpuobj, (aff1 << ARM_AFF1_SHIFT) | aff0,
> > -                                    "mp-affinity", NULL);
> > -        }
> > +
> > +        object_property_set_int(cpuobj, virt_idx2mp_affinity(vms, n),
> > +                                "mp-affinity", NULL);
> >  
> >          if (!vms->secure) {
> >              object_property_set_bool(cpuobj, false, "has_el3", NULL);
> > -- 
> > 2.7.4
> > 
> >
> 
> Thanks,
> drew 

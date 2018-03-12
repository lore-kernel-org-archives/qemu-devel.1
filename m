Received: from eggs.gnu.org ([2001:4830:134:3::10]:47523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evOxY-00043v-RQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evOxS-0001yA-Pc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:01:56 -0400
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-15-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-d_nL7Bw5FWwSEviGJwWijqYo3a8o_oPwBy2-Aw9U4zg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <422530b3-44b4-5d47-fb70-1f5693569925@redhat.com>
Date: Mon, 12 Mar 2018 16:01:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-d_nL7Bw5FWwSEviGJwWijqYo3a8o_oPwBy2-Aw9U4zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 14/14] hw/arm/virt: Handle iommu in 2.12
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

Hi Peter,

On 12/03/18 13:56, Peter Maydell wrote:
> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>> The new machine type exposes a new "iommu" virt machine option.
>> The SMMUv3 IOMMU is instantiated using -machine virt,iommu=smmuv3.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v7 -> v8:
>> - Revert to machine option, now dubbed "iommu", preparing for virtio
>>   instantiation.
>>
>> v5 -> v6: machine 2_11
>>
>> Another alternative would be to use the -device option as
>> done on x86. As the smmu is a sysbus device, we would need to
>> use the platform bus framework.
>> ---
>>  hw/arm/virt.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/arm/virt.h |  1 +
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index e9dca0d..607c7e1 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1547,6 +1547,34 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
>>      }
>>  }
>>
>> +static char *virt_get_iommu(Object *obj, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    switch (vms->iommu) {
>> +    case VIRT_IOMMU_NONE:
>> +        return g_strdup("none");
>> +    case VIRT_IOMMU_SMMUV3:
>> +        return g_strdup("smmuv3");
>> +    default:
>> +        return g_strdup("none");
> 
> Isn't this a "can't happen" case? If so, g_assert_not_reached().
yes, done
> 
>> +    }
>> +}
>> +
>> +static void virt_set_iommu(Object *obj, const char *value, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    if (!strcmp(value, "smmuv3")) {
>> +        vms->iommu = VIRT_IOMMU_SMMUV3;
>> +    } else if (!strcmp(value, "none")) {
>> +        vms->iommu = VIRT_IOMMU_NONE;
>> +    } else {
>> +        error_setg(errp, "Invalid iommu value");
>> +        error_append_hint(errp, "Valid value are none, smmuv3\n");
> 
> "Valid values are", and add trailing "." to the hint string (matches
> virt_set_gic_version() phrasing.)
OK
> 
>> +    }
>> +}
>> +
>>  static CpuInstanceProperties
>>  virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>>  {
>> @@ -1679,6 +1707,19 @@ static void virt_2_12_instance_init(Object *obj)
>>                                          NULL);
>>      }
>>
>> +    if (vmc->no_iommu) {
>> +        vms->iommu = VIRT_IOMMU_NONE;
>> +    } else {
>> +        /* Default disallows smmu instantiation */
>> +        vms->iommu = VIRT_IOMMU_NONE;
> 
> If the default is "none" then you don't need the no_iommu field
> in the VirtMachineClass. You can just have the property exist
> on all virt machines, the way we do for "secure" and "virtualization".
> It's only if we want to have the default for newer virt-n.nn versions
> be something other than what the older machines had that we need to
> have the VirtMachineClass field that lets us distinguish the older
> and newer machine types.
OK

Thanks

Eric
> 
>> +        object_property_add_str(obj, "iommu", virt_get_iommu,
>> +                                 virt_set_iommu, NULL);
>> +        object_property_set_description(obj, "iommu",
>> +                                        "Set the IOMMU model among "
>> +                                        "none, smmuv3 (default none)",
>> +                                        NULL);
>> +    }
>> +
>>      vms->memmap = a15memmap;
>>      vms->irqmap = a15irqmap;
>>  }
>> @@ -1698,8 +1739,12 @@ static void virt_2_11_instance_init(Object *obj)
>>
>>  static void virt_machine_2_11_options(MachineClass *mc)
>>  {
>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>> +
>>      virt_machine_2_12_options(mc);
>>      SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
>> +
>> +    vmc->no_iommu = true;
>>  }
>>  DEFINE_VIRT_MACHINE(2, 11)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 13d3724..3a92fc3 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -92,6 +92,7 @@ typedef struct {
>>      bool disallow_affinity_adjustment;
>>      bool no_its;
>>      bool no_pmu;
>> +    bool no_iommu;
>>      bool claim_edge_triggered_timers;
>>  } VirtMachineClass;
>>
>> --
>> 2.5.5
>>
> 
> thanks
> -- PMM
> 

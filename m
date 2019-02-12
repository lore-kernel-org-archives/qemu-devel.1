Received: from eggs.gnu.org ([209.51.188.92]:57492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtU9p-0004BJ-TN
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtTzq-00008R-47
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:04:55 -0500
References: <20190212011657.18324-1-walling@linux.ibm.com>
	<20190212011657.18324-2-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d9b74b0d-83f3-f7f1-3912-25739a931f41@redhat.com>
Date: Tue, 12 Feb 2019 10:04:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190212011657.18324-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390x/cpumodel: default enable
 mepoch for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, rth@twiddle.net

On 12.02.19 02:16, Collin Walling wrote:
> Latest systems and host kernels support mepoch, which is a
> feature that was meant to be supported for z14 GA1 from the
> get-go. Let's copy it to the z14 GA1 default CPU model.
> 
> Machines s390-ccw-virtio-3.1 and older will retain the old CPU
> models and will not provide this bit nor the extended PTFF
> functions in the default model.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
> @Christian, @David: I elected to not add your r-b's to this
> patch since I've added some code to disable feature groups.
> I'd like to know what you both think :)

Looks good to me!

Reviewed-by: David Hildenbrand <david@redhat.com>

> ---
>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>  target/s390x/cpu_models.c   | 24 ++++++++++++++++++++++++
>  target/s390x/cpu_models.h   |  2 ++
>  target/s390x/gen-features.c |  2 ++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fd9d0b0542..643265f0b4 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -757,6 +757,8 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
>  static void ccw_machine_3_1_instance_options(MachineState *machine)
>  {
>      ccw_machine_4_0_instance_options(machine);
> +    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
> +    s390_cpudef_group_featoff_greater(14, 1, S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF);
>  }
>  
>  static void ccw_machine_3_1_class_options(MachineClass *mc)
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index b42b5fd327..d75a20e49d 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -117,6 +117,30 @@ void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat)
>      }
>  }
>  
> +void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
> +                                       S390FeatGroup group)
> +{
> +    const S390FeatGroupDef *group_def = s390_feat_group_def(group);
> +    S390FeatBitmap group_def_off;
> +    int i;
> +
> +    bitmap_complement(group_def_off, group_def->feat, S390_FEAT_MAX);
> +
> +    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
> +        const S390CPUDef *cpu_def = &s390_cpu_defs[i];
> +
> +        if (cpu_def->gen < gen) {
> +            continue;
> +        }
> +        if (cpu_def->gen == gen && cpu_def->ec_ga < ec_ga) {
> +            continue;
> +        }
> +
> +        bitmap_and((unsigned long *)&cpu_def->default_feat,
> +                   cpu_def->default_feat, group_def_off, S390_FEAT_MAX);
> +    }
> +}
> +
>  uint32_t s390_get_hmfai(void)
>  {
>      static S390CPU *cpu;
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index 11cf5386fb..174a99e561 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -75,6 +75,8 @@ struct S390CPUModel {
>  
>  void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
>  void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat);
> +void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
> +                                       S390FeatGroup group);
>  uint32_t s390_get_hmfai(void);
>  uint8_t s390_get_mha_pow(void);
>  uint32_t s390_get_ibc_val(void);
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 70015eaaf5..4770f00105 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -550,6 +550,8 @@ static uint16_t default_GEN14_GA1[] = {
>      S390_FEAT_GROUP_MSA_EXT_6,
>      S390_FEAT_GROUP_MSA_EXT_7,
>      S390_FEAT_GROUP_MSA_EXT_8,
> +    S390_FEAT_MULTIPLE_EPOCH,
> +    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>  };
>  
>  /* QEMU (CPU model) features */
> 


-- 

Thanks,

David / dhildenb

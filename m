Received: from eggs.gnu.org ([209.51.188.92]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3R6-0006df-MV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3Mu-0006rF-Qj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:18:41 -0400
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-9-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <87f1441f-f081-e693-065c-b930fba588da@redhat.com>
Date: Mon, 29 Apr 2019 12:18:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190429090250.7648-9-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/9] s390x/cpumodel: add gen15 defintions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 29.04.19 11:02, Christian Borntraeger wrote:
> add several new features (msa9, sort, deflate, additional vector
> instructions, new general purpose instructions) to generation 15.
> 
> Also disable csske and bpb from the default and base models >=15.
> This will allow to migrate gen15 machines to future machines that
> do not have these features.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/gen-features.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 8fc2e8e72f..c346b76bdf 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -13,6 +13,7 @@
>  
>  #include <inttypes.h>
>  #include <stdio.h>
> +#include <string.h>
>  #include "cpu_features_def.h"
>  
>  #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
> @@ -419,6 +420,10 @@ static uint16_t base_GEN14_GA1[] = {
>  
>  #define base_GEN14_GA2 EmptyFeat
>  
> +static uint16_t base_GEN15_GA1[] = {
> +    S390_FEAT_MISC_INSTRUCTION_EXT3,
> +};
> +
>  /* Full features (in order of release)
>   * Automatically includes corresponding base features.
>   * Full features are all features this hardware supports even if kvm/QEMU do not
> @@ -548,6 +553,16 @@ static uint16_t full_GEN14_GA1[] = {
>  
>  #define full_GEN14_GA2 EmptyFeat
>  
> +static uint16_t full_GEN15_GA1[] = {
> +    S390_FEAT_VECTOR_ENH2,
> +    S390_FEAT_GROUP_ENH_SORT,
> +    S390_FEAT_GROUP_DEFLATE_CONVERSION,
> +    S390_FEAT_VECTOR_BCD_ENH,
> +    S390_FEAT_GROUP_MSA_EXT_9,
> +    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
> +    S390_FEAT_ETOKEN,
> +};
> +
>  /* Default features (in order of release)
>   * Automatically includes corresponding base features.
>   * Default features are all features this version of QEMU supports for this
> @@ -624,6 +639,16 @@ static uint16_t default_GEN14_GA1[] = {
>  
>  #define default_GEN14_GA2 EmptyFeat
>  
> +static uint16_t default_GEN15_GA1[] = {
> +    S390_FEAT_VECTOR_ENH2,
> +    S390_FEAT_GROUP_ENH_SORT,
> +    S390_FEAT_GROUP_DEFLATE_CONVERSION,
> +    S390_FEAT_VECTOR_BCD_ENH,
> +    S390_FEAT_GROUP_MSA_EXT_9,
> +    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
> +    S390_FEAT_ETOKEN,
> +};
> +
>  /* QEMU (CPU model) features */
>  
>  static uint16_t qemu_V2_11[] = {
> @@ -740,6 +765,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
>      CPU_FEAT_INITIALIZER(GEN13_GA2),
>      CPU_FEAT_INITIALIZER(GEN14_GA1),
>      CPU_FEAT_INITIALIZER(GEN14_GA2),
> +    CPU_FEAT_INITIALIZER(GEN15_GA1),
>  };
>  
>  #define FEAT_GROUP_INITIALIZER(_name)                  \
> @@ -808,6 +834,11 @@ static void set_bits(uint64_t list[], BitSpec bits)
>      }
>  }
>  
> +static inline void clear_bit(uint64_t list[], unsigned long nr)
> +{
> +    list[nr / 64] &= ~(1ULL << (nr % 64));
> +}
> +
>  static void print_feature_defs(void)
>  {
>      uint64_t base_feat[S390_FEAT_MAX / 64 + 1] = {};
> @@ -818,6 +849,12 @@ static void print_feature_defs(void)
>      printf("\n/* CPU model feature list data */\n");
>  
>      for (i = 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
> +        /* With gen15 CSSKE and BPB are deprecated */
> +        if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") == 0) {
> +            clear_bit(base_feat, S390_FEAT_CONDITIONAL_SSKE);
> +            clear_bit(default_feat, S390_FEAT_CONDITIONAL_SSKE);
> +            clear_bit(default_feat, S390_FEAT_BPB);
> +        }
>          set_bits(base_feat, CpuFeatDef[i].base_bits);
>          /* add the base to the default features */
>          set_bits(default_feat, CpuFeatDef[i].base_bits);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

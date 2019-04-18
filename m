Received: from eggs.gnu.org ([209.51.188.92]:52767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH7bX-0003MM-RU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH7bS-0002cG-26
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:01:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH7bR-0002bh-TP
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:01:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IDk347183780
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 10:01:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rxqyt7pja-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 10:01:21 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 15:01:18 +0100
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
	<295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 16:01:14 +0200
MIME-Version: 1.0
In-Reply-To: <295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ce51ef6e-b37f-1c4f-f2f2-70f0e999ee6a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] s390x/cpumodel: remove CSSKE from
 base model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>



On 18.04.19 14:45, David Hildenbrand wrote:
> On 18.04.19 13:31, Christian Borntraeger wrote:
>> conditional sske is deprecated and a distant future machine (will be one
>> where the IBC will not allow to fully go back to z14) will remove this
>> feature. To prepare for this and allow for the z14 and older cpu model
>> to still run on systems without csske, remove csske from the base (and
> 
> will csske feature be a default feature for zNext? Or is it not
> available *at all*.
> 
> In case it is not available, baselining and cpu model comparison have to
> be thought about "ignoring csske".
> 
>> thus the default models for z10..z14). For compat machines we have to
>> add those back.
> 
> Base models are machine-independent. That means, changing base models is
> not supported. Once we introduce new models like here, we can set the
> new base models into stone.
> 
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>>  target/s390x/cpu_models.c   | 21 +++++++++++++++++++++
>>  target/s390x/cpu_models.h   |  1 +
>>  target/s390x/gen-features.c |  1 -
>>  4 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index d11069b860..3415948b2c 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -648,6 +648,8 @@ bool css_migration_enabled(void)
>>  
>>  static void ccw_machine_4_0_instance_options(MachineState *machine)
>>  {
>> +    /* re-enable csske for compat machines in the base model */
>> +    s390_cpumodel_fixup_csske();
>>  }
>>  
>>  static void ccw_machine_4_0_class_options(MachineClass *mc)
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index eb125d4d0d..4e5aa879f3 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -93,6 +93,27 @@ static S390FeatBitmap qemu_max_cpu_feat;
>>  /* features part of a base model but not relevant for finding a base model */
>>  S390FeatBitmap ignored_base_feat;
>>  
>> +/*
>> + * We removed CSSKE from the base features. This is a hook for compat machines
>> + * to put this back for gen10..gen14. As the base model is also part of the
>> + * default model to have to fixup both bitfields
>> + */
>> +void s390_cpumodel_fixup_csske(void)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
>> +        const S390CPUDef *def = &s390_cpu_defs[i];
>> +
>> +        if (def->gen < 10 || def->gen > 14) {
>> +            continue;
>> +        }
>> +
>> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->base_feat);
>> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->default_feat);
>> +    }
>> +}
> 
> I think that can be avoided by smarter generation of the models, which I
> would prefer.
> 

Very rough, but something like this (I have to find a nice way to use the qemu
clear_bit).

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 15cd9836c4..21c786127a 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -13,6 +13,7 @@
 
 #include <inttypes.h>
 #include <stdio.h>
+#include <string.h>
 #include "cpu_features_def.h"
 
 #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
@@ -833,6 +834,16 @@ static void set_bits(uint64_t list[], BitSpec bits)
     }
 }
 
+#define BIT_MASK(nr)            (1UL << ((nr) % 64))
+#define BIT_WORD(nr)            ((nr) / 64)
+static inline void clear_bit(long nr, uint64_t *addr)
+{
+    unsigned long mask = BIT_MASK(nr);
+    unsigned long *p = addr + BIT_WORD(nr);
+
+    *p &= ~mask;
+}
+
 static void print_feature_defs(void)
 {
     uint64_t base_feat[S390_FEAT_MAX / 64 + 1] = {};
@@ -843,6 +854,11 @@ static void print_feature_defs(void)
     printf("\n/* CPU model feature list data */\n");
 
     for (i = 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
+       /* With gen15 CSSKE is deprecated */
+       if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") == 0) {
+               clear_bit(S390_FEAT_CONDITIONAL_SSKE, base_feat);
+               clear_bit(S390_FEAT_CONDITIONAL_SSKE, default_feat);
+       }
         set_bits(base_feat, CpuFeatDef[i].base_bits);
         /* add the base to the default features */
         set_bits(default_feat, CpuFeatDef[i].base_bits);

Received: from eggs.gnu.org ([209.51.188.92]:36091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH8X3-0004kl-IO
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH8X1-00051v-Lu
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:00:56 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
	<295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
	<ce51ef6e-b37f-1c4f-f2f2-70f0e999ee6a@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8e51d90a-db6b-a8a5-a08d-d2a868c44fd2@redhat.com>
Date: Thu, 18 Apr 2019 17:00:47 +0200
MIME-Version: 1.0
In-Reply-To: <ce51ef6e-b37f-1c4f-f2f2-70f0e999ee6a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 18.04.19 16:01, Christian Borntraeger wrote:
>=20
>=20
> On 18.04.19 14:45, David Hildenbrand wrote:
>> On 18.04.19 13:31, Christian Borntraeger wrote:
>>> conditional sske is deprecated and a distant future machine (will be =
one
>>> where the IBC will not allow to fully go back to z14) will remove thi=
s
>>> feature. To prepare for this and allow for the z14 and older cpu mode=
l
>>> to still run on systems without csske, remove csske from the base (an=
d
>>
>> will csske feature be a default feature for zNext? Or is it not
>> available *at all*.
>>
>> In case it is not available, baselining and cpu model comparison have =
to
>> be thought about "ignoring csske".
>>
>>> thus the default models for z10..z14). For compat machines we have to
>>> add those back.
>>
>> Base models are machine-independent. That means, changing base models =
is
>> not supported. Once we introduce new models like here, we can set the
>> new base models into stone.
>>
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>>>  target/s390x/cpu_models.c   | 21 +++++++++++++++++++++
>>>  target/s390x/cpu_models.h   |  1 +
>>>  target/s390x/gen-features.c |  1 -
>>>  4 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index d11069b860..3415948b2c 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -648,6 +648,8 @@ bool css_migration_enabled(void)
>>> =20
>>>  static void ccw_machine_4_0_instance_options(MachineState *machine)
>>>  {
>>> +    /* re-enable csske for compat machines in the base model */
>>> +    s390_cpumodel_fixup_csske();
>>>  }
>>> =20
>>>  static void ccw_machine_4_0_class_options(MachineClass *mc)
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index eb125d4d0d..4e5aa879f3 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -93,6 +93,27 @@ static S390FeatBitmap qemu_max_cpu_feat;
>>>  /* features part of a base model but not relevant for finding a base=
 model */
>>>  S390FeatBitmap ignored_base_feat;
>>> =20
>>> +/*
>>> + * We removed CSSKE from the base features. This is a hook for compa=
t machines
>>> + * to put this back for gen10..gen14. As the base model is also part=
 of the
>>> + * default model to have to fixup both bitfields
>>> + */
>>> +void s390_cpumodel_fixup_csske(void)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i =3D 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
>>> +        const S390CPUDef *def =3D &s390_cpu_defs[i];
>>> +
>>> +        if (def->gen < 10 || def->gen > 14) {
>>> +            continue;
>>> +        }
>>> +
>>> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->b=
ase_feat);
>>> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->d=
efault_feat);
>>> +    }
>>> +}
>>
>> I think that can be avoided by smarter generation of the models, which=
 I
>> would prefer.
>>
>=20
> Very rough, but something like this (I have to find a nice way to use t=
he qemu
> clear_bit).

We work on uint64_t, not unsigned long, therefore using existing bitmap
operations would be theoretically wrong (and even make compilation more
complicated). Just use a custom helper.

>=20
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 15cd9836c4..21c786127a 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -13,6 +13,7 @@
> =20
>  #include <inttypes.h>
>  #include <stdio.h>
> +#include <string.h>
>  #include "cpu_features_def.h"
> =20
>  #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
> @@ -833,6 +834,16 @@ static void set_bits(uint64_t list[], BitSpec bits=
)
>      }
>  }
> =20
> +#define BIT_MASK(nr)            (1UL << ((nr) % 64))
> +#define BIT_WORD(nr)            ((nr) / 64)
> +static inline void clear_bit(long nr, uint64_t *addr)
> +{
> +    unsigned long mask =3D BIT_MASK(nr);
> +    unsigned long *p =3D addr + BIT_WORD(nr);
> +
> +    *p &=3D ~mask;
> +}
> +

Looking at set_bits(), clear_bit() could be as simple as

list[nr / 64] &=3D ~(1ULL << (nr % 64));

>  static void print_feature_defs(void)
>  {
>      uint64_t base_feat[S390_FEAT_MAX / 64 + 1] =3D {};
> @@ -843,6 +854,11 @@ static void print_feature_defs(void)
>      printf("\n/* CPU model feature list data */\n");
> =20
>      for (i =3D 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
> +       /* With gen15 CSSKE is deprecated */
> +       if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") =3D=3D=
 0) {
> +               clear_bit(S390_FEAT_CONDITIONAL_SSKE, base_feat);
> +               clear_bit(S390_FEAT_CONDITIONAL_SSKE, default_feat);
> +       }
>          set_bits(base_feat, CpuFeatDef[i].base_bits);
>          /* add the base to the default features */
>          set_bits(default_feat, CpuFeatDef[i].base_bits);
>=20

That's even better. We could also add clear_bits() with deprecation
lists, similar to set_bits.


--=20

Thanks,

David / dhildenb

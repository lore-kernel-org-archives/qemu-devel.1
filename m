Received: from eggs.gnu.org ([209.51.188.92]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6QW-0007IU-MA
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6QV-0000a5-G3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:46:04 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
Date: Thu, 18 Apr 2019 14:45:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-3-borntraeger@de.ibm.com>
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

On 18.04.19 13:31, Christian Borntraeger wrote:
> conditional sske is deprecated and a distant future machine (will be on=
e
> where the IBC will not allow to fully go back to z14) will remove this
> feature. To prepare for this and allow for the z14 and older cpu model
> to still run on systems without csske, remove csske from the base (and

will csske feature be a default feature for zNext? Or is it not
available *at all*.

In case it is not available, baselining and cpu model comparison have to
be thought about "ignoring csske".

> thus the default models for z10..z14). For compat machines we have to
> add those back.

Base models are machine-independent. That means, changing base models is
not supported. Once we introduce new models like here, we can set the
new base models into stone.

>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>  target/s390x/cpu_models.c   | 21 +++++++++++++++++++++
>  target/s390x/cpu_models.h   |  1 +
>  target/s390x/gen-features.c |  1 -
>  4 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d11069b860..3415948b2c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -648,6 +648,8 @@ bool css_migration_enabled(void)
> =20
>  static void ccw_machine_4_0_instance_options(MachineState *machine)
>  {
> +    /* re-enable csske for compat machines in the base model */
> +    s390_cpumodel_fixup_csske();
>  }
> =20
>  static void ccw_machine_4_0_class_options(MachineClass *mc)
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index eb125d4d0d..4e5aa879f3 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -93,6 +93,27 @@ static S390FeatBitmap qemu_max_cpu_feat;
>  /* features part of a base model but not relevant for finding a base m=
odel */
>  S390FeatBitmap ignored_base_feat;
> =20
> +/*
> + * We removed CSSKE from the base features. This is a hook for compat =
machines
> + * to put this back for gen10..gen14. As the base model is also part o=
f the
> + * default model to have to fixup both bitfields
> + */
> +void s390_cpumodel_fixup_csske(void)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
> +        const S390CPUDef *def =3D &s390_cpu_defs[i];
> +
> +        if (def->gen < 10 || def->gen > 14) {
> +            continue;
> +        }
> +
> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->bas=
e_feat);
> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->def=
ault_feat);
> +    }
> +}

I think that can be avoided by smarter generation of the models, which I
would prefer.

> +
>  void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
>  {
>      const S390CPUDef *def;
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index 174a99e561..b2e37bc8cf 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -73,6 +73,7 @@ struct S390CPUModel {
>  #define ibc_gen(x)        (x =3D=3D 0 ? 0 : ((x >> 4) + S390_GEN_Z10))
>  #define ibc_ec_ga(x)      (x & 0xf)
> =20
> +void s390_cpumodel_fixup_csske(void);
>  void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
>  void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat =
feat);
>  void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index e4739a6b9f..bea2f80c49 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -301,7 +301,6 @@ static uint16_t base_GEN9_GA1[] =3D {
>  #define base_GEN9_GA3 EmptyFeat
> =20
>  static uint16_t base_GEN10_GA1[] =3D {
> -    S390_FEAT_CONDITIONAL_SSKE,
>      S390_FEAT_PARSING_ENH,
>      S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
>      S390_FEAT_EXTRACT_CPU_TIME,
>=20

Instead of doing that, can we rather start generating the next
generation "fresh", listing all base model features it contains instead
of doing it incrementally? Could end up "nicer"


In target/s390x/cpu_models.c we have:

"... For now, base features of a following release are always a subset
of base features of the previous release. Same is correct for the other
feature sets."

This is especially relevant for "s390_find_cpu_def", and goes into the
direction of baselining, as previously mentioned.

Luckily, we already have "ignored_base_feat", maybe we can simply add
csske there and have it working.

--=20

Thanks,

David / dhildenb

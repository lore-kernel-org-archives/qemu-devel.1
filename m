Received: from eggs.gnu.org ([2001:4830:134:3::10]:49296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chwuo-0001uX-8z
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chwul-0002J9-3Z
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:22:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chwuk-0002IQ-RD
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 06:22:55 -0500
References: <20170225231653.14942-1-mmarek@suse.com>
	<20170225233845.25828-1-mmarek@suse.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
Date: Sun, 26 Feb 2017 12:22:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170225233845.25828-1-mmarek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Marek <mmarek@suse.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Eric Bischoff <ebischoff@suse.com>, Miroslav Benes <mbenes@suse.cz>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

On 26.02.2017 00:38, Michal Marek wrote:
> The implementation is partially cargo cult based, but it works for the
> linux kernel use case.
>=20
> Signed-off-by: Michal Marek <mmarek@suse.com>
> ---
> v3:
>  - Initialize the buffer in do_stfle()
> v2:
>  - STFLE is not a privileged instruction, go through the MMU to store t=
he
>    result
>  - annotate the stfl helper with TCG_CALL_NO_RWG
>  - Use a large enough buffer to hold the feature bitmap
>  - Fix coding style of the stfle helper
> ---
>  target/s390x/cpu_features.c |  6 ++++--
>  target/s390x/cpu_features.h |  2 +-
>  target/s390x/helper.h       |  2 ++
>  target/s390x/insn-data.def  |  2 ++
>  target/s390x/misc_helper.c  | 36 ++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c    | 17 +++++++++--------
>  6 files changed, 54 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 42fd9d792bc8..d77c560380c4 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -286,11 +286,11 @@ void s390_init_feat_bitmap(const S390FeatInit ini=
t, S390FeatBitmap bitmap)
>      }
>  }
> =20
> -void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType =
type,
> +int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType t=
ype,
>                            uint8_t *data)
>  {
>      S390Feat feat;
> -    int bit_nr;
> +    int bit_nr, res =3D 0;
> =20
>      if (type =3D=3D S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, f=
eatures)) {
>          /* z/Architecture is always active if around */
> @@ -303,9 +303,11 @@ void s390_fill_feat_block(const S390FeatBitmap fea=
tures, S390FeatType type,
>              bit_nr =3D s390_features[feat].bit;
>              /* big endian on uint8_t array */
>              data[bit_nr / 8] |=3D 0x80 >> (bit_nr % 8);
> +            res =3D MAX(res, bit_nr / 8 + 1);

Not sure whether the assumption is valid, but it seems like the bit
numbers are stored in ascending order in the s390_features array, so you
could theoretically also get along without the res variable and the MAX
calculation and just return the last bit_nr / 8 + 1 at the end.

>          }
>          feat =3D find_next_bit(features, S390_FEAT_MAX, feat + 1);
>      }
> +    return res;
>  }
[...]
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index c9604ea9c728..b51454ea7861 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -500,6 +500,42 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t=
 a0,
>      return cc;
>  }
> =20
> +static int do_stfle(CPUS390XState *env, uint64_t addr, int len)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    /* 256 doublewords as per STFLE documentation */
> +    uint8_t data[256 * 8] =3D { 0 };
> +    int i, res;
> +
> +    memset(data, 0, sizeof(data));

You've alread set data to 0 with the "=3D { 0 }" initializer, so the
memset() is redundant here (or you can remove the "=3D { 0 }" initializer
instead.

> +    res =3D s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_=
STFL, data);
> +    for (i =3D 0; i < MIN(res, len); i++) {
> +        cpu_stb_data(env, addr + i, data[i]);

Since we know that we're using 64-bit values here, why not using
cpu_stq_data instead? That should be faster.
I think you could even use s390_cpu_virt_mem_write() here to avoid the
loop completely.

> +    }
> +
> +    return res;
> +}
> +
> +uint64_t HELPER(stfle)(CPUS390XState *env, uint64_t a0, uint64_t r0)
> +{
> +    int need, len =3D r0 & 0xff;

According to the POP spec, the address "must be designated on a
doubleword boundary; otherwise, a specification exception is recognized."
Could you please add this check here (or in translate.c)?

> +    need =3D do_stfle(env, a0, len * 8);
> +    need =3D DIV_ROUND_UP(need, 8);
> +    if (need <=3D len) {
> +        env->cc_op =3D 0;
> +    } else {
> +        env->cc_op =3D 3;
> +    }
> +
> +    return (r0 & ~0xffLL) | (need - 1);
> +}
> +
> +void HELPER(stfl)(CPUS390XState *env)
> +{
> +    do_stfle(env, 200, 4);

It's maybe nicer to use offsetof(LowCore, stfl_fac_list) instead of the
magic value 200 here.

> +}
> +
>  uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_=
t r1,
>                        uint64_t cpu_addr)
>  {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 01c62176bf70..3a569d3cc0ad 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3628,15 +3628,16 @@ static ExitStatus op_spt(DisasContext *s, Disas=
Ops *o)
> =20
>  static ExitStatus op_stfl(DisasContext *s, DisasOps *o)
>  {
> -    TCGv_i64 f, a;
> -    /* We really ought to have more complete indication of facilities
> -       that we implement.  Address this when STFLE is implemented.  */
>      check_privileged(s);
> -    f =3D tcg_const_i64(0xc0000000);
> -    a =3D tcg_const_i64(200);
> -    tcg_gen_qemu_st32(f, a, get_mem_index(s));
> -    tcg_temp_free_i64(f);
> -    tcg_temp_free_i64(a);
> +    gen_helper_stfl(cpu_env);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
> +{
> +    potential_page_fault(s);
> +    gen_helper_stfle(regs[0], cpu_env, o->in2, regs[0]);
> +    set_cc_static(s);
>      return NO_EXIT;
>  }

 Thomas

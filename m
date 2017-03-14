Received: from eggs.gnu.org ([2001:4830:134:3::10]:60910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cnifh-0003KU-GK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cnifc-000178-HU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cnifc-00015q-8N
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:23:08 -0400
References: <20170302024110.3978-1-rth@twiddle.net>
	<20170302024110.3978-2-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5de54421-2e33-41f3-bcad-15396267f7f0@redhat.com>
Date: Tue, 14 Mar 2017 10:23:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170302024110.3978-2-rth@twiddle.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] target/s390x: Implement STORE
 FACILITIES LIST EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Am 02.03.2017 um 03:41 schrieb Richard Henderson:
> At the same time, improve STORE FACILITIES LIST
> so that we don't hard-code the list for all cpus.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  2 ++
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/misc_helper.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   | 17 +++++++++--------
>  4 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 9102071..01adb50 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -83,6 +83,8 @@ DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
>  DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_RWG, void, env, i64)
>  DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
>  DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
> +DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_2(stfle, i32, env, i64)
>  
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 075ff59..b6702da 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -747,6 +747,8 @@
>      C(0xe33e, STRV,    RXY_a, Z,   la2, r1_32u, new, m1_32, rev32, 0)
>      C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
>  
> +/* STORE FACILITY LIST EXTENDED */
> +    C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
>  /* STORE FPC */
>      C(0xb29c, STFPC,   S,     Z,   0, a2, new, m2_32, efpc, 0)
>  
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 3cb942e..fa51b29 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -654,3 +654,44 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
>      }
>  }
>  #endif
> +
> +void HELPER(stfl)(CPUS390XState *env)
> +{
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +    S390FeatInit buf = { };

S390FeatInit is the wrong structure to use here. In theory, you would
have to allocate 2048 bytes for the stfl(e) features. So any call to
s390_fill_feat_block(S390_FEAT_TYPE_STFL) will not overwrite random
data. This function currently expects blocks prepared for the the
maximum number of bits.

What you could do is:

a) parse the enabled features yourself:

S390Feat feat = find_first_bit(cpu->model->features, S390_FEAT_MAX);

while (feat < S390_FEAT_MAX) {
    S390FeatDef *def = s390_feat_def(feat);

    if (def->type == S390_FEAT_TYPE_STFL) {
        // use def->bit
    }
    feat = find_next_bit(cpu->model->features, S390_FEAT_MAX, feat + 1);
}

b) add helper to do that / extend s390_fill_feat_block()

With a), you can directly work around the big-endian issue in stfle
below. And ignore bits > 31 here.


> +    uint32_t feat32;
> +
> +    s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_STFL,
> +                         (uint8_t *) &buf);
> +    feat32 = be64_to_cpu(buf[0]) >> 32;

be64? I would have assumed be32.

> +
> +    cpu_stl_data(env, 200, feat32);
> +}
> +
> +uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
> +{
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +    S390FeatInit buf = { };
> +    int count_m1 = env->regs[0] & 0xff;
> +    int max_m1, i;
> +
> +    s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_STFL,
> +                         (uint8_t *) &buf);
> +
> +    /* Find out how many 64-bit quantities are non-zero.  */
> +    for (max_m1 = ARRAY_SIZE (buf) - 1; max_m1 > 0; --max_m1) {
> +        if (buf[max_m1] != 0) {
> +            break;
> +        }
> +    }
> +
> +    /* Note that s390_fill_feat_block already filled in big-endian.
> +       But since cpu_stq_data will swap from host, we need to convert
> +       back to host-endian first.  */
> +    for (i = 0; i <= count_m1; ++i) {
> +        cpu_stq_data(env, addr + 8 * i, be64_to_cpu(buf[i]));
> +    }
> +
> +    env->regs[0] = deposit64(env->regs[0], 0, 8, max_m1);
> +    return (count_m1 >= max_m1 ? 0 : 3);
> +}
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 01c6217..69940e3 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3628,15 +3628,8 @@ static ExitStatus op_spt(DisasContext *s, DisasOps *o)
>  
>  static ExitStatus op_stfl(DisasContext *s, DisasOps *o)
>  {
> -    TCGv_i64 f, a;
> -    /* We really ought to have more complete indication of facilities
> -       that we implement.  Address this when STFLE is implemented.  */
>      check_privileged(s);
> -    f = tcg_const_i64(0xc0000000);
> -    a = tcg_const_i64(200);
> -    tcg_gen_qemu_st32(f, a, get_mem_index(s));
> -    tcg_temp_free_i64(f);
> -    tcg_temp_free_i64(a);
> +    gen_helper_stfl(cpu_env);
>      return NO_EXIT;
>  }
>  
> @@ -3802,6 +3795,14 @@ static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
>  }
>  #endif
>  
> +static ExitStatus op_stfle(DisasContext *s, DisasOps *o)
> +{
> +    potential_page_fault(s);
> +    gen_helper_stfle(cc_op, cpu_env, o->in2);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
>  static ExitStatus op_st8(DisasContext *s, DisasOps *o)
>  {
>      tcg_gen_qemu_st8(o->in1, o->in2, get_mem_index(s));
> 


-- 
Thanks,

David

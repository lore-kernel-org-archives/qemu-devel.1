Received: from eggs.gnu.org ([209.51.188.92]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DQ-000444-Ce
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DP-0002Rq-Cb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:16 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8DN-0002GG-Nv
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:15 -0500
Received: by mail-pf1-x443.google.com with SMTP id d25so8717211pfn.8
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:01 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3317597-1eed-8f02-07d4-d84c5398733c@linaro.org>
Date: Wed, 27 Feb 2019 07:53:29 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 12/33] s390x/tcg: Implement VECTOR LOAD
 GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> To avoid an helper, we have to do the actual calculation of the element
> address (offset in cpu_env + cpu_env) manually. Factor that out into
> get_vec_element_ptr_i64(). The same logic will be reused for "VECTOR
> LOAD VR ELEMENT FROM GR".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 55 +++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 46610e808f..f4201ff55a 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -996,6 +996,8 @@
>      E(0xe741, VLEIH,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_16, IF_VEC)
>      E(0xe743, VLEIF,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_32, IF_VEC)
>      E(0xe742, VLEIG,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_64, IF_VEC)
> +/* VECTOR LOAD GR FROM VR ELEMENT */
> +    F(0xe721, VLGV,    VRS_c, V,   la2, 0, r1, 0, vlgv, 0, IF_VEC)
>  
>  #ifndef CONFIG_USER_ONLY
>  /* COMPARE AND SWAP AND PURGE */
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index 1bf654ff4e..a02a3ba81f 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -137,6 +137,28 @@ static void load_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
>      tcg_temp_free_i64(tmp);
>  }
>  
> +static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
> +                                    uint8_t es)
> +{
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +
> +    /* mask off invalid parts from the element nr */
> +    tcg_gen_andi_i64(tmp, enr, NUM_VEC_ELEMENTS(es) - 1);
> +
> +    /* convert it to an element offset relative to cpu_env (vec_reg_offset() */
> +    tcg_gen_muli_i64(tmp, tmp, NUM_VEC_ELEMENT_BYTES(es));

Or
  tcg_gen_shli_i64(tmp, tmp, es);


> +    /* generate the final ptr by adding cpu_env */
> +    tcg_gen_trunc_i64_ptr(ptr, tmp);
> +    tcg_gen_add_ptr(ptr, ptr, cpu_env);

Sadly, there's nothing in the optimizer that will propagate this...

> +    case MO_8:
> +        tcg_gen_ld8u_i64(o->out, ptr, 0);

... into this.

Is it easy for you objdump|grep some binaries to tell if my hunch is correct,
in that virtually all direct element access is with a constant, i.e. with c(r0)
as the address?

It would be nice if this could be (o->out, cpu_env, ofs) for those cases...

But what's here is correct, and what I'm suggesting is mere refinement,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

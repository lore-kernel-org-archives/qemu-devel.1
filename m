Received: from eggs.gnu.org ([2001:4830:134:3::10]:55169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecDBI-0000tH-T4
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecDBF-0000TO-P6
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:36:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecDBF-0000RO-I3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:36:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id t74so23339347wme.3
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:36:45 -0800 (PST)
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<20180108055348.20444-2-david@gibson.dropbear.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1f754e4-adbf-0b18-e5f5-55d68e2edd89@redhat.com>
Date: Thu, 18 Jan 2018 17:36:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180108055348.20444-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 01/12] target-ppc: optimize cmp translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: surajjs@au1.ibm.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org

On 08/01/2018 06:53, David Gibson wrote:
> From: "pbonzini@redhat.com" <pbonzini@redhat.com>
> 
> We know that only one bit (in addition to SO) is going to be set in
> the condition register, so do two movconds instead of three setconds,
> three shifts and two ORs.
> 
> For ppc64-linux-user, the code size reduction is around 5% and the
> performance improvement slightly less than 10%.  For softmmu, the
> improvement is around 5%.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/translate.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4075fc8589..8a6bd329d0 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -605,27 +605,22 @@ static opc_handler_t invalid_handler = {
>  static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
>  {
>      TCGv t0 = tcg_temp_new();
> -    TCGv_i32 t1 = tcg_temp_new_i32();
> -
> -    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
> -
> -    tcg_gen_setcond_tl((s ? TCG_COND_LT: TCG_COND_LTU), t0, arg0, arg1);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_gen_shli_i32(t1, t1, CRF_LT_BIT);
> -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> +    TCGv t1 = tcg_temp_new();
> +    TCGv_i32 t = tcg_temp_new_i32();
>  
> -    tcg_gen_setcond_tl((s ? TCG_COND_GT: TCG_COND_GTU), t0, arg0, arg1);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_gen_shli_i32(t1, t1, CRF_GT_BIT);
> -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> +    tcg_gen_movi_tl(t0, CRF_EQ);
> +    tcg_gen_movi_tl(t1, CRF_LT);
> +    tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU), t0, arg0, arg1, t1, t0);
> +    tcg_gen_movi_tl(t1, CRF_GT);
> +    tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU), t0, arg0, arg1, t1, t0);
>  
> -    tcg_gen_setcond_tl(TCG_COND_EQ, t0, arg0, arg1);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_gen_shli_i32(t1, t1, CRF_EQ_BIT);
> -    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
> +    tcg_gen_trunc_tl_i32(t, t0);
> +    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
> +    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t);
>  
>      tcg_temp_free(t0);
> -    tcg_temp_free_i32(t1);
> +    tcg_temp_free(t1);
> +    tcg_temp_free_i32(t);
>  }
>  
>  static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, int crf)
> 

David, can you queue this again now that the ARM backend has been fixed?

Thanks,

Paolo

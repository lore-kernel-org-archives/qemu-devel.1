Received: from eggs.gnu.org ([2001:4830:134:3::10]:36069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pWn-00064q-Kz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pWk-0007at-Dz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:05:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pWk-0007aT-8D
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:05:14 -0400
Received: by mail-qk0-x242.google.com with SMTP id k123so24592721qke.3
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 20:05:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e1f6b98f-8342-0780-fae7-03e5b97608c4@amsat.org>
Date: Tue, 24 Oct 2017 00:05:10 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 17/52] tcg: Introduce temp_tcgv_{i32, i64,
 ptr}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

On 10/20/2017 08:19 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.h | 26 +++++++++++++++++-----
>  tcg/tcg.c | 74 +++++++++++++++++++++++++++------------------------------------
>  2 files changed, 53 insertions(+), 47 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index fb8ce01664..9432962d7b 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -786,6 +786,21 @@ static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr t)
>      return arg_temp(tcgv_ptr_arg(t));
>  }
>  
> +static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
> +{
> +    return (TCGv_i32)temp_idx(t);
> +}
> +
> +static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
> +{
> +    return (TCGv_i64)temp_idx(t);
> +}
> +
> +static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
> +{
> +    return (TCGv_ptr)temp_idx(t);
> +}
> +
>  static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
>  {
>      tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
> @@ -837,7 +852,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
>  
>  void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
>  
> -int tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
> +TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
> +                                     intptr_t, const char *);
>  
>  TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
>  TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
> @@ -851,8 +867,8 @@ void tcg_temp_free_i64(TCGv_i64 arg);
>  static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
>                                                const char *name)
>  {
> -    int idx = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, name);
> -    return MAKE_TCGV_I32(idx);
> +    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, name);
> +    return temp_tcgv_i32(t);
>  }
>  
>  static inline TCGv_i32 tcg_temp_new_i32(void)
> @@ -868,8 +884,8 @@ static inline TCGv_i32 tcg_temp_local_new_i32(void)
>  static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offset,
>                                                const char *name)
>  {
> -    int idx = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, name);
> -    return MAKE_TCGV_I64(idx);
> +    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, name);
> +    return temp_tcgv_i64(t);
>  }
>  
>  static inline TCGv_i64 tcg_temp_new_i64(void)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index cb985aabdc..0a9bfa4236 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -492,8 +492,8 @@ static inline TCGTemp *tcg_global_alloc(TCGContext *s)
>      return ts;
>  }
>  
> -static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
> -                                       TCGReg reg, const char *name)
> +static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
> +                                            TCGReg reg, const char *name)
>  {
>      TCGTemp *ts;
>  
> @@ -509,44 +509,43 @@ static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
>      ts->name = name;
>      tcg_regset_set_reg(s->reserved_regs, reg);
>  
> -    return temp_idx(ts);
> +    return ts;
>  }
>  
>  void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
>  {
> -    int idx;
>      s->frame_start = start;
>      s->frame_end = start + size;
> -    idx = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
> -    s->frame_temp = &s->temps[idx];
> +    s->frame_temp
> +        = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
>  }
>  
>  TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name)
>  {
>      TCGContext *s = &tcg_ctx;
> -    int idx;
> +    TCGTemp *t;
>  
>      if (tcg_regset_test_reg(s->reserved_regs, reg)) {
>          tcg_abort();
>      }
> -    idx = tcg_global_reg_new_internal(s, TCG_TYPE_I32, reg, name);
> -    return MAKE_TCGV_I32(idx);
> +    t = tcg_global_reg_new_internal(s, TCG_TYPE_I32, reg, name);
> +    return temp_tcgv_i32(t);
>  }
>  
>  TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
>  {
>      TCGContext *s = &tcg_ctx;
> -    int idx;
> +    TCGTemp *t;
>  
>      if (tcg_regset_test_reg(s->reserved_regs, reg)) {
>          tcg_abort();
>      }
> -    idx = tcg_global_reg_new_internal(s, TCG_TYPE_I64, reg, name);
> -    return MAKE_TCGV_I64(idx);
> +    t = tcg_global_reg_new_internal(s, TCG_TYPE_I64, reg, name);
> +    return temp_tcgv_i64(t);
>  }
>  
> -int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
> -                                intptr_t offset, const char *name)
> +TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
> +                                     intptr_t offset, const char *name)
>  {
>      TCGContext *s = &tcg_ctx;
>      TCGTemp *base_ts = &s->temps[GET_TCGV_PTR(base)];
> @@ -598,10 +597,10 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
>          ts->mem_offset = offset;
>          ts->name = name;
>      }
> -    return temp_idx(ts);
> +    return ts;
>  }
>  
> -static int tcg_temp_new_internal(TCGType type, int temp_local)
> +static TCGTemp *tcg_temp_new_internal(TCGType type, int temp_local)
>  {
>      TCGContext *s = &tcg_ctx;
>      TCGTemp *ts;
> @@ -638,36 +637,30 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
>              ts->temp_allocated = 1;
>              ts->temp_local = temp_local;
>          }
> -        idx = temp_idx(ts);
>      }
>  
>  #if defined(CONFIG_DEBUG_TCG)
>      s->temps_in_use++;
>  #endif
> -    return idx;
> +    return ts;
>  }
>  
>  TCGv_i32 tcg_temp_new_internal_i32(int temp_local)
>  {
> -    int idx;
> -
> -    idx = tcg_temp_new_internal(TCG_TYPE_I32, temp_local);
> -    return MAKE_TCGV_I32(idx);
> +    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, temp_local);
> +    return temp_tcgv_i32(t);
>  }
>  
>  TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
>  {
> -    int idx;
> -
> -    idx = tcg_temp_new_internal(TCG_TYPE_I64, temp_local);
> -    return MAKE_TCGV_I64(idx);
> +    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, temp_local);
> +    return temp_tcgv_i64(t);
>  }
>  
> -static void tcg_temp_free_internal(int idx)
> +static void tcg_temp_free_internal(TCGTemp *ts)
>  {
>      TCGContext *s = &tcg_ctx;
> -    TCGTemp *ts;
> -    int k;
> +    int k, idx;
>  
>  #if defined(CONFIG_DEBUG_TCG)
>      s->temps_in_use--;
> @@ -676,23 +669,23 @@ static void tcg_temp_free_internal(int idx)
>      }
>  #endif
>  
> -    tcg_debug_assert(idx >= s->nb_globals && idx < s->nb_temps);
> -    ts = &s->temps[idx];
> +    tcg_debug_assert(ts->temp_global == 0);
>      tcg_debug_assert(ts->temp_allocated != 0);
>      ts->temp_allocated = 0;
>  
> +    idx = temp_idx(ts);
>      k = ts->base_type + (ts->temp_local ? TCG_TYPE_COUNT : 0);
>      set_bit(idx, s->free_temps[k].l);
>  }
>  
>  void tcg_temp_free_i32(TCGv_i32 arg)
>  {
> -    tcg_temp_free_internal(GET_TCGV_I32(arg));
> +    tcg_temp_free_internal(tcgv_i32_temp(arg));
>  }
>  
>  void tcg_temp_free_i64(TCGv_i64 arg)
>  {
> -    tcg_temp_free_internal(GET_TCGV_I64(arg));
> +    tcg_temp_free_internal(tcgv_i64_temp(arg));
>  }
>  
>  TCGv_i32 tcg_const_i32(int32_t val)
> @@ -1001,7 +994,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>          for (i = real_args = 0; i < nargs; ++i) {
>              int is_64bit = sizemask & (1 << (i+1)*2);
>              if (is_64bit) {
> -                TCGv_i64 orig = MAKE_TCGV_I64(temp_idx(args[i]));
> +                TCGv_i64 orig = temp_tcgv_i64(args[i]);
>                  TCGv_i32 h = tcg_temp_new_i32();
>                  TCGv_i32 l = tcg_temp_new_i32();
>                  tcg_gen_extr_i64_i32(l, h, orig);
> @@ -1021,7 +1014,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>          int is_signed = sizemask & (2 << (i+1)*2);
>          if (!is_64bit) {
>              TCGv_i64 temp = tcg_temp_new_i64();
> -            TCGv_i64 orig = MAKE_TCGV_I64(temp_idx(args[i]));
> +            TCGv_i64 orig = temp_tcgv_i64(args[i]);
>              if (is_signed) {
>                  tcg_gen_ext32s_i64(temp, orig);
>              } else {
> @@ -1130,10 +1123,8 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>      for (i = real_args = 0; i < orig_nargs; ++i) {
>          int is_64bit = orig_sizemask & (1 << (i+1)*2);
>          if (is_64bit) {
> -            TCGv_i32 h = MAKE_TCGV_I32(temp_idx(args[real_args++]));
> -            TCGv_i32 l = MAKE_TCGV_I32(temp_idx(args[real_args++]));
> -            tcg_temp_free_i32(h);
> -            tcg_temp_free_i32(l);
> +            tcg_temp_free_internal(args[real_args++]);
> +            tcg_temp_free_internal(args[real_args++]);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          } else {
>              real_args++;
>          }
> @@ -1142,7 +1133,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>          /* The 32-bit ABI returned two 32-bit pieces.  Re-assemble them.
>             Note that describing these as TCGv_i64 eliminates an unnecessary
>             zero-extension that tcg_gen_concat_i32_i64 would create.  */
> -        tcg_gen_concat32_i64(MAKE_TCGV_I64(temp_idx(ret)), retl, reth);
> +        tcg_gen_concat32_i64(temp_tcgv_i64(ret), retl, reth);
>          tcg_temp_free_i64(retl);
>          tcg_temp_free_i64(reth);
>      }
> @@ -1150,8 +1141,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>      for (i = 0; i < nargs; ++i) {
>          int is_64bit = sizemask & (1 << (i+1)*2);
>          if (!is_64bit) {
> -            TCGv_i64 temp = MAKE_TCGV_I64(temp_idx(args[i]));
> -            tcg_temp_free_i64(temp);
> +            tcg_temp_free_internal(args[i]);
>          }
>      }
>  #endif /* TCG_TARGET_EXTEND_ARGS */
> 

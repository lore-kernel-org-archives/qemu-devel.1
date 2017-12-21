Received: from eggs.gnu.org ([2001:4830:134:3::10]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eS1tz-0002Rx-Vl
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eS1tw-0008RO-Hv
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:32:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eS1tw-0008R3-BF
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:32:48 -0500
References: <20171221142939.1339-1-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <016b1e8d-5581-8f98-fcf3-bd871851503a@redhat.com>
Date: Thu, 21 Dec 2017 15:32:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171221142939.1339-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: fix set_cc_op()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 21/12/2017 15:29, Laurent Vivier wrote:
> The first call of set_cc_op() in a new translation sequence
> is done with old_op set to CC_OP_DYNAMIC (-1).
> 
> This will do an out of bound access to the array cc_op_live[].
> 
> We fix that by adding an entry in cc_op_live[] for CC_OP_DYNAMIC,
> and in this case we can also discard QREG_CC_OP.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h       | 2 +-
>  target/m68k/translate.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index afae5f68ac..5d03764eab 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -182,7 +182,7 @@ void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
>   */
>  typedef enum {
>      /* Translator only -- use env->cc_op.  */
> -    CC_OP_DYNAMIC = -1,
> +    CC_OP_DYNAMIC,
>  
>      /* Each flag bit computed into cc_[xcnvz].  */
>      CC_OP_FLAGS,
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index b60909222c..61ac1a8e83 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -207,6 +207,7 @@ typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
>  #endif
>  
>  static const uint8_t cc_op_live[CC_OP_NB] = {
> +    [CC_OP_DYNAMIC] = CCF_C | CCF_V | CCF_Z | CCF_N | CCF_X,
>      [CC_OP_FLAGS] = CCF_C | CCF_V | CCF_Z | CCF_N | CCF_X,
>      [CC_OP_ADDB ... CC_OP_ADDL] = CCF_X | CCF_N | CCF_V,
>      [CC_OP_SUBB ... CC_OP_SUBL] = CCF_X | CCF_N | CCF_V,
> @@ -237,6 +238,11 @@ static void set_cc_op(DisasContext *s, CCOp op)
>      if (dead & CCF_V) {
>          tcg_gen_discard_i32(QREG_CC_V);
>      }
> +
> +    /* Discard any computed CC_OP value */
> +    if (old_op == CC_OP_DYNAMIC) {
> +        tcg_gen_discard_i32(QREG_CC_OP);
> +    }
>  }
>  
>  /* Update the CPU env CC_OP state.  */
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

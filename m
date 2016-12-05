Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxit-0002Rh-Vw
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxit-0006Gz-58
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:10:43 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-8-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <10698d22-57b6-b4ad-c391-04726c9eca68@twiddle.net>
Date: Mon, 5 Dec 2016 10:10:39 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-8-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/13] target-ppc: implement xxextractuw
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> +static void gen_##name(DisasContext *ctx)                       \
> +{                                                               \
> +    TCGv xt, xb;                                                \
> +    TCGv_i32 t0 = tcg_temp_new_i32();                           \
> +    uint8_t uimm = UIMM4(ctx->opcode);                          \
> +                                                                \
> +    if (unlikely(!ctx->vsx_enabled)) {                          \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                  \
> +        return;                                                 \
> +    }                                                           \
> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
> +    xb = tcg_const_tl(xB(ctx->opcode));                         \
> +    tcg_gen_movi_i32(t0, uimm);                                 \
> +    gen_helper_##name(cpu_env, xt, xb, t0);                     \
> +    tcg_temp_free(xb);                                          \
> +    tcg_temp_free(xt);                                          \
> +    tcg_temp_free_i32(t0);                                      \

While the ISA manual says that the results are undefined if UIMM > 12, I don't
think you should allow the implementation here to read beyond the end of the XB
register.

What does real hardware do?  I would have hoped for a SIGILL, but I don't
suppose that actually happens.

> +    getVSR(xbn, &xb, env);                                              \
> +    memmove(&xt.u8[8 - es], &xb.u8[index], es);                         \
> +    memset(&xt.u8[8], 0, 8);                                            \
> +    memset(&xt.u8[0], 0, 8 - es);                                       \
> +    putVSR(xtn, &xt, env);                                              \

I think this would be simpler as

  memset(&xt, 0, sizeof(xt));
  memcpy(&xt.u8[8 - es], &xb.u8[index], es);

since xt and xb are local variables and therefore cannot overlap.


r~

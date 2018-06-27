Received: from eggs.gnu.org ([2001:4830:134:3::10]:50919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY6mZ-00032N-Hv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY6mU-0003FP-Jy
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:30:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fY6mU-0003Ea-Cd
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:30:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so4996944wmw.1
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 02:30:30 -0700 (PDT)
References: <007a01d3f736$8b5e63f0$a21b2bd0$@phi.nz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b03eaea-e611-3e83-8c01-33a17a6b3f8e@redhat.com>
Date: Wed, 27 Jun 2018 11:30:26 +0200
MIME-Version: 1.0
In-Reply-To: <007a01d3f736$8b5e63f0$a21b2bd0$@phi.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fixed CR0.TS check in gen_sse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandro Sanchez Bach <alexandro@phi.nz>, qemu-devel@nongnu.org

On 29/05/2018 12:19, Alexandro Sanchez Bach wrote:
> The function `gen_sse` assumes all of its instructions require CR0.TS=0.
> However, integer extensions at `0F 38 F[0-F]` and `0F 3A F[0-F]` such as
> CRC32, MOVBE, ADX, BMI1, BMI2 that are handled by `gen_sse` are not supposed
> to throw an exception in this scenario. This causes issues while booting
> some FreeBSD-based guests.
> 
> Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
> Signed-off-by: Alexandro Sanchez Bach <alexandro@phi.nz>
> Cc: qemu-stable@nongnu.org
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 7c21814676..079ab7afef 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -3049,8 +3049,16 @@ static void gen_sse(CPUX86State *env, DisasContext
> *s, int b,
>              is_xmm = 1;
>          }
>      }
> +
> +    modrm = x86_ldub_code(env, s);
> +    reg = ((modrm >> 3) & 7);
> +    if (is_xmm)
> +        reg |= rex_r;
> +    mod = (modrm >> 6) & 3;

The problem here is that EMMS and FEMMS instructions do not have a
mod/rm byte.  However, this change should apply easily on top of another
patch to move EMMS and FEMMS out of gen_sse.

I'll queue the patch, and wait applying it until I have time to do that
other change (or someone else does it ;)).

Thanks,

Paolo

>      /* simple MMX/SSE operation */
> -    if (s->flags & HF_TS_MASK) {
> +    if (s->flags & HF_TS_MASK
> +        && ((b != 0x38 && b != 0x3A) || !(modrm & 0xF0))) {
>          gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
>          return;
>      }
> @@ -3084,11 +3092,6 @@ static void gen_sse(CPUX86State *env, DisasContext
> *s, int b,
>          gen_helper_enter_mmx(cpu_env);
>      }
>  
> -    modrm = x86_ldub_code(env, s);
> -    reg = ((modrm >> 3) & 7);
> -    if (is_xmm)
> -        reg |= rex_r;
> -    mod = (modrm >> 6) & 3;
>      if (sse_fn_epp == SSE_SPECIAL) {
>          b |= (b1 << 8);
>          switch(b) {
> 
> 
> 

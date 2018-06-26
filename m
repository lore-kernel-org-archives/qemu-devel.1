Received: from eggs.gnu.org ([2001:4830:134:3::10]:44920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXs80-0002I4-5d
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXs7z-00089u-69
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:51:44 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXs7y-00089K-Tj
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:51:43 -0400
Received: by mail-oi0-x242.google.com with SMTP id x18-v6so7434831oie.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 10:51:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <002201d40d74$a1b4b8d0$e51e2a70$@phi.nz>
References: <002201d40d74$a1b4b8d0$e51e2a70$@phi.nz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 18:51:21 +0100
Message-ID: <CAFEAcA-sT28yye6xpoMauLNNJzTok5e4Qbb_mzPOKQmgPeDneQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fixed CR0.TS check in gen_sse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandro Sanchez Bach <alexandro@phi.nz>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Ccing the target/i386 maintainers...

thanks
-- PMM

On 26 June 2018 at 18:39, Alexandro Sanchez Bach <alexandro@phi.nz> wrote:
> Ping.
>
> -----Original Message-----
> From: Alexandro Sanchez Bach <alexandro@phi.nz>
> Sent: Tuesday, May 29, 2018 12:20
> To: 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>
> Subject: [PATCH] target/i386: Fixed CR0.TS check in gen_sse
>
> The function `gen_sse` assumes all of its instructions require CR0.TS=0.
> However, integer extensions at `0F 38 F[0-F]` and `0F 3A F[0-F]` such as
> CRC32, MOVBE, ADX, BMI1, BMI2 that are handled by `gen_sse` are not supposed
> to throw an exception in this scenario. This causes issues while booting
> some FreeBSD-based guests.
>
> Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
> Signed-off-by: Alexandro Sanchez Bach <alexandro@phi.nz>
> Cc: qemu-stable@nongnu.org
> diff --git a/target/i386/translate.c b/target/i386/translate.c index
> 7c21814676..079ab7afef 100644
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
> +
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

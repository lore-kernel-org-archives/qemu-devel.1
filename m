Received: from eggs.gnu.org ([2001:4830:134:3::10]:39282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo01k-0007lM-DZ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo01h-0003CS-4h
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:31:56 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929]:41770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo01g-0003AW-Ty
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:31:53 -0400
Received: by mail-ua1-x929.google.com with SMTP id h1-v6so693260uao.8
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 22:31:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-10-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a9a97704-c24d-0e79-ff13-2f71bee34c80@amsat.org>
Date: Fri, 10 Aug 2018 02:31:45 -0300
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 09/80] target/mips: Check ELPA flag only
 in some cases of MFHC0 and MTHC0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

On 08/06/2018 01:59 PM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> MFHC0 and MTHC0 used to handle EntryLo0 and EntryLo1 registers only,
> and placing ELPA flag checks before switch statement were technically
> correct. However, after adding handling more registers, these checks
> should be moved to act only in cases of handling EntryLo0 and
> EntryLo1.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 841c0c8..bc1f21f 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4896,12 +4896,11 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>  {
>      const char *rn = "invalid";
>  
> -    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
> -
>      switch (reg) {
>      case 2:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0));
>              rn = "EntryLo0";
>              break;
> @@ -4912,6 +4911,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>      case 3:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
>              rn = "EntryLo1";
>              break;
> @@ -4964,12 +4964,11 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>      const char *rn = "invalid";
>      uint64_t mask = ctx->PAMask >> 36;
>  
> -    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
> -
>      switch (reg) {
>      case 2:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              tcg_gen_andi_tl(arg, arg, mask);
>              gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0));
>              rn = "EntryLo0";
> @@ -4981,6 +4980,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>      case 3:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              tcg_gen_andi_tl(arg, arg, mask);
>              gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
>              rn = "EntryLo1";
> 

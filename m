Received: from eggs.gnu.org ([209.51.188.92]:38572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGRwe-0006Vk-EG
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGRwd-0002me-G3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:32:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGRwd-0002ls-25
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:32:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id z9so10661133pgu.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:32:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
	<c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
	<50effb1c-3bbe-126b-9bfb-0b65eacc9c36@linaro.org>
Message-ID: <abdf9c63-8f27-8cb2-dc94-22318c3836ae@linaro.org>
Date: Tue, 16 Apr 2019 07:32:25 -1000
MIME-Version: 1.0
In-Reply-To: <50effb1c-3bbe-126b-9bfb-0b65eacc9c36@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: palmer@sifive.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org

On 4/16/19 7:22 AM, Richard Henderson wrote:
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index fb66e886bf..c96c616539 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -695,6 +695,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>   */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wredundant-decls"
> +#pragma GCC diagnostic ignored "-Wtypedef-redefinition"

Bah.  Of course gcc doesn't know this one.  And looking closer elsewhere, I see
we've got a configure test for the pragmas, which I suppose I ought to use.


r~


diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index fb66e886bf..b62ca04281 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -693,12 +693,19 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
  * initially declared by the 32-bit decoder, which results in duplicate
  * declaration warnings.  Suppress them.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wredundant-decls"
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic push
+# pragma GCC diagnostic ignored "-Wredundant-decls"
+# ifdef __clang__
+#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
+# endif
+#endif

 #include "decode_insn16.inc.c"

-#pragma GCC diagnostic pop
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic pop
+#endif

 static void decode_opc(DisasContext *ctx)
 {

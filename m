Received: from eggs.gnu.org ([209.51.188.92]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDZTW-0008N7-DS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDZTU-0002hf-CS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:58:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDZTO-0002e8-Mn
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:58:30 -0400
Received: by mail-pg1-x543.google.com with SMTP id g8so7831659pgf.2
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:58:22 -0700 (PDT)
References: <20190323222412.9825-1-slyfox@gentoo.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bbceff60-323c-a94e-f236-f0f55751d8cf@linaro.org>
Date: Mon, 8 Apr 2019 08:58:15 -1000
MIME-Version: 1.0
In-Reply-To: <20190323222412.9825-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] powerpc: fix denorm float->double
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergei Trofimovich <slyfox@gentoo.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

On 3/23/19 12:24 PM, Sergei Trofimovich wrote:
> Here denormalization conversion has a few bugs:
> - significand (abs_arg) has 32-bit unsigned wraparound in
>     ret |= abs_arg << (shift + 29);
> - significand does not drop explicit leading '1' in denorm
>   'float' when converting to normalized 'double'
> - significand had an off-by-one shift

Correct on all points.  Thanks for the test case and analysis.


> +        /*
> +         * Conversion mechanics:
> +         * float denorm (2^(-126) - biased):
> +         *    [ sign (1 bit) | exp32 (8 bits)  | sign32 (23 bits) ]
> +         *                 s                0    0001abc...def

FWIW, the overlap between "sign" and "significand" is why I prefer the term
"fraction", even though the term itself is less precise.


>          if (unlikely(abs_arg != 0)) {
>              /* Denormalized operand.  */
> -            int shift = clz32(abs_arg) - 9;
> -            int exp = -126 - shift + 1023;
> -            ret |= (uint64_t)exp << 52;
> -            ret |= abs_arg << (shift + 29);
> +            int lz = clz32(abs_arg);
> +            abs_arg &= ~(1 << (31 - lz)); /* [2a.] */
> +
> +            /* shift within sign32 includeing leading '1' */
> +            int shift = lz + 1 - (32 - 23);
> +            int exp = -126 + 1023 - shift; /* [2b]. */
> +            ret |= (uint64_t)exp << 52; /* [3.] */
> +            ret |= (uint64_t)abs_arg << (52 - 23 + shift); /* [4.] */

I think perhaps using deposit makes things clearer, since we don't have to
explicitly remove the msb in that case:

E.g.

@@ -67,10 +67,10 @@ uint64_t helper_todouble(uint32_t arg)
         ret = (uint64_t)extract32(arg, 31, 1) << 63;
         if (unlikely(abs_arg != 0)) {
             /* Denormalized operand.  */
-            int shift = clz32(abs_arg) - 9;
-            int exp = -126 - shift + 1023;
-            ret |= (uint64_t)exp << 52;
-            ret |= abs_arg << (shift + 29);
+            int msbm1 = 31 - clz32(abs_arg);
+            int exp = 1023 - 126 - (23 - msbm1);
+            ret = deposit64(ret, 52, 11, exp);
+            ret = deposit64(ret, 52 - msbm1, msbm1, abs_arg);


Thoughts?


r~

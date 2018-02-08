Received: from eggs.gnu.org ([2001:4830:134:3::10]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eju4g-0002uB-LN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:49:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eju4d-0007z5-Md
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:49:46 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eju4d-0007yl-HG
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:49:43 -0500
Received: by mail-pg0-x241.google.com with SMTP id t4so1191498pgp.8
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 13:49:43 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9f6893b-3fd7-69ed-c7ae-c54d67897955@linaro.org>
Date: Thu, 8 Feb 2018 13:49:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/32] arm/translate-a64: add FP16
 FMULX/MLS/FMLA to simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> The helpers use the new re-factored muladd support in SoftFloat for the 
> float16 work.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org> --- 
> target/arm/translate-a64.c | 69 
> ++++++++++++++++++++++++++++++++++++---------- 1 file changed, 54 
> insertions(+), 15 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c index 
> 3a2be1e016..83a1fa3116 100644 --- a/target/arm/translate-a64.c +++ 
> b/target/arm/translate-a64.c @@ -10804,7 +10804,7 @@ static void 
> disas_simd_indexed(DisasContext *s, uint32_t insn) } /* fall through */
> case 0x9: /* FMUL, FMULX */ -        if (!extract32(size, 1, 1)) { +
> if (size == 1 || (size < 2 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) { 
> unallocated_encoding(s); return; } @@ -10816,18 +10816,30 @@ static void 
> disas_simd_indexed(DisasContext *s, uint32_t insn) }
> 
> if (is_fp) { -        /* low bit of size indicates single/double */ - size =
> extract32(size, 0, 1) ? 3 : 2; -        if (size == 2) { +        /* convert
> insn encoded size to TCGMemOp size */ +        switch (size) { + case 0: /*
> half-precision */ +            size = MO_16; +            index = h << 2 | l
> << 1 | m; +            break;

FWIW, the size check for the integer insns is done in this block (in the !is_fp
side of course).  I think it makes sense to do the size check for FP insns down
here too.  So, e.g.

    if (is_fp) {
        switch (size) {
        case 2: /* single precision */
            ...
        case 3: /* double precision */
            ...
        case 0: /* half precision */
            size = MO_16;
            index = ...
            is_fp16 = true;
            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
                break;
            }
            /* fallthru */
        default: /* unallocated */
            unallocated_encoding(s);
            return;
        }
    }

Just below, you have not updated the call to get_fpstatus_ptr.
For the record, for fcmla I needed to introduce an "is_fp16" bool here.
(Since of course a complex fp16 is 32-bits wide.)


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAzd-0001ri-1U
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAzc-0004dV-9u
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:36:21 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceAzb-0004d2-Om
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:36:20 -0500
Received: by mail-pf0-x242.google.com with SMTP id o64so290558pfb.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:36:19 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-14-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d2ac5ebc-7294-af9e-aadc-899153d12f99@twiddle.net>
Date: Thu, 16 Feb 2017 12:36:13 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-14-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/16] target-m68k: add fsglmul and
 fsgldiv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> fsglmul and fsgldiv truncate data to single precision before computing
> results.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/fpu_helper.c | 22 ++++++++++++++++++++++
>  target/m68k/helper.h     |  2 ++
>  target/m68k/translate.c  |  8 ++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 42f5b5c..8a3eed3 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -351,6 +351,17 @@ void HELPER(mul_FP0_FP1)(CPUM68KState *env)
>      floatx80_to_FP0(env, res);
>  }
>
> +void HELPER(sglmul_FP0_FP1)(CPUM68KState *env)
> +{
> +    float64 a, b, res;
> +
> +    a = floatx80_to_float64(FP0_to_floatx80(env), &env->fp_status);
> +    b = floatx80_to_float64(FP1_to_floatx80(env), &env->fp_status);

s/float64/float32/g

Kinda sorta, probably close enough.  The manual says the resulting exponent may 
be out of range.  Which means this will produce +Inf in cases HW won't.


r~

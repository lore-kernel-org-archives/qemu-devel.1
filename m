Received: from eggs.gnu.org ([2001:4830:134:3::10]:56392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ce8Xb-0001qh-Cd
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ce8XW-0006Ox-Fk
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:59:15 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ce8XW-0006Op-9l
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:59:10 -0500
Received: by mail-pg0-x243.google.com with SMTP id 75so70023pgf.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 14:59:10 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-6-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5f165880-5918-c920-3df1-b195a1a3bd5c@twiddle.net>
Date: Thu, 16 Feb 2017 09:59:02 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-6-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/16] target-m68k: use floatx80
 internally
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
> +    uint32_t fp0h;
> +    uint64_t fp0l;
> +    uint32_t fp1h;
> +    uint64_t fp1l;

I'm not especially keen on these temporaries.

Wouldn't it be better to pass pointers to FPReg to the helpers, so that e.g.

   fadd.x  fp0, fp1

puts the result in fp1 directly, without having to copy from this FP0 location?
I can see that you would need a proper FPReg temporary to deal with e.g.

   fadd.d  a0@, fp1

such that the memory source gets converted before being used as input to the 
addition.

> +static float32 FP0_to_float32(CPUM68KState *env)
>  {
> +    return *(float32 *)&env->fp0h;
>  }
...
> +static void float32_to_FP0(CPUM68KState *env, float32 val)
>  {
> +    env->fp0h = *(uint32_t *)&val;
>  }

I don't like this type-punning.  I also don't see what good it does to store 
these truncated values in portions of FP0, when you could simply pass or return 
them by value from the relevant helpers, e.g.

> +void HELPER(reds32_FP0)(CPUM68KState *env)
>  {
> +    int32_t res;
> +
> +    res = floatx80_to_int32(FP0_to_floatx80(env), &env->fp_status);
> +
> +    int32_to_FP0(env, res);
>  }

could easily be

int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
{
   return floatx80_to_int32(*val, &env->fp_status);
}


r~

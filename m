Received: from eggs.gnu.org ([2001:4830:134:3::10]:39140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6zG-00070C-Ns
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6zD-0006N8-LS
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:26:22 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS6zD-0006Mb-G5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:26:19 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so25133988qkq.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:26:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-5-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <39af8700-3e03-828d-144a-5e86703e90cd@twiddle.net>
Date: Mon, 3 Jul 2017 12:26:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170703162328.24474-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target-m68k: add fscale,
 fgetman and fgetexp
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

On 07/03/2017 09:23 AM, Laurent Vivier wrote:
> +void HELPER(fgetman)(CPUM68KState *env, FPReg *res, FPReg *val)
> +{
> +    if (floatx80_is_infinity(val->d)) {
> +        res->d = floatx80_default_nan(NULL);
> +        /* FIXME: set the OPERR bit int he FPSR */
> +        return;
> +    }
> +    if (floatx80_is_zero(val->d) ||
> +        floatx80_is_any_nan(val->d)) {
> +        *res = *val;
> +        return;
> +    }
> +
> +    res->l.upper = (val->l.upper & 0x8000) | 0x3fff;
> +    if (floatx80_is_zero_or_denormal(val->d)) {
> +        res->l.lower = val->l.lower << 1;

Surely you have to do more than this for denormals?  There may be more than one 
leading zero bit in the mant.  Do you actually need to re-normalize?  Or does 
real hardware produce a so-called "unnormal" in this situation?


r~

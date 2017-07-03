Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS7My-0004Ag-JY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dS7Mt-0007xC-QA
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:50:52 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dS7Mt-0007ue-5A
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:50:47 -0400
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-5-laurent@vivier.eu>
	<39af8700-3e03-828d-144a-5e86703e90cd@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b5158122-61cb-0950-956c-79a9556bdabc@vivier.eu>
Date: Mon, 3 Jul 2017 21:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <39af8700-3e03-828d-144a-5e86703e90cd@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Le 03/07/2017 à 21:26, Richard Henderson a écrit :
> On 07/03/2017 09:23 AM, Laurent Vivier wrote:
>> +void HELPER(fgetman)(CPUM68KState *env, FPReg *res, FPReg *val)
>> +{
>> +    if (floatx80_is_infinity(val->d)) {
>> +        res->d = floatx80_default_nan(NULL);
>> +        /* FIXME: set the OPERR bit int he FPSR */
>> +        return;
>> +    }
>> +    if (floatx80_is_zero(val->d) ||
>> +        floatx80_is_any_nan(val->d)) {
>> +        *res = *val;
>> +        return;
>> +    }
>> +
>> +    res->l.upper = (val->l.upper & 0x8000) | 0x3fff;
>> +    if (floatx80_is_zero_or_denormal(val->d)) {
>> +        res->l.lower = val->l.lower << 1;
> 
> Surely you have to do more than this for denormals?  There may be more
> than one leading zero bit in the mant.  Do you actually need to
> re-normalize?  Or does real hardware produce a so-called "unnormal" in
> this situation?

I don't know. Do you have test values I can try on real hardware to know?

I've tried:

		fmove.x #0x000056789ABCDEF12345,%fp0
		fgetman.x %fp0,%fp6

fp0            1.135643728339893804160017756766172e-4932	(raw
0x0000000056789abcdef12345)
fp6            1.3511111111108837373479679699883604	(raw
0x3fff0000acf13579bde2468a)

		fmove.x #0x000086789ABCDEF12345,%fp0
		fgetman.x %fp0,%fp6

fp0            1.7660380676734113365842698475140006e-4932	(raw
0x0000000086789abcdef12345)
fp6            1.0505555555554418686739839849941802	(raw
0x3fff000086789abcdef12345)

		fmove.x #0x000000000ABCDEF12345,%fp0
		fgetman.x %fp0,%fp6
fp0            2.1518178707571747286191852003521627e-4938	(raw
0x0000000000000abcdef12345)
fp6            1.342222103012886691431049257516861	(raw
0x3fff0000abcdef1234500000)

So I guess the mantissa must be shifted to left until we have a 1 in the
explicit integer part bit?

Thanks,
Laurent

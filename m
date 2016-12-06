Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8AN-0000Hs-Sc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8AK-0003Oo-Mm
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:19:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cE8AK-0003Ob-FT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:19:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB65J5oW011363
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 00:19:43 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 275ntgcyd2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 00:19:42 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 15:19:39 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20e22e8b-c4ea-8e4c-b8d2-09f4af1f6ab2@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-3-git-send-email-nikunj@linux.vnet.ibm.com>
	<20e22e8b-c4ea-8e4c-b8d2-09f4af1f6ab2@twiddle.net>
Date: Tue, 06 Dec 2016 10:49:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fum1iqht.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 02/13] target-ppc: add mask_u128 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
>> +#if defined(CONFIG_INT128)
>> +FUNC_MASK(mask_u128, Int128, 128, Int128, ~((__uint128_t)0));
>> +#else
>> +static inline Int128 mask_u128(int start, int end)
>> +{
>> +    Int128 r = {0};
>> +    if (start > 63) {
>> +        r.hi = 0;
>> +        r.lo = mask_u64(start - 64, end - 64);
>> +    } else if (end < 64) {
>> +        r.hi = mask_u64(start, end);
>> +        r.lo = 0;
>> +    } else {
>> +        r.hi = mask_u64(start, 63);
>> +        r.lo = mask_u64(0, end - 64);
>> +    }
>> +    return r;
>> +}
>>  #endif
>
> First, I would really really like you to stop adding *any* ifdefs on
> CONFIG_INT128.  All that's going to do is make sure that there's code that is
> almost never tested, since x86_64 (and other 64-bit hosts) does support int128.

I did test both the cases above by flipping the switch of CONFIG_INT128.
Initially was planning to do this in int128.h, but the bit numbering is
different and wont be usable for other architecture.

> Second, you're not using the Int128 interface correctly.  Better would be
>
> static inline Int128 mask_u128(int start, int end)
> {
>     uint64_t hi, lo;
>     if (start > 63) {
>         hi = 0;
>         lo = mask_u64(start - 64, end - 64);
>     } else if (end < 64) {
>         hi = mask_u64(start, end);
>         lo = 0;
>     } else {
>         hi = mask_u64(start, 63);
>         lo = mask_u64(0, end - 64);
>     }
>     return make_int128(lo, hi);
> }

Sure will use this.

Regards
Nikunj

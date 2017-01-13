Received: from eggs.gnu.org ([2001:4830:134:3::10]:54809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRscL-0005f1-3n
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRscG-0006Jo-8C
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:33:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43298
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRscG-0006JT-1K
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:33:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0D3SfM5009961
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 22:33:23 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27xp7khjae-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 22:33:23 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 13 Jan 2017 13:33:20 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1145c965-e1e5-025f-c88b-de0dd614fee1@twiddle.net>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484238251-8096-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<1145c965-e1e5-025f-c88b-de0dd614fee1@twiddle.net>
Date: Fri, 13 Jan 2017 09:02:56 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvevmy6v.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 6/7] target-ppc: Add xvtstdc[sp,
 dp] instructions
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
> On 01/12/2017 08:24 AM, Nikunj A Dadhania wrote:
>> +        nan = tp##_is_any_nan(xb.fld);                      \
>> +        infinity = tp##_is_infinity(xb.fld);                \
>> +        sign = tp##_is_neg(xb.fld);                         \
>> +        zero = denormal = 0;                                \
>> +        if (tp##_is_zero_or_denormal(xb.fld)) {             \
>> +            if (tp##_is_zero(xb.fld)) {                     \
>> +                zero = 1;                                   \
>> +            } else {                                        \
>> +                denormal = 1;                               \
>> +            }                                               \
>> +        }                                                   \
>> +                                                            \
>> +        if ((extract32(dcmx, 6, 1) && nan) ||               \
>> +            (extract32(dcmx, 5, 1) && infinity && !sign) || \
>> +            (extract32(dcmx, 4, 1) && infinity &&  sign) || \
>> +            (extract32(dcmx, 3, 1) && zero     && !sign) || \
>> +            (extract32(dcmx, 3, 1) && zero     &&  sign) || \
>> +            (extract32(dcmx, 1, 1) && denormal && !sign) || \
>> +            (extract32(dcmx, 0, 1) && denormal &&  sign)) { \
>> +            match = 1;                                      \
>> +        }                                                   \
>
> I'll note that all of these are mutually exclusive, therefore you're doing much
> more work than required.
>
>   sign = tp##_is_neg(x));
>   if (tp##is_any_nan(x)) {
>       match = extract32(dcmx, 6, 1);
>   } else if (tp##_is_infinity(x)) {
>       match = extract32(dcmx, 4 + !sign, 1);
>   } else if (tp##_is_zero(x)) {
>       match = extract32(dcmx, 2 + !sign, 1);
>   } else if (tp##_is_zero_or_denormal(x)) {
>       match = extract32(dcmx, 0 + !sign, 1);
>   }

Right, that is pretty concise. Will send updated series changing patch 6
and 7.

> (Also, an apparent typo for your zero && sign case.)

Yes, was by mistake.

Regards
Nikunj

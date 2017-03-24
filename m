Received: from eggs.gnu.org ([2001:4830:134:3::10]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1crT1V-00036i-VF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1crT1S-0004wS-0u
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:29:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1crT1R-0004w1-Nq
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:29:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2OHNV31105376
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 13:29:08 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29cm3up625-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 13:29:07 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Sat, 25 Mar 2017 03:29:04 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v2OHSrNY41681044
	for <qemu-devel@nongnu.org>; Sat, 25 Mar 2017 04:29:01 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v2OHSQDk006485
	for <qemu-devel@nongnu.org>; Sat, 25 Mar 2017 04:28:26 +1100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <877f3fx7p0.fsf@linaro.org>
References: <1472935202-3342-1-git-send-email-rth@twiddle.net>
	<1472935202-3342-14-git-send-email-rth@twiddle.net>
	<87vay1w7p8.fsf@linaro.org>
	<f851ddba-bc62-2477-dd05-3f7e9d364668@twiddle.net>
	<87efxn9e2f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<877f3fx7p0.fsf@linaro.org>
Date: Fri, 24 Mar 2017 22:57:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87k27epou7.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 13/34] tcg: Add atomic helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
>
>> Richard Henderson <rth@twiddle.net> writes:
>>
>>> On 09/12/2016 06:47 AM, Alex Benn=C3=A9e wrote:
>>>>> > +    /* Notice an IO access, or a notdirty page.  */
>>>>> > +    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
>>>>> > +        /* There's really nothing that can be done to
>>>>> > +           support this apart from stop-the-world.  */
>>>>> > +        goto stop_the_world;
>>>> We are also triggering on TLB_NOTDIRTY here in the case where a
>>>> conditional write is the first write to a page. I don't know if a
>>>> stop_the_world is required at this point but we will need to ensure we
>>>> clear bits as notdirty_mem_write() does.
>>>>
>>>
>>> You're quite right that we could probably special-case TLB_NOTDIRTY her=
e such
>>> that (1) we needn't leave the cpu loop, and (2) needn't utilize the act=
ual
>>> "write" part of notdirty_mem_write; just set the bits then fall through=
 to the
>>> actual atomic instruction below.
>>
>> I do hit this case with ppc64, where I see that its the first write to
>> the page and it exits from this every time, causing the kernel to print
>> soft-lockups.
>>
>> Can we add the special case here for NOTDIRTY and set the page as dirty
>> and return successfully?
>
> Does the atomic step fall-back not work for you?

No, it doesn't seem so, otherwise I shouldn't have seen soft-lockups.

Regards
Nikunj

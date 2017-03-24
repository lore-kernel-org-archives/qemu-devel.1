Received: from eggs.gnu.org ([2001:4830:134:3::10]:52029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1crMFB-0004v6-OD
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1crMF6-0003do-Oz
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:14:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52300
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1crMF6-0003dg-Id
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:14:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2OA97ot043707
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:14:45 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29cg2rg6n2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:14:45 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Mar 2017 15:44:42 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v2OAEdTi3801262
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 15:44:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v2OAEdq9009667
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 15:44:39 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <f851ddba-bc62-2477-dd05-3f7e9d364668@twiddle.net>
References: <1472935202-3342-1-git-send-email-rth@twiddle.net>
	<1472935202-3342-14-git-send-email-rth@twiddle.net>
	<87vay1w7p8.fsf@linaro.org>
	<f851ddba-bc62-2477-dd05-3f7e9d364668@twiddle.net>
Date: Fri, 24 Mar 2017 15:44:32 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87efxn9e2f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 13/34] tcg: Add atomic helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

Richard Henderson <rth@twiddle.net> writes:

> On 09/12/2016 06:47 AM, Alex Benn=C3=A9e wrote:
>>> > +    /* Notice an IO access, or a notdirty page.  */
>>> > +    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
>>> > +        /* There's really nothing that can be done to
>>> > +           support this apart from stop-the-world.  */
>>> > +        goto stop_the_world;
>> We are also triggering on TLB_NOTDIRTY here in the case where a
>> conditional write is the first write to a page. I don't know if a
>> stop_the_world is required at this point but we will need to ensure we
>> clear bits as notdirty_mem_write() does.
>>=20
>
> You're quite right that we could probably special-case TLB_NOTDIRTY here =
such
> that (1) we needn't leave the cpu loop, and (2) needn't utilize the actual
> "write" part of notdirty_mem_write; just set the bits then fall through t=
o the
> actual atomic instruction below.

I do hit this case with ppc64, where I see that its the first write to
the page and it exits from this every time, causing the kernel to print
soft-lockups.

Can we add the special case here for NOTDIRTY and set the page as dirty
and return successfully?

Regards
Nikunj

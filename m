Received: from eggs.gnu.org ([2001:4830:134:3::10]:36514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1csTGI-0002vs-R7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1csTGB-0007zV-Vx
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:56:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1csTGB-0007yS-P8
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:56:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2RBrdji004646
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:56:30 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29dnwu1qup-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:56:30 -0400
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 27 Mar 2017 17:26:26 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v2RBuPVk15597804
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 17:26:25 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
	by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v2RBuOXp008184
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 17:26:25 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <877f3fx7p0.fsf@linaro.org>
References: <1472935202-3342-1-git-send-email-rth@twiddle.net>
	<1472935202-3342-14-git-send-email-rth@twiddle.net>
	<87vay1w7p8.fsf@linaro.org>
	<f851ddba-bc62-2477-dd05-3f7e9d364668@twiddle.net>
	<87efxn9e2f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<877f3fx7p0.fsf@linaro.org>
Date: Mon, 27 Mar 2017 17:26:22 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <877f3bq6ft.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

Looked further and I do see that EXCP_ATOMIC does get executed in
qemu_tcg_cpu_thread_fn(), but I am not sure what is going wrong there.

Following snippet fixes the issue for me:

diff --git a/cputlb.c b/cputlb.c
index f5d056c..743776a 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -930,7 +930,13 @@ static void *atomic_mmu_lookup(CPUArchState *env, targ=
et_ulong addr,
         tlb_addr =3D tlbe->addr_write;
     }
=20
-    /* Notice an IO access, or a notdirty page.  */
+    /* Check notdirty */
+    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
+        tlb_set_dirty(ENV_GET_CPU(env), addr);
+        tlb_addr =3D tlb_addr & ~TLB_NOTDIRTY;
+    }
+
+    /* Notice an IO access  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */

Regards
Nikunj

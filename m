Received: from eggs.gnu.org ([2001:4830:134:3::10]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1chA37-0007SH-Bd
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1chA32-0001iL-Tu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:12:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1chA32-0001hj-KR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:12:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O793YU115619
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 02:12:11 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t0avyvc8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 02:12:11 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 12:42:07 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <87o9xs2hnl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<755c77c5-0930-b5ee-0b3b-1e0608301c8d@twiddle.net>
	<87a89cza5l.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170224025841.GN17615@umbus.fritz.box>
	<4a13acc6-8a7e-f259-fdb7-6c3156b9ac6c@twiddle.net>
	<87o9xs2hnl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Fri, 24 Feb 2017 12:42:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgsw2hby.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 06/15] target/ppc: remove xer
 split-out flags(so, ov, ca)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Richard Henderson <rth@twiddle.net> writes:
>
>> On 02/24/2017 01:58 PM, David Gibson wrote:
>>> On Fri, Feb 24, 2017 at 06:18:22AM +0530, Nikunj A Dadhania wrote:
>>>> Richard Henderson <rth@twiddle.net> writes:
>>>>
>>>>> On 02/24/2017 06:56 AM, Nikunj A Dadhania wrote:
>>>>>> Now get rid all the split out variables so, ca, ov. After this patch,
>>>>>> all the bits are stored in CPUPPCState::xer at appropriate places.
>>>>>>
>>>>>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>  target/ppc/cpu.c        |   8 +---
>>>>>>  target/ppc/cpu.h        |  26 ++++++------
>>>>>>  target/ppc/int_helper.c |  12 +++---
>>>>>>  target/ppc/translate.c  | 106 +++++++++++++++++++++++++-----------------------
>>>>>>  4 files changed, 78 insertions(+), 74 deletions(-)
>>>>>
>>>>> I do not think this is a good direction to take this.
>>>>
>>>> Hmm, any particular reason?
>>>
>>> Right, I suggested this, but based only a suspicion that the split
>>> variables weren't worth the complexity.  I'm happy to be corrected by
>>> someone with better knowledge of TCG, but it'd be nice to know why.
>>
>> Normally we're interested in minimizing the size of the generated code, 
>> delaying computation until we can show it being used.
>>
>> Now, ppc is a bit different from other targets (which might compute overflow 
>> for any addition insn) in that it only computes overflow when someone asks for 
>> it.  Moreover, it's fairly rare for the addo/subo/nego instructions to
>> be used.
>
>> Therefore, I'm not 100% sure what the "best" solution is.
>
> Agreed, with that logic, wont it be more efficient to move the OV/CA
> updationg to respective callers, and when xer_read/write happens, its
> just one tcg_ops.

BTW, i haven't seen remarkable difference in the boot time after this
change.

Regards
Nikunj

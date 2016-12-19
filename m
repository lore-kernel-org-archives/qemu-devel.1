Received: from eggs.gnu.org ([2001:4830:134:3::10]:40158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cIpW3-0004Xq-1s
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 23:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cIpVz-0006mn-St
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 23:25:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43963
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cIpVz-0006m1-L8
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 23:25:31 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJ4Og9W004324
	for <qemu-devel@nongnu.org>; Sun, 18 Dec 2016 23:25:30 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27dkfga6bd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 18 Dec 2016 23:25:30 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 19 Dec 2016 14:25:27 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20161216041936.GF12146@umbus.fritz.box>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161212003055.GC12127@umbus.fritz.box>
	<CALAZu38RiyxcnV5uXucUcyyV9aeWqXXpEznUF9z2gNrn0Fy4tQ@mail.gmail.com>
	<20161212040733.GB31441@umbus.fritz.box>
	<87d1guc32t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20161216041936.GF12146@umbus.fritz.box>
Date: Mon, 19 Dec 2016 09:55:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvfs7dg9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/6] target-ppc: implement
 xxextractuw instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj Dadhania <nikunj.dadhania@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Wed, Dec 14, 2016 at 02:14:26PM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > [ Unknown signature status ]
>> > On Mon, Dec 12, 2016 at 09:31:11AM +0530, Nikunj Dadhania wrote:
>> >> On 12 December 2016 at 06:00, David Gibson <david@gibson.dropbear.id.au> wrote:
>> >> > On Fri, Dec 09, 2016 at 05:47:24PM +0530, Nikunj A Dadhania wrote:
>> >> >> xxextractuw: VSX Vector Extract Unsigned Word
>> >> >>
>> >> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> >> >> +        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
>> >> >> +        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
>> >> >> +        return;                                                 \
>> >> >
>> >> > So, I know the architecture says it is undefined.  But since you're
>> >> > testing for the bogus case anyway, why not turn this into an
>> >> > exception. That seems like it would be more helpful for debugging the
>> >> > guest than just setting the result to zero.  Or is this done to match
>> >> > actual hardware behaviour?
>> >> 
>> >> I havent had a change to run on the real hardware, but on the system
>> >> simulator, it happily
>> >> returns extracted content even if UIMM > 12.
>> >
>> > Hm.  Returns what exactly?
>> 
>> So for LE case extracting from 15 returns following, basically its
>> rounding up to 0.
>
>> xxextractuw: 15 - ooTSET a si sihT
>>                   ________ihTo____
>
> Ok.  IIRC your implementation did not do this - it set the
> "overflowed" bytes to 0 instead of wrapping round and taking them from
> the other end of the input.  If think we should either match hardware
> behaviour or simply trap here, rather than do something else.

Sure, will update and send the patch matching hardware behaviour.

Regards
Nikunj

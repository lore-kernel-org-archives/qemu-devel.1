Received: from eggs.gnu.org ([2001:4830:134:3::10]:41871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cdTQj-0003IK-8x
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cdTQe-0007dE-BF
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:05:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cdTQe-0007dA-1f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:05:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1E33iKc114553
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 22:05:18 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28kr87kapy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 22:05:18 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 14 Feb 2017 08:35:15 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170214024331.GD2169@umbus.fritz.box>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
	<87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170214024331.GD2169@umbus.fritz.box>
Date: Tue, 14 Feb 2017 08:35:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9y5eale.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Fri, Feb 10, 2017 at 09:49:17AM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > [ Unknown signature status ]
>> > On Thu, Feb 09, 2017 at 04:04:04PM +0530, Nikunj A Dadhania wrote:
>> >> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
>> >> and corresponding defines. Moreover, CA32 is set when CA is set and
>> >> OV32 is set when OV is set, there is no need to have a new
>> >> fields in the CPUPPCState structure.
>> >> 
>> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> >
>> > Um.. I don't quite understand this.  If CA always has the same value
>> > as CA32, what's the point?
>> 
>> I am not clear either. I think that as CA was set for both 32/64-bit
>> mode, that couldn't be changed for backward compatibility. CA32 should
>> have affected only the instructions working one word variants.
>> 
>> Re-scanning the ISA 3.0, found this in 3.3.9 Fixed-Point Arithmetic
>> Instructions:
>> 
>> =================================================================
>> addic, addic., subfic, addc, subfc, adde, subfe,
>> addme, subfme, addze, and subfze always set CA, to
>> reflect the carry out of bit 0 in 64-bit mode and out of bit
>> 32 in 32-bit mode. These instructions also always set
>> CA32 to reflect the carry out of bit 32.
>> =================================================================
>> 
>> Which is conflicting to what is said in 3.2.2 Fixed-Point Exception
>> Register:
>> =================================================================
>> Carry32 (CA32)
>> CA32 is set whenever CA is set, and is set to
>> the same value that CA is defined to be set to
>> in 32-bit mode.
>> =================================================================
>
> Ok, I've had a look at the ISA and discussed this with Michael
> Ellerman.  We think what's going on here is that it's using some
> unfortunately unclear wording.  When it says "OV32 is set when OV is
> set" we think that means "OV32 is updated when OV is updated", not
> that "OV32 is set to the same value as OV".
>
> So although they're updated at the same time, the 32-bit variants can
> have different values and will need real representation in the CPU
> model.  Well, at least in 64-bit mode.  When the CPU is in 32-bit
> mode, I believe they really will have the same values.
>
> That would make your implementation suggested here incorrect.

Yes, you are right. I had a discussion with Paul Mackerras yesterday, he
explained to me in detail about the bits. I am working on the revised
implementation. Will detail it in the commit message.

Regards
Nikunj

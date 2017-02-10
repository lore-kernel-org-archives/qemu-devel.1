Received: from eggs.gnu.org ([2001:4830:134:3::10]:55996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cc2gx-0006E8-Aw
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cc2gu-0007rE-6H
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:20:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58156
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cc2gu-0007qw-0R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:20:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A4JDYZ042736
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 23:20:11 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28h2t4f2r3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 23:20:11 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 09:49:40 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170210001035.GJ27610@umbus.fritz.box>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
Date: Fri, 10 Feb 2017 09:49:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
> On Thu, Feb 09, 2017 at 04:04:04PM +0530, Nikunj A Dadhania wrote:
>> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
>> and corresponding defines. Moreover, CA32 is set when CA is set and
>> OV32 is set when OV is set, there is no need to have a new
>> fields in the CPUPPCState structure.
>> 
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> Um.. I don't quite understand this.  If CA always has the same value
> as CA32, what's the point?

I am not clear either. I think that as CA was set for both 32/64-bit
mode, that couldn't be changed for backward compatibility. CA32 should
have affected only the instructions working one word variants.

Re-scanning the ISA 3.0, found this in 3.3.9 Fixed-Point Arithmetic
Instructions:

=================================================================
addic, addic., subfic, addc, subfc, adde, subfe,
addme, subfme, addze, and subfze always set CA, to
reflect the carry out of bit 0 in 64-bit mode and out of bit
32 in 32-bit mode. These instructions also always set
CA32 to reflect the carry out of bit 32.
=================================================================

Which is conflicting to what is said in 3.2.2 Fixed-Point Exception
Register:
=================================================================
Carry32 (CA32)
CA32 is set whenever CA is set, and is set to
the same value that CA is defined to be set to
in 32-bit mode.
=================================================================

Regards
Nikunj

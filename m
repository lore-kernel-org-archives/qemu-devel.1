Received: from eggs.gnu.org ([2001:4830:134:3::10]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPtQl-0006ns-Ut
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPtQe-0001x8-FK
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:10:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53464
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gPtQc-0001jy-QC
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:10:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAMHwgIN044859
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 13:10:10 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwya858m8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 13:10:10 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Thu, 22 Nov 2018 18:10:09 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20181122132238.GL10448@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-2-farosas@linux.ibm.com>
	<20181122132238.GL10448@umbus.fritz.box>
Date: Thu, 22 Nov 2018 16:10:01 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k1l5m1ae.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] target/ppc: Add macro
 definitions for relocated interrupt vectors offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, James Hogan <jhogan@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Wed, Nov 21, 2018 at 04:13:45PM -0200, Fabiano Rosas wrote:
>> The PowerISA prescribes that depending on the values of MSR_IR,
>> MSR_DR, MSR_HV and LPCR_AIL, the interrupt vectors might be relocated
>> by specific offsets.
>> 
>> This patch defines macros for these offsets so that they can be used
>> by another part of the code in a future patch.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
>> ---
>>  target/ppc/cpu.h         | 3 +++
>>  target/ppc/excp_helper.c | 4 ++--
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index ab68abe8a2..5147db4460 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -2390,6 +2390,9 @@ enum {
>>      AIL_C000_0000_0000_4000 = 3,
>>  };
>>  
>> +#define AIL_0001_8000_OFFSET 0x18000
>> +#define AIL_C000_0000_0000_4000_OFFSET 0xc000000000004000ull
>
> Hrm.  Is there really a point making a #define, if the name spells out
> the value?  It's not like you can change the value without having to
> change the places that use it that way?

You're right, this is a bit clumsy.

I just checked and the single step works within SLOF code as well, so
I'll probably need to borrow the AIL-checking logic from excp_helper.c
to get the correct offset so this patch is likely to go away.

Cheers.

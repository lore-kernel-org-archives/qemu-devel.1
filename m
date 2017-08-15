Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dheQ1-0006yr-5u
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dhePw-0001Dy-39
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:10:13 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com
	([104.47.36.59]:31803
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1dhePv-0001Ar-Qv
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:10:08 -0400
References: <20170814155217.4898-1-brijesh.singh@amd.com>
	<20170815113531.GR3108@localhost.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f87838dc-a1e6-f51c-70d9-1f2ff571f72c@amd.com>
Date: Tue, 15 Aug 2017 11:09:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170815113531.GR3108@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386/cpu: Add new EYPC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Tom Lendacky <Thomas.Lendacky@amd.com>

Hi Eduardo,


On 08/15/2017 06:35 AM, Eduardo Habkost wrote:
> Hi,
> 
> Thanks for the patch.
> 
> On Mon, Aug 14, 2017 at 10:52:17AM -0500, Brijesh Singh wrote:
>> Add a new base CPU model called 'EPYC' to model processors from AMD EPYC
>> family (which includes EPYC 76xx,75xx,74xx,73xx and 72xx).
> 
> I suggest enumerating in the commit message which features were
> added to the CPU model in comparison to Opteron_G5.
> 

Will do.

[snip]

>> +        /* Missing: XSAVES (not supported by some Linux versions,
>> +         * including v4.1 to v4.12).
>> +         * KVM doesn't yet expose any XSAVES state save component.
>> +         */
> 
> Do you know which supervisor state components are available in
> EPYC CPUs?  Do you have a pointer to public AMD documentation
> about XSAVES?
> 

The available state components that may be saved by XSAVES are solely
determined by XCR0, and are therefore the same set of components that
can be used in XSAVE.

AMD APM vol4 [1] provides some information about XSAVES

[1] http://support.amd.com/TechDocs/26568.pdf#search=XSAVES

Note:
Looking at the document, I see that it says state elements saved are
determined by logical OR of XCRO with the IA32_XSS MSR. But the IA32_XSS MSR
definition is missing from the document and I have flagged it, it should be
updated with correct definition. But in the meantime, CPU team has confirmed
that the EPYC does not support any bits in IA32_XSS MSR.

> 
>> +        .features[FEAT_XSAVE] =
>> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
>> +            CPUID_XSAVE_XGETBV1,
>> +        .features[FEAT_6_EAX] =
>> +            CPUID_6_EAX_ARAT,
>> +        .xlevel = 0x8000001F,
> 
> All CPUID leaves from 0x8000000B to 0x8000001F return all-zeroes
> today.  If we set xlevel to 0x8000001F before we actually
> implement those CPUID leaves, we will be forced to add extra
> machine-type compat code when we finally implement them.
> 
> I suggest setting it to 0x8000000A, and increasing it only after
> we actually implement the new CPUID leaves.
> 
> 

Sure, I will limit xlevel to 0x8000_000A.

-Brijesh

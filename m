Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1diPgA-0006i3-DX
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1diPg7-0000wM-0z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:38:02 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com
	([104.47.38.52]:11840
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1diPg6-0000vr-PZ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:37:58 -0400
References: <20170815170051.127257-1-brijesh.singh@amd.com>
	<276d5c64-7ef3-127b-b2f4-e5f7b3a5aab4@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <2f426b2d-cea3-bed4-1966-6868d6e3bbfe@amd.com>
Date: Thu, 17 Aug 2017 13:37:51 -0500
MIME-Version: 1.0
In-Reply-To: <276d5c64-7ef3-127b-b2f4-e5f7b3a5aab4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target-i386/cpu: Add new EPYC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>

Hi Paolo,

On 08/17/2017 11:45 AM, Paolo Bonzini wrote:
> On 15/08/2017 19:00, Brijesh Singh wrote:
>>
>> The following features bits have been added/removed compare to Opteron_G5
>>
>> Added: monitor, movbe, rdrand, mmxext, ffxsr, rdtscp, cr8legacy, osvw,
>>         fsgsbase, bmi1, avx2, smep, bmi2, rdseed, adx, smap, clfshopt, sha
>>         xsaveopt, xsavec, xgetbv1, arat
>>
>> Removed: xop, fma4, tbm
> 
> Interesting, why were these removed?
> 

I don't know exact reason why these were removed - I am going with whatever is
listed as supported feature bit in PPR [1], but I will ask around and let you
know. I believe some of these instruction are superseded with newer instructions
(e.g fma4->fma)

[1] http://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf


> Do we want to add "topoext" support too?  What about mwaitx?
> 

Looking at PPR I think we can safely enable "topoext" - it is listed as fixed to 1
but "mwaitx" support depends on the MSR condition. If host BIOS does not set the MSR
then we may not able to use "mwaitx" feature.

Actually, I was trying to ensure that in this patch I do not use a feature which is not
supported by KVM. Looking at kvm_cpuid_8000_0001_ecx_x86_features [2] hinted me that
both "topoext" and "mwaitx" was not supported hence I skipped it. I can add comment to
remind us.

http://elixir.free-electrons.com/linux/latest/source/arch/x86/kvm/cpuid.c#L360

-Brijesh

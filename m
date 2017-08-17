Received: from eggs.gnu.org ([2001:4830:134:3::10]:40139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1diNYY-0004XC-NX
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1diNYV-0002gu-Ht
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:22:02 -0400
Received: from mail-co1nam03on0043.outbound.protection.outlook.com
	([104.47.40.43]:22513
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1diNYV-0002cR-64
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:21:59 -0400
References: <20170815170051.127257-1-brijesh.singh@amd.com>
	<SG2PR02MB1312BD95F982C3062A01C77580830@SG2PR02MB1312.apcprd02.prod.outlook.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ca026f27-58e0-c060-fe67-60425f833280@amd.com>
Date: Thu, 17 Aug 2017 11:21:49 -0500
MIME-Version: 1.0
In-Reply-To: <SG2PR02MB1312BD95F982C3062A01C77580830@SG2PR02MB1312.apcprd02.prod.outlook.com>
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
To: Wanpeng Li <wanpeng.li@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: brijesh.singh@amd.com, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, "chandu@amd.com" <chandu@amd.com>

Hi Wanpeng,

On 08/16/2017 10:55 PM, Wanpeng Li wrote:
> Cc Chandu,
> 
> On 8/16/17 1:00 AM, Brijesh Singh wrote:
>> Add a new base CPU model called 'EPYC' to model processors from AMD EPYC
>> family (which includes EPYC 76xx,75xx,74xx, 73xx and 72xx).
>>
>> The following features bits have been added/removed compare to Opteron_G5
>>
>> Added: monitor, movbe, rdrand, mmxext, ffxsr, rdtscp, cr8legacy, osvw,
>>          fsgsbase, bmi1, avx2, smep, bmi2, rdseed, adx, smap, clfshopt, sha
>>          xsaveopt, xsavec, xgetbv1, arat
> 
> Hi Brijesh,
> 
> Actually I wonder whether or not the support for these new instructions
> have already been merged in kvm/qemu?
> 

These are new features/instructions compare to Opteron_G5. The features are not
new to the KVM. Many of these instructions are virtualized in the hardware and
does not require KVM assist. IIRC, qemu verifies the user requested CPUID
features bits with KVM supported CPUID bits and if it finds that requested CPUID
bit is not supported in the KVM then it prints warning message and remove that
feature bit.

the warning message may look like this:
"
........
warning: host doesn't support requested feature: CPUID.01H:ECX.osxsave [bit 27]
........
"

I have tested EPYC CPU with 4.13-rc1 and it does not complain on any of these feature
bits.


> Regards,
> Wanpeng Li
> 
>>
>> Removed: xop, fma4, tbm
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>
>> Changes since v2:
>>    * limit the xlevel to 0x8000000a
>>
>> Changes since v1:
>>    * fix typo EYPC -> EPYC to reflect the correct branding name
>>
>>    target/i386/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>    1 file changed, 44 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ddc45ab..6617e01 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1522,6 +1522,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>            .xlevel = 0x8000001A,
>>            .model_id = "AMD Opteron 63xx class CPU",
>>        },
>> +    {
>> +        .name = "EPYC",
>> +        .level = 0xd,
>> +        .vendor = CPUID_VENDOR_AMD,
>> +        .family = 23,
>> +        .model = 1,
>> +        .stepping = 2,
>> +        .features[FEAT_1_EDX] =
>> +            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
>> +            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
>> +            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
>> +            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
>> +            CPUID_VME | CPUID_FP87,
>> +        .features[FEAT_1_ECX] =
>> +            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
>> +            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
>> +            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
>> +            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
>> +            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
>> +        .features[FEAT_8000_0001_EDX] =
>> +            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
>> +            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
>> +            CPUID_EXT2_SYSCALL,
>> +        .features[FEAT_8000_0001_ECX] =
>> +            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
>> +            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
>> +            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
>> +        .features[FEAT_7_0_EBX] =
>> +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
>> +            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
>> +            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
>> +            CPUID_7_0_EBX_SHA_NI,
>> +        /* Missing: XSAVES (not supported by some Linux versions,
>> +         * including v4.1 to v4.12).
>> +         * KVM doesn't yet expose any XSAVES state save component.
>> +         */
>> +        .features[FEAT_XSAVE] =
>> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
>> +            CPUID_XSAVE_XGETBV1,
>> +        .features[FEAT_6_EAX] =
>> +            CPUID_6_EAX_ARAT,
>> +        .xlevel = 0x8000000A,
>> +        .model_id = "AMD EPYC Processor",
>> +    },
>>    };
>>    
>>    typedef struct PropValue {
> 

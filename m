Received: from eggs.gnu.org ([2001:4830:134:3::10]:59836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gBvXe-00080H-OX
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 01:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gBvXc-0006tx-1a
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 01:35:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:7065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gBvXb-0006rJ-M4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 01:35:43 -0400
References: <20180919031122.28487-1-tao3.xu@intel.com>
	<20180919031122.28487-2-tao3.xu@intel.com>
	<20181013043835.GG31060@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a7571e89-e177-b971-b91c-fb0461a2c086@intel.com>
Date: Mon, 15 Oct 2018 13:34:39 +0800
MIME-Version: 1.0
In-Reply-To: <20181013043835.GG31060@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] i386: Add new model of
 Cascadelake-Server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, jingqi.liu@intel.com, qemu-devel@nongnu.org

Hi Eduardo,

Thank you for your comment.

On the release document ref below link (page 13):
https://software.intel.com/sites/default/files/managed/c5/15/\ 
<https://software.intel.com/sites/default/files/managed/c5/15//>
architecture-instruction-set-extensions-programming-reference.pdf

PKU is supported in Skylake Server (Only Server) and later, and
on Intel(R) Xeon(R) Processor Scalable Family. So it is supposed
to be in Skylake-Server CPU model. And PKU/OSPKE 's CPUID has been
exposed to QEMU. But in Skylake-Server CPU model I can't find
PKU/OSPKE in the code. So we will submit another patch for
Skylake-Server CPU model after we test it. OSPKE is to reads
the value of PKRU (Instruction of PKU) into EAX and clears EDX.

Cascadelake-Server is the later Server CPU on the same CPU family,
so it inherit features from ancestor Skylake-Server and add new
features.


On 10/13/2018 12:38 PM, Eduardo Habkost wrote:
> On Wed, Sep 19, 2018 at 11:11:22AM +0800, Tao Xu wrote:
>> New CPU models mostly inherit features from ancestor Skylake-Server,
>> while addin new features: AVX512_VNNI, Intel PT.
>> SSBD support for speculative execution
>> side channel mitigations.
> Comparing to Skylake-Server, the following features are being
> added:
>
> CPUID_7_0_EBX_INTEL_PT, CPUID_7_0_ECX_PKU, CPUID_7_0_ECX_OSPKE,
> CPUID_7_0_ECX_AVX512VNNI, CPUID_7_0_EDX_SPEC_CTRL,
> CPUID_7_0_EDX_SPEC_CTRL_SSBD.
>
>  From that list, only PKU/OSPKE is not mentioned in the commit
> message.  Is this intentional?
>
> Is family/model really supposed to be the same as the one on
> Skylake-Server?
>
>> Note:
>>
>> On Cascadelake, some capabilities (RDCL_NO, IBRS_ALL, RSBA,
>> SKIP_L1DFL_VMENTRY and SSB_NO) are enumerated by MSR.
>> These features rely on MSR based feature support patch.
>> Will be added later after that patch's in.
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg00074.html
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>   target/i386/cpu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index f24295e6e4..670898f32d 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2386,6 +2386,60 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>           .xlevel = 0x80000008,
>>           .model_id = "Intel Xeon Processor (Skylake, IBRS)",
>>       },
>> +    {
>> +        .name = "Cascadelake-Server",
>> +        .level = 0xd,
>> +        .vendor = CPUID_VENDOR_INTEL,
>> +        .family = 6,
>> +        .model = 85,
>> +        .stepping = 5,
>> +        .features[FEAT_1_EDX] =
>> +            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
>> +            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
>> +            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
>> +            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
>> +            CPUID_DE | CPUID_FP87,
>> +        .features[FEAT_1_ECX] =
>> +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
>> +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
>> +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
>> +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
>> +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
>> +            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
>> +        .features[FEAT_8000_0001_EDX] =
>> +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
>> +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
>> +        .features[FEAT_8000_0001_ECX] =
>> +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
>> +        .features[FEAT_7_0_EBX] =
>> +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
>> +            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
>> +            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
>> +            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
>> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
>> +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>> +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>> +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
>> +            CPUID_7_0_EBX_INTEL_PT,
>> +        .features[FEAT_7_0_ECX] =
>> +            CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
>> +            CPUID_7_0_ECX_AVX512VNNI,
>> +        .features[FEAT_7_0_EDX] =
>> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>> +        /* Missing: XSAVES (not supported by some Linux versions,
>> +                * including v4.1 to v4.12).
>> +                * KVM doesn't yet expose any XSAVES state save component,
>> +                * and the only one defined in Skylake (processor tracing)
>> +                * probably will block migration anyway.
>> +                */
>> +        .features[FEAT_XSAVE] =
>> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
>> +            CPUID_XSAVE_XGETBV1,
>> +        .features[FEAT_6_EAX] =
>> +            CPUID_6_EAX_ARAT,
>> +        .xlevel = 0x80000008,
>> +        .model_id = "Intel Xeon Processor (Cascadelake)",
>> +    },
>>       {
>>           .name = "Icelake-Client",
>>           .level = 0xd,
>> -- 
>> 2.17.1
>>
>>

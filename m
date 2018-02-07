Received: from eggs.gnu.org ([2001:4830:134:3::10]:36312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejUSz-0002Ag-Ql
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejUSu-0004Pd-Vd
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:29:09 -0500
Received: from mail-bn3nam01on0065.outbound.protection.outlook.com
	([104.47.33.65]:61312
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejUSu-0004Od-D3
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:29:04 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-5-brijesh.singh@amd.com>
	<70d2e5cd-6b31-efc0-a48d-259defe4316b@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <653e288f-376d-693e-fac3-8cbfa185c72f@amd.com>
Date: Wed, 7 Feb 2018 12:28:48 -0600
MIME-Version: 1.0
In-Reply-To: <70d2e5cd-6b31-efc0-a48d-259defe4316b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 05/26] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>



On 02/07/2018 10:54 AM, Paolo Bonzini wrote:
> On 07/02/2018 17:06, Brijesh Singh wrote:
>> AMD EPYC processors support memory encryption feature. The feature
>> is reported through CPUID 8000_001F[EAX].
>>
>> Fn8000_001F [EAX]:
>>   Bit 0   Secure Memory Encryption (SME) supported
>>   Bit 1   Secure Encrypted Virtualization (SEV) supported
>>   Bit 2   Page flush MSR supported
>>   Bit 3   Ecrypted State (SEV-ES) support
>>
>> when memory encryption feature is reported, CPUID 8000_001F[EBX] should
>> provide additional information regarding the feature (such as which page
>> table bit is used to mark pages as encrypted etc). The information in EBX
>> and ECX may vary from one family to another hence we use the host cpuid
>> to populate the EBX information.
>>
>> The details for memory encryption CPUID is available in AMD APM
>> (https://support.amd.com/TechDocs/24594.pdf) Section E.4.17
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
>>   target/i386/cpu.h |  6 ++++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a49d2221adc9..4147eb6e18a9 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -234,6 +234,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>>   #define TCG_EXT4_FEATURES 0
>>   #define TCG_SVM_FEATURES 0
>>   #define TCG_KVM_FEATURES 0
>> +#define TCG_MEM_ENCRYPT_FEATURES 0
>>   #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
>>             CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
>>             CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
>> @@ -545,6 +546,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>           .cpuid_reg = R_EDX,
>>           .tcg_features = ~0U,
>>       },
>> +    [FEAT_MEM_ENCRYPT] = {
>> +        .feat_names = {
>> +            "sme", "sev", "page-flush-msr", "sev-es",
> 
> Why would sme ever be on in a guest?  That is, would a guest care about
> whether SME is on in the host?


Guest does not need the SME feature bit exposed  and it does not care 
whether SME is enabled on the host. Since I was defining the bit fields 
from 8000_001F EAX hence I tried to list them all. In next version, I 
will update the MEM_ENCRYPT feature to expose just SEV.

Thanks

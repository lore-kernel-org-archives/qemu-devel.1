Received: from eggs.gnu.org ([2001:4830:134:3::10]:33031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gOoAm-0001qr-TY
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gOoAl-0000Ix-0h
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:21:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gOoAh-00008h-95
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:21:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id s11so6262774wmh.1
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 10:21:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181116164806.26929-1-pbonzini@redhat.com>
	<20181116165622.GB2457@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <122eb578-002f-75e0-1162-d725a1c403f8@redhat.com>
Date: Mon, 19 Nov 2018 19:21:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181116165622.GB2457@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: kvm: add VMX and SVM
 migration blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/11/18 17:56, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> Nested VMX and SVM do not support live migration yet.  Add a blocker
>> until that is worked out.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  target/i386/kvm.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index db1f4104b6..3b6fbd3f20 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -860,6 +860,8 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>>  }
>>  
>>  static Error *invtsc_mig_blocker;
>> +static Error *vmx_mig_blocker;
>> +static Error *svm_mig_blocker;
>>  
>>  #define KVM_MAX_CPUID_ENTRIES  100
>>  
>> @@ -1250,6 +1252,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      if (c) {
>>          has_msr_feature_control = !!(c->ecx & CPUID_EXT_VMX) ||
>>                                    !!(c->ecx & CPUID_EXT_SMX);
>> +
>> +    }
>> +
>> +    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
>> +        error_setg(&vmx_mig_blocker,
>> +                   "Nested VMX virtualization does not support live migration yet");
>> +        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            error_free(vmx_mig_blocker);
>> +            return r;
>> +        }
>> +    }
>> +
>> +    if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) && !svm_mig_blocker) {
>> +        error_setg(&svm_mig_blocker,
>> +                   "Nested SVM virtualization does not support live migration yet");
>> +        r = migrate_add_blocker(svm_mig_blocker, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            error_free(svm_mig_blocker);
>> +            return r;
>> +        }
> 
> I think that's OK from a migration point of view; my only worry is if
> people have nesting enabled by default.  On AMD isn't it common to have
> it enabled by default in KVM? Especially if using -cpu host ?

Hmm, yeah.  I'll send a v2 with only nested VMX.

Paolo

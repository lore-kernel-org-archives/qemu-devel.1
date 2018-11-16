Received: from eggs.gnu.org ([2001:4830:134:3::10]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gNhQ1-0004r6-Ej
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gNhPx-0002vr-CA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gNhPv-0002uT-CH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:56:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2F4085362
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 16:56:25 +0000 (UTC)
Date: Fri, 16 Nov 2018 16:56:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181116165622.GB2457@work-vm>
References: <20181116164806.26929-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116164806.26929-1-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Nested VMX and SVM do not support live migration yet.  Add a blocker
> until that is worked out.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/kvm.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index db1f4104b6..3b6fbd3f20 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -860,6 +860,8 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>  }
>  
>  static Error *invtsc_mig_blocker;
> +static Error *vmx_mig_blocker;
> +static Error *svm_mig_blocker;
>  
>  #define KVM_MAX_CPUID_ENTRIES  100
>  
> @@ -1250,6 +1252,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (c) {
>          has_msr_feature_control = !!(c->ecx & CPUID_EXT_VMX) ||
>                                    !!(c->ecx & CPUID_EXT_SMX);
> +
> +    }
> +
> +    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
> +        error_setg(&vmx_mig_blocker,
> +                   "Nested VMX virtualization does not support live migration yet");
> +        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_free(vmx_mig_blocker);
> +            return r;
> +        }
> +    }
> +
> +    if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) && !svm_mig_blocker) {
> +        error_setg(&svm_mig_blocker,
> +                   "Nested SVM virtualization does not support live migration yet");
> +        r = migrate_add_blocker(svm_mig_blocker, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_free(svm_mig_blocker);
> +            return r;
> +        }

I think that's OK from a migration point of view; my only worry is if
people have nesting enabled by default.  On AMD isn't it common to have
it enabled by default in KVM? Especially if using -cpu host ?

Dave

>      }
>  
>      if (env->mcg_cap & MCG_LMCE_P) {
> -- 
> 2.19.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

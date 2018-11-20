Received: from eggs.gnu.org ([2001:4830:134:3::10]:34714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gP4SJ-0007h6-Rd
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gP4SF-0005kN-RJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:44:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gP4SF-0005i1-Kq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:44:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ECDA3003705
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:44:30 +0000 (UTC)
Date: Tue, 20 Nov 2018 11:44:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181120114422.GA5072@work-vm>
References: <20181119182330.17147-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119182330.17147-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: kvm: add VMX migration
 blocker
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
> Nested VMX does not support live migration yet.  Add a blocker
> until that is worked out.
> 
> Nested SVM only does not support it, but unfortunately it is
> enabled by default for -cpu host so we cannot really disable it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

So I'm OK with this, but it does need a release note warning whenever it
goes in, because it'll surprise those who've already enabled nesting
but don't use it on all their VMs.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  target/i386/kvm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f524e7d929..27dcca5365 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -854,6 +854,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>  }
>  
>  static Error *invtsc_mig_blocker;
> +static Error *vmx_mig_blocker;
>  
>  #define KVM_MAX_CPUID_ENTRIES  100
>  
> @@ -1246,6 +1247,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                    !!(c->ecx & CPUID_EXT_SMX);
>      }
>  
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
>      if (env->mcg_cap & MCG_LMCE_P) {
>          has_msr_mcg_ext_ctl = has_msr_feature_control = true;
>      }
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

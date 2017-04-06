Received: from eggs.gnu.org ([2001:4830:134:3::10]:55469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cw645-0003jb-3y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cw641-00074C-Ei
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sahid.ferdjaoui@redhat.com>)
	id 1cw641-00072y-5y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:58:57 -0400
Date: Thu, 6 Apr 2017 13:58:54 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170406115854.GA29142@redhat>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E842@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4E842@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH]Enable kvmvapic only when host doesn't
 support VAPIC capability in KVM mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Stefan Hajnoczi' <stefanha@gmail.com>

On Wed, Apr 05, 2017 at 12:52:25AM +0000, Xu, Anthony wrote:
> In KVM mode, enable kvmvapic only when host doesn't support 
> VAPIC capability.
> 
> Save the time to set up kvmvapic in some hosts.
> 
> 
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>
>

s/Signed-off -by/Signed-off-by

nit: I think we do prefer a single line summary for the commit
message, a detailed description of the patch and only one blank line
to separe the Signed-off-by tag [0].

>
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index c3829e3..d5c53af 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -317,8 +317,11 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
>      info = APIC_COMMON_GET_CLASS(s);
>      info->realize(dev, errp);
>  
> -    /* Note: We need at least 1M to map the VAPIC option ROM */
> +    /* Note: We need at least 1M to map the VAPIC option ROM,
> +       if it is KVM, enable kvmvapic only when KVM doesn't have 
> +       VAPIC capability                */ 
>      if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
> +        (!kvm_enabled() || (kvm_enabled() && !kvm_has_vapic())) &&
>          !hax_enabled() && ram_size >= 1024 * 1024) {
>          vapic = sysbus_create_simple("kvmvapic", -1, NULL);
>      }
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 24281fc..43e0e4c 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -215,6 +215,7 @@ extern KVMState *kvm_state;
>  
>  bool kvm_has_free_slot(MachineState *ms);
>  int kvm_has_sync_mmu(void);
> +int kvm_has_vapic(void);
>  int kvm_has_vcpu_events(void);
>  int kvm_has_robust_singlestep(void);
>  int kvm_has_debugregs(void);
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..edcb6ea 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -2232,6 +2232,10 @@ int kvm_has_sync_mmu(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
>  }
>  
> +int kvm_has_vapic(void){
> +    return !kvm_check_extension(kvm_state, KVM_CAP_VAPIC);
> +}
> +

Is that function shouldn't return true if KVM is providing VAPIC
capability?

nit: I think you need to mark a return to the line before opening
brace for a function [1].

[0] http://wiki.qemu-project.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message
[1] http://git.qemu-project.org/?p=qemu.git;a=blob_plain;f=CODING_STYLE;hb=HEAD

>  int kvm_has_vcpu_events(void)
>  {
>      return kvm_state->vcpu_events;

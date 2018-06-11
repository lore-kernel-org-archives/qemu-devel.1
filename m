Received: from eggs.gnu.org ([2001:4830:134:3::10]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fSQTa-0004h0-7o
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fSQTW-0005su-UV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:19:30 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com
	([40.107.5.109]:56896
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fSQTW-0005rA-6K
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:19:26 -0400
Date: Mon, 11 Jun 2018 18:45:10 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180611154509.GB9807@rkaganip.lan>
References: <20180610184927.19309-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610184927.19309-1-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for Hyper-V TLB flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Sun, Jun 10, 2018 at 08:49:27PM +0200, Vitaly Kuznetsov wrote:
> Add support for Hyper-V TLB flush which recently got added to KVM.
> 
> Just like regular Hyper-V we announce HV_EX_PROCESSOR_MASKS_RECOMMENDED
> regardless of how many vCPUs we have. Windows is 'smart' and uses less
> expensive non-EX Hypercall whenever possible (when it wants to flush TLB
> for all vCPUs or the maximum vCPU index in the vCPU set requires flushing
> is less than 64).

Indeed, reading the spec it sounds like this bit indicates the
availability of hypercalls accepting sparse processor sets, rather than
the recommendation to use them (dunno if we want to ajust the name).

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  linux-headers/linux/kvm.h  |  1 +
>  target/i386/cpu.c          |  1 +
>  target/i386/cpu.h          |  1 +
>  target/i386/hyperv-proto.h |  1 +
>  target/i386/kvm.c          | 15 ++++++++++++++-
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index cdb148e959..a52a685690 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_BPB 152
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
> +#define KVM_CAP_HYPERV_TLBFLUSH 155
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  

This header is imported from the kernel, so, to make life easier for the
maintainers, I tend to post changes to it in a separate patch,
indicating which kernel version contains it (AFAIK it's in kvm/queue
ATM).  But if they actually do want it they'll let you know ;)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

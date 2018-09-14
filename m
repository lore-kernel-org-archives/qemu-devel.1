Received: from eggs.gnu.org ([2001:4830:134:3::10]:58255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0iL2-0005wk-4F
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0iKx-0001fw-Dq
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0iKx-0001eI-2O
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:16:19 -0400
References: <20180914003827.124570-1-liran.alon@oracle.com>
	<20180914003827.124570-3-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e7316db-c24a-6dd5-9e62-1ccc93bf1ee1@redhat.com>
Date: Fri, 14 Sep 2018 09:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180914003827.124570-3-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] KVM: i386: Add support for save and
 restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com
Cc: mtosatti@redhat.com, kvm@vger.kernel.org, jmattson@google.com, idan.brown@oracle.com

On 14/09/2018 02:38, Liran Alon wrote:
> Kernel commit 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
> introduced new IOCTLs to extract and restore KVM internal state used to
> run a VM that is in VMX operation.
> 
> Utilize these IOCTLs to add support of migration of VMs which are
> running nested hypervisors.
> 
> Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
> Reviewed-by: Patrick Colp <patrick.colp@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

Heh, I was going to send a similar patch.  However, things are a bit
more complex for two reason.

First, I'd prefer to reuse the hflags and hflags2 fields that we already
have, and only store the VMCS blob in the subsection.  For example,
HF_SVMI_MASK is really the same as HF_GUEST_MASK in KVM source code and
KVM_STATE_NESTED_GUEST_MODE in the nested virt state.

More important, this:

>   
> +static int nested_state_post_load(void *opaque, int version_id) 
> +{ 
> +    X86CPU *cpu = opaque; 
> +    CPUX86State *env = &cpu->env; 
> + 
> +    /* 
> +     * Verify that the size specified in given struct is set 
> +     * to no more than the size that our kernel support 
> +     */ 
> +    if (env->nested_state->size > env->nested_state_len) { 
> +        return -EINVAL; 
> +    } 
> + 
> +    return 0; 
> +} 
> + 
> +static bool nested_state_needed(void *opaque) 

doesn't work if nested_state_len differs between source and destination,
and could overflow the nested_state buffer if nested_state_len is larger
on the source.

I'll send my version today or next Monday.

Thanks,

Paolo

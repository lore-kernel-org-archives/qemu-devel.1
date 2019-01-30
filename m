Received: from eggs.gnu.org ([209.51.188.92]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gorfL-0005Hi-9X
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gorfJ-0003di-0b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gorfH-0003bK-KW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:20:36 -0500
References: <1548859760-10654-1-git-send-email-liam.merwick@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <906e9e4c-c5ca-fae0-73e5-1b740dbcdf7e@redhat.com>
Date: Wed, 30 Jan 2019 16:20:26 +0100
MIME-Version: 1.0
In-Reply-To: <1548859760-10654-1-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: Potential NULL pointer dereference in
 kvm_arch_init_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: mtosatti@redhat.com

On 30/01/19 15:49, Liam Merwick wrote:
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9af4542fb8a8..89fac4a5576c 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1308,7 +1308,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          c->ecx = c->edx = 0;
>  
>          c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
> -        c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
> +        if (c) {
> +            c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
> +	}
>      }
>  
>      cpuid_data.cpuid.nent = cpuid_i;
> -- 1.8.3.1

That cannot happen, the line is inside "if (cpu->expose_kvm)" which in
turn has added that CPUID entry to cpuid_data.

Thanks,

Paolo

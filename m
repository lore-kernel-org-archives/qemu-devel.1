Received: from eggs.gnu.org ([2001:4830:134:3::10]:36104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dNiUn-0001um-Pi
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dNiUl-0005ch-71
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dNiUl-0005bL-0x
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:28:43 -0400
Date: Wed, 21 Jun 2017 18:28:37 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170621162833.GA22745@potion>
References: <1498014889-52658-1-git-send-email-wanpeng.li@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498014889-52658-1-git-send-email-wanpeng.li@hotmail.com>
Subject: Re: [Qemu-devel] [PATCH] KVM: Add async pf flag to
 KVM_GET/SET_VCPU_EVENTS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>

2017-06-20 20:14-0700, Wanpeng Li:
> From: Wanpeng Li <wanpeng.li@hotmail.com>
> 
> This patch adds async pf flag to KVM_GET/SET_VCPU_EVENTS interface.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
> ---
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> @@ -300,6 +301,7 @@ struct kvm_vcpu_events {
>  		__u8 has_error_code;
>  		__u8 pad;
>  		__u32 error_code;
> +		bool async_page_fault;

Touching userspace interfaces is always a major fun ...

You must not change the layout of an existing structure.  You can try to
reuse the pad and hope that some userspace didn't check it for 0.
(I think it's a decent compromise between safety and sanity.)

>  	} exception;
>  	struct {
>  		__u8 injected;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> @@ -2493,6 +2493,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>      events.exception.has_error_code = env->has_error_code;
>      events.exception.error_code = env->error_code;
>      events.exception.pad = 0;
> +    events.exception.async_page_fault = env->async_page_fault;
>  
>      events.interrupt.injected = (env->interrupt_injected >= 0);

Old QEMUs would break below this point, because interrupt.injected used
to be where exception.async_page_fault is.

>      events.interrupt.nr = env->interrupt_injected;

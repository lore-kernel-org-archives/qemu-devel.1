Received: from eggs.gnu.org ([209.51.188.92]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqED-0000fV-KT
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqEC-0005vX-7F
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:24:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmqEA-0005um-HW
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:24:14 -0500
Received: by mail-pg1-x543.google.com with SMTP id v28so3463912pgk.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 17:24:13 -0800 (PST)
References: <20190118140758.829-1-farosas@linux.ibm.com>
	<20190118140758.829-4-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a5038b41-8c7f-d8ba-528a-2ea5875ad30f@ozlabs.ru>
Date: Fri, 25 Jan 2019 12:24:06 +1100
MIME-Version: 1.0
In-Reply-To: <20190118140758.829-4-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 3/7] kvm: support checking for
 single step capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com



On 19/01/2019 01:07, Fabiano Rosas wrote:
> For single stepping (via KVM) of a guest vcpu to work, KVM needs not
> only to support the SET_GUEST_DEBUG ioctl but to also recognize the
> KVM_GUESTDBG_SINGLESTEP bit in the control field of the
> kvm_guest_debug struct.
> 
> This patch adds support for querying the single step capability so
> that QEMU can decide what to do for the platforms that do not have
> such support.


Belongs to 4/7.


> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  accel/kvm/kvm-all.c  | 7 +++++++
>  include/sysemu/kvm.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4e1de942ce..0dc7a32883 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2264,6 +2264,13 @@ bool kvm_arm_supports_user_irq(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
>  }
>  
> +/* Whether the KVM_SET_GUEST_DEBUG ioctl supports single stepping */
> +int kvm_has_guestdbg_singlestep(void)
> +{
> +    /* return kvm_check_extension(kvm_state, KVM_CAP_GUEST_DEBUG_SSTEP); */
> +    return 0;
> +}
> +
>  #ifdef KVM_CAP_SET_GUEST_DEBUG
>  struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
>                                                   target_ulong pc)
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index a6d1cd190f..ca2bbff053 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -214,6 +214,7 @@ int kvm_has_pit_state2(void);
>  int kvm_has_many_ioeventfds(void);
>  int kvm_has_gsi_routing(void);
>  int kvm_has_intx_set_mask(void);
> +int kvm_has_guestdbg_singlestep(void);
>  
>  int kvm_init_vcpu(CPUState *cpu);
>  int kvm_cpu_exec(CPUState *cpu);
> 

-- 
Alexey

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY9L5-00089l-UM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY9L0-0007CF-VC
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:14:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fY9L0-0007A2-15
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:14:18 -0400
References: <cover.1522769774.git.jan.kiszka@web.de>
	<fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
Date: Wed, 27 Jun 2018 14:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target-i386: Add NPT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

On 03/04/2018 17:36, Jan Kiszka wrote:
>  
> +static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
> +                        int *prot)
> +{
> +    CPUX86State *env = &X86_CPU(cs)->env;
> +    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
> +    uint64_t ptep, pte;
> +    uint64_t exit_info_1 = 0;
> +    target_ulong pde_addr, pte_addr;
> +    uint32_t page_offset;
> +    int page_size;
> +
> +    if (likely(!(env->hflags & HF_NPT_MASK))) {
> +        return gphys;
> +    }

hflags are a somewhat limited resource.  Can this go in hflags2?

> 
> +
> +        env->nested_pg_mode = 0;
> +        if (env->cr[4] & CR4_PAE_MASK) {
> +            env->nested_pg_mode |= SVM_NPT_PAE;
> +        }
> +        if (env->hflags & HF_LMA_MASK) {
> +            env->nested_pg_mode |= SVM_NPT_LMA;
> +        }
> +        if (env->efer & MSR_EFER_NXE) {
> +            env->nested_pg_mode |= SVM_NPT_NXE;
> +        }
> +    }
> +

This needs to be migrated.  You can put it in a subsection, conditional
on hflags & HF_SVMI_MASK.

Also, do you need to flush the TLB unconditionally, even if CR0.PG is zero?

Otherwise looks good.  I have queued patches 1-3, but hopefully this one
can go in the next release too.  Sorry for the delayed review.

Paolo

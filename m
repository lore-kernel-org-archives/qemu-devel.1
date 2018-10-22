Received: from eggs.gnu.org ([2001:4830:134:3::10]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gEbHe-0007fx-M2
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gEbHY-0000Ha-LN
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:34:18 -0400
Received: from mail-db5eur01hn0310.outbound.protection.outlook.com
	([2a01:111:f400:fe02::310]:6294
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gEbHY-0000FM-45
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:34:12 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 22 Oct 2018 14:33:59 +0000
Message-ID: <20181022143355.GA5839@rkaganb.sw.ru>
References: <20181019111432.5040-1-vkuznets@redhat.com>
	<20181019111432.5040-3-vkuznets@redhat.com>
In-Reply-To: <20181019111432.5040-3-vkuznets@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2F7E3CEC4B4C64487696E12ECAB0F6E@eurprd08.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] x86: hv_evmcs CPU flag support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Fri, Oct 19, 2018 at 01:14:32PM +0200, Vitaly Kuznetsov wrote:
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -798,6 +798,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      uint32_t unused;
>      struct kvm_cpuid_entry2 *c;
>      uint32_t signature[3];
> +    uint16_t evmcs_version;
>      int kvm_base = KVM_CPUID_SIGNATURE;
>      int r;
>      Error *local_err = NULL;
> @@ -841,7 +842,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              memset(signature, 0, 12);
>              memcpy(signature, cpu->hyperv_vendor_id, len);
>          }
> -        c->eax = HV_CPUID_MIN;
> +        c->eax = cpu->hyperv_evmcs ? HV_CPUID_MIN_NESTED : HV_CPUID_MIN;


I think these two aren't meant to be used on the hypervisor side.  My
understanding is that HV_CPUID_MIN is only there as a reminder that the
real Hyper-V exposes at least that many hypervisor-specific leaves so
the guest can rely on that.  So I'd rather use directly
HV_CPUID_IMPLEMENT_LIMITS : HV_CPUID_NESTED_FEATURES, and not introduce
HV_CPUID_MIN_NESTED.  Maybe better yet is to update this field with the
maximum value while populating HV_* leaves:

    if (hyperv_enabled(cpu)) {
        uint32_t *cpuid_40000000_eax;
        c = &cpuid_data.entries[cpuid_i++];
        c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
        cpuid_40000000_eax = &c->eax;
        *cpuid_40000000_eax = c->function;

        ....

        c = &cpuid_data.entries[cpuid_i++];
        c->function = HV_CPUID_...;
        *cpuid_40000000_eax = max(*cpuid_40000000_eax, c->function);

but I think it can be done later and doesn't need to hold this patch.

Another question related to this: are the guests OK with leaves
0x40000006..0x40000009 missing?

Thanks,
Roman.

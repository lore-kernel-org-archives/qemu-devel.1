Received: from eggs.gnu.org ([2001:4830:134:3::10]:34737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1emyCg-0005sZ-FM
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1emyCb-0003aJ-JC
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:50:42 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1emyCb-0003ZZ-BA
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:50:37 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v71so6867984wmv.2
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 00:50:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <151880471076.4588.45148319107456140.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <023cad71-d72f-c7d6-8cb4-4760658e148e@redhat.com>
Date: Sat, 17 Feb 2018 09:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <151880471076.4588.45148319107456140.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: add stubs for kvm_vcpu_id_is_valid()
 and kvm_arch_vcpu_id()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On 16/02/2018 19:11, Greg Kurz wrote:
> These two functions are essentially called by code that is only
> compiled when CONFIG_KVM=y, with the notable exception of the
> two users in the sPAPR code:
> 
> $ git grep -E -l 'kvm_arch_vcpu_id|kvm_vcpu_id_is_valid'
> accel/kvm/kvm-all.c
> hw/intc/openpic_kvm.c
> hw/intc/xics_kvm.c
> hw/ppc/spapr.c
> include/sysemu/kvm.h
> target/arm/kvm.c
> target/i386/kvm.c
> target/mips/kvm.c
> target/ppc/kvm.c
> target/s390x/kvm.c
> 
> In hw/ppc/spapr.c:
> 
>     if (kvm_enabled()) {
>         return kvm_arch_vcpu_id(cs);
>     } else {
>         return cs->cpu_index;
>     }
> 
> and
> 
>         if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
>             ...
>         }
> 
> This code happens to compile without CONFIG_KVM=y simply because
> kvm_enabled() expands to (0) and the compiler optimizes the dead
> code away. Unless this was done on purpose

Yes, it is.  There are more examples, the first I saw is:

    uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
        : SPAPR_TIMEBASE_FREQ;
    uint32_t cpufreq = kvm_enabled() ? kvmppc_get_clockfreq() : 1000000000;

> to indicate no stubs
> are required, and we'd rather break the build if calling these
> from KVM agnostic code

That's the idea. :)

Paolo

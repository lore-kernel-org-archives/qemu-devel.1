Received: from eggs.gnu.org ([2001:4830:134:3::10]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f479f-0006GY-L0
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f479c-0002al-Hj
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:50:27 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f479c-0002ad-7u
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:50:24 -0400
Received: by mail-wm0-x232.google.com with SMTP id r131so8480587wmb.2
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 08:50:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180326170658.606-1-juterry@microsoft.com>
	<20180328175050.GH5046@localhost.localdomain>
	<DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de10b07e-3ce7-e1e1-f437-792fe246d218@redhat.com>
Date: Thu, 5 Apr 2018 17:50:20 +0200
MIME-Version: 1.0
In-Reply-To: <DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] WHPX fixes an issue with CPUID 1 not
 returning CPUID_EXT_HYPERVISOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rth@twiddle.net" <rth@twiddle.net>

On 28/03/2018 22:48, Justin Terry (VM) wrote:
> 1. (As the code is doing now). At partition creation time you can
> register for specific CPUID exits and then respond to the CPUID with
> your custom answer or with the Hypervisor defaults that were forwarded
> to you. Unfortunately, QEMU has no way to know the Hypervisor default
> ahead of time but QEMU can make at least make a runtime decision about
> how to respond.
>
> 2. At partition creation time the platform allows QEMU to inject (set)
> the default responses for specific CPUID exits.

... but it still cannot access the hypervisor defaults, right?

> This can now be done by
> setting the `WHV_X64_CPUID_RESULT` in the `CpuidResultList` of
> `WHV_PARTITION_PROPERTY` to the exit values QEMU wants. So effectively
> you can know the answers ahead of time for any that you set but the
> answers are not dynamic.
> 
> The only issues/questions I have there are:
> 
> If we use [1] (like the code is now) I don't see any way to keep the
> exits in cpu_x86_cpuid() matched up with the registered exits to WHPX.

You'd have to do that on a case-by-case basis.  For example, the number
of leaves can be the minimum of the hypervisor and QEMU values, or just
the QEMU value; for "feature" leaves the results will be the AND of the
QEMU and WHPX features; for the XSAVE/XSAVEC/XSAVES (size, offset)
tuples you have to use WHPX's; for family/model/stepping/name/vendor
your mileage may vary but I suppose you can just use WHPX's; and so on.

You can take a look at target/i386/cpu.c's array feature_word_info and
add a function like

void x86_is_feature_word(uint32_t eax, uint32_t ecx, int reg)
{
    for (w = 0; w < FEATURE_WORDS; w++) {
        FeatureWordInfo *wi = &feature_word_info[w];
        if (eax == wi->cpuid_eax &&
            (ecx == wi->cpuid_ecx || wi->cpuid_needs_ecx) &&
            reg == wi->cpuid_reg) {
            return true;
        }
    }
    return false;
}

so that the code in the end is

    switch (eax) {
        /* yadda yadda... code to special case leaves whose value
         * comes from WHPX.
         */
        ...
    default:
        if (x86_is_feature_word(eax, ecx, R_EAX)) {
            rax &= vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
        }
        if (x86_is_feature_word(eax, ecx, R_EBX)) {
            rax &= vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
        }
        if (x86_is_feature_word(eax, ecx, R_ECX)) {
            rax &= vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
        }
        if (x86_is_feature_word(eax, ecx, R_EDX)) {
            rax &= vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
        }
    }

> If we use [2] to inject the answers at creation time WHPX needs access
> to the CPUX86State at accel init which also doesn't seem to be possible
> in QEMU today. WHPX could basically just call cpu_x86_cpuid() for each
> CPUID QEMU cares about and plumb the answer before start. This has the
> best performance as we avoid the additional exits but has an issue in
> that the results must be known ahead of time.

The earliest where you have access to that is x86_cpu_initfn.

Paolo

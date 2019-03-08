Received: from eggs.gnu.org ([209.51.188.92]:56358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h2KfT-0008SU-5U
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h2KfS-0007Kt-0S
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:56:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h2KfR-0007JE-La
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:56:25 -0500
Date: Fri, 8 Mar 2019 15:56:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190308185621.GA17141@habkost.net>
References: <20181227024304.12182-1-tao3.xu@intel.com>
	<20181227024304.12182-3-tao3.xu@intel.com>
	<20190114183545.GB28115@habkost.net>
	<ad912a4e-986b-61d3-0fd8-1047ecabd651@intel.com>
	<20190123191550.GX4136@habkost.net>
	<ab92f502-bc96-34fd-0b21-6d1918648549@intel.com>
	<20190128144848.GS4136@habkost.net>
	<cfac07a0-bd3b-d10f-0edb-a31a8207b6af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfac07a0-bd3b-d10f-0edb-a31a8207b6af@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>
Cc: thomas.lendacky@amd.com, qemu-devel@nongnu.org, robert.hu@linux.intel.com, pbonzini@redhat.com, xuelian.guo@intel.com, rth@twiddle.net

Hi,

Sorry for taking so long to reply.  I was away from work for a
few weeks and I'm still catching up on old threads.  Reply below:

On Tue, Jan 29, 2019 at 04:55:20PM +0800, Tao Xu wrote:
> On 1/28/2019 10:48 PM, Eduardo Habkost wrote:
> > On Mon, Jan 28, 2019 at 04:33:40PM +0800, Tao Xu wrote:
> > > On 1/24/2019 3:15 AM, Eduardo Habkost wrote:
> > > > On Mon, Jan 21, 2019 at 05:29:32PM +0800, Tao Xu wrote:
> > > > > On 1/15/2019 2:35 AM, Eduardo Habkost wrote:
> > > > > > Sorry, we do have a problem here:
> > > > > > 
> > > > > > On Thu, Dec 27, 2018 at 10:43:04AM +0800, Tao Xu wrote:
> > > > > > [...]
> > > > > > >     #define PC_COMPAT_3_0 \
> > > > > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > > > > index 09706ad51a..5296c73cd5 100644
> > > > > > > --- a/target/i386/cpu.c
> > > > > > > +++ b/target/i386/cpu.c
> > > > > > > @@ -2499,7 +2499,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
> > > > > > >                 CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
> > > > > > >                 CPUID_7_0_ECX_AVX512VNNI,
> > > > > > >             .features[FEAT_7_0_EDX] =
> > > > > > > -            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > > > > > > +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
> > > > > > > +            CPUID_7_0_EDX_ARCH_CAPABILITIES,
> > > > > > 
> > > > > > CPUID_7_0_EDX_ARCH_CAPABILITIES is still set on
> > > > > > unmigratable_flags.  We need to make it migratable before adding
> > > > > > it by default to a named CPU model.
> > > > > > 
> > > > > Hi Eduardo,
> > > > > 
> > > > > Do you mean I need to remove CPUID_7_0_EDX_ARCH_CAPABILITIES
> > > > > from .migratable_flags? Or CPUID_7_0_EDX_ARCH_CAPABILITIES can not
> > > > > support migration now?
> > > > 
> > > > We need to remove it from .unmigratable_flags, but only after
> > > > confirm it is really migration-safe.  To make it migration-safe,
> > > > the MSR value seen by the guest must have a predictable value
> > > > that is 100% independent from host hardware or host software
> > > > version.
> > > > 
> > > > This is easy to ensure if MSR_IA32_ARCH_CAPABILITIES is in
> > > > KVM_GET_MSR_INDEX_LIST (meaning QEMU can actually configure the
> > > > MSR value seen by the guest).  If MSR_IA32_ARCH_CAPABILITIES is
> > > > not on KVM_GET_MSR_INDEX_LIST, arch-capabilities must not be
> > > > returned by x86_cpu_get_supported_feature_word() when
> > > > migratable_only is true.
> > > > 
> > > Thank you. I have seen your patch to migratable it:
> > > 
> > > [PATCH 0/2] i386: arch_capabilities fixes + migratability
> > > http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06701.html
> > > 
> > > So now can arch-capabilities and features exposed by it be added in
> > > Cascadelake CPU model? Because Cascadelake CPU model can support it in
> > > hardware. And for Icelake CPU model, Robert will add in the future.
> > 
> > Even if there's host hardware support for the MSR, the feature
> > still depends on a KVM commit added in Linux v6.16 (commit
                                                  ^^^^

Sorry, I meant "4.16" above.

> > 28c1c9fabf48 "KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES").  We
> > would still have the kernel version dependency described below.
> > 
> Sorry, we are still confused about it. I read the kernel commit 28c1c9fabf48
> again. This commit indeed enabling ARCH_CAPABILITIES and emulate it in the
> platform which doesn't support it in hardware. But with your patch, the
> ARCH_CAPABILITIES is like other CPU new features. When the guest start up
> with old host kernel, it will just warning "warning: host doesn't support
> requested feature...". Beside the warnings, will this has other further
> problems?

This is not a harmless warning if you need live migration.  Any
management software that supports live migration must ensure the
chosen CPU model is fully supported by the host (by using
query-cpu-* commands or using the "enforce" flag), and existing
VM configurations using Cascadelake CPU model would stop running
on < v4.16 hosts if Cascadelake starts requiring
arch-capabilities.

> And other feature will have the same problem?

We had similar issues with other features, and we have tried
different solutions:

SPEC_CTRL requires a host microcode update + Linux >= v4.16, and
we have added new CPU models for it (the -IBRS variants).

Some Opteron CPU models didn't have RDTSCP, and the feature
requires Linux >= v4.5.  We could add RDTSCP to the existing CPU
models because we documented the minimum host kernel version on
qemu-doc.texi.

SSBD requires a host microcode update + Linux >= v4.17.  We
decided to not add new -SSBD CPU models, and let management
software enable the flag when it knows it's safe.


> 
> I am sorry for so many questions and this is really a tricky issue. Indeed,
> the versioned CPU model will solve the problem of user using the old version
> of kernel. But maybe it will have a long time to in-placement.
> 

It's too late to implement that in QEMU 4.0, but we could aim to
do it in 4.1.

Note that this doesn't block people from using the feature.  The
features above are already enabled automatically by management
software using libvirt's "host-model" mode.  Versioned CPU models
will just make things more convenient for management software and
people running QEMU from the command-line.


-- 
Eduardo

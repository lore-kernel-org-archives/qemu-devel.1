Received: from eggs.gnu.org ([2001:4830:134:3::10]:59139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d11nq-0000fa-Gg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 22:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d11nm-0005T6-FU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 22:26:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d11nm-0005Sq-6S
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 22:26:34 -0400
Date: Wed, 19 Apr 2017 23:26:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170420022629.GD25239@thinpad.lan.raisama.net>
References: <20170419195413.30141-1-bobby.prani@gmail.com>
	<20170419195413.30141-2-bobby.prani@gmail.com>
	<CAJhHMCAfexwn92bt0=rfzBB0hbgqzCpRpgnsEXbG5cnmnFYztA@mail.gmail.com>
	<20170419201314.GX25239@thinpad.lan.raisama.net>
	<CAJhHMCDpJhRoeGXRvPdqLD7zeVh_dmKX9wDcZcCSFwLj_+Cwkw@mail.gmail.com>
	<20170419205706.GY25239@thinpad.lan.raisama.net>
	<CAJhHMCBN8N27M7H4a3ayv6rezKoc9+UH5xPqE4Pu2MPYKD8RgQ@mail.gmail.com>
	<20170419213349.GC25239@thinpad.lan.raisama.net>
	<CAJhHMCB1GBC6ay4O61gnF8NtHg9+DCVR3dAcVjd253-GX3BoAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhHMCB1GBC6ay4O61gnF8NtHg9+DCVR3dAcVjd253-GX3BoAw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Do not display HT warning for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Wed, Apr 19, 2017 at 06:03:01PM -0400, Pranith Kumar wrote:
> On Wed, Apr 19, 2017 at 5:33 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Wed, Apr 19, 2017 at 05:25:23PM -0400, Pranith Kumar wrote:
> >> On Wed, Apr 19, 2017 at 4:57 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> > On Wed, Apr 19, 2017 at 04:16:53PM -0400, Pranith Kumar wrote:
> >> >> On Wed, Apr 19, 2017 at 4:13 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> >> > On Wed, Apr 19, 2017 at 04:00:49PM -0400, Pranith Kumar wrote:
> >> >> >> On Wed, Apr 19, 2017 at 3:54 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> >> >> >> > When we enable hyperthreading (using threads smp argument), we warn
> >> >> >> > the user if the cpu is an AMD cpu. This does not make sense on TCG and
> >> >> >> > is also obsolete now that AMD Ryzen support hyperthreading.
> >> >> >> >
> >> >> >> > Fix this by adding CPUID_HT bit to the TCG features and explicitly
> >> >> >> > checking this bit in the cpuid.
> >> >> >> >
> >> >> >> > Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> >> >> >> > ---
> >> >> >> >  target/i386/cpu.c | 10 +++++-----
> >> >> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >> >> >
> >> >> >> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> >> >> > index 13c0985f11..f34bb5ead7 100644
> >> >> >> > --- a/target/i386/cpu.c
> >> >> >> > +++ b/target/i386/cpu.c
> >> >> >> > @@ -202,12 +202,12 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
> >> >> >> >  #define TCG_FEATURES (CPUID_FP87 | CPUID_PSE | CPUID_TSC | CPUID_MSR | \
> >> >> >> >            CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
> >> >> >> >            CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
> >> >> >> > -          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
> >> >> >> > +          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | CPUID_HT | \
> >> >> >> >            CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
> >> >> >> >            /* partly implemented:
> >> >> >> >            CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
> >> >> >> >            /* missing:
> >> >> >> > -          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
> >> >> >> > +          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
> >> >> >> >  #define TCG_EXT_FEATURES (CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | \
> >> >> >> >            CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | \
> >> >> >> >            CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_POPCNT | \
> >> >> >> > @@ -3643,7 +3643,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >> >> >> >
> >> >> >> >      qemu_init_vcpu(cs);
> >> >> >> >
> >> >> >> > -    /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
> >> >> >> > +    /* Only some CPUs support hyperthreading. Even though QEMU fixes this
> >> >> >> >       * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
> >> >> >> >       * based on inputs (sockets,cores,threads), it is still better to gives
> >> >> >> >       * users a warning.
> >> >> >> > @@ -3651,8 +3651,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >> >> >> >       * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
> >> >> >> >       * cs->nr_threads hasn't be populated yet and the checking is incorrect.
> >> >> >> >       */
> >> >> >> > -    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
> >> >> >> > -        error_report("AMD CPU doesn't support hyperthreading. Please configure"
> >> >> >> > +    if ((env->features[FEAT_1_EDX] & CPUID_HT) && (cs->nr_threads > 1) && !ht_warned) {
> >> >> >>
> >> >> >> I missed a '!' here. We need to warn if CPUID_HT is not set. But I see
> >> >> >> that it is not being set even on HT enabled processors (i7-3770). How
> >> >> >> do I test for it?
> >> >> >
> >> >> > CPUID_HT is automatically set on the CPU if
> >> >> > (nr_threads * nr_cores) > 1. See the "case 1:" block in
> >> >> > cpu_x86_cpuid().
> >> >> >
> >> >> > AFAIK, the point of the warning is to let the user know that the
> >> >> > guest OS is likely to ignore thread topology information if CPUID
> >> >> > vendor is not Intel, and has nothing to do with TCG or KVM
> >> >> > capabilities. Maybe the warning is obsolete today and guests
> >> >> > won't be confused by a HT AMD CPU, but we need to confirm that.
> >> >>
> >> >> We assume an AMD cpu for x86 TCG and it prints this warning when an
> >> >> smp guest is run with (cores=2,threads=2) argument. The main point of
> >> >> this patch is to remove that warning when using TCG.
> >> >
> >> > What is different under TCG? If guests were confused with
> >> > threads=2 + vendor=AMD using KVM, what exactly would make them
> >> > not confused by threads=2 + vendor=AMD when using TCG?
> >>
> >> I am not sure why we chose AMD to be the vendor for TCG since, as you
> >> note, it does not really matter if it's AMD or Intel in TCG mode.
> >
> > I don't know why the default on TCG is AMD, either.
> >
> >>
> >> >
> >> > I just ran a Fedora 25 guest using "-machine accel=tcg
> >> > -smp 2,threads=2", and it still thinks it's running on a 2-core
> >> > CPU instead of a 2-thread CPU when CPU vendor is AMD.
> >>
> >> This all started with using Windows XP. It has an arbitrary limit on
> >> the number of cores it can support to 2 cores. So using -smp 4 will
> >> still only show 2 cores. However, we can overcome this by using -smp
> >> cores=2,threads=2 and 4 cores show up in the guest. But we see the
> >> ugly warning that HT is not supported on AMD cpus.
> >
> > Is Windows XP able to detect 2 threads * 2 cores even if CPUID
> > vendor is AMD?
> >
> 
> Yep. I don't think it cares for vendor id.

What happens if you use -smp 4,cores=4 ?

> 
> >> So we can either:
> >>
> >> * Change the vendor to Intel for TCG, or
> >> * Warn based on the HT bit being set
> >
> > Could you clarify what you mean by the second item? The HT bit is
> > always set when nr_cores*nr_threads > 1.
> 
> Hmm, I see it now. We just warn the user if the host processor does
> not support HT.

We don't look at the host processor at all: the warn depends only
on the CPUID data we're showing to the guest.

> 
> So how about setting the HT bit only if the host processor supports
> it? Or since it apparently does not matter anyway, remove the warning
> entirely?

The host processor doesn't matter. What matters is the CPUID
data seen by the guest, and it doesn't matter if we're using TCG
or KVM.

Linux guests seem to ignore the hyperthreading information if
vendor ID is AMD, and that seems to be the original reason for
the warning. I would like to remove the warning, too, but it
looks like this fact hasn't changed.

-- 
Eduardo

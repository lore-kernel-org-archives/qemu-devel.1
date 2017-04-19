Received: from eggs.gnu.org ([2001:4830:134:3::10]:34003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0w2Y-0002o2-Cr
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0w2W-0000CT-Tg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:17:26 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:36027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d0w2W-0000CK-P1
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:17:24 -0400
Received: by mail-yw0-x242.google.com with SMTP id 203so3500436ywk.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 13:17:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170419201314.GX25239@thinpad.lan.raisama.net>
References: <20170419195413.30141-1-bobby.prani@gmail.com>
	<20170419195413.30141-2-bobby.prani@gmail.com>
	<CAJhHMCAfexwn92bt0=rfzBB0hbgqzCpRpgnsEXbG5cnmnFYztA@mail.gmail.com>
	<20170419201314.GX25239@thinpad.lan.raisama.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 19 Apr 2017 16:16:53 -0400
Message-ID: <CAJhHMCDpJhRoeGXRvPdqLD7zeVh_dmKX9wDcZcCSFwLj_+Cwkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Do not display HT warning for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Wed, Apr 19, 2017 at 4:13 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Wed, Apr 19, 2017 at 04:00:49PM -0400, Pranith Kumar wrote:
>> On Wed, Apr 19, 2017 at 3:54 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
>> > When we enable hyperthreading (using threads smp argument), we warn
>> > the user if the cpu is an AMD cpu. This does not make sense on TCG and
>> > is also obsolete now that AMD Ryzen support hyperthreading.
>> >
>> > Fix this by adding CPUID_HT bit to the TCG features and explicitly
>> > checking this bit in the cpuid.
>> >
>> > Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> > ---
>> >  target/i386/cpu.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> > index 13c0985f11..f34bb5ead7 100644
>> > --- a/target/i386/cpu.c
>> > +++ b/target/i386/cpu.c
>> > @@ -202,12 +202,12 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>> >  #define TCG_FEATURES (CPUID_FP87 | CPUID_PSE | CPUID_TSC | CPUID_MSR | \
>> >            CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
>> >            CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
>> > -          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
>> > +          CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | CPUID_HT | \
>> >            CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
>> >            /* partly implemented:
>> >            CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
>> >            /* missing:
>> > -          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
>> > +          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
>> >  #define TCG_EXT_FEATURES (CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | \
>> >            CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | \
>> >            CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_POPCNT | \
>> > @@ -3643,7 +3643,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>> >
>> >      qemu_init_vcpu(cs);
>> >
>> > -    /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
>> > +    /* Only some CPUs support hyperthreading. Even though QEMU fixes this
>> >       * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
>> >       * based on inputs (sockets,cores,threads), it is still better to gives
>> >       * users a warning.
>> > @@ -3651,8 +3651,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>> >       * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
>> >       * cs->nr_threads hasn't be populated yet and the checking is incorrect.
>> >       */
>> > -    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
>> > -        error_report("AMD CPU doesn't support hyperthreading. Please configure"
>> > +    if ((env->features[FEAT_1_EDX] & CPUID_HT) && (cs->nr_threads > 1) && !ht_warned) {
>>
>> I missed a '!' here. We need to warn if CPUID_HT is not set. But I see
>> that it is not being set even on HT enabled processors (i7-3770). How
>> do I test for it?
>
> CPUID_HT is automatically set on the CPU if
> (nr_threads * nr_cores) > 1. See the "case 1:" block in
> cpu_x86_cpuid().
>
> AFAIK, the point of the warning is to let the user know that the
> guest OS is likely to ignore thread topology information if CPUID
> vendor is not Intel, and has nothing to do with TCG or KVM
> capabilities. Maybe the warning is obsolete today and guests
> won't be confused by a HT AMD CPU, but we need to confirm that.

We assume an AMD cpu for x86 TCG and it prints this warning when an
smp guest is run with (cores=2,threads=2) argument. The main point of
this patch is to remove that warning when using TCG.

-- 
Pranith

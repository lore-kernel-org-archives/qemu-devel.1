Received: from eggs.gnu.org ([2001:4830:134:3::10]:44446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctCF3-0001IX-IR
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctCEx-0006PY-W4
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:58:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctCEx-0006PN-QQ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:58:15 -0400
Date: Wed, 29 Mar 2017 08:58:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170329115812.GA3709@thinpad.lan.raisama.net>
References: <20170329043257.20595-1-bobby.prani@gmail.com>
	<1cabafab-801b-80c8-5476-db605c8edd73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cabafab-801b-80c8-5476-db605c8edd73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Display AMD HT warning only for
 KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>, kvm@vger.kernel.org

On Wed, Mar 29, 2017 at 10:31:13AM +0200, Paolo Bonzini wrote:
> On 29/03/2017 06:32, Pranith Kumar wrote:
> > TCG uses the AMD cpu which warns when we use hyperthreading. Disable
> > the warning for TCG since it is not necessary.
> > 
> > Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 7aa762245a..66242893b6 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3647,7 +3647,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >       * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
> >       * cs->nr_threads hasn't be populated yet and the checking is incorrect.
> >       */
> > -    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
> > +    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned && kvm_enabled()) {
> >          error_report("AMD CPU doesn't support hyperthreading. Please configure"
> >                       " -smp options properly.");
> >          ht_warned = true;
> 
> AMD Zen supports hyperthreading.  We should check if it uses the same
> CPUID leaves and drop the if completely (but not in 2.9).

AMD's CPUID specification documents the same bit
(CPUID[1].EDX[bit 28]) as "HTT: hyper-threading technology".

However:

* Their Extended Method for topology enumeration
  ignores HTT and CmpLegacy, and has contiguous APIC IDs assigned
  for each core[1]. I don't know if their Extended Method is
  compatible[2] with the topology information we expose when
  nr_threads>1. (I expect it to be compatible, but I'm not sure.)
* Their docs for the Legacy Method for CPU topology enumeration
  don't mention what to do if CmpLegacy=0, HTT=1.

[1] The APIC ID formula is:
    LocalApicId[proc=i, core=j] = (OFFSET_IDX + i) * MNC + j
[2] By compatible, I mean placing the cores/threads at the right
    physical processor, at least (even if it treats each thread
    as a separate core).

-- 
Eduardo

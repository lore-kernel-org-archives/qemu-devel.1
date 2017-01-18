Received: from eggs.gnu.org ([2001:4830:134:3::10]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTs5f-0004Ze-5s
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTs5c-0005fJ-1y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:23:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTs5b-0005eo-Sf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:23:55 -0500
Date: Wed, 18 Jan 2017 13:23:52 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118152352.GZ3491@thinpad.lan.raisama.net>
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
	<aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] x86-KVM: Supply TSC and APIC clock rates
 to guest like VMWare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Wed, Jan 18, 2017 at 04:05:59PM +0100, Paolo Bonzini wrote:
> 
> 
> On 18/01/2017 15:24, Phil Dennis-Jordan wrote:
> > ---
> >  target/i386/cpu.c |  1 +
> >  target/i386/cpu.h |  4 ++++
> >  target/i386/kvm.c | 40 ++++++++++++++++++++++++++++++++--------
> >  3 files changed, 37 insertions(+), 8 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index aba11ae..e5523d4 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3677,6 +3677,7 @@ static Property x86_cpu_properties[] = {
> >      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> >      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> >      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> > +    DEFINE_PROP_BOOL("vmware-tsc-apic-clocks", X86CPU, vmware_clock_rates, false),
> 
> Maybe just vmware-cpuid-freq instead?  Whatever the choice, please make
> the bool field in struct X86CPU consistent with the property name (e.g.
> enable_vmware_cpuid_freq).
> 
> One issue is that the TSC frequency can change, for example on
> migration.  Telling the guest about the TSC frequency makes little sense
> if it can change.
> 
> So the leaf should be conditional on the INVTSC feature
> (CPUID[0x80000007].EDX bit 8).  You can enable this unconditionally for
> new machine types (i.e. making it true here, and turning it off in
> include/hw/i386/pc.h's PC_COMPAT_2_8 macro), but only expose it if that
> bit is also set.

It can be made conditional on (invtsc || cpu->user_tsc_khz). If
the TSC frequency is configured explicitly, we know it won't
change.

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d84Q9-0004gQ-3n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d84Q5-0004fq-13
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d84Q4-0004fR-Nl
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:39:12 -0400
Date: Tue, 9 May 2017 13:39:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170509123906.GG1669@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170509112034.23351-1-berrange@redhat.com>
	<20170509112034.23351-3-berrange@redhat.com>
	<20170509115228.GA3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170509115228.GA3482@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] i386: expose "TCGTCGTCGTCG" in the
 0x40000000 CPUID leaf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 09, 2017 at 08:52:28AM -0300, Eduardo Habkost wrote:
> On Tue, May 09, 2017 at 12:20:34PM +0100, Daniel P. Berrange wrote:
> > Currently when running KVM, we expose "KVMKVMKVM\0\0\0" in
> > the 0x40000000 CPUID leaf. Other hypervisors (VMWare,
> > HyperV, Xen, BHyve) all do the same thing, which leaves
> > TCG as the odd one out.
> > 
> > The CPUID signature is used by software to detect which
> > virtual environment they are running in and (potentially)
> > change behaviour in certain ways. For example, systemd
> > supports a ConditionVirtualization= setting in unit files.
> > The virt-what command can also report the virt type it is
> > running on
> > 
> > Currently both these apps have to resort to custom hacks
> > like looking for 'fw-cfg' entry in the /proc/device-tree
> > file to identify TCG.
> > 
> > This change thus proposes a signature "TCGTCGTCGTCG" to be
> > reported when running under TCG.
> > 
> > To hide this, the -cpu option tcg-cpuid=off can be used.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  include/hw/i386/pc.h |  5 +++++
> >  target/i386/cpu.c    | 22 ++++++++++++++++++++++
> >  target/i386/cpu.h    |  1 +
> >  3 files changed, 28 insertions(+)
> > 
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index f278b3a..3aec60f 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -376,6 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >  #define PC_COMPAT_2_8 \
> >      HW_COMPAT_2_8 \
> >      {\
> > +        .driver   = TYPE_X86_CPU,\
> > +        .property = "tcg-cpuid",\
> > +        .value    = "off",\
> > +    },\
> > +    {\
> >          .driver   = "kvmclock",\
> >          .property = "x-mach-use-reliable-get-clock",\
> >          .value    = "off",\
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 8cb4af4..ee4f515 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2627,12 +2627,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >      CPUState *cs = CPU(cpu);
> >      uint32_t pkg_offset;
> >      uint32_t limit;
> > +    uint32_t signature[3];
> >  
> >      /* Calculate & apply limits for different index ranges */
> >      if (index >= 0xC0000000) {
> >          limit = env->cpuid_xlevel2;
> >      } else if (index >= 0x80000000) {
> >          limit = env->cpuid_xlevel;
> > +    } else if (index & 0x40000000) {
> 
> Why did you decide to use (index & 0x40000000) instead of
> (index >= 0x40000000)? The latter would be more consistent with
> the rest of the code.

It was just a mistake.

> > +        limit = 0x40000000;
> 
> This is not strictly wrong, but it will make CPUID[0x40000001]
> return arbitrary bits (CPUID[env->cpuid_level]). Guests aren't
> supposed to look at CPUID[0x40000001] without checking
> CPUID[0x40000000] first, but probably it's safer to set
> limit = 0x40000001 and return all-zeroes on CPUID[0x40000001],
> just in case.

Ok

> >      } else {
> >          limit = env->cpuid_level;
> >      }
> > @@ -2867,6 +2870,24 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >          }
> >          break;
> >      }
> > +    case 0x40000000:
> > +        /*
> > +         * CPUID code in kvm_arch_init_vcpu() ignores stuff
> > +         * set here, but we restrict to TCG none the less.
> > +         */
> > +        if (tcg_enabled() && cpu->expose_tcg) {
> > +            memcpy(signature, "TCGTCGTCGTCG", 12);
> > +            *eax = 0;
> 
> On both KVM and Hyper-V, CPUID[0x40000000].EAX is the maximum
> CPUID function. KVM has the additional exception that eax=0 on
> the output is interpreted as 0x40000001.
> 
> Setting this to 0x40000000 or 0x40000001 would make things more
> consistent for guests. Setting it to 0x40000001 would make it
> safer (see my other comment above).

Yep, makes sense.

> 
> 
> > +            *ebx = signature[0];
> > +            *ecx = signature[1];
> > +            *edx = signature[2];
> > +        } else {
> > +            *eax = 0;
> > +            *ebx = 0;
> > +            *ecx = 0;
> > +            *edx = 0;
> > +        }
> > +        break;

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

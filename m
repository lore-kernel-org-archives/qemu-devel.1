Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6gN1-0001v9-BD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6gMy-0001YW-89
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6gMx-0001YI-Ve
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:46:16 -0400
Date: Fri, 5 May 2017 13:46:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505164612.GE3482@thinpad.lan.raisama.net>
References: <20170504145658.5506-1-berrange@redhat.com>
	<20170504184241.GB3482@thinpad.lan.raisama.net>
	<20170505114621.GG12773@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505114621.GG12773@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] i386: expose "TCGTCGTCGTCG" in the
 0x40000000 CPUID leaf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Richard W.M. Jones" <rjones@redhat.com>

On Fri, May 05, 2017 at 12:46:21PM +0100, Daniel P. Berrange wrote:
> On Thu, May 04, 2017 at 03:42:41PM -0300, Eduardo Habkost wrote:
> > On Thu, May 04, 2017 at 03:56:58PM +0100, Daniel P. Berrange wrote:
> > > Currently when running KVM, we expose "KVMKVMKVM\0\0\0" in
> > > the 0x40000000 CPUID leaf. Other hypervisors (VMWare,
> > > HyperV, Xen, BHyve) all do the same thing, which leaves
> > > TCG as the odd one out.
> > > 
> > > The CPUID is used by software to detect when running in a
> > > virtual environment and change behaviour in certain ways.
> > > For example, systemd supports a ConditionVirtualization=
> > > setting in unit files. Currently they have to resort to
> > > custom hacks like looking for 'fw-cfg' entry in the
> > > /proc/device-tree file. The virt-what command has the
> > > same hacks & needs.
> > > 
> > > This change thus proposes a signature TCGTCGTCGTCG to be
> > > reported when running under TCG.
> > > 
> > > NB1, for reasons I don't undersatnd 'cpu_x86_cpuid' function
> > > clamps the requested CPUID leaf based on env->cpuid_level.
> 
> [snip]
> 
> > > NB2, for KVM, we added a flag for '-cpu kvm=off' to let you
> > > hide the KVMKVMKVM signature from guests. Presumably we should
> > > add a 'tcg=off' flag for the same reason ?
> > 
> > I don't like "kvm=off" because it sounds like it disables KVM
> > completely. "tcg=off" would be misleading as well.
> > 
> > What about a generic "hypervisor-cpuid=off" property?
> 
> Assuming that is intended to obsolete the existing 'kvm' parameter too,
> I'm not seeing a way to introduce that in a backwards compatible safe
> manner.
> 
> eg we add
> 
>     DEFINE_PROP_BOOL("hypervisor-cpuid", X86CPU, expose_hypervisor, true),
> 
> and in legacy machine types we need to set
> 
>     {\
>         .driver   = TYPE_X86_CPU,\
>         .property = "hypervisor-cpuid",\
>         .value    = "off",\
>     },\
> 
> to prevent TCGTCGTCGTCG appearing.
> 
> 
> Now in current KVM code we have
> 
>     if (cpu->expose_kvm) {
>         memcpy(signature, "KVMKVMKVM\0\0\0", 12);
>         ....
>     }
> 
> if we add 'expose_hypervisor' as a generic variable and thus change
> existing KVM code to
> 
>     if (cpu->expose_kvm || cpu->expose_hypervisor)
> 
> then to disable the KVMKVMKVMKVM signature, we now need to set *two*
> flags - kvm=off, and hypervisor-cpuid=off and this will break existing
> apps that are only setting kvm=off to disable it.
> 
> Conversely if we do
> 
>     if (cpu->expose_kvm && cpu->expose_hypervisor)
> 
> we're going to break KVMKVMKVM signature reporting by default, since
> we need to set hypervisor-cpuid=off in back compat machine types
> to prevent TCGTCGTCGTCG being exposed.
> 
> So it seems we're doomed either way, as we can't distinguish between
> a boolean value that is at its default, vs a boolean value that has
> been explicitly set to a value that matches the default.

That's true, even if we add a hypervisor-cpuid property, we need
a way to represent the behavior of QEMU 2.9 (disabling hypervisor
CPUID only for TCG).

> 
> Having a separate variable just for TCG seems the only viable option
> to me - eg
> 
>     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),

Sounds good to me.

-- 
Eduardo

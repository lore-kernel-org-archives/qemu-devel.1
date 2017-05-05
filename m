Received: from eggs.gnu.org ([2001:4830:134:3::10]:37339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6bgt-0008TC-HR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6bgq-0006hA-Cx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d6bgq-0006gr-4C
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:46:28 -0400
Date: Fri, 5 May 2017 12:46:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170505114621.GG12773@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170504145658.5506-1-berrange@redhat.com>
	<20170504184241.GB3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170504184241.GB3482@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Richard W.M. Jones" <rjones@redhat.com>

On Thu, May 04, 2017 at 03:42:41PM -0300, Eduardo Habkost wrote:
> On Thu, May 04, 2017 at 03:56:58PM +0100, Daniel P. Berrange wrote:
> > Currently when running KVM, we expose "KVMKVMKVM\0\0\0" in
> > the 0x40000000 CPUID leaf. Other hypervisors (VMWare,
> > HyperV, Xen, BHyve) all do the same thing, which leaves
> > TCG as the odd one out.
> > 
> > The CPUID is used by software to detect when running in a
> > virtual environment and change behaviour in certain ways.
> > For example, systemd supports a ConditionVirtualization=
> > setting in unit files. Currently they have to resort to
> > custom hacks like looking for 'fw-cfg' entry in the
> > /proc/device-tree file. The virt-what command has the
> > same hacks & needs.
> > 
> > This change thus proposes a signature TCGTCGTCGTCG to be
> > reported when running under TCG.
> > 
> > NB1, for reasons I don't undersatnd 'cpu_x86_cpuid' function
> > clamps the requested CPUID leaf based on env->cpuid_level.

[snip]

> > NB2, for KVM, we added a flag for '-cpu kvm=off' to let you
> > hide the KVMKVMKVM signature from guests. Presumably we should
> > add a 'tcg=off' flag for the same reason ?
> 
> I don't like "kvm=off" because it sounds like it disables KVM
> completely. "tcg=off" would be misleading as well.
> 
> What about a generic "hypervisor-cpuid=off" property?

Assuming that is intended to obsolete the existing 'kvm' parameter too,
I'm not seeing a way to introduce that in a backwards compatible safe
manner.

eg we add

    DEFINE_PROP_BOOL("hypervisor-cpuid", X86CPU, expose_hypervisor, true),

and in legacy machine types we need to set

    {\
        .driver   = TYPE_X86_CPU,\
        .property = "hypervisor-cpuid",\
        .value    = "off",\
    },\

to prevent TCGTCGTCGTCG appearing.


Now in current KVM code we have

    if (cpu->expose_kvm) {
        memcpy(signature, "KVMKVMKVM\0\0\0", 12);
        ....
    }

if we add 'expose_hypervisor' as a generic variable and thus change
existing KVM code to

    if (cpu->expose_kvm || cpu->expose_hypervisor)

then to disable the KVMKVMKVMKVM signature, we now need to set *two*
flags - kvm=off, and hypervisor-cpuid=off and this will break existing
apps that are only setting kvm=off to disable it.

Conversely if we do

    if (cpu->expose_kvm && cpu->expose_hypervisor)

we're going to break KVMKVMKVM signature reporting by default, since
we need to set hypervisor-cpuid=off in back compat machine types
to prevent TCGTCGTCGTCG being exposed.

So it seems we're doomed either way, as we can't distinguish between
a boolean value that is at its default, vs a boolean value that has
been explicitly set to a value that matches the default.

Having a separate variable just for TCG seems the only viable option
to me - eg

    DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

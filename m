Received: from eggs.gnu.org ([2001:4830:134:3::10]:35523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clDpn-0001qC-2L
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clDpj-00031u-Th
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:03:19 -0500
Date: Tue, 7 Mar 2017 09:02:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170307120237.GF2778@thinpad.lan.raisama.net>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<20170305230627.GA12030@umbus.fritz.box>
	<20170306114752.GS2778@thinpad.lan.raisama.net>
	<20170307033105.GB19967@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307033105.GB19967@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On Tue, Mar 07, 2017 at 02:31:05PM +1100, David Gibson wrote:
> On Mon, Mar 06, 2017 at 08:47:52AM -0300, Eduardo Habkost wrote:
> > On Mon, Mar 06, 2017 at 10:06:27AM +1100, David Gibson wrote:
> > > On Fri, Mar 03, 2017 at 11:58:07AM -0300, Eduardo Habkost wrote:
> > > > On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> > > > > When running with KVM on POWER, we register some CPU types during
> > > > > the initialization function of the ppc64 KVM code (which unfortunately
> > > > > also can not be done via a type_init() like it is done on x86).
> > > > 
> > > > Can you elaborate why it can't be done via type_init()? If the
> > > > QOM type hierarchy depends on any runtime data unavailable at
> > > > type_init(), we should fix that.
> > > 
> > > Hmm.. how?  This is specifically for the special 'host' cpu in the
> > > case of KVM.  We can't use a static configuration here, because there
> > > are things on the host that could limit what features of the CPU are
> > > available for guest use.  So, we need KVM to be initialized in order
> > > to query that information.
> > 
> > There's nothing saying you need to query that information before
> > type_register() or during class_init, does it? The behavior of
> > TYPE_HOST_POWERPC_CPU after object_new() is called can be as
> > dynamic as you want it to, but the QOM type hierarchy is supposed
> > to be static.
> 
> So, the thing is we have some properties that logically belong in the
> CPU class, rather than instance, and that's correct for all TCG CPUs,
> but not for the KVM host CPU.  It seems nasty to have to force all
> those things into the instance just because of KVM.

You can still register any class properties you want, without
querying KVM first. Are there properties that you are able to
register only after querying KVM? Is the set of class properties
on TYPE_HOST_POWERPC_CPU different depending on the host
capabilities?

I'm looking at target/ppc/cpu-models.c, and I only see the
class_init function setting PowerPCCPUClass::pvr and
PowerPCCPUClass::svr. Am I missing anything?

You can still keep pvr and svr on the CPU class. The only thing
that's different on TYPE_HOST_POWERPC_CPU is that it won't have
the preset values on PowerPCCPUClass. But it can initialize the
instance values on ->instance_init() or ->realize() instead.

I even see ppc_cpu_class_by_pvr*() treating TYPE_HOST_POWERPC_CPU
as special on PVR lookup, already. So it looks like the code is
almost ready for that?

> 
> > Registering QOM types outside type_init() is only causing us
> > problems and we should stop doing that.
> > 
> > > 
> > > > >                                                                 So to
> > > > > be able to see these updates in the CPU help text, the code that calls
> > > > > list_cpus() has to be run after configure_accelerator(). This move should
> > > > > be fine since the "cpu_model" variable is also never used before the call
> > > > > to configure_accelerator(), and thus there should not be any unwanted
> > > > > side effects in the code before configure_accelerator() if the user
> > > > > started QEMU with "-cpu ?" or "-cpu help".
> > > > > 
> > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > 
> > > > I am not convinced that the output of "-cpu help" and
> > > > "-cpu help -machine accel=kvm" should look different. Do you have
> > > > an example of what exactly is wrong with the output currently?
> > > > 
> > > > I actually believe list_cpus() needs to be called _earlier_, not
> > > > later. Otherwise we won't be able to fix this bug:
> > > > 
> > > >   $ qemu-system-arm -cpu help
> > > >   qemu-system-arm:/usr/local/etc/qemu/qemu.conf:1: No machine specified, and there is no default
> > > >   Use -machine help to list supported machines
> > > >   $ 
> > > > 
> > > > > ---
> > > > >  vl.c | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/vl.c b/vl.c
> > > > > index 0b72b12..315c5c3 100644
> > > > > --- a/vl.c
> > > > > +++ b/vl.c
> > > > > @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
> > > > >          qemu_set_hw_version(machine_class->hw_version);
> > > > >      }
> > > > >  
> > > > > -    if (cpu_model && is_help_option(cpu_model)) {
> > > > > -        list_cpus(stdout, &fprintf, cpu_model);
> > > > > -        exit(0);
> > > > > -    }
> > > > > -
> > > > >      if (!trace_init_backends()) {
> > > > >          exit(1);
> > > > >      }
> > > > > @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
> > > > >  
> > > > >      configure_accelerator(current_machine);
> > > > >  
> > > > > +    if (cpu_model && is_help_option(cpu_model)) {
> > > > > +        list_cpus(stdout, &fprintf, cpu_model);
> > > > > +        exit(0);
> > > > > +    }
> > > > > +
> > > > >      if (qtest_chrdev) {
> > > > >          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
> > > > >      }
> > > > 
> > > 
> > 
> > 
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Eduardo

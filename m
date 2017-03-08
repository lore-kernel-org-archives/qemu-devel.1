Received: from eggs.gnu.org ([2001:4830:134:3::10]:39796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1clRXN-0002Xg-Ok
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1clRXK-0000ZE-Fo
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:41:13 -0500
Date: Wed, 8 Mar 2017 13:33:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170308023345.GH19967@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<20170305230627.GA12030@umbus.fritz.box>
	<20170306114752.GS2778@thinpad.lan.raisama.net>
	<20170307033105.GB19967@umbus.fritz.box>
	<20170307120237.GF2778@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <20170307120237.GF2778@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 09:02:37AM -0300, Eduardo Habkost wrote:
> On Tue, Mar 07, 2017 at 02:31:05PM +1100, David Gibson wrote:
> > On Mon, Mar 06, 2017 at 08:47:52AM -0300, Eduardo Habkost wrote:
> > > On Mon, Mar 06, 2017 at 10:06:27AM +1100, David Gibson wrote:
> > > > On Fri, Mar 03, 2017 at 11:58:07AM -0300, Eduardo Habkost wrote:
> > > > > On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> > > > > > When running with KVM on POWER, we register some CPU types duri=
ng
> > > > > > the initialization function of the ppc64 KVM code (which unfort=
unately
> > > > > > also can not be done via a type_init() like it is done on x86).
> > > > >=20
> > > > > Can you elaborate why it can't be done via type_init()? If the
> > > > > QOM type hierarchy depends on any runtime data unavailable at
> > > > > type_init(), we should fix that.
> > > >=20
> > > > Hmm.. how?  This is specifically for the special 'host' cpu in the
> > > > case of KVM.  We can't use a static configuration here, because the=
re
> > > > are things on the host that could limit what features of the CPU are
> > > > available for guest use.  So, we need KVM to be initialized in order
> > > > to query that information.
> > >=20
> > > There's nothing saying you need to query that information before
> > > type_register() or during class_init, does it? The behavior of
> > > TYPE_HOST_POWERPC_CPU after object_new() is called can be as
> > > dynamic as you want it to, but the QOM type hierarchy is supposed
> > > to be static.
> >=20
> > So, the thing is we have some properties that logically belong in the
> > CPU class, rather than instance, and that's correct for all TCG CPUs,
> > but not for the KVM host CPU.  It seems nasty to have to force all
> > those things into the instance just because of KVM.
>=20
> You can still register any class properties you want, without
> querying KVM first. Are there properties that you are able to
> register only after querying KVM? Is the set of class properties
> on TYPE_HOST_POWERPC_CPU different depending on the host
> capabilities?

Sorry, I used "properties" sloppily, not meaning QOM properties.

There are several fields in the CPU class which describe CPU
capabilities - bitmasks indicating which instructions are available,
and L1 cacheline sizes.  There are some other things that are in the
CPU instance at the moment, but arguably would belong better in the
class: available page sizes and PTE encodings, for example.

At the real hardware level these things are dependent only the model
of CPU - hence belonging in cpu class, not instance.  But, because of
the way virtualization works on POWER, some of the features may not be
available to guests, due to configuration of the hypervisor.  So for
the "host" cpu we need to query KVM to see which CPU features are
actually available.

> I'm looking at target/ppc/cpu-models.c, and I only see the
> class_init function setting PowerPCCPUClass::pvr and
> PowerPCCPUClass::svr. Am I missing anything?

Yes.  Notice that the .parent set there is not the base powerpc cpu
class, but a "family" class.  Those families are defined in
translate_init.c by another hairy macro POWERPC_FAMILY().  The family
class_init function (generally done as a block below the macro
invocation) initializes several other things, including insns_flags.

kvmppc_host_cpu_class_init(), uses the family's copy of insns_flags as
a base, but needs to query the host and adjust it for a couple of
instruction groups that can be disabled from the hypervisor.

[Aside: we also update the cache sizes based on host information.
The reasons for that are complicated.  This particular case doesn't
require a late class init though, because although it's queried from
the host, it's not queried from kvm specifically]

> You can still keep pvr and svr on the CPU class. The only thing
> that's different on TYPE_HOST_POWERPC_CPU is that it won't have
> the preset values on PowerPCCPUClass. But it can initialize the
> instance values on ->instance_init() or ->realize() instead.
>=20
> I even see ppc_cpu_class_by_pvr*() treating TYPE_HOST_POWERPC_CPU
> as special on PVR lookup, already. So it looks like the code is
> almost ready for that?

PVR is a red herring.  insn_flags is the real issue.

>=20
> >=20
> > > Registering QOM types outside type_init() is only causing us
> > > problems and we should stop doing that.
> > >=20
> > > >=20
> > > > > >                                                                =
 So to
> > > > > > be able to see these updates in the CPU help text, the code tha=
t calls
> > > > > > list_cpus() has to be run after configure_accelerator(). This m=
ove should
> > > > > > be fine since the "cpu_model" variable is also never used befor=
e the call
> > > > > > to configure_accelerator(), and thus there should not be any un=
wanted
> > > > > > side effects in the code before configure_accelerator() if the =
user
> > > > > > started QEMU with "-cpu ?" or "-cpu help".
> > > > > >=20
> > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > >=20
> > > > > I am not convinced that the output of "-cpu help" and
> > > > > "-cpu help -machine accel=3Dkvm" should look different. Do you ha=
ve
> > > > > an example of what exactly is wrong with the output currently?
> > > > >=20
> > > > > I actually believe list_cpus() needs to be called _earlier_, not
> > > > > later. Otherwise we won't be able to fix this bug:
> > > > >=20
> > > > >   $ qemu-system-arm -cpu help
> > > > >   qemu-system-arm:/usr/local/etc/qemu/qemu.conf:1: No machine spe=
cified, and there is no default
> > > > >   Use -machine help to list supported machines
> > > > >   $=20
> > > > >=20
> > > > > > ---
> > > > > >  vl.c | 10 +++++-----
> > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > diff --git a/vl.c b/vl.c
> > > > > > index 0b72b12..315c5c3 100644
> > > > > > --- a/vl.c
> > > > > > +++ b/vl.c
> > > > > > @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **e=
nvp)
> > > > > >          qemu_set_hw_version(machine_class->hw_version);
> > > > > >      }
> > > > > > =20
> > > > > > -    if (cpu_model && is_help_option(cpu_model)) {
> > > > > > -        list_cpus(stdout, &fprintf, cpu_model);
> > > > > > -        exit(0);
> > > > > > -    }
> > > > > > -
> > > > > >      if (!trace_init_backends()) {
> > > > > >          exit(1);
> > > > > >      }
> > > > > > @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **e=
nvp)
> > > > > > =20
> > > > > >      configure_accelerator(current_machine);
> > > > > > =20
> > > > > > +    if (cpu_model && is_help_option(cpu_model)) {
> > > > > > +        list_cpus(stdout, &fprintf, cpu_model);
> > > > > > +        exit(0);
> > > > > > +    }
> > > > > > +
> > > > > >      if (qtest_chrdev) {
> > > > > >          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
> > > > > >      }
> > > > >=20
> > > >=20
> > >=20
> > >=20
> > >=20
> >=20
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYv22HAAoJEGw4ysog2bOSelQQANaa71e3JXI/ALP/YoSy9MV9
9RiiY7D/xAIvT+GOMuCn9q3FwSTnuYCV8DxxAcqJM4kYFMPcaisFq7mmdKhaRWio
qM4MpccVu4jtybUVKXdqO72SCKD3zRkmaTyYAh1exTvILs+qVi4qTQOt1UJLv1yt
CeJfipQcy+MlCU2FSJulGkcUTwRzqW4N1GDru4cCDuXTNSuGvxAB3tNy/uaXnc9X
gFPJF1sqHH0WpdKWkLt6RTVREbQWGWEv6dPBXAr/ElJ7D2IfqIaBH7fIV2zFhL6R
Wtf8smCV75vqPGO3RQ2Zh/BkddDiGO/6PZ+6RyM8GxvK5tSf2fZh2AneKisMSQhh
p2Jqoqfe9g9mOH8QtLn6cWk/2E/glvPM43xvr3S4FpSM7DYiGNBahV/wrKrdRpsk
n/S6DQ4wfF4XvQiotQA07xJ0GsUftjpKwqOeBpyzPmrWt0WlHE8JxuFh0+teFz/M
uZMjQshqzm0sX8OemFh0QtmDlF5+LI4mpBWyvRVsPwJ0LYBCGdobb1XJZQ+nFAdy
u5e7IJE1pQcYl1RYgoCZitfyJ4tN1lzI/Fg+DKBs1eeDnzx0DqxDknD0m1T2wKUM
wU85MYt0/5fHAcCKGikmfFQ8nMubz2F8fgVqzIQslqlmuJpocQzaeyzYB+K3LjqQ
n/yxq4MrAxepPQ68WRTx
=BPIg
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--

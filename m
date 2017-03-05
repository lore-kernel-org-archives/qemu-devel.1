Received: from eggs.gnu.org ([2001:4830:134:3::10]:34634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckfHd-0000qx-SL
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 18:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckfHc-0005Fn-H7
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 18:09:45 -0500
Date: Mon, 6 Mar 2017 10:06:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170305230627.GA12030@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20170303145807.GC11509@thinpad.lan.raisama.net>
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


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 11:58:07AM -0300, Eduardo Habkost wrote:
> On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> > When running with KVM on POWER, we register some CPU types during
> > the initialization function of the ppc64 KVM code (which unfortunately
> > also can not be done via a type_init() like it is done on x86).
>=20
> Can you elaborate why it can't be done via type_init()? If the
> QOM type hierarchy depends on any runtime data unavailable at
> type_init(), we should fix that.

Hmm.. how?  This is specifically for the special 'host' cpu in the
case of KVM.  We can't use a static configuration here, because there
are things on the host that could limit what features of the CPU are
available for guest use.  So, we need KVM to be initialized in order
to query that information.

> >                                                                 So to
> > be able to see these updates in the CPU help text, the code that calls
> > list_cpus() has to be run after configure_accelerator(). This move shou=
ld
> > be fine since the "cpu_model" variable is also never used before the ca=
ll
> > to configure_accelerator(), and thus there should not be any unwanted
> > side effects in the code before configure_accelerator() if the user
> > started QEMU with "-cpu ?" or "-cpu help".
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> I am not convinced that the output of "-cpu help" and
> "-cpu help -machine accel=3Dkvm" should look different. Do you have
> an example of what exactly is wrong with the output currently?
>=20
> I actually believe list_cpus() needs to be called _earlier_, not
> later. Otherwise we won't be able to fix this bug:
>=20
>   $ qemu-system-arm -cpu help
>   qemu-system-arm:/usr/local/etc/qemu/qemu.conf:1: No machine specified, =
and there is no default
>   Use -machine help to list supported machines
>   $=20
>=20
> > ---
> >  vl.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/vl.c b/vl.c
> > index 0b72b12..315c5c3 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
> >          qemu_set_hw_version(machine_class->hw_version);
> >      }
> > =20
> > -    if (cpu_model && is_help_option(cpu_model)) {
> > -        list_cpus(stdout, &fprintf, cpu_model);
> > -        exit(0);
> > -    }
> > -
> >      if (!trace_init_backends()) {
> >          exit(1);
> >      }
> > @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
> > =20
> >      configure_accelerator(current_machine);
> > =20
> > +    if (cpu_model && is_help_option(cpu_model)) {
> > +        list_cpus(stdout, &fprintf, cpu_model);
> > +        exit(0);
> > +    }
> > +
> >      if (qtest_chrdev) {
> >          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
> >      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvJnwAAoJEGw4ysog2bOSnvsQAKboICaN7sfdEpshdvWe8gK5
QPHJ4Ukf+tlZcaXTqqAWBCnV1LuKDFt4+iQCaIDP6i+NVfhZUmur6XfvERsUxGSS
xWyNkHS8wTIXo6dBpFx6/h2nbEudOQtfvYl3yfmOhQNxWtApxeUdLJoxO6ymbwfN
6uFyLti4sdjDPvZFDylpolm5+eFcGqGibtQ4dfdS6TAPJC30elHNktmz5woucd4u
8jiRG1LIZXSD7oEJSlm6+tl6/Nmxpb8MND+jmB1n2WGFMyo1+OhmXYH2e45X7mho
RuXLxt6O00urmRSYW4limWXXp2vCaC1uH3NdO0HmHp6q30imeTEzfBU0gphoBiu2
XlEpLohXCBsoqZPaSwNZGCnWoGBHcL2Kyo+3n4L0ps7TAq2Qi6LC+56Ta6bU23rN
zWoKeCqGTcR37NFVMbWe4UPFrrq3uX49wsHMR8VJabl0PbngJ2nqSqIANyadsPY2
v2xxwigd7dCsXTqE1Pke/+0Rh0ao2bRRK+wJ2tDB0WFPKX+Yn2h6lAjYRdl8Y0pr
iUq8aNcR6M5h8+lapNgrmAHbfNCRscfP34l/S2Zv969m32loENRaG7P6uoOXfXLq
I9bY2SG5hht5fFdYYz4rSlKhc+MA3O+V6y305Y34hA/VnvaPTWDosacDrT+io4XB
D4WeMc6WJlEfDigkCQJb
=YuT/
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

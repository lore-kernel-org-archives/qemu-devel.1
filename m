Received: from eggs.gnu.org ([2001:4830:134:3::10]:56346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cl5xv-0002QH-39
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 22:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cl5xr-0000n3-VX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 22:39:11 -0500
Date: Tue, 7 Mar 2017 14:31:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170307033105.GB19967@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<20170305230627.GA12030@umbus.fritz.box>
	<20170306114752.GS2778@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20170306114752.GS2778@thinpad.lan.raisama.net>
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


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 08:47:52AM -0300, Eduardo Habkost wrote:
> On Mon, Mar 06, 2017 at 10:06:27AM +1100, David Gibson wrote:
> > On Fri, Mar 03, 2017 at 11:58:07AM -0300, Eduardo Habkost wrote:
> > > On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> > > > When running with KVM on POWER, we register some CPU types during
> > > > the initialization function of the ppc64 KVM code (which unfortunat=
ely
> > > > also can not be done via a type_init() like it is done on x86).
> > >=20
> > > Can you elaborate why it can't be done via type_init()? If the
> > > QOM type hierarchy depends on any runtime data unavailable at
> > > type_init(), we should fix that.
> >=20
> > Hmm.. how?  This is specifically for the special 'host' cpu in the
> > case of KVM.  We can't use a static configuration here, because there
> > are things on the host that could limit what features of the CPU are
> > available for guest use.  So, we need KVM to be initialized in order
> > to query that information.
>=20
> There's nothing saying you need to query that information before
> type_register() or during class_init, does it? The behavior of
> TYPE_HOST_POWERPC_CPU after object_new() is called can be as
> dynamic as you want it to, but the QOM type hierarchy is supposed
> to be static.

So, the thing is we have some properties that logically belong in the
CPU class, rather than instance, and that's correct for all TCG CPUs,
but not for the KVM host CPU.  It seems nasty to have to force all
those things into the instance just because of KVM.

> Registering QOM types outside type_init() is only causing us
> problems and we should stop doing that.
>=20
> >=20
> > > >                                                                 So =
to
> > > > be able to see these updates in the CPU help text, the code that ca=
lls
> > > > list_cpus() has to be run after configure_accelerator(). This move =
should
> > > > be fine since the "cpu_model" variable is also never used before th=
e call
> > > > to configure_accelerator(), and thus there should not be any unwant=
ed
> > > > side effects in the code before configure_accelerator() if the user
> > > > started QEMU with "-cpu ?" or "-cpu help".
> > > >=20
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > >=20
> > > I am not convinced that the output of "-cpu help" and
> > > "-cpu help -machine accel=3Dkvm" should look different. Do you have
> > > an example of what exactly is wrong with the output currently?
> > >=20
> > > I actually believe list_cpus() needs to be called _earlier_, not
> > > later. Otherwise we won't be able to fix this bug:
> > >=20
> > >   $ qemu-system-arm -cpu help
> > >   qemu-system-arm:/usr/local/etc/qemu/qemu.conf:1: No machine specifi=
ed, and there is no default
> > >   Use -machine help to list supported machines
> > >   $=20
> > >=20
> > > > ---
> > > >  vl.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/vl.c b/vl.c
> > > > index 0b72b12..315c5c3 100644
> > > > --- a/vl.c
> > > > +++ b/vl.c
> > > > @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
> > > >          qemu_set_hw_version(machine_class->hw_version);
> > > >      }
> > > > =20
> > > > -    if (cpu_model && is_help_option(cpu_model)) {
> > > > -        list_cpus(stdout, &fprintf, cpu_model);
> > > > -        exit(0);
> > > > -    }
> > > > -
> > > >      if (!trace_init_backends()) {
> > > >          exit(1);
> > > >      }
> > > > @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
> > > > =20
> > > >      configure_accelerator(current_machine);
> > > > =20
> > > > +    if (cpu_model && is_help_option(cpu_model)) {
> > > > +        list_cpus(stdout, &fprintf, cpu_model);
> > > > +        exit(0);
> > > > +    }
> > > > +
> > > >      if (qtest_chrdev) {
> > > >          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
> > > >      }
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

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvil3AAoJEGw4ysog2bOSWaoP/2jSwJbBwH58z7QcHQfY4QNx
DRfgz0FL2jm/sI/r2ZWXE49doWnOd3v7eVVE6ADf/2F/KGgemigfZQysQKnhQYP5
NAr8wVQiNh8O9MKhT4YV//B1ce9aKYd/pUBNRiEv4ZifGujlOpD2mmJxKOSQizks
JM6cuaSIgwWfgqohW73WqypjERBvVZ0LuBA5pTAfYzyHRzXKrMLrkwvHe8lxzBbC
0Jx1lTKgW4OBCkO4m3+eByXS63Q8jmPb2WkNZaFZjn+THN2HoP5bSKQ/9JsMYog2
tggS+kqyUd41VrBGvvvyUVkCmSRSyluV0zMB6Ljc16qlchwGPvAr5nXezNiR6CKx
mOU+7kYNI3Tpv3zjG28i6/p0CdxZfBwx9p3lKJIs8TSPlGRwlaHPZsjYOW9Vefzb
xp1q5Vf4xBYzbxPNRcoCT5FWbN2ZheAeHFX9wUMiDBgr+H9kobl14TiVIdbttqsx
Wzu8HAt+st9vO/WhN+xK5HJyc9GvHzyplRH0FnbpLpQV1QcyfJvUfuZtz8uMF1OW
oTEfdZpjUkMyXachnnc752ygLd0h4wR603uea+gHSADLJYqVFMFYkIXZPDhNjtN6
z4rRraZqSNEazfQf1wWFsiLGHip4AUsU+Hl/l08Na71hdkaLO8HwFjhGcY4fWb5k
3yx/yhNzKxiUzCIls5NO
=KQ7P
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

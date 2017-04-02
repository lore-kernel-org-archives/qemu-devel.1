Received: from eggs.gnu.org ([2001:4830:134:3::10]:43051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuZ6m-0004mx-D4
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuZ6j-0004Zi-8j
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:35:28 -0400
Date: Sun, 2 Apr 2017 16:20:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170402062004.GE16790@umbus.fritz.box>
References: <20170331045144.9307-1-david@gibson.dropbear.id.au>
	<CAGZKiBrsiFgwuFx4CjasWAg8+qXAiA10w9cMP6MhBec3iRouLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <CAGZKiBrsiFgwuFx4CjasWAg8+qXAiA10w9cMP6MhBec3iRouLA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] pseries: Enforce homogeneous
 threads-per-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata.rao@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lvivier@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 11:04:55AM +0530, Bharata B Rao wrote:
> On Fri, Mar 31, 2017 at 10:21 AM, David Gibson <david@gibson.dropbear.id.=
au>
> wrote:
>=20
> > For reasons that may be useful in future, CPU core objects, as used on =
the
> > pseries machine type have their own nr-threads property, potentially
> > allowing cores with different numbers of threads in the same system.
> >
>=20
> I remember we retained this flexibility to support heterogenous systems in
> future ? I think we can go with this enforcement now and relax it later if
> we ever reach there.
>=20
>=20
> >
> > If the user/management uses the values specified in query-hotpluggable-=
cpus
> > as they're expected to do, this will never matter in pratice.  But that=
's
> > not actually enforced - it's possible to manually specify a core with
> > a different number of threads from that in -smp.  That will confuse the
> > platform - most immediately, this can be used to create a CPU thread wi=
th
> > index above max_cpus which leads to an assertion failure in
> > spapr_cpu_core_realize().
> >
> > For now, enforce that all cores must have the same, standard, number of
> > threads.  While we're at it, also enforce that the core ids are correct=
ly
> > aligned based on that number of threads.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_cpu_core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 6883f09..935ee62 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -167,6 +167,18 @@ static void spapr_cpu_core_realize(DeviceState *de=
v,
> > Error **errp)
> >      void *obj;
> >      int i, j;
> >
> > +    if (cc->nr_threads !=3D smp_threads) {
> > +        error_setg(errp,
> > +                   "Invalid nr-threads=3D%d of CPU[core-id: %d], must =
be
> > %d",
> > +                   cc->nr_threads, cc->core_id, smp_threads);
> > +        return;
> > +    }
> >
>=20
> The above check should move to pre_plug handler.

Ah, good point.

> > +    if ((cc->core_id % smp_threads) !=3D 0) {
> > +        error_setg(errp, "Invalid CPU core-id=3D%d, must be a multiple=
 of
> > %d",
> > +                   cc->core_id, smp_threads);
> > +        return;
> > +    }
> >
>=20
> Not sure when you will hit this as the same check is already  present in
> pre_plug handler.

Oops, yes, didn't spot that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4JgUAAoJEGw4ysog2bOSAMMQAId59vslgx1yZaI1kkmKKsZO
0kVN1YqsTwYyMh/c7AomBXlpNm4Io2pwezGYKzqyHVGZ4U6c+ATsEGpKymIbCH9B
dQgWjj0jkIGjZ7LVG0JifI9bCmQduBdML9NjUzdo1hN7fYf+XpUifqevgJ/EDKjs
wZKS56ye4C9aPAC5CXR8f2TidAqbo2bXyDVpKCg5lrplko4zaHM5CW25PvtqrkI9
Kb2q00lObifEWaAswQpymJa6xmbnRLxSrRIf6xl2fv4MLl4Uu313hVmbnuF/pcAu
59WLpNEf00JWFthPGt6Q22YAnxPs0gSoeucb8/LfjudP7G4LexEBFIWsIkR6Y5UC
vD1qkCiPWZiR6ber28xIPgGcI6SqB6xPwETc5YAgzvsCaKA8r9qyB/3uRa09K9Ib
FqLetfCjcnON/WLYfoYvg6ye39ceuns0OVeUq+HUoiLavHDebhRbFJjYS477WPai
ASCIBLbOKrLXpzLgD8MLyCN/F/CKdheoNn0cMq2eTouDdzwKbBHZXIaM8rqa4FBM
SfbncZvvLs2xM6it/wYk9U9JCsdV56G6wi0WaqnDy3kN6484CLzgjyAZ11jWY887
Yfaf8IIdZY5HrOuWtyRhuaDBAH+9uGQ7vw2compxpaunDVmp976Nkz85Hva6v7rZ
/Y16XAkXVhkzIa4WnLFu
=uJ/l
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--

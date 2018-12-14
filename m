Received: from eggs.gnu.org ([2001:4830:134:3::10]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1gXbHo-0004pY-2d
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1gXbHk-0002zu-UA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:25:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1gXbHk-0002vw-M4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:24:56 -0500
Date: Fri, 14 Dec 2018 11:24:47 +1100
From: David Gibson <dgibson@redhat.com>
Message-ID: <20181214112447.510e4691@umbus.fritz.box>
In-Reply-To: <87y38tc2fb.fsf@dusky.pond.sub.org>
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/InrDEecS_0+c76/f8ttGT6F";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

--Sig_/InrDEecS_0+c76/f8ttGT6F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Dec 2018 08:26:48 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> There's a question for David Gibson inline.  Please search for /ppc/.
>=20
> Fei Li <fli@suse.com> writes:
>=20
> > Make qemu_thread_create() return a Boolean to indicate if it succeeds
> > rather than failing with an error. And add an Error parameter to hold
> > the error message and let the callers handle it. =20
>=20
> The "rather than failing with an error" is misleading.  Before the
> patch, we report to stderr and abort().  What about:
>=20
>     qemu-thread: Make qemu_thread_create() handle errors properly
>=20
>     qemu_thread_create() abort()s on error.  Not nice.  Give it a
>     return value and an Error ** argument, so it can return success /
>     failure.
>=20
> Still missing from the commit message then: how you update the callers.
> Let's see below.

[snip]
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU=
 *cpu,
> >      sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> >      uint64_t current_ram_size;
> >      int rc;
> > +    Error *local_err =3D NULL;
> > =20
> >      if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> >          return H_AUTHORITY;
> > @@ -538,8 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCP=
U *cpu,
> >      pending->shift =3D shift;
> >      pending->ret =3D H_HARDWARE;
> > =20
> > -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > -                       hpt_prepare_thread, pending, QEMU_THREAD_DETACH=
ED);
> > +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > +                            hpt_prepare_thread, pending,
> > +                            QEMU_THREAD_DETACHED, &local_err)) {
> > +        error_reportf_err(local_err, "failed to create hpt_prepare_thr=
ead: ");
> > +        g_free(pending);
> > +        return H_RESOURCE;
> > +    }
> > =20
> >      spapr->pending_hpt =3D pending;
> >   =20
>=20
> This is a caller that returns an error code on failure.  You change it
> to report the error, then return failure.  The return failure part looks
> fine.  Whether reporting the error is appropriate I can't say for sure.
> No other failure mode reports anything.  David, what do you think?

I think it's reasonable here.  In this context error returns and
reported errors are for different audiences.  The error returns are for
the guest, the reported errors are for the guest administrator or
management layers.  This particularly failure is essentially a host
side fault that is mostly relevant to the VM management.  We have to
say *something* to the guest to explain that the action couldn't go
forward and H_RESOURCE makes as much sense as anything.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/InrDEecS_0+c76/f8ttGT6F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwS+E8ACgkQbDjKyiDZ
s5LFmQ//dsGxfz96w+8OnI8EoQSrJazo3XUIVVNbIT99wdmISHQ1Yz0WzKg5ct4+
G24asZrTdpbOae/WpUQXZWpNTwhn330YqrRSRvZ3t1MLDKc7/jjnULQTfsBMmZad
O+U6p4Klu8Az9dpKlvT84q9OOjZLb283u3or/A8k25qL+JSI3iZ04RhhTFKykkkF
9p74+7Gd3MhJADXi7LUn6ThN9bv+5eH6SUwhQ7p/4iSBLNfQFimVwvUIxx8vfgZm
F3//0C95/JQ8z8325C9fg8hdMpvs4lQaJDz1xzRRHYrZqP9Azx019s4jBQQAzJmS
LZHrOdp/hlEzScXejr14MoV7ioYjk3fBqwKRM438RIQW4GkOCI7YMJPoXve4fFYG
9q+FuXdE2WBrhQnYVa9us9AUTuxXpseRgZ9t2iOvQHs2NU8J1WVppcMbV0EfgpY5
BC8JnsvKdANbZaHxNz6w/pKgOgRXm2utnOcFyAqxyxgWdixoejBEvG0Y5/1nm6xg
+UFVI1k2B3L26HxHsiksTjHi5NA4Q9Yt2S5CSi5P8TfXbxuZQ3xBaSHM/fl/vgUR
TaGMZtN9+eGQ672W25S6vrrcHuh5Hfx9ISTUCEiuS7fCQlMmwQsx4BQkVfv0BbtN
gBsmLKZR8aoMtGgxJ4QEDVQeE81ORernZsNjnzr1UeOSeGZMOuc=
=oKtG
-----END PGP SIGNATURE-----

--Sig_/InrDEecS_0+c76/f8ttGT6F--

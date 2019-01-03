Received: from eggs.gnu.org ([208.118.235.92]:53848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugM-0003Xl-0B
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugK-0005eK-N6
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:33 -0500
Received: from ozlabs.org ([203.11.71.1]:51899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1geug6-0005FM-L7
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:21 -0500
Date: Thu, 3 Jan 2019 14:43:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103034305.GQ10853@umbus.fritz.box>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-11-fli@suse.com>
	<20190102023609.GC27457@umbus.fritz.box>
	<2c10669c-2f43-6b98-ef02-c4b2edbd21ad@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline
In-Reply-To: <2c10669c-2f43-6b98-ef02-c4b2edbd21ad@126.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 10/16] qemu_thread: supplement
 error handling for h_resize_hpt_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?5p2O6I+y?= <lifei1214@126.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Markus Armbruster <armbru@redhat.com>


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 02:44:17PM +0800, =E6=9D=8E=E8=8F=B2 wrote:
>=20
> =E5=9C=A8 2019/1/2 =E4=B8=8A=E5=8D=8810:36, David Gibson =E5=86=99=E9=81=
=93:
> > On Tue, Dec 25, 2018 at 10:04:43PM +0800, Fei Li wrote:
> > > Add a local_err to hold the error, and return the corresponding
> > > error code to replace the temporary &error_abort.
> > >=20
> > > Cc: Markus Armbruster <armbru@redhat.com>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Fei Li <fli@suse.com>
> > This looks like a good change, but it no longer applies due to a
> > change in the qemu_thread_create() signature.
> Sorry that I am not sure whether I understand. Do you mean using
> &error_abort is more suitable for this handling, rather than report
> the &local_err & return a failure reason?

No, I just mean that context has been altered by a global change and
the patch will need to be fixed up to cope with that.

> >=20
> > > ---
> > >   hw/ppc/spapr_hcall.c | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 5bc2cf4540..7c16ade04a 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCC=
PU *cpu,
> > >       sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > >       uint64_t current_ram_size;
> > >       int rc;
> > > +    Error *local_err =3D NULL;
> > >       if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> > >           return H_AUTHORITY;
> > > @@ -538,10 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerP=
CCPU *cpu,
> > >       pending->shift =3D shift;
> > >       pending->ret =3D H_HARDWARE;
> > > -    /* TODO: let the further caller handle the error instead of abor=
t() here */
> > > -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > > -                       hpt_prepare_thread, pending,
> > > -                       QEMU_THREAD_DETACHED, &error_abort);
> > > +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > > +                            hpt_prepare_thread, pending,
> > > +                            QEMU_THREAD_DETACHED, &local_err)) {
> > > +        error_reportf_err(local_err, "failed to create hpt_prepare_t=
hread: ");
> > > +        g_free(pending);
> > > +        return H_RESOURCE;
> > I also think H_HARDWARE would be a better choice here.  Although the
> > failure is due to a resource constraint, it's not because the guest
> > asked for too much, just because the host is in dire straits.  From
> > the guest's point of view it's basically a hardware failure.
>=20
> Ok, thanks. Will use H_HARDWARE instead.
>=20
> Have a nice day, thanks for the review. :)
> Fei
> >=20
> > > +    }
> > >       spapr->pending_hpt =3D pending;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwthMkACgkQbDjKyiDZ
s5JNDRAA0Q76STP+svYyBCaV+bhd6UjdS+9f1HY2T9GTskFDLxphyi7x+lG2t2Zr
IFcOZz36h31bPPPyuMsFBeQMSzOhFiIJmcQzWpm5mjP121pSwFeaYxR4cIp5NAxR
oGFqx3IBtiPAX36hrLyXFwRULH+KJmtPWytp4rXnxMJ/Rp34CIeG0AsyJuzUU8/y
vxsTEPgMOceVo/sfuchMP9xMfHX07diGDGCo9TMjyRxezqdhaHjWJg9mBDa9Kc59
1pgikmtrYJUuYWIxcaE2/1p1XTLK0ATGgtS+XCS4RNcuuhvTFTwJdsxMh2OWK4h8
qE5DTEFuUUmG2eeI0K/hYOPsKGDjqQnHtI+//Y2+2JL+Dnyp6ONyS9PQo2Bf2zfg
L8eXbysjablZboUdh3R93quC8vKqqtm2OD4qRi3CihlITHuutcrfji4WMzAtIuG0
SGtIdghCaGVvNhYMirkQ4Oz1b8PJC804LDBcn4h5niHDPzHRWF6xx1IdpGFG8V4K
g2R82I1t41KxLMimtQfPilJW21T46Atxh0N7ym5+FfF8YqoD56H46pWumfKPviVp
h1LgknJ47D/Q3V7thAP4+wr5u9UA3X3jML0OtmpTgoUpxL2pUY88kdRbatbklRQj
he6VxfKfOnj/iF0xFczWu74v1WL5/wfaQ/nPxcJi90vzs1BqcIU=
=9A+2
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--

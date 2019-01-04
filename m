Received: from eggs.gnu.org ([208.118.235.92]:49952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwZ-0002lt-7p
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwY-0002tF-0N
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:51 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:39315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gfHwX-0002YO-0S
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:49 -0500
Date: Fri, 4 Jan 2019 16:21:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190104052101.GE2801@umbus.fritz.box>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-11-fli@suse.com>
	<20190102023609.GC27457@umbus.fritz.box>
	<2c10669c-2f43-6b98-ef02-c4b2edbd21ad@126.com>
	<20190103034305.GQ10853@umbus.fritz.box>
	<76ea4ac2-e60f-b762-a365-5924445ccd6c@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <76ea4ac2-e60f-b762-a365-5924445ccd6c@126.com>
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
To: Fei Li <lifei1214@126.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Markus Armbruster <armbru@redhat.com>


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 09:41:49PM +0800, Fei Li wrote:
>=20
> =E5=9C=A8 2019/1/3 =E4=B8=8A=E5=8D=8811:43, David Gibson =E5=86=99=E9=81=
=93:
> > On Wed, Jan 02, 2019 at 02:44:17PM +0800, =E6=9D=8E=E8=8F=B2 wrote:
> > > =E5=9C=A8 2019/1/2 =E4=B8=8A=E5=8D=8810:36, David Gibson =E5=86=99=E9=
=81=93:
> > > > On Tue, Dec 25, 2018 at 10:04:43PM +0800, Fei Li wrote:
> > > > > Add a local_err to hold the error, and return the corresponding
> > > > > error code to replace the temporary &error_abort.
> > > > >=20
> > > > > Cc: Markus Armbruster <armbru@redhat.com>
> > > > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > > > Signed-off-by: Fei Li <fli@suse.com>
> > > > This looks like a good change, but it no longer applies due to a
> > > > change in the qemu_thread_create() signature.
> > > Sorry that I am not sure whether I understand. Do you mean using
> > > &error_abort is more suitable for this handling, rather than report
> > > the &local_err & return a failure reason?
> > No, I just mean that context has been altered by a global change and
> > the patch will need to be fixed up to cope with that.
>=20
> Just to be clearer: does the "global change" mean the "[patch 06/16]
> qemu_thread: Make qemu_thread_create() handle errors properly", or another
> patch not in this patch series?
>=20
> If it means the [patch 06/16], I want to explain more: the 06/16 handles =
all
> qemu_thread_create() by passing &error_abort as the parameter, and the
> following patches are to improve on the &error_abort for callers who can
> handle more properly. E.g. if qemu_thread_create() fails in
> h_resize_hpt_prepare(),
> I think reporting the &local_err & returning the failure reason is more
> proper
> than just abort() inside qemu_thread_create() when calls error_setg_errno=
().
>=20
> In other words, this patch is actually written to apply to patch 06. And I
> have
> no clue where it needs to be fixed up. Please correct me if I understand
> wrong.
>=20
>=20
> Have a nice day, thanks :)

Ah, sorry.  Since I was only CCed on this patch, not the rest of the
series, I assumed it was independent and didn't think to check the
earlier patches of the series.

So, yes, I think the global change I'm referring to is 6/16, which I
didn't have, so that explains the problem.

In that case it's probably best if this goes in via the same tree the
rest of the series is going to.  So, with the H_HARDWARE change made:

Acked-by: David Gibson <david@gibson.dropbear.id.au>


> Fei
>=20
>=20
> >=20
> > > > > ---
> > > > >    hw/ppc/spapr_hcall.c | 12 ++++++++----
> > > > >    1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > > > index 5bc2cf4540..7c16ade04a 100644
> > > > > --- a/hw/ppc/spapr_hcall.c
> > > > > +++ b/hw/ppc/spapr_hcall.c
> > > > > @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(Powe=
rPCCPU *cpu,
> > > > >        sPAPRPendingHPT *pending =3D spapr->pending_hpt;
> > > > >        uint64_t current_ram_size;
> > > > >        int rc;
> > > > > +    Error *local_err =3D NULL;
> > > > >        if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> > > > >            return H_AUTHORITY;
> > > > > @@ -538,10 +539,13 @@ static target_ulong h_resize_hpt_prepare(Po=
werPCCPU *cpu,
> > > > >        pending->shift =3D shift;
> > > > >        pending->ret =3D H_HARDWARE;
> > > > > -    /* TODO: let the further caller handle the error instead of =
abort() here */
> > > > > -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
> > > > > -                       hpt_prepare_thread, pending,
> > > > > -                       QEMU_THREAD_DETACHED, &error_abort);
> > > > > +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare=
",
> > > > > +                            hpt_prepare_thread, pending,
> > > > > +                            QEMU_THREAD_DETACHED, &local_err)) {
> > > > > +        error_reportf_err(local_err, "failed to create hpt_prepa=
re_thread: ");
> > > > > +        g_free(pending);
> > > > > +        return H_RESOURCE;
> > > > I also think H_HARDWARE would be a better choice here.  Although the
> > > > failure is due to a resource constraint, it's not because the guest
> > > > asked for too much, just because the host is in dire straits.  From
> > > > the guest's point of view it's basically a hardware failure.
> > > Ok, thanks. Will use H_HARDWARE instead.
> > >=20
> > > Have a nice day, thanks for the review. :)
> > > Fei
> > > > > +    }
> > > > >        spapr->pending_hpt =3D pending;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwu7T0ACgkQbDjKyiDZ
s5J/gA//Rer4XXJKFgPed1dZZNK3YE3GIUlkDYjaIYeXgAi0/2O2UuruTJNtcyfv
D27Twx9SdkEmvYcaH0uiDLKFgOgFGlpfOoCJQa1puOcJTHVkDO2yiHNrUxnuAtTg
5sZ4V/pCnGjjcIbakZWPLlWZKWaDC+qHFT77GY4PlyZcgLeMBkloL+SW7rfCt9Fc
Eee1zDh2ueoIhAPYpHzhc7RSITu4Fk4JkmQTbzJLi6Kl6RRb4v50Mdv847Vdrf3t
qq/vBAPPMLx5vex7pSwHHwEGTu0HMbdKT/mlMoYqJukkYPL3rZ8snNYrSj3dUah5
SChgwVNB4+QFbwgX0ILOEGNtst+jHZK0A4gxvXtgwvj0wY0KhixPo1CCB6qHee/5
5zX4t7WbHoxWArxthRDX0cczFFGSVJ3LGRepQdrOlh2Ll7/X54dGZra4hpYwxjQC
6HLI3B9qSf6eN0jdU14o5igK/1AWvVIEzy3yO5bAorFCQ57BkA4fWUAYTw0hVQz9
H+TRIFlPlwxC1o1Gp9XcRAu9qF1qIMcWlWU1eArwmZV8ov/HJXGVdREb7wZrvBSi
U3gmW2bL/lhYR4aD9Net7KIJbtpR84sv/HKODaswQhNeaMYvkqt+s3dLsbK6t0DT
m50HIx/HZqYf8EzEIKFEZxQaY+qmgL2UsiZ2QpgqEDBZNucBS5Q=
=OXlK
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFh-00084C-Jr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFf-0003Qs-RI
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:33 -0400
Date: Thu, 18 May 2017 14:37:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170518043719.GS15596@umbus.fritz.box>
References: <20170517063547.23876-1-david@gibson.dropbear.id.au>
	<20170517063547.23876-2-david@gibson.dropbear.id.au>
	<20170517175657.0c0f7666@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nSQp8DZZn7gZbDHt"
Content-Disposition: inline
In-Reply-To: <20170517175657.0c0f7666@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC 1/2] pseries: Split CAS PVR
 negotiation out into a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--nSQp8DZZn7gZbDHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 05:56:57PM +0200, Greg Kurz wrote:
> On Wed, 17 May 2017 16:35:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Guests of the qemu machine type go through a feature negotiation process
> > known as "client architecture support" (CAS) during early boot.  This d=
oes
> > a number of things, one of which is finding a CPU compatibility mode wh=
ich
> > can be supported by both guest and host.
> >=20
> > In fact the CPU negotiation is probably the single most complex part of=
 the
> > CAS process, so this splits it out into a helper function.  We've recen=
tly
> > made some mistakes in maintaining backward compatibility for old machine
> > types here.  Splitting this out will also make it easier to fix this.
> >=20
> > This also adds a possibly useful error message if the negotiation fails
> > (i.e. if there is CPU mode that's suitable for both guest and host).
>=20
> s/if there is/if there isn't a/ ?

Oops, I'll correct that.

>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_hcall.c | 43 +++++++++++++++++++++++++++----------------
> >  1 file changed, 27 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 0d608d6..007ae8d 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1047,19 +1047,13 @@ static target_ulong h_signal_sys_reset(PowerPCC=
PU *cpu,
> >      }
> >  }
> > =20
> > -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> > -                                                  sPAPRMachineState *s=
papr,
> > -                                                  target_ulong opcode,
> > -                                                  target_ulong *args)
> > +static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong list,
> > +                              Error **errp)
> >  {
> > -    target_ulong list =3D ppc64_phys_to_real(args[0]);
> > -    target_ulong ov_table;
> >      bool explicit_match =3D false; /* Matched the CPU's real PVR */
> >      uint32_t max_compat =3D cpu->max_compat;
> >      uint32_t best_compat =3D 0;
> >      int i;
> > -    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updat=
es;
> > -    bool guest_radix;
> > =20
> >      /*
> >       * We scan the supplied table of PVRs looking for two things
> > @@ -1090,26 +1084,43 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >          /* We couldn't find a suitable compatibility mode, and either
> >           * the guest doesn't support "raw" mode for this CPU, or raw
> >           * mode is disabled because a maximum compat mode is set */
> > -        return H_HARDWARE;
> > +        error_setg(errp, "Couldn't negotiate a suitable PVR during CAS=
");
> > +        return 0;
> >      }
> > =20
> >      /* Parsing finished */
> >      trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
> > =20
> > -    /* Update CPUs */
> > -    if (cpu->compat_pvr !=3D best_compat) {
> > -        Error *local_err =3D NULL;
> > +    return best_compat;
> > +}
> > +
> > +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> > +                                                  sPAPRMachineState *s=
papr,
> > +                                                  target_ulong opcode,
> > +                                                  target_ulong *args)
> > +{
> > +    /* @ov_table points to the first option vector */
> > +    target_ulong ov_table =3D ppc64_phys_to_real(args[0]);
> > +    uint32_t cas_pvr;
> > +    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updat=
es;
> > +    bool guest_radix;
> > +    Error *local_err =3D NULL;
> > =20
> > -        ppc_set_compat_all(best_compat, &local_err);
> > +    cas_pvr =3D cas_check_pvr(cpu, ov_table, &local_err);
>=20
> Shouldn't cas_check_pvr() take a target_ulong * so that we can get
> the address of the first option vector...
>=20
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        return H_HARDWARE;
> > +    }
> > +
> > +    /* Update CPUs */
> > +    if (cpu->compat_pvr !=3D cas_pvr) {
> > +        ppc_set_compat_all(cas_pvr, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >              return H_HARDWARE;
> >          }
> >      }
> > =20
> > -    /* For the future use: here @ov_table points to the first option v=
ector */
> > -    ov_table =3D list;
> > -
>=20
> ... and address Laurent's comment ?

Yes, I completely misread what was happening with the pvr_list vs. the
option vectors.  I'll correct that.

>=20
> >      ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
> >      ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> >      if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nSQp8DZZn7gZbDHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHST/AAoJEGw4ysog2bOSnAYQAMzuk3ZBa3jj4YdCHmYvmPym
//72SZpVUx4k/M0JaiL4lB9cvmkReo7h4ep+R+xhn/Y2LVBrXeD1uWyJ7/Lq2whl
Ghn+rhq7zQSWQLr/tg4kpwrsujOW4SB1KPNerEh7amDUdNKWAxIZIjcr8+PM48aA
nItmlMQ0X7jBfDKm9AIyd2eSijX+vgSGB6l9ThTnCHFzuApqSSQ2IYOn3Q4AJWE9
zZtdp/GXS8KkQfNb2Sr7orFuYqD5sCg3kpv0EzpCCC6vulZKS5WmRnZTpF6qLwQz
xFNFOnS3IvLY9o0rxLeSXh1wDQlih1L86ZJH+iusVVMLUFW2uHPJ6upJWR4VjXjW
KbMh/12S/sgWvUpkBZJn/DC/RZCnahiuB/JbXS6oFfRuJA4nTiUAsfv+PdwhBBVE
5ALxPy5HIzt25FSr9vng9P9jPeIxeu3D84AcRZSk98WfL/CJbqTFgbdGHJHT1buD
hekKWPVg8dBz6Smz4xB3S/EbFmyUYj0PfPAx4AlbCFAmfIa12mHgaJ2EGNIiSj/c
wvJOhqmsXQham3pLObzKzbKnmrc9wDmB9LWR7+hRdZwQtxUFxq84DKWkJT6mYFof
N4/qNyIEuG52DyKJbax70GuYlmlJnVVt+ln/RBBIimGcuoSyddzVAnd2qWaqm/LL
2THkbASi7YnAG0AF7wXK
=js+n
-----END PGP SIGNATURE-----

--nSQp8DZZn7gZbDHt--

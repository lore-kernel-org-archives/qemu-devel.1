Received: from eggs.gnu.org ([2001:4830:134:3::10]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIZ5c-0005d2-6O
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIZ5Z-0002B9-1s
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:25:28 -0400
Date: Wed, 7 Jun 2017 21:16:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170607111611.GK13397@umbus.fritz.box>
References: <20170607070732.23312-1-david@gibson.dropbear.id.au>
	<1799129848.6598516.1496820296394.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYX8XqlwBJQgDxCD"
Content-Disposition: inline
In-Reply-To: <1799129848.6598516.1496820296394.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pseries: Correct panic behaviour for
 pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--zYX8XqlwBJQgDxCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 03:24:56AM -0400, Paolo Bonzini wrote:
>=20
>=20
> ----- Original Message -----
> > From: "David Gibson" <david@gibson.dropbear.id.au>
> > To: mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
> > Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "D=
avid Gibson" <david@gibson.dropbear.id.au>
> > Sent: Wednesday, June 7, 2017 9:07:32 AM
> > Subject: [PATCH] pseries: Correct panic behaviour for pseries machine t=
ype
> >=20
> > The pseries machine type doesn't usually use the 'pvpanic' device as su=
ch,
> > because it has a firmware/hypervisor facility with roughly the same
> > purpose.  The 'ibm,os-term' RTAS call notifies the hypervisor that the
> > guest has crashed.
> >=20
> > Our implementation of this call was sending a GUEST_PANICKED qmp event;
> > however, it was not doing the other usual panic actions, making its
> > behaviour different from pvpanic for no good reason.
> >=20
> > To correct this, we should call qemu_system_guest_panicked() rather than
> > directly sending the panic event.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_rtas.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 707c4d4..94a2799 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -293,12 +293,9 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
> >                              target_ulong args,
> >                              uint32_t nret, target_ulong rets)
> >  {
> > -    target_ulong ret =3D 0;
> > +    qemu_system_guest_panicked(NULL);
> > =20
> > -    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false, NU=
LL,
> > -                                   &error_abort);
> > -
> > -    rtas_st(rets, 0, ret);
> > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >  }
>=20
> It's possible to "cont" a panicked guest, so I think you should keep
> the rtas_st.

I did keep the rtas_st(), I just changed it to using a constant
instead of an always-0 variable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYX8XqlwBJQgDxCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZN+B0AAoJEGw4ysog2bOSm04P/jWtmDxajzdJy7MfajiLQBPC
11Yx3s2Sloc8RlH7KZVMKweCZZ9uCpWs9ivN+mAK5OneZAWLblLOHQMPGMWbjbns
Jd8rMtqtSsLpmVD+q9TdkecSZ793ngSoSdMTXAK5wN3Qngh5tsNalQWvJdldaoKq
Ij047cfz4NBpVtJwyY8KU9xejrdXvhHLXveQNtZ2L2tj/4grE+yF8uDlzpWSTzrk
ovzKk5jKb8b4oGlYZIF1vt17Z97rK9efIRI/F//6CZwAkGD36wodhUBXTJDD6DzT
feQ0mJb7CRupNmDQxbJYxSW38GdO8Or4GYK9zH9g9K7Dk9+BymJ9wW7P1oyMdn32
Po6pdgwhVolQwgaPY0bgOTZDKqT9oRhjdwoMDRgxmGCrAyxHn9gJxRsKAsEdWlv5
RXxjCkLdF7cGDzIaybXBWpF2+ozDt+JBh9Rs51CQW4pD7/1qdVmkXYTtMLiHh4Kg
a7F928Ogu4/HCc/i+fp1cvvxDv34GG9Ftv0MQVZJANkbrHOh4NGzRyd4qMcQpKYP
6spW7B4GumwoAYUChWdXHTBfpTXz6ryB3TifKO1h7edhSpEECmjPa85lGth57nqX
WmHgj5in3sXFfKtRQQy+qEB6u0/9nV+0qOWjZMgRUMdawscI//0bdDCpnEY83Nw4
Vzk7ZyH0Ngiun/iDeW5i
=I/Wp
-----END PGP SIGNATURE-----

--zYX8XqlwBJQgDxCD--

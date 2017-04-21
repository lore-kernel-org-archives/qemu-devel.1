Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d1Nr1-0002nt-IH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 21:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d1Nr0-0006TR-EX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 21:59:23 -0400
Date: Fri, 21 Apr 2017 11:45:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170421014510.GA31355@umbus.fritz.box>
References: <20170414083717.13641-1-lvivier@redhat.com>
	<20170414083717.13641-3-lvivier@redhat.com>
	<20170418030950.GE12235@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20170418030950.GE12235@umbus.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/4] ppc: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 01:09:50PM +1000, David Gibson wrote:
> On Fri, Apr 14, 2017 at 10:37:15AM +0200, Laurent Vivier wrote:
> > This removes the assert(kvm_enabled()) from kvmppc_host_cpu_initfn()
> >=20
> > This assert can never be triggered as the function is only registered
> > when KVM is available (see also 4c315c2
> > "qdev: Protect device-list-properties against broken devices").
> >=20
> > So we can remove the cannot_destroy_with_object_finalize_yet from
> > kvmppc_host_cpu_class_init() without fear and beyond reproach.
> > (as it has already be done for i386 with 771a13e "i386: Unset
> > cannot_destroy_with_object_finalize_yet on "host" model" and
> > e435601 "target-i386: Remove assert(kvm_enabled()) from
> > host_x86_cpu_initfn()")
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Applied to ppc-for-2.10 (fixing a contextual conflict on the way).

Looks like this will go through Markus' tree instead, so:

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
>=20
> > ---
> >  target/ppc/kvm.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 9f1f132..64017ac 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2245,14 +2245,8 @@ static void alter_insns(uint64_t *word, uint64_t=
 flags, bool on)
> >      }
> >  }
> > =20
> > -static void kvmppc_host_cpu_initfn(Object *obj)
> > -{
> > -    assert(kvm_enabled());
> > -}
> > -
> >  static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
> >  {
> > -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> >      uint32_t vmx =3D kvmppc_get_vmx();
> >      uint32_t dfp =3D kvmppc_get_dfp();
> > @@ -2279,9 +2273,6 @@ static void kvmppc_host_cpu_class_init(ObjectClas=
s *oc, void *data)
> >      if (icache_size !=3D -1) {
> >          pcc->l1_icache_size =3D icache_size;
> >      }
> > -
> > -    /* Reason: kvmppc_host_cpu_initfn() dies when !kvm_enabled() */
> > -    dc->cannot_destroy_with_object_finalize_yet =3D true;
> >  }
> > =20
> >  bool kvmppc_has_cap_epr(void)
> > @@ -2333,7 +2324,6 @@ static int kvm_ppc_register_host_cpu_type(void)
> >  {
> >      TypeInfo type_info =3D {
> >          .name =3D TYPE_HOST_POWERPC_CPU,
> > -        .instance_init =3D kvmppc_host_cpu_initfn,
> >          .class_init =3D kvmppc_host_cpu_class_init,
> >      };
> >      PowerPCCPUClass *pvr_pcc;
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+WQjAAoJEGw4ysog2bOSvL0QAJDRZ9ysivKCwbsxPwByH8Zb
jphOQk3Qx4afn9odc05Gdz/1L7/XUK0PHEL+TdBKNqKrDD9nH5x9KY5EoTmmgEoG
i/jJ46uw/PWgG1nTxFijfJJ5gK4mDKR7ISo9ROJm1aqKoqk44jDdN8LIEGXJgv8u
gFN4zp26g0WK9urGvcZoH4n+AA3TYIlBiWFs6+e6jmLpPqY3FTz9YBo4RjOhnDgS
PMQ2NAPKjCqBE+UHsHNjUNrKwxk2twiGpdovJW30UZJzSp8EB5prKX3hbRU5YU61
OP12J30fZqCHZrVJouhkuNbfuTGSTCI/6HuD0MBjoIPZ83Ouy41Nf9maDvH2JhIW
VJm9iDB9TYOz2xwHPLCHgMKQ5yIgV+J2ed8HARTC9nNZFjOtFlein6cZAAiL2JDN
LWkd1AbGYWIPTL28OEYlkmAfW7C878MijOik4j0CY8Q/q7Gu+OTLHSljVg9uxnia
tVcBCwOKANViozo0YMshw68Z1RbL1HKmfKMuTukN32QVy/zCs9CnxTaINGghLqGn
CJRsxlb9UrjJvgksW3AiVcHk8LEK7PuUjtAFpscPdhk+UvFx2K9KhpJ7ODXy7BcJ
mHaczL3M7WCl7IseX6GZOSorHRg8eLpATyZ5DCczgcKGMvk9ODXoBPyko9xm4Z5i
pq1VesQ/16cKmatBrg5S
=74K3
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

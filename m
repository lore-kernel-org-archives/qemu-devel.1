Received: from eggs.gnu.org ([2001:4830:134:3::10]:52530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIZ5b-0005cz-6W
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIZ5a-0002BM-25
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:25:27 -0400
Date: Wed, 7 Jun 2017 21:25:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170607112508.GL13397@umbus.fritz.box>
References: <20170607070732.23312-1-david@gibson.dropbear.id.au>
	<3de884c3-c386-c024-e401-faa459dbf0b4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UJhykcm+BCcdfd3/"
Content-Disposition: inline
In-Reply-To: <3de884c3-c386-c024-e401-faa459dbf0b4@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--UJhykcm+BCcdfd3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 09:33:21AM +0200, Thomas Huth wrote:
> On 07.06.2017 09:07, David Gibson wrote:
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
> > =20
> >  static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> >=20
>=20
> If I get that qemu_system_guest_panicked() function right, it will stop
> the VM, won't it? That contradicts the LoPAPR spec that says that the
> RTAS call returns if the "ibm,extended-os-term" property is available in
> the device tree. And we currently present this property in the device
> tree. So either the guest should not be stopped here, or we've got to
> remove the property from the device tree again.

Hrm.  However in the case of this "extended behaviour" it's not clear
what we should do next.  I'm include to think that the preference set
by the qemu user / management layer should take precedence over PAPR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UJhykcm+BCcdfd3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZN+KUAAoJEGw4ysog2bOSRfEQAKDka+1JkPuGisH/PlEjYnj4
n9CxZInppCFzsAjrF4JfaAWEbUNUIGlxMYHsz7J5U8cZZ9B8MPXvlgJ3OtSWxs1u
4w4Wp+Wh/+Onn4he8/yC0Sugq7SXr2BFGpi3InysN7xkeuVnge0O5plsad1P/RKR
xQdNdKTiV2vgrBFRoG2rcqXv4WYgRmV9ZPVxCfilEelzTYjGh5D93wCRB9tbJPfD
y+1ZvJLAUbn+cy8j99/lyUr/0n7NtRFskar+BvmAzMN34FDNruF5DsflbYIr/ubg
wLe/v0mZoLfb9euh9l+/mblkdIdgQayjHPTUP2Xn51zRqbVCd45PRQn0QlowkT6M
LnzWnN8IPVQARlkykR1QUyuq6YBHO4fofvRfJgYtEJzSP+0dcWBiJSspn0op71UA
6OLWd6WmytTuuTtU6e+C0UCzIns3JY6oJf7iedH4MwsOp3XXqKhGmAfOX/BiLpaN
R9/pKyrnUKD1rF/yBo7ym5SAiMX+k4K56VeyN9H1df8XFjop1lxvdcut+D12VKq4
qdGzjE1vpUCrjfsND+G/gtFn8sMF5ko9GZyrUJ+pcYfmJ9fZUPmpH/ETqfzNNeSf
Y+myeWViOIwZhiKj2t+qGHC68dJ8gE0vM3EdnMV9RLPg8ezY+jmzDglT+qwU31F0
IIi5q32fJXXTu/S2fO9S
=TVrd
-----END PGP SIGNATURE-----

--UJhykcm+BCcdfd3/--

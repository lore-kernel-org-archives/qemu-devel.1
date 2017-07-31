Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc1RO-0007fP-Rd
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 23:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc1RL-000859-KH
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 23:32:22 -0400
Date: Mon, 31 Jul 2017 12:58:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170731025825.GC2652@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100571083.27487.4628655387393519076.stgit@bahia>
	<20170728034925.GF3098@umbus.fritz.box>
	<20170728123035.70cdd434@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20170728123035.70cdd434@bahia.lan>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 18/26] spapr: create DR connectors
 for PHBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 12:30:35PM +0200, Greg Kurz wrote:
> On Fri, 28 Jul 2017 13:49:25 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jul 25, 2017 at 08:01:50PM +0200, Greg Kurz wrote:
> > > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> > >=20
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> >=20
> >=20
> > > ---
> > > Changes since RFC:
> > > - rebased against ppc-for-2.10 (reset hooks registering already merge=
d)
> > > - added new DRC type for PHB
> > > ---
> > >  hw/ppc/spapr.c             |   15 +++++++++++++++
> > >  hw/ppc/spapr_drc.c         |   17 +++++++++++++++++
> > >  include/hw/ppc/spapr_drc.h |    8 ++++++++
> > >  3 files changed, 40 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 8dc505343c0f..5950c009ab7e 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -98,6 +98,9 @@
> > > =20
> > >  #define PHANDLE_XICP            0x00001111
> > > =20
> > > +/* maximum number of hotpluggable PHBs */
> > > +#define SPAPR_DRC_MAX_PHB       256 =20
> >=20
> > I wonder if we should actually make this a machine property.
> >=20
>=20
> It makes sense.
>=20
> Also, if all PHBs are instanciated with index !=3D -1, we're limited to 3=
1.
> Maybe this could be the default value for the machine property instead of
> 256 then ?

Actually, if we're binding it back to index, which has a hard limit,
then it no longer makes sense to have it as a property and we should
go back to a constant (well, it could vary by machine type version).

> > >  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
> > >                                    const char *type_ics,
> > >                                    int nr_irqs, Error **errp)
> > > @@ -2384,6 +2387,18 @@ static void ppc_spapr_init(MachineState *machi=
ne)
> > > =20
> > >      spapr->dr_phb_enabled =3D smc->dr_phb_enabled;
> > > =20
> > > +    /* Setup hotplug / dynamic-reconfiguration connectors. top-level
> > > +     * connectors (described in root DT node's "ibm,drc-types" prope=
rty)
> > > +     * are pre-initialized here. additional child connectors (such as
> > > +     * connectors for a PHBs PCI slots) are added as needed during t=
heir
> > > +     * parent's realization.
> > > +     */
> > > +    if (spapr->dr_phb_enabled) {
> > > +        for (i =3D 0; i < SPAPR_DRC_MAX_PHB; i++) {
> > > +            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_P=
HB, i);
> > > +        }
> > > +    }
> > > +
> > >      /* Set up PCI */
> > >      spapr_pci_rtas_init();
> > > =20
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index eb8024d37c54..2e1049ce61c7 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -697,6 +697,15 @@ static void spapr_drc_lmb_class_init(ObjectClass=
 *k, void *data)
> > >      drck->release =3D spapr_lmb_release;
> > >  }
> > > =20
> > > +static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
> > > +{
> > > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> > > +
> > > +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> > > +    drck->typename =3D "PHB";
> > > +    drck->drc_name_prefix =3D "PHB ";
> > > +}
> > > +
> > >  static const TypeInfo spapr_dr_connector_info =3D {
> > >      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
> > >      .parent        =3D TYPE_DEVICE,
> > > @@ -740,6 +749,13 @@ static const TypeInfo spapr_drc_lmb_info =3D {
> > >      .class_init    =3D spapr_drc_lmb_class_init,
> > >  };
> > > =20
> > > +static const TypeInfo spapr_drc_phb_info =3D {
> > > +    .name          =3D TYPE_SPAPR_DRC_PHB,
> > > +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL, =20
> >=20
> > I thought PHB DRCs were physical..
> >=20
>=20
> My understanding is that only PCI IOAs need a physical DRC.
>=20
> From LoPAPR v1.1 (March 24, 2016):
>=20
> 13.7 Logical Resource Dynamic Reconfiguration (LRDR)
>=20
> The Logical Resource Dynamic Reconfiguration option allows a platform to =
make available and recover platform re-
> sources such as CPUs, Memory Regions, Processor Host Bridges, and I/O slo=
ts to/from its operating OS image(s).
>=20
> ...
>=20
> The device tree contains logical resource DR connectors for the maximum n=
umber of resources that the platform can
> allocate to the specific OS. In some cases such as for processors and PHB=
s...
>=20
> and
>=20
> Table 240. Currently Defined DR Connector Types
>=20
> | PHB | Logical PCI Host Bridge |

Ah, my mistake.

>=20
> > > +    .instance_size =3D sizeof(sPAPRDRConnector),
> > > +    .class_init    =3D spapr_drc_phb_class_init,
> > > +};
> > > +
> > >  /* helper functions for external users */
> > > =20
> > >  sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> > > @@ -1179,6 +1195,7 @@ static void spapr_drc_register_types(void)
> > >      type_register_static(&spapr_drc_cpu_info);
> > >      type_register_static(&spapr_drc_pci_info);
> > >      type_register_static(&spapr_drc_lmb_info);
> > > +    type_register_static(&spapr_drc_phb_info);
> > > =20
> > >      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
> > >                          rtas_set_indicator);
> > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > > index a7958d0a8d14..535fc61b98a8 100644
> > > --- a/include/hw/ppc/spapr_drc.h
> > > +++ b/include/hw/ppc/spapr_drc.h
> > > @@ -69,6 +69,14 @@
> > >  #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > >                                          TYPE_SPAPR_DRC_LMB)
> > > =20
> > > +#define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
> > > +#define SPAPR_DRC_PHB_GET_CLASS(obj) \
> > > +        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_=
PHB)
> > > +#define SPAPR_DRC_PHB_CLASS(klass) \
> > > +        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_=
DRC_PHB)
> > > +#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
> > > +                                        TYPE_SPAPR_DRC_PHB)
> > > +
> > >  /*
> > >   * Various hotplug types managed by sPAPRDRConnector
> > >   *
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll+nM4ACgkQbDjKyiDZ
s5JAxg//QawCrTl3Fmo5dWDxn9cAphpLK1LX2+k184fylFVQIpWnNxO7UWdY26pK
x/SbCEzrUuyei77nUlmC5Xo6TcYGIhA4xJiW7s8fOjWj+auKj4G8rE4MbRLxKiqV
tbl8KetOREbDrhL7YoIz8N3CnH0vz/hEMNhl5k4oj56Uset0r8egu8v5iBTGsCcc
Qz1eDrd/EZFEyg3DKHmGCexb72MzJkuDDthfcdJ9WJW2GMbaRaxRa3JhBuu1cdcY
eQyl2ufi5HY3ZOj+yWyyLjBAc71tJwoHHffesNIUHr3SVEjTCu0FfmHVG+D27xwr
+u7abhb7rY3CPWbIu1LR3Q2AJB82KufqI06CKOe2SOm8IQySJz0o1QsuRCtR76qZ
kVERY/ZkTGGRFVAkMt9my5Gsdn4AP6szDwU6ZNy+P/qzf7fMNw3i0GjwKx+E2uTB
0cp0vv1i5dbwbkBfZwFSSJAYGLmryY++tPif01X595FvNwblQSa45mLIuXBSiNOJ
E/8AnRztYz8MYtX1Q+W37fkYTo0nXDPOoXgSmSa12L8OuTLy6M0z31q78DSQ22la
J4Yf5rUubZ482vN4ajKwvtOXkG2sV5Yj48D5s0yPMrdf3AIzkZzEVkH2pOC95MnS
LdYtGGPCkgDkorrwugWhO6NNQCnBz1AEBO0ZXKVz44ozG/LBGZc=
=aRcW
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

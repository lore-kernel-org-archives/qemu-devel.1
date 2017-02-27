Received: from eggs.gnu.org ([2001:4830:134:3::10]:58296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGw-0007hS-Hj
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGv-0003IF-7p
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:42 -0500
Date: Mon, 27 Feb 2017 11:57:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227005757.GK17615@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-13-git-send-email-clg@kaod.org>
	<20170223023946.GA12577@umbus.fritz.box>
	<94cf0f58-fcda-abad-4c9c-bd23af9a30c4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HUNbJr+8XKUS5qN7"
Content-Disposition: inline
In-Reply-To: <94cf0f58-fcda-abad-4c9c-bd23af9a30c4@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 12/22] ppc/xics: extend the
 QOM interface to handle ICPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--HUNbJr+8XKUS5qN7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 12:15:21PM +0100, C=E9dric Le Goater wrote:
> On 02/23/2017 03:39 AM, David Gibson wrote:
> > On Thu, Feb 16, 2017 at 02:47:35PM +0100, C=E9dric Le Goater wrote:
> >> Let's add two new handlers for ICPs. One is to get an ICP object from
> >> a server number and a second is to resend the irqs when needed.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/xics.c        |  2 +-
> >>  hw/ppc/spapr.c        | 20 ++++++++++++++++++++
> >>  include/hw/ppc/xics.h |  3 +++
> >>  3 files changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> >> index 5131587ce088..7168c2cfd8a1 100644
> >> --- a/hw/intc/xics.c
> >> +++ b/hw/intc/xics.c
> >> @@ -216,7 +216,7 @@ static void icp_check_ipi(ICPState *ss)
> >>      qemu_irq_raise(ss->output);
> >>  }
> >> =20
> >> -static void icp_resend(XICSInterface *xi, ICPState *ss)
> >> +void icp_resend(XICSInterface *xi, ICPState *ss)
> >>  {
> >>      XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
> >> =20
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index d1946ebcac69..eb7da32296d8 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2915,6 +2915,24 @@ static void spapr_ics_resend(XICSInterface *dev)
> >>      ics_resend(spapr->ics);
> >>  }
> >> =20
> >> +static ICPState *spapr_icp_get(XICSInterface *xi, int server)
> >> +{
> >> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> >> +
> >> +    return (server < spapr->xics->nr_servers) ? &spapr->xics->ss[serv=
er] :
> >> +        NULL;
> >> +}
> >> +
> >> +static void spapr_icp_resend(XICSInterface *xi)
> >> +{
> >> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < spapr->xics->nr_servers; i++) {
> >> +        icp_resend(xi, &spapr->xics->ss[i]);
> >> +    }
> >> +}
> >=20
> > I'm not quite sure where you plan to use the resend hook.  AFAICT all
> > the existing users of this path can do fine using icp_get() then
> > icp_resend() directly.
>=20
> This is for ics_simple_post_load().

Ah, right.  That's the bit that involves co-ordination between ICS and
ICP.  It should therefore move to the machine (well, xics fabric
implementor) so you shouldn't need this callback in the end anyway.

>=20
> C.
>=20
> >=20
> >> +
> >>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
> >>  {
> >>      MachineClass *mc =3D MACHINE_CLASS(oc);
> >> @@ -2959,6 +2977,8 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      vhc->hypercall =3D emulate_spapr_hypercall;
> >>      xic->ics_get =3D spapr_ics_get;
> >>      xic->ics_resend =3D spapr_ics_resend;
> >> +    xic->icp_get =3D spapr_icp_get;
> >> +    xic->icp_resend =3D spapr_icp_resend;
> >>  }
> >> =20
> >>  static const TypeInfo spapr_machine_info =3D {
> >> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >> index c15d8e2a8ae6..7004c851e250 100644
> >> --- a/include/hw/ppc/xics.h
> >> +++ b/include/hw/ppc/xics.h
> >> @@ -191,6 +191,8 @@ typedef struct XICSInterfaceClass {
> >>      InterfaceClass parent;
> >>      ICSState *(*ics_get)(XICSInterface *xi, int irq);
> >>      void (*ics_resend)(XICSInterface *xi);
> >> +    ICPState *(*icp_get)(XICSInterface *xi, int server);
> >> +    void (*icp_resend)(XICSInterface *xi);
> >>  } XICSInterfaceClass;
> >> =20
> >>  #define XICS_IRQS_SPAPR               1024
> >> @@ -221,5 +223,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, =
int server,
> >>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> >> =20
> >>  void ics_resend(ICSState *ics);
> >> +void icp_resend(XICSInterface *xi, ICPState *ss);
> >> =20
> >>  #endif /* XICS_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HUNbJr+8XKUS5qN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs3mTAAoJEGw4ysog2bOSCA8QANUYaOwBNZPrHWypB2CE2KBw
IxYJhMBTZX3OY7HUbsfzJMEBbhQlYNtNbKZT/bwp3dsohiCXwkIZOuaUoA0AEU96
xTr5ZgrEmOpcPeglf+ar4EhNIdbvtM+a7YW4x51kwE3LxSnhiG9uFmD/crjVe46x
BCgK914h4MM9Zw9xlA5Ic3nUdi2WpNOgX4QrE3PSPOQRIKQx7xvl/981VtP5Y7Pf
nl2cWnIPLP3+PLzEzj7/+zAXglh6ofsMIFwX8XIc1Xkjq3fnDhDB+5Ra7ebfsK2y
0P23eF8R+ZBZdfkC1kB7yVi/4c4zKTBy9JUOkY4mkFkhVdI1T9FAMN6cNi2t71xA
nYDcgisKM9xZTka9r+FnFYjcskrBXDFN1W1QWcgVaMpstAcL9O4liovTCu39l4Gn
mVRVONKxuZobX5e6LaNdANoUdw5f8MbgmgQs0CYALcarHo94xTsXfdhuBmIJCVx3
GGn0SLnwri3nF55ab3fnlrjX/4ysmSScbxZj+Gl87U8b83cU/ZJmsTruT2FzFNiv
EBmzfndTs6y/9q1ECUh7Yw7+g8VyGzpfvLdUrlvRv+5UpzQevVh1fkBWBkUETyZW
BWJ8GAVO/V6wohprkXRtC2MrurYvTzUVjvJ8JsJf22H7ze8crLEe5CreGJCnVwuj
XxZ1JM8P1WNtykXpp1kL
=F56/
-----END PGP SIGNATURE-----

--HUNbJr+8XKUS5qN7--

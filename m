Received: from eggs.gnu.org ([2001:4830:134:3::10]:52925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci9ZM-00064H-6c
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci9ZL-0000Dv-5E
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:53:40 -0500
Date: Mon, 27 Feb 2017 11:37:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227003706.GJ17615@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-9-git-send-email-clg@kaod.org>
	<20170223022933.GW12577@umbus.fritz.box>
	<6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
	<e12d3243-3da1-b432-a898-f01e89af5807@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3gNIKMlg37D5iFb5"
Content-Disposition: inline
In-Reply-To: <e12d3243-3da1-b432-a898-f01e89af5807@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 08/22] ppc/xics: use the QOM
 interface to resend irqs
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


--3gNIKMlg37D5iFb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 06:34:06PM +0100, C=E9dric Le Goater wrote:
> >>> @@ -592,10 +593,11 @@ static void ics_simple_reset(DeviceState *dev)
> >>> =20
> >>>  static int ics_simple_post_load(ICSState *ics, int version_id)
> >>>  {
> >>> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
> >>>      int i;
> >>> =20
> >>>      for (i =3D 0; i < ics->xics->nr_servers; i++) {
> >>> -        icp_resend(&ics->xics->ss[i]);
> >>> +        icp_resend(xi, &ics->xics->ss[i]);
> >>>      }
> >>
> >> This resend triggering needs to get moved to the xics interface
> >> implementor - i.e. the machine.  It's actually already broken right
> >> now, since it incorrectly relies on the ordering of the ics and icp
> >> restore during migration.
> >=20
> > I'm adding a icp_resend() handler in patch 12 and using it patch 14.
> > Maybe we can move the post_load() handler out of ICS simple now ?=20
>=20
> Could you give me a little more info on what should be done ? I lack=20
> context on this problem.=20
>=20
> So should we call :=20
>=20
>     ICPState *ss =3D opaque;
>     ICPStateClass *info =3D ICP_GET_CLASS(ss);
>=20
>     if (info->post_load) {
>         return info->post_load(ss, version_id);
>     }
>=20
> and then=20
>=20
>     ICSState *ics =3D opaque;
>     ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
>=20
>     if (info->post_load) {
>         return info->post_load(ics, version_id);
>     }
>=20
> from spapr_post_load() ?=20

Uh.. now I'm trying to remember what the correct order is.  Any part
of the post_load which is entirely local to the ics or icp, and
doesn't communicate with the other part should remain in a local
post-load handler.

The part of the resend which involves interaction between ics and icp
should move to the mahine.  Because the ics and icp are both
descendents of the machine, the migration core does guarantee their
local post_lodas will run before the machine's post-load.  At the
moment however, we require either the ics post_loads to run before the
icp or the other way around - I forget which.  Because these are
"cousin" objects, that order is not guaranteed by the migration core.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3gNIKMlg37D5iFb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs3SyAAoJEGw4ysog2bOSDpYQAK4aWqxcAcibrzYLzr1V+4tP
mxLsPAtiniyQ7qzt0z6dCu+xC9XWL6UM0uY/+ffEc28uT3HTr80h24a6t7JlWy0w
sX0LEmJSN0nc5ENcRDkkJoNMBCXg2C+piUC6i6YFggK/DqmvK9yFeoUgrEcT7BN+
0NdYoAJ8cIKfHnFkGNPQLR/HE2zqd70Lv94IzPIdt4BH+dN24XLzVw7h0mW35TMA
w9eaX9E9Y4AibLw3dh8wZGuV7Lr2w5T3guHcycJ1Pee6QhWiV5K/1sZo+DjCUIyQ
xNyk9bq+d74h+XjJfIJNdW4iND62IweA+soSLJcWwpG2kcX6UaiKtqUdvyV8vMOU
hvN8YHLpkZuZHtwGawEQuReAerre260ojlcJAtoh44OhnYfuBZRlukLTv3TgxOnh
Ub4aed4jmIDDekffUtJs3wGu+v0or5xC1gIVLS8ILzWBJMsXVX2JS6KC4EWbDcUp
4qpnEckprJip1IPx2rMmFlF6Aq1LoTS4IJ6mQramMVHBaeBNe6KndiDXvVh/jjmx
iNpUy44hO1au8KuJDBhtRqfPuWkP08XdNjpXOpabD1gMEI/09Dh+TCP7/UOOIQRz
bJEZouaLJ5lXhiEw4+fTqhtA9hF7B9HLpvCqIxnvT83iCiD5V3kiTGh7PlI5w69D
EB8Q725RiF26Dd1eJ7NP
=Bf+a
-----END PGP SIGNATURE-----

--3gNIKMlg37D5iFb5--

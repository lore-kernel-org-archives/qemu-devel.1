Received: from eggs.gnu.org ([2001:4830:134:3::10]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtX-0001Gk-8L
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtU-0002u4-Cv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:47 -0400
Date: Tue, 19 Sep 2017 17:36:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919073615.GN27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aIbcA3MSwnGacr4f"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-10-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/21] ppc/xive: extend the
 interrupt presenter model for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--aIbcA3MSwnGacr4f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:23PM +0200, C=E9dric Le Goater wrote:
> The XIVE interrupt presenter exposes a set of Thread Interrupt
> Management Areas, also called rings, one per different level of
> privilege (four in all). This area is used to handle priority
> management and interrupt acknowledgment among other things.
>=20
> We extend the ICPState object with a cache of the register data for
> XIVE. The integration with the sPAPR machine is much easier and we
> need a common framework to switch from one controller model to
> another: XICS <-> XIVE.

This sounds like an even worse idea than referencing the ICS state.
The TIMA really needs to be managed by a different object than the ICP.

> The next patch will introduce the MMIO handlers to interact with the
> TIMA, OS only, which is required for the sPAPR support.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c        | 4 ++++
>  include/hw/ppc/xics.h | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index a84ba51ad8ff..927d4fec966a 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -274,6 +274,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>          VMSTATE_UINT32(xirr, ICPState),
>          VMSTATE_UINT8(pending_priority, ICPState),
>          VMSTATE_UINT8(mfrr, ICPState),
> +        VMSTATE_UINT8_ARRAY(tima, ICPState, 0x40),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -293,6 +294,7 @@ static void icp_reset(void *dev)
>      if (icpc->reset) {
>          icpc->reset(icp);
>      }
> +    memset(icp->tima, 0, sizeof(icp->tima));
>  }
> =20
>  static void icp_realize(DeviceState *dev, Error **errp)
> @@ -343,6 +345,8 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>          icpc->realize(icp, errp);
>      }
> =20
> +    icp->tima_os =3D &icp->tima[0x10];
> +
>      qemu_register_reset(icp_reset, dev);
>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 28d248abad61..c835997303c4 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -83,6 +83,12 @@ struct ICPState {
>      qemu_irq output;
> =20
>      XICSFabric *xics;
> +
> +    /* XIVE section */
> +#define XIVE_TM_RING_COUNT 4
> +
> +    uint8_t tima[XIVE_TM_RING_COUNT * 0x10];
> +    uint8_t *tima_os;
>  };
> =20
>  #define ICP_PROP_XICS "xics"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aIbcA3MSwnGacr4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAyOwACgkQbDjKyiDZ
s5I5jA/7BhvPEZBvke1v1u7vAOc/i22QM9kH6RCdzQ2dob+NMUY5oZB5kjPX4ro8
AnscHhnNee1W8esVgRB698UUZBqlpV4/j67hkQ6CL5g9j5y+xmT2UqPF7Z3PFDse
Dmb60x9ue7K1769XARZXGTSYn6bGNUZOEz59XaI14AlMX40dci7NUiRHr0QbvccG
lOcqcyQcIEFvELzWtskwMLDvePx2AXClTI4XXbe7yVhs1cK7tXhzioex1eAVSpsK
+WHSW2OMflJdeAEee0jf8Qjqwr7Jahq0e4vAFICenK+ooWfswpJ+fHUHgi+qzMZW
Vv33R7zZLnVzS+O36HxSjeoXZxDT56FlGmlhZ//uGcQdoqVBFFqFATspDbz6tmBw
BOAp5jq1H0ZgUaf/AKoTCyLqhjdE4q46ZV1wXUaxZUYG9Gl9H3DTPVXL1xzSDdU+
LPjC2z6G2P8xL9XQU6U03uVCYC8u27PF6fZv7EEgx5Ylgn7Nn9i82fh4wsHa9Qmy
0kR3UrACmpLTAMFPYa9TspdqBmzGut78sJibiTxonyhf3A7RB5ZnBYiX1Y0/dlSW
L61FvsLHrfrRDtzyNfc2LFRILkCUFUSSfoyZ6N21sM4e7ztO/PSl2/dThhoO4Z6h
cFQDl6oTbC00OSR1P3HpyLejMvwjsrrVvZJMaW5naUmrGLemXCU=
=VZyc
-----END PGP SIGNATURE-----

--aIbcA3MSwnGacr4f--

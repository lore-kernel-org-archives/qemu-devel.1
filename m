Received: from eggs.gnu.org ([2001:4830:134:3::10]:53679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mU-0007bI-Hq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mT-00013B-AE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:10 -0400
Date: Fri, 9 Jun 2017 12:35:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609023506.GG26521@umbus.fritz.box>
References: <20170608172743.10132-1-lvivier@redhat.com>
	<20170608172743.10132-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <20170608172743.10132-3-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Revert "spapr: fix memory
 hot-unplugging"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 07:27:43PM +0200, Laurent Vivier wrote:
> This reverts commit fe6824d12642b005c69123ecf8631f9b13553f8b.
>=20
> Conflicts hw/ppc/spapr_drc.c, because get_index() has been renamed
> spapr_get_index().
>=20
> This didn't fix the problem. Once the hotplug has been started
> some memory is allocated and some structures are allocated.
> We don't free it when we ignore the unplug, and we can't because
> they can be in use by the kernel.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Heh.  I've just been looking at awaiting_allocation_skippable and
trying - but failing - to work out what it accomplishes.  Applied to
ppc-for-2.10.

> ---
>  hw/ppc/spapr_drc.c         | 20 +++-----------------
>  include/hw/ppc/spapr_drc.h |  1 -
>  2 files changed, 3 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 39e7f30..7605977 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -140,17 +140,6 @@ static uint32_t set_allocation_state(sPAPRDRConnecto=
r *drc,
>          if (!drc->dev) {
>              return RTAS_OUT_NO_SUCH_INDICATOR;
>          }
> -        if (drc->awaiting_release && drc->awaiting_allocation) {
> -            /* kernel is acknowledging a previous hotplug event
> -             * while we are already removing it.
> -             * it's safe to ignore awaiting_allocation here since we kno=
w the
> -             * situation is predicated on the guest either already havin=
g done
> -             * so (boot-time hotplug), or never being able to acquire in=
 the
> -             * first place (hotplug followed by immediate unplug).
> -             */
> -            drc->awaiting_allocation_skippable =3D true;
> -            return RTAS_OUT_NO_SUCH_INDICATOR;
> -        }
>      }
> =20
>      if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> @@ -401,11 +390,9 @@ static void detach(sPAPRDRConnector *drc, DeviceStat=
e *d, Error **errp)
>      }
> =20
>      if (drc->awaiting_allocation) {
> -        if (!drc->awaiting_allocation_skippable) {
> -            drc->awaiting_release =3D true;
> -            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
> -            return;
> -        }
> +        drc->awaiting_release =3D true;
> +        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
> +        return;
>      }
> =20
>      drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> @@ -428,7 +415,6 @@ static void detach(sPAPRDRConnector *drc, DeviceState=
 *d, Error **errp)
>      }
> =20
>      drc->awaiting_release =3D false;
> -    drc->awaiting_allocation_skippable =3D false;
>      g_free(drc->fdt);
>      drc->fdt =3D NULL;
>      drc->fdt_start_offset =3D 0;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index c88e1be..84b58f0 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -200,7 +200,6 @@ typedef struct sPAPRDRConnector {
>      bool awaiting_release;
>      bool signalled;
>      bool awaiting_allocation;
> -    bool awaiting_allocation_skippable;
> =20
>      /* device pointer, via link property */
>      DeviceState *dev;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOglaAAoJEGw4ysog2bOSKa0QAMtKxnq57ojkfj2Yh4SoDmBc
ijBMjPN6i4WcMog76g2jy3Y++6ZpbJF1cBK9Yu/PBf1A4ZKDvcil8JPRm34yB8dI
MTJoYKex61tFxw8pSf30xjOW+gzxEQ3prWN8N9kIR+XsGVC2kFvPO6KWktnChWWL
Y0dzVA5W7h1XuZHBmw/zT1+OdubY/nrJwEafMqPx0Ny7BvTt8brS0uEs+d4Fdp/w
isl+xnjHvNWTttzB9WYhgfWAuJvmuRy6qPdMXJW1EfF/aVnE29Oso0TO0Q1kno1J
8pSF6zzKfC2CwGOHhOY27dIQlV4j0LYNbyHRKkkyYpR2pOjSTEHCxfTwMb2VFhmr
r5qByVBy2d5FyTg4EFCpvmgtWw2VdRex+OBYf/nLC2rvjn9SX/jQciksOtvadw/D
4iKVrPi6CLnHz/0us+naXlrBMgBJGtl89SlsksB8YKKCV+dWejYM90wSL+QN3VMe
2dwiePhVY+S7Hd7OlYNO/U+AbwSAVge3XqOyeD6Wqd329d02OUhJ5O01d8HTRHvF
XszlYW2wpZtugRsanAhdjenACNw/IUnfkx+HsOnRi5L9ZVyL8txdEaME3IfoSYNl
RV4XQjZgKcpOzbzxzJu0wA/UgTzPSwRWU8RYIDPgeZ4q5xr1aMn85iEjG1IcGUKk
/v1jMuVsFVOy11F2Ofav
=y6Aj
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct2Is-000572-MQ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct2Ir-00087F-Br
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:21:38 -0400
Date: Wed, 29 Mar 2017 11:35:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329003532.GM21068@umbus.fritz.box>
References: <20170328120934.29526-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <20170328120934.29526-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: fix memory hot-unplugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 02:09:34PM +0200, Laurent Vivier wrote:
> If, once the kernel has booted, we try to remove a memory
> hotplugged while the kernel was not started, QEMU crashes on
> an assert:
>=20
>     qemu-system-ppc64: hw/virtio/vhost.c:651:
>                        vhost_commit: Assertion `r >=3D 0' failed.
>     ...
>     #4  in vhost_commit
>     #5  in memory_region_transaction_commit
>     #6  in pc_dimm_memory_unplug
>     #7  in spapr_memory_unplug
>     #8  spapr_machine_device_unplug
>     #9  in hotplug_handler_unplug
>     #10 in spapr_lmb_release
>     #11 in detach
>     #12 in set_allocation_state
>     #13 in rtas_set_indicator
>     ...
>=20
> If we take a closer look to the guest kernel log, we can see when
> we try to unplug the memory:
>=20
>     pseries-hotplug-mem: Attempting to hot-add 4 LMB(s)
>=20
> What happens:
>=20
>     1- The kernel has ignored the memory hotplug event because
>        it was not started when it was generated.
>=20
>     2- When we hot-unplug the memory,
>        QEMU starts to remove the memory,
>             generates an hot-unplug event,
>         and signals the kernel of the incoming new event
>=20
>     3- as the kernel is started, on the QEMU signal, it reads
>        the event list, decodes the hotplug event and tries to
>        finish the hotplugging.
>=20
>     4- QEMU receive the the hotplug notification while it
>        is trying to hot-unplug the memory. This moves the memory
>        DRC to an invalid state
>=20
> This patch prevents this by not allowing to set the allocation
> state to USABLE while the DRC is awaiting release.
>=20
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1432382
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-2.9, thanks.

> ---
> v2: Add awaiting_allocation_skippable flag
>     as suggested by Michael
>=20
>  hw/ppc/spapr_drc.c         | 20 +++++++++++++++++---
>  include/hw/ppc/spapr_drc.h |  1 +
>  2 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 150f6bf..a1cdc87 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -135,6 +135,17 @@ static uint32_t set_allocation_state(sPAPRDRConnecto=
r *drc,
>          if (!drc->dev) {
>              return RTAS_OUT_NO_SUCH_INDICATOR;
>          }
> +        if (drc->awaiting_release && drc->awaiting_allocation) {
> +            /* kernel is acknowledging a previous hotplug event
> +             * while we are already removing it.
> +             * it's safe to ignore awaiting_allocation here since we kno=
w the
> +             * situation is predicated on the guest either already havin=
g done
> +             * so (boot-time hotplug), or never being able to acquire in=
 the
> +             * first place (hotplug followed by immediate unplug).
> +             */
> +            drc->awaiting_allocation_skippable =3D true;
> +            return RTAS_OUT_NO_SUCH_INDICATOR;
> +        }
>      }
> =20
>      if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> @@ -436,9 +447,11 @@ static void detach(sPAPRDRConnector *drc, DeviceStat=
e *d,
>      }
> =20
>      if (drc->awaiting_allocation) {
> -        drc->awaiting_release =3D true;
> -        trace_spapr_drc_awaiting_allocation(get_index(drc));
> -        return;
> +        if (!drc->awaiting_allocation_skippable) {
> +            drc->awaiting_release =3D true;
> +            trace_spapr_drc_awaiting_allocation(get_index(drc));
> +            return;
> +        }
>      }
> =20
>      drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> @@ -448,6 +461,7 @@ static void detach(sPAPRDRConnector *drc, DeviceState=
 *d,
>      }
> =20
>      drc->awaiting_release =3D false;
> +    drc->awaiting_allocation_skippable =3D false;
>      g_free(drc->fdt);
>      drc->fdt =3D NULL;
>      drc->fdt_start_offset =3D 0;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index fa531d5..5524247 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -154,6 +154,7 @@ typedef struct sPAPRDRConnector {
>      bool awaiting_release;
>      bool signalled;
>      bool awaiting_allocation;
> +    bool awaiting_allocation_skippable;
> =20
>      /* device pointer, via link property */
>      DeviceState *dev;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2wFSAAoJEGw4ysog2bOSlgEP+gNyScw/2s0fryXXx+aApNPj
8e4Kv6IneMcq9wEPN9nlgFtwwxCYkpSB6WKqYbQPC7/uwic6pnxOMerigAY4t3V/
UHykGQU+Z1cTUEKi9sMdU26kVzLuBDEXdxDWa16QLcVtaOl48nx4FAv9d9m112kE
BuuiHpz8Ily2x2Ppi4whtX9Fkz1lziyb1jAen1RExizZVCT5br99nyY1zcAac8rS
Ry4oacuIzk3tRZC4mUMNNiuoIkOaMlOggDJg+0zOdsJFWM9VIW4vLlQB5EY40Qg4
v2jaT4jCySeJ9v/H/ZdgSkUYI5egXPim5cUJvASavBx3r1/57k1Vt7/ZOSPaJMqp
gwjPPXOGlHCOLafiWLmUaecHDZAOfQdiNUxdOyBr/dsc4OlNSAyDsCG1ixnslag+
R9cfpfdtjpi8JYl537DcuGceyPwco0n8oYuxHt1KN2ge41/ZfTuCN7w4NX+yfF0N
vKAyIfOyzyrErM9OIxZ9OQkuZLCC0HPsbg6cBW4LdECLItjR3kkxQIM8zVQMD7TA
qzSrzyajHeFXU+tEA201bNs2Fq9ypJLdSSW37OntCZUNvAbRo4VwtDHPToOx3NdI
s+zN7+iBodeM+S0iq+soAFSDqLWZN8Qmxmc90oTDX10fwfiMyqY7ayOQ0OkKZrjw
L6l8aRdTlH45xy6v2pzS
=mZut
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--

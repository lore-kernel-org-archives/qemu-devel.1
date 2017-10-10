Received: from eggs.gnu.org ([2001:4830:134:3::10]:38877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004MP-CQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTx-0004UB-8k
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:24 -0400
Received: from ozlabs.org ([103.22.144.67]:42881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e1kTw-0004Q5-HA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:21 -0400
Date: Tue, 10 Oct 2017 12:44:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010014441.GD2668@umbus.fritz.box>
References: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
	<20171009170607.4155-4-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <20171009170607.4155-4-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qdev: defer DEVICE_DEL event until
 instance_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, groug@kaod.org, peter.maydell@linaro.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, ehabkost@redhat.com


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 12:06:07PM -0500, Michael Roth wrote:
> DEVICE_DEL is currently emitted when a Device is unparented, as
> opposed to when it is finalized. The main design motivation for this
> seems to be that after unparent()/unrealize(), the Device is no
> longer visible to the guest, and thus the operation is complete
> from the perspective of management.
>=20
> However, there are cases where remaining host-side cleanup is also
> pertinent to management. The is generally handled by treating these
> resources as aspects of the "backend", which can be managed via
> separate interfaces/events, such as blockdev_add/del, netdev_add/del,
> object_add/del, etc, but some devices do not have this level of
> compartmentalization, namely vfio-pci, and possibly to lend themselves
> well to it.
>=20
> In the case of vfio-pci, the "backend" cleanup happens as part of
> the finalization of the vfio-pci device itself, in particular the
> cleanup of the VFIO group FD. Failing to wait for this cleanup can
> result in tools like libvirt attempting to rebind the device to
> the host while it's still being used by VFIO, which can result in
> host crashes or other misbehavior depending on the host driver.
>=20
> Deferring DEVICE_DEL still affords us the ability to manage backends
> explicitly, while also addressing cases like vfio-pci's, so we
> implement that approach here.
>=20
> An alternative proposal involving having VFIO emit a separate event
> to denote completion of host-side cleanup was discussed, but the
> prevailing opinion seems to be that it is not worth the added
> complexity, and leaves the issue open for other Device implementations
> solve in the future.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/qdev.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f7c66d9bd0..8b7b8c3280 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1068,7 +1068,6 @@ static void device_finalize(Object *obj)
>      NamedGPIOList *ngl, *next;
> =20
>      DeviceState *dev =3D DEVICE(obj);
> -    qemu_opts_del(dev->opts);
> =20
>      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
>          QLIST_REMOVE(ngl, node);
> @@ -1079,6 +1078,18 @@ static void device_finalize(Object *obj)
>           * here
>           */
>      }
> +
> +    /* Only send event if the device had been completely realized */
> +    if (dev->pending_deleted_event) {
> +        g_assert(dev->canonical_path);
> +
> +        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonica=
l_path,
> +                                       &error_abort);
> +        g_free(dev->canonical_path);
> +        dev->canonical_path =3D NULL;
> +    }
> +
> +    qemu_opts_del(dev->opts);
>  }
> =20
>  static void device_class_base_init(ObjectClass *class, void *data)
> @@ -1108,16 +1119,6 @@ static void device_unparent(Object *obj)
>          object_unref(OBJECT(dev->parent_bus));
>          dev->parent_bus =3D NULL;
>      }
> -
> -    /* Only send event if the device had been completely realized */
> -    if (dev->pending_deleted_event) {
> -        g_assert(dev->canonical_path);
> -
> -        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonica=
l_path,
> -                                       &error_abort);
> -        g_free(dev->canonical_path);
> -        dev->canonical_path =3D NULL;
> -    }
>  }
> =20
>  static void device_class_init(ObjectClass *class, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncJgkACgkQbDjKyiDZ
s5JIExAAs4/vnKawVkj55+6L47ngvn0sRETamiuRufDOd8b9amOCTHIZxYM/x73A
oQ/rGeoIIlibiV2P8xIf4gwhLu+XbmzQU8oLrPN2V7q9RtjgVYvIFL1KOa8ZI+e7
0HM6/qvjm3x3xW5N8m+3e+eFADb1p0za/D4Ek22WU/bQfdn77PcQTQU/RrMNObMW
+DN+XXaWF96kSOjaoqD0apt67PNowjrxHkPUwNtIbP5QVayBpnXu0Ws5IX3iT7EJ
KoW/pnITX/Qfj8ma3Som3IibxV/fFA/MhfGAbY/h30kHmy15iDQkrZk4Q1uyqBBj
zQmPtitI1UssPI5QoYKNrXf+NBrHmJm2cHmY4WlCBsY7bdRRMu4Dr/qyqSwLzXb/
M5UypzXKtAC0MLQOFjhQZnbighWi1ceEPwMXKveBCxKf+9tocr3mtxrfcgGeMcXZ
04MQqqsD1Gq8my4OlAjVkX2RXXyaT/zMiAcF0/GoSD78lWGtkph9IiBzxvdhjoJa
M/pcf2JXhGrPF0AkfmSz/LOqhURlYdyBCMmDvhhvico7jKi6TKsM7p1Qa8aWU/jG
bipPPXufoJSitxrKyvNRpIpIWpWdRFrfU2TMg6KYh2hEvUPwJoFSOLHOv4BZp28j
bsoTmUnDdh/kSXMg7bz+2enVGbHzZNLPLem2H5tOBhYgfdxgq6U=
=FSJT
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

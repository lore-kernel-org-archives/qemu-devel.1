Received: from eggs.gnu.org ([2001:4830:134:3::10]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4LAw-0000GF-7R
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4LAs-0004Tc-4E
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:26 -0400
Received: from ozlabs.org ([103.22.144.67]:59347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e4LAr-0004Rk-8u
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:22 -0400
Date: Tue, 17 Oct 2017 16:45:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171017054527.GJ2776@umbus.fritz.box>
References: <20171016222315.407-1-mdroth@linux.vnet.ibm.com>
	<20171016222315.407-2-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pz0BBB9QxoYXlT+x"
Content-Disposition: inline
In-Reply-To: <20171016222315.407-2-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qdev: store DeviceState's canonical
 path to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>


--Pz0BBB9QxoYXlT+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 05:23:13PM -0500, Michael Roth wrote:
> device_unparent(dev, ...) is called when a device is unparented,
> either directly, or as a result of a parent device being
> finalized, and handles some final cleanup for the device. Part
> of this includes emiting a DEVICE_DELETED QMP event to notify
> management, which includes the device's path in the composition
> tree as provided by object_get_canonical_path().
>=20
> object_get_canonical_path() assumes the device is still connected
> to the machine/root container, and will assert otherwise, but
> in some situations this isn't the case:
>=20
> If the parent is finalized as a result of object_unparent(), it
> will still be attached to the composition tree at the time any
> children are unparented as a result of that same call to
> object_unparent(). However, in some cases, object_unparent()
> will complete without finalizing the parent device, due to
> lingering references that won't be released till some time later.
> One such example is if the parent has MemoryRegion children (which
> take a ref on their parent), who in turn have AddressSpace's (which
> take a ref on their regions), since those AddressSpaces get cleaned
> up asynchronously by the RCU thread.
>=20
> In this case qdev:device_unparent() may be called for a child Device
> that no longer has a path to the root/machine container, causing
> object_get_canonical_path() to assert.
>=20
> Fix this by storing the canonical path during realize() so the
> information will still be available for device_unparent() in such
> cases.
>=20
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/core/qdev.c         | 16 +++++++++++++---
>  include/hw/qdev-core.h |  1 +
>  2 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 606ab53c42..ebf9d822b5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -928,6 +928,13 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>              goto post_realize_fail;
>          }
> =20
> +        /*
> +         * always free/re-initialize here since the value cannot be clea=
ned up
> +         * in device_unrealize due to its usage later on in the unplug p=
ath
> +         */
> +        g_free(dev->canonical_path);
> +        dev->canonical_path =3D object_get_canonical_path(OBJECT(dev));
> +
>          if (qdev_get_vmsd(dev)) {
>              if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(de=
v), dev,
>                                                 dev->instance_id_alias,
> @@ -984,6 +991,7 @@ child_realize_fail:
>      }
> =20
>  post_realize_fail:
> +    g_free(dev->canonical_path);

Should dev->canonical_path be set to NULL on this failure path?

>      if (dc->unrealize) {
>          dc->unrealize(dev, NULL);
>      }
> @@ -1102,10 +1110,12 @@ static void device_unparent(Object *obj)
> =20
>      /* Only send event if the device had been completely realized */
>      if (dev->pending_deleted_event) {
> -        gchar *path =3D object_get_canonical_path(OBJECT(dev));
> +        g_assert(dev->canonical_path);
> =20
> -        qapi_event_send_device_deleted(!!dev->id, dev->id, path, &error_=
abort);
> -        g_free(path);
> +        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonica=
l_path,
> +                                       &error_abort);
> +        g_free(dev->canonical_path);
> +        dev->canonical_path =3D NULL;
>      }
> =20
>      qemu_opts_del(dev->opts);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 089146197f..0a71bf83f0 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -153,6 +153,7 @@ struct DeviceState {
>      /*< public >*/
> =20
>      const char *id;
> +    char *canonical_path;
>      bool realized;
>      bool pending_deleted_event;
>      QemuOpts *opts;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pz0BBB9QxoYXlT+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnlmPQACgkQbDjKyiDZ
s5JGsRAAxBt0b+VyhKTCb5VvUDk25FEYCDYZ7Mv+wkOk33gcgMbhTTF0wvNAjvqO
DMDgwzitErz3l4IDFWYTNec2IYZBdeG2pG4oGb1wSG24W+Mnnbdugwj7tXGFFOh3
dFDi1JRHX0CkXFFqCX4jeQVxlcgLqGop5oGtjBxxeTKsJngdutypZ2JN5WemyMBo
5ChjszKF+AqKcLG2sUcYLO2Stxp6sKdaXp9sO8iZoRMiOSJOYzEwA4yoopvccMRJ
DU+HRbIt9lpVhPWsP9Gi7N7v7edkseJLqUXMvWD/+um+WRPYdhxhOu69et0tuQJl
BXxarzepoKR6Fl5fN05FCXuMszkQrxH1W0YpgHC7NRVs7GdPhjZ/FqYVMCBKp7Qf
gsHUVKnCLbY3E3v1KTYzREd+uGze8dz0rHAR1GRuI36y8po3PzTx/fh1KvcqP4A6
bESJTXZImCdqbHaYeys1gMSLNRFldUugLy4CO90ug4FLrKzAXDkl0ZfnakxWXxQZ
hZeSPXcBt2ZWMnqccAi5HvE7EuPPI8w489jWYWhub0C6w2XpSjr6fGhEQ0WOPpAT
kKBHl5+K89xvHgfXn1YJsVHMAunzTNFDJDC/EdixDnSWrZFGG1SoNYw9QnDT6Ozd
bqig8Ajg7XNUBtojuCerWTlAxblW/Vr/7zlwBEF8xB/AJPMBxvI=
=yibk
-----END PGP SIGNATURE-----

--Pz0BBB9QxoYXlT+x--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcEEB-0002x9-0o
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcEE5-0006H1-M2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:11:34 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:47256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcEE5-0006DF-EE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:11:29 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1489E666CF
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 19:11:28 +0200 (CEST)
Date: Mon, 31 Jul 2017 19:11:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170731191119.13687ee2@bahia.lan>
In-Reply-To: <1501119055-4060-4-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1501119055-4060-4-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/47hyglSYElyLOsgK78a8/KO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] qdev: defer DEVICE_DEL event
 until instance_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, armbru@redhat.com

--Sig_/47hyglSYElyLOsgK78a8/KO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 20:30:55 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

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
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/core/qdev.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 08c4061..d14acba 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1067,7 +1067,6 @@ static void device_finalize(Object *obj)
>      NamedGPIOList *ngl, *next;
> =20
>      DeviceState *dev =3D DEVICE(obj);
> -    qemu_opts_del(dev->opts);
> =20
>      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
>          QLIST_REMOVE(ngl, node);
> @@ -1078,6 +1077,18 @@ static void device_finalize(Object *obj)
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
> @@ -1107,16 +1118,6 @@ static void device_unparent(Object *obj)
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


--Sig_/47hyglSYElyLOsgK78a8/KO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll/ZLcACgkQAvw66wEB28JiLACgiwWnpuyb45baRektz91j0ARu
DHoAoIt4wrHO2RV1a1TCyLM0mlmQWOqp
=hIJx
-----END PGP SIGNATURE-----

--Sig_/47hyglSYElyLOsgK78a8/KO--

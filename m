Received: from eggs.gnu.org ([2001:4830:134:3::10]:35839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVeLo-0002hq-Qk
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVeLi-0000Xb-W5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVeLi-0000Wh-PI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:40:10 -0400
Date: Thu, 13 Jul 2017 14:40:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170713134002.GB18623@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-3-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-3-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] virtio: enhance virtio_error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:31PM +0200, Ladi Prosek wrote:
> +static const char *virtio_get_device_id(VirtIODevice *vdev)
> +{
> +    DeviceState *qdev =3D DEVICE(vdev);
> +    while (qdev) {
> +        /* Find the proxy object corresponding to the vdev backend */
> +        Object *prop =3D object_property_get_link(OBJECT(qdev),
> +                                                VIRTIO_PROP_BACKEND, NUL=
L);
> +        if (prop =3D=3D OBJECT(vdev)) {
> +            return qdev->id;
> +        }
> +        qdev =3D qdev->parent_bus->parent;
> +    }
> +    return NULL;
> +}
> +
>  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt=
, ...)
>  {
>      va_list ap;
> =20
> +    error_report_nolf("%s (id=3D%s): ", vdev->name, virtio_get_device_id=
(vdev));

virtio_get_device_id() can return NULL.  POSIX does not guarantee that
the printf(3) family functions handle "%s", NULL safely.  glibc prints
"(null)" but other libc implementations crash (e.g. Solaris).

http://pubs.opengroup.org/onlinepubs/9699919799/functions/fprintf.html

Should the return NULL above have g_assert_not_reached()?  That would
communicate the assumption that we never reach return NULL and it might
silence static checkers like Coverity but I'm not sure.

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZ3gyAAoJEJykq7OBq3PIUdMIAJOl5VBGJqqa30UH8tZpxw87
MjZ16MmbQ0/2DjVkSO4psA1BNTSzbd6IVlaTjcfDCZxexHLveUHUD3M29/SKZ1SN
1mJP1YyFLsq/sMRebfUUem0JeJxys9LbXuUHtWj9W+4toSm0Ws2cHEN9X8xEaq2T
IUJW8Ck5mq2LB0LBxbGqGEAyIE7OjBSNA16OjDtoFKcHvs+EIIsI/JRc9Vz89wzk
A/adWtorEHD6W0PVjvPW+gQr81DvW6ndVsdl/VdHPeSnS7h56QChI2uwr39pPKqD
WgDvyO24m9afVvCw+eAFRGVYu0sgNWanEbbAIy67OL4Bhbqv2T+zvWfnNQNsNKI=
=yMAB
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

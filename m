Received: from eggs.gnu.org ([2001:4830:134:3::10]:42749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5N-00026p-KL
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5K-0002Ox-GI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:57 -0400
Date: Mon, 10 Apr 2017 15:36:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410053652.GP27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-18-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-18-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/21] qdev: Add a hook for a bus to device
 if it can add devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:42PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This allows a bus class to tell whether a given bus has room for
> any new device. max_dev isn't sufficient as the rules can depend
> on some arguments or can differ between instances of a bus. This
> will be used by PCI in subsequent patches
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [clg: updated for qemu-2.9 ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         | 14 +++++++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b44b47676576..867662ba5352 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -201,6 +201,7 @@ struct BusClass {
>       */
>      char *(*get_fw_dev_path)(DeviceState *dev);
>      void (*reset)(BusState *bus);
> +    bool (*can_add_device)(BusState *bus, QemuOpts *opts);
>      BusRealize realize;
>      BusUnrealize unrealize;
> =20
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 5f2fcdfc4551..c6eca929c473 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -415,7 +415,7 @@ static inline bool qbus_is_full(BusState *bus)
>   * Return the bus if found, else %NULL.
>   */
>  static BusState *qbus_find_recursive(BusState *bus, const char *name,
> -                                     const char *bus_typename)
> +                                     const char *bus_typename, QemuOpts =
*opts)
>  {
>      BusChild *kid;
>      BusState *pick, *child, *ret;
> @@ -429,7 +429,10 @@ static BusState *qbus_find_recursive(BusState *bus, =
const char *name,
>      }
> =20
>      if (match && !qbus_is_full(bus)) {
> -        return bus;             /* root matches and isn't full */
> +        BusClass *bc =3D BUS_GET_CLASS(bus);
> +        if (!bc->can_add_device || bc->can_add_device(bus, opts)) {
> +            return bus;             /* root matches and isn't full */

Seems like qbus_is_full() should be changed to use the can_add_device
hook, rather than changing the caller here.  Essentially the current
max_devs implementation would become the fallback if the bus doesn't
define a bus specific test.

> +        }
>      }
> =20
>      pick =3D match ? bus : NULL;
> @@ -437,7 +440,7 @@ static BusState *qbus_find_recursive(BusState *bus, c=
onst char *name,
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
>          DeviceState *dev =3D kid->child;
>          QLIST_FOREACH(child, &dev->child_bus, sibling) {
> -            ret =3D qbus_find_recursive(child, name, bus_typename);
> +            ret =3D qbus_find_recursive(child, name, bus_typename, opts);
>              if (ret && !qbus_is_full(ret)) {
>                  return ret;     /* a descendant matches and isn't full */
>              }
> @@ -467,7 +470,7 @@ static BusState *qbus_find(const char *path, Error **=
errp)
>              assert(!path[0]);
>              elem[0] =3D len =3D 0;
>          }
> -        bus =3D qbus_find_recursive(sysbus_get_default(), elem, NULL);
> +        bus =3D qbus_find_recursive(sysbus_get_default(), elem, NULL, NU=
LL);
>          if (!bus) {
>              error_setg(errp, "Bus '%s' not found", elem);
>              return NULL;
> @@ -591,7 +594,8 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **=
errp)
>              return NULL;
>          }
>      } else if (dc->bus_type !=3D NULL) {
> -        bus =3D qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_=
type);
> +        bus =3D qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_=
type,
> +                                  opts);
>          if (!bus || qbus_is_full(bus)) {
>              error_setg(errp, "No '%s' bus found for device '%s'",
>                         dc->bus_type, driver);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xn0AAoJEGw4ysog2bOSDT4P/i71/W3n0ZaE3IBY8uB8+Mz1
Pblx7EOezaAyDoZ0cmObt77UyXZPEKE4CL2P6pZtih+KCWc6znMTsl/iItiP/841
DPUPd4iAqowO24kWbw94vLNqfqAlv2/Gmb7+MnbLb0iKfdcinKOXV5hN9YtC3sP8
s9Xt40kUUIU+5n9ZVY5V8IOHnECel5My7lJqcylS43JaS+draH75dv0Xt/+0BS8j
CrUvKNUP6H01jFhYhob3P+p7qqTKrJi44EancnfN+eWpnfIbSJNj+xmXH+A4ojPS
o71xs3fFMRkWOExQWy8C2/hH+B6eBmtsd+5wFqYEYIp3CBfyHjzcPY+zce3t+ecz
sm7zniY+s+WNa0JlDHqsScd7fA1/u9DdIGvBNwaRN2DeJ2/ZU6T7bJXDOcYfN8sJ
Xta+P8H415WXt9/CVQ1j8gIoDI9ny5HB6MNkYnqUMxvsXbMUFFpCCO3Pca/v3j/z
CIE6G7FzPi7GEOIg4n2wWlfv81PpiFAeTQuvlCo5UfQwSXdrGXo4Vnctm+tu47j4
0rSRw8ha/sfxFIimDVpPyC4aIAirF0BjbBgXePTaltM2kp5GUXF7CUvI8ODTL+5V
HL4UhCH+5Rs8CEmsIe7FUE70oXA6IYlCGrUWszGxbwzPmxlUznhv6xyZkc6YR8oK
H5G2pPlMvHwg8E/AM5wb
=+wHV
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--

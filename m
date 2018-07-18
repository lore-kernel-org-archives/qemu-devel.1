Received: from eggs.gnu.org ([2001:4830:134:3::10]:55615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffbwY-000680-Fd
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffbwX-0004i3-0O
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:11:54 -0400
Date: Wed, 18 Jul 2018 11:57:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180718015718.GA2102@umbus.fritz.box>
References: <1531839114-13671-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <1531839114-13671-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/misc/macio: Fix device
 introspection problems in macio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 04:51:54PM +0200, Thomas Huth wrote:
11;rgb:ffff/ffff/ffff> Valgrind reports an error when introspecting the mac=
io devices, e.g.:
>=20
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties',=
" \
>  "'arguments':{'typename':'macio-newworld'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q ppc64-softmmu/qemu-system-ppc64 -M none,accel=3Dqtest -qmp s=
tdio
> [...]
> =3D=3D30768=3D=3D Invalid read of size 8
> =3D=3D30768=3D=3D    at 0x5BC1EA: qdev_print (qdev-monitor.c:686)
> =3D=3D30768=3D=3D    by 0x5BC1EA: qbus_print (qdev-monitor.c:719)
> =3D=3D30768=3D=3D    by 0x43E458: handle_hmp_command (monitor.c:3446)
> [...]
>=20
> Use the new function sysbus_init_child_obj() to initialize the objects
> here, to get the reference counting of the objects right, so that they
> are cleaned up correctly when the parent gets removed.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/misc/macio/cuda.c  |  5 ++---
>  hw/misc/macio/macio.c | 24 ++++++++----------------
>  hw/misc/macio/pmu.c   |  5 ++---
>  3 files changed, 12 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 9651ed9..c4f7a2f 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -554,9 +554,8 @@ static void cuda_init(Object *obj)
>      CUDAState *s =3D CUDA(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> =20
> -    object_initialize(&s->mos6522_cuda, sizeof(s->mos6522_cuda),
> -                      TYPE_MOS6522_CUDA);
> -    qdev_set_parent_bus(DEVICE(&s->mos6522_cuda), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "mos6522-cuda", &s->mos6522_cuda,
> +                          sizeof(s->mos6522_cuda), TYPE_MOS6522_CUDA);
> =20
>      memory_region_init_io(&s->mem, obj, &mos6522_cuda_ops, s, "cuda", 0x=
2000);
>      sysbus_init_mmio(sbd, &s->mem);
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index d135e3b..52aa377 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -209,14 +209,11 @@ static void macio_oldworld_realize(PCIDevice *d, Er=
ror **errp)
>  static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, size_t ide=
_size,
>                             int index)
>  {
> -    gchar *name;
> +    gchar *name =3D g_strdup_printf("ide[%i]", index);
> =20
> -    object_initialize(ide, ide_size, TYPE_MACIO_IDE);
> -    qdev_set_parent_bus(DEVICE(ide), sysbus_get_default());
> +    sysbus_init_child_obj(OBJECT(s), name, ide, ide_size, TYPE_MACIO_IDE=
);
>      memory_region_add_subregion(&s->bar, 0x1f000 + ((index + 1) * 0x1000=
),
>                                  &ide->mem);
> -    name =3D g_strdup_printf("ide[%i]", index);
> -    object_property_add_child(OBJECT(s), name, OBJECT(ide), NULL);
>      g_free(name);
>  }
> =20
> @@ -232,9 +229,7 @@ static void macio_oldworld_init(Object *obj)
>                               qdev_prop_allow_set_link_before_realize,
>                               0, NULL);
> =20
> -    object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
> -    qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
> -    object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
> +    sysbus_init_child_obj(obj, "cuda", &s->cuda, sizeof(s->cuda), TYPE_C=
UDA);
> =20
>      object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
>      dev =3D DEVICE(&os->nvram);
> @@ -390,8 +385,8 @@ static void macio_newworld_init(Object *obj)
>                               qdev_prop_allow_set_link_before_realize,
>                               0, NULL);
> =20
> -    object_initialize(&ns->gpio, sizeof(ns->gpio), TYPE_MACIO_GPIO);
> -    qdev_set_parent_bus(DEVICE(&ns->gpio), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "gpio", &ns->gpio, sizeof(ns->gpio),
> +                          TYPE_MACIO_GPIO);
> =20
>      for (i =3D 0; i < 2; i++) {
>          macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
> @@ -404,13 +399,10 @@ static void macio_instance_init(Object *obj)
> =20
>      memory_region_init(&s->bar, obj, "macio", 0x80000);
> =20
> -    object_initialize(&s->dbdma, sizeof(s->dbdma), TYPE_MAC_DBDMA);
> -    qdev_set_parent_bus(DEVICE(&s->dbdma), sysbus_get_default());
> -    object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
> +    sysbus_init_child_obj(obj, "dbdma", &s->dbdma, sizeof(s->dbdma),
> +                          TYPE_MAC_DBDMA);
> =20
> -    object_initialize(&s->escc, sizeof(s->escc), TYPE_ESCC);
> -    qdev_set_parent_bus(DEVICE(&s->escc), sysbus_get_default());
> -    object_property_add_child(obj, "escc", OBJECT(&s->escc), NULL);
> +    sysbus_init_child_obj(obj, "escc", &s->escc, sizeof(s->escc), TYPE_E=
SCC);
>  }
> =20
>  static const VMStateDescription vmstate_macio_oldworld =3D {
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index e246b0f..d25344f 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -770,9 +770,8 @@ static void pmu_init(Object *obj)
>                               qdev_prop_allow_set_link_before_realize,
>                               0, NULL);
> =20
> -    object_initialize(&s->mos6522_pmu, sizeof(s->mos6522_pmu),
> -                      TYPE_MOS6522_PMU);
> -    qdev_set_parent_bus(DEVICE(&s->mos6522_pmu), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "mos6522-pmu", &s->mos6522_pmu,
> +                          sizeof(s->mos6522_pmu), TYPE_MOS6522_PMU);
> =20
>      memory_region_init_io(&s->mem, obj, &mos6522_pmu_ops, s, "via-pmu",
>                            0x2000);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltOnnoACgkQbDjKyiDZ
s5Lavw/+JBCwnan3qRhjmK+TBkPOOku8R6w8tCw86tc7mEwupWRxW3VYNMIU2oNN
ygkdRnMT4H2ZMHWmLjok+hn6ggr4/z9aQdBOWQcayA6VnocA7Cc5y5FtWptNfT5n
yplNMXwTHj7j/1Ekhg8dVvcX5RUbV0JrNbCdlLE7/YYjAIVWdjjAR2Hh00Sh503y
1VlPZuKYlE3UhZL4FoLuHNJbyQ2eJhTSKrTT/SFdr8IYeU+pA61jYtdYN3UfTvZi
PxMRca6NB7HZ51+jjiFDW0JeenFEehB0pPe/f0g6Lea1nP/NkpNpGZmYcllHfB6O
QxYsEgYI2TQB2kAEh0GN8cy/anzawlBtdIFpZepkMB1iHj6tGI+E0jLYAvkpJUI5
zSV7OiGNjYOcrUAYQhgaHCUtbTcfEM+wKegZ72WrTq6oR8o9gbXAnE2/1kFSJQOS
jIRAwQY2x0Yjsnhpo0dcVexuDwbE8KWxlTJEtA6rxQ/bm1ei3grQvOr3QT44YPJR
s/pQGjASQk6KdG0aOeW6WE2F3y6d8zXprxXScAsyOYXY35G0e1ZAW0OhePzIjDRG
bNwVUqe9jvIwaj1pANJC2er4pwH7vXu6nO8AuTI9XpEiQWt21tOuowCo24gyR71L
C+HpJOqlhJ7OChAvL5cqWZl/UsMokqyVhxYXqcu6fH6ANF89ujU=
=OpJE
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

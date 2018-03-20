Received: from eggs.gnu.org ([2001:4830:134:3::10]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ey6Ij-0002aj-Px
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ey6Ii-0006OZ-LS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:42:57 -0400
Date: Tue, 20 Mar 2018 11:01:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180320000124.GJ3905@umbus.fritz.box>
References: <1521468046-10400-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline
In-Reply-To: <1521468046-10400-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/misc/macio: Fix crash when
 listing device properties of macio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 03:00:46PM +0100, Thomas Huth wrote:
> The macio-newworld device can currently be used to abort QEMU unexpectedl=
y:
>=20
> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=3Dqtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> { 'execute': 'qmp_capabilities' }
> {"return": {}}
> { 'execute': 'device-list-properties',
>   'arguments': {'typename': 'macio-newworld'}}
> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> Device 'serial0' is in use
> Aborted (core dumped)
>=20
> qdev properties should be set during realize(), not during instance_init(=
),
> so move the related code there to fix this problem.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  hw/misc/macio/macio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 454244f..b74a657 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -115,6 +115,13 @@ static void macio_common_realize(PCIDevice *d, Error=
 **errp)
>      memory_region_add_subregion(&s->bar, 0x16000,
>                                  sysbus_mmio_get_region(sysbus_dev, 0));
> =20
> +    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
> +    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
> +    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
> +    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
> +    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
> +    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
> +    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>      object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -341,13 +348,6 @@ static void macio_instance_init(Object *obj)
>      object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
> =20
>      object_initialize(&s->escc, sizeof(s->escc), TYPE_ESCC);
> -    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
> -    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
> -    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
> -    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
> -    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>      qdev_set_parent_bus(DEVICE(&s->escc), sysbus_get_default());
>      object_property_add_child(obj, "escc", OBJECT(&s->escc), NULL);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqwT1QACgkQbDjKyiDZ
s5LIuw//RNnEirlL3vWk6sDao64Tu6Y4ffxvyMWNffkx8DlgDgQgN/SYVWQchrGW
3e/kZbbKaSAVZIJk9VihDA3at2lvXCzrSq3YVm+yv9SwZz7g7gv01zDKhJfBjfZH
QyNym2v9wCWISL+Ksx6lT6Z0+7rx7DndRVN5HaCHy3dDZbIJf6d1QnXbzuCtKtkG
NdTKgCUkKoKADYBk/jYTv7SqGRYcj0/hlnqJc1OqsPB1ds5YeGAGHBELE2E9WHdD
pGX1qdhjDXple29Novr4N8OHpzLRPUqgBPAXDkmeudSWN9hfbB5uTeT4mgok1pPU
puaZEmTJ9X8zFDxuVAGwl4rg5AmU00c3GJHqm8f/9/dWhIMrykehTCMRCv7CtX5F
yWN/2uZ6i52GBikWFReYjvl+5eQhMr1dsoYgbhg9lzbTRJzYKqvdiieQ6RKBkJDO
7gmbyED7qNe80coxvRtDoTe900QbFOLcGvAJiOSLyUjCg+Hzoo1XGbSGQQWtzQGZ
Dyff24DVWRaXuWqyKYE+IPeuYVtdfiUei9D64A2rFAJa0k3hafrBUhJwc0Skuf/3
UPluZDjwsAtqifAaC3SsMW4fb12jdmDGdWUFgXCdYplQT3G7IX69RDc4rzUkP0pb
x9hZJUhyyyWG0rxgUYkNeeBn2Jos9fZy+54bj5PPOrZoRwcyp6w=
=z0Gi
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTNvC-0004tr-74
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTNv9-00051n-8v
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:14 -0500
Date: Sun, 2 Dec 2018 19:54:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181202085432.GK30479@umbus.fritz.box>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <20181130151712.2312-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 01/10] hw/ppc/mac_newworld,
 mac_oldworld: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 03:17:03PM +0000, Peter Maydell wrote:
> The load_image() function is deprecated, as it does not let the
> caller specify how large the buffer to read the file into is.
> Use the glib g_file_get_contents() function instead, which does
> the whole "allocate memory for the file and read it in" operation.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/mac_newworld.c | 10 ++++------
>  hw/ppc/mac_oldworld.c | 10 ++++------
>  2 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 14273a123e5..7e45afae7c5 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -127,8 +127,7 @@ static void ppc_core99_init(MachineState *machine)
>      MACIOIDEState *macio_ide;
>      BusState *adb_bus;
>      MacIONVRAMState *nvr;
> -    int bios_size, ndrv_size;
> -    uint8_t *ndrv_file;
> +    int bios_size;
>      int ppc_boot_device;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      void *fw_cfg;
> @@ -510,11 +509,10 @@ static void ppc_core99_init(MachineState *machine)
>      /* MacOS NDRV VGA driver */
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, NDRV_VGA_FILENAME);
>      if (filename) {
> -        ndrv_size =3D get_image_size(filename);
> -        if (ndrv_size !=3D -1) {
> -            ndrv_file =3D g_malloc(ndrv_size);
> -            ndrv_size =3D load_image(filename, ndrv_file);
> +        gchar *ndrv_file;
> +        gsize ndrv_size;
> =20
> +        if (g_file_get_contents(filename, &ndrv_file, &ndrv_size, NULL))=
 {
>              fw_cfg_add_file(fw_cfg, "ndrv/qemu_vga.ndrv", ndrv_file, ndr=
v_size);
>          }
>          g_free(filename);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 9891c325a9b..817f70e52cf 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -99,8 +99,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      SysBusDevice *s;
>      DeviceState *dev, *pic_dev;
>      BusState *adb_bus;
> -    int bios_size, ndrv_size;
> -    uint8_t *ndrv_file;
> +    int bios_size;
>      uint16_t ppc_boot_device;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      void *fw_cfg;
> @@ -361,11 +360,10 @@ static void ppc_heathrow_init(MachineState *machine)
>      /* MacOS NDRV VGA driver */
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, NDRV_VGA_FILENAME);
>      if (filename) {
> -        ndrv_size =3D get_image_size(filename);
> -        if (ndrv_size !=3D -1) {
> -            ndrv_file =3D g_malloc(ndrv_size);
> -            ndrv_size =3D load_image(filename, ndrv_file);
> +        gchar *ndrv_file;
> +        gsize ndrv_size;
> =20
> +        if (g_file_get_contents(filename, &ndrv_file, &ndrv_size, NULL))=
 {
>              fw_cfg_add_file(fw_cfg, "ndrv/qemu_vga.ndrv", ndrv_file, ndr=
v_size);
>          }
>          g_free(filename);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwDncUACgkQbDjKyiDZ
s5K1CRAAv+AQp+AmwpryKeQ46ovv63OD2MxrGt8tEAkPrGVNT6N41o91qwQ4Imw8
UKCbOuLosxpJ7rR7rysOa0ng+8ibK8gZOSk2VexIRwVIQe8FpPjoQ/TPLkARm8ey
MJ2OwylJ/FndSkxYxIPzs369myLzkz5hZpkmyTXOssV668yUf+T1G9uhuLE8uYo4
5gfHA/0u/75ZizNBWD/ejgi7bV8F1CcuQQkJLAS46AxjBGghjiqkCVULcHyt5taL
XKVkrVlHDkXFtnxboOk4AEcpHOEHw9BiTP9sZxgpyhHi3mi9K3mvrDoeqszed1hW
QdPkDKgkfdtlLKRfk80Gep6IIQTc/OsGyEjdjZ+Z5VgNuKn377PoOLpOcrHmMsGj
7D6R2nDno8rVjYquMkrG9LdYaM0EHHhjp81nEVURn7uimqN0TsFTGziMRghiz6UM
cXB5/FmuY6QA/9jHJUDfU159w1k7BkGP8iPRaaeFSJVJsqSSsP6RhovxV3TUCpk6
XqHG+yZ944Ep1Fna1PEu9oDTpdt9+91iQhkciy01Tru6qZmoPuRGm5ekwrN5mUAR
V6OdZXNa0x3cI+Rv4XLO/zuB1AovSTbKLKuYFIkxYSq2Lzc+a22L5I9l5fT/U1Et
jTpywTIdE5Lg/Sy+UglHUFQFnWYgwc+1+6mMtZf6cCARn3DWmUY=
=Xiu7
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--

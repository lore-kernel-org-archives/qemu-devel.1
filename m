Received: from eggs.gnu.org ([209.51.188.92]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glU7V-0008QQ-Ne
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glU7U-0004M1-Fy
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:35:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glU7U-0004LD-72
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:35:44 -0500
Date: Mon, 21 Jan 2019 08:35:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190121073537.kez4xvln7anz2vzr@sirius.home.kraxel.org>
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-3-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190118223400.24311-3-lersek@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] roms: build the EfiRom utility from
 the roms/edk2 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On Fri, Jan 18, 2019 at 11:33:57PM +0100, Laszlo Ersek wrote:
> Building the EfiRom utility from "roms/edk2/BaseTools" should make
> "roms/Makefile" more self-contained. Otherwise, we'd call the system-wi=
de
> EfiRom for building the combined iPXE option ROMs, but call the sibling
> utilities from "roms/edk2/BaseTools" for building "roms/edk2" content.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
>  roms/Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index a6043eff37e9..78d5dd18c301 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -47,10 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>  # We need that to combine multiple images (legacy bios,
>  # efi ia32, efi x64) into a single rom binary.
>  #
> -# We try to find it in the path.  You can also pass the location on
> -# the command line, i.e. "make EFIROM=3D/path/to/EfiRom efirom"
> -#
> -EFIROM ?=3D $(shell which EfiRom 2>/dev/null)
> +EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> =20
>  default:
>  	@echo "nothing is build by default"
> @@ -59,8 +56,7 @@ default:
>  	@echo "  vgabios        -- update vgabios binaries (seabios)"
>  	@echo "  sgabios        -- update sgabios binaries"
>  	@echo "  pxerom         -- update nic roms (bios only)"
> -	@echo "  efirom         -- update nic roms (bios+efi, this needs"
> -	@echo "                    the EfiRom utility from edk2 / tianocore)"
> +	@echo "  efirom         -- update nic roms (bios+efi)"
>  	@echo "  slof           -- update slof.bin"
>  	@echo "  skiboot        -- update skiboot.lid"
>  	@echo "  u-boot.e500    -- update u-boot.e500"
> @@ -106,7 +102,7 @@ pxe-rom-%: build-pxe-roms
> =20
>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
> =20
> -efi-rom-%: build-pxe-roms build-efi-roms
> +efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
>  	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
> @@ -124,6 +120,8 @@ build-efi-roms: build-pxe-roms
>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
> =20
> +$(EFIROM):
> +	$(MAKE) -C edk2/BaseTools
> =20
>  slof:
>  	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
> @@ -150,6 +148,7 @@ clean:
>  	$(MAKE) -C sgabios clean
>  	rm -f sgabios/.depend
>  	$(MAKE) -C ipxe/src veryclean
> +	$(MAKE) -C edk2/BaseTools clean
>  	$(MAKE) -C SLOF clean
>  	rm -rf u-boot/build.e500
>  	$(MAKE) -C u-boot-sam460ex distclean
> --=20
> 2.19.1.3.g30247aa5d201
>=20
>=20

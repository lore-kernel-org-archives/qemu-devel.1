Received: from eggs.gnu.org ([209.51.188.92]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDRuv-0004WZ-PT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDRut-0000cn-OW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDRuq-0000Rc-1W
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:54:17 -0400
References: <20190405153314.2068-1-philmd@redhat.com>
	<20190405153314.2068-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <38bea80e-fe2a-78d6-bd2e-f997ea9e4df2@redhat.com>
Date: Mon, 8 Apr 2019 12:54:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190405153314.2068-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 1/2] roms: Rename the EFIROM
 variable to avoid clashing with iPXE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 04/05/19 17:33, Philippe Mathieu-Daud=C3=A9 wrote:
> The iPXE project already uses the EFIROM for a tool named 'efirom'
> which is not the Intel EfiRom used by the EDK2 project. To make
> the difference obvious, rename the variable.
>=20
> This fixes a long standing issue which is now masked since commit
> f590a812c21 "roms: build the EfiRom utility from the roms/edk2
> submodule" (but would reappear in the next commit):

[*]

>=20
>   $ git checkout f590a812c21~
>   $ make -C roms clean EFIROM=3D$(type -P EfiRom)
>   make: Entering directory '/source/qemu/roms'
>   [...]
>   make -C ipxe/src veryclean
>   make[1]: Entering directory '/source/qemu/roms/ipxe/src'
>   rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.* b=
in{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin ./util/el=
f2efi32 ./util/elf2efi64 /usr/bin/EfiRom ./util/efifatbin ./util/iccfix .=
/util/einfo TAGS bin{,-*}/symtab
>   rm: cannot remove '/usr/bin/EfiRom': Permission denied
>   make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
>   make[1]: Leaving directory '/source/qemu/roms/ipxe/src'
>   make: *** [Makefile:152: clean] Error 2
>   make: Leaving directory '/source/qemu/roms'
>=20
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index 78d5dd18c30..d28252dafdf 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>  # We need that to combine multiple images (legacy bios,
>  # efi ia32, efi x64) into a single rom binary.
>  #
> -EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> +EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> =20
>  default:
>  	@echo "nothing is build by default"
> @@ -102,8 +102,8 @@ pxe-rom-%: build-pxe-roms
> =20
>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
> =20
> -efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
> -	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
> +efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
> +	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
>  		-ec ipxe/src/bin-x86_64-efi/$(VID)$(DID).efidrv \
> @@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
> =20
> -$(EFIROM):
> +$(EDK2_EFIROM):
>  	$(MAKE) -C edk2/BaseTools
> =20
>  slof:
>=20

Upon reading your and Olaf's comments in the v1 thread:

  [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden

I've changed my mind on this series.

Please insert a paragraph at [*] in the commit message:

"iPXE's 'veryclean' recipe removes $(EFIROM) even if the EFIROM macro
originates from elsewhere."

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(I'll comment under patch#2 separately.)

Thank you for picking this up.
Laszlo

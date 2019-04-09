Received: from eggs.gnu.org ([209.51.188.92]:37304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDscP-00061S-Ru
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDscO-0006Ab-BF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDscN-00069l-Uf
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:00 -0400
References: <20190409134536.15548-1-philmd@redhat.com>
	<20190409134536.15548-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8cb9bfab-f213-9dc7-2fb6-96e412ec06ff@redhat.com>
Date: Tue, 9 Apr 2019 17:24:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190409134536.15548-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 2/2] roms: Allow passing
 configure options to the EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 04/09/19 15:45, Philippe Mathieu-Daud=C3=A9 wrote:
> Since commit f590a812c210 we build the EDK2 EfiRom utility
> unconditionally.
>=20
> Some distributions require to use extra compiler/linker flags,
> i.e. SUSE which enforces the PIE protection (see [*]).
>=20
> EDK2 build tools already provide a set of variables for that,
> use them to allow the caller to easily inject compiler/linker
> options..
>=20
> Now build scripts can pass extra options, example:
>=20
>   $ make -C roms \
>       EDK2_BASETOOLS_OPTFLAGS=3D'-fPIE' \
>       efirom
>=20
> [*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html
>=20
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/Makefile | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index d28252dafdf..1ff78b63bb3 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -120,8 +120,21 @@ build-efi-roms: build-pxe-roms
>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
> =20
> +# Build scripts can pass compiler/linker flags to the EDK2 build tools
> +# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
> +# EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
> +#
> +# Example:
> +#
> +#  make -C roms \
> +#    EDK2_BASETOOLS_OPTFLAGS=3D'...' \
> +#    EDK2_BASETOOLS_LDFLAGS=3D'...' \
> +#    efirom
> +#
>  $(EDK2_EFIROM):
> -	$(MAKE) -C edk2/BaseTools
> +	$(MAKE) -C edk2/BaseTools \
> +		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
> +		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
> =20
>  slof:
>  	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

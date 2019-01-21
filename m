Received: from eggs.gnu.org ([209.51.188.92]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glU7V-0008QC-Cr
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glU7U-0004Ld-6M
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:35:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glU7T-0004IQ-U1
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:35:44 -0500
Date: Mon, 21 Jan 2019 08:35:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190121073524.mfdsz3va2pzs5rgw@sirius.home.kraxel.org>
References: <20190118223400.24311-1-lersek@redhat.com>
	<20190118223400.24311-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190118223400.24311-2-lersek@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] roms: add the edk2 project as a git
 submodule
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

On Fri, Jan 18, 2019 at 11:33:56PM +0100, Laszlo Ersek wrote:
> The roms/edk2 submodule can help with three goals:
> - build the OVMF and ArmVirtQemu virtual UEFI firmware platforms (to be
>   implemented later),
> - build the EfiRom tool on the fly, which is used in roms/Makefile, for
>   building the "efirom" target,
> - build UEFI test applications (to be run in guests), for qtest support=
.
>=20
> Edk2 commit 85588389222a3636baf0f9ed8227f2434af4c3f9 stands for the lat=
est
> "stable tag", namely "edk2-stable201811".
>=20
> The edk2 repository tracks some binary files that should not be removed=
 by
> QEMU's top-level "make clean"; exempt the full pathnames from the "find=
"
> command.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  Makefile    | 6 +++++-
>  .gitmodules | 3 +++
>  roms/edk2   | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index dccba1dca27f..1f768e2bcf8f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -602,7 +602,11 @@ clean:
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.=
h gen-op-arm.h
>  	rm -f qemu-options.def
>  	rm -f *.msi
> -	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[=
oda]' \) -type f -exec rm {} +
> +	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[=
oda]' \) -type f \
> +		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
> +		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
> +		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
> +		-exec rm {} +
>  	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.*=
 *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f qemu-img-cmds.h
> diff --git a/.gitmodules b/.gitmodules
> index 6b91176098c8..ceafb0ee29a0 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -49,3 +49,6 @@
>  [submodule "tests/fp/berkeley-softfloat-3"]
>  	path =3D tests/fp/berkeley-softfloat-3
>  	url =3D https://github.com/cota/berkeley-softfloat-3
> +[submodule "roms/edk2"]
> +	path =3D roms/edk2
> +	url =3D https://github.com/tianocore/edk2.git
> diff --git a/roms/edk2 b/roms/edk2
> new file mode 160000
> index 000000000000..85588389222a
> --- /dev/null
> +++ b/roms/edk2
> @@ -0,0 +1 @@
> +Subproject commit 85588389222a3636baf0f9ed8227f2434af4c3f9
> --=20
> 2.19.1.3.g30247aa5d201
>=20
>=20

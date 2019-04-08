Received: from eggs.gnu.org ([209.51.188.92]:39601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQXV-0001o5-Vo
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQSd-0003rJ-Kg
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDQSd-0003pZ-8r
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:21:03 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20190405153314.2068-1-philmd@redhat.com>
	<7fde154a-4384-0233-fae5-7dc9e288ccec@redhat.com>
Message-ID: <042462c3-e583-01f4-8849-9b1f1e1316cb@redhat.com>
Date: Mon, 8 Apr 2019 11:20:52 +0200
MIME-Version: 1.0
In-Reply-To: <7fde154a-4384-0233-fae5-7dc9e288ccec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 0/2] roms: Rename the EFIROM
 variable and let it be overridable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 04/08/19 11:02, Laszlo Ersek wrote:
> On 04/05/19 17:33, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi,
>>
>> Two trivial fixes to avoid the latest EDK2 testing series to
>> cause trouble to downstream distributions (in particular if
>> they have PIE enforced).
>=20
> I disgree with this.
>=20
> (1) In the first commit message, you say,
>=20
> "The iPXE project already uses the EFIROM for a tool named 'efirom'
> which is not the Intel EfiRom used by the EDK2 project".
>=20
> That's wrong. For building the combined (UEFI+BIOS) iPXE oprom binaries=
,
> the efirom tool that is invoked is *most definitely* the tool from edk2=
.
>=20
> What changes is that we now build efirom directly from the edk2
> submodule, rather than using a binary that could possibly be found on a
> GNU/Linux system from another package.
>=20
> This is entirely aligned with the addition of the edk2 submodule. The
> source for the efirom tool is now directly available, so in a
> *maintainer* build -- i.e., when you decide to rebuild iPXE binaries --
> we should certainly prefer to build everything from source.
>=20
> Again, this is a *maintainer* build (which also covers downstream
> package builds), not end-user build. If you decide to rebuild artifacts
> that are otherwise offered in binary form to end-users, you commit to
> building everything from source that goes into (or is necessary for)
> producing those artifacts.
>=20
> In the thread "edk2 fails to compile in v4.0.0-rc2", Olaf wrote,
>=20
> "It is in ovmf-tools.rpm, which comes from ovmf."
>=20
> That only proves my point.

Of course, ipxe.git itself has a macro called EFIROM:

src/Makefile:EFIROM             :=3D ./util/efirom

but that has *zero* relevance for QEMU commit f590a812c210 ("roms: build
the EfiRom utility from the roms/edk2 submodule", 2019-02-21).

Because, the "efirom" utility from inside ipxe.git is not used for
anything at all in the *QEMU recipe* for building the combined iPXE
option ROMs.

Look at the diff in f590a812c210:

-EFIROM ?=3D $(shell which EfiRom 2>/dev/null)
+EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom

If the way we build the combined iPXE oproms, from QEMU's ipxe.git
submodule, using "roms/Makefile", had *anything* to do with iPXE's own
"efirom", then the pre-patch state would have been wrong *already*.

Laszlo

> (2) For a while now, it has been possible for downstream build scripts
> to inject their preferred build flags into the BaseTools build recipes
> (makefiles) themselves. Please see
> <https://bugzilla.redhat.com/show_bug.cgi?id=3D1540244>. This is the
> relevant upstream commit list:
>=20
>   1  67983484a443 BaseTools/footer.makefile: expand BUILD_CFLAGS last
>                   for C files too
>   2  03252ae287c4 BaseTools/header.makefile: remove "-c" from
>                   BUILD_CFLAGS
>   3  b8a661702643 BaseTools/Source/C: split "-O2" to BUILD_OPTFLAGS
>   4  b0ca5dae78ff BaseTools/Source/C: take EXTRA_OPTFLAGS from the
>                   caller
>   5  81502cee20ac BaseTools/Source/C: take EXTRA_LDFLAGS from the calle=
r
>   6  aa4e0df1f0c7 BaseTools/VfrCompile: honor EXTRA_LDFLAGS
>=20
> Build BaseTools as follows:
>=20
>   make -C "$EDK_TOOLS_PATH" EXTRA_OPTFLAGS=3D"..."  EXTRA_LDFLAGS=3D"..=
."
>=20
> If you need to inject PIC/PIE-related flags into the BaseTools
> compilation/linking, please use the above facility.
>=20
> I think it's pretty usual that new upstream releases (of any open sourc=
e
> project) bring some changes for downstream packaging scripts.
>=20
> Thanks
> Laszlo
>=20

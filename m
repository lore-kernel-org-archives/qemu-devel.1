Received: from eggs.gnu.org ([209.51.188.92]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gpT5Y-00016M-BL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gpT5X-0000zK-Im
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:18:12 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:44026
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gpT5X-0000wr-9q
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 02:18:11 -0500
References: <20190129113921.21599-1-berrange@redhat.com>
	<20190129113921.21599-4-berrange@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <1760c7bb-12ca-31eb-ce69-ed5e68e6ca5d@weilnetz.de>
Date: Fri, 1 Feb 2019 08:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190129113921.21599-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] nsis: ensure we always pass -W64 flag
 to nsis installer script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>

On 29.01.19 12:39, Daniel P. Berrang=C3=A9 wrote:
> The code to set the -W64 flag is inside a conditional block that only
> executes when we are bundling DLLs with the installer. This results in
> QEMU being installed in the wrong location on 64-bit hosts when DLLs
> are not bundled.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 14a463564e..97a6727358 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -893,11 +893,14 @@ INSTALLER =3D qemu-setup-$(VERSION)$(EXESUF)
> =20
>  nsisflags =3D -V2 -NOCD
> =20
> +ifeq ($(ARCH),x86_64)
> +nsisflags +=3D -DW64
> +endif
> +
>  ifneq ($(wildcard $(SRC_PATH)/dll),)
>  ifeq ($(ARCH),x86_64)
>  # 64 bit executables
>  DLL_PATH =3D $(SRC_PATH)/dll/w64
> -nsisflags +=3D -DW64
>  else
>  # 32 bit executables
>  DLL_PATH =3D $(SRC_PATH)/dll/w32
>=20

Technically this is fine, therefore

Signed-off-by: Stefan Weil <sw@weilnetz.de>

But I wonder whether a Windows installer without bundled DLLs makes
sense. If it doesn't, we could as well fail if the DLL path is empty.

Regards
Stefan

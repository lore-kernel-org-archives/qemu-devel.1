Received: from eggs.gnu.org ([2001:4830:134:3::10]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cenqv-0002l4-8g
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cenqr-0005A8-VM
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:05:57 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:41003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cenqr-00059W-M4
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:05:53 -0500
Date: Fri, 17 Feb 2017 14:05:52 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <556543868.6974038.1487358352187.JavaMail.zimbra@redhat.com>
In-Reply-To: <1487357968-31000-1-git-send-email-peter.maydell@linaro.org>
References: <1487357968-31000-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Makefile: Put VERSION info into
 version.texi rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>



----- Original Message -----
> Unfortunately some older versions of makeinfo don't correctly
> handle the -D command line option and fail to set the variable.
> This then causes them to complain
>  docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION
>=20
> Work around this by doing as the autotools do, and writing
> the information into a version.texi file which we then
> include from the .texi files that need it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Changes v1->v2: add .gitignore entry
> ---
>  Makefile               | 17 ++++++++++-------
>  .gitignore             |  1 +
>  docs/qemu-ga-ref.texi  |  2 ++
>  docs/qemu-qmp-ref.texi |  2 ++
>  4 files changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 830fa5a..1c4c04f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -516,7 +516,7 @@ distclean: clean
>  =09rm -f qemu-doc.vr qemu-doc.txt
>  =09rm -f config.log
>  =09rm -f linux-headers/asm
> -=09rm -f qemu-ga-qapi.texi qemu-qapi.texi
> +=09rm -f qemu-ga-qapi.texi qemu-qapi.texi version.texi
>  =09rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
>  =09rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
>  =09rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
> @@ -663,21 +663,24 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
> =20
>  # documentation
>  MAKEINFO=3Dmakeinfo
> -MAKEINFOFLAGS=3D--no-split --number-sections -D 'VERSION $(VERSION)'
> -TEXIFLAG=3D$(if $(V),,--quiet) --command=3D'@set VERSION $(VERSION)'
> +MAKEINFOFLAGS=3D--no-split --number-sections
> +TEXIFLAG=3D$(if $(V),,--quiet)
> =20
> -%.html: %.texi
> +version.texi: $(SRC_PATH)/VERSION
> +=09$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
> +
> +%.html: %.texi version.texi
>  =09$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-hea=
ders \
>  =09--html $< -o $@,"GEN","$@")
> =20
> -%.info: %.texi
> +%.info: %.texi version.texi
>  =09$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@"=
)
> =20
> -%.txt: %.texi
> +%.txt: %.texi version.texi
>  =09$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-hea=
ders \
>  =09--plaintext $< -o $@,"GEN","$@")
> =20
> -%.pdf: %.texi
> +%.pdf: %.texi version.texi
>  =09$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I . $< -o
>  =09$@,"GEN","$@")
> =20
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtoo=
l
> diff --git a/.gitignore b/.gitignore
> index c563dc1..2849d75 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -107,6 +107,7 @@ docs/qemu-ga-ref.info*
>  docs/qemu-qmp-ref.info*
>  /qemu-ga-qapi.texi
>  /qemu-qapi.texi
> +/version.texi
>  *.tps
>  .stgit-*
>  cscope.*
> diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
> index 87cc8d0..ddb76ce 100644
> --- a/docs/qemu-ga-ref.texi
> +++ b/docs/qemu-ga-ref.texi
> @@ -1,6 +1,8 @@
>  \input texinfo
>  @setfilename qemu-ga-ref.info
> =20
> +@include version.texi
> +
>  @exampleindent 0
>  @paragraphindent 0
> =20
> diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
> index 818e525..0a00569 100644
> --- a/docs/qemu-qmp-ref.texi
> +++ b/docs/qemu-qmp-ref.texi
> @@ -1,6 +1,8 @@
>  \input texinfo
>  @setfilename qemu-qmp-ref.info
> =20
> +@include version.texi
> +
>  @exampleindent 0
>  @paragraphindent 0
> =20
> --
> 2.7.4
>=20
>=20

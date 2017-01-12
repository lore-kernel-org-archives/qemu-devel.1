Received: from eggs.gnu.org ([2001:4830:134:3::10]:40609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRcJv-0006qv-T7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRcJu-0001q5-QO
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:09:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRcJu-0001pM-HU
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:09:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD0ECC049D5D
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:09:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-21-marcandre.lureau@redhat.com>
Date: Thu, 12 Jan 2017 11:09:19 +0100
In-Reply-To: <20170109143437.30554-21-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 9 Jan 2017
	15:34:36 +0100")
Message-ID: <87bmvcegj4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 20/21] build-sys: add txt documentation
 rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Build plain text documentation, and install it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  .gitignore |  1 +
>  Makefile   | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 6f175b391e..e16bddc070 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -40,6 +40,7 @@
>  /qmp-marshal.c
>  /qemu-doc.html
>  /qemu-doc.info
> +/qemu-doc.txt
>  /qemu-img
>  /qemu-nbd
>  /qemu-options.def
> diff --git a/Makefile b/Makefile
> index d18bac1c31..37d45ee21b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -81,7 +81,7 @@ Makefile: ;
>  configure: ;
>=20=20
>  .PHONY: all clean cscope distclean html info install install-doc \
> -	pdf recurse-all speed test dist msi FORCE
> +	pdf txt recurse-all speed test dist msi FORCE
>=20=20
>  $(call set-vpath, $(SRC_PATH))
>=20=20
> @@ -90,7 +90,7 @@ LIBS+=3D-lz $(LIBS_TOOLS)
>  HELPERS-$(CONFIG_LINUX) =3D qemu-bridge-helper$(EXESUF)
>=20=20
>  ifdef BUILD_DOCS
> -DOCS=3Dqemu-doc.html qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
> +DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
>  ifdef CONFIG_VIRTFS
>  DOCS+=3Dfsdev/virtfs-proxy-helper.1
>  endif
> @@ -431,6 +431,7 @@ endif
>  install-doc: $(DOCS)
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
> +	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
>  ifdef CONFIG_POSIX
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
> @@ -538,6 +539,10 @@ TEXIFLAG=3D$(if $(V),,--quiet)
>  %.info: %.texi
>  	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
>=20=20
> +%.txt: %.texi
> +	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
> +	--plaintext $< -o $@,"GEN   $@")

I believe this needs to be "GEN", "$@" now.  See commit 0bdb12c.

> +
>  %.pdf: %.texi
>  	$(call quiet-command,texi2pdf $(TEXIFLAG) -I . $<,"GEN","$@")
>=20=20
> @@ -563,6 +568,7 @@ qemu-ga.8: qemu-ga.texi
>  html: qemu-doc.html
>  info: qemu-doc.info
>  pdf: qemu-doc.pdf
> +txt: qemu-doc.txt
>=20=20
>  qemu-doc.html qemu-doc.info qemu-doc.pdf: \
>  	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
> @@ -661,7 +667,7 @@ help:
>  	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
>  	@echo  ''
>  	@echo  'Documentation targets:'
> -	@echo  '  html info pdf'
> +	@echo  '  html info pdf txt'
>  	@echo  '                  - Build documentation in specified format'
>  	@echo  ''
>  ifdef CONFIG_WIN32

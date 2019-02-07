Received: from eggs.gnu.org ([209.51.188.92]:55900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grkAF-0007NN-0J
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grkA9-0004eh-4n
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:56:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grkA5-0004ax-G4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:56:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so12006209qtj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 05:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20181126105125.30973-1-marcandre.lureau@redhat.com>
In-Reply-To: <20181126105125.30973-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 14:55:57 +0100
Message-ID: <CAMxuvawePkNOOQ3qrMK39KfXZnrdH1QikFsHoL3W27xWgpFW2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: fix the configuration path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Nov 26, 2018 at 11:51 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Use a CONFDIR variable to show the configured sysconf path in the
> generated documentations (html, man pages etc).
>
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1644985
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  Makefile     | 9 ++++++---
>  qemu-ga.texi | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9cc4dae1a6..a39c231d1c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -932,11 +932,14 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
>  MAKEINFO=3Dmakeinfo
>  MAKEINFOINCLUDES=3D -I docs -I $(<D) -I $(@D)
>  MAKEINFOFLAGS=3D--no-split --number-sections $(MAKEINFOINCLUDES)
> -TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) "-DVERSION=3D$(VERSION)"
> +TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) -DVERSION=3D"$(VERSION)" -DCONFDIR=
=3D"$(qemu_confdir)"
>  TEXI2PDFFLAGS=3D$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
>
> -docs/version.texi: $(SRC_PATH)/VERSION
> -       $(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$=
@")
> +docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
> +       $(call quiet-command,(\
> +               echo "@set VERSION $(VERSION)" && \
> +               echo "@set CONFDIR $(qemu_confdir)" \
> +       )> $@,"GEN","$@")
>
>  %.html: %.texi docs/version.texi
>         $(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no=
-headers \
> diff --git a/qemu-ga.texi b/qemu-ga.texi
> index 4c7a8fd163..f00ad830f2 100644
> --- a/qemu-ga.texi
> +++ b/qemu-ga.texi
> @@ -30,7 +30,7 @@ set user's password
>  @end itemize
>
>  qemu-ga will read a system configuration file on startup (located at
> -@file{/etc/qemu/qemu-ga.conf} by default), then parse remaining
> +@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
>  configuration options on the command line. For the same key, the last
>  option wins, but the lists accumulate (see below for configuration
>  file format).
> @@ -58,7 +58,7 @@ file format).
>    Enable fsfreeze hook. Accepts an optional argument that specifies
>    script to run on freeze/thaw. Script will be called with
>    'freeze'/'thaw' arguments accordingly (default is
> -  @samp{/etc/qemu/fsfreeze-hook}). If using -F with an argument, do
> +  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, d=
o
>    not follow -F with a space (for example:
>    @samp{-F/var/run/fsfreezehook.sh}).
>
> --
> 2.20.0.rc1
>

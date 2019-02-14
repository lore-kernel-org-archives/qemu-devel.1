Received: from eggs.gnu.org ([209.51.188.92]:54818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guEsq-00051f-40
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guErV-0002t9-06
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:07:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1guErS-0002s7-Vt
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:07:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id v16so5967275wrn.11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20190214093053.1400-1-armbru@redhat.com>
	<20190214093053.1400-9-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-9-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Feb 2019 12:07:10 +0100
Message-ID: <CAJ+F1C+osg0EmdKur4MJNngip5Rb2m3Gb=XHDwRB+TSKxe7SwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/18] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Feb 14, 2019 at 10:50 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> We can't add appropriate target-specific conditionals to misc.json,
> because that would make all of misc.json unusable in
> target-independent code.  To keep misc.json target-independent, we
> need to split off target-dependent target.json.
>
> This commit doesn't actually split off anything, it merely creates the
> empty module.  The next few patches will move stuff from misc.json
> there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  Makefile.objs         |  3 +--
>  qapi/Makefile.objs    | 28 +++++++++++++++++-----------
>  qapi/qapi-schema.json |  1 +
>  qapi/target.json      | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 13 deletions(-)
>  create mode 100644 qapi/target.json
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 4a266357a2..95150d7173 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -79,8 +79,7 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>  ######################################################################
>  # qapi
>
> -common-obj-y +=3D qapi/qapi-commands.o
> -common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
> +common-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi/qapi-commands-%.o)
>  common-obj-y +=3D qmp.o hmp.o
>  endif
>
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index da0000cbae..654321de94 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -5,21 +5,27 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
>  util-obj-y +=3D qmp-event.o
>  util-obj-y +=3D qapi-util.o
>
> -QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
> -QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
> -QAPI_MODULES +=3D ui
> +QAPI_COMMON_MODULES =3D block-core block char common crypto introspect
> +QAPI_COMMON_MODULES +=3D job migration misc net rdma rocker run-state
> +QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui
> +QAPI_TARGET_MODULES =3D target
> +QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
>
>  util-obj-y +=3D qapi-builtin-types.o
> -util-obj-y +=3D qapi-types.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-types-%.o)
> +util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-types-%.o)
>  util-obj-y +=3D qapi-builtin-visit.o
> -util-obj-y +=3D qapi-visit.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-visit-%.o)
> +util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-visit-%.o)
>  util-obj-y +=3D qapi-emit-events.o
> -util-obj-y +=3D qapi-events.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-events-%.o)
> +util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-events-%.o)
>
> -common-obj-y +=3D qapi-commands.o
> -common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-commands-%.o)
> +common-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-commands-%.o)
>
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-types-%.o)
> +obj-y +=3D qapi-types.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-visit-%.o)
> +obj-y +=3D qapi-visit.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
> +obj-y +=3D qapi-events.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
> +obj-y +=3D qapi-commands.o
>  obj-y +=3D qapi-introspect.o
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 1845aa78ff..db61bfd688 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -97,3 +97,4 @@
>  { 'include': 'trace.json' }
>  { 'include': 'introspect.json' }
>  { 'include': 'misc.json' }
> +{ 'include': 'target.json' }
> diff --git a/qapi/target.json b/qapi/target.json
> new file mode 100644
> index 0000000000..8054926293
> --- /dev/null
> +++ b/qapi/target.json
> @@ -0,0 +1,13 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# =3D Target-specific commands & events
> +##
> +
> +##
> +# @TARGET-TEMPORARY-DUMMY:
> +# Will go away in the next commit.  Needed in this one because empty
> +# modules don't generate anything, defeating this commit's purpose.
> +##
> +{ 'event': 'TARGET-TEMPORARY-DUMMY' }
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

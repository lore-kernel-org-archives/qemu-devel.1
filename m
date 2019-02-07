Received: from eggs.gnu.org ([209.51.188.92]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grhfG-000489-4F
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grhfE-0004lo-TZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:16:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grhfE-0004ld-LZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:16:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id r21so6176807qkl.11
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-8-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 12:16:05 +0100
Message-ID: <CAMxuvaxBZ2K6NZcvMU6gZ29MQKgBYCNK2nBCTtyLci7VzBBSEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/17] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrote:
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
>  Makefile.objs         | 20 +++++++++-----------
>  Makefile.target       | 10 ++++++++++
>  qapi/qapi-schema.json |  1 +
>  qapi/target.json      | 13 +++++++++++++
>  4 files changed, 33 insertions(+), 11 deletions(-)
>  create mode 100644 qapi/target.json
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 70ee51742f..5f0a7a8ca5 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,20 +1,19 @@
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
>  #######################################################################
>  # Common libraries for tools and emulators
>  stub-obj-y =3D stubs/ crypto/
>  util-obj-y =3D util/ qobject/ qapi/
>  util-obj-y +=3D qapi/qapi-builtin-types.o
> -util-obj-y +=3D qapi/qapi-types.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.o)
> +util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi/qapi-types-%.o)
>  util-obj-y +=3D qapi/qapi-builtin-visit.o
> -util-obj-y +=3D qapi/qapi-visit.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
> +util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi/qapi-visit-%.o)
>  util-obj-y +=3D qapi/qapi-emit-events.o
> -util-obj-y +=3D qapi/qapi-events.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
> +util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi/qapi-events-%.o)
>
>  chardev-obj-y =3D chardev/
>  slirp-obj-$(CONFIG_SLIRP) =3D slirp/
> @@ -92,8 +91,7 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>  ######################################################################
>  # qapi
>
> -common-obj-y +=3D qapi/qapi-commands.o
> -common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
> +common-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi/qapi-commands-%.o)
>  common-obj-y +=3D qmp.o hmp.o
>  endif
>
> diff --git a/Makefile.target b/Makefile.target
> index d8af835890..f908477040 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -164,6 +164,16 @@ endif
>
>  GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
>
> +# FIXME duplicates Makefile.obj's
> +QAPI_TARGET_MODULES =3D target
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-types-%.o)
> +obj-y +=3D qapi/qapi-types.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-visit-%.o)
> +obj-y +=3D qapi/qapi-visit.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-events-%.o)
> +obj-y +=3D qapi/qapi-events.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-commands-%.o)
> +obj-y +=3D qapi/qapi-commands.o
>  obj-y +=3D qapi/qapi-introspect.o
>
>  endif # CONFIG_SOFTMMU
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

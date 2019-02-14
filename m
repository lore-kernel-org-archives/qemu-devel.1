Received: from eggs.gnu.org ([209.51.188.92]:55088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guEtG-0005A3-Fp
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1guEkW-0005F1-9Y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:00:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1guEkV-0005DK-TW
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:00:12 -0500
Received: by mail-wm1-x344.google.com with SMTP id f16so5622593wmh.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20190214093053.1400-1-armbru@redhat.com>
	<20190214093053.1400-8-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Feb 2019 11:59:58 +0100
Message-ID: <CAJ+F1CL3QGOhqNRNUAhhtBE2q0UpTS2AkOWc9-P09uz99EhKAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/18] build: Deal with all of QAPI's .o
 in qapi/Makefile.objs
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

On Thu, Feb 14, 2019 at 10:44 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Adding QAPI's .o to util-obj-y, common-obj-y and obj-y is spread over
> three places: Makefile.objs takes care of target-independent generated
> code, Makefile.target of target-dependent generated code, and
> qapi/Makefile.objs of (target-independent) hand-written code.
>
> Do everything in qapi/Makefile.objs.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile           |  1 -
>  Makefile.objs      | 13 -------------
>  Makefile.target    |  3 +--
>  qapi/Makefile.objs | 19 +++++++++++++++++++
>  4 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 53d161b65f..a6de28677f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -89,7 +89,6 @@ include $(SRC_PATH)/rules.mak
>
>  GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
>
> -#see Makefile.objs for the definition of QAPI_MODULES
>  GENERATED_QAPI_FILES =3D qapi/qapi-builtin-types.h qapi/qapi-builtin-typ=
es.c
>  GENERATED_QAPI_FILES +=3D qapi/qapi-types.h qapi/qapi-types.c
>  GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.h)
> diff --git a/Makefile.objs b/Makefile.objs
> index bc78e26f55..4a266357a2 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,20 +1,7 @@
> -QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
> -QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
> -QAPI_MODULES +=3D ui
> -
>  #######################################################################
>  # Common libraries for tools and emulators
>  stub-obj-y =3D stubs/ crypto/
>  util-obj-y =3D util/ qobject/ qapi/
> -util-obj-y +=3D qapi/qapi-builtin-types.o
> -util-obj-y +=3D qapi/qapi-types.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.o)
> -util-obj-y +=3D qapi/qapi-builtin-visit.o
> -util-obj-y +=3D qapi/qapi-visit.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
> -util-obj-y +=3D qapi/qapi-emit-events.o
> -util-obj-y +=3D qapi/qapi-events.o
> -util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
>
>  chardev-obj-y =3D chardev/
>  slirp-obj-$(CONFIG_SLIRP) =3D slirp/
> diff --git a/Makefile.target b/Makefile.target
> index d8af835890..d6ce549388 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -148,6 +148,7 @@ ifdef CONFIG_SOFTMMU
>  obj-y +=3D arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o num=
a.o
>  obj-y +=3D qtest.o
>  obj-y +=3D hw/
> +obj-y +=3D qapi/
>  obj-y +=3D memory.o
>  obj-y +=3D memory_mapping.o
>  obj-y +=3D dump.o
> @@ -164,8 +165,6 @@ endif
>
>  GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
>
> -obj-y +=3D qapi/qapi-introspect.o
> -
>  endif # CONFIG_SOFTMMU
>
>  dummy :=3D $(call unnest-vars,,obj-y)
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 33906ff321..da0000cbae 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -4,3 +4,22 @@ util-obj-y +=3D string-input-visitor.o string-output-vis=
itor.o
>  util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
>  util-obj-y +=3D qmp-event.o
>  util-obj-y +=3D qapi-util.o
> +
> +QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
> +QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
> +QAPI_MODULES +=3D ui
> +
> +util-obj-y +=3D qapi-builtin-types.o
> +util-obj-y +=3D qapi-types.o
> +util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-types-%.o)
> +util-obj-y +=3D qapi-builtin-visit.o
> +util-obj-y +=3D qapi-visit.o
> +util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-visit-%.o)
> +util-obj-y +=3D qapi-emit-events.o
> +util-obj-y +=3D qapi-events.o
> +util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-events-%.o)
> +
> +common-obj-y +=3D qapi-commands.o
> +common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-commands-%.o)

You meant to remove it from /Makefile.objs I suppose?

Other than that,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +
> +obj-y +=3D qapi-introspect.o
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE049C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248B720663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POlXB1QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248B720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlmY-0002U9-Vc
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPllU-0001le-95
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:08:20 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:35756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPllQ-00046v-Ug
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:08:20 -0400
Received: by mail-lf1-x144.google.com with SMTP id w11so14776302lfn.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=06CMSnJLWLkFbbg1eSfiZrFquBfboiVgZN6uww2VFIE=;
 b=POlXB1QABJj3ZodIcDEsvsCVOkxsH9CK2jh/dwwwPpdVnZ0ecARv4rB7+abq0jf9if
 +AVKplqCNId/bVndoZ5ts70rqtAJexWeoZx+wReHLdDW4e6SCKP1zIsd2PBVwwBW8mdm
 X/8w+Ts0klOeWFE2a8eJJ5Ju590rcu8jlJdu7LwC8JLr9ZEv0Rq1ExJBsk02O3nLe9/8
 d5VFHvl8vEd5dWhaaNXf9/beU7Fc1CEavMK14tmfXORFPCaXzmoralIcQkSFZGpwZjID
 jq4prHJXEUnE77XFY67HYJwhHBfdW30r0t/WjU8JbGF4bW5GIUT7pJCbhtiWbE6fPnu6
 xd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=06CMSnJLWLkFbbg1eSfiZrFquBfboiVgZN6uww2VFIE=;
 b=PZbGRKyXtWd9dnfjIA5SqP3QPGVW2Z2uIWFVWg1Pz/5AxQ/oxIIbEiKjyWIPg5YBym
 6P7zlSOe4K3qWLPXJcZ/SI9FwYXunfOuNZOOq+uYxGQ0Y5pkPPF+Qq7pU+PJcGBqKLBn
 57B7ZXEFlzRsHwCHBg78quNJioaQb15SXSWy5ekJ8CSRBbsQ8to7iiXmGvEF4p3/zBNJ
 ALOq5pMWItBp9hjs8lyrjQmRT1v4MEL81urBkgfzvj+PVBvfJf5XYxI//VvoAVVLCPih
 s7PV9JUz+ysj9ZlM33xJniOmQq0elm1xtDYJ0+vbj6jFuETS/QeA1wucpS4u1pL4U68Q
 qGyQ==
X-Gm-Message-State: AOAM531SmT2CB+VbCX7yEy9ikavOKZjSrzV31H5HwjfOK2tB+6Nh5kCE
 R1b+hW/YH3ip4zW+z0uykSKD/2gaE55TJsGaWTs=
X-Google-Smtp-Source: ABdhPJyL5ZA4pUWbCQi0JfmvGiMFwcpP/As6XqeLyQZqdM/T3yPxEhnfImSYYEdUCdwSHKzFsPKtJGdfxDO/96DDfmM=
X-Received: by 2002:a19:383:: with SMTP id 125mr425583lfd.356.1601986094736;
 Tue, 06 Oct 2020 05:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-7-luoyonggang@gmail.com>
 <87sgar1tjo.fsf@linaro.org>
In-Reply-To: <87sgar1tjo.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2020 20:08:04 +0800
Message-ID: <CAE2XoE_8vGkC5dZQ0quzuNGjoGRPQNEhJpXTsizXRzJr_2S4Nw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] plugin: Getting qemu-plugin works under win32.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001cbc1b05b0ff74b9"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001cbc1b05b0ff74b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2020 at 7:29 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > We removed the need of .symbols file, so is the
> > configure script, if we one expose a function to qemu-plugin
> > just need prefix the function with QEMU_PLUGIN_EXPORT
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  Makefile                     |   1 -
> >  configure                    |  71 -------------
> >  contrib/plugins/hotblocks.c  |   1 +
> >  contrib/plugins/hotpages.c   |   1 +
> >  contrib/plugins/howvec.c     |   1 +
> >  contrib/plugins/lockstep.c   |   1 +
> >  include/qemu/qemu-plugin.h   | 197 +++++++++++++++++++++++++++--------
> >  meson.build                  |   6 +-
> >  plugins/api.c                |  62 +++++------
> >  plugins/core.c               |  10 +-
> >  plugins/loader.c             |  50 ++++++++-
> >  plugins/meson.build          |  10 +-
> >  plugins/plugin.h             |   1 +
> >  plugins/qemu-plugins.symbols |  40 -------
> >  tests/plugin/bb.c            |   1 +
> >  tests/plugin/empty.c         |   1 +
> >  tests/plugin/insn.c          |   1 +
> >  tests/plugin/mem.c           |   1 +
> >  18 files changed, 251 insertions(+), 205 deletions(-)
> >  delete mode 100644 plugins/qemu-plugins.symbols
> >
> > diff --git a/Makefile b/Makefile
> > index 54fc1a9d10..9981dd5209 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -105,7 +105,6 @@ config-host.mak: $(SRC_PATH)/configure
$(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
> >
> >  # Force configure to re-run if the API symbols are updated
> >  ifeq ($(CONFIG_PLUGIN),y)
> > -config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
> >
> >  .PHONY: plugins
> >  plugins:
> > diff --git a/configure b/configure
> > index 1c21a73c3b..ea447919fc 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5435,61 +5435,6 @@ if compile_prog "" "" ; then
> >    atomic64=3Dyes
> >  fi
> >
> > -#########################################
> > -# See if --dynamic-list is supported by the linker
> > -ld_dynamic_list=3D"no"
> > -if test "$static" =3D "no" ; then
> > -    cat > $TMPTXT <<EOF
> > -{
> > -  foo;
> > -};
> > -EOF
> > -
> > -    cat > $TMPC <<EOF
> > -#include <stdio.h>
> > -void foo(void);
> > -
> > -void foo(void)
> > -{
> > -  printf("foo\n");
> > -}
> > -
> > -int main(void)
> > -{
> > -  foo();
> > -  return 0;
> > -}
> > -EOF
> > -
> > -    if compile_prog "" "-Wl,--dynamic-list=3D$TMPTXT" ; then
> > -        ld_dynamic_list=3D"yes"
> > -    fi
> > -fi
> > -
> > -#########################################
> > -# See if -exported_symbols_list is supported by the linker
> > -
> > -ld_exported_symbols_list=3D"no"
> > -if test "$static" =3D "no" ; then
> > -    cat > $TMPTXT <<EOF
> > -  _foo
> > -EOF
> > -
> > -    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
> > -        ld_exported_symbols_list=3D"yes"
> > -    fi
> > -fi
> > -
> > -if  test "$plugins" =3D "yes" &&
> > -    test "$ld_dynamic_list" =3D "no" &&
> > -    test "$ld_exported_symbols_list" =3D "no" ; then
> > -  error_exit \
> > -      "Plugin support requires dynamic linking and specifying a set of
symbols " \
> > -      "that are exported to plugins. Unfortunately your linker doesn't
" \
> > -      "support the flag (--dynamic-list or -exported_symbols_list)
used " \
> > -      "for this purpose. You can't build with --static."
> > -fi
> > -
> >  ########################################
> >  # See if __attribute__((alias)) is supported.
> >  # This false for Xcode 9, but has been remedied for Xcode 10.
> > @@ -7074,22 +7019,6 @@ fi
> >
> >  if test "$plugins" =3D "yes" ; then
> >      echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
> > -    # Copy the export object list to the build dir
> > -    if test "$ld_dynamic_list" =3D "yes" ; then
> > -     echo "CONFIG_HAS_LD_DYNAMIC_LIST=3Dyes" >> $config_host_mak
> > -     ld_symbols=3Dqemu-plugins-ld.symbols
> > -     cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
> > -    elif test "$ld_exported_symbols_list" =3D "yes" ; then
> > -     echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=3Dyes" >> $config_host_=
mak
> > -     ld64_symbols=3Dqemu-plugins-ld64.symbols
> > -     echo "# Automatically generated by configure - do not modify" >
$ld64_symbols
> > -     grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed
's/;//g' | \
> > -         sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
> > -    else
> > -     error_exit \
> > -         "If \$plugins=3Dyes, either \$ld_dynamic_list or " \
> > -         "\$ld_exported_symbols_list should have been set to 'yes'."
> > -    fi
> >  fi
> >
> >  if test -n "$gdb_bin" ; then
> > diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> > index 37435a3fc7..39e77d2980 100644
> > --- a/contrib/plugins/hotblocks.c
> > +++ b/contrib/plugins/hotblocks.c
> > @@ -13,6 +13,7 @@
> >  #include <stdio.h>
> >  #include <glib.h>
> >
> > +#define QEMU_PLUGIN_IMPLEMENTATION
> >  #include <qemu-plugin.h>
>
> As mentioned in earlier patch we should be able to just have the tweak
> in api.c and avoid touching all the plugins themselves.
> >
> > -#define QEMU_PLUGIN_VERSION 0
> > +#define QEMU_PLUGIN_VERSION 1
> > +
> > +typedef void *(*qemu_plugin_global_dlsym_t)(void* context, const char
*name);
> >
> >  typedef struct {
> >      /* string describing architecture */
> > @@ -73,8 +71,23 @@ typedef struct {
> >              int max_vcpus;
> >          } system;
> >      };
> > +    void *context;
> > +    qemu_plugin_global_dlsym_t dlsym;
> >  } qemu_info_t;
> >
> > +/**
> > + * qemu_plugin_initialize() - Initialize a plugin before install
> > + * @info: a block describing some details about the guest
> > + *
> > + * All plugins must export this symbol, and in most case using
qemu-plugin.h
> > + * provided implementation directly.
> > + * For plugin provide this function, the QEMU_PLUGIN_VERSION should >=
=3D
1
> > + *
> > + * Note: This function only used to loading qemu's exported functions,
nothing
> > + * else should doding in this function.
> > + */
> > +QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info_t *info)=
;
> > +
>
> So this is essentially working around the linker/dlopen stage and
> manually linking in all the API functions? Does this affect the
> efficiency of the API calls?
> > -void qemu_plugin_outs(const char *string);
> > +typedef void (*qemu_plugin_outs_t)(const char *string);
> > +
> > +#if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
> > +#if defined(QEMU_PLUGIN_IMPLEMENTATION)
> > +#define QEMU_PLUGIN_EXTERN
> > +#else
> > +#define QEMU_PLUGIN_EXTERN extern
> > +#endif
>
> As mentioned in the earlier patch I want to understand why the extern is
> required. Could we avoid it with a parameter to the compiler when
> building plugins?
Hi, I've publisehd with v5 of the patch and explain that,

If we only have a single .c file in a plugin, then define
QEMU_PLUGIN_EXTERN to empty is OK, but if we have multiple .c files
in a plugin, then we need distinguish the implementation and the
deceleration. only the main .c file should define the macro
QEMU_PLUGIN_IMPLEMENTATION
other sources are user and should use extern
>
> <snip>
> >
> >  static int plugin_load(struct qemu_plugin_desc *desc, const
qemu_info_t *info)
> >  {
> > +    qemu_plugin_initialize_func_t initialize =3D NULL;
> >      qemu_plugin_install_func_t install;
> >      struct qemu_plugin_ctx *ctx;
> >      gpointer sym;
> >      int rc;
> > +    int version =3D -1;
> >
> >      ctx =3D qemu_memalign(qemu_dcache_linesize, sizeof(*ctx));
> >      memset(ctx, 0, sizeof(*ctx));
> > @@ -184,7 +187,7 @@ static int plugin_load(struct qemu_plugin_desc
*desc, const qemu_info_t *info)
> >                       desc->path, g_module_error());
> >          goto err_symbol;
> >      } else {
> > -        int version =3D *(int *)sym;
> > +        version =3D *(int *)sym;
> >          if (version < QEMU_PLUGIN_MIN_VERSION) {
> >              error_report("TCG plugin %s requires API version %d, but "
> >                           "this QEMU supports only a minimum version of
%d",
> > @@ -198,6 +201,21 @@ static int plugin_load(struct qemu_plugin_desc
*desc, const qemu_info_t *info)
> >          }
> >      }
> >
> > +    if (version >=3D QEMU_PLUGIN_VERSION_1) {
> > +        /* This version should call to qemu_plugin_initialize first */
> > +        if (!g_module_symbol(ctx->handle, "qemu_plugin_initialize",
&sym)) {
> > +            error_report("%s: %s", __func__, g_module_error());
> > +            goto err_symbol;
> > +        }
> > +        initialize =3D (qemu_plugin_initialize_func_t) sym;
> > +        /* symbol was found; it could be NULL though */
> > +        if (initialize =3D=3D NULL) {
> > +            error_report("%s: %s: qemu_plugin_initialize is NULL",
> > +                        __func__, desc->path);
> > +            goto err_symbol;
> > +        }
> > +    }
> > +
> >      qemu_rec_mutex_lock(&plugin.lock);
> >
> >      /* find an unused random id with &ctx as the seed */
> > @@ -216,6 +234,16 @@ static int plugin_load(struct qemu_plugin_desc
*desc, const qemu_info_t *info)
> >          }
> >      }
> >      QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
> > +    if (initialize !=3D NULL) {
> > +        rc =3D initialize(info);
> > +        if (rc) {
> > +            error_report("%s: qemu_plugin_initialize returned error
code %d",
> > +                        __func__, rc);
> > +            /* qemu_plugin_initialize only loading function symbols */
> > +            goto err_symbol;
> > +        }
> > +    }
> > +
> >      ctx->installing =3D true;
> >      rc =3D install(ctx->id, info, desc->argc, desc->argv);
> >      ctx->installing =3D false;
> > @@ -254,6 +282,17 @@ static void plugin_desc_free(struct
qemu_plugin_desc *desc)
> >      g_free(desc);
> >  }
> >
> > +static void *qemu_plugin_global_dlsym(void* context, const char *name)
> > +{
> > +    GModule *global_handle =3D context;
> > +    gpointer sym =3D NULL;
> > +    if (!g_module_symbol(global_handle, name, &sym)) {
> > +        error_report("%s: %s", __func__, g_module_error());
> > +        return NULL;
> > +    }
> > +    return sym;
> > +}
> > +
> >  /**
> >   * qemu_plugin_load_list - load a list of plugins
> >   * @head: head of the list of descriptors of the plugins to be loaded
> > @@ -267,6 +306,7 @@ int qemu_plugin_load_list(QemuPluginList *head)
> >  {
> >      struct qemu_plugin_desc *desc, *next;
> >      g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
> > +    GModule *global_handle =3D NULL;
> >
> >      info->target_name =3D TARGET_NAME;
> >      info->version.min =3D QEMU_PLUGIN_MIN_VERSION;
> > @@ -276,6 +316,12 @@ int qemu_plugin_load_list(QemuPluginList *head)
> >      info->system_emulation =3D true;
> >      info->system.smp_vcpus =3D ms->smp.cpus;
> >      info->system.max_vcpus =3D ms->smp.max_cpus;
> > +    global_handle =3D g_module_open(NULL, G_MODULE_BIND_LOCAL);
> > +    if (global_handle =3D=3D NULL) {
> > +        goto err_dlopen;
> > +    }
> > +    info->dlsym =3D qemu_plugin_global_dlsym;
> > +    info->context =3D (void*)global_handle;
> >  #else
> >      info->system_emulation =3D false;
> >  #endif
> > @@ -289,6 +335,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
> >          }
> >          QTAILQ_REMOVE(head, desc, entry);
> >      }
> > +
> > +err_dlopen:
> >      return 0;
>
> This doesn't compile cleanly for both linux-user and softmmu:
>
>   Compiling C object libqemu-aarch64-linux-user.fa.p/tcg_tcg-common.c.o
>   ../../plugins/loader.c: In function =E2=80=98qemu_plugin_load_list=E2=
=80=99:
>   ../../plugins/loader.c:339:1: error: label =E2=80=98err_dlopen=E2=80=99=
 defined but not
used [-Werror=3Dunused-label]
>    err_dlopen:
>    ^~~~~~~~~~
>   ../../plugins/loader.c:309:14: error: unused variable =E2=80=98global_h=
andle=E2=80=99
[-Werror=3Dunused-variable]
>        GModule *global_handle =3D NULL;
>                 ^~~~~~~~~~~~~
>   At top level:
>   ../../plugins/loader.c:285:14: error: =E2=80=98qemu_plugin_global_dlsym=
=E2=80=99
defined but not used [-Werror=3Dunused-function]
>    static void *qemu_plugin_global_dlsym(void* context, const char *name)
>                 ^~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile.ninja:6703:
libqemu-aarch64-linux-user.fa.p/plugins_loader.c.o] Error 1
>   make: *** Waiting for unfinished jobs....
>
> --
> Alex Benn=C3=A9e



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001cbc1b05b0ff74b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 6, 2020 at 7:29 PM Alex Benn=C3=A9e &l=
t;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =
wrote:<br>&gt;<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyongga=
ng@gmail.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; We=
 removed the need of .symbols file, so is the<br>&gt; &gt; configure script=
, if we one expose a function to qemu-plugin<br>&gt; &gt; just need prefix =
the function with QEMU_PLUGIN_EXPORT<br>&gt; &gt;<br>&gt; &gt; Signed-off-b=
y: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gm=
ail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0Makefile =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 -<br>&gt=
; &gt; =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A071 -------------<br>&gt; &gt; =C2=A0contrib/plugin=
s/hotblocks.c =C2=A0| =C2=A0 1 +<br>&gt; &gt; =C2=A0contrib/plugins/hotpage=
s.c =C2=A0 | =C2=A0 1 +<br>&gt; &gt; =C2=A0contrib/plugins/howvec.c =C2=A0 =
=C2=A0 | =C2=A0 1 +<br>&gt; &gt; =C2=A0contrib/plugins/lockstep.c =C2=A0 | =
=C2=A0 1 +<br>&gt; &gt; =C2=A0include/qemu/qemu-plugin.h =C2=A0 | 197 +++++=
++++++++++++++++++++++--------<br>&gt; &gt; =C2=A0meson.build =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 6 +-<br>&gt; &gt;=
 =C2=A0plugins/api.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A062 +++++------<br>&gt; &gt; =C2=A0plugins/core.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A010 +-<br>&gt; &gt; =C2=A0plugins=
/loader.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A050 ++++++++-<br=
>&gt; &gt; =C2=A0plugins/meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A010 +-<br>&gt; &gt; =C2=A0plugins/plugin.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 1 +<br>&gt; &gt; =C2=A0plugins/qemu-plugins.symbols=
 | =C2=A040 -------<br>&gt; &gt; =C2=A0tests/plugin/bb.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1 +<br>&gt; &gt; =C2=A0tests/plugin/empty.=
c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 +<br>&gt; &gt; =C2=A0tests/plugin/=
insn.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 1 +<br>&gt; &gt; =C2=A0te=
sts/plugin/mem.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 +<br>&gt; &g=
t; =C2=A018 files changed, 251 insertions(+), 205 deletions(-)<br>&gt; &gt;=
 =C2=A0delete mode 100644 plugins/qemu-plugins.symbols<br>&gt; &gt;<br>&gt;=
 &gt; diff --git a/Makefile b/Makefile<br>&gt; &gt; index 54fc1a9d10..9981d=
d5209 100644<br>&gt; &gt; --- a/Makefile<br>&gt; &gt; +++ b/Makefile<br>&gt=
; &gt; @@ -105,7 +105,6 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PAT=
H)/pc-bios $(SRC_PATH)/VERSION<br>&gt; &gt; <br>&gt; &gt; =C2=A0# Force con=
figure to re-run if the API symbols are updated<br>&gt; &gt; =C2=A0ifeq ($(=
CONFIG_PLUGIN),y)<br>&gt; &gt; -config-host.mak: $(SRC_PATH)/plugins/qemu-p=
lugins.symbols<br>&gt; &gt; <br>&gt; &gt; =C2=A0.PHONY: plugins<br>&gt; &gt=
; =C2=A0plugins:<br>&gt; &gt; diff --git a/configure b/configure<br>&gt; &g=
t; index 1c21a73c3b..ea447919fc 100755<br>&gt; &gt; --- a/configure<br>&gt;=
 &gt; +++ b/configure<br>&gt; &gt; @@ -5435,61 +5435,6 @@ if compile_prog &=
quot;&quot; &quot;&quot; ; then<br>&gt; &gt; =C2=A0 =C2=A0atomic64=3Dyes<br=
>&gt; &gt; =C2=A0fi<br>&gt; &gt; <br>&gt; &gt; -###########################=
##############<br>&gt; &gt; -# See if --dynamic-list is supported by the li=
nker<br>&gt; &gt; -ld_dynamic_list=3D&quot;no&quot;<br>&gt; &gt; -if test &=
quot;$static&quot; =3D &quot;no&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0ca=
t &gt; $TMPTXT &lt;&lt;EOF<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0foo;<br>&gt=
; &gt; -};<br>&gt; &gt; -EOF<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0cat=
 &gt; $TMPC &lt;&lt;EOF<br>&gt; &gt; -#include &lt;stdio.h&gt;<br>&gt; &gt;=
 -void foo(void);<br>&gt; &gt; -<br>&gt; &gt; -void foo(void)<br>&gt; &gt; =
-{<br>&gt; &gt; - =C2=A0printf(&quot;foo\n&quot;);<br>&gt; &gt; -}<br>&gt; =
&gt; -<br>&gt; &gt; -int main(void)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0fo=
o();<br>&gt; &gt; - =C2=A0return 0;<br>&gt; &gt; -}<br>&gt; &gt; -EOF<br>&g=
t; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0if compile_prog &quot;&quot; &quot;-W=
l,--dynamic-list=3D$TMPTXT&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ld_dynamic_list=3D&quot;yes&quot;<br>&gt; &gt; - =C2=A0 =C2=A0fi<br>=
&gt; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; -################################=
#########<br>&gt; &gt; -# See if -exported_symbols_list is supported by the=
 linker<br>&gt; &gt; -<br>&gt; &gt; -ld_exported_symbols_list=3D&quot;no&qu=
ot;<br>&gt; &gt; -if test &quot;$static&quot; =3D &quot;no&quot; ; then<br>=
&gt; &gt; - =C2=A0 =C2=A0cat &gt; $TMPTXT &lt;&lt;EOF<br>&gt; &gt; - =C2=A0=
_foo<br>&gt; &gt; -EOF<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0if compil=
e_prog &quot;&quot; &quot;-Wl,-exported_symbols_list,$TMPTXT&quot; ; then<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0ld_exported_symbols_list=3D&quot;y=
es&quot;<br>&gt; &gt; - =C2=A0 =C2=A0fi<br>&gt; &gt; -fi<br>&gt; &gt; -<br>=
&gt; &gt; -if =C2=A0test &quot;$plugins&quot; =3D &quot;yes&quot; &amp;&amp=
;<br>&gt; &gt; - =C2=A0 =C2=A0test &quot;$ld_dynamic_list&quot; =3D &quot;n=
o&quot; &amp;&amp;<br>&gt; &gt; - =C2=A0 =C2=A0test &quot;$ld_exported_symb=
ols_list&quot; =3D &quot;no&quot; ; then<br>&gt; &gt; - =C2=A0error_exit \<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0&quot;Plugin support requires dynamic li=
nking and specifying a set of symbols &quot; \<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0&quot;that are exported to plugins. Unfortunately your linker doesn&=
#39;t &quot; \<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0&quot;support the flag (-=
-dynamic-list or -exported_symbols_list) used &quot; \<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0&quot;for this purpose. You can&#39;t build with --static.=
&quot;<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; =C2=A0#################=
#######################<br>&gt; &gt; =C2=A0# See if __attribute__((alias)) =
is supported.<br>&gt; &gt; =C2=A0# This false for Xcode 9, but has been rem=
edied for Xcode 10.<br>&gt; &gt; @@ -7074,22 +7019,6 @@ fi<br>&gt; &gt; <br=
>&gt; &gt; =C2=A0if test &quot;$plugins&quot; =3D &quot;yes&quot; ; then<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0echo &quot;CONFIG_PLUGIN=3Dy&quot; &gt;&gt; =
$config_host_mak<br>&gt; &gt; - =C2=A0 =C2=A0# Copy the export object list =
to the build dir<br>&gt; &gt; - =C2=A0 =C2=A0if test &quot;$ld_dynamic_list=
&quot; =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 echo &quot;C=
ONFIG_HAS_LD_DYNAMIC_LIST=3Dyes&quot; &gt;&gt; $config_host_mak<br>&gt; &gt=
; - =C2=A0 =C2=A0 ld_symbols=3Dqemu-plugins-ld.symbols<br>&gt; &gt; - =C2=
=A0 =C2=A0 cp &quot;$source_path/plugins/qemu-plugins.symbols&quot; $ld_sym=
bols<br>&gt; &gt; - =C2=A0 =C2=A0elif test &quot;$ld_exported_symbols_list&=
quot; =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 echo &quot;CO=
NFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=3Dyes&quot; &gt;&gt; $config_host_mak<br>=
&gt; &gt; - =C2=A0 =C2=A0 ld64_symbols=3Dqemu-plugins-ld64.symbols<br>&gt; =
&gt; - =C2=A0 =C2=A0 echo &quot;# Automatically generated by configure - do=
 not modify&quot; &gt; $ld64_symbols<br>&gt; &gt; - =C2=A0 =C2=A0 grep &#39=
;qemu_&#39; &quot;$source_path/plugins/qemu-plugins.symbols&quot; | sed &#3=
9;s/;//g&#39; | \<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -E &#39;s/=
^[[:space:]]*(.*)/_\1/&#39; &gt;&gt; $ld64_symbols<br>&gt; &gt; - =C2=A0 =
=C2=A0else<br>&gt; &gt; - =C2=A0 =C2=A0 error_exit \<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;If \$plugins=3Dyes, either \$ld_dynamic_list or =
&quot; \<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\$ld_exported_sym=
bols_list should have been set to &#39;yes&#39;.&quot;<br>&gt; &gt; - =C2=
=A0 =C2=A0fi<br>&gt; &gt; =C2=A0fi<br>&gt; &gt; <br>&gt; &gt; =C2=A0if test=
 -n &quot;$gdb_bin&quot; ; then<br>&gt; &gt; diff --git a/contrib/plugins/h=
otblocks.c b/contrib/plugins/hotblocks.c<br>&gt; &gt; index 37435a3fc7..39e=
77d2980 100644<br>&gt; &gt; --- a/contrib/plugins/hotblocks.c<br>&gt; &gt; =
+++ b/contrib/plugins/hotblocks.c<br>&gt; &gt; @@ -13,6 +13,7 @@<br>&gt; &g=
t; =C2=A0#include &lt;stdio.h&gt;<br>&gt; &gt; =C2=A0#include &lt;glib.h&gt=
;<br>&gt; &gt; <br>&gt; &gt; +#define QEMU_PLUGIN_IMPLEMENTATION<br>&gt; &g=
t; =C2=A0#include &lt;qemu-plugin.h&gt;<br>&gt;<br>&gt; As mentioned in ear=
lier patch we should be able to just have the tweak<br>&gt; in api.c and av=
oid touching all the plugins themselves.<br>&gt; &gt; <br>&gt; &gt; -#defin=
e QEMU_PLUGIN_VERSION 0<br>&gt; &gt; +#define QEMU_PLUGIN_VERSION 1<br>&gt;=
 &gt; +<br>&gt; &gt; +typedef void *(*qemu_plugin_global_dlsym_t)(void* con=
text, const char *name);<br>&gt; &gt; <br>&gt; &gt; =C2=A0typedef struct {<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0/* string describing architecture */<br>&g=
t; &gt; @@ -73,8 +71,23 @@ typedef struct {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int max_vcpus;<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} system;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0};<br>&gt; &=
gt; + =C2=A0 =C2=A0void *context;<br>&gt; &gt; + =C2=A0 =C2=A0qemu_plugin_g=
lobal_dlsym_t dlsym;<br>&gt; &gt; =C2=A0} qemu_info_t;<br>&gt; &gt; <br>&gt=
; &gt; +/**<br>&gt; &gt; + * qemu_plugin_initialize() - Initialize a plugin=
 before install<br>&gt; &gt; + * @info: a block describing some details abo=
ut the guest<br>&gt; &gt; + *<br>&gt; &gt; + * All plugins must export this=
 symbol, and in most case using qemu-plugin.h<br>&gt; &gt; + * provided imp=
lementation directly.<br>&gt; &gt; + * For plugin provide this function, th=
e QEMU_PLUGIN_VERSION should &gt;=3D 1<br>&gt; &gt; + *<br>&gt; &gt; + * No=
te: This function only used to loading qemu&#39;s exported functions, nothi=
ng<br>&gt; &gt; + * else should doding in this function.<br>&gt; &gt; + */<=
br>&gt; &gt; +QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info=
_t *info);<br>&gt; &gt; +<br>&gt;<br>&gt; So this is essentially working ar=
ound the linker/dlopen stage and<br>&gt; manually linking in all the API fu=
nctions? Does this affect the<br>&gt; efficiency of the API calls?<br>&gt; =
&gt; -void qemu_plugin_outs(const char *string);<br>&gt; &gt; +typedef void=
 (*qemu_plugin_outs_t)(const char *string);<br>&gt; &gt; +<br>&gt; &gt; +#i=
f !defined(QEMU_PLUGIN_API_IMPLEMENTATION)<br>&gt; &gt; +#if defined(QEMU_P=
LUGIN_IMPLEMENTATION)<br>&gt; &gt; +#define QEMU_PLUGIN_EXTERN<br>&gt; &gt;=
 +#else<br>&gt; &gt; +#define QEMU_PLUGIN_EXTERN extern<br>&gt; &gt; +#endi=
f<br>&gt;<br>&gt; As mentioned in the earlier patch I want to understand wh=
y the extern is<br>&gt; required. Could we avoid it with a parameter to the=
 compiler when<br>&gt; building plugins?<div>Hi, I&#39;ve publisehd with v5=
 of the patch and explain that,</div><div><br></div><div>If we only have a =
single .c file in a plugin, then define<br>QEMU_PLUGIN_EXTERN to empty is O=
K, but if we have multiple .c files<br>in a plugin, then we need distinguis=
h the implementation and the<br>deceleration. only the main .c file should =
define the macro QEMU_PLUGIN_IMPLEMENTATION<br>other sources are user and s=
hould use extern<br>&gt;<br>&gt; &lt;snip&gt;<br>&gt; &gt; <br>&gt; &gt; =
=C2=A0static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info=
_t *info)<br>&gt; &gt; =C2=A0{<br>&gt; &gt; + =C2=A0 =C2=A0qemu_plugin_init=
ialize_func_t initialize =3D NULL;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0qemu_pl=
ugin_install_func_t install;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0struct qemu_p=
lugin_ctx *ctx;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0gpointer sym;<br>&gt; &gt;=
 =C2=A0 =C2=A0 =C2=A0int rc;<br>&gt; &gt; + =C2=A0 =C2=A0int version =3D -1=
;<br>&gt; &gt; <br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0ctx =3D qemu_memalign(qemu=
_dcache_linesize, sizeof(*ctx));<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0memset(ct=
x, 0, sizeof(*ctx));<br>&gt; &gt; @@ -184,7 +187,7 @@ static int plugin_loa=
d(struct qemu_plugin_desc *desc, const qemu_info_t *info)<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
esc-&gt;path, g_module_error());<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0goto err_symbol;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0} else {<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0int version =3D *(int *)sym;<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0version =3D *(int *)sym;<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (version &lt; QEMU_PLUGIN_MIN_VERSION) {<br>&=
gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot=
;TCG plugin %s requires API version %d, but &quot;<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;this QEMU supports only a minimum version of %d&quot;,<br>&gt;=
 &gt; @@ -198,6 +201,21 @@ static int plugin_load(struct qemu_plugin_desc *=
desc, const qemu_info_t *info)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; <br>&gt; &gt; + =C2=A0=
 =C2=A0if (version &gt;=3D QEMU_PLUGIN_VERSION_1) {<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* This version should call to qemu_plugin_initialize f=
irst */<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_module_symbol(ctx-=
&gt;handle, &quot;qemu_plugin_initialize&quot;, &amp;sym)) {<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;%s: %s&quot;, =
__func__, g_module_error());<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto err_symbol;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&=
gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0initialize =3D (qemu_plugin_initializ=
e_func_t) sym;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* symbol was foun=
d; it could be NULL though */<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(initialize =3D=3D NULL) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0error_report(&quot;%s: %s: qemu_plugin_initialize is NULL&quot;,<=
br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__, desc-&gt;path);<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_symbol;<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; +<br>&gt; &gt=
; =C2=A0 =C2=A0 =C2=A0qemu_rec_mutex_lock(&amp;plugin.lock);<br>&gt; &gt; <=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0/* find an unused random id with &amp;ctx =
as the seed */<br>&gt; &gt; @@ -216,6 +234,16 @@ static int plugin_load(str=
uct qemu_plugin_desc *desc, const qemu_info_t *info)<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt=
; =C2=A0 =C2=A0 =C2=A0QTAILQ_INSERT_TAIL(&amp;plugin.ctxs, ctx, entry);<br>=
&gt; &gt; + =C2=A0 =C2=A0if (initialize !=3D NULL) {<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rc =3D initialize(info);<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (rc) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0error_report(&quot;%s: qemu_plugin_initialize returned error code %d&=
quot;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, rc);<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* qemu_plugin_initialize only loading function =
symbols */<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err=
_symbol;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =
=C2=A0}<br>&gt; &gt; +<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0ctx-&gt;installing =
=3D true;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0rc =3D install(ctx-&gt;id, info,=
 desc-&gt;argc, desc-&gt;argv);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0ctx-&gt;in=
stalling =3D false;<br>&gt; &gt; @@ -254,6 +282,17 @@ static void plugin_de=
sc_free(struct qemu_plugin_desc *desc)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0g_f=
ree(desc);<br>&gt; &gt; =C2=A0}<br>&gt; &gt; <br>&gt; &gt; +static void *qe=
mu_plugin_global_dlsym(void* context, const char *name)<br>&gt; &gt; +{<br>=
&gt; &gt; + =C2=A0 =C2=A0GModule *global_handle =3D context;<br>&gt; &gt; +=
 =C2=A0 =C2=A0gpointer sym =3D NULL;<br>&gt; &gt; + =C2=A0 =C2=A0if (!g_mod=
ule_symbol(global_handle, name, &amp;sym)) {<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0error_report(&quot;%s: %s&quot;, __func__, g_module_error());<=
br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>&gt; &gt; + =C2=
=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0return sym;<br>&gt; &gt; +}<br>&gt;=
 &gt; +<br>&gt; &gt; =C2=A0/**<br>&gt; &gt; =C2=A0 * qemu_plugin_load_list =
- load a list of plugins<br>&gt; &gt; =C2=A0 * @head: head of the list of d=
escriptors of the plugins to be loaded<br>&gt; &gt; @@ -267,6 +306,7 @@ int=
 qemu_plugin_load_list(QemuPluginList *head)<br>&gt; &gt; =C2=A0{<br>&gt; &=
gt; =C2=A0 =C2=A0 =C2=A0struct qemu_plugin_desc *desc, *next;<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1)=
;<br>&gt; &gt; + =C2=A0 =C2=A0GModule *global_handle =3D NULL;<br>&gt; &gt;=
 <br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0info-&gt;target_name =3D TARGET_NAME;<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0info-&gt;version.min =3D QEMU_PLUGIN_MIN_VER=
SION;<br>&gt; &gt; @@ -276,6 +316,12 @@ int qemu_plugin_load_list(QemuPlugi=
nList *head)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0info-&gt;system_emulation =3D=
 true;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0info-&gt;system.smp_vcpus =3D ms-&g=
t;smp.cpus;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0info-&gt;system.max_vcpus =3D =
ms-&gt;smp.max_cpus;<br>&gt; &gt; + =C2=A0 =C2=A0global_handle =3D g_module=
_open(NULL, G_MODULE_BIND_LOCAL);<br>&gt; &gt; + =C2=A0 =C2=A0if (global_ha=
ndle =3D=3D NULL) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_dlop=
en;<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0info-&gt;dlsy=
m =3D qemu_plugin_global_dlsym;<br>&gt; &gt; + =C2=A0 =C2=A0info-&gt;contex=
t =3D (void*)global_handle;<br>&gt; &gt; =C2=A0#else<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0info-&gt;system_emulation =3D false;<br>&gt; &gt; =C2=A0#endif=
<br>&gt; &gt; @@ -289,6 +335,8 @@ int qemu_plugin_load_list(QemuPluginList =
*head)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_REMOVE(head, desc, entry);<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; +<br>&gt; &gt; +err_dlopen:<br>&gt; &gt;=
 =C2=A0 =C2=A0 =C2=A0return 0;<br>&gt;<br>&gt; This doesn&#39;t compile cle=
anly for both linux-user and softmmu:<br>&gt;<br>&gt; =C2=A0 Compiling C ob=
ject libqemu-aarch64-linux-user.fa.p/tcg_tcg-common.c.o<br>&gt; =C2=A0 ../.=
./plugins/loader.c: In function =E2=80=98qemu_plugin_load_list=E2=80=99:<br=
>&gt; =C2=A0 ../../plugins/loader.c:339:1: error: label =E2=80=98err_dlopen=
=E2=80=99 defined but not used [-Werror=3Dunused-label]<br>&gt; =C2=A0 =C2=
=A0err_dlopen:<br>&gt; =C2=A0 =C2=A0^~~~~~~~~~<br>&gt; =C2=A0 ../../plugins=
/loader.c:309:14: error: unused variable =E2=80=98global_handle=E2=80=99 [-=
Werror=3Dunused-variable]<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0GModule *globa=
l_handle =3D NULL;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ^~~~~~~~~~~~~<br>&gt; =C2=A0 At top level:<br>&gt; =C2=A0 ../../plu=
gins/loader.c:285:14: error: =E2=80=98qemu_plugin_global_dlsym=E2=80=99 def=
ined but not used [-Werror=3Dunused-function]<br>&gt; =C2=A0 =C2=A0static v=
oid *qemu_plugin_global_dlsym(void* context, const char *name)<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~=
~~<br>&gt; =C2=A0 cc1: all warnings being treated as errors<br>&gt; =C2=A0 =
make: *** [Makefile.ninja:6703: libqemu-aarch64-linux-user.fa.p/plugins_loa=
der.c.o] Error 1<br>&gt; =C2=A0 make: *** Waiting for unfinished jobs....<b=
r>&gt;<br>&gt; --<br>&gt; Alex Benn=C3=A9e<br><br><br><br>--<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></di=
v>

--0000000000001cbc1b05b0ff74b9--


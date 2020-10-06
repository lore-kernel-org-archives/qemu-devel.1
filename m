Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB42AC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FEC2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8V5LeC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FEC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlBY-0006Vi-I8
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPlAH-0004zE-7M
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:29:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPlAE-0007X6-LT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:29:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so13038194wrx.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qSU5OJunGAQ3pAvDMC/AAKtW/3HY8+m6yVa8c5m4vAE=;
 b=i8V5LeC9VtmvUftTYNDDytkiHBTH52J/ci9+p44lL4nC8A/XGahn5Hok6a5ITYYSGn
 7YeO4lTYcLQjbWi3V2Fr2REobKXXfGzD/pFKVyw5hZH+wMCVWyxrgdDS6P39qC6CF3Cy
 sU9NXDlytcVh1RcmAchUJMvSLg2bDYc9RA/NCGyl7cuooEYW+8bubWmxGC/2kQp2GoTd
 YkrJ8nEhoxMNBP5ahZ7XNIhs8EHTKQArzHxqLdJItqo/5Vc9inlHYxxbP7J1kEA9y10a
 apKcBGfFmGe54oGsrdVrOPcXZSsJ1ZD93K4a2+r/oWgPlVc1l2/j6fm5wmSxu925ZN47
 Q57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qSU5OJunGAQ3pAvDMC/AAKtW/3HY8+m6yVa8c5m4vAE=;
 b=Z7P7h4izZLPI/rqP+WnpJ73/1E0+P4cxpbLPlJvzimDLhiZ802HRjUt3nNovNtTYfD
 FhUlsH/3AoI4rsRvIjEu+xH90YM9kKdxe+7pQ2dNdjRisHFc4Th88hbEQI6LWbuXUwDK
 +4BAelJc8Qtta8ooNWNmsPsoiFDaFmRyG0/jsrPJi9AY/JsQiiOYN6i6oVKvQXj51SHT
 bEeB9vFOE994NrjXXUoqzwRi/2ZetEonppZI6c+GF9jD4LjrpIshIpylB2hGxHzf33OK
 wltDFzcpidDTHZSMEN/BNRPgI1GxqShmLICWm2mlT3pc6yXp+ECiMFe9U9u5G5rR7Bx4
 OK9A==
X-Gm-Message-State: AOAM532EWbjD4VcvYFJKqMEwnQYKNObs52WZZm9t1HQpBe6rA6YZsVRE
 Une3Gm2okZ43tW48PdEPJW9G2g==
X-Google-Smtp-Source: ABdhPJzPMUMZzqCp8sJ0iCRylHwpi9Kz8/2S39FqCibEHCdT5OKz0+Xi9L1+9xzMzLJG5RovUcHjPA==
X-Received: by 2002:adf:df07:: with SMTP id y7mr4804846wrl.347.1601983788869; 
 Tue, 06 Oct 2020 04:29:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm4682021wrq.0.2020.10.06.04.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:29:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0CFC51FF7E;
 Tue,  6 Oct 2020 12:29:47 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-7-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 6/6] plugin: Getting qemu-plugin works under win32.
In-reply-to: <20201001163429.1348-7-luoyonggang@gmail.com>
Date: Tue, 06 Oct 2020 12:29:47 +0100
Message-ID: <87sgar1tjo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> We removed the need of .symbols file, so is the
> configure script, if we one expose a function to qemu-plugin
> just need prefix the function with QEMU_PLUGIN_EXPORT
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  Makefile                     |   1 -
>  configure                    |  71 -------------
>  contrib/plugins/hotblocks.c  |   1 +
>  contrib/plugins/hotpages.c   |   1 +
>  contrib/plugins/howvec.c     |   1 +
>  contrib/plugins/lockstep.c   |   1 +
>  include/qemu/qemu-plugin.h   | 197 +++++++++++++++++++++++++++--------
>  meson.build                  |   6 +-
>  plugins/api.c                |  62 +++++------
>  plugins/core.c               |  10 +-
>  plugins/loader.c             |  50 ++++++++-
>  plugins/meson.build          |  10 +-
>  plugins/plugin.h             |   1 +
>  plugins/qemu-plugins.symbols |  40 -------
>  tests/plugin/bb.c            |   1 +
>  tests/plugin/empty.c         |   1 +
>  tests/plugin/insn.c          |   1 +
>  tests/plugin/mem.c           |   1 +
>  18 files changed, 251 insertions(+), 205 deletions(-)
>  delete mode 100644 plugins/qemu-plugins.symbols
>
> diff --git a/Makefile b/Makefile
> index 54fc1a9d10..9981dd5209 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -105,7 +105,6 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc=
-bios $(SRC_PATH)/VERSION
>=20=20
>  # Force configure to re-run if the API symbols are updated
>  ifeq ($(CONFIG_PLUGIN),y)
> -config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
>=20=20
>  .PHONY: plugins
>  plugins:
> diff --git a/configure b/configure
> index 1c21a73c3b..ea447919fc 100755
> --- a/configure
> +++ b/configure
> @@ -5435,61 +5435,6 @@ if compile_prog "" "" ; then
>    atomic64=3Dyes
>  fi
>=20=20
> -#########################################
> -# See if --dynamic-list is supported by the linker
> -ld_dynamic_list=3D"no"
> -if test "$static" =3D "no" ; then
> -    cat > $TMPTXT <<EOF
> -{
> -  foo;
> -};
> -EOF
> -
> -    cat > $TMPC <<EOF
> -#include <stdio.h>
> -void foo(void);
> -
> -void foo(void)
> -{
> -  printf("foo\n");
> -}
> -
> -int main(void)
> -{
> -  foo();
> -  return 0;
> -}
> -EOF
> -
> -    if compile_prog "" "-Wl,--dynamic-list=3D$TMPTXT" ; then
> -        ld_dynamic_list=3D"yes"
> -    fi
> -fi
> -
> -#########################################
> -# See if -exported_symbols_list is supported by the linker
> -
> -ld_exported_symbols_list=3D"no"
> -if test "$static" =3D "no" ; then
> -    cat > $TMPTXT <<EOF
> -  _foo
> -EOF
> -
> -    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
> -        ld_exported_symbols_list=3D"yes"
> -    fi
> -fi
> -
> -if  test "$plugins" =3D "yes" &&
> -    test "$ld_dynamic_list" =3D "no" &&
> -    test "$ld_exported_symbols_list" =3D "no" ; then
> -  error_exit \
> -      "Plugin support requires dynamic linking and specifying a set of s=
ymbols " \
> -      "that are exported to plugins. Unfortunately your linker doesn't "=
 \
> -      "support the flag (--dynamic-list or -exported_symbols_list) used =
" \
> -      "for this purpose. You can't build with --static."
> -fi
> -
>  ########################################
>  # See if __attribute__((alias)) is supported.
>  # This false for Xcode 9, but has been remedied for Xcode 10.
> @@ -7074,22 +7019,6 @@ fi
>=20=20
>  if test "$plugins" =3D "yes" ; then
>      echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
> -    # Copy the export object list to the build dir
> -    if test "$ld_dynamic_list" =3D "yes" ; then
> -	echo "CONFIG_HAS_LD_DYNAMIC_LIST=3Dyes" >> $config_host_mak
> -	ld_symbols=3Dqemu-plugins-ld.symbols
> -	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
> -    elif test "$ld_exported_symbols_list" =3D "yes" ; then
> -	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=3Dyes" >> $config_host_mak
> -	ld64_symbols=3Dqemu-plugins-ld64.symbols
> -	echo "# Automatically generated by configure - do not modify" > $ld64_s=
ymbols
> -	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g'=
 | \
> -	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
> -    else
> -	error_exit \
> -	    "If \$plugins=3Dyes, either \$ld_dynamic_list or " \
> -	    "\$ld_exported_symbols_list should have been set to 'yes'."
> -    fi
>  fi
>=20=20
>  if test -n "$gdb_bin" ; then
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 37435a3fc7..39e77d2980 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -13,6 +13,7 @@
>  #include <stdio.h>
>  #include <glib.h>
>=20=20
> +#define QEMU_PLUGIN_IMPLEMENTATION
>  #include <qemu-plugin.h>

As mentioned in earlier patch we should be able to just have the tweak
in api.c and avoid touching all the plugins themselves.
>=20=20
> -#define QEMU_PLUGIN_VERSION 0
> +#define QEMU_PLUGIN_VERSION 1
> +
> +typedef void *(*qemu_plugin_global_dlsym_t)(void* context, const char *n=
ame);
>=20=20
>  typedef struct {
>      /* string describing architecture */
> @@ -73,8 +71,23 @@ typedef struct {
>              int max_vcpus;
>          } system;
>      };
> +    void *context;
> +    qemu_plugin_global_dlsym_t dlsym;
>  } qemu_info_t;
>=20=20
> +/**
> + * qemu_plugin_initialize() - Initialize a plugin before install
> + * @info: a block describing some details about the guest
> + *
> + * All plugins must export this symbol, and in most case using qemu-plug=
in.h
> + * provided implementation directly.
> + * For plugin provide this function, the QEMU_PLUGIN_VERSION should >=3D=
 1
> + *
> + * Note: This function only used to loading qemu's exported functions, n=
othing
> + * else should doding in this function.
> + */
> +QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info_t *info);
> +

So this is essentially working around the linker/dlopen stage and
manually linking in all the API functions? Does this affect the
efficiency of the API calls?
> -void qemu_plugin_outs(const char *string);
> +typedef void (*qemu_plugin_outs_t)(const char *string);
> +
> +#if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
> +#if defined(QEMU_PLUGIN_IMPLEMENTATION)
> +#define QEMU_PLUGIN_EXTERN
> +#else
> +#define QEMU_PLUGIN_EXTERN extern
> +#endif

As mentioned in the earlier patch I want to understand why the extern is
required. Could we avoid it with a parameter to the compiler when
building plugins?

<snip>
>=20=20
>  static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t =
*info)
>  {
> +    qemu_plugin_initialize_func_t initialize =3D NULL;
>      qemu_plugin_install_func_t install;
>      struct qemu_plugin_ctx *ctx;
>      gpointer sym;
>      int rc;
> +    int version =3D -1;
>=20=20
>      ctx =3D qemu_memalign(qemu_dcache_linesize, sizeof(*ctx));
>      memset(ctx, 0, sizeof(*ctx));
> @@ -184,7 +187,7 @@ static int plugin_load(struct qemu_plugin_desc *desc,=
 const qemu_info_t *info)
>                       desc->path, g_module_error());
>          goto err_symbol;
>      } else {
> -        int version =3D *(int *)sym;
> +        version =3D *(int *)sym;
>          if (version < QEMU_PLUGIN_MIN_VERSION) {
>              error_report("TCG plugin %s requires API version %d, but "
>                           "this QEMU supports only a minimum version of %=
d",
> @@ -198,6 +201,21 @@ static int plugin_load(struct qemu_plugin_desc *desc=
, const qemu_info_t *info)
>          }
>      }
>=20=20
> +    if (version >=3D QEMU_PLUGIN_VERSION_1) {
> +        /* This version should call to qemu_plugin_initialize first */
> +        if (!g_module_symbol(ctx->handle, "qemu_plugin_initialize", &sym=
)) {
> +            error_report("%s: %s", __func__, g_module_error());
> +            goto err_symbol;
> +        }
> +        initialize =3D (qemu_plugin_initialize_func_t) sym;
> +        /* symbol was found; it could be NULL though */
> +        if (initialize =3D=3D NULL) {
> +            error_report("%s: %s: qemu_plugin_initialize is NULL",
> +                        __func__, desc->path);
> +            goto err_symbol;
> +        }
> +    }
> +
>      qemu_rec_mutex_lock(&plugin.lock);
>=20=20
>      /* find an unused random id with &ctx as the seed */
> @@ -216,6 +234,16 @@ static int plugin_load(struct qemu_plugin_desc *desc=
, const qemu_info_t *info)
>          }
>      }
>      QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
> +    if (initialize !=3D NULL) {
> +        rc =3D initialize(info);
> +        if (rc) {
> +            error_report("%s: qemu_plugin_initialize returned error code=
 %d",
> +                        __func__, rc);
> +            /* qemu_plugin_initialize only loading function symbols */
> +            goto err_symbol;
> +        }
> +    }
> +
>      ctx->installing =3D true;
>      rc =3D install(ctx->id, info, desc->argc, desc->argv);
>      ctx->installing =3D false;
> @@ -254,6 +282,17 @@ static void plugin_desc_free(struct qemu_plugin_desc=
 *desc)
>      g_free(desc);
>  }
>=20=20
> +static void *qemu_plugin_global_dlsym(void* context, const char *name)
> +{
> +    GModule *global_handle =3D context;
> +    gpointer sym =3D NULL;
> +    if (!g_module_symbol(global_handle, name, &sym)) {
> +        error_report("%s: %s", __func__, g_module_error());
> +        return NULL;
> +    }
> +    return sym;
> +}
> +
>  /**
>   * qemu_plugin_load_list - load a list of plugins
>   * @head: head of the list of descriptors of the plugins to be loaded
> @@ -267,6 +306,7 @@ int qemu_plugin_load_list(QemuPluginList *head)
>  {
>      struct qemu_plugin_desc *desc, *next;
>      g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
> +    GModule *global_handle =3D NULL;
>=20=20
>      info->target_name =3D TARGET_NAME;
>      info->version.min =3D QEMU_PLUGIN_MIN_VERSION;
> @@ -276,6 +316,12 @@ int qemu_plugin_load_list(QemuPluginList *head)
>      info->system_emulation =3D true;
>      info->system.smp_vcpus =3D ms->smp.cpus;
>      info->system.max_vcpus =3D ms->smp.max_cpus;
> +    global_handle =3D g_module_open(NULL, G_MODULE_BIND_LOCAL);
> +    if (global_handle =3D=3D NULL) {
> +        goto err_dlopen;
> +    }
> +    info->dlsym =3D qemu_plugin_global_dlsym;
> +    info->context =3D (void*)global_handle;
>  #else
>      info->system_emulation =3D false;
>  #endif
> @@ -289,6 +335,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
>          }
>          QTAILQ_REMOVE(head, desc, entry);
>      }
> +
> +err_dlopen:
>      return 0;

This doesn't compile cleanly for both linux-user and softmmu:

  Compiling C object libqemu-aarch64-linux-user.fa.p/tcg_tcg-common.c.o
  ../../plugins/loader.c: In function =E2=80=98qemu_plugin_load_list=E2=80=
=99:
  ../../plugins/loader.c:339:1: error: label =E2=80=98err_dlopen=E2=80=99 d=
efined but not used [-Werror=3Dunused-label]
   err_dlopen:
   ^~~~~~~~~~
  ../../plugins/loader.c:309:14: error: unused variable =E2=80=98global_han=
dle=E2=80=99 [-Werror=3Dunused-variable]
       GModule *global_handle =3D NULL;
                ^~~~~~~~~~~~~
  At top level:
  ../../plugins/loader.c:285:14: error: =E2=80=98qemu_plugin_global_dlsym=
=E2=80=99 defined but not used [-Werror=3Dunused-function]
   static void *qemu_plugin_global_dlsym(void* context, const char *name)
                ^~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile.ninja:6703: libqemu-aarch64-linux-user.fa.p/plugins_l=
oader.c.o] Error 1
  make: *** Waiting for unfinished jobs....

--=20
Alex Benn=C3=A9e


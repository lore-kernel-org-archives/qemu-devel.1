Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A819C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CCD2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB30Ao+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CCD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxJW-0002NX-7p
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxIO-0001Yl-1X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:25:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxIL-0005cJ-KK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598455499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+c7umsoqgSuxBJu524SupUvNdvO+iUlCyXYztttk/Y=;
 b=PB30Ao+mZMkOLecPB1vSdjT+DxvW0Zs4118SHwyVVGByTs552S8ueQgU+tWHI/GEtEns4D
 jKylxjkfgqlbKIKam/Yvqmu48trf6WV6EmVJ/sLS5VtlGyxZTg/Mez6J+Yhj9c/SPJl84e
 SNzgFB45AUzddfUg7sjmp+pkXaF+5/U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-keCi4m5lNXGN_dKfkhAFPw-1; Wed, 26 Aug 2020 11:24:55 -0400
X-MC-Unique: keCi4m5lNXGN_dKfkhAFPw-1
Received: by mail-ed1-f70.google.com with SMTP id u11so801367eds.23
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o+c7umsoqgSuxBJu524SupUvNdvO+iUlCyXYztttk/Y=;
 b=nDDwuEUA7bImHYM6aSmtT7TPhwJH58+W4fkoVmU/OnpagSBa30N+JjvqUkjZJrdyM7
 HWUgYW+uyJTr0J4Wztz5ic6ovflksCXq4JRQzOTw6xthcuEJJZqWHVpqkJ4lfCpB2pEA
 PHTXm1U61ui+gp6+C2rR88CEe9R5p49sLCo1hQsB7taoCR3J9s4XwejT2z4RplhGBo9K
 hvfwZJ2DwPfuhZxe6ZS2rSM7NjD5z6sKKoqNAwkFp0IxgWy44zH+nvWPoHWx6RYr+kv8
 WmLYCoZW9NjNzlfPDcGu9PVgf1KM8Z4L6oSvMg+8tjOoYpqwC3sUHMB2BJ7wMz8zqT0t
 y4OQ==
X-Gm-Message-State: AOAM533D44YP/LcVUiHUksivNKEr/oXxcfHyN2gHbpY0QAn3lG8wPtWq
 xQwGLEqUL9B0rPoq8PaXWZZ6EIA2teOilewd/fBhwhnogNMhoRZdxkybAAc64zoq9bZuBnnlsgg
 FIpY5IvgH3bs7IRsJMBgOGryrU80eY0E=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr15280292ejr.543.1598455494364; 
 Wed, 26 Aug 2020 08:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwySn6G+LMnxTfXzGxwv6Agr9sjUuYawDR0Z/h3aoJc67OMf/KtGF+NnIpJyInlCLr7iJQEpnDr0p/bvefxdac=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr15280269ejr.543.1598455494090; 
 Wed, 26 Aug 2020 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-4-luoyonggang@gmail.com>
In-Reply-To: <20200826151006.80-4-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:24:43 +0200
Message-ID: <CABgObfbL9rdB1T0gzYvT4uR9D8ghLmo7OYaVdk+Vdk_vSjjvoA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] configure: Fix include and linkage issue on msys2
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm a bit wary of this patch, the effects are quite wide-ranging. If
we move all the detection of dependencies to meson, it will take a
while but we should get a similar effect.

However, I'm testing and queuing patches 1 to 3.

Paolo

On Wed, Aug 26, 2020 at 5:13 PM <luoyonggang@gmail.com> wrote:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized by the compiler
> Cause $PWD are result posix style path such as /e/path/to/qemu that can not be recognized
> by mingw gcc, and `pwd -W` are result Windows style path such as E:/path/to/qemu that can
> be recognized by the mingw gcc. So we replace all $PWD with $build_path that can
> building qemu under msys2/mingw environment.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/configure b/configure
> index b1e11397a8..3b9e79923d 100755
> --- a/configure
> +++ b/configure
> @@ -13,8 +13,13 @@ export CCACHE_RECACHE=yes
>
>  # make source path absolute
>  source_path=$(cd "$(dirname -- "$0")"; pwd)
> +build_path=$PWD
> +if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then
> +source_path=$(cd "$(dirname -- "$0")"; pwd -W)
> +build_path=`pwd -W`
> +fi
>
> -if test "$PWD" = "$source_path"
> +if test "$build_path" = "$source_path"
>  then
>      echo "Using './build' as the directory for build output"
>
> @@ -346,7 +351,12 @@ ld_has() {
>      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>  }
>
> -if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> +check_valid_build_path="[[:space:]:]"
> +if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then
> +check_valid_build_path="[[:space:]]"
> +fi
> +
> +if printf %s\\n "$source_path" "$build_path" | grep -q "$check_valid_build_path";
>  then
>    error_exit "main directory cannot contain spaces nor colons"
>  fi
> @@ -942,7 +952,7 @@ Linux)
>    linux="yes"
>    linux_user="yes"
>    kvm="yes"
> -  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
> +  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
>    libudev="yes"
>  ;;
>  esac
> @@ -4283,7 +4293,7 @@ EOF
>                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
>            fi
>            fdt_cflags="-I${source_path}/dtc/libfdt"
> -          fdt_ldflags="-L$PWD/dtc/libfdt"
> +          fdt_ldflags="-L${build_path}/dtc/libfdt"
>            fdt_libs="$fdt_libs"
>        elif test "$fdt" = "yes" ; then
>            # Not a git build & no libfdt found, prompt for system install
> @@ -5268,7 +5278,7 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=libcapstone.a
>      fi
> -    capstone_libs="-L$PWD/capstone -lcapstone"
> +    capstone_libs="-L${build_path}/capstone -lcapstone"
>      capstone_cflags="-I${source_path}/capstone/include"
>      ;;
>
> @@ -6268,8 +6278,8 @@ case "$slirp" in
>        git_submodules="${git_submodules} slirp"
>      fi
>      mkdir -p slirp
> -    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
> -    slirp_libs="-L$PWD/slirp -lslirp"
> +    slirp_cflags="-I${source_path}/slirp/src -I${build_path}/slirp/src"
> +    slirp_libs="-L${build_path}/slirp -lslirp"
>      if test "$mingw32" = "yes" ; then
>        slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
>      fi
> @@ -8212,7 +8222,7 @@ fi
>  mv $cross config-meson.cross
>
>  rm -rf meson-private meson-info meson-logs
> -NINJA=$PWD/ninjatool $meson setup \
> +NINJA="${build_path}/ninjatool" $meson setup \
>          --prefix "${pre_prefix}$prefix" \
>          --libdir "${pre_prefix}$libdir" \
>          --libexecdir "${pre_prefix}$libexecdir" \
> @@ -8232,7 +8242,7 @@ NINJA=$PWD/ninjatool $meson setup \
>         -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
>         -Dgettext=$gettext -Dxkbcommon=$xkbcommon \
>          $cross_arg \
> -        "$PWD" "$source_path"
> +        "$build_path" "$source_path"
>
>  if test "$?" -ne 0 ; then
>      error_exit "meson setup failed"
> --
> 2.27.0.windows.1
>



Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E988BC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB8620791
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSOukpKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB8620791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2sS-0003LM-UB
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kC2oT-0000ek-V6
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kC2oR-0006jw-G6
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598715037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7ez+vd31owNB/bKRsxkb2Zns1WtBNfCz1pkRa7fmt0=;
 b=fSOukpKeqTpTI9Faxmci12OVzW6Rpm96T5iWRwD9eVbXEn4lCUwpz4wMHf5DkXmMiDZak6
 TahPBfwhnIfhU80HeOn1l7aa+JE4p8jFbd6DiicM5ecd1ReYHEPX3rXZj5C9JclMP4MywS
 YVExPpfRWvuQHafqWa/hTVyv+7Ac5S8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-QbpSXv-mPae-tvxgKDmZsQ-1; Sat, 29 Aug 2020 11:30:32 -0400
X-MC-Unique: QbpSXv-mPae-tvxgKDmZsQ-1
Received: by mail-il1-f197.google.com with SMTP id m10so1608133ild.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 08:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s7ez+vd31owNB/bKRsxkb2Zns1WtBNfCz1pkRa7fmt0=;
 b=Lzf0Ajnsq7+NsG2xhp9xT5uoyhFkblIwtsfe7G9DhFBBZqdYeIKhExBCbAoeJEIPKu
 7mmHelm+wwPsyXlRlr4Gla+jKecpvG8oitmF+9jSxMPEY3wpCQCUVz/uyb9TC/0NSKgW
 1gpTcRIqHzjJi7JnVCwQ1+TVu3ZbF7/2ngWBDzl8jgu6IAZbgNzzu9d4b3r0JAuVc1uB
 UZtvQ+UBEkHmDywn17PykgjLJFlZ8f8W6o/+erWy52d7pz1YoxOuaVJqw/watZjtTACy
 WRHXcDa3acb4DjudFsGHxndsInbCVpQLloYB2awCBiWfhI6UAo5mVr88H5h8SBGLqq09
 ECfw==
X-Gm-Message-State: AOAM532xcKNREX8kT1NfOXOzLfDUgHM1FwNp8DBNsX3EXuEDOA/qaxwy
 B/VYgP88r6pscKSaLchO7gMSMMyLvGfcAS9daUKihJWuleeac3plxgyuRP6QqX+dlUwk0UFhpwo
 ALbN98fnlvbTAYZNKeYJMsvhrUeQxRRU=
X-Received: by 2002:a5d:97cd:: with SMTP id k13mr2847574ios.164.1598715031838; 
 Sat, 29 Aug 2020 08:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfH12KZTGLU/8V/MPBGB16fhQCBIOZMONw9qEnusRayXkKukmBP1f0II04nKJuRHUQNnMu3j8V1qSEoDCmzTI=
X-Received: by 2002:a5d:97cd:: with SMTP id k13mr2847558ios.164.1598715031581; 
 Sat, 29 Aug 2020 08:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200828173841.33505-1-pbonzini@redhat.com>
In-Reply-To: <20200828173841.33505-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2020 19:30:20 +0400
Message-ID: <CAMxuvayUswRjvxV4ZLOES5SzmN==LeNAe3p2CtX9ETy-83_HBg@mail.gmail.com>
Subject: Re: [PATCH] meson: move zlib detection to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 11:30:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 9:38 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Meson includes the same logic that tries to look for -lz if
> pkg-config (and cmake) cannot find zlib.  The undocumented
> --disable-zlib-test option becomes a no-op.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Nice! (special treatment since 0.54),
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  Makefile    |  2 +-
>  configure   | 32 +-------------------------------
>  meson.build |  6 +-----
>  3 files changed, 3 insertions(+), 37 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 81794d5c34..1520a2eab5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -132,7 +132,7 @@ configure: ;
>
>  $(call set-vpath, $(SRC_PATH))
>
> -LIBS+=3D-lz $(LIBS_TOOLS)
> +LIBS+=3D$(LIBS_TOOLS)
>
>  SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=3D=
$(BUILD_DIR)
>
> diff --git a/configure b/configure
> index 6ecaff429b..e035eb2868 100755
> --- a/configure
> +++ b/configure
> @@ -501,7 +501,6 @@ opengl=3D""
>  opengl_dmabuf=3D"no"
>  cpuid_h=3D"no"
>  avx2_opt=3D""
> -zlib=3D"yes"
>  capstone=3D""
>  lzo=3D""
>  snappy=3D""
> @@ -1423,7 +1422,7 @@ for opt do
>    ;;
>    --enable-usb-redir) usb_redir=3D"yes"
>    ;;
> -  --disable-zlib-test) zlib=3D"no"
> +  --disable-zlib-test)
>    ;;
>    --disable-lzo) lzo=3D"no"
>    ;;
> @@ -3898,30 +3897,6 @@ if ! compile_prog "$glib_cflags -Werror" "$glib_li=
bs" ; then
>      fi
>  fi
>
> -#########################################
> -# zlib check
> -
> -if test "$zlib" !=3D "no" ; then
> -    if $pkg_config --exists zlib; then
> -        zlib_cflags=3D$($pkg_config --cflags zlib)
> -        zlib_libs=3D$($pkg_config --libs zlib)
> -        QEMU_CFLAGS=3D"$zlib_cflags $QEMU_CFLAGS"
> -        LIBS=3D"$zlib_libs $LIBS"
> -    else
> -        cat > $TMPC << EOF
> -#include <zlib.h>
> -int main(void) { zlibVersion(); return 0; }
> -EOF
> -        if compile_prog "" "-lz" ; then
> -            zlib_libs=3D-lz
> -            LIBS=3D"$LIBS $zlib_libs"
> -        else
> -            error_exit "zlib check failed" \
> -                "Make sure to have the zlib libs and headers installed."
> -        fi
> -    fi
> -fi
> -
>  ##########################################
>  # SHA command probe for modules
>  if test "$modules" =3D yes; then
> @@ -7129,11 +7104,6 @@ fi
>  if test "$posix_memalign" =3D "yes" ; then
>    echo "CONFIG_POSIX_MEMALIGN=3Dy" >> $config_host_mak
>  fi
> -if test "$zlib" !=3D "no" ; then
> -    echo "CONFIG_ZLIB=3Dy" >> $config_host_mak
> -    echo "ZLIB_CFLAGS=3D$zlib_cflags" >> $config_host_mak
> -    echo "ZLIB_LIBS=3D$zlib_libs" >> $config_host_mak
> -fi
>  if test "$spice" =3D "yes" ; then
>    echo "CONFIG_SPICE=3Dy" >> $config_host_mak
>    echo "SPICE_CFLAGS=3D$spice_cflags" >> $config_host_mak
> diff --git a/meson.build b/meson.build
> index 74f8ea0c2e..35e6f8688d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -134,11 +134,7 @@ if 'CONFIG_AUTH_PAM' in config_host
>    pam =3D cc.find_library('pam')
>  endif
>  libaio =3D cc.find_library('aio', required: false)
> -zlib =3D not_found
> -if 'CONFIG_ZLIB' in config_host
> -  zlib =3D declare_dependency(compile_args: config_host['ZLIB_CFLAGS'].s=
plit(),
> -                            link_args: config_host['ZLIB_LIBS'].split())
> -endif
> +zlib =3D dependency('zlib', required: true)
>  linux_io_uring =3D not_found
>  if 'CONFIG_LINUX_IO_URING' in config_host
>    linux_io_uring =3D declare_dependency(compile_args: config_host['LINUX=
_IO_URING_CFLAGS'].split(),
> --
> 2.26.2
>



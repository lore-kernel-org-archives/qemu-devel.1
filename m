Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC39C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0419A2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjlvJi5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0419A2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBXw-000068-2A
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJBVQ-00051Z-J1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:12:33 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJBVM-0003if-KN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:12:32 -0400
Received: by mail-lj1-x242.google.com with SMTP id w3so4346703ljo.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=/ezZ8MIcj6M0TUNCuwp5ggtA/kZ800PJbLbSyRdztdk=;
 b=GjlvJi5pRLJ7a2TUssMR1Hf5nfeYRCGX8eWfdrG0ra4jH9gXluHl0YqHVZX1sHsrBM
 8pjjuapVUZbk9CgW7vPLCNFsCMC/KPaTuR2L111PrdUuyt/BmweIX0jEks+7Ee/K1cZ5
 cUfN/s6tFQFQWlyf6q4jFvin3f76E2tmdyJ8zJfG1HB6zCYyzY1rGEz76tT8CqRMNztw
 ULu/DskiyzZ8vMAhTQBvbyG3A1JotSYdrhiSTUOTPG0S6YEB+qp22ZGMqQzstKOlTm1R
 UlBw+2uhTU36zHFc+kWLf34VFmjMsxkaWPhDSsPc/I/q/FdFzuetxVxRoTIBhL9xuC3Y
 vL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=/ezZ8MIcj6M0TUNCuwp5ggtA/kZ800PJbLbSyRdztdk=;
 b=bwC8CHYc8aUmywMXWCbHEZspaLDFc7KKFG/bCU+kV6QSYXASoynCmvOqTeEHiyvCzf
 HPczg7eZjF90OJcv+3IBs8bQJzVNZD/9p+OQ78Nykfa+IFzbpnB1ljuEN+6cj8DTMoDR
 3P1bkMtquOqO8slmDpkA/ApY+FKlINbWxGTqGvPDrGttgR2X5nFZhDFcQrUabEbcFkrz
 RkTdNeLv92gQgJzFj4mRnQ9oKsUm3zAO6w7JiP5Ymie86XxwDYYQuu7DLJwav1DB7c5u
 KccgHz6ySjjCNJtpHa/i/IUbMne7EDGtTwr+IakDE1/Iawpdblc6kkwfzxoedtVyBydH
 UJUw==
X-Gm-Message-State: AOAM531L+afPvRewCYFTNZguUUZkbMyqLkxYsjlciLGxY0+W49cLs2RJ
 DHpYi3o82Yf5H4Sv+gcSS1G02Fcm1nTPViiimdk=
X-Google-Smtp-Source: ABdhPJwDRFOlkL/jqFBDljTYGhxZSl/76VWyAGPJnHOZSHco3YzX/VyJ/ZIBrlscab+baZEIRyyCoyuqsl4OGJLyDxM=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr12441339ljj.447.1600416746726; 
 Fri, 18 Sep 2020 01:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-2-richard.henderson@linaro.org>
In-Reply-To: <20200917235720.2685978-2-richard.henderson@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 16:12:15 +0800
Message-ID: <CAE2XoE_+BwNC7wFv00V+YfT+XLT4TS-_Ad+_cT1Hhi+DNhsnHg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ae698705af920f08"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ae698705af920f08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 7:59 AM Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> There are better ways to do this, e.g. meson cmake subproject,
> but that requires cmake 3.7 and some of our CI environments
> only provide cmake 3.5.
>
> Nor can we add a meson.build file to capstone/, because the git
> submodule would then always report "untracked files".  Fixing that
> would require creating our own branch on the qemu git mirror, at
> which point we could just as easily create a native meson subproject.
>
> Instead, build the library via the main meson.build.
>
> This improves the current state of affairs in that we will re-link
> the qemu executables against a changed libcapstone.a, which we wouldn't
> do before-hand.  In addition, the use of the configuration header file
> instead of command-line -DEFINES means that we will rebuild the
> capstone objects with changes to meson.build.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> v2: Further reduce probing in configure (paolo),
>     Drop state 'internal' and use 'git' even when it isn't git.
>     Move CONFIG_CAPSTONE to config_host_data.
> v3: Add Submodules separator; fix default in meson_options.txt.
> ---
>  configure         |  61 +++----------------------
>  Makefile          |  16 -------
>  meson.build       | 111 +++++++++++++++++++++++++++++++++++++++++++---
>  meson_options.txt |   4 ++
>  4 files changed, 115 insertions(+), 77 deletions(-)
>
> diff --git a/configure b/configure
> index 7564479008..76636c430d 100755
> --- a/configure
> +++ b/configure
> @@ -478,7 +478,7 @@ opengl=3D""
>  opengl_dmabuf=3D"no"
>  cpuid_h=3D"no"
>  avx2_opt=3D""
> -capstone=3D""
> +capstone=3D"auto"
>  lzo=3D""
>  snappy=3D""
>  bzip2=3D""
> @@ -1580,7 +1580,7 @@ for opt do
>    ;;
>    --enable-capstone) capstone=3D"yes"
>    ;;
> -  --enable-capstone=3Dgit) capstone=3D"git"
> +  --enable-capstone=3Dgit) capstone=3D"internal"
>    ;;
>    --enable-capstone=3Dsystem) capstone=3D"system"
>    ;;
> @@ -5128,51 +5128,11 @@ fi
>  # capstone
>
>  case "$capstone" in
> -  "" | yes)
> -    if $pkg_config capstone; then
> -      capstone=3Dsystem
> -    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
> -      capstone=3Dgit
> -    elif test -e "${source_path}/capstone/Makefile" ; then
> -      capstone=3Dinternal
> -    elif test -z "$capstone" ; then
> -      capstone=3Dno
> -    else
> -      feature_not_found "capstone" "Install capstone devel or git
submodule"
> -    fi
> -    ;;
> -
> -  system)
> -    if ! $pkg_config capstone; then
> -      feature_not_found "capstone" "Install capstone devel"
> -    fi
> -    ;;
> -esac
> -
> -case "$capstone" in
> -  git | internal)
> -    if test "$capstone" =3D git; then
> +  auto | yes | internal)
> +    # Simpler to always update submodule, even if not needed.
> +    if test -e "${source_path}/.git" && test $git_update =3D 'yes' ; the=
n
>        git_submodules=3D"${git_submodules} capstone"
>      fi
> -    mkdir -p capstone
> -    if test "$mingw32" =3D "yes"; then
> -      LIBCAPSTONE=3Dcapstone.lib
> -    else
> -      LIBCAPSTONE=3Dlibcapstone.a
> -    fi
> -    capstone_libs=3D"-Lcapstone -lcapstone"
> -    capstone_cflags=3D"-I${source_path}/capstone/include"
> -    ;;
> -
> -  system)
> -    capstone_libs=3D"$($pkg_config --libs capstone)"
> -    capstone_cflags=3D"$($pkg_config --cflags capstone)"
> -    ;;
> -
> -  no)
> -    ;;
> -  *)
> -    error_exit "Unknown state for capstone: $capstone"
>      ;;
>  esac
>
> @@ -7292,11 +7252,6 @@ fi
>  if test "$ivshmem" =3D "yes" ; then
>    echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
>  fi
> -if test "$capstone" !=3D "no" ; then
> -  echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
> -  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak
> -  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak
> -fi
>  if test "$debug_mutex" =3D "yes" ; then
>    echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
>  fi
> @@ -7819,9 +7774,6 @@ done # for target in $targets
>  if [ "$fdt" =3D "git" ]; then
>    subdirs=3D"$subdirs dtc"
>  fi
> -if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
> -  subdirs=3D"$subdirs capstone"
> -fi
>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
>  if test -n "$LIBCAPSTONE"; then
>    echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
These  LIBCAPSTONE should be removed, as they are empty and have no meaning
now
> @@ -8008,7 +7960,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
>          -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else e=
cho
false; fi) \
>         -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
>         -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
-Dvnc_png=3D$vnc_png \
> -       -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
> +       -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
> +       -Dcapstone=3D$capstone \
These lines should ident with 8 space instead of two tab.
There is four lines of them
 -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$vnc=
_png \
-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
-Dcapstone=3D$capstone \

>          $cross_arg \
>          "$PWD" "$source_path"
>
> diff --git a/Makefile b/Makefile
> index 7c60b9dcb8..f3da1760ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -156,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt
>  dtc/%: .git-submodule-status
>         @mkdir -p $@
>
> -# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
> -# Not overriding CFLAGS leads to mis-matches between compilation modes.
> -# Therefore we replicate some of the logic in the sub-makefile.
> -# Remove all the extra -Warning flags that QEMU uses that Capstone
doesn't;
> -# no need to annoy QEMU developers with such things.
> -CAP_CFLAGS =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLA=
GS)
> -CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC
> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
> -
> -.PHONY: capstone/all
> -capstone/all: .git-submodule-status
> -       $(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone
CAPSTONE_SHARED=3Dno BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)" AR=3D"=
$(AR)"
LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)" $(SUBDIR_MAKEFLA=
GS)
$(BUILD_DIR)/capstone/$(LIBCAPSTONE))
> -
>  .PHONY: slirp/all
>  slirp/all: .git-submodule-status
>         $(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp               \
> diff --git a/meson.build b/meson.build
> index f4d1ab1096..f23273693d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -10,6 +10,7 @@ else
>    keyval =3D import('unstable-keyval')
>  endif
>  ss =3D import('sourceset')
> +fs =3D import('fs')
>
>  sh =3D find_program('sh')
>  cc =3D meson.get_compiler('c')
> @@ -409,11 +410,6 @@ if 'CONFIG_USB_LIBUSB' in config_host
>    libusb =3D declare_dependency(compile_args:
config_host['LIBUSB_CFLAGS'].split(),
>                                link_args:
config_host['LIBUSB_LIBS'].split())
>  endif
> -capstone =3D not_found
> -if 'CONFIG_CAPSTONE' in config_host
> -  capstone =3D declare_dependency(compile_args:
config_host['CAPSTONE_CFLAGS'].split(),
> -                                link_args:
config_host['CAPSTONE_LIBS'].split())
> -endif
>  libpmem =3D not_found
>  if 'CONFIG_LIBPMEM' in config_host
>    libpmem =3D declare_dependency(compile_args:
config_host['LIBPMEM_CFLAGS'].split(),
> @@ -470,7 +466,6 @@ foreach k, v: config_host
>      config_host_data.set(k, v =3D=3D 'y' ? 1 : v)
>    endif
>  endforeach
> -genh +=3D configure_file(output: 'config-host.h', configuration:
config_host_data)
>
>  minikconf =3D find_program('scripts/minikconf.py')
>  config_all_devices =3D {}
> @@ -610,6 +605,108 @@ config_all +=3D {
>    'CONFIG_ALL': true,
>  }
>
> +# Submodules
> +
> +capstone =3D not_found
> +capstone_opt =3D get_option('capstone')
> +if capstone_opt =3D=3D 'no'
> +  capstone_opt =3D false
> +elif capstone_opt in ['yes', 'auto', 'system']
> +  have_internal =3D fs.exists('capstone/Makefile')
> +  capstone =3D dependency('capstone', static: enable_static,
> +                        required: capstone_opt =3D=3D 'system' or
> +                                  capstone_opt =3D=3D 'yes' and not
have_internal)
> +  if capstone.found()
> +    capstone_opt =3D 'system'
> +  elif have_internal
> +    capstone_opt =3D 'internal'
> +  else
> +    capstone_opt =3D false
> +  endif
> +endif
> +if capstone_opt =3D=3D 'internal'
> +  capstone_data =3D configuration_data()
> +  capstone_data.set('CAPSTONE_USE_SYS_DYN_MEM', '1')
> +
> +  capstone_files =3D files(
> +    'capstone/cs.c',
> +    'capstone/MCInst.c',
> +    'capstone/MCInstrDesc.c',
> +    'capstone/MCRegisterInfo.c',
> +    'capstone/SStream.c',
> +    'capstone/utils.c'
> +  )
> +
> +  if 'CONFIG_ARM_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_ARM', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/ARM/ARMDisassembler.c',
> +      'capstone/arch/ARM/ARMInstPrinter.c',
> +      'capstone/arch/ARM/ARMMapping.c',
> +      'capstone/arch/ARM/ARMModule.c'
> +    )
> +  endif
> +
> +  # FIXME: This config entry currently depends on a c++ compiler.
> +  # Which is needed for building libvixl, but not for capstone.
> +  if 'CONFIG_ARM_A64_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_ARM64', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/AArch64/AArch64BaseInfo.c',
> +      'capstone/arch/AArch64/AArch64Disassembler.c',
> +      'capstone/arch/AArch64/AArch64InstPrinter.c',
> +      'capstone/arch/AArch64/AArch64Mapping.c',
> +      'capstone/arch/AArch64/AArch64Module.c'
> +    )
> +  endif
> +
> +  if 'CONFIG_PPC_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_POWERPC', '1')
> +    capstone_files +=3D files(
> +      'capstone/arch/PowerPC/PPCDisassembler.c',
> +      'capstone/arch/PowerPC/PPCInstPrinter.c',
> +      'capstone/arch/PowerPC/PPCMapping.c',
> +      'capstone/arch/PowerPC/PPCModule.c'
> +    )
> +  endif
> +
> +  if 'CONFIG_I386_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_X86', 1)
> +    capstone_files +=3D files(
> +      'capstone/arch/X86/X86Disassembler.c',
> +      'capstone/arch/X86/X86DisassemblerDecoder.c',
> +      'capstone/arch/X86/X86ATTInstPrinter.c',
> +      'capstone/arch/X86/X86IntelInstPrinter.c',
> +      'capstone/arch/X86/X86Mapping.c',
> +      'capstone/arch/X86/X86Module.c'
> +    )
> +  endif
> +
> +  configure_file(output: 'capstone-defs.h', configuration: capstone_data=
)
> +
> +  capstone_cargs =3D [
> +    # FIXME: There does not seem to be a way to completely replace the
c_args
> +    # that come from add_project_arguments() -- we can only add to them.
> +    # So: disable all warnings with a big hammer.
> +    '-Wno-error', '-w',
> +
> +    # Include all configuration defines via a header file, which will
wind up
> +    # as a dependency on the object file, and thus changes here will
result
> +    # in a rebuild.
> +    '-include', 'capstone-defs.h'
> +  ]
> +
> +  libcapstone =3D static_library('capstone',
> +                               sources: capstone_files,
> +                               c_args: capstone_cargs,
> +                               include_directories: 'capstone/include')
> +  capstone =3D declare_dependency(link_with: libcapstone,
> +                                include_directories: 'capstone/include')
> +endif
> +config_host_data.set('CONFIG_CAPSTONE', capstone.found())
> +
> +genh +=3D configure_file(output: 'config-host.h', configuration:
config_host_data)
> +
>  # Generators
>
>  hxtool =3D find_program('scripts/hxtool')
> @@ -1512,7 +1609,7 @@ summary_info +=3D {'vvfat support':
config_host.has_key('CONFIG_VVFAT')}
>  summary_info +=3D {'qed support':       config_host.has_key('CONFIG_QED'=
)}
>  summary_info +=3D {'parallels support':
config_host.has_key('CONFIG_PARALLELS')}
>  summary_info +=3D {'sheepdog support':
 config_host.has_key('CONFIG_SHEEPDOG')}
> -summary_info +=3D {'capstone':
 config_host.has_key('CONFIG_CAPSTONE')}
> +summary_info +=3D {'capstone':          capstone_opt}
>  summary_info +=3D {'libpmem support':
config_host.has_key('CONFIG_LIBPMEM')}
>  summary_info +=3D {'libdaxctl support':
config_host.has_key('CONFIG_LIBDAXCTL')}
>  summary_info +=3D {'libudev':
config_host.has_key('CONFIG_LIBUDEV')}
> diff --git a/meson_options.txt b/meson_options.txt
> index 543cf70043..e650a937e7 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -22,3 +22,7 @@ option('vnc_sasl', type : 'feature', value : 'auto',
>         description: 'SASL authentication for VNC server')
>  option('xkbcommon', type : 'feature', value : 'auto',
>         description: 'xkbcommon support')
> +
> +option('capstone', type: 'combo', value: 'auto',
> +       choices: ['no', 'yes', 'auto', 'system', 'internal'],
> +       description: 'Whether and how to find the capstone library')
> --
> 2.25.1
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ae698705af920f08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Sep 18, 2020 at 7:59 AM Richard Henderson =
&lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linar=
o.org</a>&gt; wrote:<br>&gt;<br>&gt; There are better ways to do this, e.g.=
 meson cmake subproject,<br>&gt; but that requires cmake 3.7 and some of ou=
r CI environments<br>&gt; only provide cmake 3.5.<br>&gt;<br>&gt; Nor can w=
e add a meson.build file to capstone/, because the git<br>&gt; submodule wo=
uld then always report &quot;untracked files&quot;.=C2=A0 Fixing that<br>&g=
t; would require creating our own branch on the qemu git mirror, at<br>&gt;=
 which point we could just as easily create a native meson subproject.<br>&=
gt;<br>&gt; Instead, build the library via the main meson.build.<br>&gt;<br=
>&gt; This improves the current state of affairs in that we will re-link<br=
>&gt; the qemu executables against a changed libcapstone.a, which we wouldn=
&#39;t<br>&gt; do before-hand.=C2=A0 In addition, the use of the configurat=
ion header file<br>&gt; instead of command-line -DEFINES means that we will=
 rebuild the<br>&gt; capstone objects with changes to meson.build.<br>&gt;<=
br>&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.hend=
erson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>&gt; ---<br>&gt; =
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redha=
t.com</a>&gt;<br>&gt; v2: Further reduce probing in configure (paolo),<br>&=
gt; =C2=A0 =C2=A0 Drop state &#39;internal&#39; and use &#39;git&#39; even =
when it isn&#39;t git.<br>&gt; =C2=A0 =C2=A0 Move CONFIG_CAPSTONE to config=
_host_data.<br>&gt; v3: Add Submodules separator; fix default in meson_opti=
ons.txt.<br>&gt; ---<br>&gt; =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A061 +++----------------------<br>&gt; =C2=A0Makefile =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A016 -------<br>&gt; =C2=A0meson.build =C2=A0 =C2=A0=
 =C2=A0 | 111 +++++++++++++++++++++++++++++++++++++++++++---<br>&gt; =C2=A0=
meson_options.txt | =C2=A0 4 ++<br>&gt; =C2=A04 files changed, 115 insertio=
ns(+), 77 deletions(-)<br>&gt;<br>&gt; diff --git a/configure b/configure<b=
r>&gt; index 7564479008..76636c430d 100755<br>&gt; --- a/configure<br>&gt; =
+++ b/configure<br>&gt; @@ -478,7 +478,7 @@ opengl=3D&quot;&quot;<br>&gt; =
=C2=A0opengl_dmabuf=3D&quot;no&quot;<br>&gt; =C2=A0cpuid_h=3D&quot;no&quot;=
<br>&gt; =C2=A0avx2_opt=3D&quot;&quot;<br>&gt; -capstone=3D&quot;&quot;<br>=
&gt; +capstone=3D&quot;auto&quot;<br>&gt; =C2=A0lzo=3D&quot;&quot;<br>&gt; =
=C2=A0snappy=3D&quot;&quot;<br>&gt; =C2=A0bzip2=3D&quot;&quot;<br>&gt; @@ -=
1580,7 +1580,7 @@ for opt do<br>&gt; =C2=A0 =C2=A0;;<br>&gt; =C2=A0 =C2=A0-=
-enable-capstone) capstone=3D&quot;yes&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt=
; - =C2=A0--enable-capstone=3Dgit) capstone=3D&quot;git&quot;<br>&gt; + =C2=
=A0--enable-capstone=3Dgit) capstone=3D&quot;internal&quot;<br>&gt; =C2=A0 =
=C2=A0;;<br>&gt; =C2=A0 =C2=A0--enable-capstone=3Dsystem) capstone=3D&quot;=
system&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt; @@ -5128,51 +5128,11 @@ fi<br>=
&gt; =C2=A0# capstone<br>&gt;<br>&gt; =C2=A0case &quot;$capstone&quot; in<b=
r>&gt; - =C2=A0&quot;&quot; | yes)<br>&gt; - =C2=A0 =C2=A0if $pkg_config ca=
pstone; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dsystem<br>&gt; - =C2=
=A0 =C2=A0elif test -e &quot;${source_path}/.git&quot; &amp;&amp; test $git=
_update =3D &#39;yes&#39; ; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dg=
it<br>&gt; - =C2=A0 =C2=A0elif test -e &quot;${source_path}/capstone/Makefi=
le&quot; ; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dinternal<br>&gt; -=
 =C2=A0 =C2=A0elif test -z &quot;$capstone&quot; ; then<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0capstone=3Dno<br>&gt; - =C2=A0 =C2=A0else<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0feature_not_found &quot;capstone&quot; &quot;Install capstone dev=
el or git submodule&quot;<br>&gt; - =C2=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0=
;;<br>&gt; -<br>&gt; - =C2=A0system)<br>&gt; - =C2=A0 =C2=A0if ! $pkg_confi=
g capstone; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;caps=
tone&quot; &quot;Install capstone devel&quot;<br>&gt; - =C2=A0 =C2=A0fi<br>=
&gt; - =C2=A0 =C2=A0;;<br>&gt; -esac<br>&gt; -<br>&gt; -case &quot;$capston=
e&quot; in<br>&gt; - =C2=A0git | internal)<br>&gt; - =C2=A0 =C2=A0if test &=
quot;$capstone&quot; =3D git; then<br>&gt; + =C2=A0auto | yes | internal)<b=
r>&gt; + =C2=A0 =C2=A0# Simpler to always update submodule, even if not nee=
ded.<br>&gt; + =C2=A0 =C2=A0if test -e &quot;${source_path}/.git&quot; &amp=
;&amp; test $git_update =3D &#39;yes&#39; ; then<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0git_submodules=3D&quot;${git_submodules} capstone&quot;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0mkdir -p capstone<br>&gt; - =
=C2=A0 =C2=A0if test &quot;$mingw32&quot; =3D &quot;yes&quot;; then<br>&gt;=
 - =C2=A0 =C2=A0 =C2=A0LIBCAPSTONE=3Dcapstone.lib<br>&gt; - =C2=A0 =C2=A0el=
se<br>&gt; - =C2=A0 =C2=A0 =C2=A0LIBCAPSTONE=3Dlibcapstone.a<br>&gt; - =C2=
=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0capstone_libs=3D&quot;-Lcapstone -lcaps=
tone&quot;<br>&gt; - =C2=A0 =C2=A0capstone_cflags=3D&quot;-I${source_path}/=
capstone/include&quot;<br>&gt; - =C2=A0 =C2=A0;;<br>&gt; -<br>&gt; - =C2=A0=
system)<br>&gt; - =C2=A0 =C2=A0capstone_libs=3D&quot;$($pkg_config --libs c=
apstone)&quot;<br>&gt; - =C2=A0 =C2=A0capstone_cflags=3D&quot;$($pkg_config=
 --cflags capstone)&quot;<br>&gt; - =C2=A0 =C2=A0;;<br>&gt; -<br>&gt; - =C2=
=A0no)<br>&gt; - =C2=A0 =C2=A0;;<br>&gt; - =C2=A0*)<br>&gt; - =C2=A0 =C2=A0=
error_exit &quot;Unknown state for capstone: $capstone&quot;<br>&gt; =C2=A0=
 =C2=A0 =C2=A0;;<br>&gt; =C2=A0esac<br>&gt;<br>&gt; @@ -7292,11 +7252,6 @@ =
fi<br>&gt; =C2=A0if test &quot;$ivshmem&quot; =3D &quot;yes&quot; ; then<br=
>&gt; =C2=A0 =C2=A0echo &quot;CONFIG_IVSHMEM=3Dy&quot; &gt;&gt; $config_hos=
t_mak<br>&gt; =C2=A0fi<br>&gt; -if test &quot;$capstone&quot; !=3D &quot;no=
&quot; ; then<br>&gt; - =C2=A0echo &quot;CONFIG_CAPSTONE=3Dy&quot; &gt;&gt;=
 $config_host_mak<br>&gt; - =C2=A0echo &quot;CAPSTONE_CFLAGS=3D$capstone_cf=
lags&quot; &gt;&gt; $config_host_mak<br>&gt; - =C2=A0echo &quot;CAPSTONE_LI=
BS=3D$capstone_libs&quot; &gt;&gt; $config_host_mak<br>&gt; -fi<br>&gt; =C2=
=A0if test &quot;$debug_mutex&quot; =3D &quot;yes&quot; ; then<br>&gt; =C2=
=A0 =C2=A0echo &quot;CONFIG_DEBUG_MUTEX=3Dy&quot; &gt;&gt; $config_host_mak=
<br>&gt; =C2=A0fi<br>&gt; @@ -7819,9 +7774,6 @@ done # for target in $targe=
ts<br>&gt; =C2=A0if [ &quot;$fdt&quot; =3D &quot;git&quot; ]; then<br>&gt; =
=C2=A0 =C2=A0subdirs=3D&quot;$subdirs dtc&quot;<br>&gt; =C2=A0fi<br>&gt; -i=
f [ &quot;$capstone&quot; =3D &quot;git&quot; -o &quot;$capstone&quot; =3D =
&quot;internal&quot; ]; then<br>&gt; - =C2=A0subdirs=3D&quot;$subdirs capst=
one&quot;<br>&gt; -fi<br>&gt; =C2=A0echo &quot;SUBDIRS=3D$subdirs&quot; &gt=
;&gt; $config_host_mak<br>&gt; =C2=A0if test -n &quot;$LIBCAPSTONE&quot;; t=
hen<br>&gt; =C2=A0 =C2=A0echo &quot;LIBCAPSTONE=3D$LIBCAPSTONE&quot; &gt;&g=
t; $config_host_mak<div>These=C2=A0

LIBCAPSTONE should be removed, as they are empty and have no meaning now<br=
>&gt; @@ -8008,7 +7960,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Db_coverage=3D$(if test &quot;$=
gcov&quot; =3D yes; then echo true; else echo false; fi) \<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \<br>&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc=
_jpeg -Dvnc_png=3D$vnc_png \<br>&gt; - =C2=A0 =C2=A0 =C2=A0 -Dgettext=3D$ge=
ttext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\<br>&gt; + =C2=A0 =C2=A0 =C2=A0=
 -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 -Dcapstone=3D$capstone \</div><div>These lines should ide=
nt with 8 space instead of two tab.</div><div>There is four lines of them</=
div><div>=C2=A0-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \<br>	-Dvnc=3D$vnc -Dv=
nc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$vnc_png \<br>	-Dget=
text=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \<br>	-Dcapstone=3D$c=
apstone \</div><div><br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cross_arg \=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$PWD&quot; &quot;$source_p=
ath&quot;<br>&gt;<br>&gt; diff --git a/Makefile b/Makefile<br>&gt; index 7c=
60b9dcb8..f3da1760ad 100644<br>&gt; --- a/Makefile<br>&gt; +++ b/Makefile<b=
r>&gt; @@ -156,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt<br>&g=
t; =C2=A0dtc/%: .git-submodule-status<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @=
mkdir -p $@<br>&gt;<br>&gt; -# Overriding CFLAGS causes us to lose defines =
added in the sub-makefile.<br>&gt; -# Not overriding CFLAGS leads to mis-ma=
tches between compilation modes.<br>&gt; -# Therefore we replicate some of =
the logic in the sub-makefile.<br>&gt; -# Remove all the extra -Warning fla=
gs that QEMU uses that Capstone doesn&#39;t;<br>&gt; -# no need to annoy QE=
MU developers with such things.<br>&gt; -CAP_CFLAGS =3D $(patsubst -W%,,$(C=
FLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)<br>&gt; -CAP_CFLAGS +=3D -DCAPSTO=
NE_USE_SYS_DYN_MEM<br>&gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM<br>&gt; -CAP=
_CFLAGS +=3D -DCAPSTONE_HAS_ARM64<br>&gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_P=
OWERPC<br>&gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86<br>&gt; -<br>&gt; -.PHON=
Y: capstone/all<br>&gt; -capstone/all: .git-submodule-status<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 $(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPS=
TONE_SHARED=3Dno BUILDDIR=3D&quot;$(BUILD_DIR)/capstone&quot; CC=3D&quot;$(=
CC)&quot; AR=3D&quot;$(AR)&quot; LD=3D&quot;$(LD)&quot; RANLIB=3D&quot;$(RA=
NLIB)&quot; CFLAGS=3D&quot;$(CAP_CFLAGS)&quot; $(SUBDIR_MAKEFLAGS) $(BUILD_=
DIR)/capstone/$(LIBCAPSTONE))<br>&gt; -<br>&gt; =C2=A0.PHONY: slirp/all<br>=
&gt; =C2=A0slirp/all: .git-submodule-status<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 $(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; diff --git a/meson.build b/meson.=
build<br>&gt; index f4d1ab1096..f23273693d 100644<br>&gt; --- a/meson.build=
<br>&gt; +++ b/meson.build<br>&gt; @@ -10,6 +10,7 @@ else<br>&gt; =C2=A0 =
=C2=A0keyval =3D import(&#39;unstable-keyval&#39;)<br>&gt; =C2=A0endif<br>&=
gt; =C2=A0ss =3D import(&#39;sourceset&#39;)<br>&gt; +fs =3D import(&#39;fs=
&#39;)<br>&gt;<br>&gt; =C2=A0sh =3D find_program(&#39;sh&#39;)<br>&gt; =C2=
=A0cc =3D meson.get_compiler(&#39;c&#39;)<br>&gt; @@ -409,11 +410,6 @@ if &=
#39;CONFIG_USB_LIBUSB&#39; in config_host<br>&gt; =C2=A0 =C2=A0libusb =3D d=
eclare_dependency(compile_args: config_host[&#39;LIBUSB_CFLAGS&#39;].split(=
),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args: config_host[&#39=
;LIBUSB_LIBS&#39;].split())<br>&gt; =C2=A0endif<br>&gt; -capstone =3D not_f=
ound<br>&gt; -if &#39;CONFIG_CAPSTONE&#39; in config_host<br>&gt; - =C2=A0c=
apstone =3D declare_dependency(compile_args: config_host[&#39;CAPSTONE_CFLA=
GS&#39;].split(),<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args=
: config_host[&#39;CAPSTONE_LIBS&#39;].split())<br>&gt; -endif<br>&gt; =C2=
=A0libpmem =3D not_found<br>&gt; =C2=A0if &#39;CONFIG_LIBPMEM&#39; in confi=
g_host<br>&gt; =C2=A0 =C2=A0libpmem =3D declare_dependency(compile_args: co=
nfig_host[&#39;LIBPMEM_CFLAGS&#39;].split(),<br>&gt; @@ -470,7 +466,6 @@ fo=
reach k, v: config_host<br>&gt; =C2=A0 =C2=A0 =C2=A0config_host_data.set(k,=
 v =3D=3D &#39;y&#39; ? 1 : v)<br>&gt; =C2=A0 =C2=A0endif<br>&gt; =C2=A0end=
foreach<br>&gt; -genh +=3D configure_file(output: &#39;config-host.h&#39;, =
configuration: config_host_data)<br>&gt;<br>&gt; =C2=A0minikconf =3D find_p=
rogram(&#39;scripts/minikconf.py&#39;)<br>&gt; =C2=A0config_all_devices =3D=
 {}<br>&gt; @@ -610,6 +605,108 @@ config_all +=3D {<br>&gt; =C2=A0 =C2=A0&#=
39;CONFIG_ALL&#39;: true,<br>&gt; =C2=A0}<br>&gt;<br>&gt; +# Submodules<br>=
&gt; +<br>&gt; +capstone =3D not_found<br>&gt; +capstone_opt =3D get_option=
(&#39;capstone&#39;)<br>&gt; +if capstone_opt =3D=3D &#39;no&#39;<br>&gt; +=
 =C2=A0capstone_opt =3D false<br>&gt; +elif capstone_opt in [&#39;yes&#39;,=
 &#39;auto&#39;, &#39;system&#39;]<br>&gt; + =C2=A0have_internal =3D fs.exi=
sts(&#39;capstone/Makefile&#39;)<br>&gt; + =C2=A0capstone =3D dependency(&#=
39;capstone&#39;, static: enable_static,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: capsto=
ne_opt =3D=3D &#39;system&#39; or<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0capstone_opt =3D=3D &#39;yes&#39; and not have_internal)<br>&g=
t; + =C2=A0if capstone.found()<br>&gt; + =C2=A0 =C2=A0capstone_opt =3D &#39=
;system&#39;<br>&gt; + =C2=A0elif have_internal<br>&gt; + =C2=A0 =C2=A0caps=
tone_opt =3D &#39;internal&#39;<br>&gt; + =C2=A0else<br>&gt; + =C2=A0 =C2=
=A0capstone_opt =3D false<br>&gt; + =C2=A0endif<br>&gt; +endif<br>&gt; +if =
capstone_opt =3D=3D &#39;internal&#39;<br>&gt; + =C2=A0capstone_data =3D co=
nfiguration_data()<br>&gt; + =C2=A0capstone_data.set(&#39;CAPSTONE_USE_SYS_=
DYN_MEM&#39;, &#39;1&#39;)<br>&gt; +<br>&gt; + =C2=A0capstone_files =3D fil=
es(<br>&gt; + =C2=A0 =C2=A0&#39;capstone/cs.c&#39;,<br>&gt; + =C2=A0 =C2=A0=
&#39;capstone/MCInst.c&#39;,<br>&gt; + =C2=A0 =C2=A0&#39;capstone/MCInstrDe=
sc.c&#39;,<br>&gt; + =C2=A0 =C2=A0&#39;capstone/MCRegisterInfo.c&#39;,<br>&=
gt; + =C2=A0 =C2=A0&#39;capstone/SStream.c&#39;,<br>&gt; + =C2=A0 =C2=A0&#3=
9;capstone/utils.c&#39;<br>&gt; + =C2=A0)<br>&gt; +<br>&gt; + =C2=A0if &#39=
;CONFIG_ARM_DIS&#39; in config_all_disas<br>&gt; + =C2=A0 =C2=A0capstone_da=
ta.set(&#39;CAPSTONE_HAS_ARM&#39;, &#39;1&#39;)<br>&gt; + =C2=A0 =C2=A0caps=
tone_files +=3D files(<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM=
/ARMDisassembler.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/A=
RM/ARMInstPrinter.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/=
ARM/ARMMapping.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM=
/ARMModule.c&#39;<br>&gt; + =C2=A0 =C2=A0)<br>&gt; + =C2=A0endif<br>&gt; +<=
br>&gt; + =C2=A0# FIXME: This config entry currently depends on a c++ compi=
ler.<br>&gt; + =C2=A0# Which is needed for building libvixl, but not for ca=
pstone.<br>&gt; + =C2=A0if &#39;CONFIG_ARM_A64_DIS&#39; in config_all_disas=
<br>&gt; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_ARM64&#39;, &#3=
9;1&#39;)<br>&gt; + =C2=A0 =C2=A0capstone_files +=3D files(<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64BaseInfo.c&#39;,<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64Disassembler.c&#39=
;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64InstPrin=
ter.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch6=
4Mapping.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/A=
Arch64Module.c&#39;<br>&gt; + =C2=A0 =C2=A0)<br>&gt; + =C2=A0endif<br>&gt; =
+<br>&gt; + =C2=A0if &#39;CONFIG_PPC_DIS&#39; in config_all_disas<br>&gt; +=
 =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_POWERPC&#39;, &#39;1&#39;=
)<br>&gt; + =C2=A0 =C2=A0capstone_files +=3D files(<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0&#39;capstone/arch/PowerPC/PPCDisassembler.c&#39;,<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0&#39;capstone/arch/PowerPC/PPCInstPrinter.c&#39;,<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/PowerPC/PPCMapping.c&#39;,<br>&gt; +=
 =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/PowerPC/PPCModule.c&#39;<br>&gt; + =
=C2=A0 =C2=A0)<br>&gt; + =C2=A0endif<br>&gt; +<br>&gt; + =C2=A0if &#39;CONF=
IG_I386_DIS&#39; in config_all_disas<br>&gt; + =C2=A0 =C2=A0capstone_data.s=
et(&#39;CAPSTONE_HAS_X86&#39;, 1)<br>&gt; + =C2=A0 =C2=A0capstone_files +=
=3D files(<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86Disassem=
bler.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86Disass=
emblerDecoder.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/=
X86ATTInstPrinter.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/=
X86/X86IntelInstPrinter.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone=
/arch/X86/X86Mapping.c&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/ar=
ch/X86/X86Module.c&#39;<br>&gt; + =C2=A0 =C2=A0)<br>&gt; + =C2=A0endif<br>&=
gt; +<br>&gt; + =C2=A0configure_file(output: &#39;capstone-defs.h&#39;, con=
figuration: capstone_data)<br>&gt; +<br>&gt; + =C2=A0capstone_cargs =3D [<b=
r>&gt; + =C2=A0 =C2=A0# FIXME: There does not seem to be a way to completel=
y replace the c_args<br>&gt; + =C2=A0 =C2=A0# that come from add_project_ar=
guments() -- we can only add to them.<br>&gt; + =C2=A0 =C2=A0# So: disable =
all warnings with a big hammer.<br>&gt; + =C2=A0 =C2=A0&#39;-Wno-error&#39;=
, &#39;-w&#39;,<br>&gt; +<br>&gt; + =C2=A0 =C2=A0# Include all configuratio=
n defines via a header file, which will wind up<br>&gt; + =C2=A0 =C2=A0# as=
 a dependency on the object file, and thus changes here will result<br>&gt;=
 + =C2=A0 =C2=A0# in a rebuild.<br>&gt; + =C2=A0 =C2=A0&#39;-include&#39;, =
&#39;capstone-defs.h&#39;<br>&gt; + =C2=A0]<br>&gt; +<br>&gt; + =C2=A0libca=
pstone =3D static_library(&#39;capstone&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sources: capstone_files,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 c_args: capstone_cargs,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 incl=
ude_directories: &#39;capstone/include&#39;)<br>&gt; + =C2=A0capstone =3D d=
eclare_dependency(link_with: libcapstone,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0include_directories: &#39;capstone/include&#39;)<br>&gt; +=
endif<br>&gt; +config_host_data.set(&#39;CONFIG_CAPSTONE&#39;, capstone.fou=
nd())<br>&gt; +<br>&gt; +genh +=3D configure_file(output: &#39;config-host.=
h&#39;, configuration: config_host_data)<br>&gt; +<br>&gt; =C2=A0# Generato=
rs<br>&gt;<br>&gt; =C2=A0hxtool =3D find_program(&#39;scripts/hxtool&#39;)<=
br>&gt; @@ -1512,7 +1609,7 @@ summary_info +=3D {&#39;vvfat support&#39;: =
=C2=A0 =C2=A0 config_host.has_key(&#39;CONFIG_VVFAT&#39;)}<br>&gt; =C2=A0su=
mmary_info +=3D {&#39;qed support&#39;: =C2=A0 =C2=A0 =C2=A0 config_host.ha=
s_key(&#39;CONFIG_QED&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;parallel=
s support&#39;: config_host.has_key(&#39;CONFIG_PARALLELS&#39;)}<br>&gt; =
=C2=A0summary_info +=3D {&#39;sheepdog support&#39;: =C2=A0config_host.has_=
key(&#39;CONFIG_SHEEPDOG&#39;)}<br>&gt; -summary_info +=3D {&#39;capstone&#=
39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_CAPS=
TONE&#39;)}<br>&gt; +summary_info +=3D {&#39;capstone&#39;: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0capstone_opt}<br>&gt; =C2=A0summary_info +=3D {&#39;lib=
pmem support&#39;: =C2=A0 config_host.has_key(&#39;CONFIG_LIBPMEM&#39;)}<br=
>&gt; =C2=A0summary_info +=3D {&#39;libdaxctl support&#39;: config_host.has=
_key(&#39;CONFIG_LIBDAXCTL&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;lib=
udev&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_host.has_key(&#39;CONF=
IG_LIBUDEV&#39;)}<br>&gt; diff --git a/meson_options.txt b/meson_options.tx=
t<br>&gt; index 543cf70043..e650a937e7 100644<br>&gt; --- a/meson_options.t=
xt<br>&gt; +++ b/meson_options.txt<br>&gt; @@ -22,3 +22,7 @@ option(&#39;vn=
c_sasl&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;SASL authentication for VNC serv=
er&#39;)<br>&gt; =C2=A0option(&#39;xkbcommon&#39;, type : &#39;feature&#39;=
, value : &#39;auto&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: =
&#39;xkbcommon support&#39;)<br>&gt; +<br>&gt; +option(&#39;capstone&#39;, =
type: &#39;combo&#39;, value: &#39;auto&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 choices: [&#39;no&#39;, &#39;yes&#39;, &#39;auto&#39;, &#39;system&#39;=
, &#39;internal&#39;],<br>&gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;Whe=
ther and how to find the capstone library&#39;)<br>&gt; --<br>&gt; 2.25.1<b=
r>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=
=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =
=C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000ae698705af920f08--


Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36FDC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0920920874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND7ixJj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0920920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLId-0006v5-WF
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kKLHl-0006Rg-3h
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:51:13 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kKLHc-00046A-TO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:51:09 -0400
Received: by mail-lf1-x144.google.com with SMTP id z17so13820898lfi.12
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=PVfB0uXJSi5h7AYV5D3OuDxk+O9djX6rKpHtxjpd+bk=;
 b=ND7ixJj/7MfPYcTiI7RLlGChh0aSKeudiMrKjLTUhV1Tgod2DK6d2w6wKb89U+z0vm
 peQUQJMr1c8uncRNfPe+iIFT7Adakw/WlAK5y1xA7zZkXbT5UuIQ1BCftmdNcdX9xNfB
 4D+mudV9Yy60OuYyoNpeldhSpGA0vYHC+vkRSUBexmIKsqAaBs8GJerFQApO95J0B6gk
 67KCGdh+M9VyO6SHHFk7RFk6EeNs+mtmdVfjUicCskou6p20o4jEkZVYydWv6ZFhnqF0
 5Ey1B6vXO/20WyNH037UxKYdiL7RnUFa5HFPbXKdt2X4RI/celBJ+c0RBm/ZybCp8jp9
 M4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=PVfB0uXJSi5h7AYV5D3OuDxk+O9djX6rKpHtxjpd+bk=;
 b=sQ2jJcrp2pNeJUVVdJB5Q2SwFSox0BzeSK4mRd2wd0CvPSuEKp6n3fmShMwif5d8cP
 GPIpvfZnnNCbmfTLu8kfGHufiy1ZQ4uLFiIJDAgTNEFEUlBZHXswc2NiAEPWD76KSuEQ
 qK9MiKeg/NpEgTaNLJpSLRAVhNqhrmHrxVHszcVJCGL+Ocbklyxj8e356/ZHmqQGvb6r
 61FlDbDSQq8glZ2OXSG8BgVyqeVnTkO/6j6gC0NSTIzJ1wouYkad0K0dogVxzWlNEaBh
 9O9JXoTXDLNJgL/jeafwu1zF+kOxGFoGIaMDaOJdXDQVWZ55+3FBX/Kfw/tBrmKF26Os
 ypCg==
X-Gm-Message-State: AOAM530tOlN9LlyB8PlNnqLf69e+uACjV2NPfiP08HYKxmAVKXlAi22K
 9rMu17SleoCbu9sNilcavHTllDcMHhK43oG1ACI=
X-Google-Smtp-Source: ABdhPJwJW/w1iLhUyFh67OOrqXqjVo7B1cMAG5W4D9pOhIuBSV+fxCIkGoioCTVL/a4hsVeimFXc8kYcN0oo6MGBmgY=
X-Received: by 2002:a19:a407:: with SMTP id q7mr14560845lfc.377.1600692662137; 
 Mon, 21 Sep 2020 05:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-2-richard.henderson@linaro.org>
 <87wo0no0wz.fsf@linaro.org> <87tuvro0eu.fsf@linaro.org>
In-Reply-To: <87tuvro0eu.fsf@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 21 Sep 2020 20:50:50 +0800
Message-ID: <CAE2XoE8-_QSKAA2ZjEPcHzzUKHtUWJ3P7oJR3J8FdwchEUFc2A@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] capstone: Convert Makefile bits to meson bits
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008578bb05afd24d35"
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

--0000000000008578bb05afd24d35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 7:06 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Richard Henderson <richard.henderson@linaro.org> writes:
> >
> >> There are better ways to do this, e.g. meson cmake subproject,
> >> but that requires cmake 3.7 and some of our CI environments
> >> only provide cmake 3.5.
> >>
> >> Nor can we add a meson.build file to capstone/, because the git
> >> submodule would then always report "untracked files".  Fixing that
> >> would require creating our own branch on the qemu git mirror, at
> >> which point we could just as easily create a native meson subproject.
> >>
> >> Instead, build the library via the main meson.build.
> >>
> >> This improves the current state of affairs in that we will re-link
> >> the qemu executables against a changed libcapstone.a, which we wouldn'=
t
> >> do before-hand.  In addition, the use of the configuration header file
> >> instead of command-line -DEFINES means that we will rebuild the
> >> capstone objects with changes to meson.build.
> >
> > Something is breaking when switching to a branch with this on from
> > current master:
> >
> >   Linking target qemu-hppa
> >   /usr/bin/ld: libcommon.fa.p/disas_alpha.c.o: in function
`print_insn_alpha':
> >   /home/alex/lsrc/qemu.git/builds/all/../../disas/alpha.c:1818:
undefined reference to `bfd_getl32'
> >   collect2: error: ld returned 1 exit status
> >   make: *** [Makefile.ninja:5965: qemu-alpha] Error 1
> >   make: *** Waiting for unfinished jobs....
> >   /usr/bin/ld: libcommon.fa.p/disas_hppa.c.o: in function
`print_insn_hppa':
> >   /home/alex/lsrc/qemu.git/builds/all/../../disas/hppa.c:1969:
undefined reference to `bfd_getb32'
> >   collect2: error: ld returned 1 exit status
> >   make: *** [Makefile.ninja:6259: qemu-hppa] Error 1
> >
> > Aggressively wiping out the submodule and doing a fresh configure in a
> > empty build directory and I still see a failure:
> >
> >   ../../disas/capstone.c:25:1: error: expected =E2=80=98=3D=E2=80=99, =
=E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98cap_skipdata_s390x_cb=E2=80=
=99
> >    cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
> >    ^~~~~~~~~~~~~~~~~~~~~
> >   ../../disas/capstone.c:49:17: error: =E2=80=98cap_skipdata_s390x_cb=
=E2=80=99
undeclared here (not in a function); did you mean =E2=80=98cap_skipdata_s39=
0x=E2=80=99?
> >        .callback =3D cap_skipdata_s390x_cb
> >                    ^~~~~~~~~~~~~~~~~~~~~
> >                    cap_skipdata_s390x
> >   Makefile.ninja:1424: recipe for target
'libcommon.fa.p/disas_capstone.c.o' failed
> >   make: *** [libcommon.fa.p/disas_capstone.c.o] Error 1
> >   make: *** Waiting for unfinished jobs....
> >
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> v2: Further reduce probing in configure (paolo),
> >>     Drop state 'internal' and use 'git' even when it isn't git.
> >>     Move CONFIG_CAPSTONE to config_host_data.
> >> v3: Add Submodules separator; fix default in meson_options.txt.
> >> ---
> >>  configure         |  61 +++----------------------
> >>  Makefile          |  16 -------
> >>  meson.build       | 111 +++++++++++++++++++++++++++++++++++++++++++--=
-
> >>  meson_options.txt |   4 ++
> >>  4 files changed, 115 insertions(+), 77 deletions(-)
> >>
> >> diff --git a/configure b/configure
> >> index 7564479008..76636c430d 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -478,7 +478,7 @@ opengl=3D""
> >>  opengl_dmabuf=3D"no"
> >>  cpuid_h=3D"no"
> >>  avx2_opt=3D""
> >> -capstone=3D""
> >> +capstone=3D"auto"
> >>  lzo=3D""
> >>  snappy=3D""
> >>  bzip2=3D""
> >> @@ -1580,7 +1580,7 @@ for opt do
> >>    ;;
> >>    --enable-capstone) capstone=3D"yes"
> >>    ;;
> >> -  --enable-capstone=3Dgit) capstone=3D"git"
> >> +  --enable-capstone=3Dgit) capstone=3D"internal"
> >>    ;;
> >>    --enable-capstone=3Dsystem) capstone=3D"system"
> >>    ;;
> >> @@ -5128,51 +5128,11 @@ fi
> >>  # capstone
> >>
> >>  case "$capstone" in
> >> -  "" | yes)
> >> -    if $pkg_config capstone; then
> >> -      capstone=3Dsystem
> >> -    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' =
;
then
> >> -      capstone=3Dgit
> >> -    elif test -e "${source_path}/capstone/Makefile" ; then
> >> -      capstone=3Dinternal
> >> -    elif test -z "$capstone" ; then
> >> -      capstone=3Dno
> >> -    else
> >> -      feature_not_found "capstone" "Install capstone devel or git
submodule"
> >> -    fi
> >> -    ;;
> >> -
> >> -  system)
> >> -    if ! $pkg_config capstone; then
> >> -      feature_not_found "capstone" "Install capstone devel"
> >> -    fi
> >> -    ;;
> >> -esac
> >> -
> >> -case "$capstone" in
> >> -  git | internal)
> >> -    if test "$capstone" =3D git; then
> >> +  auto | yes | internal)
> >> +    # Simpler to always update submodule, even if not needed.
> >> +    if test -e "${source_path}/.git" && test $git_update =3D 'yes' ;
then
> >>        git_submodules=3D"${git_submodules} capstone"
> >>      fi
> >> -    mkdir -p capstone
> >> -    if test "$mingw32" =3D "yes"; then
> >> -      LIBCAPSTONE=3Dcapstone.lib
> >> -    else
> >> -      LIBCAPSTONE=3Dlibcapstone.a
> >> -    fi
> >> -    capstone_libs=3D"-Lcapstone -lcapstone"
> >> -    capstone_cflags=3D"-I${source_path}/capstone/include"
> >> -    ;;
> >> -
> >> -  system)
> >> -    capstone_libs=3D"$($pkg_config --libs capstone)"
> >> -    capstone_cflags=3D"$($pkg_config --cflags capstone)"
> >> -    ;;
> >> -
> >> -  no)
> >> -    ;;
> >> -  *)
> >> -    error_exit "Unknown state for capstone: $capstone"
> >>      ;;
> >>  esac
> >>
> >> @@ -7292,11 +7252,6 @@ fi
> >>  if test "$ivshmem" =3D "yes" ; then
> >>    echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
> >>  fi
> >> -if test "$capstone" !=3D "no" ; then
> >> -  echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
> >> -  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak
> >> -  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak
> >> -fi
> >>  if test "$debug_mutex" =3D "yes" ; then
> >>    echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
> >>  fi
> >> @@ -7819,9 +7774,6 @@ done # for target in $targets
> >>  if [ "$fdt" =3D "git" ]; then
> >>    subdirs=3D"$subdirs dtc"
> >>  fi
> >> -if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
> >> -  subdirs=3D"$subdirs capstone"
> >> -fi
> >>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
> >>  if test -n "$LIBCAPSTONE"; then
> >>    echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
> >> @@ -8008,7 +7960,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
> >>          -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; els=
e
echo false; fi) \
> >>      -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
> >>      -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
-Dvnc_png=3D$vnc_png \
> >> -    -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
> >> +    -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
> >> +    -Dcapstone=3D$capstone \
> >>          $cross_arg \
> >>          "$PWD" "$source_path"
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 7c60b9dcb8..f3da1760ad 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -156,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt
> >>  dtc/%: .git-submodule-status
> >>      @mkdir -p $@
> >>
> >> -# Overriding CFLAGS causes us to lose defines added in the
sub-makefile.
> >> -# Not overriding CFLAGS leads to mis-matches between compilation
modes.
> >> -# Therefore we replicate some of the logic in the sub-makefile.
> >> -# Remove all the extra -Warning flags that QEMU uses that Capstone
doesn't;
> >> -# no need to annoy QEMU developers with such things.
> >> -CAP_CFLAGS =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
$(CAPSTONE_CFLAGS)
> >> -CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM
> >> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM
> >> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
> >> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC
> >> -CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
> >> -
> >> -.PHONY: capstone/all
> >> -capstone/all: .git-submodule-status
> >> -    $(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone
CAPSTONE_SHARED=3Dno BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)" AR=3D"=
$(AR)"
LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)" $(SUBDIR_MAKEFLA=
GS)
$(BUILD_DIR)/capstone/$(LIBCAPSTONE))
> >> -
> >>  .PHONY: slirp/all
> >>  slirp/all: .git-submodule-status
> >>      $(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp               \
> >> diff --git a/meson.build b/meson.build
> >> index f4d1ab1096..f23273693d 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -10,6 +10,7 @@ else
> >>    keyval =3D import('unstable-keyval')
> >>  endif
> >>  ss =3D import('sourceset')
> >> +fs =3D import('fs')
> >>
> >>  sh =3D find_program('sh')
> >>  cc =3D meson.get_compiler('c')
> >> @@ -409,11 +410,6 @@ if 'CONFIG_USB_LIBUSB' in config_host
> >>    libusb =3D declare_dependency(compile_args:
config_host['LIBUSB_CFLAGS'].split(),
> >>                                link_args:
config_host['LIBUSB_LIBS'].split())
> >>  endif
> >> -capstone =3D not_found
> >> -if 'CONFIG_CAPSTONE' in config_host
> >> -  capstone =3D declare_dependency(compile_args:
config_host['CAPSTONE_CFLAGS'].split(),
> >> -                                link_args:
config_host['CAPSTONE_LIBS'].split())
> >> -endif
> >>  libpmem =3D not_found
> >>  if 'CONFIG_LIBPMEM' in config_host
> >>    libpmem =3D declare_dependency(compile_args:
config_host['LIBPMEM_CFLAGS'].split(),
> >> @@ -470,7 +466,6 @@ foreach k, v: config_host
> >>      config_host_data.set(k, v =3D=3D 'y' ? 1 : v)
> >>    endif
> >>  endforeach
> >> -genh +=3D configure_file(output: 'config-host.h', configuration:
config_host_data)
> >>
> >>  minikconf =3D find_program('scripts/minikconf.py')
> >>  config_all_devices =3D {}
> >> @@ -610,6 +605,108 @@ config_all +=3D {
> >>    'CONFIG_ALL': true,
> >>  }
> >>
> >> +# Submodules
> >> +
> >> +capstone =3D not_found
> >> +capstone_opt =3D get_option('capstone')
> >> +if capstone_opt =3D=3D 'no'
> >> +  capstone_opt =3D false
> >> +elif capstone_opt in ['yes', 'auto', 'system']
> >> +  have_internal =3D fs.exists('capstone/Makefile')
> >> +  capstone =3D dependency('capstone', static: enable_static,
> >> +                        required: capstone_opt =3D=3D 'system' or
> >> +                                  capstone_opt =3D=3D 'yes' and not
have_internal)
> >> +  if capstone.found()
> >> +    capstone_opt =3D 'system'
> >> +  elif have_internal
> >> +    capstone_opt =3D 'internal'
> >> +  else
> >> +    capstone_opt =3D false
> >> +  endif
> >> +endif
> >> +if capstone_opt =3D=3D 'internal'
> >> +  capstone_data =3D configuration_data()
> >> +  capstone_data.set('CAPSTONE_USE_SYS_DYN_MEM', '1')
> >> +
> >> +  capstone_files =3D files(
> >> +    'capstone/cs.c',
> >> +    'capstone/MCInst.c',
> >> +    'capstone/MCInstrDesc.c',
> >> +    'capstone/MCRegisterInfo.c',
> >> +    'capstone/SStream.c',
> >> +    'capstone/utils.c'
> >> +  )
> >> +
> >> +  if 'CONFIG_ARM_DIS' in config_all_disas
> >> +    capstone_data.set('CAPSTONE_HAS_ARM', '1')
> >> +    capstone_files +=3D files(
> >> +      'capstone/arch/ARM/ARMDisassembler.c',
> >> +      'capstone/arch/ARM/ARMInstPrinter.c',
> >> +      'capstone/arch/ARM/ARMMapping.c',
> >> +      'capstone/arch/ARM/ARMModule.c'
> >> +    )
> >> +  endif
> >> +
> >> +  # FIXME: This config entry currently depends on a c++ compiler.
> >> +  # Which is needed for building libvixl, but not for capstone.
> >> +  if 'CONFIG_ARM_A64_DIS' in config_all_disas
> >> +    capstone_data.set('CAPSTONE_HAS_ARM64', '1')
> >> +    capstone_files +=3D files(
> >> +      'capstone/arch/AArch64/AArch64BaseInfo.c',
> >> +      'capstone/arch/AArch64/AArch64Disassembler.c',
> >> +      'capstone/arch/AArch64/AArch64InstPrinter.c',
> >> +      'capstone/arch/AArch64/AArch64Mapping.c',
> >> +      'capstone/arch/AArch64/AArch64Module.c'
> >> +    )
> >> +  endif
> >> +
> >> +  if 'CONFIG_PPC_DIS' in config_all_disas
> >> +    capstone_data.set('CAPSTONE_HAS_POWERPC', '1')
> >> +    capstone_files +=3D files(
> >> +      'capstone/arch/PowerPC/PPCDisassembler.c',
> >> +      'capstone/arch/PowerPC/PPCInstPrinter.c',
> >> +      'capstone/arch/PowerPC/PPCMapping.c',
> >> +      'capstone/arch/PowerPC/PPCModule.c'
> >> +    )
> >> +  endif
> >> +
> >> +  if 'CONFIG_I386_DIS' in config_all_disas
> >> +    capstone_data.set('CAPSTONE_HAS_X86', 1)
> >> +    capstone_files +=3D files(
> >> +      'capstone/arch/X86/X86Disassembler.c',
> >> +      'capstone/arch/X86/X86DisassemblerDecoder.c',
> >> +      'capstone/arch/X86/X86ATTInstPrinter.c',
> >> +      'capstone/arch/X86/X86IntelInstPrinter.c',
> >> +      'capstone/arch/X86/X86Mapping.c',
> >> +      'capstone/arch/X86/X86Module.c'
> >> +    )
> >> +  endif
> >> +
> >> +  configure_file(output: 'capstone-defs.h', configuration:
capstone_data)
> >> +
> >> +  capstone_cargs =3D [
> >> +    # FIXME: There does not seem to be a way to completely replace
the c_args
> >> +    # that come from add_project_arguments() -- we can only add to
them.
> >> +    # So: disable all warnings with a big hammer.
> >> +    '-Wno-error', '-w',
> >> +
> >> +    # Include all configuration defines via a header file, which will
wind up
> >> +    # as a dependency on the object file, and thus changes here will
result
> >> +    # in a rebuild.
> >> +    '-include', 'capstone-defs.h'
> >> +  ]
> >> +
> >> +  libcapstone =3D static_library('capstone',
> >> +                               sources: capstone_files,
> >> +                               c_args: capstone_cargs,
> >> +                               include_directories:
'capstone/include')
> >> +  capstone =3D declare_dependency(link_with: libcapstone,
> >> +                                include_directories:
'capstone/include')
> >> +endif
> >> +config_host_data.set('CONFIG_CAPSTONE', capstone.found())
> >> +
> >> +genh +=3D configure_file(output: 'config-host.h', configuration:
config_host_data)
> >> +
> >>  # Generators
> >>
> >>  hxtool =3D find_program('scripts/hxtool')
> >> @@ -1512,7 +1609,7 @@ summary_info +=3D {'vvfat support':
config_host.has_key('CONFIG_VVFAT')}
> >>  summary_info +=3D {'qed support':
config_host.has_key('CONFIG_QED')}
> >>  summary_info +=3D {'parallels support':
config_host.has_key('CONFIG_PARALLELS')}
> >>  summary_info +=3D {'sheepdog support':
 config_host.has_key('CONFIG_SHEEPDOG')}
> >> -summary_info +=3D {'capstone':
 config_host.has_key('CONFIG_CAPSTONE')}
> >> +summary_info +=3D {'capstone':          capstone_opt}
> >>  summary_info +=3D {'libpmem support':
config_host.has_key('CONFIG_LIBPMEM')}
> >>  summary_info +=3D {'libdaxctl support':
config_host.has_key('CONFIG_LIBDAXCTL')}
> >>  summary_info +=3D {'libudev':
config_host.has_key('CONFIG_LIBUDEV')}
> >> diff --git a/meson_options.txt b/meson_options.txt
> >> index 543cf70043..e650a937e7 100644
> >> --- a/meson_options.txt
> >> +++ b/meson_options.txt
> >> @@ -22,3 +22,7 @@ option('vnc_sasl', type : 'feature', value : 'auto',
> >>         description: 'SASL authentication for VNC server')
> >>  option('xkbcommon', type : 'feature', value : 'auto',
> >>         description: 'xkbcommon support')
> >> +
> >> +option('capstone', type: 'combo', value: 'auto',
> >> +       choices: ['no', 'yes', 'auto', 'system', 'internal'],
> >> +       description: 'Whether and how to find the capstone library')
>
>
> Hmm even more confusing is configure does:
>
>   GIT submodules: ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 meson dtc capstone slirp
>
> but also:
>
>   capstone: system
>
> which I can't quite help but feel is going to be confusing.
maybe remove the capstone system support is a good idea after-all.
>
> --
> Alex Benn=C3=A9e
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000008578bb05afd24d35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 21, 2020 at 7:06 PM Alex Benn=C3=A9e &=
lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt;=
 wrote:<br>&gt;<br>&gt;<br>&gt; Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex=
.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; writes:<br>&gt;<br>&gt; =
&gt; Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">=
richard.henderson@linaro.org</a>&gt; writes:<br>&gt; &gt;<br>&gt; &gt;&gt; =
There are better ways to do this, e.g. meson cmake subproject,<br>&gt; &gt;=
&gt; but that requires cmake 3.7 and some of our CI environments<br>&gt; &g=
t;&gt; only provide cmake 3.5.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Nor can we=
 add a meson.build file to capstone/, because the git<br>&gt; &gt;&gt; subm=
odule would then always report &quot;untracked files&quot;.=C2=A0 Fixing th=
at<br>&gt; &gt;&gt; would require creating our own branch on the qemu git m=
irror, at<br>&gt; &gt;&gt; which point we could just as easily create a nat=
ive meson subproject.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Instead, build the =
library via the main meson.build.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; This im=
proves the current state of affairs in that we will re-link<br>&gt; &gt;&gt=
; the qemu executables against a changed libcapstone.a, which we wouldn&#39=
;t<br>&gt; &gt;&gt; do before-hand.=C2=A0 In addition, the use of the confi=
guration header file<br>&gt; &gt;&gt; instead of command-line -DEFINES mean=
s that we will rebuild the<br>&gt; &gt;&gt; capstone objects with changes t=
o meson.build.<br>&gt; &gt;<br>&gt; &gt; Something is breaking when switchi=
ng to a branch with this on from<br>&gt; &gt; current master:<br>&gt; &gt;<=
br>&gt; &gt; =C2=A0 Linking target qemu-hppa<br>&gt; &gt; =C2=A0 /usr/bin/l=
d: libcommon.fa.p/disas_alpha.c.o: in function `print_insn_alpha&#39;:<br>&=
gt; &gt; =C2=A0 /home/alex/lsrc/qemu.git/builds/all/../../disas/alpha.c:181=
8: undefined reference to `bfd_getl32&#39;<br>&gt; &gt; =C2=A0 collect2: er=
ror: ld returned 1 exit status<br>&gt; &gt; =C2=A0 make: *** [Makefile.ninj=
a:5965: qemu-alpha] Error 1<br>&gt; &gt; =C2=A0 make: *** Waiting for unfin=
ished jobs....<br>&gt; &gt; =C2=A0 /usr/bin/ld: libcommon.fa.p/disas_hppa.c=
.o: in function `print_insn_hppa&#39;:<br>&gt; &gt; =C2=A0 /home/alex/lsrc/=
qemu.git/builds/all/../../disas/hppa.c:1969: undefined reference to `bfd_ge=
tb32&#39;<br>&gt; &gt; =C2=A0 collect2: error: ld returned 1 exit status<br=
>&gt; &gt; =C2=A0 make: *** [Makefile.ninja:6259: qemu-hppa] Error 1<br>&gt=
; &gt;<br>&gt; &gt; Aggressively wiping out the submodule and doing a fresh=
 configure in a<br>&gt; &gt; empty build directory and I still see a failur=
e:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 ../../disas/capstone.c:25:1: error: exp=
ected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=
=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98cap_s=
kipdata_s390x_cb=E2=80=99<br>&gt; &gt; =C2=A0 =C2=A0cap_skipdata_s390x_cb(c=
onst uint8_t *code, size_t code_size,<br>&gt; &gt; =C2=A0 =C2=A0^~~~~~~~~~~=
~~~~~~~~~~<br>&gt; &gt; =C2=A0 ../../disas/capstone.c:49:17: error: =E2=80=
=98cap_skipdata_s390x_cb=E2=80=99 undeclared here (not in a function); did =
you mean =E2=80=98cap_skipdata_s390x=E2=80=99?<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.callback =3D cap_skipdata_s390x_cb<br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~=
~~<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cap_skipdata_s390x<br>&gt; &gt; =C2=A0 Makefile.ninja:1424: recip=
e for target &#39;libcommon.fa.p/disas_capstone.c.o&#39; failed<br>&gt; &gt=
; =C2=A0 make: *** [libcommon.fa.p/disas_capstone.c.o] Error 1<br>&gt; &gt;=
 =C2=A0 make: *** Waiting for unfinished jobs....<br>&gt; &gt;<br>&gt; &gt;=
&gt;<br>&gt; &gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>&gt=
; &gt;&gt; ---<br>&gt; &gt;&gt; Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbo=
nzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; &gt;&gt; v2: Further =
reduce probing in configure (paolo),<br>&gt; &gt;&gt; =C2=A0 =C2=A0 Drop st=
ate &#39;internal&#39; and use &#39;git&#39; even when it isn&#39;t git.<br=
>&gt; &gt;&gt; =C2=A0 =C2=A0 Move CONFIG_CAPSTONE to config_host_data.<br>&=
gt; &gt;&gt; v3: Add Submodules separator; fix default in meson_options.txt=
.<br>&gt; &gt;&gt; ---<br>&gt; &gt;&gt; =C2=A0configure =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A061 +++----------------------<br>&gt; &gt;&gt; =C2=A0Make=
file =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A016 -------<br>&gt; &gt;&gt; =
=C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 | 111 ++++++++++++++++++++++++++++++=
+++++++++++++---<br>&gt; &gt;&gt; =C2=A0meson_options.txt | =C2=A0 4 ++<br>=
&gt; &gt;&gt; =C2=A04 files changed, 115 insertions(+), 77 deletions(-)<br>=
&gt; &gt;&gt;<br>&gt; &gt;&gt; diff --git a/configure b/configure<br>&gt; &=
gt;&gt; index 7564479008..76636c430d 100755<br>&gt; &gt;&gt; --- a/configur=
e<br>&gt; &gt;&gt; +++ b/configure<br>&gt; &gt;&gt; @@ -478,7 +478,7 @@ ope=
ngl=3D&quot;&quot;<br>&gt; &gt;&gt; =C2=A0opengl_dmabuf=3D&quot;no&quot;<br=
>&gt; &gt;&gt; =C2=A0cpuid_h=3D&quot;no&quot;<br>&gt; &gt;&gt; =C2=A0avx2_o=
pt=3D&quot;&quot;<br>&gt; &gt;&gt; -capstone=3D&quot;&quot;<br>&gt; &gt;&gt=
; +capstone=3D&quot;auto&quot;<br>&gt; &gt;&gt; =C2=A0lzo=3D&quot;&quot;<br=
>&gt; &gt;&gt; =C2=A0snappy=3D&quot;&quot;<br>&gt; &gt;&gt; =C2=A0bzip2=3D&=
quot;&quot;<br>&gt; &gt;&gt; @@ -1580,7 +1580,7 @@ for opt do<br>&gt; &gt;&=
gt; =C2=A0 =C2=A0;;<br>&gt; &gt;&gt; =C2=A0 =C2=A0--enable-capstone) capsto=
ne=3D&quot;yes&quot;<br>&gt; &gt;&gt; =C2=A0 =C2=A0;;<br>&gt; &gt;&gt; - =
=C2=A0--enable-capstone=3Dgit) capstone=3D&quot;git&quot;<br>&gt; &gt;&gt; =
+ =C2=A0--enable-capstone=3Dgit) capstone=3D&quot;internal&quot;<br>&gt; &g=
t;&gt; =C2=A0 =C2=A0;;<br>&gt; &gt;&gt; =C2=A0 =C2=A0--enable-capstone=3Dsy=
stem) capstone=3D&quot;system&quot;<br>&gt; &gt;&gt; =C2=A0 =C2=A0;;<br>&gt=
; &gt;&gt; @@ -5128,51 +5128,11 @@ fi<br>&gt; &gt;&gt; =C2=A0# capstone<br>=
&gt; &gt;&gt; <br>&gt; &gt;&gt; =C2=A0case &quot;$capstone&quot; in<br>&gt;=
 &gt;&gt; - =C2=A0&quot;&quot; | yes)<br>&gt; &gt;&gt; - =C2=A0 =C2=A0if $p=
kg_config capstone; then<br>&gt; &gt;&gt; - =C2=A0 =C2=A0 =C2=A0capstone=3D=
system<br>&gt; &gt;&gt; - =C2=A0 =C2=A0elif test -e &quot;${source_path}/.g=
it&quot; &amp;&amp; test $git_update =3D &#39;yes&#39; ; then<br>&gt; &gt;&=
gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dgit<br>&gt; &gt;&gt; - =C2=A0 =C2=A0el=
if test -e &quot;${source_path}/capstone/Makefile&quot; ; then<br>&gt; &gt;=
&gt; - =C2=A0 =C2=A0 =C2=A0capstone=3Dinternal<br>&gt; &gt;&gt; - =C2=A0 =
=C2=A0elif test -z &quot;$capstone&quot; ; then<br>&gt; &gt;&gt; - =C2=A0 =
=C2=A0 =C2=A0capstone=3Dno<br>&gt; &gt;&gt; - =C2=A0 =C2=A0else<br>&gt; &gt=
;&gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;capstone&quot; &quot;In=
stall capstone devel or git submodule&quot;<br>&gt; &gt;&gt; - =C2=A0 =C2=
=A0fi<br>&gt; &gt;&gt; - =C2=A0 =C2=A0;;<br>&gt; &gt;&gt; -<br>&gt; &gt;&gt=
; - =C2=A0system)<br>&gt; &gt;&gt; - =C2=A0 =C2=A0if ! $pkg_config capstone=
; then<br>&gt; &gt;&gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;capst=
one&quot; &quot;Install capstone devel&quot;<br>&gt; &gt;&gt; - =C2=A0 =C2=
=A0fi<br>&gt; &gt;&gt; - =C2=A0 =C2=A0;;<br>&gt; &gt;&gt; -esac<br>&gt; &gt=
;&gt; -<br>&gt; &gt;&gt; -case &quot;$capstone&quot; in<br>&gt; &gt;&gt; - =
=C2=A0git | internal)<br>&gt; &gt;&gt; - =C2=A0 =C2=A0if test &quot;$capsto=
ne&quot; =3D git; then<br>&gt; &gt;&gt; + =C2=A0auto | yes | internal)<br>&=
gt; &gt;&gt; + =C2=A0 =C2=A0# Simpler to always update submodule, even if n=
ot needed.<br>&gt; &gt;&gt; + =C2=A0 =C2=A0if test -e &quot;${source_path}/=
.git&quot; &amp;&amp; test $git_update =3D &#39;yes&#39; ; then<br>&gt; &gt=
;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0git_submodules=3D&quot;${git_submodules} c=
apstone&quot;<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0fi<br>&gt; &gt;&gt; - =
=C2=A0 =C2=A0mkdir -p capstone<br>&gt; &gt;&gt; - =C2=A0 =C2=A0if test &quo=
t;$mingw32&quot; =3D &quot;yes&quot;; then<br>&gt; &gt;&gt; - =C2=A0 =C2=A0=
 =C2=A0LIBCAPSTONE=3Dcapstone.lib<br>&gt; &gt;&gt; - =C2=A0 =C2=A0else<br>&=
gt; &gt;&gt; - =C2=A0 =C2=A0 =C2=A0LIBCAPSTONE=3Dlibcapstone.a<br>&gt; &gt;=
&gt; - =C2=A0 =C2=A0fi<br>&gt; &gt;&gt; - =C2=A0 =C2=A0capstone_libs=3D&quo=
t;-Lcapstone -lcapstone&quot;<br>&gt; &gt;&gt; - =C2=A0 =C2=A0capstone_cfla=
gs=3D&quot;-I${source_path}/capstone/include&quot;<br>&gt; &gt;&gt; - =C2=
=A0 =C2=A0;;<br>&gt; &gt;&gt; -<br>&gt; &gt;&gt; - =C2=A0system)<br>&gt; &g=
t;&gt; - =C2=A0 =C2=A0capstone_libs=3D&quot;$($pkg_config --libs capstone)&=
quot;<br>&gt; &gt;&gt; - =C2=A0 =C2=A0capstone_cflags=3D&quot;$($pkg_config=
 --cflags capstone)&quot;<br>&gt; &gt;&gt; - =C2=A0 =C2=A0;;<br>&gt; &gt;&g=
t; -<br>&gt; &gt;&gt; - =C2=A0no)<br>&gt; &gt;&gt; - =C2=A0 =C2=A0;;<br>&gt=
; &gt;&gt; - =C2=A0*)<br>&gt; &gt;&gt; - =C2=A0 =C2=A0error_exit &quot;Unkn=
own state for capstone: $capstone&quot;<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=
=A0;;<br>&gt; &gt;&gt; =C2=A0esac<br>&gt; &gt;&gt; <br>&gt; &gt;&gt; @@ -72=
92,11 +7252,6 @@ fi<br>&gt; &gt;&gt; =C2=A0if test &quot;$ivshmem&quot; =3D=
 &quot;yes&quot; ; then<br>&gt; &gt;&gt; =C2=A0 =C2=A0echo &quot;CONFIG_IVS=
HMEM=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt; &gt;&gt; =C2=A0fi<br>&gt; =
&gt;&gt; -if test &quot;$capstone&quot; !=3D &quot;no&quot; ; then<br>&gt; =
&gt;&gt; - =C2=A0echo &quot;CONFIG_CAPSTONE=3Dy&quot; &gt;&gt; $config_host=
_mak<br>&gt; &gt;&gt; - =C2=A0echo &quot;CAPSTONE_CFLAGS=3D$capstone_cflags=
&quot; &gt;&gt; $config_host_mak<br>&gt; &gt;&gt; - =C2=A0echo &quot;CAPSTO=
NE_LIBS=3D$capstone_libs&quot; &gt;&gt; $config_host_mak<br>&gt; &gt;&gt; -=
fi<br>&gt; &gt;&gt; =C2=A0if test &quot;$debug_mutex&quot; =3D &quot;yes&qu=
ot; ; then<br>&gt; &gt;&gt; =C2=A0 =C2=A0echo &quot;CONFIG_DEBUG_MUTEX=3Dy&=
quot; &gt;&gt; $config_host_mak<br>&gt; &gt;&gt; =C2=A0fi<br>&gt; &gt;&gt; =
@@ -7819,9 +7774,6 @@ done # for target in $targets<br>&gt; &gt;&gt; =C2=A0=
if [ &quot;$fdt&quot; =3D &quot;git&quot; ]; then<br>&gt; &gt;&gt; =C2=A0 =
=C2=A0subdirs=3D&quot;$subdirs dtc&quot;<br>&gt; &gt;&gt; =C2=A0fi<br>&gt; =
&gt;&gt; -if [ &quot;$capstone&quot; =3D &quot;git&quot; -o &quot;$capstone=
&quot; =3D &quot;internal&quot; ]; then<br>&gt; &gt;&gt; - =C2=A0subdirs=3D=
&quot;$subdirs capstone&quot;<br>&gt; &gt;&gt; -fi<br>&gt; &gt;&gt; =C2=A0e=
cho &quot;SUBDIRS=3D$subdirs&quot; &gt;&gt; $config_host_mak<br>&gt; &gt;&g=
t; =C2=A0if test -n &quot;$LIBCAPSTONE&quot;; then<br>&gt; &gt;&gt; =C2=A0 =
=C2=A0echo &quot;LIBCAPSTONE=3D$LIBCAPSTONE&quot; &gt;&gt; $config_host_mak=
<br>&gt; &gt;&gt; @@ -8008,7 +7960,8 @@ NINJA=3D${ninja:-$PWD/ninjatool} $m=
eson setup \<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Db_coverag=
e=3D$(if test &quot;$gcov&quot; =3D yes; then echo true; else echo false; f=
i) \<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0-Dsdl=3D$sdl -Dsdl_image=3D$sdl_i=
mage \<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_=
sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$vnc_png \<br>&gt; &gt;&gt; - =C2=
=A0 =C2=A0-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\<br>&g=
t; &gt;&gt; + =C2=A0 =C2=A0-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -D=
u2f=3D$u2f \<br>&gt; &gt;&gt; + =C2=A0 =C2=A0-Dcapstone=3D$capstone \<br>&g=
t; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cross_arg \<br>&gt; &gt;&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$PWD&quot; &quot;$source_path&quot=
;<br>&gt; &gt;&gt; <br>&gt; &gt;&gt; diff --git a/Makefile b/Makefile<br>&g=
t; &gt;&gt; index 7c60b9dcb8..f3da1760ad 100644<br>&gt; &gt;&gt; --- a/Make=
file<br>&gt; &gt;&gt; +++ b/Makefile<br>&gt; &gt;&gt; @@ -156,22 +156,6 @@ =
dtc/all: .git-submodule-status dtc/libfdt<br>&gt; &gt;&gt; =C2=A0dtc/%: .gi=
t-submodule-status<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0@mkdir -p $@<br>&gt=
; &gt;&gt; <br>&gt; &gt;&gt; -# Overriding CFLAGS causes us to lose defines=
 added in the sub-makefile.<br>&gt; &gt;&gt; -# Not overriding CFLAGS leads=
 to mis-matches between compilation modes.<br>&gt; &gt;&gt; -# Therefore we=
 replicate some of the logic in the sub-makefile.<br>&gt; &gt;&gt; -# Remov=
e all the extra -Warning flags that QEMU uses that Capstone doesn&#39;t;<br=
>&gt; &gt;&gt; -# no need to annoy QEMU developers with such things.<br>&gt=
; &gt;&gt; -CAP_CFLAGS =3D $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPS=
TONE_CFLAGS)<br>&gt; &gt;&gt; -CAP_CFLAGS +=3D -DCAPSTONE_USE_SYS_DYN_MEM<b=
r>&gt; &gt;&gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM<br>&gt; &gt;&gt; -CAP_C=
FLAGS +=3D -DCAPSTONE_HAS_ARM64<br>&gt; &gt;&gt; -CAP_CFLAGS +=3D -DCAPSTON=
E_HAS_POWERPC<br>&gt; &gt;&gt; -CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86<br>&gt; =
&gt;&gt; -<br>&gt; &gt;&gt; -.PHONY: capstone/all<br>&gt; &gt;&gt; -capston=
e/all: .git-submodule-status<br>&gt; &gt;&gt; - =C2=A0 =C2=A0$(call quiet-c=
ommand,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=3Dno BUILDDIR=3D&quo=
t;$(BUILD_DIR)/capstone&quot; CC=3D&quot;$(CC)&quot; AR=3D&quot;$(AR)&quot;=
 LD=3D&quot;$(LD)&quot; RANLIB=3D&quot;$(RANLIB)&quot; CFLAGS=3D&quot;$(CAP=
_CFLAGS)&quot; $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))<br=
>&gt; &gt;&gt; -<br>&gt; &gt;&gt; =C2=A0.PHONY: slirp/all<br>&gt; &gt;&gt; =
=C2=A0slirp/all: .git-submodule-status<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=
=A0$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt;&gt; diff --git a/meson.build b/m=
eson.build<br>&gt; &gt;&gt; index f4d1ab1096..f23273693d 100644<br>&gt; &gt=
;&gt; --- a/meson.build<br>&gt; &gt;&gt; +++ b/meson.build<br>&gt; &gt;&gt;=
 @@ -10,6 +10,7 @@ else<br>&gt; &gt;&gt; =C2=A0 =C2=A0keyval =3D import(&#3=
9;unstable-keyval&#39;)<br>&gt; &gt;&gt; =C2=A0endif<br>&gt; &gt;&gt; =C2=
=A0ss =3D import(&#39;sourceset&#39;)<br>&gt; &gt;&gt; +fs =3D import(&#39;=
fs&#39;)<br>&gt; &gt;&gt; <br>&gt; &gt;&gt; =C2=A0sh =3D find_program(&#39;=
sh&#39;)<br>&gt; &gt;&gt; =C2=A0cc =3D meson.get_compiler(&#39;c&#39;)<br>&=
gt; &gt;&gt; @@ -409,11 +410,6 @@ if &#39;CONFIG_USB_LIBUSB&#39; in config_=
host<br>&gt; &gt;&gt; =C2=A0 =C2=A0libusb =3D declare_dependency(compile_ar=
gs: config_host[&#39;LIBUSB_CFLAGS&#39;].split(),<br>&gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args: config_host[&#39;LIBUSB_LIBS&#39;=
].split())<br>&gt; &gt;&gt; =C2=A0endif<br>&gt; &gt;&gt; -capstone =3D not_=
found<br>&gt; &gt;&gt; -if &#39;CONFIG_CAPSTONE&#39; in config_host<br>&gt;=
 &gt;&gt; - =C2=A0capstone =3D declare_dependency(compile_args: config_host=
[&#39;CAPSTONE_CFLAGS&#39;].split(),<br>&gt; &gt;&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0link_args: config_host[&#39;CAPSTONE_LIBS&#39;].split()=
)<br>&gt; &gt;&gt; -endif<br>&gt; &gt;&gt; =C2=A0libpmem =3D not_found<br>&=
gt; &gt;&gt; =C2=A0if &#39;CONFIG_LIBPMEM&#39; in config_host<br>&gt; &gt;&=
gt; =C2=A0 =C2=A0libpmem =3D declare_dependency(compile_args: config_host[&=
#39;LIBPMEM_CFLAGS&#39;].split(),<br>&gt; &gt;&gt; @@ -470,7 +466,6 @@ fore=
ach k, v: config_host<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0config_host_data=
.set(k, v =3D=3D &#39;y&#39; ? 1 : v)<br>&gt; &gt;&gt; =C2=A0 =C2=A0endif<b=
r>&gt; &gt;&gt; =C2=A0endforeach<br>&gt; &gt;&gt; -genh +=3D configure_file=
(output: &#39;config-host.h&#39;, configuration: config_host_data)<br>&gt; =
&gt;&gt; <br>&gt; &gt;&gt; =C2=A0minikconf =3D find_program(&#39;scripts/mi=
nikconf.py&#39;)<br>&gt; &gt;&gt; =C2=A0config_all_devices =3D {}<br>&gt; &=
gt;&gt; @@ -610,6 +605,108 @@ config_all +=3D {<br>&gt; &gt;&gt; =C2=A0 =C2=
=A0&#39;CONFIG_ALL&#39;: true,<br>&gt; &gt;&gt; =C2=A0}<br>&gt; &gt;&gt; <b=
r>&gt; &gt;&gt; +# Submodules<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; +capstone=
 =3D not_found<br>&gt; &gt;&gt; +capstone_opt =3D get_option(&#39;capstone&=
#39;)<br>&gt; &gt;&gt; +if capstone_opt =3D=3D &#39;no&#39;<br>&gt; &gt;&gt=
; + =C2=A0capstone_opt =3D false<br>&gt; &gt;&gt; +elif capstone_opt in [&#=
39;yes&#39;, &#39;auto&#39;, &#39;system&#39;]<br>&gt; &gt;&gt; + =C2=A0hav=
e_internal =3D fs.exists(&#39;capstone/Makefile&#39;)<br>&gt; &gt;&gt; + =
=C2=A0capstone =3D dependency(&#39;capstone&#39;, static: enable_static,<br=
>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0required: capstone_opt =3D=3D &#39;system&#39; o=
r<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capstone_=
opt =3D=3D &#39;yes&#39; and not have_internal)<br>&gt; &gt;&gt; + =C2=A0if=
 capstone.found()<br>&gt; &gt;&gt; + =C2=A0 =C2=A0capstone_opt =3D &#39;sys=
tem&#39;<br>&gt; &gt;&gt; + =C2=A0elif have_internal<br>&gt; &gt;&gt; + =C2=
=A0 =C2=A0capstone_opt =3D &#39;internal&#39;<br>&gt; &gt;&gt; + =C2=A0else=
<br>&gt; &gt;&gt; + =C2=A0 =C2=A0capstone_opt =3D false<br>&gt; &gt;&gt; + =
=C2=A0endif<br>&gt; &gt;&gt; +endif<br>&gt; &gt;&gt; +if capstone_opt =3D=
=3D &#39;internal&#39;<br>&gt; &gt;&gt; + =C2=A0capstone_data =3D configura=
tion_data()<br>&gt; &gt;&gt; + =C2=A0capstone_data.set(&#39;CAPSTONE_USE_SY=
S_DYN_MEM&#39;, &#39;1&#39;)<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =C2=A0ca=
pstone_files =3D files(<br>&gt; &gt;&gt; + =C2=A0 =C2=A0&#39;capstone/cs.c&=
#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0&#39;capstone/MCInst.c&#39;,<br>&gt; =
&gt;&gt; + =C2=A0 =C2=A0&#39;capstone/MCInstrDesc.c&#39;,<br>&gt; &gt;&gt; =
+ =C2=A0 =C2=A0&#39;capstone/MCRegisterInfo.c&#39;,<br>&gt; &gt;&gt; + =C2=
=A0 =C2=A0&#39;capstone/SStream.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0&#3=
9;capstone/utils.c&#39;<br>&gt; &gt;&gt; + =C2=A0)<br>&gt; &gt;&gt; +<br>&g=
t; &gt;&gt; + =C2=A0if &#39;CONFIG_ARM_DIS&#39; in config_all_disas<br>&gt;=
 &gt;&gt; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_ARM&#39;, &#39=
;1&#39;)<br>&gt; &gt;&gt; + =C2=A0 =C2=A0capstone_files +=3D files(<br>&gt;=
 &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM/ARMDisassembler.c&#3=
9;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM/ARMInstPr=
inter.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/ARM=
/ARMMapping.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/ar=
ch/ARM/ARMModule.c&#39;<br>&gt; &gt;&gt; + =C2=A0 =C2=A0)<br>&gt; &gt;&gt; =
+ =C2=A0endif<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =C2=A0# FIXME: This con=
fig entry currently depends on a c++ compiler.<br>&gt; &gt;&gt; + =C2=A0# W=
hich is needed for building libvixl, but not for capstone.<br>&gt; &gt;&gt;=
 + =C2=A0if &#39;CONFIG_ARM_A64_DIS&#39; in config_all_disas<br>&gt; &gt;&g=
t; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_ARM64&#39;, &#39;1&#3=
9;)<br>&gt; &gt;&gt; + =C2=A0 =C2=A0capstone_files +=3D files(<br>&gt; &gt;=
&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64BaseInfo.c&#39=
;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch6=
4Disassembler.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/=
arch/AArch64/AArch64InstPrinter.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =
=C2=A0&#39;capstone/arch/AArch64/AArch64Mapping.c&#39;,<br>&gt; &gt;&gt; + =
=C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/AArch64/AArch64Module.c&#39;<br>&gt;=
 &gt;&gt; + =C2=A0 =C2=A0)<br>&gt; &gt;&gt; + =C2=A0endif<br>&gt; &gt;&gt; =
+<br>&gt; &gt;&gt; + =C2=A0if &#39;CONFIG_PPC_DIS&#39; in config_all_disas<=
br>&gt; &gt;&gt; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_POWERPC=
&#39;, &#39;1&#39;)<br>&gt; &gt;&gt; + =C2=A0 =C2=A0capstone_files +=3D fil=
es(<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/PowerPC/PPCDi=
sassembler.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arc=
h/PowerPC/PPCInstPrinter.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#3=
9;capstone/arch/PowerPC/PPCMapping.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0=
 =C2=A0&#39;capstone/arch/PowerPC/PPCModule.c&#39;<br>&gt; &gt;&gt; + =C2=
=A0 =C2=A0)<br>&gt; &gt;&gt; + =C2=A0endif<br>&gt; &gt;&gt; +<br>&gt; &gt;&=
gt; + =C2=A0if &#39;CONFIG_I386_DIS&#39; in config_all_disas<br>&gt; &gt;&g=
t; + =C2=A0 =C2=A0capstone_data.set(&#39;CAPSTONE_HAS_X86&#39;, 1)<br>&gt; =
&gt;&gt; + =C2=A0 =C2=A0capstone_files +=3D files(<br>&gt; &gt;&gt; + =C2=
=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86Disassembler.c&#39;,<br>&gt; &gt=
;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86DisassemblerDecoder.c=
&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/arch/X86/X86ATT=
InstPrinter.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&#39;capstone/ar=
ch/X86/X86IntelInstPrinter.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0&=
#39;capstone/arch/X86/X86Mapping.c&#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =
=C2=A0&#39;capstone/arch/X86/X86Module.c&#39;<br>&gt; &gt;&gt; + =C2=A0 =C2=
=A0)<br>&gt; &gt;&gt; + =C2=A0endif<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =
=C2=A0configure_file(output: &#39;capstone-defs.h&#39;, configuration: caps=
tone_data)<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; + =C2=A0capstone_cargs =3D [=
<br>&gt; &gt;&gt; + =C2=A0 =C2=A0# FIXME: There does not seem to be a way t=
o completely replace the c_args<br>&gt; &gt;&gt; + =C2=A0 =C2=A0# that come=
 from add_project_arguments() -- we can only add to them.<br>&gt; &gt;&gt; =
+ =C2=A0 =C2=A0# So: disable all warnings with a big hammer.<br>&gt; &gt;&g=
t; + =C2=A0 =C2=A0&#39;-Wno-error&#39;, &#39;-w&#39;,<br>&gt; &gt;&gt; +<br=
>&gt; &gt;&gt; + =C2=A0 =C2=A0# Include all configuration defines via a hea=
der file, which will wind up<br>&gt; &gt;&gt; + =C2=A0 =C2=A0# as a depende=
ncy on the object file, and thus changes here will result<br>&gt; &gt;&gt; =
+ =C2=A0 =C2=A0# in a rebuild.<br>&gt; &gt;&gt; + =C2=A0 =C2=A0&#39;-includ=
e&#39;, &#39;capstone-defs.h&#39;<br>&gt; &gt;&gt; + =C2=A0]<br>&gt; &gt;&g=
t; +<br>&gt; &gt;&gt; + =C2=A0libcapstone =3D static_library(&#39;capstone&=
#39;,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sources: capstone_f=
iles,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_args: capstone_ca=
rgs,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 include_directories=
: &#39;capstone/include&#39;)<br>&gt; &gt;&gt; + =C2=A0capstone =3D declare=
_dependency(link_with: libcapstone,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0include_directories: &#39;capstone/include&#39;)<br>&gt; &=
gt;&gt; +endif<br>&gt; &gt;&gt; +config_host_data.set(&#39;CONFIG_CAPSTONE&=
#39;, capstone.found())<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; +genh +=3D conf=
igure_file(output: &#39;config-host.h&#39;, configuration: config_host_data=
)<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; =C2=A0# Generators<br>&gt; &gt;&gt; <=
br>&gt; &gt;&gt; =C2=A0hxtool =3D find_program(&#39;scripts/hxtool&#39;)<br=
>&gt; &gt;&gt; @@ -1512,7 +1609,7 @@ summary_info +=3D {&#39;vvfat support&=
#39;: =C2=A0 =C2=A0 config_host.has_key(&#39;CONFIG_VVFAT&#39;)}<br>&gt; &g=
t;&gt; =C2=A0summary_info +=3D {&#39;qed support&#39;: =C2=A0 =C2=A0 =C2=A0=
 config_host.has_key(&#39;CONFIG_QED&#39;)}<br>&gt; &gt;&gt; =C2=A0summary_=
info +=3D {&#39;parallels support&#39;: config_host.has_key(&#39;CONFIG_PAR=
ALLELS&#39;)}<br>&gt; &gt;&gt; =C2=A0summary_info +=3D {&#39;sheepdog suppo=
rt&#39;: =C2=A0config_host.has_key(&#39;CONFIG_SHEEPDOG&#39;)}<br>&gt; &gt;=
&gt; -summary_info +=3D {&#39;capstone&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0config_host.has_key(&#39;CONFIG_CAPSTONE&#39;)}<br>&gt; &gt;&gt; +sum=
mary_info +=3D {&#39;capstone&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capst=
one_opt}<br>&gt; &gt;&gt; =C2=A0summary_info +=3D {&#39;libpmem support&#39=
;: =C2=A0 config_host.has_key(&#39;CONFIG_LIBPMEM&#39;)}<br>&gt; &gt;&gt; =
=C2=A0summary_info +=3D {&#39;libdaxctl support&#39;: config_host.has_key(&=
#39;CONFIG_LIBDAXCTL&#39;)}<br>&gt; &gt;&gt; =C2=A0summary_info +=3D {&#39;=
libudev&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_host.has_key(&#39;C=
ONFIG_LIBUDEV&#39;)}<br>&gt; &gt;&gt; diff --git a/meson_options.txt b/meso=
n_options.txt<br>&gt; &gt;&gt; index 543cf70043..e650a937e7 100644<br>&gt; =
&gt;&gt; --- a/meson_options.txt<br>&gt; &gt;&gt; +++ b/meson_options.txt<b=
r>&gt; &gt;&gt; @@ -22,3 +22,7 @@ option(&#39;vnc_sasl&#39;, type : &#39;fe=
ature&#39;, value : &#39;auto&#39;,<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 description: &#39;SASL authentication for VNC server&#39;)<br>&gt; &=
gt;&gt; =C2=A0option(&#39;xkbcommon&#39;, type : &#39;feature&#39;, value :=
 &#39;auto&#39;,<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: =
&#39;xkbcommon support&#39;)<br>&gt; &gt;&gt; +<br>&gt; &gt;&gt; +option(&#=
39;capstone&#39;, type: &#39;combo&#39;, value: &#39;auto&#39;,<br>&gt; &gt=
;&gt; + =C2=A0 =C2=A0 =C2=A0 choices: [&#39;no&#39;, &#39;yes&#39;, &#39;au=
to&#39;, &#39;system&#39;, &#39;internal&#39;],<br>&gt; &gt;&gt; + =C2=A0 =
=C2=A0 =C2=A0 description: &#39;Whether and how to find the capstone librar=
y&#39;)<br>&gt;<br>&gt;<br>&gt; Hmm even more confusing is configure does:<=
br>&gt;<br>&gt; =C2=A0 GIT submodules: ui/keycodemapdb tests/fp/berkeley-te=
stfloat-3 tests/fp/berkeley-softfloat-3 meson dtc capstone slirp<br>&gt;<br=
>&gt; but also:<br>&gt;<br>&gt; =C2=A0 capstone: system<br>&gt;<br>&gt; whi=
ch I can&#39;t quite help but feel is going to be confusing.<div>maybe remo=
ve the capstone system support is a good idea after-all.<br>&gt;<br>&gt; --=
<br>&gt; Alex Benn=C3=A9e<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000008578bb05afd24d35--


Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC723C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2853321582
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnLIltjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2853321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBc8-0003g8-2t
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBWb-0006NF-7J
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBWX-0003r7-7C
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600416820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhdLZzUsi8PTEQx35QgXgDd/FSBOecCB+5EZwwdSqLA=;
 b=fnLIltjsKzedV5zWmjqjA68SpyovOVZHxFdmRuVcH0oLfi/STkggxaYwvAd5sedULVSFWr
 W6iV2MQhY57J3BDhf5hFZKlP+RBPOYQVJok3HfzJvWz99PUbwmxaN3+FDVlbh34aGQYyD2
 XlNL4ts5bqpgDXH1wh7lIWBkXYyQkfU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-Lqi6KsR5Ptu30Bz2MfXa6g-1; Fri, 18 Sep 2020 04:13:35 -0400
X-MC-Unique: Lqi6KsR5Ptu30Bz2MfXa6g-1
Received: by mail-wr1-f69.google.com with SMTP id o6so1848139wrp.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AhdLZzUsi8PTEQx35QgXgDd/FSBOecCB+5EZwwdSqLA=;
 b=PKWQ8kW0cLejhGk/nXVvefxH6IjFcx4Rar3UFrpzVY/USFkWdrFOJ5K24GH8a6XYub
 E6PjAPBrp55+/D5MqjZQUBP6E93RjqUYaqFoURysv0BQB8ezmrb89pSTJlY7qHzZUgKs
 KjeFWhtSoCyRlCOyMeYB5PIOF6wwPGZRo7pHJtZkCGcMzRab7iPlEfybY8AQKIcl5T+b
 pic3OO3BKt7jrPKNq4oh30AmY62YVdGwENoE9nAUC+tWCELH29HgaOQMVytBNjzClzEY
 6lEZLnB7rrrdIT0GhDkfv6cs4B4xBjoJDXeaAqqLaWIhBAX58Uz3viSQjrQyzAhmBS7w
 sqjQ==
X-Gm-Message-State: AOAM531uh9DVJC9lxQdVt2jHlpVloUnSFAlYsrn4l5ZrW4//FSYKroQR
 2WmmyOcynXqonA7ERXb+TkfKpWON2nDHtAcRT68idxtNkq8zxftKiiJkaGvB6MOfNwfRJWrYc0h
 7nTt2mGuhqtW7eB0=
X-Received: by 2002:a1c:6385:: with SMTP id x127mr14901719wmb.95.1600416813976; 
 Fri, 18 Sep 2020 01:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw79wewRrXndTgkQwRPlppbncKSdriLhdm3ge3xeWmZAbTKAHjN7ugMVOYUQ8tk+UU+yKuoZA==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr14901694wmb.95.1600416813650; 
 Fri, 18 Sep 2020 01:13:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id o15sm3482074wmh.29.2020.09.18.01.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:13:33 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-2-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <047ad15d-e847-a53d-d0ef-443196085e10@redhat.com>
Date: Fri, 18 Sep 2020 10:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917235720.2685978-2-richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/20 01:57, Richard Henderson wrote:
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

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!  That's also a nice blueprint if anyone wants to do the same on
libfdt.

Paolo


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
> @@ -478,7 +478,7 @@ opengl=""
>  opengl_dmabuf="no"
>  cpuid_h="no"
>  avx2_opt=""
> -capstone=""
> +capstone="auto"
>  lzo=""
>  snappy=""
>  bzip2=""
> @@ -1580,7 +1580,7 @@ for opt do
>    ;;
>    --enable-capstone) capstone="yes"
>    ;;
> -  --enable-capstone=git) capstone="git"
> +  --enable-capstone=git) capstone="internal"
>    ;;
>    --enable-capstone=system) capstone="system"
>    ;;
> @@ -5128,51 +5128,11 @@ fi
>  # capstone
>  
>  case "$capstone" in
> -  "" | yes)
> -    if $pkg_config capstone; then
> -      capstone=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> -      capstone=git
> -    elif test -e "${source_path}/capstone/Makefile" ; then
> -      capstone=internal
> -    elif test -z "$capstone" ; then
> -      capstone=no
> -    else
> -      feature_not_found "capstone" "Install capstone devel or git submodule"
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
> -    if test "$capstone" = git; then
> +  auto | yes | internal)
> +    # Simpler to always update submodule, even if not needed.
> +    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
>        git_submodules="${git_submodules} capstone"
>      fi
> -    mkdir -p capstone
> -    if test "$mingw32" = "yes"; then
> -      LIBCAPSTONE=capstone.lib
> -    else
> -      LIBCAPSTONE=libcapstone.a
> -    fi
> -    capstone_libs="-Lcapstone -lcapstone"
> -    capstone_cflags="-I${source_path}/capstone/include"
> -    ;;
> -
> -  system)
> -    capstone_libs="$($pkg_config --libs capstone)"
> -    capstone_cflags="$($pkg_config --cflags capstone)"
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
>  if test "$ivshmem" = "yes" ; then
>    echo "CONFIG_IVSHMEM=y" >> $config_host_mak
>  fi
> -if test "$capstone" != "no" ; then
> -  echo "CONFIG_CAPSTONE=y" >> $config_host_mak
> -  echo "CAPSTONE_CFLAGS=$capstone_cflags" >> $config_host_mak
> -  echo "CAPSTONE_LIBS=$capstone_libs" >> $config_host_mak
> -fi
>  if test "$debug_mutex" = "yes" ; then
>    echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
>  fi
> @@ -7819,9 +7774,6 @@ done # for target in $targets
>  if [ "$fdt" = "git" ]; then
>    subdirs="$subdirs dtc"
>  fi
> -if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
> -  subdirs="$subdirs capstone"
> -fi
>  echo "SUBDIRS=$subdirs" >> $config_host_mak
>  if test -n "$LIBCAPSTONE"; then
>    echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
> @@ -8008,7 +7960,8 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
>  	-Dsdl=$sdl -Dsdl_image=$sdl_image \
>  	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
> -	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
> +	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
> +	-Dcapstone=$capstone \
>          $cross_arg \
>          "$PWD" "$source_path"
>  
> diff --git a/Makefile b/Makefile
> index 7c60b9dcb8..f3da1760ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -156,22 +156,6 @@ dtc/all: .git-submodule-status dtc/libfdt
>  dtc/%: .git-submodule-status
>  	@mkdir -p $@
>  
> -# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
> -# Not overriding CFLAGS leads to mis-matches between compilation modes.
> -# Therefore we replicate some of the logic in the sub-makefile.
> -# Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
> -# no need to annoy QEMU developers with such things.
> -CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)
> -CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
> -CAP_CFLAGS += -DCAPSTONE_HAS_ARM
> -CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
> -CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
> -CAP_CFLAGS += -DCAPSTONE_HAS_X86
> -
> -.PHONY: capstone/all
> -capstone/all: .git-submodule-status
> -	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
> -
>  .PHONY: slirp/all
>  slirp/all: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
> diff --git a/meson.build b/meson.build
> index f4d1ab1096..f23273693d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -10,6 +10,7 @@ else
>    keyval = import('unstable-keyval')
>  endif
>  ss = import('sourceset')
> +fs = import('fs')
>  
>  sh = find_program('sh')
>  cc = meson.get_compiler('c')
> @@ -409,11 +410,6 @@ if 'CONFIG_USB_LIBUSB' in config_host
>    libusb = declare_dependency(compile_args: config_host['LIBUSB_CFLAGS'].split(),
>                                link_args: config_host['LIBUSB_LIBS'].split())
>  endif
> -capstone = not_found
> -if 'CONFIG_CAPSTONE' in config_host
> -  capstone = declare_dependency(compile_args: config_host['CAPSTONE_CFLAGS'].split(),
> -                                link_args: config_host['CAPSTONE_LIBS'].split())
> -endif
>  libpmem = not_found
>  if 'CONFIG_LIBPMEM' in config_host
>    libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
> @@ -470,7 +466,6 @@ foreach k, v: config_host
>      config_host_data.set(k, v == 'y' ? 1 : v)
>    endif
>  endforeach
> -genh += configure_file(output: 'config-host.h', configuration: config_host_data)
>  
>  minikconf = find_program('scripts/minikconf.py')
>  config_all_devices = {}
> @@ -610,6 +605,108 @@ config_all += {
>    'CONFIG_ALL': true,
>  }
>  
> +# Submodules
> +
> +capstone = not_found
> +capstone_opt = get_option('capstone')
> +if capstone_opt == 'no'
> +  capstone_opt = false
> +elif capstone_opt in ['yes', 'auto', 'system']
> +  have_internal = fs.exists('capstone/Makefile')
> +  capstone = dependency('capstone', static: enable_static,
> +                        required: capstone_opt == 'system' or
> +                                  capstone_opt == 'yes' and not have_internal)
> +  if capstone.found()
> +    capstone_opt = 'system'
> +  elif have_internal
> +    capstone_opt = 'internal'
> +  else
> +    capstone_opt = false
> +  endif
> +endif
> +if capstone_opt == 'internal'
> +  capstone_data = configuration_data()
> +  capstone_data.set('CAPSTONE_USE_SYS_DYN_MEM', '1')
> +
> +  capstone_files = files(
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
> +    capstone_files += files(
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
> +    capstone_files += files(
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
> +    capstone_files += files(
> +      'capstone/arch/PowerPC/PPCDisassembler.c',
> +      'capstone/arch/PowerPC/PPCInstPrinter.c',
> +      'capstone/arch/PowerPC/PPCMapping.c',
> +      'capstone/arch/PowerPC/PPCModule.c'
> +    )
> +  endif
> +
> +  if 'CONFIG_I386_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_X86', 1)
> +    capstone_files += files(
> +      'capstone/arch/X86/X86Disassembler.c',
> +      'capstone/arch/X86/X86DisassemblerDecoder.c',
> +      'capstone/arch/X86/X86ATTInstPrinter.c',
> +      'capstone/arch/X86/X86IntelInstPrinter.c',
> +      'capstone/arch/X86/X86Mapping.c',
> +      'capstone/arch/X86/X86Module.c'
> +    )
> +  endif
> +
> +  configure_file(output: 'capstone-defs.h', configuration: capstone_data)
> +
> +  capstone_cargs = [
> +    # FIXME: There does not seem to be a way to completely replace the c_args
> +    # that come from add_project_arguments() -- we can only add to them.
> +    # So: disable all warnings with a big hammer.
> +    '-Wno-error', '-w',
> +
> +    # Include all configuration defines via a header file, which will wind up
> +    # as a dependency on the object file, and thus changes here will result
> +    # in a rebuild.
> +    '-include', 'capstone-defs.h'
> +  ]
> +
> +  libcapstone = static_library('capstone',
> +                               sources: capstone_files,
> +                               c_args: capstone_cargs,
> +                               include_directories: 'capstone/include')
> +  capstone = declare_dependency(link_with: libcapstone,
> +                                include_directories: 'capstone/include')
> +endif
> +config_host_data.set('CONFIG_CAPSTONE', capstone.found())
> +
> +genh += configure_file(output: 'config-host.h', configuration: config_host_data)
> +
>  # Generators
>  
>  hxtool = find_program('scripts/hxtool')
> @@ -1512,7 +1609,7 @@ summary_info += {'vvfat support':     config_host.has_key('CONFIG_VVFAT')}
>  summary_info += {'qed support':       config_host.has_key('CONFIG_QED')}
>  summary_info += {'parallels support': config_host.has_key('CONFIG_PARALLELS')}
>  summary_info += {'sheepdog support':  config_host.has_key('CONFIG_SHEEPDOG')}
> -summary_info += {'capstone':          config_host.has_key('CONFIG_CAPSTONE')}
> +summary_info += {'capstone':          capstone_opt}
>  summary_info += {'libpmem support':   config_host.has_key('CONFIG_LIBPMEM')}
>  summary_info += {'libdaxctl support': config_host.has_key('CONFIG_LIBDAXCTL')}
>  summary_info += {'libudev':           config_host.has_key('CONFIG_LIBUDEV')}
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
> 



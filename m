Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D31C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E5E2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY3Cqx6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E5E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqOj-0006SI-V0
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLq6r-0002vy-1a
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLq6f-0002Dk-CZ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:58:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601049476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHTudelAe4FHOwK9bn7CI1OAeB5I5/ai5y0kAje0YL4=;
 b=fY3Cqx6qPe/Zh1yssED2b9C3zXGRElNY8wnxMMbJeUHchwAp624aVfV2VVb2sbxFIep3qf
 hwexsrl845X9ODDKyTAZW7LMfNHf8GKAnEQDI2jIOItkXAhy0fdfpSo1q8ZVpItq7Cd97Q
 vRf+UKCGCsL83wGf12LYpGUKwQxBCfQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-G6ttaHMMO6C_jakYhRrUEg-1; Fri, 25 Sep 2020 11:57:52 -0400
X-MC-Unique: G6ttaHMMO6C_jakYhRrUEg-1
Received: by mail-wr1-f69.google.com with SMTP id v5so1218436wrs.17
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pHTudelAe4FHOwK9bn7CI1OAeB5I5/ai5y0kAje0YL4=;
 b=srRKDH0X3oAHovHlC/9bkqSOiAEvV++ld5E7z9O9jFWvDsc9bHjr/BXWs6ue5ncQJ6
 UMIJWD4B0mf47NjsseAH2qI8u+5+lsYuuVNc+hCdkQK402fpx6EDC11p2ELtPYGHua93
 Spp6DaZmw9HP2yj2QXlyzoyTIvsbdhBOqAFVe2SHsyqNETqipFm3aVfncaRqyBXnqQpd
 PT7MUfjQXGdVJj0X/NCxvA2JVwnlgT4zC4zaC/YVtpjNXu0FWbkOdKvf90q5grZ4eXJ9
 usXXu+dLfpntTyRv147HRw6pRjTyo2IQ0Z8T+HgXRaDDescsOMJGiAi+K9i3ot3s2a0x
 wXpg==
X-Gm-Message-State: AOAM530UOCRsoCzPtMVwt5AOndVmPN1/DBBjnomAwAUl7m6Kjajot7ZO
 ah7N7QtSiyCA3d/5ep1EDkxQD0eCv1K8nQ1XGBPLmsLQXz59gZ/2W+0QuDpQDv7nYBVWDzlRzO5
 pVQml56SJsKfeyQU=
X-Received: by 2002:a05:600c:608:: with SMTP id
 o8mr3857753wmm.86.1601049470798; 
 Fri, 25 Sep 2020 08:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYv04DjnhL2cjP7qTtQlTiu57DKdMnlyw1VqSlt1+DhZ/XRBS85XN68juUgP7iEeto85KMVg==
X-Received: by 2002:a05:600c:608:: with SMTP id
 o8mr3857715wmm.86.1601049470300; 
 Fri, 25 Sep 2020 08:57:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id t17sm3433401wrx.82.2020.09.25.08.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 08:57:49 -0700 (PDT)
Subject: Re: [PATCH v1 03/15] meson: move libmpathpersist test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200925154027.12672-1-alex.bennee@linaro.org>
 <20200925154027.12672-4-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
Date: Fri, 25 Sep 2020 17:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925154027.12672-4-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 17:40, Alex Bennée wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> This is the first compiler/linker test that has been moved to Meson.
> Add more section headings to keep things clearer.
> 
> [thuth: Add check for mpathpersist.found() before showing mpathpersist_new_api]
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20200918103430.297167-3-thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure         | 77 +++-----------------------------------------
>  meson.build       | 82 ++++++++++++++++++++++++++++++++++++++++++-----
>  meson_options.txt |  2 ++
>  3 files changed, 80 insertions(+), 81 deletions(-)
> 
> diff --git a/configure b/configure
> index 48bf437021f6..b81868cf0231 100755
> --- a/configure
> +++ b/configure
> @@ -403,7 +403,7 @@ netmap="no"
>  sdl="auto"
>  sdl_image="auto"
>  virtfs=""
> -mpath=""
> +mpath="auto"
>  vnc="enabled"
>  sparse="no"
>  vde=""
> @@ -1116,9 +1116,9 @@ for opt do
>    ;;
>    --enable-virtfs) virtfs="yes"
>    ;;
> -  --disable-mpath) mpath="no"
> +  --disable-mpath) mpath="disabled"
>    ;;
> -  --enable-mpath) mpath="yes"
> +  --enable-mpath) mpath="enabled"
>    ;;
>    --disable-vnc) vnc="disabled"
>    ;;
> @@ -3848,57 +3848,6 @@ if test "$modules" = yes; then
>      fi
>  fi
>  
> -##########################################
> -# libmpathpersist probe
> -
> -if test "$mpath" != "no" ; then
> -  # probe for the new API
> -  cat > $TMPC <<EOF
> -#include <libudev.h>
> -#include <mpath_persist.h>
> -unsigned mpath_mx_alloc_len = 1024;
> -int logsink;
> -static struct config *multipath_conf;
> -extern struct udev *udev;
> -extern struct config *get_multipath_config(void);
> -extern void put_multipath_config(struct config *conf);
> -struct udev *udev;
> -struct config *get_multipath_config(void) { return multipath_conf; }
> -void put_multipath_config(struct config *conf) { }
> -
> -int main(void) {
> -    udev = udev_new();
> -    multipath_conf = mpath_lib_init();
> -    return 0;
> -}
> -EOF
> -  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
> -    mpathpersist=yes
> -    mpathpersist_new_api=yes
> -  else
> -    # probe for the old API
> -    cat > $TMPC <<EOF
> -#include <libudev.h>
> -#include <mpath_persist.h>
> -unsigned mpath_mx_alloc_len = 1024;
> -int logsink;
> -int main(void) {
> -    struct udev *udev = udev_new();
> -    mpath_lib_init(udev);
> -    return 0;
> -}
> -EOF
> -    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
> -      mpathpersist=yes
> -      mpathpersist_new_api=no
> -    else
> -      mpathpersist=no
> -    fi
> -  fi
> -else
> -  mpathpersist=no
> -fi
> -
>  ##########################################
>  # pthread probe
>  PTHREADLIBS_LIST="-pthread -lpthread -lpthreadGC2"
> @@ -6340,23 +6289,11 @@ if test "$softmmu" = yes ; then
>        fi
>        virtfs=no
>      fi
> -    if test "$mpath" != no && test "$mpathpersist" = yes ; then
> -      mpath=yes
> -    else
> -      if test "$mpath" = yes; then
> -        error_exit "Multipath requires libmpathpersist devel"
> -      fi
> -      mpath=no
> -    fi
>    else
>      if test "$virtfs" = yes; then
>        error_exit "VirtFS is supported only on Linux"
>      fi
>      virtfs=no
> -    if test "$mpath" = yes; then
> -      error_exit "Multipath is supported only on Linux"
> -    fi
> -    mpath=no
>    fi
>  fi
>  
> @@ -6897,12 +6834,6 @@ fi
>  if test "$virtfs" = "yes" ; then
>    echo "CONFIG_VIRTFS=y" >> $config_host_mak
>  fi
> -if test "$mpath" = "yes" ; then
> -  echo "CONFIG_MPATH=y" >> $config_host_mak
> -  if test "$mpathpersist_new_api" = "yes"; then
> -    echo "CONFIG_MPATH_NEW_API=y" >> $config_host_mak
> -  fi
> -fi
>  if test "$vhost_scsi" = "yes" ; then
>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>  fi
> @@ -7992,7 +7923,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
>          -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
>          -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
> -	-Dsdl=$sdl -Dsdl_image=$sdl_image \
> +	-Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
>  	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
>  	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
>          $cross_arg \
> diff --git a/meson.build b/meson.build
> index 48724988972d..c09d869f9b02 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -81,6 +81,14 @@ if 'SPARSE_CFLAGS' in config_host
>                         'compile_commands.json'])
>  endif
>  
> +###########################################
> +# Target-specific checks and dependencies #
> +###########################################
> +
> +if targetos != 'linux' and get_option('mpath').enabled()
> +  error('Multipath is supported only on Linux')
> +endif
> +
>  m = cc.find_library('m', required: false)
>  util = cc.find_library('util', required: false)
>  winmm = []
> @@ -112,6 +120,11 @@ elif targetos == 'haiku'
>              cc.find_library('network'),
>              cc.find_library('bsd')]
>  endif
> +
> +################
> +# Dependencies #
> +################
> +
>  # The path to glib.h is added to all compilation commands.  This was
>  # grandfathered in from the QEMU Makefiles.
>  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
> @@ -218,10 +231,6 @@ if 'CONFIG_SPICE' in config_host
>                               link_args: config_host['SPICE_LIBS'].split())
>  endif
>  rt = cc.find_library('rt', required: false)
> -libmpathpersist = not_found
> -if config_host.has_key('CONFIG_MPATH')
> -  libmpathpersist = cc.find_library('mpathpersist')
> -endif
>  libdl = not_found
>  if 'CONFIG_PLUGIN' in config_host
>    libdl = cc.find_library('dl', required: true)
> @@ -252,9 +261,62 @@ if 'CONFIG_CURL' in config_host
>                              link_args: config_host['CURL_LIBS'].split())
>  endif
>  libudev = not_found
> -if target_os == 'linux'
> -  libudev = dependency('libudev', static: enable_static)
> +if targetos == 'linux'
> +  libudev = dependency('libudev',
> +                       required: get_option('mpath'),
> +                       static: enable_static)
> +endif
> +
> +mpathpersist = not_found
> +if targetos == 'linux' and not get_option('mpath').disabled()
> +  libmultipath = cc.find_library('multipath',
> +                                 required: get_option('mpath'),
> +                                 static: enable_static)
> +  libmpathpersist = cc.find_library('mpathpersist',
> +                                    required: get_option('mpath'),
> +                                    static: enable_static)
> +  if libmultipath.found() and libmpathpersist.found() and libudev.found()
> +    if cc.links('''
> +      #include <libudev.h>
> +      #include <mpath_persist.h>
> +      unsigned mpath_mx_alloc_len = 1024;
> +      int logsink;
> +      static struct config *multipath_conf;
> +      extern struct udev *udev;
> +      extern struct config *get_multipath_config(void);
> +      extern void put_multipath_config(struct config *conf);
> +      struct udev *udev;
> +      struct config *get_multipath_config(void) { return multipath_conf; }
> +      void put_multipath_config(struct config *conf) { }
> +      int main(void) {
> +          udev = udev_new();
> +          multipath_conf = mpath_lib_init();
> +          return 0;
> +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist = declare_dependency(dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist_new_api = true
> +    elif cc.links('''
> +      #include <libudev.h>
> +      #include <mpath_persist.h>
> +      unsigned mpath_mx_alloc_len = 1024;
> +      int logsink;
> +      int main(void) {
> +          struct udev *udev = udev_new();
> +          mpath_lib_init(udev);
> +          return 0;
> +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist = declare_dependency(dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist_new_api = false
> +    else
> +      if get_option('mpath').enabled()
> +        error('Cannot detect libmpathpersist API')
> +      else
> +        warning('Cannot detect libmpathpersist API, disabling')
> +      endif
> +    endif
> +  endif
>  endif
> +
>  brlapi = not_found
>  if 'CONFIG_BRLAPI' in config_host
>    brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
> @@ -436,6 +498,10 @@ has_gettid = cc.has_function('gettid')
>  # Create config-host.h
>  
>  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
> +config_host_data.set('CONFIG_MPATH', mpathpersist.found())
> +if mpathpersist.found()
> +  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
> +endif
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>  config_host_data.set('CONFIG_VNC', vnc.found())
> @@ -1185,7 +1251,7 @@ if have_tools
>  
>      executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
>                 dependencies: [authz, crypto, io, qom, qemuutil,
> -                              libcap_ng, libudev, libmpathpersist],
> +                              libcap_ng, mpathpersist],
>                 install: true)
>    endif
>  
> @@ -1407,7 +1473,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
>  summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
>  summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
>  summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
> -summary_info += {'Multipath support': config_host.has_key('CONFIG_MPATH')}
> +summary_info += {'Multipath support': mpathpersist.found()}
>  summary_info += {'VNC support':       vnc.found()}
>  if vnc.found()
>    summary_info += {'VNC SASL support':  sasl.found()}
> diff --git a/meson_options.txt b/meson_options.txt
> index 543cf70043a2..b38a6ae92a92 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -6,6 +6,8 @@ option('docdir', type : 'string', value : 'doc',
>  option('gettext', type : 'boolean', value : true,
>         description: 'Localization of the GTK+ user interface')
>  
> +option('mpath', type : 'feature', value : 'auto',
> +       description: 'Multipath persistent reservation passthrough')
>  option('sdl', type : 'feature', value : 'auto',
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
> 

This is not the latest version of the series, can you drop patches 2 and 3?

Paolo



Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65566C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F4E20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5UAt9og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F4E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWEj-0003Ub-85
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDWCV-0000BL-M3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:05:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45720
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDWCT-0000lZ-PC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6TlbH7y+xa+GJxis15YXQ64WYenOB8iouw1DBJ0B9M=;
 b=X5UAt9oguKerRUoB/LGm6ARpN8T1fCJMSTsHFzLo1H5cg72728+AJTw/oil2cA37oCtamW
 +HmwA600wFMZXltHlUNmwfhTN0z2e/CqWfe24CKkJjdnk33c3KT6+mgqnfaZoqmq94zJ9v
 azuYQYC7LLAWyKqA9rTuvYvLShL8Qq4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-ACVfyPP_MmS27AkPVoHkVQ-1; Wed, 02 Sep 2020 13:05:31 -0400
X-MC-Unique: ACVfyPP_MmS27AkPVoHkVQ-1
Received: by mail-wm1-f70.google.com with SMTP id z1so2229321wmk.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p6TlbH7y+xa+GJxis15YXQ64WYenOB8iouw1DBJ0B9M=;
 b=qFRz7Ac5tTpmxXGQ287YqIUQFccuww8BvNnFVwgcSXmj0qj9TCOGj/ySbHwct4sBYf
 ZJ5a1yOhNrWK7lQN2l0CZJ74llLhk6o46v9ieKxY3t9WnTPCi+mGrP2XehaZZ1aUjq9q
 Obuo7FqjRw8F62kRvoi1fQc23HrVRXeUEkLsXzDzTNhOHItGrD/UnfnTzajgkMrv4C6o
 W+VqnvOk1/v/G2SC6clZvi37nGIyuakztcy9UphEmcHVBmzb8yTnlygo0B0ip16vS4YX
 sPUvR17spjsLws3UDrX773fBRPqxmbPSD+2Q4sJBb68vBbY7PPkEto7N6KSybR6pfZLz
 R8xg==
X-Gm-Message-State: AOAM532p3wNeohUhGIVxBGJUQ6ToCH1furZUCGmvPehTGKLcvmAlAkN5
 mj3sUuBCi87snTO1zwkAUiJkuA+iPKtCl/2RrTcVTbxgFPagIAh/h/2+bc1x1m3DLX2lsOOK4+t
 qcuUQMG4TtItXdgI=
X-Received: by 2002:adf:f508:: with SMTP id q8mr7739685wro.233.1599066329696; 
 Wed, 02 Sep 2020 10:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWZ42mgdXAepRb7H+MHbtlSZoclFM+cLddJXDzH0dxcBwjCJ1HhUyVhQ6XSr59/96tMe+M4g==
X-Received: by 2002:adf:f508:: with SMTP id q8mr7739664wro.233.1599066329464; 
 Wed, 02 Sep 2020 10:05:29 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id p11sm397407wma.11.2020.09.02.10.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:05:28 -0700 (PDT)
Subject: Re: [PATCH 6/6] configure: Fix include and linkage issue on msys2
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-7-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <436ea293-8fba-e762-fdff-d84534f5baee@redhat.com>
Date: Wed, 2 Sep 2020 19:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902170054.810-7-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 19:00, Yonggang Luo wrote:
> On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized by the compiler
> Cause $PWD are result posix style path such as /e/path/to/qemu that can not be recognized
> by mingw gcc, and `pwd -W` are result Windows style path such as E:/path/to/qemu that can
> be recognized by the mingw gcc. So we replace all $PWD with $build_path that can
> building qemu under msys2/mingw environment.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

I'm dropping this patch in favor of relative -L and -I paths.

Paolo

>  configure | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/configure b/configure
> index 30f8c4db29..5f2bcc4b57 100755
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
> @@ -943,7 +953,7 @@ Linux)
>    linux="yes"
>    linux_user="yes"
>    kvm="yes"
> -  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
> +  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
>    libudev="yes"
>  ;;
>  esac
> @@ -4259,7 +4269,7 @@ EOF
>            fdt=git
>            mkdir -p dtc
>            fdt_cflags="-I${source_path}/dtc/libfdt"
> -          fdt_ldflags="-L$PWD/dtc/libfdt"
> +          fdt_ldflags="-L${build_path}/dtc/libfdt"
>            fdt_libs="$fdt_libs"
>        elif test "$fdt" = "yes" ; then
>            # Not a git build & no libfdt found, prompt for system install
> @@ -5244,7 +5254,7 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=libcapstone.a
>      fi
> -    capstone_libs="-L$PWD/capstone -lcapstone"
> +    capstone_libs="-L${build_path}/capstone -lcapstone"
>      capstone_cflags="-I${source_path}/capstone/include"
>      ;;
>  
> @@ -6244,8 +6254,8 @@ case "$slirp" in
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
> @@ -8190,7 +8200,7 @@ fi
>  mv $cross config-meson.cross
>  
>  rm -rf meson-private meson-info meson-logs
> -NINJA=${ninja:-$PWD/ninjatool} $meson setup \
> +NINJA=${ninja:-${build_path}/ninjatool} $meson setup \
>          --prefix "${pre_prefix}$prefix" \
>          --libdir "${pre_prefix}$libdir" \
>          --libexecdir "${pre_prefix}$libexecdir" \
> @@ -8212,7 +8222,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>  	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
>  	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
>          $cross_arg \
> -        "$PWD" "$source_path"
> +        "$build_path" "$source_path"
>  
>  if test "$?" -ne 0 ; then
>      error_exit "meson setup failed"
> 



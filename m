Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E7C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7EA21775
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDd5llL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7EA21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTRN-0003pV-0N
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQTQO-00034v-W7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQTQM-0007UF-Ln
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602153925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dL/CKTQzbqohFYtdrBGkjv1FIPQ6YK9hC7aBQfSN9Q=;
 b=gDd5llL+WDPEdXfl1bw6RcO6nm+GIDcu1MDXlGQ5OzAs7/Gzt7lMZQ817NZvB18QESSZyS
 oxCYnxjO5GnM4lAJ3UzExxRDeFWp2F0dSAMVY+9S0HVrjlU7q0VRwCLQ1NzB/QEf6I11zx
 NyOSdyZdP+LwBQeyIxWjyhKJfPLO3iw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-LCM6GZJBOJm4jMzLtKetcQ-1; Thu, 08 Oct 2020 06:45:24 -0400
X-MC-Unique: LCM6GZJBOJm4jMzLtKetcQ-1
Received: by mail-wm1-f71.google.com with SMTP id 73so2992128wma.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0dL/CKTQzbqohFYtdrBGkjv1FIPQ6YK9hC7aBQfSN9Q=;
 b=rVk00a+ZXKZDKtQX7XA3pdlOLP8SrhFC8x9aHrrA37tz9XHv5GgXot65wEXmFF+vHo
 91WZcRUNf5XSxf6PXzrfT76O1cTf02Bnx27Wc/prSWitxa+fU4nnR+aD8iEvTVhDmpC9
 g6OFS7IJrQskep95/1DKfMNwIY0d4c5JdM8QwpdxolEQDWorMmA15imGS4KtwHyRCwYc
 FVx3QqifFqo2JH0mEqP5VsQmPucRqVRVqJz8ZQrV4QPg4Fu++cepMUiRd9OeO5bKnKFH
 oGMtbkJ5voKJpLSfImkt2c32qpbB10cez2vKllV0JBsBkE7JVProRSuIJaWOzRurCMnh
 MgoQ==
X-Gm-Message-State: AOAM533Qt1t2aorJ1sRdLr0/sbbbnE9tPWBbGqOPDtLQXkFueqzXf08v
 u3Axd/q75M1qaaDicAcTg71fBq4JUQLYA7VQMRsZoZv/bB1vaJMsDyAG4qWFpQbt2xu/U1CZ8ja
 A7pvuOp0cszWqQ/k=
X-Received: by 2002:adf:fa06:: with SMTP id m6mr3024896wrr.253.1602153922484; 
 Thu, 08 Oct 2020 03:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyZaPwKLYhnC7uAw8JKvU6rXtB/gJxAGjaQGt3VUtwXXvXBLXs8ForNxoYl1kAneMUNsx81Q==
X-Received: by 2002:adf:fa06:: with SMTP id m6mr3024874wrr.253.1602153922186; 
 Thu, 08 Oct 2020 03:45:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id u63sm6634161wmb.13.2020.10.08.03.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 03:45:21 -0700 (PDT)
Subject: Re: [PATCH v2] configure: add option for virtiofsd
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com
References: <20201008103133.2722903-1-misono.tomohiro@jp.fujitsu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea7dc73c-7ca5-924e-756e-02a5e66f85c7@redhat.com>
Date: Thu, 8 Oct 2020 12:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008103133.2722903-1-misono.tomohiro@jp.fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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

On 08/10/20 12:31, Misono Tomohiro wrote:
> Currently it is unknown whether virtiofsd will be built at
> configuration time. It will be automatically built when dependency
> is met. Also, required libraries are not clear.
> 
> To make this clear, add configure option --{enable,disable}-virtiofsd.
> The default is the same as current (enabled if available) like many
> other options. When --enable-virtiofsd is given and dependency is not
> met, we get:
> 
>   ERROR: Problem encountered: virtiofsd requires libcap-ng-devel and seccomp-devel
> or
>   ERROR: Problem encountered: virtiofsd needs tools and vhost-user support
> 
> In addition, configuration summary now includes virtiofsd entry:
> 
>   build virtiofs daemon: YES/NO
> 
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> ---
> This patch is based on current master branch
> 
> v1 ... https://lore.kernel.org/qemu-devel/20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com/
> v1 -> v2: Update to follow the current meson build style
> 
>  configure         |  8 +++++++-
>  meson.build       |  1 +
>  meson_options.txt |  2 ++
>  tools/meson.build | 17 +++++++++++++++--
>  4 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 28df227db5..2bd8419b1f 100755
> --- a/configure
> +++ b/configure
> @@ -302,6 +302,7 @@ netmap="no"
>  sdl="auto"
>  sdl_image="auto"
>  virtfs=""
> +virtiofsd="auto"
>  mpath="auto"
>  vnc="enabled"
>  sparse="auto"
> @@ -1004,6 +1005,10 @@ for opt do
>    ;;
>    --enable-virtfs) virtfs="yes"
>    ;;
> +  --disable-virtiofsd) virtiofsd="disabled"
> +  ;;
> +  --enable-virtiofsd) virtiofsd="enabled"
> +  ;;
>    --disable-mpath) mpath="disabled"
>    ;;
>    --enable-mpath) mpath="enabled"
> @@ -1761,6 +1766,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    vnc-png         PNG compression for VNC server
>    cocoa           Cocoa UI (Mac OS X only)
>    virtfs          VirtFS
> +  virtiofsd       build virtiofs daemon (virtiofsd)
>    mpath           Multipath persistent reservation passthrough
>    xen             xen backend driver support
>    xen-pci-passthrough    PCI passthrough support for Xen
> @@ -7215,7 +7221,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>  	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
>  	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
>  	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
> -	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
> +	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f -Dvirtiofsd=$virtiofsd \
>  	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
>          $cross_arg \
>          "$PWD" "$source_path"
> diff --git a/meson.build b/meson.build
> index 17c89c87c6..a087239009 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1843,6 +1843,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
>  summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
>  summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
>  summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
> +summary_info += {'build virtiofs daemon': have_virtiofsd}
>  summary_info += {'Multipath support': mpathpersist.found()}
>  summary_info += {'VNC support':       vnc.found()}
>  if vnc.found()
> diff --git a/meson_options.txt b/meson_options.txt
> index 1d3c94840a..80637ada63 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -48,6 +48,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
>         description: 'SASL authentication for VNC server')
>  option('xkbcommon', type : 'feature', value : 'auto',
>         description: 'xkbcommon support')
> +option('virtiofsd', type: 'feature', value: 'auto',
> +       description: 'build virtiofs daemon (virtiofsd)')
>  
>  option('capstone', type: 'combo', value: 'auto',
>         choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
> diff --git a/tools/meson.build b/tools/meson.build
> index 513bd2ff4f..76bf84df52 100644
> --- a/tools/meson.build
> +++ b/tools/meson.build
> @@ -1,10 +1,23 @@
> -have_virtiofsd = (have_system and
> +have_virtiofsd = (targetos == 'linux' and
>      have_tools and
> -    'CONFIG_LINUX' in config_host and 
>      'CONFIG_SECCOMP' in config_host and
>      'CONFIG_LIBCAP_NG' in config_host and
>      'CONFIG_VHOST_USER' in config_host)
>  
> +if get_option('virtiofsd').enabled()
> +  if not have_virtiofsd
> +    if targetos != 'linux'
> +      error('virtiofsd requires Linux')
> +    elif 'CONFIG_SECCOMP' not in config_host or 'CONFIG_LIBCAP_NG' not in config_host
> +      error('virtiofsd requires libcap-ng-devel and seccomp-devel')
> +    elif not have_tools or 'CONFIG_VHOST_USER' not in config_host
> +      error('virtiofsd needs tools and vhost-user support')
> +    endif
> +  endif
> +elif get_option('virtiofsd').disabled() or not have_system
> +  have_virtiofsd = false
> +endif
> +
>  if have_virtiofsd
>    subdir('virtiofsd')
>  endif
> 

This looks good and the way you solved --enable-virtiofsd
--disable-tools makes sense.  I'll let David pick it up or decide if he
wants a different approach.

Paolo



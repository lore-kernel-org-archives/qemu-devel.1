Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75505C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7ED20738
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmvcP2yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7ED20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCJi0-00069x-Dk
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 05:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJhT-0005kI-3G
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:32:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJhQ-0001T7-HP
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598779950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8AoCkbwfxp2aW7jKNl5uDoV3aHGmxGgRzq08bv++Vs=;
 b=cmvcP2yncAaWGYUxAkDaXT5bp3FuBKsQSmPVlIMIYEbu+kmTD9GsAU8DuS3Bp+FxEp3xaF
 VpwRzIPMreCOTT59dfWIl/ttT0aTCyAIsB6zrTfP4hUhJUxqqJSKGWffsTxC8K5/LWVKwD
 Qx5afr5Bmbk6Kjtbw5DvbgI5wPmkJVY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-2Xgm8GlVPiesQxsDsrU2iQ-1; Sun, 30 Aug 2020 05:32:26 -0400
X-MC-Unique: 2Xgm8GlVPiesQxsDsrU2iQ-1
Received: by mail-wr1-f71.google.com with SMTP id i6so1871490wrs.13
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w8AoCkbwfxp2aW7jKNl5uDoV3aHGmxGgRzq08bv++Vs=;
 b=BD23dMigB7D7nSyhTsBYrqGwwOlEjd1QDSmHqjgHUAdDfL9aH1gY7ogrsF/nkJuXfp
 oYkuEiHHrPQWaHWx7nUc/miSyNCYarWObA6mgnVyKQMMGkjzpIpVg6dUyyxKmKN6Sf1L
 n5jU0dr6iXmqEI8Zb0ECeLjU9Ge5fwb3Cn9UsPfWnPNqKYfwT4DIiik/kazgd+xc0OvF
 79h+ZDmiWub3abNhwFPpL4bnQFhU/FoT34DQbAMZJXec/d8wzaiMAetTf+YrTskRWQJp
 01ZrKiDAYyHqRRjmnezeNcHQ/LOtt171wQim3QS57AW3oy5F/hJGexi8uwhMSYVBHwLR
 oEuQ==
X-Gm-Message-State: AOAM532n58rsyljs3wBdgtHSSV/VX9QHEWkLKXE6UAGxn69XGg1LkEno
 J2Zif10R+eAdaSQkc1YdNj5CB8uKPwmKfJmHD+O1D1RgWJmzUkhqTkP40BX4JA4UiI4zwaB4EeJ
 O45e5SjHjk2TrHnI=
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr6483740wme.139.1598779944888; 
 Sun, 30 Aug 2020 02:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1WrsaVxpQuXZyvM2jGbqS029tZwLHyXUefqwlg8yt/9XSKud5zthlUwo2g1kUZj6kiAGxWA==
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr6483729wme.139.1598779944668; 
 Sun, 30 Aug 2020 02:32:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7?
 ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
 by smtp.gmail.com with ESMTPSA id 70sm6658791wme.15.2020.08.30.02.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 02:32:24 -0700 (PDT)
Subject: Re: [PATCH] meson: fix SDL2_image detection
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
References: <20200829104158.7461-1-vr_qemu@t-online.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ba485fb-09cc-092a-2c8b-35c9f1f1c7c9@redhat.com>
Date: Sun, 30 Aug 2020 11:32:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200829104158.7461-1-vr_qemu@t-online.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 05:32:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/08/20 12:41, Volker Rümelin wrote:
> Configure used to probe for SDL2_image in sdl_image_probe (). Meson
> should do the same.
> 
> This fixes the following error on my system:
> 
> Run-time dependency sdl2 found: YES 2.0.8
> Found CMake: /usr/bin/cmake (3.17.0)
> Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)
> 
> ../qemu-master/meson.build:256:2: ERROR: Dependency "sdl-image" not
> found, tried pkgconfig and cmake
> 
> A full log can be found at /home/ruemelin/rpmbuild/BUILD
> /qemu-5.1.50-build/meson-logs/meson-log.txt
> 
> ERROR: meson setup failed
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 74f8ea0c2e..8204878860 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -248,7 +248,7 @@ if sdl.found()
>    # work around 2.0.8 bug
>    sdl = declare_dependency(compile_args: '-Wno-undef',
>                             dependencies: sdl)
> -  sdl_image = dependency('sdl-image', required: get_option('sdl_image'),
> +  sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
>                           static: enable_static)
>  else
>    if get_option('sdl_image').enabled()
> 

Queued, thanks.

Paolo



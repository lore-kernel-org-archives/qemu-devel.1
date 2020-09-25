Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96BC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02B520936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc4VEI4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02B520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoUL-0005Ab-RL
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLoOJ-0007oS-FJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLoOH-0003AA-09
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:08:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601042878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb/F7p0Bj1MLb1PrzgmwCV4r9V/pchxdlOUHZVdSBkE=;
 b=Kc4VEI4cHeJbFK6bbF6nUK8pzumrl83mS5zS6q3x4Oa8OiLJuymAa5gAeZW3/IfF7NMq4K
 8iPP8dc3rRM2Qwhv3bU76JoWSrqjJc8SjTLRenRTD0ysIkATDTjuvN+bO7KS0liIie25Hf
 PwWY9090yxUcpRZhy7/Y8JtVziccTQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-MhkA4p5lOZmagBvAwjLW7A-1; Fri, 25 Sep 2020 10:07:44 -0400
X-MC-Unique: MhkA4p5lOZmagBvAwjLW7A-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1125315wrp.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 07:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rb/F7p0Bj1MLb1PrzgmwCV4r9V/pchxdlOUHZVdSBkE=;
 b=P7ElcamniRN9uxvRWEvnq20q9a9yAWPsS0Ot2xWuioybA8eAQYgQzZXRySJfjaugVU
 WLalKEWukivb50y6XtMxyYww7G2J6bOngerHsNpI2Ve2trb2PF11GOwRSJdzvyjHYwLb
 ZsOFpxMrh2ZFoHbhcgi4pMwJJP7wIy/pD6Wi39ez86QX/KPTbG4hJM6HI+gDa2iV9L2M
 IiW0DfLnjuT4UYA9auD2jrePMef2kYuZ+HPYXqtKhr1LvNNcLnMnYxw/9qWq0M+4RSJh
 EurVv4FDyiD/Zkz+lfGSsv8l3qxtsx4dfkwPWY+qDnzA41nn7FCbRFlr9vl/QIiDsUNV
 3wRw==
X-Gm-Message-State: AOAM532q73zLyqUja0AgQArd32w0KSX+5RBNlM/D/arOkBHeUJrEwEQi
 ziVTOPMJ+++S/iL44CiRjn2rlsxq0VTlMnR6RTdL6fuEDklF58oHmKk4Zv7xg4xJY/eqQiX6QjS
 /MvWUH26+ZeczYCM=
X-Received: by 2002:adf:eacb:: with SMTP id o11mr4624382wrn.209.1601042862936; 
 Fri, 25 Sep 2020 07:07:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg64sfDvh3ATYqsPz80Z/zKzQB48J8Fxo5mZ9whzSTQGe76w8N2ke372PSFEn1TX5EJw4Prw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr4624349wrn.209.1601042862621; 
 Fri, 25 Sep 2020 07:07:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id q12sm2983779wrs.48.2020.09.25.07.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:07:41 -0700 (PDT)
Subject: Re: [PATCH 1/4] util/vhost-user-server: use static library in
 meson.build
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200925134229.246169-1-stefanha@redhat.com>
 <20200925134229.246169-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4a25e55-3e63-4090-21ab-e3b3ee98be16@redhat.com>
Date: Fri, 25 Sep 2020 16:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925134229.246169-2-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 15:42, Stefan Hajnoczi wrote:
> Don't compile contrib/libvhost-user/libvhost-user.c again. Instead build
> the static library once and then reuse it throughout QEMU.
> 
> Also switch from CONFIG_LINUX to CONFIG_VHOST_USER, which is what the
> vhost-user tools (vhost-user-gpu, etc) do.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Looks good.  Unrelated to this patch, probably the contrib/libvhost-user
directory should be moved under tools.

Paolo

> ---
>  block/export/export.c             | 8 ++++----
>  block/export/meson.build          | 2 +-
>  contrib/libvhost-user/meson.build | 1 +
>  meson.build                       | 6 +++++-
>  tests/qtest/meson.build           | 2 +-
>  util/meson.build                  | 4 +++-
>  6 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/block/export/export.c b/block/export/export.c
> index bd7cac241f..550897e236 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -17,17 +17,17 @@
>  #include "sysemu/block-backend.h"
>  #include "block/export.h"
>  #include "block/nbd.h"
> -#if CONFIG_LINUX
> -#include "block/export/vhost-user-blk-server.h"
> -#endif
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block-export.h"
>  #include "qapi/qapi-events-block-export.h"
>  #include "qemu/id.h"
> +#ifdef CONFIG_VHOST_USER
> +#include "vhost-user-blk-server.h"
> +#endif
>  
>  static const BlockExportDriver *blk_exp_drivers[] = {
>      &blk_exp_nbd,
> -#if CONFIG_LINUX
> +#ifdef CONFIG_VHOST_USER
>      &blk_exp_vhost_user_blk,
>  #endif
>  };
> diff --git a/block/export/meson.build b/block/export/meson.build
> index ef3a9576f7..469a7aa0f5 100644
> --- a/block/export/meson.build
> +++ b/block/export/meson.build
> @@ -1,2 +1,2 @@
>  block_ss.add(files('export.c'))
> -block_ss.add(when: 'CONFIG_LINUX', if_true: files('vhost-user-blk-server.c', '../../contrib/libvhost-user/libvhost-user.c'))
> +block_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-blk-server.c'))
> diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
> index e68dd1a581..a261e7665f 100644
> --- a/contrib/libvhost-user/meson.build
> +++ b/contrib/libvhost-user/meson.build
> @@ -1,3 +1,4 @@
>  libvhost_user = static_library('vhost-user',
>                                 files('libvhost-user.c', 'libvhost-user-glib.c'),
>                                 build_by_default: false)
> +vhost_user = declare_dependency(link_with: libvhost_user)
> diff --git a/meson.build b/meson.build
> index 4c6c7310fa..eb84b97ebb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -788,6 +788,11 @@ trace_events_subdirs += [
>    'util',
>  ]
>  
> +vhost_user = not_found
> +if 'CONFIG_VHOST_USER' in config_host
> +  subdir('contrib/libvhost-user')
> +endif
> +
>  subdir('qapi')
>  subdir('qobject')
>  subdir('stubs')
> @@ -1169,7 +1174,6 @@ if have_tools
>               install: true)
>  
>    if 'CONFIG_VHOST_USER' in config_host
> -    subdir('contrib/libvhost-user')
>      subdir('contrib/vhost-user-blk')
>      subdir('contrib/vhost-user-gpu')
>      subdir('contrib/vhost-user-input')
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c72821b09a..aa8d0985e1 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -191,7 +191,7 @@ qos_test_ss.add(
>  )
>  qos_test_ss.add(when: 'CONFIG_VIRTFS', if_true: files('virtio-9p-test.c'))
>  qos_test_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-test.c'))
> -qos_test_ss.add(when: 'CONFIG_LINUX', if_true: files('vhost-user-blk-test.c'))
> +qos_test_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-blk-test.c'))
>  
>  extra_qtest_deps = {
>    'bios-tables-test': [io],
> diff --git a/util/meson.build b/util/meson.build
> index 2296e81b34..9b2a7a5de9 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -66,7 +66,9 @@ if have_block
>    util_ss.add(files('main-loop.c'))
>    util_ss.add(files('nvdimm-utils.c'))
>    util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
> -  util_ss.add(when: 'CONFIG_LINUX', if_true: files('vhost-user-server.c'))
> +  util_ss.add(when: 'CONFIG_VHOST_USER', if_true: [
> +    files('vhost-user-server.c'), vhost_user
> +  ])
>    util_ss.add(files('block-helpers.c'))
>    util_ss.add(files('qemu-coroutine-sleep.c'))
>    util_ss.add(files('qemu-co-shared-resource.c'))
> 



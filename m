Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA305C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475F8208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLCXX0oP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475F8208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoQr-0000tr-2r
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLoOZ-0007y9-Qn
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLoOV-0003D0-HI
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:08:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601042894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRF9bAd3ZZGSlPY/ZRXLf/FnOHGuDLRy8Dg1kro0PcY=;
 b=CLCXX0oPiJMsBswM/9QtEQT9nD/lQA8Oj24DRfHE5POiVOFpef/UN9OufpQXCy+D3FaOh2
 pfBfTpbFONhgpYTE5kgmqDTWjw/uUvT8xZXjHNCjrVOJCszR1ZJY2vH6NlCMX7/loLNjyk
 9s2Dl5DFCTrujP3LTyC/LNdoGRjAxZg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-Xn2W__cXP1-9am7kXokOeA-1; Fri, 25 Sep 2020 10:08:12 -0400
X-MC-Unique: Xn2W__cXP1-9am7kXokOeA-1
Received: by mail-wr1-f70.google.com with SMTP id w7so1132605wrp.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mRF9bAd3ZZGSlPY/ZRXLf/FnOHGuDLRy8Dg1kro0PcY=;
 b=R5cgdCBKp+TpmECnMLocqPkruNlb1K2I2Mg6naV+vyd27VYOn4H+tTeRMA64IvlTRM
 QYeI5KzM39ZzXnL7ZgNvBcEfI5rEnVz3d5I8zFRSES9OtbdftD6FHbDVxeCX86UE5NNA
 Wlp5RK+ta59k5li0uyFKbAKF45BK4xjeDD1kJeR3Zif4pOF64k/ioazmODZMMk7yxyoi
 XEu1SAqbP6czcLPVDnlBNPxPTrIXc/yBumbaGYVxiB68ovBt0tr77QUnOodCre3cRj25
 v/PPFUftLOYZp598tigGZd0smc1NRqJMSu7iyx5qNwc6UX3soF5kF72ycXgNlPg1YV6W
 yNvA==
X-Gm-Message-State: AOAM5305V4Pv3rWuzeGaiAqvLd6sD4FGh9bcL8vYPJKWkU70+QGPKD+y
 MQgvC3Yzz7ckFpteN3vavWWT2SlS5IUSrcUm8ajcJ/exw7GlkG60orEUoE5Z0uQU+czYsikZ+GZ
 yQxAL+7mlSzqaQiI=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr3555119wmh.177.1601042891674; 
 Fri, 25 Sep 2020 07:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQJDgB0nMznL4/oFW8Tpwl514CTCnWrl+7vC8JlB6GsjVzj14CwiF3weyr+UynJAP+jiEJUQ==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr3555087wmh.177.1601042891457; 
 Fri, 25 Sep 2020 07:08:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id h3sm3331614wrq.0.2020.09.25.07.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:08:10 -0700 (PDT)
Subject: Re: [PATCH 2/4] qemu-storage-daemon: avoid compiling blockdev_ss twice
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200925134229.246169-1-stefanha@redhat.com>
 <20200925134229.246169-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9522a69-c2c0-1e8a-adf7-04ceb6a49232@redhat.com>
Date: Fri, 25 Sep 2020 16:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925134229.246169-3-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 15:42, Stefan Hajnoczi wrote:
> Introduce libblkdev.fa to avoid recompiling blockdev_ss twice.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  meson.build                | 12 ++++++++++--
>  storage-daemon/meson.build |  3 +--
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index eb84b97ebb..18d689b423 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -857,7 +857,6 @@ blockdev_ss.add(files(
>  blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
>  softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
>  
> -softmmu_ss.add_all(blockdev_ss)
>  softmmu_ss.add(files(
>    'bootdevice.c',
>    'dma-helpers.c',
> @@ -952,6 +951,15 @@ block = declare_dependency(link_whole: [libblock],
>                             link_args: '@block.syms',
>                             dependencies: [crypto, io])
>  
> +blockdev_ss = blockdev_ss.apply(config_host, strict: false)
> +libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
> +                             dependencies: blockdev_ss.dependencies(),
> +                             name_suffix: 'fa',
> +                             build_by_default: false)
> +
> +blockdev = declare_dependency(link_whole: [libblockdev],
> +                              dependencies: [block])
> +
>  qmp_ss = qmp_ss.apply(config_host, strict: false)
>  libqmp = static_library('qmp', qmp_ss.sources() + genh,
>                          dependencies: qmp_ss.dependencies(),
> @@ -968,7 +976,7 @@ foreach m : block_mods + softmmu_mods
>                  install_dir: config_host['qemu_moddir'])
>  endforeach
>  
> -softmmu_ss.add(authz, block, chardev, crypto, io, qmp)
> +softmmu_ss.add(authz, blockdev, chardev, crypto, io, qmp)
>  common_ss.add(qom, qemuutil)
>  
>  common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: [softmmu_ss])
> diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
> index 0409acc3f5..c5adce81c3 100644
> --- a/storage-daemon/meson.build
> +++ b/storage-daemon/meson.build
> @@ -1,7 +1,6 @@
>  qsd_ss = ss.source_set()
>  qsd_ss.add(files('qemu-storage-daemon.c'))
> -qsd_ss.add(block, chardev, qmp, qom, qemuutil)
> -qsd_ss.add_all(blockdev_ss)
> +qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
>  
>  subdir('qapi')
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>



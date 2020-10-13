Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7466C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A1123975
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eul3cIW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A1123975
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKS7-00073w-2I
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSKPr-0004KR-H0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSKPn-0001l6-Md
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602595950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJCDN23uhinq4hyqQ/aLd65LLd0Pe4nC/XbwoMDCHh4=;
 b=eul3cIW6V6zdiaX5/NkkKr8QJFWCal5k7wb3MaA8YL4CYjpz+YMnBDhn5s6oOYGwG17pAe
 P9W+3+OXldFS2y17wb+EqCIuzpnmsCgii0e+186aTYm9EjSnZWXh0joBiB4Qm54MTTaCr3
 6w939hcVL5p5diJQ11VJd9IpSjZiD5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-4SKbceRpPBGBCvZWYDWCCA-1; Tue, 13 Oct 2020 09:32:22 -0400
X-MC-Unique: 4SKbceRpPBGBCvZWYDWCCA-1
Received: by mail-wm1-f69.google.com with SMTP id c204so6773719wmd.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AJCDN23uhinq4hyqQ/aLd65LLd0Pe4nC/XbwoMDCHh4=;
 b=NTMS+zK864yGocvZMcuiKyhemt4pBZ27jGohAV0wKL36fontqSso3Nma1g6Ptr420I
 2vdIi/pLJSYS3fRV3hFCamhavpOwrzSAAw6NamfOvemlo5m5v+kRav6AHvZ78b7DHTBt
 FWIE0jOgFgttWrXfAqScneAoNSD5J0/j78Q6WrzTdlUtyYHuVPo2NDFwxBM/eC3gC8Ky
 oxJ/wUtfYD9brL0ACSmQbuMUlDoqv0f4jdLhhM+XRRzV7EioA3qLOYJFnlVvtEaJ/jpm
 VjyEpx+/F1snr733k8vQrrRV7AwQWtgFFZp4/WPc1KEc2/1AivsA8PUTFzBZ/AMyyrjt
 7aAQ==
X-Gm-Message-State: AOAM530Tc2gPhWG+PgwqT6YhQ2LU6wTm3UM/0e1o1IBCbdgSuq7yMhOf
 Jw53/nR+EmlOwFaai+DHsoPn0iOe2XGQrQd7LlsVyAYX0JZmraedbZMBSL+G/P1RfEQbHHUSPWj
 66reacNaAL66tP74=
X-Received: by 2002:a05:6000:1151:: with SMTP id
 d17mr38234443wrx.363.1602595941183; 
 Tue, 13 Oct 2020 06:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvQwnSIdtfWSi40smjU8h/935RGRcKY8qAYMF0l691k1H7P7H93uqmdwZtSbK2Ueg/eCMvag==
X-Received: by 2002:a05:6000:1151:: with SMTP id
 d17mr38234420wrx.363.1602595940961; 
 Tue, 13 Oct 2020 06:32:20 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u15sm28248226wrm.77.2020.10.13.06.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 06:32:20 -0700 (PDT)
Subject: Re: [PATCH 05/10] slirp: update for iOS resolv fix
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-6-j@getutm.app>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c99464f7-6fd7-e81f-9037-50942706fc24@redhat.com>
Date: Tue, 13 Oct 2020 15:32:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012232939.48481-6-j@getutm.app>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/13/20 1:29 AM, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
> 
> We cannot access /etc/resolv.conf on iOS so libslirp is modified to use
> libresolv instead.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   .gitmodules | 2 +-
>   meson.build | 2 ++
>   slirp       | 2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index 2bdeeacef8..f23e859210 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -51,7 +51,7 @@
>   	url = https://git.qemu.org/git/edk2.git
>   [submodule "slirp"]
>   	path = slirp
> -	url = https://git.qemu.org/git/libslirp.git
> +	url = https://github.com/utmapp/libslirp.git

NAck.

You can not take over the SLiRP project submodule that way.

I suggest getting your SLiRP changes merged with mainstream
instead, see:
https://gitlab.freedesktop.org/slirp/libslirp#contributing

>   [submodule "roms/opensbi"]
>   	path = roms/opensbi
>   	url = 	https://git.qemu.org/git/opensbi.git
> diff --git a/meson.build b/meson.build
> index 32cf08619f..da96e296e0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -996,6 +996,8 @@ if have_system
>       slirp_deps = []
>       if targetos == 'windows'
>         slirp_deps = cc.find_library('iphlpapi')
> +    elif targetos == 'darwin'
> +      slirp_deps = cc.find_library('resolv')
>       endif
>       slirp_conf = configuration_data()
>       slirp_conf.set('SLIRP_MAJOR_VERSION', meson.project_version().split('.')[0])
> diff --git a/slirp b/slirp
> index ce94eba204..452c389d82 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
> +Subproject commit 452c389d8288f81ec9d59d983a047d4e54f3194e



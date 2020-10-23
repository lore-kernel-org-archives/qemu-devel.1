Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D5C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C2F20857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUjFMtRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C2F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW09X-00064f-KO
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzKd-0001lj-AY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVzKb-0004RO-3D
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yW40x2/0pHEgK+M951X+hofT7qx/jEbUulZaou/x7ZE=;
 b=YUjFMtRLg/jnoNq/tYfuKTv6K1aZkYaQIbOm37WZkoZ5yv2PtyTUE1YEIkGcLR9eW1Q8bJ
 7FCquAjbTm1l0m8lijbYGZ/q688ZMFy/qpo8DStSbxdHk503BSa9GowyOAuSqLgFd1v71x
 inmwL01NsWBgRt6ahNZG2ZFi3tm2fk0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-iu-W-IVYOfKD2S9VY25-3A-1; Fri, 23 Oct 2020 11:50:13 -0400
X-MC-Unique: iu-W-IVYOfKD2S9VY25-3A-1
Received: by mail-wm1-f69.google.com with SMTP id r19so604407wmh.9
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yW40x2/0pHEgK+M951X+hofT7qx/jEbUulZaou/x7ZE=;
 b=DgfvlUhI6LAspqOV7HMGHGx8oRXjgg3Wvqx0s9YnegJok2t8ZF4uARsZgxGhn9Xsb0
 wMxNzS6iGnPXsU0uaoVL+itqtpG/bSU22BxTOIq1XQhzU845+cl7GzmfoOW68UhXKPlq
 KcYDM3LVVNRQ9moCnALJXWdyTZSvQM4EEUcvrGl51BJ6lQ/MCQSvtxtnuUiejTRh0sdm
 WyDNyF5VkKJKCcP7KCXbBE0TBm3SsgPqweusTnmSiZWVCAHQpZTaDX6su/H0nDKFPb7z
 R2q+A91gYVj4EibTLG8+tw4QghOxNKR9/cl5ON8wXPJ/YEVVL2JQZB0XEnsGR8+UKvRa
 4tEw==
X-Gm-Message-State: AOAM530lfKaszO5lz4v1DtLhapn8/eM41kPvTjyfO6kJbresqPreBG+Y
 nrhIylZN5rCgmAdMc6h2k6zjWAt0odvkEdlhojKW2Oz+nESEpxK7dUKWWwlWV3QKA7c9aHuwdP8
 Y72Pkd7nIJSXZtio=
X-Received: by 2002:a1c:9ed8:: with SMTP id h207mr2912652wme.75.1603468210818; 
 Fri, 23 Oct 2020 08:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrCguJIdEvZ/XIrQYcq1IBq8Aly8cs/g4W+Z47f3ZNYgPtmpqH342sV5iE11vp6arXtjOgAQ==
X-Received: by 2002:a1c:9ed8:: with SMTP id h207mr2912632wme.75.1603468210581; 
 Fri, 23 Oct 2020 08:50:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p4sm3656919wmg.20.2020.10.23.08.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 08:50:09 -0700 (PDT)
Subject: Re: [qemu-web PATCH 7/7] Add a CONTRIBUTING.md file as guidance for
 contributors
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201023152957.488974-1-berrange@redhat.com>
 <20201023152957.488974-8-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8825f53-6f33-3051-6c4c-30dc386cb9ef@redhat.com>
Date: Fri, 23 Oct 2020 17:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023152957.488974-8-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On 23/10/20 17:29, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  CONTRIBUTING.md | 32 ++++++++++++++++++++++++++++++++
>  _config.yml     |  1 +
>  2 files changed, 33 insertions(+)
>  create mode 100644 CONTRIBUTING.md
> 
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> new file mode 100644
> index 0000000..0be58d8
> --- /dev/null
> +++ b/CONTRIBUTING.md
> @@ -0,0 +1,32 @@
> +# Contributing to qemu-web
> +
> +The QEMU project accepts code contributions to the website as patches sent to
> +the the developer mailing list:
> +
> +https://lists.nongnu.org/mailman/listinfo/qemu-devel
> +
> +For further guidance on sending patches consult:
> +
> +https://wiki.qemu.org/Contribute/SubmitAPatch
> +
> +It is expected that contributors check the rendered website before submitting
> +patches. This is possible by either running jekyll locally, or by using the
> +GitLab CI and Pages infrastructure.
> +
> +Any branch that is pushed to a GitLab fork will result in a CI job being run
> +visible at
> +
> +https://gitlab.com/yourusername/libvirt-perl/pipelines

Apart from the pasto, I think it is
https://gitlab.com/yourusername/qemu-web/-/pipelines.

> +The rendered result can be then viewed at
> +
> +https://yourusername.gitlab.io/qemu-web

Very cool, thanks.

Paolo

> +Contributions submitted to the project must be in compliance with the
> +Developer Certificate of Origin Version 1.1. This is documented at:
> +
> +https://developercertificate.org/
> +
> +To indicate compliance, each commit in a series must have a "Signed-off-by"
> +tag with the submitter's name and email address. This can be added by passing
> +the ``-s`` flag to ``git commit`` when creating the patches.
> diff --git a/_config.yml b/_config.yml
> index d0473c1..7d34779 100644
> --- a/_config.yml
> +++ b/_config.yml
> @@ -40,3 +40,4 @@ exclude:
>    - Gemfile.lock
>    - vendor/
>    - README
> +  - CONTRIBUTING.md
> 



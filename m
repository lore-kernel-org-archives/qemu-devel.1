Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C07BC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9526C2467C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ4iNF5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9526C2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhBd-0002yo-7s
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXhAd-0002NG-7X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXhAa-0005Bp-9y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603875057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYQ91VMxT4Ba21psPiLhutxNa9aV21dNN/X7Awt2to0=;
 b=EZ4iNF5w++Xz1eoFtmired+S7p79gPO3WrX2LdLeQmg59egaubq1ZLw25IYzCKx59lUhgS
 yKMxqB2v42gfKQqQt6FiZ/6e57NME48s7rmw/X0cwAxRUfmhQ7FTz+0GQk9mf41MIsWCwq
 jqdEGw+o/j6K42uPN05aP8hbZZ53eWc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-tz2YEcqeOOOigToi34frNw-1; Wed, 28 Oct 2020 04:50:55 -0400
X-MC-Unique: tz2YEcqeOOOigToi34frNw-1
Received: by mail-ej1-f71.google.com with SMTP id d13so1917629ejz.6
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 01:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iYQ91VMxT4Ba21psPiLhutxNa9aV21dNN/X7Awt2to0=;
 b=DrSEi7/dZxRcvE9Vivgqj10CZuAZsdQ5aWn4ytTNesoB9c+T2ueHUe5VMuGw63pAHH
 AoPgRTwQ2w6k7IaLZkRFbrPzc2xHuTclcdru7vLhuQzHMbiAEibfIlwLUxik/h4n3xtS
 XMUar675I51gtdeluIy5u1NFvq+heWvLTAARU5OYNrx8qW5T20WEOj9pToeB8qtvA8Bd
 X4QFpvK1abZymlLgE5Bb9xMJh/fQu9m0waAW5bZp8JMLKKwhawdY6f2SQLUbnAFSVfVw
 nr9foO9geJ90Uqy+A/oMA7WU/kjFSaNYd9ag/98WYBy0VH5lFSSW9IFA0RxsGTweYqR0
 SnFg==
X-Gm-Message-State: AOAM5338mvF87g8yMw2VHhGMXEBKy8E8PW9f1LSXKx6fNrUjQy+G5rfU
 XE+HY4gWol4rPgyImuKU6WlpjF4BNlANWOTcFJIwaxyXfSOx1uEXWo7LtJetpQhJi2Idx1Um4Gr
 ZLr1gtBqESwaTBDs=
X-Received: by 2002:a17:906:3e4b:: with SMTP id
 t11mr6369394eji.420.1603875053860; 
 Wed, 28 Oct 2020 01:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQtzN0Tl6t0+1Ad74NwMdysPVVnBVzYxhFBv0Rm2bdyWIvuP3Ej6F0VA/4r5ezABQtMHs4Gw==
X-Received: by 2002:a17:906:3e4b:: with SMTP id
 t11mr6369377eji.420.1603875053666; 
 Wed, 28 Oct 2020 01:50:53 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z23sm2524854ejj.52.2020.10.28.01.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 01:50:52 -0700 (PDT)
Subject: Re: [PATCH 2/5] python: add excluded dirs to flake8 config
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201027223815.159802-1-jsnow@redhat.com>
 <20201027223815.159802-3-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <da8e8e7f-18cb-7fc1-955f-c3f73d9a3260@redhat.com>
Date: Wed, 28 Oct 2020 09:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027223815.159802-3-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 11:38 PM, John Snow wrote:
> Following patches make obvious that we ought to ignore certain
> directories to avoid wildly erroneous flake8 output.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/setup.cfg | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/python/setup.cfg b/python/setup.cfg
> index cb696291ba38..d0ad683b5148 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -30,6 +30,8 @@ devel =
>  
>  [flake8]
>  extend-ignore = E722  # Prefer pylint's bare-except checks to flake8's
> +exclude = __pycache__,
> +          .venv,

Can we make flake8 aware the files are in a git repository instead?

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  [mypy]
>  strict = True
> 



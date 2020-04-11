Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA99C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 05:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0C02078E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 05:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5QzL3Fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0C02078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN91f-0002t2-Rp
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 01:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jN911-0002SU-Db
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 01:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jN90z-0007cI-Sg
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 01:49:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jN90z-0007bg-Nh
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 01:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586584152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSbWeZHGFb8AvavgwGG6WPziuwKHPEwDKb1W+9wOOhI=;
 b=I5QzL3FjLubpe/6sSmnkUMVHF1/p2JhH5Tb7L7efDKs4DlF+88jJZIH2Tb3jlAwp4nT4l/
 r2nfNFyIdi2kE0yuCV5MPCqt58WxJ4vwlg4wllZAPH0JE1Kd5/xCwNVaVZ94ZGJztPMDGB
 oJde1vbfKzNZ19HFiBJ+6Y9DDcHvUcs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-UvXrPHNNNFuhs-Amanuhyw-1; Sat, 11 Apr 2020 01:49:10 -0400
X-MC-Unique: UvXrPHNNNFuhs-Amanuhyw-1
Received: by mail-wr1-f70.google.com with SMTP id d4so2691441wrq.10
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 22:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PSbWeZHGFb8AvavgwGG6WPziuwKHPEwDKb1W+9wOOhI=;
 b=O6Ys/sTAQ1NlRNHFg2SuFh1vpA0HSKcqay8LeRTRjAsflgFKiZ90FSCfrkG9dgRPez
 VoQVNLgyOKb9GUsWA7J/XJ+p9qEnQJluW3n7WtkHPslnw5TreG+HaxrfMmoYoZiOpDdP
 rteo7mCjZe7zbZBYvwypIXlcFHW64ZCHjpDf4kAhZn7UiSQdRpNE354Jwws1JvGgE/+o
 9z2FsTz/sa4D1sSwr+1pbhPrQpCgZ1ebAqG6+y6lrRHUfBR++Y/lVlxoxvwvWXybAfij
 PwfMOHqevjxhCha/7MkJcQE3RzI1/JG+ejekpdVhPt8LkuM7I4t3BtUXEHl270A0+DGm
 gvZQ==
X-Gm-Message-State: AGi0PubYj60f13OMJsqR2UKn+jklxl5fkzHuNkXkC7tmaQrnP7F8n4kq
 iglW68Qj6gFv1xs94zAKCEOp+gmb0Cz3FFg1BiaH0kfS7xjkYd8bsU2NN8fQOAKR2j//9H34SiP
 VKPZ2vYOjyf80Dxs=
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr8239924wmd.119.1586584149752; 
 Fri, 10 Apr 2020 22:49:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypLs//gzMIrAOeRUFLoJwzMUiWvn4/rBJw4g5FfNB9KSZ0hVIO7DKDe4jPKpHnU+OUvgaEsaFw==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr8239910wmd.119.1586584149519; 
 Fri, 10 Apr 2020 22:49:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c938:f991:b948:b0ca?
 ([2001:b07:6468:f312:c938:f991:b948:b0ca])
 by smtp.gmail.com with ESMTPSA id u16sm5598332wro.23.2020.04.10.22.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 22:49:09 -0700 (PDT)
Subject: Re: [PATCH] module: increase dirs array size by one
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20200411010746.472295-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66713300-eebd-d9a4-62fd-f355e6ca4e07@redhat.com>
Date: Sat, 11 Apr 2020 07:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200411010746.472295-1-brogers@suse.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: berrange@redhat.com, christian.ehrhardt@canonical.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/04/20 03:07, Bruce Rogers wrote:
> With the module upgrades code change, the statically sized dirs array
> can now overflow. Increase it's size by one, according to the new
> maximum possible usage.
> 
> Fixes: bd83c861c0 ("modules: load modules from versioned /var/run dir")
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  util/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/module.c b/util/module.c
> index 5f7896870a..e48d9aacc0 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -177,7 +177,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
>      char *version_dir;
>  #endif
>      const char *search_dir;
> -    char *dirs[4];
> +    char *dirs[5];
>      char *module_name;
>      int i = 0, n_dirs = 0;
>      int ret;
> 

Queued, thanks.

Paolo



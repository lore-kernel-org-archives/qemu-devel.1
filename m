Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24367C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE348208CA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI1oqnZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE348208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCz3Z-0005cV-UC
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 01:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCz2r-00053a-DS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 01:41:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCz2o-0005G8-My
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 01:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598938881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYlsWrzS2kGQZya8FtD/Y/cxGtKRBvdXYfzLOXngaXE=;
 b=XI1oqnZIZnwuAH/Fr6pbRLlJGUh9bsqzjG+rUWF3dqFK8Sg8FicfSdTPvtQjis0ajltnX/
 RJ/Z8fmWDtRMkZVQizhJdcdbYaQKE+gKVxKaP/Z4MXSAj7U6W41nxuRMWFUXXS6BJUdXas
 i7CwtrWWkpW6w9YXBSTbwGmJLg9CuXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-ekGLYQDjMgO-LRXfz6rcDg-1; Tue, 01 Sep 2020 01:41:19 -0400
X-MC-Unique: ekGLYQDjMgO-LRXfz6rcDg-1
Received: by mail-wm1-f69.google.com with SMTP id c186so47277wmd.9
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 22:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RYlsWrzS2kGQZya8FtD/Y/cxGtKRBvdXYfzLOXngaXE=;
 b=E3RDWe5FgHqdCcADRWHNjxRvpau65ZucZ+0e3+e+rCue3biq1RuRd+cFyYWLG5KFIR
 En4eK2+h3+6zzO/FYx87WDWEQ0ZRyrXsq5GbWfwXFnemakhrT4IHuYNPWMfxDxtqXkg9
 9IU63jc1J18tST2f/BrnGJfEA0WLTpj5Tq9cRAFOR+UiawFBy66/y9YxCtIagn0a7hfG
 HlciAYbrPTxJRgKDO5wK2xroZwq1KHpSZzrulM3suVWYZi11RdM9ZW9nS/iUlT7F0o9Y
 WC+EuPlrL/nMM2KAtgd56BhsX/DZAm6cR4Ze2b3xuAI9cmdY1AK2JstNn5soibJfsYp1
 /IJQ==
X-Gm-Message-State: AOAM532lDZEsIjAoHulzkBMrj3xzoA1y/GfSYDRHGaNnQEs2kRrnImPf
 MQ0Dkja3LzK29Tru8QYYwEsr1zp4aWB2TRX75trRR7BLvvkplhTpijsm+BzwcDuNGxx9MpsG4Vs
 gaKo1umczLhd397A=
X-Received: by 2002:adf:8544:: with SMTP id 62mr4673400wrh.262.1598938877969; 
 Mon, 31 Aug 2020 22:41:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTCnvXqwWmX2FwR9yeSzqZnsOo/bl3Mk2caZAmttvGHcFg5xyiQM3lTiRaV3wPAzucyTUAzw==
X-Received: by 2002:adf:8544:: with SMTP id 62mr4673370wrh.262.1598938877623; 
 Mon, 31 Aug 2020 22:41:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a2d9:71bf:36d7:4ea8?
 ([2001:b07:6468:f312:a2d9:71bf:36d7:4ea8])
 by smtp.gmail.com with ESMTPSA id q12sm345514wrn.94.2020.08.31.22.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 22:41:17 -0700 (PDT)
Subject: Re: [PATCH] docs/system: Fix grammar in documentation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Stefan Weil <sw@weilnetz.de>
References: <20200827173051.31050-1-sw@weilnetz.de>
 <CAAdtpL508gaCmuencEu31H0bcQorUhywUXGkD-3ZukafjsdLzw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2857607d-30ff-6d31-c57b-f2b009ca8ae8@redhat.com>
Date: Tue, 1 Sep 2020 07:41:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL508gaCmuencEu31H0bcQorUhywUXGkD-3ZukafjsdLzw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/08/20 22:01, Philippe Mathieu-Daudé wrote:
> 
> 
> Le jeu. 27 août 2020 19:31, Stefan Weil <sw@weilnetz.de
> <mailto:sw@weilnetz.de>> a écrit :
> 
>     Signed-off-by: Stefan Weil <sw@weilnetz.de <mailto:sw@weilnetz.de>>
> 
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>>
> 
>     ---
>      docs/system/build-platforms.rst | 6 +++---
>      1 file changed, 3 insertions(+), 3 deletions(-)
> 
>     diff --git a/docs/system/build-platforms.rst
>     b/docs/system/build-platforms.rst
>     index c2b92a9698..9734eba2f1 100644
>     --- a/docs/system/build-platforms.rst
>     +++ b/docs/system/build-platforms.rst
>     @@ -57,12 +57,12 @@ macOS
>      -----
> 
>      The project supports building with the two most recent versions of
>     -macOS, with the current homebrew package set available.
>     +macOS, with the current Homebrew package set available.
> 
>      FreeBSD
>      -------
> 
>     -The project aims to support the all the versions which are not end of
>     +The project aims to support all versions which are not end of
>      life.
> 
>      NetBSD
>     @@ -75,5 +75,5 @@ new major version is released.
>      OpenBSD
>      -------
> 
>     -The project aims to support the all the versions which are not end of
>     +The project aims to support all versions which are not end of
>      life.
>     -- 
>     2.28.0
> 
> 

Cc: qemu-trivial@nongnu.org



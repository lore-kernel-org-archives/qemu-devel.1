Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58AAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCDD20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+Nyc3oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCDD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmTd-0000oR-LM
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmSu-00088u-9i
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:46:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40808
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmSt-0002NM-Fx
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590072390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYv+poDrf1h7mPzZ/QRG4x8C2aVeFJaiE4uJsceECEw=;
 b=a+Nyc3oRTmF4nPCQIWveTja5hcVswashqLwOR0slj/r2dQ3oo+lQ+PEPzKq219WlnL/rLM
 DzkX0blnkbg8ruW+aGEXI+naV5fbJKxk8DLXX8ZbxXlDnaSy2TqYHXp9jLFWiaTvFCEkbj
 IcFwI8AOmjT17ztMZNES1iIRiNDnmeA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-o_qhuEQyNWCqovspUB8umg-1; Thu, 21 May 2020 10:46:29 -0400
X-MC-Unique: o_qhuEQyNWCqovspUB8umg-1
Received: by mail-wm1-f72.google.com with SMTP id t62so2773032wmt.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KYv+poDrf1h7mPzZ/QRG4x8C2aVeFJaiE4uJsceECEw=;
 b=uDKec2IHnkLHw50P7f+aBIm8TD5oI1hBqhoXlOYB4bedHYBuJCuBOzNIy56ihzvJAK
 dIKFjX2EHbKUGJPwbnZNGabnolCg8crasIs7EiG/lqa5rNnB2NqraouB4Ex9qtoyWvEH
 HfDtSYKTnZ/MKgMdbuSe8F/xj02aMwq3rwJd2L9ECo2JqJGjuvQtANFMpW8ve+CvazR+
 K4QlsYYxnbmkxraZbvmzOie+faFpZSnmX1CatSW9HfxFCdZkmaua/iTXdJn7gStxFhsC
 Ckj6MkjFC5q4OV0CPbXSLBt2rtej/afLZ9/CyMzIC9Q9NTHSofd0qLJ/h0LUKjh6DNnN
 8NQA==
X-Gm-Message-State: AOAM533845YQl1q2x+HFTwkjnWHgpH9Q1YVsDiBNclOcETQ/nLsdG9Y6
 xUeaiq/aJpHckRFuZLsxk2XXmIbDAdkHWrkRnAITm/6zwy5VLaVvg0dhRqqjDRRpzRtZI3HNWg4
 XqD40YjLOTHF8E+E=
X-Received: by 2002:adf:eec2:: with SMTP id a2mr1819596wrp.136.1590072388065; 
 Thu, 21 May 2020 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Zl487ugCFKdOA06ctsZjREw/c9Cmm36o/iuuUOg//QslzuOHDnxkjIjDxH8dsSvwLxUuMg==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr1819584wrp.136.1590072387885; 
 Thu, 21 May 2020 07:46:27 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id y3sm6539196wrm.64.2020.05.21.07.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:46:27 -0700 (PDT)
Subject: Re: [PATCH] qom/object: pass (Object *) to
 object_initialize_with_type()
To: Masahiro Yamada <masahiroy@kernel.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200512173104.2293073-1-masahiroy@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae82206c-e147-1448-ea91-0517c1157bf1@redhat.com>
Date: Thu, 21 May 2020 16:46:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512173104.2293073-1-masahiroy@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 12/05/20 19:31, Masahiro Yamada wrote:
> object_new_with_type() already passes (Object *) pointer.
> Avoid casting back and forth.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  qom/object.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index e4085d8ae2..9d1a918e42 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -495,10 +495,8 @@ static void object_class_property_init_all(Object *obj)
>      }
>  }
>  
> -static void object_initialize_with_type(void *data, size_t size, TypeImpl *type)
> +static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
>  {
> -    Object *obj = data;
> -
>      type_initialize(type);
>  
>      g_assert(type->instance_size >= sizeof(Object));
> 

Queued, thanks.

Paolo



Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44686C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120B520671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+W+TLGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120B520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnkt-0007S6-9q
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbngw-0000jo-Ht
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:05:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbngu-0005Wo-WE
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590077103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LejXcK3xRwyW++iBZ1Aq6UPFnnrZH9y4yUsjWAUwyc=;
 b=g+W+TLGjpPg/Lq8GfiKlzxqtURNlkmXnx2LanR7IxZfGxO3W52v/5R7iFTMiKPzRL3UbYj
 JzIltR8au2G0pfug+TvECT0o9hSnVfgV9HIViqxpLDtq2M7uoi5ZoKcB6pDGJ6aluJUy9F
 3dlRSf0QSweG/nnkRckLXCmgjVrnEHc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-DiUF9NGzNU2W5Sjxm20kZw-1; Thu, 21 May 2020 12:04:57 -0400
X-MC-Unique: DiUF9NGzNU2W5Sjxm20kZw-1
Received: by mail-wm1-f72.google.com with SMTP id p24so2846036wmc.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9LejXcK3xRwyW++iBZ1Aq6UPFnnrZH9y4yUsjWAUwyc=;
 b=rbUkv9RQpS2fdA+yNRNp7RSihvyaNxkpg/XXna4Ib50W8jRxFyW2MR3mcRpzOLBs4U
 G1DOejW63EBOULgQdaOo1nUVGCsTAdYX/ZLCmjcWrQ09iTFqyCGESXtIp26mlTkKZWC/
 LxBwPDPDCBMO1lYKHvhRgv3EhT4ez1RNrevN4qR+Mw5xA71lzfLG2Y/YCXZwKU75jOow
 UbgPOlUZ+VpL0qNUAHN7hwyVRvRgIlMD9YchzypFH6lSpCUn1ctYr9z1BuPTyrYDKejn
 yL+KTJnOWlgEYrc/w+ewLo4RkE3cCpu046vqVYHOkHt1pxNKBbmEhchLPBSCfJcX5apq
 gGEQ==
X-Gm-Message-State: AOAM533jzWpXWiRgnxTAPK9/dAnCOY/6ZbED9hxwNUygW0VGumK9IakT
 x1YY/bKGDxzODmvz5oF1KI1ASvFipTm0RSISuB3MvAxmnf/O1t964KqHPOSFOt42LDk+DUIDrPs
 uud8Pb174A/n9xHU=
X-Received: by 2002:a1c:e903:: with SMTP id q3mr9199017wmc.76.1590077095967;
 Thu, 21 May 2020 09:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpntpE5Eoq+ZHMXVvNwt41hBDGRQovAOBy2ryWD/usxMj4Ne3R2SH5gC1FxxDldg4rx9NOTQ==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr9198997wmc.76.1590077095718;
 Thu, 21 May 2020 09:04:55 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id k13sm6676895wmj.40.2020.05.21.09.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 09:04:55 -0700 (PDT)
Subject: Re: [PATCH 1/1] target/i386: fix phadd* with identical destination
 and source register
To: Janne Grunau <j@jannau.net>, qemu-devel@nongnu.org
References: <20200401225253.30745-1-j@jannau.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa08c8d6-c243-c0db-42c8-72bc6c69ef10@redhat.com>
Date: Thu, 21 May 2020 18:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401225253.30745-1-j@jannau.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/20 00:52, Janne Grunau wrote:
> Detected by asm test suite failures in dav1d
> (https://code.videolan.org/videolan/dav1d). Can be reproduced by
> `qemu-x86_64 -cpu core2duo ./tests/checkasm --test=mc_8bpc 1659890620`.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  target/i386/ops_sse.h | 53 +++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
> index ec1ec745d0..2f41511aef 100644
> --- a/target/i386/ops_sse.h
> +++ b/target/i386/ops_sse.h
> @@ -1435,34 +1435,47 @@ void glue(helper_pshufb, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
>  
>  void glue(helper_phaddw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
>  {
> -    d->W(0) = (int16_t)d->W(0) + (int16_t)d->W(1);
> -    d->W(1) = (int16_t)d->W(2) + (int16_t)d->W(3);
> -    XMM_ONLY(d->W(2) = (int16_t)d->W(4) + (int16_t)d->W(5));
> -    XMM_ONLY(d->W(3) = (int16_t)d->W(6) + (int16_t)d->W(7));
> -    d->W((2 << SHIFT) + 0) = (int16_t)s->W(0) + (int16_t)s->W(1);
> -    d->W((2 << SHIFT) + 1) = (int16_t)s->W(2) + (int16_t)s->W(3);
> -    XMM_ONLY(d->W(6) = (int16_t)s->W(4) + (int16_t)s->W(5));
> -    XMM_ONLY(d->W(7) = (int16_t)s->W(6) + (int16_t)s->W(7));
> +
> +    Reg r;
> +
> +    r.W(0) = (int16_t)d->W(0) + (int16_t)d->W(1);
> +    r.W(1) = (int16_t)d->W(2) + (int16_t)d->W(3);
> +    XMM_ONLY(r.W(2) = (int16_t)d->W(4) + (int16_t)d->W(5));
> +    XMM_ONLY(r.W(3) = (int16_t)d->W(6) + (int16_t)d->W(7));
> +    r.W((2 << SHIFT) + 0) = (int16_t)s->W(0) + (int16_t)s->W(1);
> +    r.W((2 << SHIFT) + 1) = (int16_t)s->W(2) + (int16_t)s->W(3);
> +    XMM_ONLY(r.W(6) = (int16_t)s->W(4) + (int16_t)s->W(5));
> +    XMM_ONLY(r.W(7) = (int16_t)s->W(6) + (int16_t)s->W(7));
> +
> +    *d = r;
>  }
>  
>  void glue(helper_phaddd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
>  {
> -    d->L(0) = (int32_t)d->L(0) + (int32_t)d->L(1);
> -    XMM_ONLY(d->L(1) = (int32_t)d->L(2) + (int32_t)d->L(3));
> -    d->L((1 << SHIFT) + 0) = (int32_t)s->L(0) + (int32_t)s->L(1);
> -    XMM_ONLY(d->L(3) = (int32_t)s->L(2) + (int32_t)s->L(3));
> +    Reg r;
> +
> +    r.L(0) = (int32_t)d->L(0) + (int32_t)d->L(1);
> +    XMM_ONLY(r.L(1) = (int32_t)d->L(2) + (int32_t)d->L(3));
> +    r.L((1 << SHIFT) + 0) = (int32_t)s->L(0) + (int32_t)s->L(1);
> +    XMM_ONLY(r.L(3) = (int32_t)s->L(2) + (int32_t)s->L(3));
> +
> +    *d = r;
>  }
>  
>  void glue(helper_phaddsw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
>  {
> -    d->W(0) = satsw((int16_t)d->W(0) + (int16_t)d->W(1));
> -    d->W(1) = satsw((int16_t)d->W(2) + (int16_t)d->W(3));
> -    XMM_ONLY(d->W(2) = satsw((int16_t)d->W(4) + (int16_t)d->W(5)));
> -    XMM_ONLY(d->W(3) = satsw((int16_t)d->W(6) + (int16_t)d->W(7)));
> -    d->W((2 << SHIFT) + 0) = satsw((int16_t)s->W(0) + (int16_t)s->W(1));
> -    d->W((2 << SHIFT) + 1) = satsw((int16_t)s->W(2) + (int16_t)s->W(3));
> -    XMM_ONLY(d->W(6) = satsw((int16_t)s->W(4) + (int16_t)s->W(5)));
> -    XMM_ONLY(d->W(7) = satsw((int16_t)s->W(6) + (int16_t)s->W(7)));
> +    Reg r;
> +
> +    r.W(0) = satsw((int16_t)d->W(0) + (int16_t)d->W(1));
> +    r.W(1) = satsw((int16_t)d->W(2) + (int16_t)d->W(3));
> +    XMM_ONLY(r.W(2) = satsw((int16_t)d->W(4) + (int16_t)d->W(5)));
> +    XMM_ONLY(r.W(3) = satsw((int16_t)d->W(6) + (int16_t)d->W(7)));
> +    r.W((2 << SHIFT) + 0) = satsw((int16_t)s->W(0) + (int16_t)s->W(1));
> +    r.W((2 << SHIFT) + 1) = satsw((int16_t)s->W(2) + (int16_t)s->W(3));
> +    XMM_ONLY(r.W(6) = satsw((int16_t)s->W(4) + (int16_t)s->W(5)));
> +    XMM_ONLY(r.W(7) = satsw((int16_t)s->W(6) + (int16_t)s->W(7)));
> +
> +    *d = r;
>  }
>  
>  void glue(helper_pmaddubsw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
> 

Queued, thanks.

Paolo



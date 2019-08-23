Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C788C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576E421726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACo3obDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576E421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Bjs-0005Io-IX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BY8-0001LZ-B3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BY6-0004HN-Bq
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:32:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1BY6-0004Gs-4Q
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:32:22 -0400
Received: by mail-pg1-x544.google.com with SMTP id o13so5956300pgp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a3oNgLFWQ1zaQh9erv/yNG+nb+vzzsxhIMMpFZfOJO4=;
 b=ACo3obDR8gEiUshu7kLxDf5KbOPxRpaBNdgqVfF7LefgmKCJ53uWpzls6lJu89ncSr
 zUF0fduvEj9CK+sPb/fB+yWXP+hA+a7J5SzDRv1FqJ39i7UPBu9gjpIswxfipAIcuBTY
 m+j+XhU29IjQ5UVENOUQ5n86zS/NYgpACkqqSFaZT40Y4qMNw++ejNLaE8jc1gDJrEcp
 dljaSEXbfQEgFdCVAwuM1ri0F1s+UD8DRtxEGjDYCEosdll5Ewhd9qRO2W/+EmtinKJD
 3lwwVrorKGwHImGjFX//v0e1Go6B5DowqruPrh6pHgdIXgW5+OrDAzabWfJTr/ZSYxyD
 KW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a3oNgLFWQ1zaQh9erv/yNG+nb+vzzsxhIMMpFZfOJO4=;
 b=R4mZzNrMn4jsSNxOR3qv8cjF6f2+kWwS0VXIxraUaX5C+T/31RaOCvjTs+TlS2sUMw
 awrGl7oxaIUZa1CJvfXN3VhcFNAau0kGj7GMsqEBsL5/PJLIV8pkL+i23JTMOCoKPTZg
 GP6L5PSeR27hoWGuyb4miZIOHGZDma7m+HckgjeGGwR9JUBZor2Fxl6khOi2oWEyCbsX
 NMBM/nftOo0Q61IxZMFeOe5rCx/tVdGnRZVF7fZ55Sb01iV8hgI/qKRgnO18mBsBrdRu
 0MJfpO4/SztByKQdfASJSo+VGUdCYy3DRTebkGtgLCkpOAMXdfhp0tr4iyQvnbOmFm2f
 uH+g==
X-Gm-Message-State: APjAAAW/W9hSimHsOtxbTMtaBtXewgMju47gGU7wv9bNBDEstMfkxk8M
 i/YMUBEWiOx+LM2as0IiAqsWtQ==
X-Google-Smtp-Source: APXvYqzfPdMCq5QWrlaLxhjjhLC5evgpk6bdbnmLz+Wn0Bp+p7AGaMAwJmlDqP7zsxxpHzBNVor8nQ==
X-Received: by 2002:a17:90a:1ae1:: with SMTP id
 p88mr5721762pjp.26.1566574341091; 
 Fri, 23 Aug 2019 08:32:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f72sm2917154pjg.10.2019.08.23.08.32.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 08:32:20 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <00ba15da-9838-b732-f65b-ce52cb54afd1@linaro.org>
Date: Fri, 23 Aug 2019 08:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v1 7/9] s390x/tcg: Pass a size to
 probe_write() in do_csst()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> ... and also call it for CONFIG_USER_ONLY. This function probably will
> also need some refactoring in regards to probing, however, we'll have to
> come back to that later, once cleaning up the other mem helpers.
> 
> The alignment check always makes sure that the write access falls into a
> single page.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



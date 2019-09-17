Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C7C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01D02171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXK3sFtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01D02171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52189 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJxE-0005IO-QI
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJwG-0004eF-NE
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJwE-0005F0-P1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:19:04 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJwE-0005Dr-8Y
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:19:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id x15so2581134pgg.8
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J3C4ZYCQM7bd98OD10S0QvCkrusS7rDFr2KIe/5+Nt8=;
 b=mXK3sFtJXAnTWKCvhxA9Je4WphAXoUXmvLBRKzw9VGCE6DMIKXjvCxSWyjqwywHCr3
 fumqklnkaWdtvGeKlC3RdJeGlKj18RLkNb31TB0Dkqi2GkoXut12l0hrXZvcU7GpG5QP
 +0EcXfMpe6pPovxjcnB/8MXiLWiWNCPAVnDpz9uiUsK0/c/4KeOyG5ASIgrI+Ikxabn8
 TRqD74BkBKFByw47vRY3qQgHJjPcNzjjiNPH1KDSgnTG5FpieEipvCD734ikBODqNrOM
 PBDjrN/Ev5d0lFFHtPuWNAzwaM+d73H9A4EXmlLtqg4t8KBSOF+Bs5NlxnlL9N8cHFNd
 3T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J3C4ZYCQM7bd98OD10S0QvCkrusS7rDFr2KIe/5+Nt8=;
 b=jD6gmVlCTNMGOiAbFrbs7+4LLpWXlpaG2QfvBkbiU1gz+Mia/7S+Z71YwdoxTruuq8
 XvLt3kkq9/A2QttCXND//2z9RxzHEgpI4iokCGVT47mAH8SV/lqEBD4WO1eEhshckYJ7
 WS2I85Ka9Gx9H1yCJMZhP8OMmG6fwmxsj7kSOeSjMH3uK21YdrzvVJAhR6AE8CvJdLbh
 79+tHaAfK3ND/tLoDM7lkfM6M1FOopNr2t6rRSXF+kOZv9IUVcl/k5u0GyHUWxsExd1c
 7nlLZWPnDBsa8yRKvlRnmC3SVrgiDdPpv/HLdhibTf1lxwZp5lCCHpgLlBYDbFeFtkyj
 g/gg==
X-Gm-Message-State: APjAAAWpfLqfacCa38kHkUxwZf3FdO43kZtRFEH5eieIhzmOoeJ00XQp
 ka6Jb7Az1cMuENoO7g/kcqctog==
X-Google-Smtp-Source: APXvYqyo7UW4KGU/30RuTIrKB1072fZz51/MDUvas7IlilkRl210qOf+JkvJ8/yxjTdvcZ+YiguZ1g==
X-Received: by 2002:a62:4d41:: with SMTP id a62mr152489pfb.155.1568751540759; 
 Tue, 17 Sep 2019 13:19:00 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u11sm3764587pfm.113.2019.09.17.13.18.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:18:59 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <889922de-5beb-2317-301c-c761619980de@linaro.org>
Date: Tue, 17 Sep 2019 13:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v3 17/29] s390x/tcg: Fault-safe memmove
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 9:57 AM, David Hildenbrand wrote:
> Replace fast_memmove() variants by access_memmove() variants, that
> first try to probe access to all affected pages (maximum is two pages).
> 
> Introduce access_get_byte()/access_set_byte(). We might be able to speed
> up memmove in special cases even further (do single-byte access, use
> memmove() for remaining bytes in page), however, we'll skip that for now.
> 
> In MVCOS, simply always call access_memmove_as() and drop the TODO
> about LAP. LAP is already handled in the MMU.
> 
> Get rid of adj_len_to_page(), which is now unused.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 232 ++++++++++++++++++++++----------------
>  1 file changed, 133 insertions(+), 99 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


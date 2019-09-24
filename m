Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB0FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D51207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0MDwwRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D51207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoNp-0008DX-3S
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCngG-0000fj-3j
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCngD-0005hi-J9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:28:47 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCngB-0005eh-KQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:28:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id q5so1656741pfg.13
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6+EHufdxTefcW7FuNfEcjmSx0/t+YRSf/WWM/SjDXIE=;
 b=D0MDwwRF06bX+WcIrd0KK13yMEdrHt5cdTw22MiQZ773uLraKCld03XZMi5yeHzDNr
 Su75T/kys7aGGwM3z5IfebBSks1pUk0drDLisqlA5ISuEYiESs+vm6WVU9/lpKK6d4Yc
 6KuOi1YbZG7viXbr7H6rbUh4RM4F5vwFjaRsHvAoE+c0Vfw6ZAmLZ9IRIw+jb4su0gqP
 uEOVfKG0HQZMt4SEHwjG2iir6LVgL0PJkEVqNNKjZ5kLpPUDhN+YsPHPDj22l/vLh7qg
 Uc4Duv4xukp9vm9r/T+qXUGjU6L5rwi/QUdlJKa1UgVFWdWETvyGXftePRGJuzAY7AIT
 cwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6+EHufdxTefcW7FuNfEcjmSx0/t+YRSf/WWM/SjDXIE=;
 b=tU1E09qjl5V6Cxm/xFCcocOAyOK4MW2LmF3rCsFGicqD3MPYjiMEtRjD128OJUV2Gh
 D/477H8Ml7reoYlHMv6GDdLf21DKCDLFEOAB6EZeTpzfsjGYZc6KB2DNV2aEUCPNG6y8
 gEQqtZSKoyLCvcnuhX1tNMs40tgQZ/cypmqk6STEW+0VlmdWzuTV4FjeUYRnv9kY7IUO
 8wSMCFiW4MuobPEVX4ncwL2Pa7C97m6kAbqbetRRuvMoeyj/GoZPNzmNo7HQCA5hcs9C
 0J3kuufjafryVqQ6rHkBTZB6p2wj/mdanSYkYiUYajMkBebt9oPWK47R2TMQcGi9ycx3
 ofPg==
X-Gm-Message-State: APjAAAWVzt0pfrA3g7XApkHmnkK5YFhSK+D7Tj/PXmpwjohBWasVrYb/
 ejK/v9B5GgmRfuaeFwp+o04pew==
X-Google-Smtp-Source: APXvYqzm+QFqo9m79tHvAxAtLcdEI07St974YYyVLDnNoD33jVRQ/fF4gvvRTU1155/j4tUZkuXlaw==
X-Received: by 2002:a62:53c7:: with SMTP id h190mr4321963pfb.208.1569342519829; 
 Tue, 24 Sep 2019 09:28:39 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id a11sm3596797pfg.94.2019.09.24.09.28.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 09:28:38 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 2/4] Memory: Enable writeback for given
 memory region
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-3-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d8ca7a99-ca3d-00b8-f34c-82375ecb7c4d@linaro.org>
Date: Tue, 24 Sep 2019 09:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910095610.4546-3-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 2:56 AM, Beata Michalska wrote:
> +int main(void) {
> +#if defined(_POSIX_MAPPED_FILES) && _POSIX_MAPPED_FILES > 0 \
> +&& defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
> +return msync(NULL,0, MS_SYNC);
> +#else
> +#error Not supported
> +#endif
> +}

Is there any particular reason to check _POSIX_MAPPED_FILES &
_POSIX_SYNCHRONIZED_IO?  IIRC, you can use those to "safely" use MS_SYNC.  But
this is a configure test, and an error is in fact our defined failure case, so
"safely" doesn't seem particularly relevant.

Alternately, do we even support any systems (besides perhaps windows) that do
not provide POSIX-2001 support, and so include msync + MS_SYNC?  My first guess
is that we don't.

> +        msync((void *)((uintptr_t)addr & qemu_host_page_mask),
> +               HOST_PAGE_ALIGN(length), MS_SYNC);

This isn't quite right.  If you move addr down to a lower address via this page
mask, you must also increase length by the same amount, and only afterward
increase length to the host page size.

Consider addr == 0xffffff, length = 2.  This covers two pages, so you'd expect
the final parameters to be, for 4k page size, 0xfff000, 0x2000.


r~


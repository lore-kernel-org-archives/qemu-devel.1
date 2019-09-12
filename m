Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C29C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6662084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ff/m/VBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6662084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8TJT-0007NS-At
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8TIh-0006v2-6t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8TIg-0001pt-BU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:54:35 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:40850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8TIg-0001pY-6e
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:54:34 -0400
Received: by mail-qk1-x72f.google.com with SMTP id y144so17317595qkb.7
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WQTGkEgR35o6ko8DSsYlQ0c+2OKkFI4J4Ra4tM7V1fA=;
 b=ff/m/VBztshtNRSsbmCpifBnk0odH9wXzMTzkIO0h+aizOgciuGh7pvW57tkDkek+Q
 /zSzM2g+zrfsLZgD+LxJyOwJFaxLLlhKUgEyW0X+UZ0pKWEKfN2ANiQ326hUjhafJUkK
 0eFcnsiGHcDKn1K8hmskJSN/T1wMOGTb/SzrunFC+pvao5PqiryhGRkHiSslsjOgqS7M
 7GQDe3m3C5PI3DptNTLQbarkrG+xE1f8RTG7Nic/6ZwJHTIVATe7Y5OxALuPLctNHanT
 817pP6HXtWb4bjGtwdQ7RKYj9b1URFHwBKJHVCgZg7+cGYRtXdBRrFRJx4gKqdqWuEf9
 YsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQTGkEgR35o6ko8DSsYlQ0c+2OKkFI4J4Ra4tM7V1fA=;
 b=AlfKjShtM76ZAMf2sVkQlUEnbLVi8VCPst0N/8ZksA7WLBYAyAd28JV8kAUKonHv6/
 50fXyaCWAe+gb1H6cY5mB9JZh8D9zX6VIyXIYZbPREGJPby/7HnkK2IjQYwhY+jljYO7
 5hu96QEek4Bur5VJ43XbfwOoJR6neCpAxmp6cb3f28PbWmvulsMpxcjbpT+EN0+hbnto
 +Fo0gghEMEVt/no7NoBq1YN7rM6tELgVy+pfFV4hl+FQWXoAIoOTNewaHhLfCw+gxiJL
 skDOZjQfY73ohoubVZORVnbAQVSDq2mbLqr64SmK+F4DzOtm9dSAdtC3wL7LrZhs/HRs
 x8iQ==
X-Gm-Message-State: APjAAAXUOTwnzcQ+wCb+dBQAXBw26u/zzsEy6/SIiSTUu6/KHUdvlGOg
 9ForLplbkC7dzO/XrLtkHU0Zyw==
X-Google-Smtp-Source: APXvYqzn0AcoJx0pGyN0rYWKkQPzQ1WtjdoDB3EsrtP4G/B9mHmkGEYLCusPDYmy4XtaZqENSsNHDA==
X-Received: by 2002:a37:a946:: with SMTP id s67mr43403440qke.470.1568310873481; 
 Thu, 12 Sep 2019 10:54:33 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id a3sm12554854qta.68.2019.09.12.10.54.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 10:54:32 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190912141853.31057-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0204b897-b286-ffb2-54e6-f068b34366ba@linaro.org>
Date: Thu, 12 Sep 2019 13:54:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912141853.31057-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72f
Subject: Re: [Qemu-devel] [PATCH v2] memory: inline and optimize devend_memop
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 10:18 AM, Paolo Bonzini wrote:
> -MemOp devend_memop(enum device_endian end);
> +static inline MemOp devend_memop(enum device_endian end)

Ah ha, yes of course, the static inline.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~




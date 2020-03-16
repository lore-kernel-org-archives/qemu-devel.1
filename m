Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C626C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560A720753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rzr1XnXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560A720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvKe-00081e-F3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuvE-000474-Jj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuvD-0003my-HL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:57:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuvC-0003d1-SZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:57:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id d9so8406600plo.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j1sC+lNIFsKn3Cq5U7jHOz8e7n9eiTLX59JudzPIyOU=;
 b=Rzr1XnXjKQlpR0mhkTwKRrurdw5NhB/KiMC8gFr3f6OPwo4trkT978nXKP0rmHUvWv
 euFJv1AfdTFr5vOvg5g7bX6jX9/ZuFPCBhfuBa/9vdhQQ9D9JaeuuoY3FWFmp0QgT/qj
 SOxQxlIFptIGwSXaoc2zWxFJUCk3MKV8wYjgbT5O9CPNihs8H1Z/LhsNlGlcMKnXh3AZ
 OKybcIRTtOVTzRUX2C8BjvtLhdgsG6esDECqpy/zGAW4UiemIThOHzA0YBmtW48mWSvg
 +URARYkLH4nNITZCxlspTLQOZ03I+XvVsOM+jM6NMn8g4ITeYB3s/a6r94K0qfOeAEe0
 uv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j1sC+lNIFsKn3Cq5U7jHOz8e7n9eiTLX59JudzPIyOU=;
 b=tg1Us4rRRvpDXxeHjW02Z4sjXk+CjdvQGLWKcbAlPiQKclwB+zdHehdsqWNZrqP3XM
 7h/mPI6fk9Yijgy6Gq8C1va5k74m631EujCwuSK9yp/QtZUXn2RzTZNvGDPY8JP76Rr3
 f1FOlPrpN2EaaQ7HT7I3g3bsU9oIrWb8+BxYfau/2oy3wfXkRbQ7JhOz6k1VTFpB+2kZ
 XDsFzLddzTiDne6Dy/W5k5TlRt7Ve59UlUcLBJUGCr73xgjwcJjViC5+SJ/DR7pqePad
 vrzmEkO/4YfNZf3TbURsV6iiBQkIqzl65Eel1mboNGe1epJ+sZWo4Bftc6RqlzWXphlv
 7Ofg==
X-Gm-Message-State: ANhLgQ1liWJ58PKzfscLEK6VhplPFpgrKeU367Y9julmXuiBA1xhDbVw
 toc6y/gH7pc49sVvu0u9/OaJzA==
X-Google-Smtp-Source: ADFU+vscxB5GwRBCLCk4FIKwjmo3R2TCFIKQXTPhGuFiqt0FRxLIb8FuexYRa6oaJupiOW6gdiw9xA==
X-Received: by 2002:a17:902:7886:: with SMTP id
 q6mr536847pll.237.1584385025843; 
 Mon, 16 Mar 2020 11:57:05 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i21sm274755pgn.5.2020.03.16.11.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:57:05 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] Makefile: Only build virtiofsd if system-mode is
 enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200315235716.28448-1-philmd@redhat.com>
 <20200315235716.28448-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b999f172-b616-5bec-e88f-725983057bf1@linaro.org>
Date: Mon, 16 Mar 2020 11:57:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315235716.28448-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 4:57 PM, Philippe Mathieu-Daudé wrote:
> Do not build the virtiofsd helper when configured with
> --disable-system.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Use single line with ifeq='yyyy' (lvivier, rth)
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



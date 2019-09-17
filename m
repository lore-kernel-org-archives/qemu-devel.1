Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2162C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9D9214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7TnO9up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9D9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJbG-0002w2-OR
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJaK-0002RH-08
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJaI-0001CY-Qj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:56:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJaI-0001C8-IQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:56:22 -0400
Received: by mail-pl1-x641.google.com with SMTP id 4so1953098pld.10
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wm3IM8qfZZUE7jYfganJBGPiImd7ipdBWao7ul2CHb4=;
 b=X7TnO9upiJw/7zwZDG35i3900DFCII807A6ZTVY56a9fBc9oFfrDydJJF0WCzKlBB3
 vft+D65UQTygrx98q97Q16iHIUMpv+bpOBKwMtEmXjA2m/YtuCHud2IMdehHu/1U+CRA
 20k+6BeI2TNP5x/Yv5xKxPaq/G1E1f5fb0+ssME21z5igTbSU9vI+EJrnBQ8kWDxK7Af
 3m9DwWiGH97SjVMaEpmO10I7+L+/1SJ5KLXVEZV/wCibmlaLhVebBhik1265Sx0Qjdba
 2fJOMGlv1flgGzEkuQ1JKhSioY16t7cJr9Lhijz5ZD2K1FjxR2MIgWMmbLgB1U/21Dp+
 6JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wm3IM8qfZZUE7jYfganJBGPiImd7ipdBWao7ul2CHb4=;
 b=iKWQLC6uXjbad0BisqoaYPJPbDwhYCgUXu/2hGGgWWL6D37NIzRn1Wchgc53fZKMk1
 oFx+Gz0igjz/iGlrP5veAyLu5ZgwWe1zmdRFMSQyFQWBcH4Dj6E+Nrx5mCTztQKj4QH5
 EadNOaxiWG2EE+yOt7/TqEx8+qlPy0Fo2dmT4nX6qROng7zGv7jGn/E15LRsmBnkU6Wv
 1uBiH9AKUgg0BVX1uBnHFOocH6IuVOnxMNiMTLD+psgbp5LNvOBLY2h/bhJSQAfR1Eev
 8pToGcEdf4O/4ssfQ6iIihEbui7Wbv5pxvZLneZpu+xr4NwSSoGr9NAScgFJkjB4lQLy
 xkxQ==
X-Gm-Message-State: APjAAAXK5fOZOliQ9il8d1eJliBe7lDKho5pz6Kdi2wTjnMrgpBEdH6N
 ItCN0y/aCN0p8txz8Hx1eUoDFw==
X-Google-Smtp-Source: APXvYqxQjK7yKv5itOGKlEc2Hq1cPYmqO0Rx8rU9UMkNRaVYyqIqWBjD0K94kLgxoEheU2Ci1CE+zA==
X-Received: by 2002:a17:902:850a:: with SMTP id
 bj10mr417302plb.254.1568750181185; 
 Tue, 17 Sep 2019 12:56:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a8sm4904335pfo.118.2019.09.17.12.56.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:56:19 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aeefce6a-3b85-a20c-db95-6f881600cb8b@linaro.org>
Date: Tue, 17 Sep 2019 12:56:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v3 04/29] s390x/tcg: MVCL: Process max 4k
 bytes at a time
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
> Process max 4k bytes at a time, writing back registers between the
> accesses. The instruction is interruptible.
>     "For operands longer than 2K bytes, access exceptions are not
>     recognized for locations more than 2K bytes beyond the current location
>     being processed."
> Note that on z/Architecture, 2k vs. 4k access cannot get differentiated as
> long as pages are not crossed. This seems to be a leftover from ESA/390.
> Simply stay within single pages.
> 
> MVCL handling is quite different than MVCLE/MVCLU handling, so split up
> the handlers.
> 
> Defer interrupt handling, as that will require more thought, add a TODO
> for that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 44 +++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


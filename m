Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049AEC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E0F20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpUeTIMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E0F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK43Y-0002s4-Pv
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3XQ-0002Gv-Vw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3XO-0001JV-Qo
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:49:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3XO-0001IQ-Kr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:49:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so10725930pfl.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WA6zskcdS4cC7Ap1HsIPqcID8t0uIv6cTHlITU3A39w=;
 b=YpUeTIMqGXLVcK+Q6xq2IMIiAE3+Pb5kVyvsvDvMYf213BU3NVIe3PmELBdZ/s9oZN
 EKeTL/BDBYwuwx0JKD2hBPTjq11Noxa2JXJkOXvzKnNx/vkS3QKHDDpkZDq143lvh/zG
 r/X/oXH6ap3CNkhAzpvWfqQnPFxdZj/7k2IcTsb4CJxOSoH4Pfne3KUwvHdcT1N5LzXe
 M9UtquHkDwtOxpKhDiIT9GLKrYS6/G7iv74Lud4oJ9Gnvq5Ku+rudL2N7h7phhgBvh+T
 U9s7S85qywSzJsLPM9qXyeS4hNamfwmkcoV3CJzQ1LKoMeHUmQ3kTmwFx1pp0w5/8U7F
 X7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WA6zskcdS4cC7Ap1HsIPqcID8t0uIv6cTHlITU3A39w=;
 b=fOvdIGFsa2S3g/ZNCEnxqt8m5ZQrES/zM+sCrqiKHNqa1IZ45fu5aARL60uNagZOdo
 gg10WgBQ8oOxgKUqt7fq/otUS4RychgabaMK/9MjowCDgwtWiw+g+HIs4snazY9xL/CE
 qIT1i/PQVm4x/yCdfUadD33iJiyN2lzJxlf4Y8H+X4MehYg+kr8FB1W6Sj2+xzEjaUVj
 spSTJbSDC0w4eH79DLLMQVXRWNzWmvOHhKnFYK6y+yAN8GMASDlFuGsObM4k64gNfTgk
 LgsvyjhCUXrHE+FU26CnloSliC8Mv+7CQ6Wq6f8al5LMsNnKNThVOR9y1eYOJ3LrMjug
 Fyng==
X-Gm-Message-State: APjAAAVND35ZZZHnr3VvD2ad21mtXEIrrVO6J+cwqA+Hsku4QcMsXL6v
 TDXv6ZD1D5qxbq+RbiiamO1noA==
X-Google-Smtp-Source: APXvYqxrTD7mmf0Go1W8niEmq/X2YpeK/X9pbBnqJQYCOwWVk8mGTzQQDlLKetqc7IjS/INB4hRvCQ==
X-Received: by 2002:a63:5c57:: with SMTP id n23mr43656pgm.132.1571071776342;
 Mon, 14 Oct 2019 09:49:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q13sm21593798pfn.150.2019.10.14.09.49.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:49:35 -0700 (PDT)
Subject: Re: [PATCH v5 45/55] tests/plugin: add a hotblocks plugin
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-46-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aee53b95-5a94-79a7-5056-86e71e324012@linaro.org>
Date: Mon, 14 Oct 2019 09:49:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-46-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, robert.foley@futurewei.com,
 peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> This is a simple plugin to track which translation blocks are call
> most often. As we don't have a view of the internals of TCG we can
> only work by the address of the start of the block so we also need to
> tracks how often the address is translated.
> 
> As there will be multiple blocks starting at the same address. We can
> try and work around this by futzing the value to feed to the hash with
> the insn count.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v5
>   - handle 0 length report
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



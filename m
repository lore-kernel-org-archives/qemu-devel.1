Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52193ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3920873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTvarUlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Vj-0004VC-2h
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3hO-0008Va-1y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3hM-0005Gi-Sx
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:59:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3hM-0005GY-Ms
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:59:56 -0400
Received: by mail-pf1-x443.google.com with SMTP id y22so10733097pfr.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VoO2pxDk1KCakIkBae1NkwF0Gxl4lO2EjsHoA0aRpDI=;
 b=XTvarUljLpJwa0m1hkMyk5zwrmHb15UGlg96InBZpqdM3RLIxbhhTGHkIl4wLxhR1O
 j3DgjXWnGn3J7No1RDdW7jlkiRJz3S7cSUBpBUt1KDb20xPjwvrEMeEwqUZPO1H0RHrc
 2Ba285bVeWPtGTF7Y8feoWxS+ZjFZ3R7vwLD3KgqhVvkTkXrsgm8V/P+m3nr2vgbVKg6
 wnigalPBmyE65i7RJ5EoBuwyVIKEaMBzuE3qhApVFgkdT53MNoRVMHlPAYFPaDfCE709
 FL0IBpO0Gkkv5+pGVFRmoR4jgGtgv51Pf8Tj2BwmDyXUPBcpWK2BITrfWEqSYc88CTUp
 V12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VoO2pxDk1KCakIkBae1NkwF0Gxl4lO2EjsHoA0aRpDI=;
 b=ZpWwkitaRW65fel/+ez01oiVl6QhGHhCwJECaeaf2wPKSP51RwBeLlCZzcSr54nkYi
 HiciMrx/k5k4pQXjkkE4Kd8pz7Bn2V9PnbSLG/XmhJM4PoZNVd4MIqEw61ZZX88FoJKh
 xadUiLndsc9qx88eeV7f6eXKmoeQltOYxzdvXzwR35JnDsxhd4F/2KC8JRx86WY0HkCP
 HlkEbCShWjGsKMfd9dETE408hiZbV7/gujZ21BIYx3UPi85Nw8Y6dMANIy32Sos+20AM
 zwh8JRlpWSDyzqvTapAvl2HoqNPaLpApIKs/aDIeQKFVbD8clv8cLc+9IUKBdVpFa/L3
 MQrQ==
X-Gm-Message-State: APjAAAU1UuvlfDahW0S0XW/L8Bh4QioxkHZ0bseZEju711xe3ndEWy9N
 yIY8y1wWsMIx8i1ERge1DaRHRw==
X-Google-Smtp-Source: APXvYqzwypP/z5Z39zAiRycwm5QYkrs5xMgvWWrt7134RGgJ46mF3xquRfS5IwghtMytIk8BAzI8iQ==
X-Received: by 2002:a17:90a:80ca:: with SMTP id
 k10mr36983617pjw.88.1571072395392; 
 Mon, 14 Oct 2019 09:59:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a20sm1992817pjs.30.2019.10.14.09.59.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:59:54 -0700 (PDT)
Subject: Re: [PATCH v5 52/55] plugins: make howvec plugin more generic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-53-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a05f8601-7c93-8861-4935-6806f5ae3ec3@linaro.org>
Date: Mon, 14 Oct 2019 09:59:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-53-alex.bennee@linaro.org>
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
> @@ -190,14 +211,18 @@ static uint64_t * find_counter(struct qemu_plugin_insn *insn)
>      uint32_t opcode;
>      InsnClassExecCount *class = NULL;
>  
> -    /* we expect all instructions to by 32 bits for ARM */
> -    g_assert(qemu_plugin_insn_size(insn) == 4);
> +    /*
> +     * We only match the first 32 bits of the instruction which is
> +     * fine for most RISCs but a bit limiting for CISC architectures.
> +     * They would probably benefit from a more tailored plugin.
> +     * However we can fall back to individual instruction counting.
> +     */
>      opcode = *((uint32_t *)qemu_plugin_insn_data(insn));

This totally ignores the endianness of the host.
I'm not keen on reading more than the number of
bytes in the insn either...


r~


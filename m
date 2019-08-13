Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C23CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159DC2063F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZ6FFqKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159DC2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOjF-0003Bc-ET
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 00:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOii-0002H8-HR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOih-0001yv-KX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:47:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOih-0001yf-Ed
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:47:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so106477941wru.13
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=riOf9SI8199DfHP2OSX3uGmJduKR0yErw8/NnNTvgKw=;
 b=sZ6FFqKEDNgFxWdeztiIuhbDnYyBv4wkqj8fBnBMcBS0ANgeOVm7xnxbiEzT2kqhng
 Gf+uyMXJy7lchUuY/2mUG1m5mdrh6Z+JsxivsASA1WDT+MuOsT/gAdbKzGmGeS8zH+v3
 UXsrEGmbPVhmJClCxfmt0CjyjKMMR7+gTNsnJ3DogUDlf0d51t4XlRlI42YdGMUMk4Jy
 dzlOF5Hr2HSFwmOuH4ctIllkL4p2OGp+/7Z1Yur8cdJ1gy044A8J+fbP5LxaLqI7gy3Z
 xBsuxjCMzRDVzNOJwTlWan7I1L8u9Y5Kcx2AvTyDXvZGUjPYV8XhICpca4fKA/N+0U3C
 TOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=riOf9SI8199DfHP2OSX3uGmJduKR0yErw8/NnNTvgKw=;
 b=ckwQeNQIK4wuNcPumEMP0WD1qHi5m/+7TDWMbE6lCnPyYCb+vZVrqHuXlvZ57ReCc+
 gwwv4cg58nTXHZD0i6niMTgn5p0K2VyeLuRZ2+i+gKiOjBFEn98gLU0TH3yn1krJWU17
 KLoUA0cp32ybUjhVRmvRzyBov4WxZRqgdda08xXhJhJN0fQWI7C3CauWqsC8syplC1PI
 Nnwshm38K1y0ABE2P7yOKLq27RAmrnWR3YVp3Xjbnlwo9gtjc36HyV5CISmGCh6TC6To
 JOGdVqPS7yt3yLZHqo0Z2M37b9AOvfztVJR6Alf9HTwaw/8ji3jjFWvqEqDQg+OVU8xl
 ItTA==
X-Gm-Message-State: APjAAAV+WiRRp3F4x6FtlGQTNcAlyn97ZguGu64RKhmUWYEpVAf9E90r
 xki9Vp48KNK1FC69d2s/OxeSPA==
X-Google-Smtp-Source: APXvYqxm6mPwnnOYqly7KuC0Ov65DmVhd1KBiOz4HvqZHILc9WYJ608/3knclInVyZnGzm0saW+VnQ==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr46038878wrj.283.1565671658196; 
 Mon, 12 Aug 2019 21:47:38 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id m23sm369863wml.41.2019.08.12.21.47.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 21:47:37 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-4-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dd35fb5f-4ab7-aea8-7453-5f16e40de1b0@linaro.org>
Date: Tue, 13 Aug 2019 05:47:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-4-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/39] target/i386: reduce scope of
 variable aflag
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> The variable aflag is not used in most of disas_insn; make this clear
> by explicitly reducing its scope to the block where it is used.
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~




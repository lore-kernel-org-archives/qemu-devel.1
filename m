Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6319C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849D524954
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4kMS2Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849D524954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYyN-00010S-O9
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:57:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUYx8-00005G-UM
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUYx6-0004mq-PZ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:55:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUYx6-0004g8-Ao; Fri, 01 May 2020 12:55:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id y24so309199wma.4;
 Fri, 01 May 2020 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1cxxB0WR4bKFByG6pF1csPNThFwOOxAcQgm8sxJ3nmQ=;
 b=D4kMS2GvvDaBkuqcXDYQSiFp3PDnqOprHidPPb8cuKNJCh7TQvksRDX9AqJSPjxdo+
 7kDxA2diaMvj9ZPQSpiiw8UD1H42lMyOJKSnjJl7ZJyS3BOtHo5IfzXnr9TdiLSxzYKf
 Vt92vOvt1sftuw2cUvkzN1FPP+OMSWQUUlsIKLbar0YFQ2vYWxkaPLvg97+sLt8YjPfv
 1xDFo2N4pRDHcdlVZWzf2P5CAbGR8qpXzHholWpCGu/Y4A0KaymST8nNRZp5DhxCPKVI
 eVsiLrWXIKR6/7KULRIcaVwcY+I5ynBP+K/TAhZHRKR/wD3jWz0lophuPoqe0dYGCdg+
 +KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1cxxB0WR4bKFByG6pF1csPNThFwOOxAcQgm8sxJ3nmQ=;
 b=XeunVpImG8UCtgKE6Ek8ny4Y3EE6nR+PONFBLJ+/AJPWZpO+fVlaaCKM2r7neGUaF+
 1HdRzhbMfXvTSFtmrQkmqBMNkTJHOz4IwG0TGjPEHy9FmGu32E1EzVjddWvGUBAd8Ccz
 +WCClUPgdCSjnKntwJrQNWnvE7YLZrxn4ZW5mmH86ort1JIlABfdLlFbcBgOUVL+SzWh
 prLLImWWCx/rkQ3FbXHttNYHqrhEFDtyuHCOHvO6tcPtA1H9yBCoLKQdxAtaEO9yJyog
 3EyvIhfyI28QNfppIg0XntkGdu5j51mJo56ZnDNeTKH2rUOAS1g0A10Aidd8sbnXtGQD
 Z4lA==
X-Gm-Message-State: AGi0PuaDTR+XENLjZBpYUoBCx+F63TQsC02Vf7m952SWfvSLSaHxCJ2o
 TNNkQM6GFmqYbcQ+e/JO0Ss=
X-Google-Smtp-Source: APiQypJp8wEGXY0Tv86sxq8elFQqA7WKTkkc6/vksd9061tWQxRS/j3QDcPfHIvZBx9h31kDEu36kQ==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr442890wmf.60.1588352146414;
 Fri, 01 May 2020 09:55:46 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id j11sm5060102wrr.62.2020.05.01.09.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 09:55:45 -0700 (PDT)
Subject: Re: [PATCH 01/36] target/arm/translate-vfp.inc.c: Remove duplicate
 simd_r32 check
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b01b89f2-3934-8444-622a-6b966a43d31a@amsat.org>
Date: Fri, 1 May 2020 18:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 4/30/20 8:09 PM, Peter Maydell wrote:
> Somewhere along theline we accidentally added a duplicate

"the line"?

> "using D16-D31 when they don't exist" check to do_vfm_dp()
> (probably an artifact of a patchseries rebase). Remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/translate-vfp.inc.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index b087bbd812e..e1a90175983 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -1872,12 +1872,6 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
>           return false;
>       }
>   
> -    /* UNDEF accesses to D16-D31 if they don't exist. */
> -    if (!dc_isar_feature(aa32_simd_r32, s) &&
> -        ((a->vd | a->vn | a->vm) & 0x10)) {
> -        return false;
> -    }
> -
>       if (!vfp_access_check(s)) {
>           return true;
>       }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


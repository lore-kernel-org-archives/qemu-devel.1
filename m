Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB7C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BA2206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCsnMQSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipIGg-0002CC-RO
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipIFs-0001Xw-OM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipIFr-00028d-EE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:48:40 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipIFr-00027I-7G
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:48:39 -0500
Received: by mail-pf1-x441.google.com with SMTP id q10so2211031pfs.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 12:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hW+k2uGtlUYlhpvIMLfCQP9nWDcZgdXgSrRx4bq2qK0=;
 b=mCsnMQSqepoiEqNdxoGpdIt6ARRv7zGEqe1sumOD2Wr0iFEUSeJZY0Hj3c6pLAL27X
 UiMcRCotyCQwMh1KzfhVxYy7X3spLrmC2aP3Nak9xxZ3y3vX6BBoZqKK3BeksJ5RIOuC
 0awkCbLGD9TzPhPdqhTLat/pMR+gK91Dvc14tYAuEi4mk3rSVu/NpCwmkK6sDU835x/G
 FT4xJtT2DqJy5NgdDk7IwCbrDxeJLKbZ8Au0qzK/3MQO9y977f45SfPM4GzkD4wiEm//
 Dp+cQA8yr6C7JZVT7Tnziybo9horD/R5Vk3GmzEFHMupPv1BiSWPv4U3PNl2Ye72Jsi6
 n40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hW+k2uGtlUYlhpvIMLfCQP9nWDcZgdXgSrRx4bq2qK0=;
 b=T+OmrWp7dt/ctOctkCO7TCCDOVyw/OVIaAUWrHb2RCadYg6SJvrJ/x4sP1SuGS2Rj9
 PJXqD4IPND41QWnFJnvG7FG1Eu2i0qtofhceOYpt1z6fmec1s5ngNj7AQtDXXXBbrkSu
 AQjVJjGna81sNMwkNo/EjC+BnclzssLzVjbs1sf0srmQIlbokk7CNAbEtRIVBcEnc3wc
 /BnPU+a0cNjZ1jRRLWWo21DANjYGEAo87rJe6AGgTQ9yJkQoVH7/Gi6fv1KBNf7R5CvI
 q1kjFKATF10DP6n/0ATf3loZ+9cnIlRqexDqSPKH1tXnbPbnKyQv+ddoyQrp/YrmXJz5
 6iEw==
X-Gm-Message-State: APjAAAUIEknDFmMefT9bD4S99esnaubezui3QI9jEx1sFwczCVb1uzG7
 T9ykTNi4yLtKbxlqtSJavZiMpg==
X-Google-Smtp-Source: APXvYqxEWaZlYdV5QQ3OD9kyHmlf2K/7F81oBTMHMuehUBBNc7wiUieRwS0zHRj3CLoG0h/T51AHiA==
X-Received: by 2002:aa7:8246:: with SMTP id e6mr7224065pfn.102.1578516517974; 
 Wed, 08 Jan 2020 12:48:37 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id m14sm178258pjf.3.2020.01.08.12.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 12:48:37 -0800 (PST)
Subject: Re: [PATCH v3 5/6] tests/tcg: extract __semi_call into a header and
 expand
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200108150252.6216-1-alex.bennee@linaro.org>
 <20200108150252.6216-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <841fb3d6-2cc3-dd4f-1151-4e83ae43dfc4@linaro.org>
Date: Thu, 9 Jan 2020 07:48:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108150252.6216-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 2:02 AM, Alex Bennée wrote:
> There are two types of ARM semicall - lets test them both. Putting the
> logic in a header will make re-using the functions easier later.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/arm/semicall.h      | 35 +++++++++++++++++++++++++++++++++++
>  tests/tcg/arm/semihosting.c   | 21 +--------------------
>  tests/tcg/arm/Makefile.target |  9 +++++++++
>  3 files changed, 45 insertions(+), 20 deletions(-)
>  create mode 100644 tests/tcg/arm/semicall.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


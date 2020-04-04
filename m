Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5DCC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 00:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FFC20737
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 00:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Emo0utoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FFC20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKWFD-0000xX-2T
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 20:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWEM-0000Lq-8N
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWEL-0004QT-8o
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:00:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:33881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jKWEK-0004Pc-W7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:00:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id v23so1502719pfm.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lTqPIjM2wJo+D/9TL1H4MJLN53EHWsWaRcTJoa7Xs7Y=;
 b=Emo0utoJSQM5t33OlbXIFf+xSX7Lo/vrTn0kwTOSeFxa5UrW1oHo+eGj51yJxIQtig
 HzLqcKtz32vbbdRxzpTk6GbPEK2jmVYlH3hf8U03tT89WLbCMuR+gUuiTY+iW1Q1+6LY
 VvAAJ91LKEgNUy8ZL3WcuhKyWTwvOdICB3rEOl483bqtqqTkR+3iaRT8W+60Tj6xhahb
 OP8HxZqZyy+Y7q6ILiyR/4KFfiNJFEPWXYtv/U1rLnGf+uzZHd+FltTDy5KlxVD+47Dm
 6WzeLTZGrN6ltJTMQmv2yEWDoL8Dw+8iVQGFCb9lWW9DUVvomW/Xq9cnuIaZK1KwzWS8
 Bxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lTqPIjM2wJo+D/9TL1H4MJLN53EHWsWaRcTJoa7Xs7Y=;
 b=tDGttdjPiZLFgcwLsFseJZCqbuGQHsNASazTtBu81Dx7yDkKYpEsVrsGipBXxq1pgn
 mkVjy4c2hJVntKcdMUjDykwMI+skriqMgQU6oWHpfAjRTEAu2MEp+WwCO+WT3WjRB+5l
 n82n5MTWYgvDApifhGRnOdyFeo3zrXCDmHVHc54gGxKfl8yrFfHUcMivQiot2ohUmnbV
 A4BgjNDxzklkXlhjIx+bqAV+JR1slqL2E26tXw3wh0H3GrWqXK4ETM/xYjPeLWIYkEdK
 CLIW5sITC7zIIyV5Ar/tAwPJrszVNwWIMi1TWGIeDiSuqJqMCUfIyb33i/ywE1In3Z1b
 gqHg==
X-Gm-Message-State: AGi0PuZIVxpRrv0jA0raZB7xB9lnPEqucyozibD24lK1sFUXeHaK0hjT
 JoRQ6wjsn6LG5g/5Dk4dYK6NGg==
X-Google-Smtp-Source: APiQypIGESMm28d900ARYesgC1n/eOyY1UYGweSIIf5xEl8J4O5F+Od3Kb5CxHE/RmWL2zW3LizqZQ==
X-Received: by 2002:a62:3086:: with SMTP id w128mr10957850pfw.63.1585958407849; 
 Fri, 03 Apr 2020 17:00:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h2sm6622777pfr.220.2020.04.03.17.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 17:00:07 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2] target/rx/translate: Add missing fall through
 comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200403184419.28556-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f875561-13b1-ec40-79c3-f1678501af4c@linaro.org>
Date: Fri, 3 Apr 2020 17:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403184419.28556-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 11:44 AM, Philippe Mathieu-Daudé wrote:
> Coverity reported a missing fall through comment, add it.
> 
> Fixes: e5918d7d7f0 ("target/rx: TCG translation")
> Reported-by: Coverity (CID 1422222 MISSING_BREAK)
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Fixed typo 'comments -> comment'
> ---
>  target/rx/translate.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


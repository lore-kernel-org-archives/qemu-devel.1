Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD4C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 23:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1F1206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 23:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PN20CRtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1F1206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKWDl-0008Id-To
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 19:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWD9-0007sx-Nk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 19:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWD8-0003V2-Ft
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 19:58:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:55074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jKWD8-0003Ui-A9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 19:58:54 -0400
Received: by mail-pj1-x1033.google.com with SMTP id np9so3779916pjb.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s/6dbLuMefQCY2o4JAYvyiD5n54R3gZoL/8YFr53v08=;
 b=PN20CRtkoEm02M9Y0WTxaDGUN/DS1wWmtV7Bk7t0eziwJjJ3gC4dsUkb7H4x9yMX4b
 qWmRg/iKe9ZVtAIlKY4pHSIwJnV2JF5RZbIDUPzI4GogMe6zrqwWIXJ5/LESLQ7QvFN4
 R2L8jIn0M4l0T5mRqKAJ0oKgX2rlVdNTpRjQM98K/TPXYve6uDRGQ5qpnMjOTRQPvSk2
 dpkqQuPib+MMaeqjCZg/WUuDZHDb3tauyKB1EsXhKGnGho9kKHOxVSPMLsuBXWI9ZaKu
 zK+RH+7ckhQ67cqgzWnbpJJBEEo0yh7QBwr3Hkan8OEHkr2m+/nOKzs1arqJBvwazBEc
 +DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s/6dbLuMefQCY2o4JAYvyiD5n54R3gZoL/8YFr53v08=;
 b=ssGLOOuCbdQYw9U3XEbmqSODPDxUjV/oje/sXZMXagGtngFoHfBUn+4ScC6tuIIo9t
 3KwIxz7KA4eqfCC3yVN0VxyZM9c/Zv0k03+XtbOHbGIghBXE4Z8o664WEz5xkyovki45
 8ciRgq+7I1MO1POdQaaVa6XCTtDrGAL0F7kRZU5fy5TvASzVraQkaPnVdWi6twbRgRSm
 miS8H4t81TcBFXxIKbTjoAcqptlDt98JdxBcQULQfvA+g3IOF1+Xk/2uwt7KJ405BHbf
 ncBMssSJpT/xBytM1Yx9FAC97b0IeUI7n/C71nnoXbprtqc1HMqexl4jFOLBOyvLGYIy
 PumQ==
X-Gm-Message-State: AGi0PubVxcEZBOzycrPV8qjlnCg1yK7HCudLW9MUVEilbRDycX5K73u+
 A9vxF5e5/2XUNTqwJoT1Kf89pg==
X-Google-Smtp-Source: APiQypJw+X/xkYw1eE0ZWhqi/N5DWtGRLsugDi/WuJNkWozTyMxBYOta76qTZyioE1P5kIt7qRL58g==
X-Received: by 2002:a17:902:e788:: with SMTP id
 cp8mr10113965plb.343.1585958332762; 
 Fri, 03 Apr 2020 16:58:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id v25sm6095935pgl.55.2020.04.03.16.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 16:58:52 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] target/rx/translate: Add missing fall through
 comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200403184257.28040-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d07c1409-a513-b430-7418-8c2dfad15de8@linaro.org>
Date: Fri, 3 Apr 2020 16:58:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403184257.28040-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1033
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

On 4/3/20 11:42 AM, Philippe Mathieu-Daudé wrote:
> Coverity reported a missing fall through comments, add it.
> 
> Fixes: e5918d7d7f0 ("target/rx: TCG translation")
> Reported-by: Coverity (CID 1422222 MISSING_BREAK)
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/rx/translate.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


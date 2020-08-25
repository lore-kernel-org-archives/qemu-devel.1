Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC96720738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlPT7T43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC96720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdwY-0002Qx-VG
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdvX-0001kR-9Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:44:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdvV-00018P-OK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:44:10 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ds1so1714068pjb.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=dhR7qv2DXNOO7s+cWlxRYzOkGC4Qq0jTAX3k1d2vWek=;
 b=YlPT7T43Pglcpj0RY5VSZy+SmoD5T6LXF9gdP2YKl2AwfcpEpOjJA5Wx7C2rMFeuAE
 6W3XgSMu8DN5SEAJ7IR+bzbUkncEBAHVSrr7Qhy+T/zxybuDOkouSuvM70RgmAn+HXx6
 ZVoGz8Hdl8YoLAfcQxH2DVgKwxmeCExBzJ+y/VZ3I0hR6WxGTcA/CQt2qDLPLHsofao8
 mtmiriTjsNqj2mKPyh1VOZb0IjCDfUwgRs+bFj3wRK/q695DluGwfDgWy4KgY6FNlsOQ
 JW3WB6uuIJiWQlO4LgSrF956E9tleeJxtVgBNOAI76JGz4wtANQWnvI5+Pp0OvSIGM4T
 bNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dhR7qv2DXNOO7s+cWlxRYzOkGC4Qq0jTAX3k1d2vWek=;
 b=YUVE+E7MTgnaubJ0UCK+c/Siuqejtkjo/PHC6rgEuqpNS15iTYeshT/ACtajDMJg5q
 W6XcS9sdGlWfFk664Q/VCxYd8UMt/YO21NH8SbqBzaZT3pxSz4RvNX+lHp2J0d5eb3dv
 d6yDkjxaBoLC9Fvfelus8HIaw0ftTQXQZAc0IjsYXZ6UojiBcMvNapjnMUO7edoOTw0d
 9u6KMi4K9KRDZz9jHeN9hNSZKni7jA8n2BHbn0GJu3UG8lGiUjvrxCMMGtfBvkGC2zz+
 cQLAogHuKCWqqCHvI716pg95YoN6xcAqiDO6O3yp0r5DaH46rueGEorifNZJ0AlUBYwM
 ye8g==
X-Gm-Message-State: AOAM5324IPBkDmVm5TXkgieNbGhVGQfpoDa3z0JFSSmGuYaqYCmsfiCV
 2gw38DGhigVZS1M6LY+aoG49+sxuhsIBGQ==
X-Google-Smtp-Source: ABdhPJxebJBHO4fjvsuq59A0VJxWDEvIz7QioIZ/4NSzA1AtpxlJQQeXwXNhq3gp1wFsGJL9btUa5g==
X-Received: by 2002:a17:90b:198f:: with SMTP id
 mv15mr2685315pjb.57.1598381048280; 
 Tue, 25 Aug 2020 11:44:08 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id b18sm3380665pjq.3.2020.08.25.11.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:44:07 -0700 (PDT)
Subject: Re: [PATCH 11/22] target/arm: Implement VFP fp16 VLDR and VSTR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <519914e6-a9a2-8775-d5a6-30cdbb886c39@linaro.org>
Date: Tue, 25 Aug 2020 11:44:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement the fp16 versions of the VFP VLDR/VSTR (immediate).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp.decode          |  3 +--
>  target/arm/translate-vfp.c.inc | 35 ++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB4FECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BD9206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbPggMEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BD9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTDr-0006j3-G2
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTBe-0004WS-KB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTBd-0007hv-F6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:36:30 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:38510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHTBd-0007hB-7d
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:36:29 -0400
Received: by mail-yw1-xc43.google.com with SMTP id s6so5110458ywe.5
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ny1aNn6LVxX7Bhak4U7E8JYqggUXalQzYCu2EQpeTdM=;
 b=hbPggMEuSI+nQWIKYB/4fji99+lN4rQCPaMMFC6B+qiqXKiS32M/ydYqUfwLU7sxiO
 qdZ6FkCUfFtzkzzRk340c+Ji4zaXpr84WA58R0A4nE8s+sFba8Jh5czBmr72w3ruoFsk
 Uzj8eDRQsozD4vZZjcX+JdakA886pb9dkTaUfA+nWmi/Bkg76SRaki9pzFq/aptUA4PT
 x8mJXL12sLX8c4jlXlAcxHIhb8ioeeqUUMSC6h6yr12BdkfyMbzOfCcC96x4iKpjofst
 jLYRb7Zsh+oi4LXAjCUdV/uTlBdOfF8WjBbkF99UaVpUAJJ5Y4OmGOWE+NJO1mqAA1xk
 RMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ny1aNn6LVxX7Bhak4U7E8JYqggUXalQzYCu2EQpeTdM=;
 b=rIn4VDZ52bAKjWhJSlxutekNc5gdL157MsmaG7t8e98RoHgKOB6WApVvZ4Jz5VItnK
 EC+x2XL8YQEl7Jx4kYtBoRzsb6B5003pjOv/lNf+2KcDzUB+/yd8QoKWswr9l2Im46kO
 qwjAE7MqYajNVObjU7dSfSlMgigeiwzrgam6q+hg7BxnAsEMe0C+OsxLO/Wmr3hgLMa4
 uGEmHeFKPTktxb44vz378n8kJYGad4r8YHWY7K6mv6ZRXI/x3ZORwGmf0FwlcUpGuJaT
 GiQTzfGJ1F0vNiZ7R3WR9/7bfdO7gWbfTWBDcWebIki+rpeYgClOtUYkmuHTWjcjsL0s
 efcg==
X-Gm-Message-State: APjAAAUPPPJhCllkEa/GdPyVTaiemxxNZF2Aw59TWyBb1XOWNUHdssVc
 WPpG9++EzIvUrFgBLdzIReAM0ER+Ef8=
X-Google-Smtp-Source: APXvYqxnCCgVWB+cg88+W6cJ1RjrVkGBaUZ99AuFXRSsv37lHl6UMsE+VX+g0m9D1a67l3+MT9Wv5A==
X-Received: by 2002:a0d:cc86:: with SMTP id
 o128mr21060695ywd.416.1570455388482; 
 Mon, 07 Oct 2019 06:36:28 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id 12sm3971513ywu.59.2019.10.07.06.36.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:36:27 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 01/15] target/arm/arm-semi: Capture errno
 in softmmu version of set_swi_errno()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8bf09c55-967d-e1ac-3c0a-78076220dcc1@linaro.org>
Date: Mon, 7 Oct 2019 09:36:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 7:15 AM, Peter Maydell wrote:
> The set_swi_errno() function is called to capture the errno
> from a host system call, so that we can return -1 from the
> semihosting function and later allow the guest to get a more
> specific error code with the SYS_ERRNO function. It comes in
> two versions, one for user-only and one for softmmu. We forgot
> to capture the errno in the softmmu version; fix the error.
> 
> (Semihosting calls directed to gdb are unaffected because
> they go through a different code path that captures the
> error return from the gdbstub call in arm_semi_cb() or
> arm_semi_flen_cb().)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB that a later commit will put in some cleanup of TaskState
> that will let us reduce the duplication between the two
> implementations of this function.
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



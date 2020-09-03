Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283EC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AD720775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUk3I3q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AD720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsPr-0006AW-F1
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsP4-00057h-3W
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:48:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsP1-0005LR-G7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:48:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id v15so2593637pgh.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MqEzl7bYtjx6L00QzbuzeF7tsc3PgsBkPDFIIf9kTuU=;
 b=OUk3I3q2OP1PwnaLggOkAkANBJodhyNlNKAMruvJT7831ybbqKH2980kp0tksuyqGr
 DQbBvUNflIOcVVx8bLr96X8dSesw4Qj9H8pVjcxuDoGReZRVQYENExhn1McaL+aOAvT6
 BVisjTmofzssN+y9/AkUMPV6UsWfvEt+EVTZy/C+ka9JO7+snTUZ3Bzn/W/cB9B9JoZY
 NF+aUWMa5oIozXGkWFaxuvu6AyjNcKZqTmQzwfc4MI1tN/r1/ZD/dfwomjdm2ye0Scxt
 2BxM9O/Yv9ZY3ktTeFAuhwLtX6BIcM8I9wxk0GdEQ32N55btx2O2+D2HcFzb4ZvEqwW3
 0LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MqEzl7bYtjx6L00QzbuzeF7tsc3PgsBkPDFIIf9kTuU=;
 b=nYKzT4QB/oKIPLonETQNoeOY44ahOlgUwhnNk8h4IqkuuXUsOEsExl6nLVr7zBvYgn
 PXDLMJK8xVEEJ763O+eXZcvJkei/Oe4bd/isocBOMoaL+9rz/e+HtTg4ydpBQxAke9DJ
 7KJy/NFUWDu1jtXHMnZQ4Q+E6RssUI9bEJvcyJ+qIxArF3kXlHqHwvBtDpM25s/lvieK
 k4/cCFUdee3Vy3Hn9dUQxnp1V/rhSDrpen5kNTgDb/DRT4pVS5UbHQK2uHOAeFFfZ22i
 uz3/nshF2TI6iQDNVCI/UDX29ZVrLa96Qf8qrE5h+BtvaPm0l56fWxcceMNJsyD6oHjl
 xvMQ==
X-Gm-Message-State: AOAM532mjlEyiu19ihQseX67DPkbQ/x+naeYP+gKYRxYBP9sf1YnclAL
 DLOCMuxxndNZ1IwpYrTI2P06qg==
X-Google-Smtp-Source: ABdhPJwhXWEk2Ioempmc73GBpP9b1VnFptBQrJ0jD/47FZFOGL640EbZ58Zlon7l/7b1HS89rb//kw==
X-Received: by 2002:a63:6f82:: with SMTP id k124mr3647574pgc.357.1599151677391; 
 Thu, 03 Sep 2020 09:47:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s8sm3936837pfm.180.2020.09.03.09.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:47:56 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/mps2: New board model mps2-386
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200903144425.11060-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <79c86090-02b2-2849-ab6e-c600c02e69c8@linaro.org>
Date: Thu, 3 Sep 2020 09:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903144425.11060-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kumar Gala <kumar.gala@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 7:44 AM, Peter Maydell wrote:
> Implement a model of the MPS2 with the AN386 firmware. This is
> essentially identical to the AN385 firmware, but it has a
> Cortex-M4 rather than a Cortex-M3.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


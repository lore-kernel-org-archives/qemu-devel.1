Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C647E20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCTw/SMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C647E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3vt-0000P4-WD
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3v4-0008Mw-4p
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:15:18 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3v0-0005Je-W5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:15:17 -0400
Received: by mail-pj1-x1041.google.com with SMTP id k5so317270pjg.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KnFc4aN4nd9q0TlUXrxVWo79RUIQKXsFj88AfCvpRgI=;
 b=fCTw/SMttoNmmWoKZayvIi1sLYvj/eIOQbPqWs7F69A3eBQ3TX3p5PQzP4Mz0B8sKu
 nfM59aqJXK8bU1q+sGfYSOpG1czZV/K4Zrq3nKJoWtvSvTBYpDbORlSUWEp7biXREeBx
 0bIKDGqvop2Nba2P0eYpOncj5T6M/ZYTfsyh7rhKofg+4Yh/OvNtX3G4NVbWoGKoq9Yo
 pk4FNle409ZMXbHpD+31q3/mT/JxA+l9TYgu7DUOlTC7oh/QC4kR7NEfRdvAPoAVfnd+
 7i8j3hgKfipRL5NoGp/OzYlPnhGN5cHywKKaTEciT2IjzkSN13+ecKOON3wOfqnnB4ya
 ht3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KnFc4aN4nd9q0TlUXrxVWo79RUIQKXsFj88AfCvpRgI=;
 b=Mt2Er5FT9pV17rk2uDH/vQksG9nV/39/L8Y7dKEtk2WDcWchSeFPLpahDfph0lVmZ3
 ouju+5K7ULrxw6BNEyLifCPFlLLZ+Z9s9R7lVDpU/l3vqijyQzrW9sZ37tskeOYzcswv
 +dpklTdRZCqHAXed4+PacOHWy2r5LGImmFa5HWU1Y8P4izoQ2zzMbECJBWRRnlGebced
 Abh8UF5U/GtupDNWtMZMIJQ5MMJMb05tCAXyxVZF/3Ih/1Fk6+mQKNchhfcSytH+W+To
 FoLQSxg7+Vv1j2+vP8e4254TN9OzyelLhslZMPh9ExkGef3KKKHcux+MTqFzSjs1MHD7
 302A==
X-Gm-Message-State: AOAM5339XCgLH2d50nTQOiOIYVxcUCeYG0rHirJxds+WPPWzSbKvc1kO
 GOUFz3Si8tY7MO7K/THogKvbSw==
X-Google-Smtp-Source: ABdhPJxxvo2a2lVvopGKOKHrruVpMYAjwBY6v6SYA78M6ODNt+RTcrhY150utCrW6iWOgzFLmTZ96Q==
X-Received: by 2002:a17:90a:d181:: with SMTP id
 fu1mr874284pjb.60.1594667713610; 
 Mon, 13 Jul 2020 12:15:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o4sm311928pjo.16.2020.07.13.12.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:15:12 -0700 (PDT)
Subject: Re: [RFC PATCH 1/8] fpu/softfloat: fix up float16 nan recognition
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <055e48f9-c193-c1fc-8d60-3bebd37efe09@linaro.org>
Date: Mon, 13 Jul 2020 12:15:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-2-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 4:45 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat-specialize.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This one should go into 5.1.  Are you collecting, Alex?


r~


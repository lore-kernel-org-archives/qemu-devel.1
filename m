Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CBEFA3736
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E632921A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xg35TV9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E632921A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7yX-0006sW-IK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL78u-0007qA-J0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL78t-0001H4-Is
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:52:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL78t-0001Gp-CS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:52:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id x127so1809837pfb.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fQXDvjQ0IsAk8pASma6H1fKrcTpTHUBY64ueBPATuhU=;
 b=xg35TV9YULiyJlNfzzSDR7wu7e6xvpvJloyQb3vdAkrcCM5x37Oih3lSTT+vKCkeRS
 TMBXF5UqchSkF8QSiJYMoubj9hlOsEV5I2KN4ARYD0sbTWbf/R2Mcw12K99I/GVk0NFK
 bTT41KpND8E9wIuuneXUhJAxUVPZPML3jQTb3n/Mgy1opaVdAd0SvpU1DHy7BUwHj83R
 Zi7qWtW3JFNlcDlYV8TyoRYfEB/qJ7fvj5iyPmBZ2ojw1yv1RP+ma4fS40n8mWiJEJHH
 0knZs/RHvzoegFtInsuOXQw1yR1YIlkzGeNlLHwXk/894PhU7+pgobXBrMws/Z2RkvSA
 j59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fQXDvjQ0IsAk8pASma6H1fKrcTpTHUBY64ueBPATuhU=;
 b=hQ9Q2ATH5xGaSsAYfKpEG/jJPRFuOxc8/NxPWr6VSlD1RDfyzwtyDvD8AwuqNCSKJM
 YY49UIiYjcQ/B/Tn+XphZNn6/chRfgNqL8qxwNPk8BJhKVWn9neI9F6qZwcNJvNiFvwP
 kdHsCBoL4ClLv+4lf9LN2RQHgSyQ0R8BuTZmr4FYbNCzaelpN06Obtu/SO0DY6VNSqpx
 0aIxJgk6Uv9D8nQIDGPWnxHkOYH5GZrpRkZP1kTTFGLJTfpE/U0nAsOwQXUq1paT/idn
 SZr2wecitJGEXdtoBLL2zOX5dKgDiaVbrvTbgvMgiFoaQ54lLoATkBJBCXlBPJVtGyF2
 o7Ag==
X-Gm-Message-State: APjAAAWvsSpKBxx/5KfUp/18G8/rJ4+EFNCGEISx0Og6jYi/1wMoNuW3
 cwfSDu/DJdQ2ZwDep5hirwHU1tQs8mw=
X-Google-Smtp-Source: APXvYqyWeXH1v96JsjrbFa9boHiFEoJ1kCml8ArtxxFMk6+3Z1i2R2DknGHDZ8jalyO8KrS0dv/u2w==
X-Received: by 2002:aa7:96d1:: with SMTP id h17mr611770pfq.187.1571323962510; 
 Thu, 17 Oct 2019 07:52:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l22sm2474258pgj.4.2019.10.17.07.52.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:52:41 -0700 (PDT)
Subject: Re: [PATCH 3/8] hw/timer/lm32_timer: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <86f6e8f2-53d5-0087-3e58-06d630dac278@linaro.org>
Date: Thu, 17 Oct 2019 07:51:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:29 AM, Peter Maydell wrote:
> Switch the lm32_timer code away from bottom-half based ptimers to the
> new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the ytimer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/lm32_timer.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


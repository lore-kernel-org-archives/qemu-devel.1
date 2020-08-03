Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF9220825
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kd9Mxdwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF9220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2cp6-0007Fa-9k
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2coP-0006Xv-DI
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 11:55:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2coN-0001Pp-JV
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 11:55:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id p3so20071464pgh.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0qqpqD915onaFoCxpKXH4xqDUdvvjVy0l6KgzS3CiVc=;
 b=Kd9MxdwxdcTixVbfvVQfT9sF6CszWBoLuTbIO9i55J7JrIweY7RJLjkbw7tiY7T9LU
 N47ROMMUJw/ZV6ZWaHo3/hJ3JrhHMqfPKeMa6/C2Xu1pJ+GuGqU2JnP8ICGqlDd9b0Ck
 3VHxzKacmKafANrJL3CPCXVEbgxwjJPDeJ4NO1g+udY+KGX9WylEIZubeF2+axIRXCO7
 lOGBo0apeHLLLYgT/X1gzylsum1RodEOEFReibabS4jP1BT7hP/iR/o7B4infWubOaBr
 hCpscxAcWCoP/+2Pw4eGMGTLrbPxS/lKdEFvE02I47tAp1ToTjZK32Iv5t/4xrz3s2uo
 4VBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0qqpqD915onaFoCxpKXH4xqDUdvvjVy0l6KgzS3CiVc=;
 b=UHJK9DKe7h9drmRUW1VCxM+NQlaff1JRSXtgJu2IJBDTc2eIGgEB7Klw3Z37BhxiPG
 SeVxHELHBf59gB48L/kGaQ9Ip4AHn5G3h4hrexLhDrkgEabh/IpRMTJ3+r9kVVx5EXnI
 41+IQmVocXMOwH1OFiYRWwlBexo+DQ1PoNgbb4746TbgON9LcaqcC4yC6jnbaC7HVJ7g
 Wu5QqTNNlABdVHj223V6P7G+45rhFMkA2t2isnGspHv+wbMciUZdi2SRptB5BPyB1C3U
 zmXSmipbHQKnnN3/z7PEqhDi9z0v+CCw7QIInDZgffHlzIOaNGE1zEasS2lxFeN3Y9hV
 UCsA==
X-Gm-Message-State: AOAM532OzkW1awaYtPz+1ZXeTtAbImRWtBvJmnxknpoJidpICDAr5da3
 EdFmEyntXHclrvFR/bFGpa7nag==
X-Google-Smtp-Source: ABdhPJx9wYQ4/rsHXU92+zy4dHlKlNn8kUeXUhLU7rmcAanf6V7b6KgjpymooiF47bBliDo+i59lgQ==
X-Received: by 2002:a62:7958:: with SMTP id u85mr16477877pfc.248.1596470137195; 
 Mon, 03 Aug 2020 08:55:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t19sm18581683pgg.19.2020.08.03.08.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 08:55:36 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] hw/display/artist.c: fix out of bounds check
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20200801131357.17379-1-deller@gmx.de>
 <20200801131357.17379-5-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1acaa4f9-917b-47f0-6c48-36d033d0a294@linaro.org>
Date: Mon, 3 Aug 2020 08:55:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200801131357.17379-5-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/20 6:13 AM, Helge Deller wrote:
> From: Sven Schnelle <svens@stackframe.org>
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/display/artist.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Looks ok, if not ideal.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


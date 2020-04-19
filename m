Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75A5C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F592072B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="bcBbkDSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F592072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQFGt-0002wA-Gf
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 15:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFE3-0002AH-8J
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:03:31 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jQFE2-0003yO-Uo
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:03:31 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:39814)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jQFE0-0003pS-UK; Sun, 19 Apr 2020 15:03:29 -0400
Received: from [172.17.10.10] (unknown [172.17.10.10])
 by beetle.greensocs.com (Postfix) with ESMTPSA id E219A96EF0;
 Sun, 19 Apr 2020 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1587323004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRKFEuXAKLsEX2U13LRI8BUYt/b9YcUUlivgjXJW/5I=;
 b=bcBbkDSDEIGlRx/OdUt3IQkrhesUkYCWPT0b8es76eVd9iT4BneVNGRbXGQsEPuJsP8LlG
 wAYpUslfxrgSbc+4c7+lbxAuzzfhJatHR1+7ULgK9Bo3UHl1Z+djU1v0dBZ0fGNh5aJg1n
 b4EecDCsou2nwDpp4Safdbi8d38WXEQ=
Subject: Re: [PATCH v1 1/1] hw/arm: versal: Setup the ADMA with 128bit
 bus-width
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200417153800.27399-1-edgar.iglesias@gmail.com>
 <20200417153800.27399-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <3415ca01-2765-7269-a4f0-9d2c18d5147c@greensocs.com>
Date: Sun, 19 Apr 2020 21:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417153800.27399-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1587323004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRKFEuXAKLsEX2U13LRI8BUYt/b9YcUUlivgjXJW/5I=;
 b=unfUvTx0RM2aoImD3tL2OxicRjfjv5T6/szmMfpLuSz+rzN4/nxP/lXwVNbuDUtPpvORkf
 PKlFScSN/Q9L8bnJCd90/HzJAd2pJnFHCKIQGQEQFbILlT1KGt8svvFbUGwD/sxMZhLT/w
 xgwxJpt5D4KaJnC6d+3xKm+kXVEQwAg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1587323004; a=rsa-sha256; cv=none;
 b=sBk5h/UsitLNESPGWYuMm1jnq+0RjMizTVrHAGgEpmsDIMVgtR6rWSTNmq/KUAah6jdrq4
 24xrisp6MBFs0TeLqSjY+ztFr0qMqLuJEq3oezLDhL1JDMOrhfhCf58Fajr4BFJhJiTlxv
 CxJAkGlwEG7KjWBFg4Hs6Xz/u1qyEM0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 5:38 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Setup the ADMA with 128bit bus-width. This matters when
> FIXED BURST mode is used.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index cb0122a3a6..94460f2343 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -205,6 +205,8 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
>  
>          dev = qdev_create(NULL, "xlnx.zdma");
>          s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
> +        object_property_set_int(OBJECT(s->lpd.iou.adma[i]), 128, "bus-width",
> +                                &error_abort);
>          object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
>          qdev_init_nofail(dev);
>  
> 


Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1113C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092AA20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlMhDXDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092AA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc84q-0001Tk-0c
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc82k-00084r-Qr
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc82j-0006NB-2E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604931672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKpPbOZfoD7MY4J4rFfCbQA3SoqduSdcuZEjijYyX+Q=;
 b=SlMhDXDJcjkzi08pj3emltDAOoRaI0cto0NMp4sJi+iOWBi1gBxQZFPGjy/u3evlzJceDZ
 1mrXlB8un2SO8StxO2yoEjPkW7gFTVGW3yDabSL2/tni5BAbM0FSDFLqGKArWzNCeHojF6
 GNzwfqaeHc690/1NI2qJC6lLCrNDPCM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-y5tJnVRcMiGE-WbTXGXHdg-1; Mon, 09 Nov 2020 09:21:07 -0500
X-MC-Unique: y5tJnVRcMiGE-WbTXGXHdg-1
Received: by mail-wm1-f72.google.com with SMTP id z7so2031585wme.8
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vKpPbOZfoD7MY4J4rFfCbQA3SoqduSdcuZEjijYyX+Q=;
 b=mtevWpAGuTJbiwG8Jb/L4sTQHimsa8n57YO/zS9NO0oiqh0AVndjh9aSi24BHzlB+/
 4/GTR2tcICrazIvQilJeW1wQ+ExZTblAyMfuZlSth9kXcSohZqdyBcrQAXUr+LvMWVAY
 Q9zvKnhwUrp05mjBTF5G/9pXQBZVuQL3dWeoPgY9k74rAjW10P57Qat4QtnIbBh5KPhr
 h7FYlekVbbMopNLNdKZV6GOaa+d3e4Pg3N1hq2jYm2BmbayUODUpiC6lR1GLwmdw8ctT
 RSEiK+b/t538+fPjboMSqUCsm54ZF0S5dmAMVZdkbirNpjp++IJS0oDjJfoRrEA3O3X2
 ysZg==
X-Gm-Message-State: AOAM530WC18yzplIwuq69yXntBhl6BfXXDsNxFpKtG6zIu8G4fKGSCPk
 YXgrjjjX4XMUbnG2YjfNhm+fgSwRSI6V9h9vJEKl2jpqCy2LVRp7s2VdEBeesH06ROBoavFUclm
 m/rPmZHDkaCZO1fI=
X-Received: by 2002:a5d:6751:: with SMTP id l17mr4106001wrw.109.1604931665257; 
 Mon, 09 Nov 2020 06:21:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8wKfdLbSdt4Zdb5YLM4rbQB9cC3tlQpQOZzZHr9jJa1BRUN0/oGgh8Vpw4xIui3NGLt8uoA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr4105979wrw.109.1604931665035; 
 Mon, 09 Nov 2020 06:21:05 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u8sm5357882wmg.6.2020.11.09.06.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:21:04 -0800 (PST)
Subject: Re: [PATCH v3 1/3] hw/block/m25p80: Fix Numonyx NVCFG DIO and QIO bit
 polarity
To: Joe Komlodi <joe.komlodi@xilinx.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
 <1604626378-152352-2-git-send-email-komlodi@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6adfcb31-8f91-5e28-e8a7-a0e1c55e154c@redhat.com>
Date: Mon, 9 Nov 2020 15:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604626378-152352-2-git-send-email-komlodi@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, alistair@alistair23.me,
 philippe.mathieu.daude@gmail.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 2:32 AM, Joe Komlodi wrote:
> QIO and DIO modes should be enabled when the bits in NVCFG are set to 0.
> This matches the behavior of the other bits in the NVCFG register.

Is this material for the 5.2 release?

> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  hw/block/m25p80.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 483925f..4255a6a 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -783,10 +783,10 @@ static void reset_memory(Flash *s)
>          s->enh_volatile_cfg |= EVCFG_OUT_DRIVER_STRENGTH_DEF;
>          s->enh_volatile_cfg |= EVCFG_VPP_ACCELERATOR;
>          s->enh_volatile_cfg |= EVCFG_RESET_HOLD_ENABLED;
> -        if (s->nonvolatile_cfg & NVCFG_DUAL_IO_MASK) {
> +        if (!(s->nonvolatile_cfg & NVCFG_DUAL_IO_MASK)) {
>              s->enh_volatile_cfg |= EVCFG_DUAL_IO_ENABLED;
>          }
> -        if (s->nonvolatile_cfg & NVCFG_QUAD_IO_MASK) {
> +        if (!(s->nonvolatile_cfg & NVCFG_QUAD_IO_MASK)) {
>              s->enh_volatile_cfg |= EVCFG_QUAD_IO_ENABLED;
>          }
>          if (!(s->nonvolatile_cfg & NVCFG_4BYTE_ADDR_MASK)) {
> 



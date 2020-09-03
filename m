Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE1C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BFC206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juP0Tt1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BFC206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDouI-0008Oj-IY
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDotT-0007pw-UU; Thu, 03 Sep 2020 09:03:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDotS-0003yu-2W; Thu, 03 Sep 2020 09:03:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id a9so2815138wmm.2;
 Thu, 03 Sep 2020 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6YQlrgPL3xfqmcKmCDzAAhZC0YGrSttpUfADCJ8+pa4=;
 b=juP0Tt1kRImDwhQqhWFmL0AeNvuAbGNNP8Komy0DzzqV/yUavaxXk8jmblOHIYUkaD
 XgLK4ABBA0t0puUzK00e8eVILLN95ALjm+15YW3bjDGmKGeXNzrrFYqHdiSQ9Tg6qqQj
 wQs2g0D/9qEb02tebYPlT6bh/Mxlnjp7UeUYZlXtj+9ILnAwcwK9vJnpgJkyqqFHf9sF
 s3cWlXq6J4H2pTe84cLBnPzy0mqYB/Rkl935dLXWnwHoYfoJIuoJa9v121ANsfy0k4NM
 GJ0+Qed4DMGFZeTx6rcqTJ/Xfyroe22iWsUOqrzaR9HM4PlVTEIFtVeJ5DuG/dIcIt+B
 /MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6YQlrgPL3xfqmcKmCDzAAhZC0YGrSttpUfADCJ8+pa4=;
 b=YBU719vp7OzBjPkwcfjVxMoPkZXlcXn0QRMHGDtTzHYA0PIhQeGPtv8Rpzm7tYxckN
 SAP63vIQ+bAbOdGBtXkOIqHZfjSiASMFXrgMVDBdOuWUTgBXROVsZwmQBgJtMVqooyg6
 UwKqrqG62LuWVa+z2Md2VQpITclHpWQY3/CfXWxB47/WNdDBpKWJ5nlY9WG/xImXYifq
 jaC11qbkG6hW6swuCzaUm8Bb+uJ96OFQHZotZ+0DYOE/k1zMpHHkBYzp9XM+3t9LQR8B
 IFN3U6POC1rmvP8l1Tcdcc+jmWtF3O/IC6NIE7a8yd5+FJY/xH+HfUEH5q1UDjRLbZDb
 VqEQ==
X-Gm-Message-State: AOAM5335EkO71BrUHrIlhYvELda7fkfZK5Dhn+/xWjDxfMaXEz3S9FMr
 VTggvm0NSClsYIDPUQEL2SU=
X-Google-Smtp-Source: ABdhPJxi7dJDQB7fyPBhXpIx69gdIuwoPA8uH+sJX55VlGTWq5OOTnPVgEc1EfA5WSFQjRKVByVMXA==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr2508554wmj.144.1599138188554; 
 Thu, 03 Sep 2020 06:03:08 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id y1sm4498627wru.87.2020.09.03.06.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 06:03:07 -0700 (PDT)
Subject: Re: [PATCH 47/63] rs6000_mc: Rename RS6000MC_DEVICE to RS6000MC
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-48-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4617c825-2c66-a885-7196-a4078ae67acd@amsat.org>
Date: Thu, 3 Sep 2020 15:03:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-48-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, berrange@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> Make the type checking macro name consistent with the TYPE_*
> constant.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/ppc/rs6000_mc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
> index 56e96010b8..8611ffa96d 100644
> --- a/hw/ppc/rs6000_mc.c
> +++ b/hw/ppc/rs6000_mc.c
> @@ -30,7 +30,7 @@
>  
>  #define TYPE_RS6000MC "rs6000-mc"
>  typedef struct RS6000MCState RS6000MCState;
> -DECLARE_INSTANCE_CHECKER(RS6000MCState, RS6000MC_DEVICE,
> +DECLARE_INSTANCE_CHECKER(RS6000MCState, RS6000MC,
>                           TYPE_RS6000MC)
>  
>  struct RS6000MCState {
> @@ -143,7 +143,7 @@ static const MemoryRegionPortio rs6000mc_port_list[] = {
>  
>  static void rs6000mc_realize(DeviceState *dev, Error **errp)
>  {
> -    RS6000MCState *s = RS6000MC_DEVICE(dev);
> +    RS6000MCState *s = RS6000MC(dev);
>      int socket = 0;
>      unsigned int ram_size = s->ram_size / MiB;
>      Error *local_err = NULL;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



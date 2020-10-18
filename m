Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4D7208FE
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S17AibpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4D7208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU2ts-0006AJ-Ah
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 03:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2sd-0005FQ-0O; Sun, 18 Oct 2020 03:13:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2sb-0002g1-Lw; Sun, 18 Oct 2020 03:13:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so7918744wre.4;
 Sun, 18 Oct 2020 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6xraDlsZZBSBLhBf7HNd+DyHCxCZcqQKb3TS4A5z8uU=;
 b=S17AibpWh957VlWkIAos9qRLMnmHbk6FuR+zJAmctkyoU8Cf88VvNVGk2y3iytttx2
 GHDR/0oE5StweGDCr+9jlySw5Fv4XfIK+//7X+Dpoxu020D0qkQtmnkmacWmt4DEBc3m
 lxGwaSx/5+nn6wyTEmGI+2Z0Mv9UVdC9qI6z9tKPNyPXDy60UBG99myeRo3d+RsI45ZF
 KdfG4XBkQYIT1RftUjEhZrPf5Je8pPbmCPvglipljIvSFqfVjZv1SGqcFHnhyXiClU/K
 9WT/Z7Dtx9KizdICqGtygLSNDfLRMkrZ6jarBtAzmEFwlNjzSLFEa3Iju/kLS41OhtGI
 h8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6xraDlsZZBSBLhBf7HNd+DyHCxCZcqQKb3TS4A5z8uU=;
 b=cr80Xtn0qNdJzQ3z+ujnz0FjZw71ScdQBBemKBtC18R+XNZVBXNkrnThRy6OH49pVU
 FOWMHP3Rgzt4G4+tJlfB1W2fJ/8z4MlkRsLiHj9bjjijyjm6ex82Yc8g+qm5Xkzue9+U
 3EiNYlvBiakzAJMCmSZg9MSPCNz3rKS8B3AtcfW3DG0CqLeFfFYvYawU7YK0t6uWEvzM
 F5SQH+lwJLEn1ZtNIAAUXOPXr6wHpGxcE1oXqRtcsoMeyzVnWIJpbYg0k5f5lRzdwQWA
 fAVsCKzWUiTIxaFXFDb/DQ65uz2nuPQQEfZAmc81DWI5bC0R1UgpxOW7QKbCciUh50sl
 fO6A==
X-Gm-Message-State: AOAM533/1jScnUNOs/xT/DwTP+/JWX23OLAaEqb9i50XJhcp9v0WgYLb
 dMoOjIv4e6m5q5owTxk9bwWFYNKK+o8=
X-Google-Smtp-Source: ABdhPJzUE/AqNb4opXv4O8ZwgCueq5xSGvPPv7l4TrfuuCD+oynNYm9CkPrHOxrUs2a/YbeCdd6RIg==
X-Received: by 2002:adf:e681:: with SMTP id r1mr13096882wrm.181.1603005199418; 
 Sun, 18 Oct 2020 00:13:19 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id j7sm10604456wmc.7.2020.10.18.00.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 00:13:18 -0700 (PDT)
Subject: Re: [PATCH 5/6] ppc405_boards: use qdev instead of legacy
 m48t59_init() function
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1602965621.git.balaton@eik.bme.hu>
 <cbd0085a1b503deeb3bebe56d5d10ce14c8113ee.1602965621.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2445e37f-c91f-f9f7-509f-2181b84ceb82@amsat.org>
Date: Sun, 18 Oct 2020 09:13:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cbd0085a1b503deeb3bebe56d5d10ce14c8113ee.1602965621.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Herve Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 10:13 PM, BALATON Zoltan via wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc405_boards.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 6198ec1035..7a11a38831 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -28,6 +28,7 @@
>   #include "qemu-common.h"
>   #include "cpu.h"
>   #include "hw/ppc/ppc.h"
> +#include "hw/sysbus.h"
>   #include "ppc405.h"
>   #include "hw/rtc/m48t59.h"
>   #include "hw/block/flash.h"
> @@ -227,7 +228,7 @@ static void ref405ep_init(MachineState *machine)
>       /* Register FPGA */
>       ref405ep_fpga_init(sysmem, 0xF0300000);
>       /* Register NVRAM */
> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
> +    sysbus_create_simple("sysbus-m48t08", 0xF0000000, NULL);
>       /* Load kernel */
>       linux_boot = (kernel_filename != NULL);
>       if (linux_boot) {
> 


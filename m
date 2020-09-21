Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A37C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318C121789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="qTWP2mKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318C121789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKS8J-0008A3-TX
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 16:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRwy-0002Mz-Sg; Mon, 21 Sep 2020 15:58:12 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:41522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRww-0001ui-E5; Mon, 21 Sep 2020 15:58:12 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 32AF121CC5;
 Mon, 21 Sep 2020 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600718286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MnCSi9KZji0ZefXd77EJJA9Qszak5xyeEkMp8GdcrQ=;
 b=qTWP2mKTGTcep+PAmno6DCSy5xSfwOZz+qF6mjnPKFRdvxZ7nZmM1+kTdLAjrEXVKAoNjs
 2oWHOsbC/PTyCn5/ZlTdRxu17IwL4/qLSgQYKnuyh3O2SyIqu4kMpLjQ38VehEYlpTwdHI
 KwYqBOyjRGFTLQp2Q/9LG3au6ALgBWo=
Subject: Re: [PATCH v3 7/8] hw/arm/raspi: Use RaspiProcessorId to set the
 firmware load address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200921075628.466506-1-f4bug@amsat.org>
 <20200921075628.466506-8-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <5f27aed1-15a6-0cc2-1d24-750efdffe234@greensocs.com>
Date: Mon, 21 Sep 2020 21:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921075628.466506-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:38:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

Just two small typos in the commit message.

On 9/21/20 9:56 AM, Philippe Mathieu-Daudé wrote:
> The firmware load address depends of the SoC ("processor id") used,
"depends on"
> not of the version of the board.
"not on"

Otherwise:

Reviewed-by: Luc Michel <luc.michel@greensocs.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/arm/raspi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 0d8e5a34c78..ae98a2fbfca 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -238,7 +238,8 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>        * the normal Linux boot process
>        */
>       if (machine->firmware) {
> -        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
> +        hwaddr firmware_addr = processor_id <= PROCESSOR_ID_BCM2836
> +                             ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
>           /* load the firmware image (typically kernel.img) */
>           r = load_image_targphys(machine->firmware, firmware_addr,
>                                   ram_size - firmware_addr);
> 


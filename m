Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D05BC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0128F20791
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="vDmsE2gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128F20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKS06-0004UC-U4
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 16:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRt7-000801-Fn; Mon, 21 Sep 2020 15:54:13 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:41298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRt5-0001JH-QC; Mon, 21 Sep 2020 15:54:13 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 7710221CC5;
 Mon, 21 Sep 2020 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600718049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XVbwrUEvUKZdJ79HWuQzHiiHHBy19dq2igKd7smsJo=;
 b=vDmsE2gZofSdG4pQk4hYS7h8nf5XTSO27W3JyoHmaLqFMAOPWtXoUk2PxPjsd+3Qu9zpvy
 Y68/5ZVPbGjFEmzARygyaHmGPVRGAK8BUfK3mKSBeb/1K1QBr147ZLvJDc36PLDva0PcGr
 3xgUtvi19737+OUYzKzzezBZCpl042c=
Subject: Re: [PATCH v3 2/8] hw/arm/raspi: Load the firmware on the first core
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200921075628.466506-1-f4bug@amsat.org>
 <20200921075628.466506-3-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <7aaea771-0dae-6bac-c1c0-2325e035f484@greensocs.com>
Date: Mon, 21 Sep 2020 21:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921075628.466506-3-f4bug@amsat.org>
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

On 9/21/20 9:56 AM, Philippe Mathieu-Daudé wrote:
> The 'first_cpu' is more a QEMU accelerator-related concept
> than a variable the machine requires to use.
> Since the machine is aware of its CPUs, directly use the
> first one to load the firmware.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   hw/arm/raspi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 46d9ed7f054..8716a80a75e 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -205,6 +205,7 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
>   
>   static void setup_boot(MachineState *machine, int version, size_t ram_size)
>   {
> +    RaspiMachineState *s = RASPI_MACHINE(machine);
>       static struct arm_boot_info binfo;
>       int r;
>   
> @@ -253,7 +254,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>           binfo.firmware_loaded = true;
>       }
>   
> -    arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
> +    arm_load_kernel(&s->soc.cpu[0].core, machine, &binfo);
>   }
>   
>   static void raspi_machine_init(MachineState *machine)
> 


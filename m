Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA5EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE1A20714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="vD5qTZ2u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="hkMg7kv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE1A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRqoh-0000zx-Lt
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 01:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kRqnJ-000085-H6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 01:54:49 -0400
Received: from relay1.mymailcheap.com ([144.217.248.102]:36155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1kRqnH-0000kp-OI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 01:54:49 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id D19B93F201;
 Mon, 12 Oct 2020 05:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id B27E72A0DC;
 Mon, 12 Oct 2020 01:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1602482085;
 bh=WFO6RoU/pTv4L8Ma5M4Z6Py5qzJgp8rpu+L26U709VY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=vD5qTZ2uQcgyYjKPQOXWkyji1AaHr3ubDvAXkb9+h7dI8e3sGSiUszqyOfkJeqCGT
 2zNwbRe7+L1mnzcKF5ThLA/QBts4t3k/zWjY/pmFFIVhlIfCoubOxOAXDdicWNwl0L
 Rh0UTjgtJcE21WSsdbCs0dpgSqpJjLtGA+VYvUd0=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1L9HZaTWrOA; Mon, 12 Oct 2020 01:54:44 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Mon, 12 Oct 2020 01:54:44 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 79EED40FE1;
 Mon, 12 Oct 2020 05:54:41 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="hkMg7kv0"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (li1197-90.members.linode.com [45.79.98.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id A70C840FE1;
 Mon, 12 Oct 2020 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1602482076;
 bh=WFO6RoU/pTv4L8Ma5M4Z6Py5qzJgp8rpu+L26U709VY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hkMg7kv097X6VBhyEjZYMGNXnYnWlaGcZkMuVh6ia390rJjzcfAZnhoAwXo7wNg/a
 B9ITCcUD0pnANNsRcUWcULRNh/1z6tJjC+hUs5O5Gsb+0svqsY3aHDuoeiHqv0f30b
 hIv6Lk1MIGdtq4UgunYOm858mR6hG4BTvV3VX+Lw=
Subject: Re: [PATCH v3 13/20] hw/mips/fuloong2e: Set CPU frequency to 533 MHz
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201010204319.3119239-1-f4bug@amsat.org>
 <20201010204319.3119239-14-f4bug@amsat.org>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <d80ff10d-b4f2-d510-3f87-7e3f74f504fe@flygoat.com>
Date: Mon, 12 Oct 2020 13:54:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201010204319.3119239-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Rspamd-Queue-Id: 79EED40FE1
X-Spamd-Result: default: False [-0.10 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_SPF_SOFTFAIL(0.00)[~all]; ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCPT_COUNT_TWELVE(0.00)[15];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 FREEMAIL_CC(0.00)[linaro.org,gmail.com,greensocs.com,kernel.org,lmichel.fr,syrmia.com,lemote.com,twiddle.net,redhat.com,reactos.org,aurel32.net];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=144.217.248.102;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:43:18
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



在 2020/10/11 上午4:43, Philippe Mathieu-Daudé 写道:
> The CPU frequency is normally provided by the firmware in the
> "cpuclock" environment variable. The 2E board can handles up
> to 660MHz, but be conservative and take the same value used
> by the Linux kernel: 533 MHz.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks

- Jiaxun
> ---
>   hw/mips/fuloong2e.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index b000ed1d7f7..b25c3df19d0 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -28,6 +28,7 @@
>   #include "hw/isa/superio.h"
>   #include "net/net.h"
>   #include "hw/boards.h"
> +#include "hw/qdev-clock.h"
>   #include "hw/i2c/smbus_eeprom.h"
>   #include "hw/block/flash.h"
>   #include "hw/mips/mips.h"
> @@ -300,10 +301,15 @@ static void mips_fuloong2e_init(MachineState *machine)
>       I2CBus *smbus;
>       MIPSCPU *cpu;
>       CPUMIPSState *env;
> +    Clock *cpuclk;
>       DeviceState *dev;
>   
>       /* init CPUs */
> -    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
> +    cpu = MIPS_CPU(object_new(machine->cpu_type));
> +    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
> +    clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
> +    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);
>       env = &cpu->env;
>   
>       qemu_register_reset(main_cpu_reset, cpu);


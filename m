Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9478208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0VcNqXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9478208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvIo-0007Nk-Fh
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40805)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hcvGr-0005k0-7s
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hcvGq-0007Od-4v
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:18:17 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:47073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hcvGp-00075I-TC; Mon, 17 Jun 2019 13:18:16 -0400
Received: by mail-lf1-x144.google.com with SMTP id z15so7057688lfh.13;
 Mon, 17 Jun 2019 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p4qnA9oL0BPxkrOSqqsQYJaOB8IB08w7HDDnpsjfjTA=;
 b=e0VcNqXN9I3TQJRvm+HJUA6JLogFMS+eeQKnk7uwnmJ2ejpHMBuO7TiZPjc/TZHojF
 XHpGk1IjZfsFuDYJB/GPMxtpQc0PFgDEGVDNCiHLKWnUDMYUMI4MTiCPr961CWkmu9oz
 pnYIT2k47WZbs2i1zlFXI9OU2L9LhM4Y7uU2FETV/yYGTLOcCseoW2xoCQ0CRn8AdPkl
 wJYaSM7/XZ+8N7yVaUb9UauJaDaFWeNVUaFGKCfll75V7WhI1xzHw1YCWUyBU4849idh
 Myigavlp0KJsZleLm0pbHZs2zbmS22LEWR+GVOm9k4ZvcHkZ2Ez1wbDPrLeJx8f08gHM
 atyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p4qnA9oL0BPxkrOSqqsQYJaOB8IB08w7HDDnpsjfjTA=;
 b=XR9cxfVRSz6XwgmVcKcXJ3xMEHu6xNBNG4gCNAQwRg49Tneqqea+HzCOwv0nOUI4T/
 B8BvAgCyHChihUeWQJzZ12sFLlPOAsevkB9I3jkdLiHB3Ug852W6rggRBbLoUiMoH5Gx
 NEW8CKm7L/c6sfobCpE9kDSsBcE8TmdSQpPLn7iWfQcnSRhCJdGgDqdvmqHCq5eJVbC0
 1h1TbsPea+WDjVUSYVEi6c43vh7l+1QPAw+/zO+BTt095ebS2or2O85Z+5ZUU0+amxR+
 q9C9aLjLqp/HSw2Ry3exA3q92eC3se63N+DGDxFwAmB8A0cjvA2WpF81KxgZvRWM0uF0
 dYhQ==
X-Gm-Message-State: APjAAAUAmL9On42sVPKtA3mgKCQwbyk2tUASphyXAbGWIb7PKmYxMx2U
 qMy/YhEBpOnLrank/uA7dpyyX4MYH8qvXV0PDDk=
X-Google-Smtp-Source: APXvYqx84IGvzvYHoQ5QfK+b0Z/UEb6gtRtKILRCDTbE0b1kqw3wu/jwy5vwE05gPyTc3IA31ubC9sdKTlwm7pDkEoQ=
X-Received: by 2002:ac2:5324:: with SMTP id f4mr15421710lfh.156.1560791881225; 
 Mon, 17 Jun 2019 10:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190617160136.29930-1-philmd@redhat.com>
In-Reply-To: <20190617160136.29930-1-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Jun 2019 10:15:14 -0700
Message-ID: <CAKmqyKOc-ZnGhUgsBzHx2oGoBCoKStTHVWySUqP5kF88LvuqTQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] hw/arm/msf2-som: Exit when the cpu is not
 the expected one
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 9:19 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> This machine correctly defines its default_cpu_type to cortex-m3
> and report an error if the user requested another cpu_type,
> however it does not exit, and this can confuse users trying
> to use another core:
>
>   $ qemu-system-arm -M emcraft-sf2 -cpu cortex-m4 -kernel test-m4.elf
>   qemu-system-arm: This board can only be used with CPU cortex-m3-arm-cpu
>   [output related to M3 core ...]
>
> The CPU is indeed a M3 core:
>
>   (qemu) info qom-tree
>   /machine (emcraft-sf2-machine)
>     /unattached (container)
>       /device[0] (msf2-soc)
>         /armv7m (armv7m)
>           /cpu (cortex-m3-arm-cpu)
>
> Add the missing exit() call to return to the shell.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/msf2-som.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index 8c550a8bdd..2c9984bb3b 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -53,6 +53,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machi=
ne)
>      if (strcmp(machine->cpu_type, mc->default_cpu_type) !=3D 0) {
>          error_report("This board can only be used with CPU %s",
>                       mc->default_cpu_type);
> +        exit(1);
>      }
>
>      memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
> --
> 2.20.1
>
>


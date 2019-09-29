Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4FC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 15:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D692D217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 15:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujjk9gDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D692D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEbYz-0001tv-VH
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iEbWm-0000pv-Bo
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iEbWb-00080L-3s
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 11:54:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iEbWa-0007ED-TQ; Sun, 29 Sep 2019 11:54:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so8291783wrt.2;
 Sun, 29 Sep 2019 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=pvfC2gT+1fyxF8HNPDqCWPRGayLN9bCE9RC7HdlOIzM=;
 b=ujjk9gDd7wpRzGtbN7/gZh8/iHk5WuOIveHcgGQqI/SU1I2q6LLZlCrsynlSmlbIYS
 R1l0I4ky8czXMQ19btkJ4mWJvV12DXx3FUHLYAAyNT9MrQfg610U2AByfT3DS/NEnLJC
 HMOxaRMlx2MVLxnHhkNCGctHcZkGohw70YMNmYE282AvivOiZob/6qzh/1E3hdSIEYEa
 36vL6dWJ4XaBi07C43y4WwEidVftrxATkv2vIkmtR0mWJ76PLmkwmTad+z2vpMv0KzFi
 7uR7W7Z/UY+Z6THv+TqvIan1w7nueCayZxxT6zHQNlRy5wFqmnu1yRn2Ps/NK4hGGy8H
 rWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=pvfC2gT+1fyxF8HNPDqCWPRGayLN9bCE9RC7HdlOIzM=;
 b=qBpixyX3XNoFCmCZkpKBXWGalep1lVAtPgM6dAKuxN6tmabOVjdj2Rz9ejecw6JdNS
 aWZXbB5sexkqloRV5H9KrU1NIhTRevcnfEgyWFs4cnSSUT0Qjt5SCSodfZAe2Y8CZID6
 bkB0yPKPYO2mOHu3sNAF4IXxaR4Z4unocnVs7BZFHihOCiFgijlrupYWE4+tv4IJ2ya+
 sju94lZXjLSHQGu0LCg64gl6FSVqYJtj/P9DkH9eUnzcGeDyWWTcZDr+vt6CSNvaipCN
 pdS5TTPjExnXZ1N1FC4Vyi/D8Ph99Qi5hnB1fBSVm2ev0e00DnrK41eU5DEL1QCUCkKc
 KIug==
X-Gm-Message-State: APjAAAWe9z+m8ZK0cpcyJyNZGMglKaqJyu9YFed2s50YoOdCMLH06JHn
 yJ/NaOZkSQhTscXAVfIwwNE=
X-Google-Smtp-Source: APXvYqzOqjCna4GK+zLGgS88URXhURLokULvQQJbx5x1WdVGme8uRzkJj+I6tmFsDtpiNojbN6a8xA==
X-Received: by 2002:adf:cd86:: with SMTP id q6mr10030651wrj.153.1569772442036; 
 Sun, 29 Sep 2019 08:54:02 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id n8sm22302088wma.7.2019.09.29.08.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 08:54:01 -0700 (PDT)
Message-ID: <c8a8c7758104a1a5fe052743b5a22d3a1353de91.camel@gmail.com>
Subject: Re: [RFC PATCH 14/14] hw/arm/raspi: Add the Raspberry Pi 4B board
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 17:53:52 +0200
In-Reply-To: <20190904171315.8354-15-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-15-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
> The Raspberry Pi 4 uses a BCM2711 SoC (based on a BCM2838).
> The SoC can handle up to 8GiB of SDRAM, but we limit it to 4GiB
> (no 8GiB models in the market yet).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index b4db39661f..59ee2f82b4 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -39,11 +39,13 @@ enum BoardIdChip {
>      C_BCM2835 = 0,
>      C_BCM2836 = 1,
>      C_BCM2837 = 2,
> +    C_BCM2711 = 3,
>  };
>  
>  enum BoardIdType {
>      T_2B = 0x04,
>      T_3B = 0x08,
> +    T_4B = 0x11,
>  };
>  
>  enum BoardIdRevision {
> @@ -56,6 +58,7 @@ enum BoardIdRevision {
>  static const char *processor_typename[] = {
>      [C_BCM2836] = TYPE_BCM2836,
>      [C_BCM2837] = TYPE_BCM2837,
> +    [C_BCM2711] = TYPE_BCM2838,
>  };
>  
>  typedef struct BoardInfo BoardInfo;
> @@ -90,6 +93,12 @@ static const BoardInfo bcm283x_boards[] = {
>          .ram_size_min = 1 * GiB,
>          .ram_size_max = 1 * GiB,
>      },
> +    [4] = {
> +        .board_id = 0xc42,
> +        .board_rev = { T_4B, R_1_1, C_BCM2711, M_SONY_UK },
> +        .ram_size_min = 1 * GiB,
> +        .ram_size_max = 4 * GiB,
> +    },
>  };
>  
>  typedef struct RasPiState {
> @@ -336,4 +345,24 @@ static void raspi3_machine_init(MachineClass
> *mc)
>      mc->default_ram_size = 1 * GiB;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)
> -#endif
> +
> +static void raspi4_init(MachineState *machine)
> +{
> +    raspi_init(machine, 4);
> +}
> +
> +static void raspi4_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Raspberry Pi 4B";
> +    mc->init = raspi4_init;
> +    mc->block_default_type = IF_SD;
> +    mc->no_parallel = 1;
> +    mc->no_floppy = 1;
> +    mc->no_cdrom = 1;
> +    mc->max_cpus = BCM283X_NCPUS;
> +    mc->min_cpus = BCM283X_NCPUS;
> +    mc->default_cpus = BCM283X_NCPUS;
> +    mc->default_ram_size = 1 * GiB;
The comercial models are: 1, 2 and 4 GiB. Why do you choose 1 GiB as
default?
> +}
> +DEFINE_MACHINE("raspi4", raspi4_machine_init)
> +#endif /* TARGET_AARCH64 */
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>



Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612EBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295F5206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4aDVhnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295F5206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixB8p-0000Hh-Bi
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ixB7y-0007qs-Gi
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ixB7x-000087-EM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:49:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ixB7x-00005A-3Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:49:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so4555302wma.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=kMhzUeveepxyKpMH/W5N9hLcHtE1Kufs05P0GwzNzjg=;
 b=D4aDVhnU7rNI654tnzgAVsQyMAeC95Mp0Kbce4byIr7DJkB0LdABPR54CuMnni2xE8
 MuJTkLCr1kjLuwGraUWDhIB7Jd2pNRFQRmgkJtyJi9UCCyFO0L54kEliqx9ir1+HFG9b
 egGJqT0FjUZdAweMBbBd+fcCSjffXdaRi76f3RTobHAIcWJv6Kb94X7RT5Bwb+xDnDyf
 4d0q+Ss2eoj0T7cTfwnGAsF3udC2SB+ODDWRF3LBqq2L7XMVup1lJUR0IXPH9dIxJpem
 oJPBmD6cHXzRCr9YQmM01/v3Lwy9zj/Bs16EnRtUuk5v2fgLsGwziicWv95dHKKiCpB1
 vIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=kMhzUeveepxyKpMH/W5N9hLcHtE1Kufs05P0GwzNzjg=;
 b=Xnj0AZ6tEn2m/c5npZv5h7xmziymLUGN5+7i12FCbVnYLKQT8KzjsFFbARN4PCDA+d
 8vi3KcvjiSabRsPCsCDCJPuxK3whOuHVC+1x442QAdeXutK76sZlc+gcXJX59DZgOz8A
 qHy/N9/tBM/oWxtXEdbLwa2fKjssuRsNJtRWW98YFz83055Q9+IdbeGpzq/FGJJV4A/R
 x/ucUVVISQiK12M6PywZhAkWC0FYVDBlmfjw2kaVFO8bPPKzzaSuJ/ZqtGd+kdoAsPxW
 9syeawlwR7WtsqhrI16gHIO3dADOurGqOj7ol90gdp28rBuvMPjot+ubz+CGXpv1fEDh
 0nbg==
X-Gm-Message-State: APjAAAW3Pxe/KImaSEH3oA6QDw9hfv+IGMZzUkUlLuCSMT9eeopuYdPJ
 /Xkrqw2C7+WepojpdNpEppiF+Q==
X-Google-Smtp-Source: APXvYqz3pbtbmnh3zLbqBhiOVAzAQ0es6y98s5yLzt0PtLvFq8OjVsIu+vAAlMcC/b3PQJAADjlVxQ==
X-Received: by 2002:a05:600c:146:: with SMTP id
 w6mr6429232wmm.180.1580395743781; 
 Thu, 30 Jan 2020 06:49:03 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
 by smtp.gmail.com with ESMTPSA id s16sm7814666wrn.78.2020.01.30.06.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 06:49:03 -0800 (PST)
Date: Thu, 30 Jan 2020 06:49:03 -0800 (PST)
X-Google-Original-Date: Thu, 30 Jan 2020 14:48:47 GMT (+0000)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
CC: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, sagark@eecs.berkeley.edu,
 Atish Patra <Atish.Patra@wdc.com>, 
 anup@brainfault.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Anup Patel <Anup.Patel@wdc.com>
To: Anup Patel <Anup.Patel@wdc.com>
In-Reply-To: <20200122112952.94284-3-anup.patel@wdc.com>
References: <20200122112952.94284-3-anup.patel@wdc.com>
 <20200122112952.94284-1-anup.patel@wdc.com>
Message-ID: <mhng-89da94b9-64c1-43e7-ae24-5a21ffc6d695@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 11:30:36 GMT (+0000), Anup Patel wrote:
> This patch extends CLINT emulation to provide rdtime callback for
> TCG. This rdtime callback will be called wheneven TIME CSRs are
> read in privileged modes.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_clint.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index e5a8f75cee..805503dc27 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -236,6 +236,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>          if (!env) {
>              continue;
>          }
> +        riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
>          env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                    &sifive_clint_timer_cb, cpu);
>          env->timecmp = 0;
> -- 
> 2.17.1

Can you make this optional?  Ideally via a command-line argument, but at a
minimum as via the board configuration files.  As it stands this will enable
the direct rdtime implemnetation everywhere, and while that's sensible for the
virt board I'd prefer to avoid changing the behavior of the sifive_u board in
ways that differ from the hardware when that's easy.


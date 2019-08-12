Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC674C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 08:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B111820820
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 08:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovu2qf6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B111820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx5uE-0003Ax-33
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 04:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hx5tp-0002jM-N9
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hx5to-00022m-J8
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:41:53 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hx5to-00022Q-AD
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:41:52 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so150079396otq.6
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y06vg75D8oXVgYOOQOwaINkYsIizY/RxyFIyjAmugSk=;
 b=ovu2qf6yRQn6xO/MsvaI/m5FRrmPOnFhTVh1AOtQ0fJRJQDEYdzlJvGcI5iy69LmXG
 NyXCVNMMbOac14ADMdValNdCCkceA5t1/vpOx2OtddjB02YxarGBaK/oqygVGKGe57Xn
 02G08M5OIPgcqsllioAMhbMRpXlNNK+SzmBqraGIMlw5XqvRqj9/bdyyNkWlmfXFUM70
 FvMOT9b3cJryb+MK2Kg8q55XBLZz4Vt+7oeHhKQYi7MZzjQ+DyKgtDlowI6gNeRIhpPi
 Qo9A0WV0+JyvIuRKe3rbwN9l9p9/5Xls+7mFxFfPNdmtmGosDubrJ6xycPtCT6fdhbfZ
 4dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y06vg75D8oXVgYOOQOwaINkYsIizY/RxyFIyjAmugSk=;
 b=PTEM0Db00bD1UCWy6WOzd/oiKKbAytulpwd4Rzq4c9Awaw0xA8qJnVBfdv9l9U0ZcA
 y/+6xUnVCxnymBh4XAoxo3goiPC0gMNRHstITtXD6p0ummRN2LFHIkrWxClNKErICki7
 zurJ3L8K4LfbMkCi0zwIaF9sLyih/EnOBNtsm3R7PdLDGsprsjEt7GEgXDAMABB6GKwi
 H3JgU82Wu4bRdDG2ZDre3wg4QAO5vk/6Zx6i+24cURgQyXTgWCKH3FEEPO02izSa4G7U
 /FHvPE/G4caJcrBsg/rUp1LAPLjGn6+hVlRikd4eFjjYgSoe46gGnElqrZJW/Q4HLA6H
 +ypQ==
X-Gm-Message-State: APjAAAUkXwjcJPTk1IbYLbIvnYqAxUUGf+opGeGHcdRrO8bZw1Aei/R0
 JRW8Yn21Alvnp0t1EoOMu0NCqwi/Or7o2653mEyYQQ==
X-Google-Smtp-Source: APXvYqw6kvvf+WoKMYpt3d/uJBhoG1ZluIie3intfBw5xF65II5FHZ5ydcL24wyolf2AmHqmtJLisZyU03ZyovNeOnI=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr29968830otn.135.1565599311566; 
 Mon, 12 Aug 2019 01:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563302751.git.alistair.francis@wdc.com>
 <202a2df9cd8e3de2555295446ff1a144eef61eeb.1563302751.git.alistair.francis@wdc.com>
 <mvmwofizw6s.fsf_-_@suse.de>
In-Reply-To: <mvmwofizw6s.fsf_-_@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2019 09:41:40 +0100
Message-ID: <CAFEAcA_v_qJKVgX8dsxwnGpw1cR5bN_CHAhA=kGbQtXEsa0wSg@mail.gmail.com>
To: Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] roms/Makefile: fix command for
 opensbi64-sifive_u
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
Cc: Stefan Hajnoczi <stefanha@gmail.co>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Jeff Cody <codyprime@gmail.com>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@sifive.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, Guenter Roeck <linux@roeck-us.ne>,
 Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 at 08:20, Andreas Schwab <schwab@suse.de> wrote:
>
> Copy the correct firmware file
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  roms/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index dc70fb5aea..775c963f9d 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -183,7 +183,7 @@ opensbi64-sifive_u:
>         $(MAKE) -C opensbi \
>                 CROSS_COMPILE=$(riscv64_cross_prefix) \
>                 PLATFORM="qemu/sifive_u"
> -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> +       cp opensbi/build/platform/qemu/sifive_u/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>
>  clean:
>         rm -rf seabios/.config seabios/out seabios/builds
> --

Hi Andreas; this looks it's the same issue fixed by this patch
from Bin Meng sent last week:
https://patchew.org/QEMU/1564812484-20385-1-git-send-email-bmeng.cn@gmail.com/

thanks
-- PMM


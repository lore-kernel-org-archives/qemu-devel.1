Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0086C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFF82147A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOeFYTAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFF82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hugQF-0007Xn-Pt
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 13:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42480)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hugPt-00077h-D7
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 13:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hugPs-0001XF-GK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 13:05:01 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hugPs-0001Wf-9K; Mon, 05 Aug 2019 13:05:00 -0400
Received: by mail-lf1-x142.google.com with SMTP id p197so58552833lfa.2;
 Mon, 05 Aug 2019 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gg/AJ/YQXrRQridwda33+ngtflOxLxCDvR7Vm4OQ0Fc=;
 b=FOeFYTAYiFLZajzIH0mhR6HuGy4IvrLyUICm+5bjupCcy/YBNqeQfSfqiH1bXj2Bjb
 VaO65JJvZIf/2kYz376ViBXKcgspC5t38eWNlvnJjPJox2kxKyGxcw3EP6L4QGlPa6fQ
 m4EJIiz1bhbSXDPquA3hTEDabaY+HS+S8Fuv5AMh7gBfh09P4Aty7Brwnv2XTZmboTdf
 FKy4z3y/ISN1eUoBIsIHsTkeqf3k4hbdSnKeIou+1Og2oKv7d1aajzCEVg+ZvNiHuL/S
 kqQje3D5ur73qSCM5MXae0HHhSxaSNz6BCzkk+XK+YLJMtW88X1QvCUjmN/a687ysW1s
 Wbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gg/AJ/YQXrRQridwda33+ngtflOxLxCDvR7Vm4OQ0Fc=;
 b=XcxP7ussfvijgl3lnGc0Mzn+B/C3CywNf+fnnM+WxJo56vI07iTyvdDa/iHuXtJ6Gu
 a/avDPYRU8eNn8RDIRx+p0PdNtP6xpe/xvpmNHAiG1KCzAqQN3NqQfqTLfG5dlev6jh7
 tlNmpryKGtV7Tn+ZOFKUIhIfXfbH+6YIsH8Xxc3CFJeXweO/7uIg3MAphfzeRCYjuW7m
 yENjavOIir+2JuaDrfFYljFl16raiAcN2jkI+kb5+qEXM4xi9OwHnMsOsowjYbBxJq5N
 g/RnAXFo4cnAxkQKErRJT9KkCtWU/V6ogpGmAFJ1k7MPMRwqLSBm1qPgkaVjHr13i3Dw
 43WQ==
X-Gm-Message-State: APjAAAXkZYqrjEvZdKgnWyuAAuGTDBl3JhJAoJwEJ/CZ1ZvNN/hdUVHW
 wObtrrqTBdYQIEo4OLL2ZDItWSljlbnxtaqgfUeKpoBh
X-Google-Smtp-Source: APXvYqzNMeiMrZm/T3V0PiCJlKn6f47r88cWxFv+f21OC9RPNcLKbpSwPCe9kzAps77TxIzb2jZvjuu+e5qQvqt/CSU=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr58313554lff.93.1565024698485; 
 Mon, 05 Aug 2019 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 10:01:18 -0700
Message-ID: <CAKmqyKPW-nMc2zV-VwG_sY9ca7uSenUJW+mEcV2qaKT5dELmgA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [FOR 4.1 PATCH] riscv: roms: Fix make rules for
 building sifive_u bios
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 2, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Currently the make rules are wrongly using qemu/virt opensbi image
> for sifive_u machine. Correct it.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Good catch.

@Palmer Dabbelt can you take this for 4.1?

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
>  roms/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index dc70fb5..775c963 100644
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
> 2.7.4
>
>


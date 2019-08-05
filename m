Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC3C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2DB205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a5gWgFDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2DB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXH5-00021t-PW
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1huXBh-0001se-14
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1huXBf-00037G-2W
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:13:44 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1huXBd-00036G-2C
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:13:41 -0400
Received: by mail-io1-xd44.google.com with SMTP id k20so11961262ios.10
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NyuxMo6Lz6AGtZo584o2I6qBlHqY92fe2F0vBgo45qw=;
 b=a5gWgFDoqu68WsAI3Juxo5s6+VGxatY3nbTqDpDecH7g7UlXYK9O9B9+nYJ1yxZJaA
 rVj3bWAu97LfmRywESzTzpWY6fhC7HdH85NNSC2G9Am//nQrEvaoQ90CiZtrcUpNBsmE
 yPnyGalUwkilVXunQSRz5gEDO3Fhj7T3xZm9kJHPVJzkdBO23qURJ8PAShBneAo2x6fT
 IsaCbXtBAPLyHCFuexzyNyJAVrEA8SI5nr4556Rw8vEKzCnvhNNlN5F+FiWHHkRa/7ZG
 b7qgfboatQ9jLUjKXtsYbtwGCfrjyT/k+gz4tptv/MONqkp/ZI54txLB+pUzpgg4ECYe
 3+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NyuxMo6Lz6AGtZo584o2I6qBlHqY92fe2F0vBgo45qw=;
 b=LrVc/deZZy74jRy/rzkY+cs/f0xErHOUWmXnSOEjU6yren98q58Bbq58pIP1BPbmsl
 QydP26zkC3j6r8DDaXrkcBzrRhuiNma1e3YqYqPFmNkisWVYl1+IgMwA77C4mC8DCkXR
 P4ghf6pcW8brvGEzczUBmODBOfYvOqY6ONWisCXccmxsEFtYPlOnZnNP/PnoYiy4LJYc
 /Fls583TVi+ccTt7D+eqtHFifHpbKmFyYFkbSU67HENDQfZtH93H3caC9EzZ27WS4YeU
 RH7RYllAJix+EwrH46cucPGXH64vu+/C8R9NzWIASrYHm5p7qZf4hFq32uxCZp8c8NOK
 DcsA==
X-Gm-Message-State: APjAAAWXr3ohQ2DtX23ge80RhkG/8reqHaNU85LhntLCSNuU0WHUp6kA
 3BCYeP43C+vEc2cyg4OggbBspWN8etGTqTV15sJvIg==
X-Google-Smtp-Source: APXvYqzl40yVpYMwuGa9jP0xUHZ6Nhiq6W4dLrEQRRfrWPuSt1tAqMpoCfdNGZ3KxZUHFpGBr2sitxhFNiPdvQD9Vtg=
X-Received: by 2002:a02:a07:: with SMTP id 7mr154561604jaw.65.1564989220213;
 Mon, 05 Aug 2019 00:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Mon, 5 Aug 2019 15:13:27 +0800
Message-ID: <CAEiOBXW5Z5Jp7ooR+TQ5HcAdW2MoVTZQ9kZsqqw5P-yaPWtVUA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [FOR 4.1 PATCH] riscv: roms: Fix make
 rules for building sifive_u bios
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

On Sat, Aug 3, 2019 at 2:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> Currently the make rules are wrongly using qemu/virt opensbi image
> for sifive_u machine. Correct it.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
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
> -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin
> ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> +       cp opensbi/build/platform/qemu/sifive_u/firmware/fw_jump.bin
> ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>
>  clean:
>         rm -rf seabios/.config seabios/out seabios/builds
> --
> 2.7.4
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

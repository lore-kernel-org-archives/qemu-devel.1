Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD82C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190582070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcD238xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190582070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HQL-0002zD-Sd
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6H8K-0000Pm-Bo
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6H8J-0001MI-3S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:30:48 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1i6H8I-0001Kn-TF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:30:47 -0400
Received: by mail-ed1-x544.google.com with SMTP id p2so5648967edx.11
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XYWOlu0JcjQMa8KG/bAxzxnQtsjmKwqz4I8uac6dnQs=;
 b=DcD238xw/E3bqqpc0HYLlhZq24feJPN/Ell/qCtt8RWSHwDsop5ZHGEhhvwjq/t+wg
 jnoFfItMp/gAdMhofYfl+r22UtqwyKr/HJOefvzNw81z5uUi//T3GJQTw+TwWRPx+o1/
 5r93mI9vCTYZvRBCUbejjrxr6cQw7yRU/tlASkH2K4JwPMu4bbWr82FOnITeClWnTwQw
 oQqW7/vmK4trCrpSPstf5e+PCJeQwzjmE0gTlT03oFLvyQnv98oSnL7EnoStqPa8Nc8K
 obKYOUVAlRzw7uJQTfwR5hoJCldIUq7gtzKR2EZ9QD1yoGPLbn0U7kb6QUVivHQlpWfA
 RDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XYWOlu0JcjQMa8KG/bAxzxnQtsjmKwqz4I8uac6dnQs=;
 b=lnXTtQRhnixeeuvFJEy5oEILgiZy/Z5tqsecGYhZtiSL1RSxcjWRB7FQ8+Cu/ArVM+
 3zyrZHskz3YyLk/6FNoXZ/2mrxyb/M3+tLDyAQLTlCnVnCLFhIgQ6ODQtnLUTaydXBMf
 P/p23G6mNzRmNkdY/KaMIlEHzcR//QhmCTMO/pb8rY1HQim5lTHzWQVcZuFSiE27UhjN
 6WsftnEbo4f9VkHaJDXAjeCcyOlGzd/VkCFm/jjQJDom/G+R3CzcihUj8HQxt7laetCa
 ksC0GBUFpmXKuPm0nqZmYcl/LIc0MnlCcAa8kpvK31TmypmbHnJtbmwIskmu2A2NzFtP
 IQ4A==
X-Gm-Message-State: APjAAAVZoOw8QtHaGHEocVLSx0bPg+zBk0gsiE35hwQXkE0TweVMGYAn
 UwiKBXm34MJje6aIUL/8V50kLYfG6OQwsz8V5WI=
X-Google-Smtp-Source: APXvYqyxVqapPywCTxnJQ4LBTTtvBvOCef2ZMQ1Mtrqj5Xjs1m1n0dG65Ja8JJjAzpja5nZ245hhMR/gOFC6o9rdQa4=
X-Received: by 2002:a17:906:b254:: with SMTP id
 ce20mr8184669ejb.129.1567787445801; 
 Fri, 06 Sep 2019 09:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <1567782585-19854-1-git-send-email-bmeng.cn@gmail.com>
 <CAEUhbmXJA_L_TwF16sZD9rUsFXAmbg-b6ABCUrbJTOTVfZORgA@mail.gmail.com>
In-Reply-To: <CAEUhbmXJA_L_TwF16sZD9rUsFXAmbg-b6ABCUrbJTOTVfZORgA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 7 Sep 2019 00:30:34 +0800
Message-ID: <CAEUhbmX9dqSY4TqVtb-FLvjdaACVcsynvvp-KhEW+ePajNDWKg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] riscv: hw: Remove duplicated "hw/hw.h"
 inclusion
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Fri, Sep 6, 2019 at 11:22 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Sep 6, 2019 at 11:09 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
> > added "hw/hw.h" to sifive_prci.c and sifive_test.c.
> >
> > Another inclusion of "hw/hw.h" was later added via
> > commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
> > resulted in duplicated inclusion of "hw/hw.h".
> >
> > Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  hw/riscv/sifive_prci.c | 1 -
> >  hw/riscv/sifive_test.c | 1 -
> >  2 files changed, 2 deletions(-)
> >
>
> Sigh, I just realized that this patch has inter-dependencies with the
> following patch series:
>
> riscv: sifive_test: Add reset functionality
> http://patchwork.ozlabs.org/patch/1158526/
>
> and
>
> riscv: sifive_u: Improve the emulation fidelity of sifive_u machine
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=128443
>
> Thus cannot be applied cleanly on top of qemu/master.
>
> If I create this patch on qemu/master, that means the other 2 series
> needs to be rebased again.
>

I've included this single patch to my v8 version of "riscv: sifive_u:
Improve the emulation fidelity of sifive_u machine", to ease patch
inter-dependencies, so that the whole v8 series can be applied on
Palmer's RISC-V queue.

See http://patchwork.ozlabs.org/patch/1159111/

So, please ignore this single patch.

Regards,
Bin


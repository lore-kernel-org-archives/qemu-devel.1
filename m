Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB8221E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlSIClBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB8221E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIus-0003tv-PG
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvIuO-000381-B9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvIuN-0001zB-57
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:11:04 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvIuM-0001wr-Uc; Wed, 07 Aug 2019 06:11:03 -0400
Received: by mail-ed1-x541.google.com with SMTP id i11so22193257edq.0;
 Wed, 07 Aug 2019 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0KnN+XMpD1S23kPFeDkskQsy53U1k3iUrqNXMO5WEB0=;
 b=NlSIClBwKiqwEXVvJKhhuIXPXkK+gSE30EtinpBa0ncvX30sAF5Rjs6ilXyLoXW69m
 m5PclRpVS3fDatPCX9dCushfMToZHOxH9oifrU53cT4dYWS4f/7qDy6AnaFYNwd6Mxod
 F4CNmykJLmkgcCm9y3g7m6EtTcbUk9WoZ52O550+sLnHFDWOgdWMrZQvlCNJCcJapBfn
 0wEJacSQg8xCRBD+gIDjWFC9XyUZ5wZH7+YsDfzMRr57FMNIEgXW2gHAPaeTr3uD51KC
 hbRUFjaeMHgN4tnQ1qowX24rw9J5wtYPGZdPZA5SMkAqcDk7b9pRhv6pl5OJsA1+4JnZ
 uh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0KnN+XMpD1S23kPFeDkskQsy53U1k3iUrqNXMO5WEB0=;
 b=OJeHF+Ufmdq3YwA+t/mD+sV3BRQ/84k5EU5kA/p27jlOBlcgC9D+8xuuyvgWjsbEYC
 NOeMLrd+U088Ac+iYkrk3c5NeULFSzFphxA9jtkjoy09/Xxbn0nZXabbbIxRCBImYZst
 rVBJdCyOXjKV6e46IDw+SKoTFraqA9zBsQyadoJ5ptEN2K3QYlcgu6vS31avCcd/JUhp
 q/UlcMjF77z9xFyGqUKFZBacDBfZ0oTf/bs65NSF6DPwqrlSh6+p7B8LWXwTEhmxnnHH
 N0YavN9L1Ft1bYjJdiHuUJX16qVkczAWcrqs9uDzALdtiH6xIFLe1pmZdaS2DH8miAx0
 dFFQ==
X-Gm-Message-State: APjAAAVzVU5HueycS3Q6jlqTP8VE1c98mPpq4ZcVQMNYmXzc+ZoqE7T3
 8QBAqoFhFrdnFxa8eJ8Mtz3Q4Ud7LQ1Y8YnxHe4=
X-Google-Smtp-Source: APXvYqx9/phD50K9YF1FAGvyVXiu1GoaTryEilkioa9ZXRZw2xxqf73AU+d8tSB5gnBZN/RkH9uAdXxq32IQ4yw+goI=
X-Received: by 2002:a50:b388:: with SMTP id s8mr8664469edd.15.1565172661869;
 Wed, 07 Aug 2019 03:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-12-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXU9UXEGYjEDP-LJ5mEY-bF+OtMKt4O+LGJh9qQt3OPaew@mail.gmail.com>
In-Reply-To: <CAEiOBXU9UXEGYjEDP-LJ5mEY-bF+OtMKt4O+LGJh9qQt3OPaew@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Aug 2019 18:10:49 +0800
Message-ID: <CAEUhbmUO2aFrGXbZDB4uXAKe9kq5NJuwS9mMM6-Pwvn_8h++aA@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2 11/28] riscv: sifive: Rename
 sifive_prci.{c, h} to sifive_e_prci.{c, h}
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 4:54 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Wed, Aug 7, 2019 at 3:49 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> Current SiFive PRCI model only works with sifive_e machine, as it
>> only emulates registers or PRCI block in the FE310 SoC.
>>
>> Rename the file name to make it clear that it is for sifive_e.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> ---
>>
>> Changes in v2: None
>>
>>  hw/riscv/Makefile.objs                              |  2 +-
>>  hw/riscv/sifive_e.c                                 |  4 ++--
>>  hw/riscv/{sifive_prci.c => sifive_e_prci.c}         | 14 +++++++-------
>>  include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} | 14 +++++++-------
>>  4 files changed, 17 insertions(+), 17 deletions(-)
>>  rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (90%)
>>  rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (82%)
>>
>> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
>> index eb9d4f9..c859697 100644
>> --- a/hw/riscv/Makefile.objs
>> +++ b/hw/riscv/Makefile.objs
>> @@ -2,9 +2,9 @@ obj-y += boot.o
>>  obj-$(CONFIG_SPIKE) += riscv_htif.o
>>  obj-$(CONFIG_HART) += riscv_hart.o
>>  obj-$(CONFIG_SIFIVE_E) += sifive_e.o
>> +obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
>>  obj-$(CONFIG_SIFIVE) += sifive_clint.o
>>  obj-$(CONFIG_SIFIVE) += sifive_gpio.o
>> -obj-$(CONFIG_SIFIVE) += sifive_prci.o
>>  obj-$(CONFIG_SIFIVE) += sifive_plic.o
>>  obj-$(CONFIG_SIFIVE) += sifive_test.o
>>  obj-$(CONFIG_SIFIVE_U) += sifive_u.o
>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> index 2a499d8..2d67670 100644
>> --- a/hw/riscv/sifive_e.c
>> +++ b/hw/riscv/sifive_e.c
>> @@ -41,9 +41,9 @@
>>  #include "hw/riscv/riscv_hart.h"
>>  #include "hw/riscv/sifive_plic.h"
>>  #include "hw/riscv/sifive_clint.h"
>> -#include "hw/riscv/sifive_prci.h"
>>  #include "hw/riscv/sifive_uart.h"
>>  #include "hw/riscv/sifive_e.h"
>> +#include "hw/riscv/sifive_e_prci.h"
>>  #include "hw/riscv/boot.h"
>>  #include "chardev/char.h"
>>  #include "sysemu/arch_init.h"
>> @@ -174,7 +174,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
>>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
>>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
>> -    sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
>> +    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
>>
>>      /* GPIO */
>>
>
> I  think adding infix to function name is sufficient and keeping the filename the same may be better.
> The U board PRCI or variant implementation in future could be included in the same files with different create function
>

I considered such approach when working on this one, but later I chose
to implement a new file for SiFive U machine.

The SiFive U and E PRCI blocks have different register blocks so if we
put two variants into one file, their functions don't have much in
common and we end up just merely physically put them into one file
which does not bring too much benefit IMHO.

Regards,
Bin


Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FFCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 23:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3BA20679
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 23:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ufQl8eVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3BA20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQgAd-0000uA-W8
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 19:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iQg7X-0007Vc-Qx
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 19:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iQg7W-0001Le-Bx
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 19:14:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iQg7V-0001ES-R2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 19:14:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id c8so7388638pgb.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=I+tk50ZLrZFMT4YeonEpXu60V8yJzZKdvbFllb7MvIQ=;
 b=ufQl8eVhBqdW6CagWT5XAl3aOJeCcDZj4ee22dnUTn2stZ3xh5wfoFe9QLfkYSYu6g
 7Tm7W0lojmzi+LqQDGZCEx0H8Y6YP84uciRnEnwIMfVXrZo4ns6WGC3GX8VJ0m1DrTUp
 PnwHbSock0hfMVr1pamQbIpJ6gDhCbq+hf9k1elVwssq+uTSAPzNK9nbehuAUbuxIynw
 JNsUdl+i3AsL8Qda1ITYgW3b/sQclezYo7d3VpUx8dGXt5GMH1ePKAiG72WLCbrlWk+Y
 cqy4vUVxosnfOlfwVnvrznqO8poEBHHD5BY8Ad+ywQd061/u3so1oeq7KgZ/kKy459vk
 5Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=I+tk50ZLrZFMT4YeonEpXu60V8yJzZKdvbFllb7MvIQ=;
 b=CEZcyUWiz7cgpS/fH8mAg4jj3+bWDDhXC316oxxK/dXO4nzS3kOKpaOTEwjsJd0F41
 d5ZXV5LTFYs/oRye0JbZGSgE9lsJgwBmck5ij0jpbpQ1zWv1xRySzk3Fg8rRlAXLICDA
 mSMWWT0FJURnHtmCzHZMd2jmnNjdQRGh/Dii7+B6umpCbRLaDFgDQCIa+0d0pX2WNJAT
 lFz2svi3qJT/JviaVKt9HussiWhJgfnkXjxlh+dyz5uX1MbY/Ohc2mycnmci8KrcR+g5
 29joZE/2NInLTnJWD8vrMQIjwi6gQI1rk0Fjf94lDBfSi+31GSnpmEedTxCQ4e7kHEP2
 QEsQ==
X-Gm-Message-State: APjAAAWk1X2MsyoyzrHkgX0iMgKbeyxwG6M7pGgbSOIb6CQOCwZp57HX
 jhT8QCOSg/bF3jx05i81kS59bg==
X-Google-Smtp-Source: APXvYqzW0m7t50Wk8cntTsthNGlGbrH+ufYqNy3n18ynoXLw5wa3DL/IJpoTh/Gb7bLcKow0OdfDZQ==
X-Received: by 2002:a63:495b:: with SMTP id y27mr16083031pgk.438.1572650055248; 
 Fri, 01 Nov 2019 16:14:15 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id b59sm8490339pjc.14.2019.11.01.16.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 16:14:14 -0700 (PDT)
Date: Fri, 01 Nov 2019 16:14:14 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Nov 2019 16:10:03 PDT (-0700)
Subject: Re: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
In-Reply-To: <CAAhSdy3sUb_r77NBvEQEAQ0EQB99=4jgAbH3ADOqvJ_iX+o8pg@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: anup@brainfault.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-111ec6b3-0e63-4f94-a1ed-8ddcd354b943@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>, qemu-devel@nongnu.org,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 01 Nov 2019 08:40:24 PDT (-0700), anup@brainfault.org wrote:
> On Tue, Oct 29, 2019 at 6:55 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Fri, Oct 25, 2019 at 6:28 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>> >
>> > This series adds RTC device to QEMU RISC-V virt machine. We have
>> > selected Goldfish RTC device model for this. It's a pretty simple
>> > synthetic device with few MMIO registers and no dependency external
>> > clock. The driver for Goldfish RTC is already available in Linux so
>> > we just need to enable it in Kconfig for RISCV and also update Linux
>> > defconfigs.
>> >
>> > We have tested this series with Linux-5.4-rc4 plus defconfig changes
>> > available in 'goldfish_rtc_v2' branch of:
>> > https://github.com/avpatel/linux.git
>>
>> @Peter Maydell this has been reviewed, do you mind taking this in you
>> next PR? I don't see a maintainer for hw/rtc.
>
> It would be great if this series can be taken for QEMU-4.2

It doesn't look like there's anyone who maintains hw/rtc, so maybe that's why 
this has been going slowly?  I'd happy to PR it, but I don't really have the 
bandwidth to sign up to maintain more stuff right now.

>
> Regards,
> Anup
>
>>
>> Alistair
>>
>> >
>> > Changes since v4:
>> >  - Fixed typo in trace event usage
>> >  - Moved goldfish_rtc.h to correct location
>> >
>> > Changes since v3:
>> >  - Address all nit comments from Alistair
>> >
>> > Changes since v2:
>> >  - Rebased on RTC code refactoring
>> >
>> > Changes since v1:
>> >  - Implemented VMState save/restore callbacks
>> >
>> > Anup Patel (2):
>> >   hw: rtc: Add Goldfish RTC device
>> >   riscv: virt: Use Goldfish RTC device
>> >
>> >  hw/riscv/Kconfig              |   1 +
>> >  hw/riscv/virt.c               |  15 ++
>> >  hw/rtc/Kconfig                |   3 +
>> >  hw/rtc/Makefile.objs          |   1 +
>> >  hw/rtc/goldfish_rtc.c         | 288 ++++++++++++++++++++++++++++++++++
>> >  hw/rtc/trace-events           |   4 +
>> >  include/hw/riscv/virt.h       |   2 +
>> >  include/hw/rtc/goldfish_rtc.h |  46 ++++++
>> >  8 files changed, 360 insertions(+)
>> >  create mode 100644 hw/rtc/goldfish_rtc.c
>> >  create mode 100644 include/hw/rtc/goldfish_rtc.h
>> >
>> > --
>> > 2.17.1
>> >


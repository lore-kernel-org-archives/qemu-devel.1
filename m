Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B59C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 19:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EC921901
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f9RMG2oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EC921901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpdgq-0002DN-Ly
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@sifive.com>) id 1hpdgg-0001kl-7I
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hpdge-000891-TW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:09:30 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hpdgZ-0007vA-HS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:09:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id r7so17829143pfl.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=FDcI6V051d29BD5Jk7agCDwaH6IXlxWsVS9Z7PYAjNo=;
 b=f9RMG2oJk+409+qfpC/uu1tEHLeOYVVcp2qxXRpifc1YyyQaPOunkFyM2GgPDkkjvm
 QPa01VhabJ8XX7cdcI7y/T1ufJb5slea5RiVH0/4zsAbiB/MVVBikZ+NgzJDx83dKYX5
 ZXsTyw4pCwWbKP/j+x4ddDvU/gFHj+JtLFjd0puZgvOslf53tIWnZOlzIvyZj52jLO72
 5DhdQfeDvNW9MbGhqIF91CedGhA0U83p7RMvB4tqG85Bo1dwWzq2GtlbR8mF4/J+WNTI
 ++9Drv/n1FJBv3urUrdf6+PSkc2T4n4PYk9DxxPyQ/yDY+9p79Pg40bb5rDMfvwrqNAp
 acoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=FDcI6V051d29BD5Jk7agCDwaH6IXlxWsVS9Z7PYAjNo=;
 b=auHh4Hig0Z12C9DvuyX8rhAz/UACbwE6R/w9OE/Ij8Dot6wpbgZb/b5g5I4V3zigrB
 DOPsZIHuHYlUnfYd4Q8A6xF2VJXzDNhkl+I+mx7SvLSpTVPXx+6s+Vk6ftgrfPxY9gnj
 NStI1Lp3TADAN6SL9dAVoMIRrkVfXN2LB4dtsytYgq7BjmJo8TI43R4GW1f3SPLjJRRQ
 ADgutdb9tHGS80VATpIylDsgu5C1wuW2pZ8NwDhrEWjPoBcIeyxNwaI+mZS+QalQYUmh
 1Vv7QlhMni6fDjHALUis4/Up/NTQmA00J9IS5RQmwHtI17r8gjAOBLO98jgjiMIwlCbV
 lAzQ==
X-Gm-Message-State: APjAAAVYUFltLREpk4CHtZngnHSJCcg82h0NdYMGZAK4KWkwBCC4nHqn
 /f7t/+qXUxKRV1WQ4FtZ6dS09Q==
X-Google-Smtp-Source: APXvYqwBnSzEAw6JraPmDVTlil3IIN0hTWSOo6DkVliA9ooIIOvpcYDn5bE/zBMkJM4H07vf3gRXkQ==
X-Received: by 2002:a17:90a:5884:: with SMTP id
 j4mr81367849pji.142.1563822557585; 
 Mon, 22 Jul 2019 12:09:17 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id i7sm32183015pjk.24.2019.07.22.12.09.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 12:09:16 -0700 (PDT)
Date: Mon, 22 Jul 2019 12:09:16 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 12:08:03 PDT (-0700)
In-Reply-To: <CAKmqyKNnkToYf3Y025Hpv1e8jazMVjxhjAaOBtn0ajcHSFaTUA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-d801380f-1010-4ee3-a3ee-d6f16159474e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv/boot: Fixup the RISC-V
 firmware warning
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 11:22:43 PDT (-0700), alistair23@gmail.com wrote:
> On Sat, Jul 20, 2019 at 2:30 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> On 7/19/19 8:05 PM, Alistair Francis wrote:
>> > Fix a typo in the warning message displayed to users, don't print the
>> > message when running inside qtest and don't mention a specific QEMU
>> > version for the deprecation.
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  hw/riscv/boot.c | 12 ++++++++----
>> >  1 file changed, 8 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> > index 5dee63011b..4b32ab1d26 100644
>> > --- a/hw/riscv/boot.c
>> > +++ b/hw/riscv/boot.c
>> > @@ -26,6 +26,7 @@
>> >  #include "hw/riscv/boot.h"
>> >  #include "hw/boards.h"
>> >  #include "elf.h"
>> > +#include "sysemu/qtest.h"
>> >
>> >  #if defined(TARGET_RISCV32)
>> >  # define KERNEL_BOOT_ADDRESS 0x80400000
>> > @@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *machine,
>> >           * In the future this defaul will change to loading the prebuilt
>> >           * OpenSBI firmware. Let's warn the user and then continue.
>> >          */
>> > -        warn_report("No -bios option specified. Not loading a firmware.");
>> > -        warn_report("This default will change in QEMU 4.3. Please use the " \
>> > -                    "-bios option to aviod breakages when this happens.");
>> > -        warn_report("See QEMU's deprecation documentation for details");
>> > +        if (!qtest_enabled()) {
>> > +            warn_report("No -bios option specified. Not loading a firmware.");
>> > +            warn_report("This default will change in a future QEMU release. " \
>> > +                        "Please use the -bios option to avoid breakages when "\
>> > +                        "this happens.");
>> > +            warn_report("See QEMU's deprecation documentation for details");
>>
>> Maybe a final '.' in the last warning to be consistent with the previous
>> lines?
>
> Done in v2.

I don't see a v2, did I miss it?

>> Regardless:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
> Thanks!
>
> Alistair
>
>>
>> > +        }
>> >          return;
>> >      }
>> >
>> >


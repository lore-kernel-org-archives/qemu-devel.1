Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFFDC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060A120880
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRafk5qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060A120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvc3S-00068i-Bu
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 02:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvc2X-0005Q8-6q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvc2V-00063N-OQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:36:45 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvc2R-0005tO-S1; Thu, 08 Aug 2019 02:36:42 -0400
Received: by mail-ed1-x541.google.com with SMTP id z51so1880359edz.13;
 Wed, 07 Aug 2019 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7CoRmRHpe+dLhFhAUcpmpFT82wnzv4Fux6n8ZUh3xKA=;
 b=mRafk5qgbH3nQhftEHbZBokQYxG5imI0hsUuj8s9aUV494g9NSeHi8HeUNccGiCQLc
 pltgieQtuZd4GURJXfEpZfoGqADHfYEaE8dU3LRpek5L7PNsdX95PJQXk1JMqKbXgnQZ
 TEUH8fC+CNS0ea7OJgfg7CaK2CiOuIJBKOAWWZudFL3gyN1s8LpsQDZfj2UffuF2ilkw
 gmP+2lcCQMLJsZZZC88uOYVDCk1iOX1gveZF1uH9GevifTDxoIVOFn84wX8oNbDCJ+wK
 pJ9pV+TEBXGqROzyfntQ2B3BD+9+66I8EjGvid+0UUUmgx1x9ZS/ctEe9JrGYFl7Ltb4
 uGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7CoRmRHpe+dLhFhAUcpmpFT82wnzv4Fux6n8ZUh3xKA=;
 b=V17A3GyHmBfcAm2F1DalJki4evzBk65N60YkJKtkWo8mtVvbZ7eBQIcXXVqej98M1x
 /RK0a5AqSkvi9R6z9iavbnCxi8ERCiUZCCrPsl4Mtcyv2deczyrbNBruSDZxOVo4qNEM
 S5KzUdgnEAHBHfBtu939FrErKdv0Nt2JgO4TdctP9Wg4/vrfRJGb2b4TzMx/SnQICXQ9
 IqdVjZmOZcBC4x1GiT5S54t4QClntDDIFWosjMOTwYjB+s+a40VCmFAoFZ8jwrp7AP/R
 tNLLUP4GO2y8LpjuEPFBOUOClXU4KzE8dY9JeQ8zBBdhchJJAaWH2plq33jPwAUgEDrx
 oIDg==
X-Gm-Message-State: APjAAAU/UCwee83nP7eyEW7ONgrJcvuJ7VuMEXTnXHnyT2zreDWj6pui
 yM2W5dKqqAluHcSqN1Uthov0Al1nCCOR7mdIM4M=
X-Google-Smtp-Source: APXvYqy8k5QtpvRjqcRe5gezJGDkayu/JLn4cr6I5z70N4/BOaL4xQBiqy83McHUxsLr3vIo2qYOg6Fwz1dP9pf2hPQ=
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr13856692edr.119.1565246196559; 
 Wed, 07 Aug 2019 23:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
 <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
 <d0ca78ec-c5d4-bc80-6f2e-3e933013b5f4@redhat.com>
In-Reply-To: <d0ca78ec-c5d4-bc80-6f2e-3e933013b5f4@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Aug 2019 14:36:25 +0800
Message-ID: <CAEUhbmVKnUkJ66A-mULpkqZppb=2c8NVAFJhZhOMpOdyRRxSQQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2] hw: net: cadence_gem: Fix build errors
 in DB_PRINT()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 1:21 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi,
>
> On 8/8/19 6:44 AM, Bin Meng wrote:
> > When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> > compilation errors in DB_PRINT(). Fix them.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >
> > ---
> >
> > Changes in v2:
>
> Please don't reply to previous version, post as a new thread (it is
> harder to notice your new versions in a emails threaded view).
>

OK.

> > - use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
> > - use 'z' modifier to print sizeof(..)
> >
> >  hw/net/cadence_gem.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index d412085..b6ff2c1 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, cons=
t uint8_t *buf, size_t size)
> >              return -1;
> >          }
> >
> > -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsi=
ze),
> > -                rx_desc_get_buffer(s->rx_desc[q]));
> > +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
>
> rx_desc_get_buffer() returns a uint64_t, shouldn't you use a PRIx64
> format here?

HWADDR_PRIx expands to PRIx64. I got your point that since it does not
return hwaddr, so we should use PRIx64 directly. Correct?

>
> > +                 MIN(bytes_to_copy, rxbufsize),
>
> Nitpick #1: since you are cleaning this file up, bytes_to_copy and
> rxbufsize are both unsigned, so the first format should be %u instead of =
%d.

Sure, will do in v3.

>
> > +                 rx_desc_get_buffer(s, s->rx_desc[q]));
> >
> >          /* Copy packet data to emulated DMA buffer */
> >          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_de=
sc[q]) +
> > @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
> >              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> >                                                 (p - tx_packet)) {
> >                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x sp=
ace " \
> > -                         "0x%x\n", (unsigned)packet_desc_addr,
> > +                         "0x%zx\n", (unsigned)packet_desc_addr,
>
> Nitpick #2: packet_desc_addr is of type hwaddr, so removing the cast the
> 1st format is HWADDR_PRIx, also removing the 2nd cast the 2nd format is
> PRIx64.

packet_desc_addr() return unsigned, so %x should be OK.

>
> Then the 3rd format is now correct.
>
> >                           (unsigned)tx_desc_get_length(desc),
> >                           sizeof(tx_packet) - (p - tx_packet));
> >                  break;
> >

Regards,
Bin


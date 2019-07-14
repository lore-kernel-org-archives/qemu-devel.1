Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA05C31E40
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 03:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2B20838
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 03:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZhRhDag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmVLK-0001VW-FY
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 23:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52111)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hmVLA-000173-Em
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 23:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hmVL9-0003kp-Cu
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 23:38:20 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hmVL7-0003iz-3m; Sat, 13 Jul 2019 23:38:17 -0400
Received: by mail-ed1-x541.google.com with SMTP id e3so12387349edr.10;
 Sat, 13 Jul 2019 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=epXt3tMCuaCZ+FBDgx3zrjs1rQeNPB0DcBSKGrdJiGc=;
 b=HZhRhDagqG4KEMuJlJS58veC1css7UA61acQQtMWWKHoRlfyDEa4nQ0jSBEszW37KL
 45N+3Culs13+Ph25zcHRoiYDPT3H/6QudSmzHQN/au7PpuH9feqqOy0wFipyimINLRx5
 /Z1O1o7ueMdMwBD/IoEOkGZNWf2q2cuqrK90v/O54zdog2QCycMqXsNeBRw6sr2rtZvG
 tr2HNVISzHDBZXrg93nLCk+dvnTKTzecN4cYvFfiMF0rTEEfCGeS+slqn6HvLHKgybKH
 msd8o464u4AQt3Mc5177TZYi9lEjI9rmDVUsSjZ5SytXnlB4GQzuazGMkm0JF3H8DvHn
 r1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=epXt3tMCuaCZ+FBDgx3zrjs1rQeNPB0DcBSKGrdJiGc=;
 b=GkxzJX8XHn+3c3nS4t/8x6nRWfKVkE+iXXGENrF2zAxwnN8TrW93HllWIXrttK1EvR
 Gzo/zZOxd73BC2/fK5zJauSZF9m0VNGQwaZX11Xrz39kuLdonQ9RB+NJ4l7ROFR3B87l
 d0g04obMX3je0sMhYi3eyxkd9fVhZ1tjohmP6Q2ca5z7NMDp9Wda6pfAsqvk5FMuBnWn
 WC3+Jrv/6tK+PCf+ttA8m3n7ZcJk+xB/afpdJhxttXVb6msgRboQTwD0MzP0xv6oIXjJ
 NDGnT3UHhOb+mEoDc49SaOgL/Vx9oDTmhseqJ8wnhw+LaMfrxpWGr7dJiOO7sa1fQ5jQ
 aTbw==
X-Gm-Message-State: APjAAAUmrqIJScL3eBXhwS1CDYfoCzC0x/qGJ/C2Xv/aIABt2pnm5PD8
 mK3KOaD+LzNzpLqSM5ZuJ8Jit8hp9oPJfyYSWHo=
X-Google-Smtp-Source: APXvYqx67bOgUgJAwgc5K46c9yvh/ujiQ/8/2T900p2FxpcV9sHWZxOOoQuhlgEp5Z131on/xOVNnhdCPlXX35Ksv4M=
X-Received: by 2002:a17:906:fcb8:: with SMTP id
 qw24mr14784506ejb.239.1563075496133; 
 Sat, 13 Jul 2019 20:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <1560525351-590-1-git-send-email-bmeng.cn@gmail.com>
 <mhng-4825dce4-e510-41cd-b97c-0e599d6a2369@palmer-si-x1e>
In-Reply-To: <mhng-4825dce4-e510-41cd-b97c-0e599d6a2369@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 14 Jul 2019 11:38:05 +0800
Message-ID: <CAEUhbmVH8cWcWn=s9J7VA40VCUoYpMkjXAMe=X1MLZfwghxP4A@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] riscv: sifive_test: Add reset functionality
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 5:48 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 14 Jun 2019 08:15:51 PDT (-0700), bmeng.cn@gmail.com wrote:
> > This adds a reset opcode for sifive_test device to trigger a system
> > reset for testing purpose.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  hw/riscv/sifive_test.c         | 4 ++++
> >  include/hw/riscv/sifive_test.h | 3 ++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > index 24a04d7..cd86831 100644
> > --- a/hw/riscv/sifive_test.c
> > +++ b/hw/riscv/sifive_test.c
> > @@ -21,6 +21,7 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/sysbus.h"
> >  #include "qemu/module.h"
> > +#include "sysemu/sysemu.h"
> >  #include "target/riscv/cpu.h"
> >  #include "hw/riscv/sifive_test.h"
> >
> > @@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
> >              exit(code);
> >          case FINISHER_PASS:
> >              exit(0);
> > +        case FINISHER_RESET:
> > +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +            return;
> >          default:
> >              break;
> >          }
> > diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
> > index 71d4c9f..c186a31 100644
> > --- a/include/hw/riscv/sifive_test.h
> > +++ b/include/hw/riscv/sifive_test.h
> > @@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
> >
> >  enum {
> >      FINISHER_FAIL = 0x3333,
> > -    FINISHER_PASS = 0x5555
> > +    FINISHER_PASS = 0x5555,
> > +    FINISHER_RESET = 0x7777
> >  };
> >
> >  DeviceState *sifive_test_create(hwaddr addr);
>
> Poking around the hardware side, it looks like we're silently ignoring all
> codes aside from 0x3333 and 0x5555.  As a result there's really no way to test
> if this added reset is going to work, so this should be a "sifive,test1"
> instead of a "sifive,test0".  It's backwards compatible, so the compat string
> in the device trees should look something like
>
>     compatible = "sifive,test1", "sifive,test0";
>
> With that it should be fine, pending the change to our hardware to reserve this
> as an error code within "sifive,test0" devices.
>
> Do you mind also submitting a device tree binding to Linux that describes this
> device?  That way we can all stay on the same page about what the pair of
> interfaces do.

Thanks for the confirmation. I will try to create a device tree
binding for Linux.

Regards,
Bin


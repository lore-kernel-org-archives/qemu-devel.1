Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C7C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47384204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0Jap6st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47384204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfx3a-0006Uf-Av
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 21:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfx0d-0005UK-JD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfx0b-0001Al-SE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:46:03 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hfx0Y-0000zt-RI; Tue, 25 Jun 2019 21:45:59 -0400
Received: by mail-ed1-x543.google.com with SMTP id m10so768498edv.6;
 Tue, 25 Jun 2019 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qj7FR9121l9IsTilBBUGuk85aAP8qTQXViWSfc/mKmM=;
 b=t0Jap6st0PiYxVfoT1jCXCVGkOi5qpRjObHLB8RO6t+pEtNsrd8CslMgLyJB+c3hiT
 iB+7LGHnB+ZIeVVNHYQf5BdUHuIJeR9ZyjO3qmc5iuBzhGdQjLqdob2qTOJyqmU0I9jE
 4p51QP+Ke2NoY4nHGYDE1z7hHnIxRZHHVL1RiPIWUQMAGywOANfy+1gwHHEUTmAmC/Wr
 cKrZVOWEFgeplsOLrl+E+qjNlLaVI5A77fqCeL/uT1EKC4JmJebzcpMs66Ly91Fgwp/5
 ZCvPOUEGHBIWGcojyDl1daYwF60YAnT0J2J+hbhp32kmlu8LrcbR5lEzPFwaVgK1VMLn
 lfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qj7FR9121l9IsTilBBUGuk85aAP8qTQXViWSfc/mKmM=;
 b=pFg2fwVmMRsuYxvi3Ykd7gAeSG2bJx6h1BnAKnsLJZJREqr/CPfgr1mp6vvDbBRkhJ
 oqouwbjVQxHyNboBOWj2uwGqf14k9t9fIZHkdqevmKYFSQGEEB90M6H+HWjJ/5WCQmKp
 De/x7YTx4Gx/I23FnACtU9KuGcsgGPURee4OlaXZtXkqdmU8bTPMB2VaudlGNRiLzU6d
 jG9Dd6mtvAAcFM4+x+rG7slxfcKMSeVE3422uKdBiZI4frHlwXapMExjbmXk5bYd3gUk
 yI0WbxeAbYY3GG6GwCoJXjAxVhrqJFyfbkIt24PvxDaIm90sBzrEtnZJYd2cA2Zj1Vh2
 dnGw==
X-Gm-Message-State: APjAAAXIzVelMT9CPXtYZX1A0Cnq3sua+sTQX3kMgQiygpa8KRZPS8R/
 GBjqv2HVuzTV8UCnn+Ej8u/7XIyYP8DLeizQYBY=
X-Google-Smtp-Source: APXvYqz4sAOMmDJsckbWYbi88A4GUd42a9zTnJ2URQ4CBFNduXCDdF7TW88wgXebasAUTKcN4Emh44bL6slQ3DvWro8=
X-Received: by 2002:a50:886a:: with SMTP id c39mr1827266edc.214.1561513557143; 
 Tue, 25 Jun 2019 18:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmWJYE+BUfE5v-TrmQ=xzhV8HuxFhBQrtU74T6TKfTZXCw@mail.gmail.com>
 <mhng-ab33da75-40fa-4fec-8f96-28a3287ef952@palmer-si-x1e>
In-Reply-To: <mhng-ab33da75-40fa-4fec-8f96-28a3287ef952@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 26 Jun 2019 09:45:46 +0800
Message-ID: <CAEUhbmXLGq_0MuOWKr0gwN16CoPWBCzPFpjzTQcWaEjynscFyA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Sun, Jun 23, 2019 at 10:40 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 20 Jun 2019 22:40:24 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Hi Palmer,
> >
> > On Fri, Jun 21, 2019 at 10:53 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Wed, 19 Jun 2019 06:42:21 PDT (-0700), bmeng.cn@gmail.com wrote:
> >> > Hi Alistair,
> >> >
> >> > On Tue, Jun 18, 2019 at 1:15 AM Alistair Francis <alistair23@gmail.com> wrote:
> >> >>
> >> >> On Fri, Jun 14, 2019 at 8:30 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> >> >
> >> >> > This adds a reset opcode for sifive_test device to trigger a system
> >> >> > reset for testing purpose.
> >> >> >
> >> >> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> >> > ---
> >> >> >
> >> >> >  hw/riscv/sifive_test.c         | 4 ++++
> >> >> >  include/hw/riscv/sifive_test.h | 3 ++-
> >> >> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> >> >> > index 24a04d7..cd86831 100644
> >> >> > --- a/hw/riscv/sifive_test.c
> >> >> > +++ b/hw/riscv/sifive_test.c
> >> >> > @@ -21,6 +21,7 @@
> >> >> >  #include "qemu/osdep.h"
> >> >> >  #include "hw/sysbus.h"
> >> >> >  #include "qemu/module.h"
> >> >> > +#include "sysemu/sysemu.h"
> >> >> >  #include "target/riscv/cpu.h"
> >> >> >  #include "hw/riscv/sifive_test.h"
> >> >> >
> >> >> > @@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
> >> >> >              exit(code);
> >> >> >          case FINISHER_PASS:
> >> >> >              exit(0);
> >> >> > +        case FINISHER_RESET:
> >> >> > +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >> >> > +            return;
> >> >> >          default:
> >> >> >              break;
> >> >> >          }
> >> >> > diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
> >> >> > index 71d4c9f..c186a31 100644
> >> >> > --- a/include/hw/riscv/sifive_test.h
> >> >> > +++ b/include/hw/riscv/sifive_test.h
> >> >> > @@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
> >> >> >
> >> >> >  enum {
> >> >> >      FINISHER_FAIL = 0x3333,
> >> >> > -    FINISHER_PASS = 0x5555
> >> >> > +    FINISHER_PASS = 0x5555,
> >> >> > +    FINISHER_RESET = 0x7777
> >> >>
> >> >> Do you mind sharing where you got this value from? I can't find
> >> >> details on this device in the SiFive manuals.
> >> >>
> >> >
> >> > I don't think this is a device that actually exists on SiFive's
> >> > chipset. It's hypothetical.
> >>
> >> The device actually does exist in the hardware, but that's just an
> >> implementation quirk.  Essentially what's going on here is that the RTL
> >> contains this device, which has a register and then a behavioral verilog block
> >> that causes simulations to terminate.  This is how we exit from tests in RTL
> >> simulation, and we've just gone ahead and implemented the same device in QEMU
> >> in order to make it easy to have compatibility with those bare-metal tests.
> >> Due to how our design flow is set up we end up with exactly the same block in
> >> the ASIC.  The register is still there, but the behavioral code to exit
> >> simulations doesn't do anything so it's essentially just a useless device.
> >> Since it's useless we don't bother writing it up in the ASIC documentation, but
> >> it should be in the RTL documentation.
> >>
> >> I'm not opposed to extending the interface in the suggested fashion, but I
> >> wanted to check with the hardware team first to see if they're doing anything
> >> with the other numbers.  I'm out of the office (and somewhat backed up on code
> >> review) until July, so it might take a bit to dig through this.
> >
> > Thanks for the clarification. The main reason of adding this
> > functionality is to provide software a way of rebooting the whole
> > system. Please provide update after you consult SiFive hardware guys
> > :)
>
> Ya, it makes sense.  My only worry here is that we have some way of doing this
> already, in which case I'd just want to make sure it matches.

If the SiFive chipset already has the functionality to do the reset
via this test module, I agree let's align the number to what hardware
actually accepts.

Regards,
Bin


Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF7C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 01:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84866208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 01:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tzi78uWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84866208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy4y2-0002bY-DC
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 21:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1hy4x3-0001rT-7L
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 21:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hy4x1-00047m-Mk
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 21:53:17 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hy4x1-000475-Fq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 21:53:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id y8so446373plr.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=CpKzhrAquFjqvLVLpjn2rxvsNuslhSSRhPlrp0w3atI=;
 b=Tzi78uWW8/azF0Iop9jVGosGeQ0ORJojZKjDqjiU5bvUT91O0xfeEn4xKjzWW5lNp4
 l/ThTzEJ2dl/5+UC9Bfv4WxTKLixbPIMpeZ8hg7skOLaOnXkmWc6IJB4DMhkkRV1vh83
 3LvDpC7cdNPhjiGlkONcBn+15hGbYANCQp90WsEx0mZhWPaFPg4CusBnRZRL2yJF1Rik
 VELwV1Jr1H8YY+LYMRve3Nw00IItav3EHKMBeaz1E5IgK6TQ0EkvrmQGybjQlaT5Ke1S
 v63Tw8iZJIX45CmTsSSpaCHDmNBdLFb/zTGT8/+kZgQQPo0TgJIFYyiGNWQdfpNAJqeM
 aBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=CpKzhrAquFjqvLVLpjn2rxvsNuslhSSRhPlrp0w3atI=;
 b=C1ZcZNRO3a7oJZAjFjt/FKg7svcMa9/dxflRf3wujRs+LZS5ZdVh9JH5TPIGoAdrsU
 7fcFuK0ZXzPGoctfBZ5TPaGTBDghyUZ/CesjIr7UD0W2EpEfhzPyJZbYuVaCCqhvjBvo
 uGzjHZ0pA7mAfQCHVXw5Dc9EvSv2eox79m/wA2JTMh360lCyf6k9gzRgbGBdnQRrXgV3
 XggIAdPxhS18BQHtpymuhIbITRxzWjvsBK7p2IAmxPSLYC/x8lQU2lIhnKdouU5iNBPH
 KAG7psyV0+1n2Qdwjd+leGZu0VtrPPFhcKz2BHQ95E367APcaKDaBFzULuAHaX0u6z+V
 V5xA==
X-Gm-Message-State: APjAAAVsoHSF/E6fB6rECGwgi1+qSWQRKkknJfjuWowatK5V0VWsP3h9
 wu1HgC6e8WRIIGGVBt7Ykjl3ew==
X-Google-Smtp-Source: APXvYqyVFbR6gMPUkUIexVoWKYrn9ixFmZ5cciUjb3bJFKxFELIiTaZTQSvdTLgO4ISi6TyxXHxauw==
X-Received: by 2002:a17:902:fe14:: with SMTP id
 g20mr2065514plj.54.1565833994067; 
 Wed, 14 Aug 2019 18:53:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id c71sm1307258pfc.106.2019.08.14.18.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 18:53:13 -0700 (PDT)
Date: Wed, 14 Aug 2019 18:53:13 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 18:52:41 PDT (-0700)
In-Reply-To: <CAEUhbmVb-rfZ74mY_2QHTNw8R-FYTwxggHAPCCWviYpZZXNtAg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-cb8e7951-7f1d-4168-8907-cff56ff9ca0f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 1/3] riscv: sifive_u: Add support for
 loading initrd
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, linux@roeck-us.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Aug 2019 18:30:59 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Thu, Aug 15, 2019 at 1:06 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Mon, 12 Aug 2019 16:48:00 PDT (-0700), bmeng.cn@gmail.com wrote:
>> > Hi Palmer,
>> >
>> > On Tue, Aug 13, 2019 at 6:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>> >>
>> >> On Fri, 19 Jul 2019 06:40:43 PDT (-0700), linux@roeck-us.net wrote:
>> >> > Add support for loading initrd with "-initrd <filename>"
>> >> > to the sifive_u machine. This lets us boot into Linux without
>> >> > disk drive.
>> >> >
>> >> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> >> > ---
>> >> >  hw/riscv/sifive_u.c | 20 +++++++++++++++++---
>> >> >  1 file changed, 17 insertions(+), 3 deletions(-)
>> >> >
>> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> >> > index 71b8083..0657046 100644
>> >> > --- a/hw/riscv/sifive_u.c
>> >> > +++ b/hw/riscv/sifive_u.c
>> >> > @@ -67,7 +67,7 @@ static const struct MemmapEntry {
>> >> >
>> >> >  #define GEM_REVISION        0x10070109
>> >> >
>> >> > -static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> >> > +static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> >> >      uint64_t mem_size, const char *cmdline)
>> >> >  {
>> >> >      void *fdt;
>> >> > @@ -244,11 +244,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> >> >          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>> >> >      }
>> >> >      g_free(nodename);
>> >> > +
>> >> > +    return fdt;
>> >> >  }
>> >> >
>> >> >  static void riscv_sifive_u_init(MachineState *machine)
>> >> >  {
>> >> >      const struct MemmapEntry *memmap = sifive_u_memmap;
>> >> > +    void *fdt;
>> >> >
>> >> >      SiFiveUState *s = g_new0(SiFiveUState, 1);
>> >> >      MemoryRegion *system_memory = get_system_memory();
>> >> > @@ -269,13 +272,24 @@ static void riscv_sifive_u_init(MachineState *machine)
>> >> >                                  main_mem);
>> >> >
>> >> >      /* create device tree */
>> >> > -    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>> >> > +    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>> >> >
>> >> >      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> >> >                                   memmap[SIFIVE_U_DRAM].base);
>> >> >
>> >> >      if (machine->kernel_filename) {
>> >> > -        riscv_load_kernel(machine->kernel_filename);
>> >> > +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
>> >> > +
>> >> > +        if (machine->initrd_filename) {
>> >> > +            hwaddr start;
>> >> > +            hwaddr end = riscv_load_initrd(machine->initrd_filename,
>> >> > +                                           machine->ram_size, kernel_entry,
>> >> > +                                           &start);
>> >> > +            qemu_fdt_setprop_cell(fdt, "/chosen",
>> >> > +                                  "linux,initrd-start", start);
>> >> > +            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
>> >> > +                                  end);
>> >> > +        }
>> >> >      }
>> >> >
>> >> >      /* reset vector */
>> >>
>> >> Thanks.  I've queued all three of these.
>> >>
>> >
>> > Ah, looks I did a duplicate.
>> > http://patchwork.ozlabs.org/patch/1145247/
>> >
>> > Which git repo/branch should I rebase my series on?
>>
>> github.com/palmer-dabbelt/riscv-qemu -b for-master
>
> I did not see branch "for-master" in the riscv-qemu repo. However I
> did find the branch in the github.com/palmer-dabbelt/qemu repo.
>
> I assume that's the correct one I should rebase my patch series on.

Thanks, I've deleted that confusing fork.


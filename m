Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE62C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC6F2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G2RaldHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC6F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxwkE-0006bv-Lq
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1hxwjT-000651-Hy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hxwjS-0007cs-5R
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:06:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hxwjR-0007bq-WD
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:06:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id e11so2826439pga.5
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=PEBEqNJnBX2a01paAgfoN/R9hhRL6hRf2pblNogkX80=;
 b=G2RaldHSi07fZ6oNUvM9xz9oDne6epapEe/8e0c5+qUFO9SXuHJtchzJ/U5P2adS+G
 U/Hwk9Rx4vHuKs/MToTuTj7KV/10938JYtbQ3RZSQQhO3gq+CNIxtIWjejzYG/6D8/xs
 T0iXRQojwaoUhfs4KCVei53A0j+GDKsGL/34btA1aj7ZOnqB90rT+mYefNvX0HegJSNh
 CLi7DmDrli7a7y886NfNWj3RBUgwSb9C3uV3NUtbIMfHrKpywJO9dyYWAMDpKD79Qkuc
 0DGx0961RM1tYqU6nzqfTtRyJNyXVaQlbySwKgk+wa2+K7ddoRih7eiUPqvlluje3sJX
 05IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=PEBEqNJnBX2a01paAgfoN/R9hhRL6hRf2pblNogkX80=;
 b=FCZ3UwPcrzEzpKrHdXPzHC0IAHOpoFL7qyOUHzy2GGo2s2nvKKzAWHEVaE5X2JTGOA
 zQV1JovmiJsMhN4kjkTplKvJNOzz883fB4GHo/cf52mvbj2JHGzxznBZTpub3iyg7IZC
 ZcImC7miKKk81MS+Cu/IdY9U9LmuvJsRYXAr8WEU85wlSs6X+4WEXw2yB1QUpAD0IIgC
 LVAfXgtMAREjOJ2pkSPT4O0EuAXLQ51i2UyzZnVz+7ZkIDRlLknVz7cbtPc+qbRnO3jB
 OWzncWfUHeXWAXICNiVdfNndfa46eBJFrGSF4vwmbY4NSsjXvF0psQ599e6CLnYy5JIo
 anaA==
X-Gm-Message-State: APjAAAV8cHcNHRaQ5+Uw9gVHiI8Jnx0ccu/o+pdy+uX1sLSMZhVy5czG
 +K6aIS/FJeROvVduHu99DTCWqw==
X-Google-Smtp-Source: APXvYqwX+4db6GbAZ3+iCPsjC3ixInEzut7LemFdJVBE8vQ+AxfUh/qU0eRqfQxV6SQpUZ68lVimTw==
X-Received: by 2002:a65:6108:: with SMTP id z8mr151734pgu.289.1565802399873;
 Wed, 14 Aug 2019 10:06:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id n7sm353495pff.59.2019.08.14.10.06.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 10:06:39 -0700 (PDT)
Date: Wed, 14 Aug 2019 10:06:39 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 10:03:21 PDT (-0700)
In-Reply-To: <CAEUhbmU8s5cEt4J-ae0wqfgFHEWe=YWQaDn_Au_MhtK1J7OntA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-b7d8bc3c-3d03-4b2a-910f-8a9ceb18a046@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

On Mon, 12 Aug 2019 16:48:00 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Tue, Aug 13, 2019 at 6:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Fri, 19 Jul 2019 06:40:43 PDT (-0700), linux@roeck-us.net wrote:
>> > Add support for loading initrd with "-initrd <filename>"
>> > to the sifive_u machine. This lets us boot into Linux without
>> > disk drive.
>> >
>> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> > ---
>> >  hw/riscv/sifive_u.c | 20 +++++++++++++++++---
>> >  1 file changed, 17 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> > index 71b8083..0657046 100644
>> > --- a/hw/riscv/sifive_u.c
>> > +++ b/hw/riscv/sifive_u.c
>> > @@ -67,7 +67,7 @@ static const struct MemmapEntry {
>> >
>> >  #define GEM_REVISION        0x10070109
>> >
>> > -static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> > +static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> >      uint64_t mem_size, const char *cmdline)
>> >  {
>> >      void *fdt;
>> > @@ -244,11 +244,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> >          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>> >      }
>> >      g_free(nodename);
>> > +
>> > +    return fdt;
>> >  }
>> >
>> >  static void riscv_sifive_u_init(MachineState *machine)
>> >  {
>> >      const struct MemmapEntry *memmap = sifive_u_memmap;
>> > +    void *fdt;
>> >
>> >      SiFiveUState *s = g_new0(SiFiveUState, 1);
>> >      MemoryRegion *system_memory = get_system_memory();
>> > @@ -269,13 +272,24 @@ static void riscv_sifive_u_init(MachineState *machine)
>> >                                  main_mem);
>> >
>> >      /* create device tree */
>> > -    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>> > +    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>> >
>> >      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> >                                   memmap[SIFIVE_U_DRAM].base);
>> >
>> >      if (machine->kernel_filename) {
>> > -        riscv_load_kernel(machine->kernel_filename);
>> > +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
>> > +
>> > +        if (machine->initrd_filename) {
>> > +            hwaddr start;
>> > +            hwaddr end = riscv_load_initrd(machine->initrd_filename,
>> > +                                           machine->ram_size, kernel_entry,
>> > +                                           &start);
>> > +            qemu_fdt_setprop_cell(fdt, "/chosen",
>> > +                                  "linux,initrd-start", start);
>> > +            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
>> > +                                  end);
>> > +        }
>> >      }
>> >
>> >      /* reset vector */
>>
>> Thanks.  I've queued all three of these.
>>
>
> Ah, looks I did a duplicate.
> http://patchwork.ozlabs.org/patch/1145247/
>
> Which git repo/branch should I rebase my series on?

github.com/palmer-dabbelt/riscv-qemu -b for-master


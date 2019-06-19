Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBB0C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D355621881
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7lfl9a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D355621881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdciA-000258-2D
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43727)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcXQ-0008Uo-TO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcXP-00049R-HG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:30:16 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hdcXM-00046G-Ie; Wed, 19 Jun 2019 11:30:12 -0400
Received: by mail-ed1-x542.google.com with SMTP id p15so27796809eds.8;
 Wed, 19 Jun 2019 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TgkZtnD/t/xdS+UbH52wzHUHwNkuIhtBPcIdqds31kU=;
 b=d7lfl9a5IuIhtj/qQTVTZ5SHujXRz4WcNPtl4zDxTq3y9f4Y1F90hy2Y/xNG9H81+q
 rDLja8NnCQJ6FH3qllzUOh3N5QEOYabkzJPvnDBfsWtIPzAErS598XAzMF6Z/ukjcnYN
 6eUJN64exddvPbs6ajEVdev1rHRnZcy0DkD9HokXyJMX+iIeXlg8rUobK59cyBALdFhh
 8NRi7jHmpVlW/uufoVE4wTLdg4i86PSwdHgDuxA5bElSIEkLJCGaQWbVOihdEwErEvCY
 v2JsezmTS7FLxJNDIA+UNrg3Gg1IEuz7IRdaAHIKTpAX+UKmMaBfPhXjQ/3iac04qUDR
 ugKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TgkZtnD/t/xdS+UbH52wzHUHwNkuIhtBPcIdqds31kU=;
 b=LdPc0iJt3+kpGjmO0wU86fRDqIRynficXA1M19XlDiwwp2bGqL63UTVYqCuF9Rifm7
 w1vamAclLq0He6NfTHsyW1isY1cHlpTeauYrfK2Z98qQ5bpZXyliTMwr2TX69hXocXE0
 fr9K7i/yo3Vcp9nWY2HfiMcRSjCCDSdlO+1fXKe/WGBYJzYYOvGNXgAgY72fzN+Z8y4b
 fsOq8WgqQDqgaud8ng4EcTlaX3dNpL44IMZ+YvaDQCwZ8kLq0i6nujYYB6UC61J+kgFe
 /uKA90T7PXSPcSNUZTdJzqR3jVZtLl1ZpMy6MxfyM4Je1uR2IQdMfWbYs0mfBPtPM+Wa
 vSfw==
X-Gm-Message-State: APjAAAUIb9hMW15m9WDuQC99qstQaw4083VCcXmG5XXLGI4XIfKVUJfR
 3dimCiRuUTJbuTTqnGEl60huQ5I1l7cqJcNbCro=
X-Google-Smtp-Source: APXvYqx4V/DrFCnsqSaCZWQ3nxGT0vgzw2rlVo1u+lvdYPf4JZ2mYpWWlXHiNd6noZqRv+m82HCb+uUmaz/ltAq6woo=
X-Received: by 2002:a50:ad0c:: with SMTP id y12mr85924080edc.25.1560958211233; 
 Wed, 19 Jun 2019 08:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <e718da8df07915765217dece609255b6ad196955.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmUz5xHqhuEvDWHBTpKN+k3uuNPQxNCGFWOfR21hMhWtPw@mail.gmail.com>
 <CANnJOVH34B0efKNSjNHD5ZmuWqAsybsmiwFXEQYvTye+oJBV=A@mail.gmail.com>
In-Reply-To: <CANnJOVH34B0efKNSjNHD5ZmuWqAsybsmiwFXEQYvTye+oJBV=A@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 19 Jun 2019 23:30:00 +0800
Message-ID: <CAEUhbmU_fjS4-DeZwnC7u4gQc3h44m4yYQ7vUA3-N0Wk64z5uw@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 2/5] hw/riscv: Add support
 for loading a firmware
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Wed, Jun 19, 2019 at 11:26 PM Jonathan Behrens <fintelia@gmail.com> wrot=
e:
>
> I was actually just writing up the same thing.  Shifting all the addresse=
s in the ELF file by 2 or 4MB is somewhat surprising behavior, especially b=
ecause this will apply to segments that are mapped even at much higher addr=
esses. If you want a segment aligned to a 1GB superpage boundary you now ne=
ed to place it slightly below so that it will be bumped up to the right pla=
ce. Further, ANDing all addresses with 0x7fffffff makes it impossible to ma=
p anything beyond the first 2GB of RAM.
>

Yes, current kernel_translate() logic is tightly coupled to the kernel
entry VA, and if we link kernel at some other address it will just
fail.

> Jonathan
>
> On Wed, Jun 19, 2019 at 11:16 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> On Wed, Jun 19, 2019 at 8:53 AM Alistair Francis
>> <alistair.francis@wdc.com> wrote:
>> >
>> > Add support for loading a firmware file for the virt machine and the
>> > SiFive U. This can be run with the following command:
>> >
>> >     qemu-system-riscv64 -machine virt -bios fw_jump.elf -kernel vmlinu=
x
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  hw/riscv/boot.c         | 41 +++++++++++++++++++++++++++++++++++++++-=
-
>> >  hw/riscv/sifive_e.c     |  2 +-
>> >  hw/riscv/sifive_u.c     |  6 +++++-
>> >  hw/riscv/spike.c        |  6 +++---
>> >  hw/riscv/virt.c         |  7 ++++++-
>> >  include/hw/riscv/boot.h |  4 +++-
>> >  6 files changed, 57 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> > index 62f94aaf8a..392ca0cb2e 100644
>> > --- a/hw/riscv/boot.c
>> > +++ b/hw/riscv/boot.c
>> > @@ -23,13 +23,50 @@
>> >  #include "exec/cpu-defs.h"
>> >  #include "hw/loader.h"
>> >  #include "hw/riscv/boot.h"
>> > +#include "hw/boards.h"
>> >  #include "elf.h"
>> >
>> > -target_ulong riscv_load_kernel(const char *kernel_filename)
>> > +#if defined(TARGET_RISCV32)
>> > +# define KERNEL_BOOT_ADDRESS 0x80400000
>> > +#else
>> > +# define KERNEL_BOOT_ADDRESS 0x80200000
>> > +#endif
>> > +
>> > +static uint64_t kernel_translate(void *opaque, uint64_t addr)
>> > +{
>> > +    MachineState *machine =3D opaque;
>> > +
>> > +    /*
>> > +     * If the user specified a firmware move the kernel to the offset
>> > +     * start address.
>> > +     */
>>
>> Why?
>>
>> > +    if (machine->firmware) {
>> > +        return (addr & 0x7fffffff) + KERNEL_BOOT_ADDRESS;
>>
>> So with both "-bios" and "-kernel", the kernel address will be moved
>> to another address other than 0x80200000 (for 64-bit). This does not
>> look good to me.
>>

So why not simply return KERNEL_BOOT_ADDRESS in kernel_translate()?

Regards,
Bin


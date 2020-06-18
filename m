Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 22:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F167206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 22:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="iJDPgAUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F167206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm3G4-0007rh-R8
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 18:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jm3FL-0007LB-Ec
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 18:42:59 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jm3FJ-0001qy-9U
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 18:42:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id j12so1281029pfn.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=JDsXUrwiyOxKf5EPRtphxAPjkjSRxEUgA9ZOYjRX/kk=;
 b=iJDPgAUEMsw8E8skxCSOsFtCdfWXqnEzKsTTbO085A3ppKwCPV3WL5q1PZchjHH4cQ
 Otyq5E7ytqo3JurXE7nfZQV4WdJITEBa1Afaij1n6YvxFD0lP1MClxEOGPHEjLTD7C5g
 +0A8XzTu2n6FGzH4bMHF9E3mNwreV0Rq/j3kPMpGTk/a19ZELLG6qufq9LiVTiGPXcGm
 WVBDbrphk7hC1U+t4ggXqeS2bTNsrcOT8Z3aZFAG1oNq77mjjBZZow2/PvNAgx5ObYSB
 B59eUnC+B0yVqMh6feh2YESVA3XQlCruLRFXku+RGs2jdFgThFryBQO+eE2bG6LJ5ARF
 rONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=JDsXUrwiyOxKf5EPRtphxAPjkjSRxEUgA9ZOYjRX/kk=;
 b=o6LMU443w4MpVTuEvLjXm2S7dXXb37Gtvj5A6TmWlL5N9rpbX3S2viynoaW253lXlc
 nnQzTKiRhZttrr3NjIcCy8QrGxVxghHvUAdM2puBLkYXfkvPW5VPR64W5hBExbIo89Yb
 fiNdnVE1f/49Ap2cQ4qKmFQcc+f8bcJ9cHDg6KHPhosczs2F/klyResmpynjtXpqTz4q
 4bGe9jjHvU2dXCGUo2pPEealmiF9p4ftQYbk5RQWW5y++0k9p06+fc+x7VkLtW/gcufB
 c/ybr1FXJqtYGp2bDsN9F7nE0N66k1PTA5RqzXoRok3WS2/Xpr2Mbclh94Mm0cUEprEu
 o9cQ==
X-Gm-Message-State: AOAM533l4B073m5fK6XV05D2KasYqz+kYBghedoA0b6cezAFXb/e1CX0
 KBSFIHl0PfExVbBVN8ypcPNlCg==
X-Google-Smtp-Source: ABdhPJwa9fza9+H5BE5YttB7nji9Mj6EdEpqwr4CSVnjOsVSExToqj2PGum9/yEyhgVtnYT01NHDSw==
X-Received: by 2002:a62:52d6:: with SMTP id g205mr5641864pfb.78.1592520174976; 
 Thu, 18 Jun 2020 15:42:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id y4sm3797849pfr.182.2020.06.18.15.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 15:42:54 -0700 (PDT)
Date: Thu, 18 Jun 2020 15:42:54 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 15:41:33 PDT (-0700)
Subject: Re: [PATCH v1 2/2] sifive_e: Support the revB machine
In-Reply-To: <CAKmqyKPOSdgnWfCR40jXC6qQjeeEr8rfzQaez+Ce92CZstz_aw@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-1811460a-33f1-4c92-a74e-bdb56605da62@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=palmer@dabbelt.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 15:13:49 PDT (-0700), alistair23@gmail.com wrote:
> On Thu, May 28, 2020 at 11:13 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Thu, May 21, 2020 at 8:57 AM Alistair Francis <alistair23@gmail.com> wrote:
>> >
>> > On Wed, May 20, 2020 at 4:08 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > >
>> > > On Thu, 14 May 2020 13:47:10 PDT (-0700), Alistair Francis wrote:
>> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > > > ---
>> > > >  hw/riscv/sifive_e.c         | 35 +++++++++++++++++++++++++++++++----
>> > > >  include/hw/riscv/sifive_e.h |  1 +
>> > > >  2 files changed, 32 insertions(+), 4 deletions(-)
>> > > >
>> > > > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> > > > index 472a98970b..cb7818341b 100644
>> > > > --- a/hw/riscv/sifive_e.c
>> > > > +++ b/hw/riscv/sifive_e.c
>> > > > @@ -98,10 +98,14 @@ static void riscv_sifive_e_init(MachineState *machine)
>> > > >          memmap[SIFIVE_E_DTIM].base, main_mem);
>> > > >
>> > > >      /* Mask ROM reset vector */
>> > > > -    uint32_t reset_vec[2] = {
>> > > > -        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
>> > > > -        0x00028067,        /* 0x1004: jr      t0 */
>> > > > -    };
>> > > > +    uint32_t reset_vec[2];
>> > > > +
>> > > > +    if (s->revb) {
>> > > > +        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
>> > > > +    } else {
>> > > > +        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
>> > > > +    }
>> > > > +    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
>> > > >
>> > > >      /* copy in the reset vector in little_endian byte order */
>> > > >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> > > > @@ -115,8 +119,31 @@ static void riscv_sifive_e_init(MachineState *machine)
>> > > >      }
>> > > >  }
>> > > >
>> > > > +static bool sifive_e_machine_get_revb(Object *obj, Error **errp)
>> > > > +{
>> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
>> > > > +
>> > > > +    return s->revb;
>> > > > +}
>> > > > +
>> > > > +static void sifive_e_machine_set_revb(Object *obj, bool value, Error **errp)
>> > > > +{
>> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
>> > > > +
>> > > > +    s->revb = value;
>> > > > +}
>> > > > +
>> > > >  static void sifive_e_machine_instance_init(Object *obj)
>> > > >  {
>> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
>> > > > +
>> > > > +    s->revb = false;
>> > > > +    object_property_add_bool(obj, "revb", sifive_e_machine_get_revb,
>> > > > +                             sifive_e_machine_set_revb, NULL);
>> > > > +    object_property_set_description(obj, "revb",
>> > > > +                                    "Set on to tell QEMU that it should model "
>> > > > +                                    "the revB HiFive1 board",
>> > > > +                                    NULL);
>> > > >  }
>> > > >
>> > > >  static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
>> > > > diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
>> > > > index 414992119e..0d3cd07fcc 100644
>> > > > --- a/include/hw/riscv/sifive_e.h
>> > > > +++ b/include/hw/riscv/sifive_e.h
>> > > > @@ -45,6 +45,7 @@ typedef struct SiFiveEState {
>> > > >
>> > > >      /*< public >*/
>> > > >      SiFiveESoCState soc;
>> > > > +    bool revb;
>> > > >  } SiFiveEState;
>> > > >
>> > > >  #define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
>> > >
>> > > IIRC there are way more differences between the un-suffixed FE310 and the Rev
>> > > B, specifically the interrupt map is all different.
>> >
>> > The three IRQs that QEMU uses for the SiFive E (UART0, UART1 and GPIO)
>> > all seem to be the same.
>>
>> Ping!
>
> Ping^2
>
> Applying to RISC-V tree.

They're not: uart0 is interrupt 3 on the rev b but 5 on the non-rev b (which
they don't call rev a but I'm going to :)).  There's isn't even a uart1 in the
DTS on the rev a, and the GPIO interrupts are different as well.

The DTS files are in SiFive's SDK:

https://github.com/sifive/freedom-e-sdk/blob/master/bsp/sifive-hifive1-revb/core.dts
https://github.com/sifive/freedom-e-sdk/blob/master/bsp/sifive-hifive1/core.dts

which should also generate some test programs.  When I was there we tested on
QEMU for the platforms that were supported, so there should be some support for
doing so still.

>
> Alistair
>
>>
>> >
>> > Alistair


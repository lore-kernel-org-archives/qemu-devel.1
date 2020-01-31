Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D88620707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtDHQv6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D88620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXgL-000645-Kl
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixXfM-0005PO-U8
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixXfL-0000ZO-IF
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:53:04 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixXfL-0000Xm-9A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:53:03 -0500
Received: by mail-wr1-x442.google.com with SMTP id j104so8919761wrj.7
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nA+qHn+r1zOEXnmkqs1YpSUQU3YPmVelMWhzQ5Ift5A=;
 b=CtDHQv6UsrgBcllmuGv4G+YdQX92gWmfhOSDXLERjMmtTV5mKtZRB86JE6FCOXrAXY
 p8nfgv+tb4MTCaY75VtnX4Vlzag824VuyBbJPye7gO1r3wF/v7W5BDtBO8JKZ/FQPflm
 tmpdBUw+ETQ322MZKbTNAoRcHKXXVEzpeeGwO/yW5WotkBtvLQPf/Gr3ZI10Eug0KgRl
 X9WTKBecIzWdX3pWT2+rtCfBIBjjQUtKaCMfEhLSC5hPSvBcsNIHsIckMAKqoeYdaVFm
 EdGoB+VPyboXGhthcfKxYI/LNod3BHsEsiInApvVaSIYYDJNEPDulwl2nAVtiPGNX/5L
 phWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nA+qHn+r1zOEXnmkqs1YpSUQU3YPmVelMWhzQ5Ift5A=;
 b=SG8BZdMAVEOgtnOGTAQSXRi3Ee8/LvImEEB0tLuQi/BXy/Vt4xrdmI/2UZRgMtcNdq
 2iBDVd7eiD2m1R2auxff4T/+542HBEDin9OAqyaGkNV6g06A7hk56EcsgXQ7Zaz3Adel
 jxCz61zUZgXReRasCOWwbEwAJhm8kZp9psyFlQerTdK/bsgRTL3AQkLk//4qqSfET0TC
 EFWraomUXlVEWcb/n6ywsiwll9541hMHZL0sESkUUqDtBvQvGF5Ht7JMoSSU+TPUOVq5
 2ZP9J0Q79ODn1kYIrZpIjktuCbvPP7chCFpx/dVXlfXrhO85StKwQGSq08tfLJi+cEMk
 Rbdg==
X-Gm-Message-State: APjAAAVsjwTr9UPYncieiLzEE9LCO4RtlygtQh5FehjoaS8ybFg1H3rl
 o0FrkiRnCA1T7G4aqv/LR/kHfw==
X-Google-Smtp-Source: APXvYqyMSKp5GvmzN4uwjkX+Grjz+LB7dPoQjsMpdsRw67eW6DoxUBzKa+fi4zWlfNme3J8cHO4mwQ==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr13145459wrt.41.1580482381883; 
 Fri, 31 Jan 2020 06:53:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm11137339wmj.23.2020.01.31.06.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 06:52:59 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B7A01FF87;
 Fri, 31 Jan 2020 14:52:59 +0000 (GMT)
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
 <20200131010941.10636-2-philmd@redhat.com> <87sgjv9883.fsf@linaro.org>
 <CAP+75-WkRVeV3B09C7sTkzzH6DSNzO4vitTf7Q4SYBSxL1CgSg@mail.gmail.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] !fixup "hw/misc: Add limited support for AVR power
 device"
In-reply-to: <CAP+75-WkRVeV3B09C7sTkzzH6DSNzO4vitTf7Q4SYBSxL1CgSg@mail.gmail.com>
Date: Fri, 31 Jan 2020 14:52:59 +0000
Message-ID: <87mua38ypg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On Fri, Jan 31, 2020 at 12:27 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>> > - convert DB_PRINT() to trace-events
>> > - fix style/indentation
>> >
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> > ---
>> >  hw/misc/avr_power.c  | 17 +++++++++--------
>> >  hw/misc/trace-events |  4 ++++
>> >  2 files changed, 13 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
>> > index 598bc7279c..65ff7c4405 100644
>> > --- a/hw/misc/avr_power.c
>> > +++ b/hw/misc/avr_power.c
>> > @@ -27,9 +27,7 @@
>> >  #include "qemu/log.h"
>> >  #include "hw/qdev-properties.h"
>> >  #include "hw/irq.h"
>> > -
>> > -#define DB_PRINT(fmt, args...) /* Nothing */
>> > -/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##=
 args)*/
>> > +#include "trace.h"
>> >
>> >  static void avr_mask_reset(DeviceState *dev)
>> >  {
>> > @@ -48,19 +46,20 @@ static uint64_t avr_mask_read(void *opaque, hwaddr=
 offset, unsigned size)
>> >      assert(offset =3D=3D 0);
>> >      AVRMaskState *s =3D opaque;
>> >
>> > +    trace_avr_power_read(s->val);
>> > +
>> >      return (uint64_t)s->val;
>> >  }
>> >
>> >  static void avr_mask_write(void *opaque, hwaddr offset,
>> > -                              uint64_t val64, unsigned size)
>> > +                           uint64_t val64, unsigned size)
>> >  {
>> >      assert(size =3D=3D 1);
>> >      assert(offset =3D=3D 0);
>> >      AVRMaskState *s =3D opaque;
>> >      uint8_t val8 =3D val64;
>> >
>> > -    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
>> > -
>> > +    trace_avr_power_write(val8);
>>
>> You've dropped offset in this trace point which is probably worth
>> keeping so you track where is being written to. Same with the read.
>
> I dropped it because it is always 0x00, the register is 8bit wide. See
> below, memory_region_init_io(...,1).
> I thought about adding a "name" property so each instance can display
> the device it belongs to, but this was too invasive, so I decided to
> keep this change for later.

Ahh I did wonder (I was reviewing without applying). Might be worth
mentioning in the commit then.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
>> >      s->val =3D val8;
>> >      for (int i =3D 0; i < 8; i++) {
>> >          qemu_set_irq(s->irq[i], (val8 & (1 << i)) !=3D 0);
>> > @@ -71,7 +70,9 @@ static const MemoryRegionOps avr_mask_ops =3D {
>> >      .read =3D avr_mask_read,
>> >      .write =3D avr_mask_write,
>> >      .endianness =3D DEVICE_NATIVE_ENDIAN,
>> > -    .impl =3D {.max_access_size =3D 1}
>> > +    .impl =3D {
>> > +        .max_access_size =3D 1,
>> > +    },
>> >  };
>> >
>> >  static void avr_mask_init(Object *dev)
>> > @@ -80,7 +81,7 @@ static void avr_mask_init(Object *dev)
>> >      SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);
>> >
>> >      memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_=
MASK,
>> > -            0x01);
>> > +                          0x01);
>
> ^ Region has only 1 address: 0x00.
>
>> >      sysbus_init_mmio(busdev, &s->iomem);
>> >
>> >      for (int i =3D 0; i < 8; i++) {
>> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> > index 7f0f5dff3a..f716881bb1 100644
>> > --- a/hw/misc/trace-events
>> > +++ b/hw/misc/trace-events
>> > @@ -179,3 +179,7 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=
=3D%u value=3D0x%02x"
>> >  via1_rtc_cmd_pram_write(int addr, int value) "addr=3D%u value=3D0x%02=
x"
>> >  via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int val=
ue) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
>> >  via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int va=
lue) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
>> > +
>> > +# avr_power.c
>> > +avr_power_read(uint8_t value) "power_reduc read value:%u"
>> > +avr_power_write(uint8_t value) "power_reduc write value:%u"
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e


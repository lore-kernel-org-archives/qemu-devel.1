Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F79C2D0C6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 18:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CFD2173E
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO6/l7nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CFD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilHDz-0005UZ-CJ
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 13:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilHD9-00054p-84
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 13:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilHD3-0005KK-3y
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 13:53:15 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:42074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilHD2-0005E0-RP
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 13:53:09 -0500
Received: by mail-qv1-xf44.google.com with SMTP id dc14so11105255qvb.9
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rc+X7UKjqYJTwjNsI6AYZoE+FlMkAaBQ0DHmGJI7BVs=;
 b=oO6/l7nqswUUXWe72Id6EAiTM0M7M3sZDkSHsGJdQCa1fE6H4UT5992rDfNCskcnHv
 KmSTmCQshqEJ42ws6w2UzwgM+vSZcMuUA8aZnYVwZyg8xejTXmPDFh95lBfKI9vc3r1M
 BNnV1nvtqvOi9ZYgZg9Ud/zNY5rc/lTovl7/zhw0JY5MlsJ5uIS2ehvOZs+us4GBDIcm
 6epNCPW829fK1qjReZcBgWquADQ4ZjRRgJeLRCaFtNJGD+42EsqX1fy2BBINgOinm0DD
 1vei8FQM8YWIYslUBlx1nZ22h+UjjTlZ5PIldNPc+DQE5BS9EEoKAHNWpHw9goQBs7op
 sD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rc+X7UKjqYJTwjNsI6AYZoE+FlMkAaBQ0DHmGJI7BVs=;
 b=MBh6AS4sYGgJ1rn+E5dveTpGe18eY3F8xx3e8AFxjhBQs69dXH5top/AKzMmRXyuY9
 BqTBaj9liiNcalpuhDoKJ7Uwp//KUpRDH4IhWMm+puup9HRoohwj2cA7zkC330xlawY2
 AeUH2cGkITpZz5AkmHDLUr92lwEgd2cXXNihObgDqRh9nacAWAbTtE+8K4NvfOah3UOs
 exzQ4a5TnzMUXOIMFfuuS/a59GC+mF9gA7t/GbxPAv9+3jRRzUeIB3hlWOe8HvFhFwKe
 sgg9rSmo4aSUAtNQQkaXg798cWkt5kCrsttnQQQon8X3B5ezZa+Y/YhJ8A3wsXL52kF2
 zDPQ==
X-Gm-Message-State: APjAAAXO5/yXEIGj5sQhPex1JG8dD6u3xh384sdKnF5jt51x76agRsdj
 ZYq8DEMrLYqHr/Pt114XqPgMf5D76jRivLhHg2E=
X-Google-Smtp-Source: APXvYqz1tSP+4sjN3X3jPEvhglOU+1BL0UFfCRzMT+monD1c+za9iagQGGLrQO7Yz/4JsRQ61wZSakSrM8sU491VIOQ=
X-Received: by 2002:a0c:8d0a:: with SMTP id r10mr42711481qvb.7.1577559187750; 
 Sat, 28 Dec 2019 10:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-15-mrolnik@gmail.com>
 <CAL1e-=ggk1_RqUSk2M=b9cBjzJA0VBpsH8qAQ9Uvbya2rCNStg@mail.gmail.com>
In-Reply-To: <CAL1e-=ggk1_RqUSk2M=b9cBjzJA0VBpsH8qAQ9Uvbya2rCNStg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 28 Dec 2019 20:52:28 +0200
Message-ID: <CAK4993gw8ju=AQZCeGGL5MobqrKruHVY=p6C-dcM_kAERs14DA@mail.gmail.com>
Subject: Re: [PATCH v39 14/22] target/avr: Add dummy mask device
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ff81d6059ac81e45"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ff81d6059ac81e45
Content-Type: text/plain; charset="UTF-8"

This device is not "Power Reduction" but power reduction registers can be
implemented with it. All it does, whenever a bit is written the device
raises an interrupt / IRQ.
If you have a better name please advise.

On Mon, Dec 23, 2019 at 10:46 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> ---
>
>
> Hi, Michael.
>
> Please avoid empty commit messages.
>
> At the very beginning, there is a line:
>
> + * AVR Power Reduction
>
> Why is that? There is a power reduction register in the docs, but is it
> covered in this patch?
>
> Further, "mask" is too genetic word. Pkease use more specific name bot fir
> filename and variables within this patch. "interrupt controller",
> "irq_masq", "IrqMask", "irq" are justsome of ideas.
>
> Yours,
> Aleksandar
>
>
>>  include/hw/misc/avr_mask.h |  47 ++++++++++++++++
>>  hw/misc/avr_mask.c         | 112 +++++++++++++++++++++++++++++++++++++
>>  hw/misc/Kconfig            |   3 +
>>  hw/misc/Makefile.objs      |   2 +
>>  4 files changed, 164 insertions(+)
>>  create mode 100644 include/hw/misc/avr_mask.h
>>  create mode 100644 hw/misc/avr_mask.c
>>
>> diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h
>> new file mode 100644
>> index 0000000000..d3e21972d8
>> --- /dev/null
>> +++ b/include/hw/misc/avr_mask.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + * AVR Power Reduction
>> + *
>> + * Copyright (c) 2019 Michael Rolnik
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining
>> a copy
>> + * of this software and associated documentation files (the "Software"),
>> to deal
>> + * in the Software without restriction, including without limitation the
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#ifndef HW_avr_mask_H
>> +#define HW_avr_mask_H
>> +
>> +#include "hw/sysbus.h"
>> +#include "chardev/char-fe.h"
>> +#include "hw/hw.h"
>> +
>> +
>> +#define TYPE_AVR_MASK "avr-mask"
>> +#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)
>> +
>> +typedef struct {
>> +    /* <private> */
>> +    SysBusDevice parent_obj;
>> +
>> +    /* <public> */
>> +    MemoryRegion iomem;
>> +
>> +    uint8_t val;
>> +    qemu_irq irq[8];
>> +} AVRMaskState;
>> +
>> +#endif /* HW_avr_mask_H */
>> diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c
>> new file mode 100644
>> index 0000000000..3af82ed9c1
>> --- /dev/null
>> +++ b/hw/misc/avr_mask.c
>> @@ -0,0 +1,112 @@
>> +/*
>> + * AVR Power Reduction
>> + *
>> + * Copyright (c) 2019 Michael Rolnik
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining
>> a copy
>> + * of this software and associated documentation files (the "Software"),
>> to deal
>> + * in the Software without restriction, including without limitation the
>> rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>> sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/avr_mask.h"
>> +#include "qemu/log.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/irq.h"
>> +
>> +#define DB_PRINT(fmt, args...) /* Nothing */
>> +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
>> args)*/
>> +
>> +static void avr_mask_reset(DeviceState *dev)
>> +{
>> +    AVRMaskState *s = AVR_MASK(dev);
>> +
>> +    s->val = 0x00;
>> +
>> +    for (int i = 0; i < 8; i++) {
>> +        qemu_set_irq(s->irq[i], 0);
>> +    }
>> +}
>> +
>> +static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    assert(size == 1);
>> +    assert(offset == 0);
>> +    AVRMaskState *s = opaque;
>> +
>> +    return (uint64_t)s->val;
>> +}
>> +
>> +static void avr_mask_write(void *opaque, hwaddr offset,
>> +                              uint64_t val64, unsigned size)
>> +{
>> +    assert(size == 1);
>> +    assert(offset == 0);
>> +    AVRMaskState *s = opaque;
>> +    uint8_t val8 = val64;
>> +
>> +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
>> +
>> +    s->val = val8;
>> +    for (int i = 0; i < 8; i++) {
>> +        qemu_set_irq(s->irq[i], (val8 & (1 << i)) != 0);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps avr_mask_ops = {
>> +    .read = avr_mask_read,
>> +    .write = avr_mask_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {.max_access_size = 1}
>> +};
>> +
>> +static void avr_mask_init(Object *dev)
>> +{
>> +    AVRMaskState *s = AVR_MASK(dev);
>> +    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
>> +
>> +    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s,
>> TYPE_AVR_MASK,
>> +            0x01);
>> +    sysbus_init_mmio(busdev, &s->iomem);
>> +
>> +    for (int i = 0; i < 8; i++) {
>> +        sysbus_init_irq(busdev, &s->irq[i]);
>> +    }
>> +    s->val = 0x00;
>> +}
>> +
>> +static void avr_mask_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->reset = avr_mask_reset;
>> +}
>> +
>> +static const TypeInfo avr_mask_info = {
>> +    .name          = TYPE_AVR_MASK,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(AVRMaskState),
>> +    .class_init    = avr_mask_class_init,
>> +    .instance_init = avr_mask_init,
>> +};
>> +
>> +static void avr_mask_register_types(void)
>> +{
>> +    type_register_static(&avr_mask_info);
>> +}
>> +
>> +type_init(avr_mask_register_types)
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index 2164646553..e79841e3a4 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -125,4 +125,7 @@ config MAC_VIA
>>      select MOS6522
>>      select ADB
>>
>> +config AVR_MASK
>> +    bool
>> +
>>  source macio/Kconfig
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index ba898a5781..3a8093be6a 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
>>  obj-$(CONFIG_MAC_VIA) += mac_via.o
>>
>>  common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
>> +
>> +obj-$(CONFIG_AVR_MASK) += avr_mask.o
>> --
>> 2.17.2 (Apple Git-113)
>>
>>

-- 
Best Regards,
Michael Rolnik

--000000000000ff81d6059ac81e45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This device is not &quot;Power Reduction&quot; but power r=
eduction registers can be implemented with it. All it does, whenever a bit =
is written the device raises an interrupt / IRQ.=C2=A0<div>If you have a be=
tter name please advise.</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Dec 23, 2019 at 10:46 AM Aleksandar M=
arkovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mai=
l@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br><br>On Wednesday, December 18, 2019, Michael Rolnik &lt;<a h=
ref=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt=
; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by=
: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank"=
>mrolnik@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>Hi, Michael.</div><div><br></div><div>P=
lease avoid empty commit messages.</div><div><br></div><div>At the very beg=
inning, there is a line:</div><div><br></div><div>+ * AVR Power Reduction<b=
r></div><div><br></div><div>Why is that? There is a power reduction registe=
r in the docs, but is it covered in this patch?</div><div><br></div><div>Fu=
rther, &quot;mask&quot; is too genetic word. Pkease use more specific name =
bot fir filename and variables within this patch. &quot;interrupt controlle=
r&quot;, &quot;irq_masq&quot;, &quot;IrqMask&quot;, &quot;irq&quot; are jus=
tsome of ideas.</div><div><br></div><div>Yours,</div><div>Aleksandar</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0include/hw/misc/avr_mask.h |=C2=A0 47 ++++++++++++++++<br>
=C2=A0hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 112 +++++++++++=
++++++++++++++++++++++++++<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A04 files changed, 164 insertions(+)<br>
=C2=A0create mode 100644 include/hw/misc/avr_mask.h<br>
=C2=A0create mode 100644 hw/misc/avr_mask.c<br>
<br>
diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h<br>
new file mode 100644<br>
index 0000000000..d3e21972d8<br>
--- /dev/null<br>
+++ b/include/hw/misc/avr_mask.h<br>
@@ -0,0 +1,47 @@<br>
+/*<br>
+ * AVR Power Reduction<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#ifndef HW_avr_mask_H<br>
+#define HW_avr_mask_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;chardev/char-fe.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+<br>
+<br>
+#define TYPE_AVR_MASK &quot;avr-mask&quot;<br>
+#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
+=C2=A0 =C2=A0 MemoryRegion iomem;<br>
+<br>
+=C2=A0 =C2=A0 uint8_t val;<br>
+=C2=A0 =C2=A0 qemu_irq irq[8];<br>
+} AVRMaskState;<br>
+<br>
+#endif /* HW_avr_mask_H */<br>
diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c<br>
new file mode 100644<br>
index 0000000000..3af82ed9c1<br>
--- /dev/null<br>
+++ b/hw/misc/avr_mask.c<br>
@@ -0,0 +1,112 @@<br>
+/*<br>
+ * AVR Power Reduction<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/misc/avr_mask.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+<br>
+#define DB_PRINT(fmt, args...) /* Nothing */<br>
+/*#define DB_PRINT(fmt, args...) printf(&quot;%s: &quot; fmt &quot;\n&quot=
;, __func__, ## args)*/<br>
+<br>
+static void avr_mask_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D AVR_MASK(dev);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;val =3D 0x00;<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[i], 0);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)<=
br>
+{<br>
+=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
+=C2=A0 =C2=A0 assert(offset =3D=3D 0);<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 return (uint64_t)s-&gt;val;<br>
+}<br>
+<br>
+static void avr_mask_write(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val64, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
+=C2=A0 =C2=A0 assert(offset =3D=3D 0);<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D opaque;<br>
+=C2=A0 =C2=A0 uint8_t val8 =3D val64;<br>
+<br>
+=C2=A0 =C2=A0 DB_PRINT(&quot;write %d to offset %d&quot;, val8, (uint8_t)o=
ffset);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;val =3D val8;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[i], (val8 &amp; (1 &lt;=
&lt; i)) !=3D 0);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static const MemoryRegionOps avr_mask_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D avr_mask_read,<br>
+=C2=A0 =C2=A0 .write =3D avr_mask_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+=C2=A0 =C2=A0 .impl =3D {.max_access_size =3D 1}<br>
+};<br>
+<br>
+static void avr_mask_init(Object *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D AVR_MASK(dev);<br>
+=C2=A0 =C2=A0 SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, dev, &amp;avr_mask_o=
ps, s, TYPE_AVR_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(busdev, &amp;s-&gt;iomem);<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(busdev, &amp;s-&gt;irq[i]);<br=
>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 s-&gt;val =3D 0x00;<br>
+}<br>
+<br>
+static void avr_mask_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D avr_mask_reset;<br>
+}<br>
+<br>
+static const TypeInfo avr_mask_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AVR_MASK,<b=
r>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AVRMaskState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D avr_mask_class_init,<br>
+=C2=A0 =C2=A0 .instance_init =3D avr_mask_init,<br>
+};<br>
+<br>
+static void avr_mask_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;avr_mask_info);<br>
+}<br>
+<br>
+type_init(avr_mask_register_types)<br>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>
index 2164646553..e79841e3a4 100644<br>
--- a/hw/misc/Kconfig<br>
+++ b/hw/misc/Kconfig<br>
@@ -125,4 +125,7 @@ config MAC_VIA<br>
=C2=A0 =C2=A0 =C2=A0select MOS6522<br>
=C2=A0 =C2=A0 =C2=A0select ADB<br>
<br>
+config AVR_MASK<br>
+=C2=A0 =C2=A0 bool<br>
+<br>
=C2=A0source macio/Kconfig<br>
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
index ba898a5781..3a8093be6a 100644<br>
--- a/hw/misc/Makefile.objs<br>
+++ b/hw/misc/Makefile.objs<br>
@@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o<br>
=C2=A0obj-$(CONFIG_MAC_VIA) +=3D mac_via.o<br>
<br>
=C2=A0common-obj-$(CONFIG_GRLIB) +=3D grlib_ahb_apb_pnp.o<br>
+<br>
+obj-$(CONFIG_AVR_MASK) +=3D avr_mask.o<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000ff81d6059ac81e45--


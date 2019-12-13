Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED20C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D4B24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/38ZT1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D4B24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjqQ-0007Sv-Sh
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifjhV-00040M-Vv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifjhT-0004PB-Sy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:05:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifjhT-0004N4-NQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576238738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wsndkmrDgO4R616mA/j4jCunnkK9YxFW8KpePJyouyI=;
 b=X/38ZT1MGLY1q5H9D2jEprUPXcKDI3fnu+9N52R08qjGc8ckukaoI0O+rONQQuZ3qgw0zc
 ODcq+/EM8JAA3ba24OofP5CGe0lZ43+stDtr7bCF0Z8PH9W8M7ANgR4cTbX1Bm5Fpo8/H5
 v0xJJllycYREQqBRXDw3IBN7kNBsJps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-HNH_5NGkMpm1W5BaMDoZEA-1; Fri, 13 Dec 2019 07:05:37 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so2506471wru.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 04:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ID22dBbZQaduHjGMyJjJpvFzGzVmgD0q2u/LGoMz5Q8=;
 b=LfRBIUZOSyQKs/XMVQW+99oHtj51pk6n+O23WA9WaJCh6eEolOTdi7XU6TFI/6ztUR
 CX5VfGFvr5nKDjLwa/7uh+dPMEFs3+bJHoxndSjtaUzmUJy4AMzWfFrzwNNY/jUEmjXq
 y9E9HCZR4L45GUI0/sOvX0dxrG2cy+Kv8QMZqXEYgCuouY1qR5g3TwS4cgJwmUNRdRny
 oNdwuDzl9Tc94rJO6EWYii2tXROINQVLzukdQzCh2Zxj5v8BvaAmBUfSIHQ0ojTSE/37
 e23vRsHuedsF/cmaUOZdw3+F7vLsDuFLl3d/skoiNvWx0kQnHx5EuDcHFVOZ8PHw0epc
 irIg==
X-Gm-Message-State: APjAAAWcjCihQQ+g7pZunryYFgvI3jfl/isD1zCUxyiAZwk9QcnQv0af
 c8lnOZduJ8KJ73aAlT6Fgpdy/MESBapRrGC7oofxSBnjmWkKS0wmfHLfylrbYaW9MpkQT9JwVvJ
 q0GvZz14K5tLUJNo=
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr12838148wmb.160.1576238736156; 
 Fri, 13 Dec 2019 04:05:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwNzbgUAqsXlPgBdwJLpzZIig9sqgrEf4Ulzm/Kkvag2x+QB14mQioqYSBgcXnauywaSvRtg==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr12838108wmb.160.1576238735840; 
 Fri, 13 Dec 2019 04:05:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id f1sm10140719wml.11.2019.12.13.04.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 04:05:35 -0800 (PST)
Subject: Re: [PATCH 4/4] hw/i386/pc: Extract the port92 device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213105100.8173-1-philmd@redhat.com>
 <20191213105100.8173-5-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <935d20ba-4a67-b4ee-cc0a-f549a4218159@redhat.com>
Date: Fri, 13 Dec 2019 13:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213105100.8173-5-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: HNH_5NGkMpm1W5BaMDoZEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 11:51, Philippe Mathieu-Daud=C3=A9 wrote:
> This device is only used by the PC machines. The pc.c file is
> already big enough, with 2255 lines. By removing 113 lines of
> it, we reduced it by 5%. It is now a bit easier to navigate
> the file.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> checkpatch warning:
>=20
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
>   #142:
>   new file mode 100644
>=20
> is harmless because MAINTAINERS PC entry matches the directory:
>=20
>   PC
>   ...
>   F: hw/i386/
> ---
>  include/hw/i386/pc.h  |   3 +
>  hw/i386/pc.c          | 113 -------------------------------------
>  hw/i386/port92.c      | 126 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/Makefile.objs |   1 +
>  hw/i386/trace-events  |   2 +
>  5 files changed, 132 insertions(+), 113 deletions(-)
>  create mode 100644 hw/i386/port92.c
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1f86eba3f9..7e8d18d6fa 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -224,8 +224,11 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
> =20
>  #define FW_CFG_IO_BASE     0x510
> =20
> +/* port92.c */
>  #define PORT92_A20_LINE "a20"
> =20
> +#define TYPE_PORT92 "port92"
> +
>  /* hpet.c */
>  extern int no_hpet;
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2e8992c7d0..15efcb29d5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -733,119 +733,6 @@ void pc_cmos_init(PCMachineState *pcms,
>      qemu_register_reset(pc_cmos_init_late, &arg);
>  }
> =20
> -#define TYPE_PORT92 "port92"
> -#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
> -
> -/* port 92 stuff: could be split off */
> -typedef struct Port92State {
> -    ISADevice parent_obj;
> -
> -    MemoryRegion io;
> -    uint8_t outport;
> -    qemu_irq a20_out;
> -} Port92State;
> -
> -static void port92_write(void *opaque, hwaddr addr, uint64_t val,
> -                         unsigned size)
> -{
> -    Port92State *s =3D opaque;
> -    int oldval =3D s->outport;
> -
> -    trace_port92_write(val);
> -    s->outport =3D val;
> -    qemu_set_irq(s->a20_out, (val >> 1) & 1);
> -    if ((val & 1) && !(oldval & 1)) {
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> -    }
> -}
> -
> -static uint64_t port92_read(void *opaque, hwaddr addr,
> -                            unsigned size)
> -{
> -    Port92State *s =3D opaque;
> -    uint32_t ret;
> -
> -    ret =3D s->outport;
> -    trace_port92_read(ret);
> -    return ret;
> -}
> -
> -static const VMStateDescription vmstate_port92_isa =3D {
> -    .name =3D "port92",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT8(outport, Port92State),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static void port92_reset(DeviceState *d)
> -{
> -    Port92State *s =3D PORT92(d);
> -
> -    s->outport &=3D ~1;
> -}
> -
> -static const MemoryRegionOps port92_ops =3D {
> -    .read =3D port92_read,
> -    .write =3D port92_write,
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 1,
> -    },
> -    .endianness =3D DEVICE_LITTLE_ENDIAN,
> -};
> -
> -static void port92_initfn(Object *obj)
> -{
> -    Port92State *s =3D PORT92(obj);
> -
> -    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1=
);
> -
> -    s->outport =3D 0;
> -
> -    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, =
1);
> -}
> -
> -static void port92_realizefn(DeviceState *dev, Error **errp)
> -{
> -    ISADevice *isadev =3D ISA_DEVICE(dev);
> -    Port92State *s =3D PORT92(dev);
> -
> -    isa_register_ioport(isadev, &s->io, 0x92);
> -}
> -
> -static void port92_class_initfn(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    dc->realize =3D port92_realizefn;
> -    dc->reset =3D port92_reset;
> -    dc->vmsd =3D &vmstate_port92_isa;
> -    /*
> -     * Reason: unlike ordinary ISA devices, this one needs additional
> -     * wiring: its A20 output line needs to be wired up with
> -     * qdev_connect_gpio_out_named().
> -     */
> -    dc->user_creatable =3D false;
> -}
> -
> -static const TypeInfo port92_info =3D {
> -    .name          =3D TYPE_PORT92,
> -    .parent        =3D TYPE_ISA_DEVICE,
> -    .instance_size =3D sizeof(Port92State),
> -    .instance_init =3D port92_initfn,
> -    .class_init    =3D port92_class_initfn,
> -};
> -
> -static void port92_register_types(void)
> -{
> -    type_register_static(&port92_info);
> -}
> -
> -type_init(port92_register_types)
> -
>  static void handle_a20_line_change(void *opaque, int irq, int level)
>  {
>      X86CPU *cpu =3D opaque;
> diff --git a/hw/i386/port92.c b/hw/i386/port92.c
> new file mode 100644
> index 0000000000..19866c44ef
> --- /dev/null
> +++ b/hw/i386/port92.c
> @@ -0,0 +1,126 @@
> +/*
> + * QEMU I/O port 0x92 (System Control Port A, to handle Fast Gate A20)
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/runstate.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/i386/pc.h"
> +#include "trace.h"
> +
> +#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
> +
> +typedef struct Port92State {
> +    ISADevice parent_obj;
> +
> +    MemoryRegion io;
> +    uint8_t outport;
> +    qemu_irq a20_out;
> +} Port92State;
> +
> +static void port92_write(void *opaque, hwaddr addr, uint64_t val,
> +                         unsigned size)
> +{
> +    Port92State *s =3D opaque;
> +    int oldval =3D s->outport;
> +
> +    trace_port92_write(val);
> +    s->outport =3D val;
> +    qemu_set_irq(s->a20_out, (val >> 1) & 1);
> +    if ((val & 1) && !(oldval & 1)) {
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    }
> +}
> +
> +static uint64_t port92_read(void *opaque, hwaddr addr,
> +                            unsigned size)
> +{
> +    Port92State *s =3D opaque;
> +    uint32_t ret;
> +
> +    ret =3D s->outport;
> +    trace_port92_read(ret);
> +
> +    return ret;
> +}
> +
> +static const VMStateDescription vmstate_port92_isa =3D {
> +    .name =3D "port92",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(outport, Port92State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void port92_reset(DeviceState *d)
> +{
> +    Port92State *s =3D PORT92(d);
> +
> +    s->outport &=3D ~1;
> +}
> +
> +static const MemoryRegionOps port92_ops =3D {
> +    .read =3D port92_read,
> +    .write =3D port92_write,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void port92_initfn(Object *obj)
> +{
> +    Port92State *s =3D PORT92(obj);
> +
> +    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1=
);
> +
> +    s->outport =3D 0;
> +
> +    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, =
1);
> +}
> +
> +static void port92_realizefn(DeviceState *dev, Error **errp)
> +{
> +    ISADevice *isadev =3D ISA_DEVICE(dev);
> +    Port92State *s =3D PORT92(dev);
> +
> +    isa_register_ioport(isadev, &s->io, 0x92);
> +}
> +
> +static void port92_class_initfn(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D port92_realizefn;
> +    dc->reset =3D port92_reset;
> +    dc->vmsd =3D &vmstate_port92_isa;
> +    /*
> +     * Reason: unlike ordinary ISA devices, this one needs additional
> +     * wiring: its A20 output line needs to be wired up with
> +     * qdev_connect_gpio_out_named().
> +     */
> +    dc->user_creatable =3D false;
> +}
> +
> +static const TypeInfo port92_info =3D {
> +    .name          =3D TYPE_PORT92,
> +    .parent        =3D TYPE_ISA_DEVICE,
> +    .instance_size =3D sizeof(Port92State),
> +    .instance_init =3D port92_initfn,
> +    .class_init    =3D port92_class_initfn,
> +};
> +
> +static void port92_register_types(void)
> +{
> +    type_register_static(&port92_info);
> +}
> +
> +type_init(port92_register_types)
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 0d195b5210..b317e7eee0 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -12,6 +12,7 @@ obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
>  obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
>  obj-$(CONFIG_VMPORT) +=3D vmport.o
>  obj-$(CONFIG_VMMOUSE) +=3D vmmouse.o
> +obj-$(CONFIG_PC) +=3D port92.o
> =20
>  obj-y +=3D kvmvapic.o
>  obj-y +=3D acpi-build.o
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 43f33cf7e2..076ea5dcfb 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -115,5 +115,7 @@ vmport_command(unsigned char command) "command: 0x%02=
x"
>  # pc.c
>  pc_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
>  pc_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
> +
> +# port92.c
>  port92_read(uint8_t val) "port92: read 0x%02x"
>  port92_write(uint8_t val) "port92: write 0x%02x"
>=20

Queued, thanks.

Paolo



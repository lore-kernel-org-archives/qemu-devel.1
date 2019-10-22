Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A297CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0199620700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+P2i4Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0199620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMr42-0001ZJ-VO
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMqwe-00024T-4E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMqwc-0007Tk-AD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:59:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMqwc-0007TS-6M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OylO2xDo9tcksk3g8E89ozyoYIqMZPsBAkU0JJicmKM=;
 b=c+P2i4JfzlRHGcuca1SwrMcr9A0m5ByMz6RaVo7j9W0phqWFZ1P40ktskiVpjSnS24tlrP
 IG5W3The3SuRYcm5MtLdr5+JvEZHjS4K0SVffw6zpQNkPWrjNkn5oGtRt4vfip58ZZaTc0
 Wv6xxRPA8DZYKdN1YmZm+dEHSxf8yPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-e-hfXRB6MzOz5QBro1x8Vw-1; Tue, 22 Oct 2019 05:59:12 -0400
Received: by mail-wm1-f70.google.com with SMTP id z24so5951838wmk.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=md/cV/r98QcJyvDimPIaWMOEHqTCRRJfv1N7umvnMVM=;
 b=AkdFH6cGy3Fu2Ca+ms/eknOnp5bsLpbOHWawbkcjdgYaLyQndgBfjgQeHy/dgXy+Pn
 FVT85D8XzU7jeQwIWX1mAr4HoH7PMsv9erc/qzvHXRFS3LnVvqEbnqc/zOv5pRqytRFq
 w5dQq04r7jrHIC1E9Edu2qDDAmNWZTCsgbHYL4dYRzsMkM/iMqVtNnHB4gotRXdWMhyS
 gxHg0xNPSovxp1QkXwrg/36RIGUh0lGuyfW0qpVbL5XxCL5U60Teo00E3lhzHTFhmYwM
 oGFqcc1HbuQlL87GQRBejy957TB3uEHzzckKQUMXzU3Sia4iYKoQrleIUBnOyCY5lFHG
 X1Jw==
X-Gm-Message-State: APjAAAXjFe2JnM0thqtXkM9CFQtE+nHhb3Ig1BiePVGls3tfsjT+O9+c
 g2oR6bnyNd1gU2AL9+A56DGdmxYOMTqEY6LgtD7iNVBJ2lgdDw1pHgx530REfun7icK7ClTfRx7
 eG70Iq285jI6QqMQ=
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr2264946wmu.69.1571738350582; 
 Tue, 22 Oct 2019 02:59:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxd82nyuV9FD5Lxq41ov/IpLys8w0EerjgnjUXjTjbXsKyp6VaxDpcUTFlmAMNM4FdFZg529w==
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr2264914wmu.69.1571738350175; 
 Tue, 22 Oct 2019 02:59:10 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p5sm17380944wmi.4.2019.10.22.02.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 02:59:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] hw/hppa/dino.c: Improve emulation of Dino PCI chip
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191022055415.18122-1-svens@stackframe.org>
 <20191022055415.18122-2-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d94da067-d9d3-4192-f1ed-e5db47cc3806@redhat.com>
Date: Tue, 22 Oct 2019 11:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022055415.18122-2-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: e-hfXRB6MzOz5QBro1x8Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 7:54 AM, Sven Schnelle wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> The tests of the dino chip with the Online-diagnostics CD
> ("ODE DINOTEST") now succeeds.
> Additionally add some qemu trace events.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   MAINTAINERS          |  2 +-
>   hw/hppa/dino.c       | 94 ++++++++++++++++++++++++++++++++++++++------
>   hw/hppa/trace-events |  5 +++
>   3 files changed, 88 insertions(+), 13 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 250ce8e7a1..f9541c3305 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -874,7 +874,7 @@ F: hw/*/etraxfs_*.c
>  =20
>   HP-PARISC Machines
>   ------------------
> -Dino
> +HP B160L
>   M: Richard Henderson <rth@twiddle.net>
>   R: Helge Deller <deller@gmx.de>
>   S: Odd Fixes
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index ab6969b45f..ec5a71a831 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -1,7 +1,7 @@
>   /*
> - * HP-PARISC Dino PCI chipset emulation.
> + * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machin=
es
>    *
> - * (C) 2017 by Helge Deller <deller@gmx.de>
> + * (C) 2017-2019 by Helge Deller <deller@gmx.de>
>    *
>    * This work is licensed under the GNU GPL license version 2 or later.
>    *
> @@ -21,6 +21,7 @@
>   #include "migration/vmstate.h"
>   #include "hppa_sys.h"
>   #include "exec/address-spaces.h"
> +#include "trace.h"
>  =20
>  =20
>   #define TYPE_DINO_PCI_HOST_BRIDGE "dino-pcihost"
> @@ -82,11 +83,28 @@
>   #define DINO_PCI_HOST_BRIDGE(obj) \
>       OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
>  =20
> +#define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
> +static const uint32_t reg800_keep_bits[DINO800_REGS] =3D {
> +            MAKE_64BIT_MASK(0, 1),
> +            MAKE_64BIT_MASK(0, 7),
> +            MAKE_64BIT_MASK(0, 7),
> +            MAKE_64BIT_MASK(0, 8),
> +            MAKE_64BIT_MASK(0, 7),
> +            MAKE_64BIT_MASK(0, 9),
> +            MAKE_64BIT_MASK(0, 32),
> +            MAKE_64BIT_MASK(0, 8),
> +            MAKE_64BIT_MASK(0, 30),
> +            MAKE_64BIT_MASK(0, 25),
> +            MAKE_64BIT_MASK(0, 22),
> +            MAKE_64BIT_MASK(0, 9),
> +};
> +
>   typedef struct DinoState {
>       PCIHostState parent_obj;
>  =20
>       /* PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_o=
ps,
>          so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.  */
> +    uint32_t config_reg_dino; /* keep original copy, including 2 lowest =
bits */
>  =20
>       uint32_t iar0;
>       uint32_t iar1;
> @@ -94,8 +112,12 @@ typedef struct DinoState {
>       uint32_t ipr;
>       uint32_t icr;
>       uint32_t ilr;
> +    uint32_t io_fbb_en;
>       uint32_t io_addr_en;
>       uint32_t io_control;
> +    uint32_t toc_addr;
> +
> +    uint32_t reg800[DINO800_REGS];
>  =20
>       MemoryRegion this_mem;
>       MemoryRegion pci_mem;
> @@ -106,8 +128,6 @@ typedef struct DinoState {
>       MemoryRegion bm_ram_alias;
>       MemoryRegion bm_pci_alias;
>       MemoryRegion bm_cpu_alias;
> -
> -    MemoryRegion cpu0_eir_mem;
>   } DinoState;
>  =20
>   /*
> @@ -122,6 +142,8 @@ static void gsc_to_pci_forwarding(DinoState *s)
>       tmp =3D extract32(s->io_control, 7, 2);
>       enabled =3D (tmp =3D=3D 0x01);
>       io_addr_en =3D s->io_addr_en;
> +    /* Mask out first (=3Dfirmware) and last (=3DDino) areas. */
> +    io_addr_en &=3D 0x7ffffffe;

Or
        io_addr_en &=3D ~((1 << 31) | (1 << 0));

>  =20
>       memory_region_transaction_begin();
>       for (i =3D 1; i < 31; i++) {
> @@ -142,6 +164,8 @@ static bool dino_chip_mem_valid(void *opaque, hwaddr =
addr,
>                                   unsigned size, bool is_write,
>                                   MemTxAttrs attrs)
>   {
> +    bool ret =3D false;
> +
>       switch (addr) {
>       case DINO_IAR0:
>       case DINO_IAR1:
> @@ -152,16 +176,22 @@ static bool dino_chip_mem_valid(void *opaque, hwadd=
r addr,
>       case DINO_ICR:
>       case DINO_ILR:
>       case DINO_IO_CONTROL:
> +    case DINO_IO_FBB_EN:
>       case DINO_IO_ADDR_EN:
>       case DINO_PCI_IO_DATA:
> -        return true;
> +    case DINO_TOC_ADDR:
> +    case DINO_GMASK ... DINO_TLTIM:
> +        ret =3D true;
> +        break;
>       case DINO_PCI_IO_DATA + 2:
> -        return size <=3D 2;
> +        ret =3D (size <=3D 2);
> +        break;
>       case DINO_PCI_IO_DATA + 1:
>       case DINO_PCI_IO_DATA + 3:
> -        return size =3D=3D 1;
> +        ret =3D (size =3D=3D 1);
>       }
> -    return false;
> +    trace_dino_chip_mem_valid(addr, ret);
> +    return ret;
>   }
>  =20
>   static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr addr,
> @@ -194,6 +224,9 @@ static MemTxResult dino_chip_read_with_attrs(void *op=
aque, hwaddr addr,
>           }
>           break;
>  =20
> +    case DINO_IO_FBB_EN:
> +        val =3D s->io_fbb_en;
> +        break;
>       case DINO_IO_ADDR_EN:
>           val =3D s->io_addr_en;
>           break;
> @@ -227,12 +260,28 @@ static MemTxResult dino_chip_read_with_attrs(void *=
opaque, hwaddr addr,
>       case DINO_IRR1:
>           val =3D s->ilr & s->imr & s->icr;
>           break;
> +    case DINO_TOC_ADDR:
> +        val =3D s->toc_addr;
> +        break;
> +    case DINO_GMASK ... DINO_TLTIM:
> +        val =3D s->reg800[(addr - DINO_GMASK) / 4];
> +        if (addr =3D=3D DINO_PAMR) {
> +            val &=3D ~0x01;  /* LSB is hardwired to 0 */
> +        }
> +        if (addr =3D=3D DINO_MLTIM) {
> +            val &=3D ~0x07;  /* 3 LSB are hardwired to 0 */
> +        }
> +        if (addr =3D=3D DINO_BRDG_FEAT) {
> +            val &=3D ~(0x10710E0ul | 8); /* bits 5-7, 24 & 15 reserved *=
/
> +        }
> +        break;
>  =20
>       default:
>           /* Controlled by dino_chip_mem_valid above.  */
>           g_assert_not_reached();
>       }
>  =20
> +    trace_dino_chip_read(addr, val);
>       *data =3D val;
>       return ret;
>   }
> @@ -245,6 +294,9 @@ static MemTxResult dino_chip_write_with_attrs(void *o=
paque, hwaddr addr,
>       AddressSpace *io;
>       MemTxResult ret;
>       uint16_t ioaddr;
> +    int i;
> +
> +    trace_dino_chip_write(addr, val);
>  =20
>       switch (addr) {
>       case DINO_IO_DATA ... DINO_PCI_IO_DATA + 3:
> @@ -266,9 +318,11 @@ static MemTxResult dino_chip_write_with_attrs(void *=
opaque, hwaddr addr,
>           }
>           return ret;
>  =20
> +    case DINO_IO_FBB_EN:
> +        s->io_fbb_en =3D val & 0x03;
> +        break;
>       case DINO_IO_ADDR_EN:
> -        /* Never allow first (=3Dfirmware) and last (=3DDino) areas.  */
> -        s->io_addr_en =3D val & 0x7ffffffe;
> +        s->io_addr_en =3D val;
>           gsc_to_pci_forwarding(s);
>           break;
>       case DINO_IO_CONTROL:
> @@ -292,6 +346,10 @@ static MemTxResult dino_chip_write_with_attrs(void *=
opaque, hwaddr addr,
>           /* Any write to IPR clears the register.  */
>           s->ipr =3D 0;
>           break;
> +    case DINO_TOC_ADDR:
> +        /* IO_COMMAND of CPU with client_id bits */
> +        s->toc_addr =3D 0xFFFA0030 | (val & 0x1e000);
> +        break;
>  =20
>       case DINO_ILR:
>       case DINO_IRR0:
> @@ -299,6 +357,12 @@ static MemTxResult dino_chip_write_with_attrs(void *=
opaque, hwaddr addr,
>           /* These registers are read-only.  */
>           break;
>  =20
> +    case DINO_GMASK ... DINO_TLTIM:
> +        i =3D (addr - DINO_GMASK) / 4;
> +        val &=3D reg800_keep_bits[i];
> +        s->reg800[i] =3D val;
> +        break;
> +
>       default:
>           /* Controlled by dino_chip_mem_valid above.  */
>           g_assert_not_reached();
> @@ -332,8 +396,10 @@ static const VMStateDescription vmstate_dino =3D {

You changed the migration state, shouldn't you update its version?

            .version_id =3D 2,

Except this question,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           VMSTATE_UINT32(ipr, DinoState),
>           VMSTATE_UINT32(icr, DinoState),
>           VMSTATE_UINT32(ilr, DinoState),
> +        VMSTATE_UINT32(io_fbb_en, DinoState),
>           VMSTATE_UINT32(io_addr_en, DinoState),
>           VMSTATE_UINT32(io_control, DinoState),
> +        VMSTATE_UINT32(toc_addr, DinoState),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -362,14 +428,16 @@ static const MemoryRegionOps dino_config_data_ops =
=3D {
>  =20
>   static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsign=
ed len)
>   {
> -    PCIHostState *s =3D opaque;
> -    return s->config_reg;
> +    DinoState *s =3D opaque;
> +    return s->config_reg_dino;
>   }
>  =20
>   static void dino_config_addr_write(void *opaque, hwaddr addr,
>                                      uint64_t val, unsigned len)
>   {
>       PCIHostState *s =3D opaque;
> +    DinoState *ds =3D opaque;
> +    ds->config_reg_dino =3D val; /* keep a copy of original value */
>       s->config_reg =3D val & ~3U;
>   }
>  =20
> @@ -453,6 +521,8 @@ PCIBus *dino_init(MemoryRegion *addr_space,
>  =20
>       dev =3D qdev_create(NULL, TYPE_DINO_PCI_HOST_BRIDGE);
>       s =3D DINO_PCI_HOST_BRIDGE(dev);
> +    s->iar0 =3D s->iar1 =3D CPU_HPA + 3;
> +    s->toc_addr =3D 0xFFFA0030; /* IO_COMMAND of CPU */
>  =20
>       /* Dino PCI access from main memory.  */
>       memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
> diff --git a/hw/hppa/trace-events b/hw/hppa/trace-events
> index 4e2acb6176..f943b16c4e 100644
> --- a/hw/hppa/trace-events
> +++ b/hw/hppa/trace-events
> @@ -2,3 +2,8 @@
>  =20
>   # pci.c
>   hppa_pci_iack_write(void) ""
> +
> +# dino.c
> +dino_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRI=
x64" is %d"
> +dino_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x=
"
> +dino_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08=
x"
>=20



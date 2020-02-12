Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC0C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6748620578
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diihXf2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6748620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j21aI-0005Fd-LJ
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 18:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j21Zc-0004bb-8Z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j21ZZ-0000Qq-Gu
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:37:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j21ZZ-0000Q1-98
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581550656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIAQ1AfisPMRyb8JwmhxPAy98MuZpyHPYBfP6sRQh1c=;
 b=diihXf2lM+shWJ40DuTKtp343llPm3kJnINy2/GxJxuO3ft3OHeSZllZikZS435mvBX818
 I1qHBcgGXDC2wQysLQ53evwuvI+uhSFRS/ZXqELL4kRrW5qNK5PDeOyPdxUE0oi1/meJ+P
 IpqVe7d/jK3o+qIhLWXloraUV1NUgSA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-k6dAeK6ZO7O3One-1-noPw-1; Wed, 12 Feb 2020 18:37:33 -0500
Received: by mail-wr1-f72.google.com with SMTP id l1so1529447wrt.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 15:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hthi+Ip7RUIFXh01gClCVKnDN/IYqRJ7IaIaPPfOPWY=;
 b=G0Bkwd8j1CdFTjTG/xDtffjvJef3qud3OOFR6MsIWirBTmXv6V9qsL0RbeLmQswGc3
 jVhgenI35Foh9Z/Ji25NLEIAkjQjQTiwnOA7qxd8oI0SCEfR0BAPQDxlwQbOo39/kiLl
 cilwbbmjyTrNh7Wry4dHkbQg6cS93z9pn+yyGocLTrRbTMaz+bsl/Wrq18yOGcE8eMeg
 bYikKIw/KHDo1NIAiUr8AM/dqDCbPjycf40kCYeOLNngRK7qBHCZGF9EAzzK6G4KLugd
 0pcmrOxsj5PZ/Rnvgm4TLrJzqI38dgBi1eWKsPMkyD48E6S6dtErqs9RZnaEg4xmePr5
 waKQ==
X-Gm-Message-State: APjAAAWqwNc7UKoPlio8epE+iWdGB1sgT1+sVXlLgyQm/4HQ9Rs3N47C
 ZinPYI8osY2RmtJ2D340sxnkW1cPEgBVxQtoRvh69nbt9GMd46WmOvk7Q/7ce9FSSQBSFIwXlvS
 btOER0/KpaPTzCoA=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr17449117wrn.245.1581550651404; 
 Wed, 12 Feb 2020 15:37:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkMoxrMKB5ic3k5W9vgxRebfSPxHmrrK6v8y6PQ75vqEjo82hFkTffZZQR60CUAhC6j+NYRQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr17449078wrn.245.1581550650898; 
 Wed, 12 Feb 2020 15:37:30 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v22sm471034wml.11.2020.02.12.15.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 15:37:30 -0800 (PST)
Subject: Re: [PATCH v5 1/6] hw/hppa/dino.c: Improve emulation of Dino PCI chip
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-2-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <779e7a6e-00e1-1f51-7132-1cd389bbd921@redhat.com>
Date: Thu, 13 Feb 2020 00:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191220211512.3289-2-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: k6dAeK6ZO7O3One-1-noPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Hi Sven, Helge.

On 12/20/19 10:15 PM, Sven Schnelle wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> The tests of the dino chip with the Online-diagnostics CD
> ("ODE DINOTEST") now succeeds.
> Additionally add some qemu trace events.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   MAINTAINERS          |  2 +-
>   hw/hppa/dino.c       | 97 +++++++++++++++++++++++++++++++++++++-------
>   hw/hppa/trace-events |  5 +++
>   3 files changed, 89 insertions(+), 15 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 387879aebc..e333bc67a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,7 +876,7 @@ F: hw/*/etraxfs_*.c
>  =20
>   HP-PARISC Machines
>   ------------------
> -Dino
> +HP B160L
>   M: Richard Henderson <rth@twiddle.net>
>   R: Helge Deller <deller@gmx.de>
>   S: Odd Fixes
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index ab6969b45f..9797a7f0d9 100644
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

Coverity noticed (CID 1419394) this should be '(1 + (DINO_TLTIM -=20
DINO_GMASK) / 4)' (13 registers).

> +static const uint32_t reg800_keep_bits[DINO800_REGS] =3D {
> +            MAKE_64BIT_MASK(0, 1),
> +            MAKE_64BIT_MASK(0, 7),
> +            MAKE_64BIT_MASK(0, 7),
> +            MAKE_64BIT_MASK(0, 8),
> +            MAKE_64BIT_MASK(0, 7),
> +            MAKE_64BIT_MASK(0, 9),
> +            MAKE_64BIT_MASK(0, 32),

Looking at the datasheet pp. 30, this register is 'Undefined'.
We should report GUEST_ERROR if it is accessed.

> +            MAKE_64BIT_MASK(0, 8),
> +            MAKE_64BIT_MASK(0, 30),
> +            MAKE_64BIT_MASK(0, 25),

Still looking at the datasheet (pp. 37) PCIROR is 24-bit (not 25).

> +            MAKE_64BIT_MASK(0, 22),

Here you are missing register 0x82c...

> +            MAKE_64BIT_MASK(0, 9),
> +};
> +

Altogether:

static const uint32_t reg800_keep_bits[DINO800_REGS] =3D {
     MAKE_64BIT_MASK(0, 1),  /* GMASK */
     MAKE_64BIT_MASK(0, 7),  /* PAMR */
     MAKE_64BIT_MASK(0, 7),  /* PAPR */
     MAKE_64BIT_MASK(0, 8),  /* DAMODE */
     MAKE_64BIT_MASK(0, 7),  /* PCICMD */
     MAKE_64BIT_MASK(0, 9),  /* PCISTS */
     MAKE_64BIT_MASK(0, 0),  /* Undefined */
     MAKE_64BIT_MASK(0, 8),  /* MLTIM */
     MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
     MAKE_64BIT_MASK(0, 24), /* PCIROR */
     MAKE_64BIT_MASK(0, 22), /* PCIWOR */
     MAKE_64BIT_MASK(0, 0),  /* Undocumented */
     MAKE_64BIT_MASK(0, 9),  /* TLTIM */
};

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
> +    io_addr_en &=3D ~(BIT(31) | BIT(0));
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

Due to the missing register, Coverity reports:

 >>>     CID 1419394:  Memory - illegal accesses  (OVERRUN)
 >>>     Overrunning array "reg800_keep_bits" of 12 4-byte elements at=20
element index 12 (byte offset 48) using index "i" (which evaluates to 12).

> +        s->reg800[i] =3D val;
> +        break; > +
>       default:
>           /* Controlled by dino_chip_mem_valid above.  */
>           g_assert_not_reached();
> @@ -323,7 +387,7 @@ static const MemoryRegionOps dino_chip_ops =3D {
>  =20
>   static const VMStateDescription vmstate_dino =3D {
>       .name =3D "Dino",
> -    .version_id =3D 1,
> +    .version_id =3D 2,
>       .minimum_version_id =3D 1,
>       .fields =3D (VMStateField[]) {
>           VMSTATE_UINT32(iar0, DinoState),
> @@ -332,13 +396,14 @@ static const VMStateDescription vmstate_dino =3D {
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
>  =20
> -
>   /* Unlike pci_config_data_le_ops, no check of high bit set in config_re=
g.  */
>  =20
>   static uint64_t dino_config_data_read(void *opaque, hwaddr addr, unsign=
ed len)
> @@ -362,14 +427,16 @@ static const MemoryRegionOps dino_config_data_ops =
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
> @@ -453,6 +520,8 @@ PCIBus *dino_init(MemoryRegion *addr_space,
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



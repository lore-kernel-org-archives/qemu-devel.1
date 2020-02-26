Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D6C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410CA24680
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOA777dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410CA24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xZY-0004b9-Gl
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6xYu-00043Y-Ok
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6xYq-0005cH-M5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:21:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6xYq-0005ZG-Hp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582726875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSHbGqgS3B/wr2StKJrKN9dNOj5Ox0ESJKQAivfGhes=;
 b=gOA777dc9tQfr5qMiqPA7N7tgnAfbvwQrsjwspTGkPgWwhAR87NxPXoJmp9IP0Y+kf6YDq
 yRl0Xppez+RrMjQuyquEgS0ZLTPOYuSbuYKj8EguXvtn6MTnnWDOx88lfLTpaMT3s/X52z
 3knynBn5Oq299kVLcFw+fAwG4NtOhiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-KfbwHwNsOYyfeHfn4zsPdg-1; Wed, 26 Feb 2020 09:21:13 -0500
X-MC-Unique: KfbwHwNsOYyfeHfn4zsPdg-1
Received: by mail-wm1-f69.google.com with SMTP id f9so640130wmb.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 06:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CBenu/1p0A399odB+r0l5DGS3G3AmJFUTUr0sxpL1B4=;
 b=V++Gfp8pGa5O5EHbJIF9AjLjouth/CNj2pfkcSeJiQKvUaW5zCavkz6YUqOVMwTE/I
 K2L9cF8t8/47dymaSq3m2adSHqmFMOso0B7ZSOb/Ph1Es8smhBuKIVlzWG2KXVEE62+u
 Xeu8MmCnRXqsdJT0MkXPfuZ6iT0Gm8/4koa2d1WuaaGkzGy4SRh/EyjyclwFClT0sh5D
 OBkVKeYxJzFWFooefsyufiUuVF9MHzTXVRV865QtldZ2n/DSu/9B767S6Rv9a7fZ5Qud
 WvMFR79n5dE1iaJZEnI3PxQ7JRkqgbNa6bER10s/6c6+w+pEVtIM4PwDs4bsFPDPgEQS
 TlqQ==
X-Gm-Message-State: APjAAAU5wJboulru3z5JIKAjFtHCVjFE5vtHc3aY4RW0W5S74VMs6k05
 j9O5WG/AR5f2Wi6TfX9sITgOXBEjbRnrJIbUAhp1nnnGimT3AcVpSv3V081sq/OpJU+MfSLC7+Y
 fRfri2UCr1ofBz5s=
X-Received: by 2002:adf:e742:: with SMTP id c2mr5775614wrn.262.1582726872641; 
 Wed, 26 Feb 2020 06:21:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJdFOZmI2Gsp4dGKfHGdPHM8nBJmmpzuLLZoPVs6a5/CSQbcL/CGbRn3eZDXpiL3vPxTW4ZQ==
X-Received: by 2002:adf:e742:: with SMTP id c2mr5775577wrn.262.1582726872222; 
 Wed, 26 Feb 2020 06:21:12 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h10sm3163365wml.18.2020.02.26.06.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 06:21:11 -0800 (PST)
Subject: Re: [PATCH 1/2] aspeed/smc: Add some tracing
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200206112645.21275-1-clg@kaod.org>
 <20200206112645.21275-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee72256b-8635-41e3-daa5-17ea1b5db9cd@redhat.com>
Date: Wed, 26 Feb 2020 15:21:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206112645.21275-2-clg@kaod.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Andrew Geissler <geissonator@gmail.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 12:26 PM, C=C3=A9dric Le Goater wrote:
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   Makefile.objs       |  1 +
>   hw/ssi/aspeed_smc.c | 17 +++++++++++++++++
>   hw/ssi/trace-events |  9 +++++++++
>   3 files changed, 27 insertions(+)
>   create mode 100644 hw/ssi/trace-events
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index 26b9cff95436..9e4ba95794e9 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -168,6 +168,7 @@ trace-events-subdirs +=3D hw/scsi
>   trace-events-subdirs +=3D hw/sd
>   trace-events-subdirs +=3D hw/sparc
>   trace-events-subdirs +=3D hw/sparc64
> +trace-events-subdirs +=3D hw/ssi
>   trace-events-subdirs +=3D hw/timer
>   trace-events-subdirs +=3D hw/tpm
>   trace-events-subdirs +=3D hw/usb
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 23c8d2f06245..e5621bf728ca 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -31,6 +31,7 @@
>   #include "qapi/error.h"
>   #include "exec/address-spaces.h"
>   #include "qemu/units.h"
> +#include "trace.h"
>  =20
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> @@ -513,6 +514,8 @@ static void aspeed_smc_flash_set_segment(AspeedSMCSta=
te *s, int cs,
>  =20
>       s->ctrl->reg_to_segment(s, new, &seg);
>  =20
> +    trace_aspeed_smc_flash_set_segment(cs, new, seg.addr, seg.addr + seg=
.size);
> +
>       /* The start address of CS0 is read-only */
>       if (cs =3D=3D 0 && seg.addr !=3D s->ctrl->flash_window_base) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> @@ -753,6 +756,8 @@ static uint64_t aspeed_smc_flash_read(void *opaque, h=
waddr addr, unsigned size)
>                         __func__, aspeed_smc_flash_mode(fl));
>       }
>  =20
> +    trace_aspeed_smc_flash_read(fl->id, addr, size, ret,
> +                                aspeed_smc_flash_mode(fl));
>       return ret;
>   }
>  =20
> @@ -808,6 +813,9 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  =
uint64_t data,
>       AspeedSMCState *s =3D fl->controller;
>       uint8_t addr_width =3D aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
>  =20
> +    trace_aspeed_smc_do_snoop(fl->id, s->snoop_index, s->snoop_dummies,
> +                              (uint8_t) data & 0xff);
> +
>       if (s->snoop_index =3D=3D SNOOP_OFF) {
>           return false; /* Do nothing */
>  =20
> @@ -858,6 +866,9 @@ static void aspeed_smc_flash_write(void *opaque, hwad=
dr addr, uint64_t data,
>       AspeedSMCState *s =3D fl->controller;
>       int i;
>  =20
> +    trace_aspeed_smc_flash_write(fl->id, addr, size, data,
> +                                 aspeed_smc_flash_mode(fl));
> +
>       if (!aspeed_smc_is_writable(fl)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: flash is not writable at 0x=
%"
>                         HWADDR_PRIx "\n", __func__, addr);
> @@ -972,6 +983,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
>           (s->ctrl->has_dma && addr =3D=3D R_DMA_CHECKSUM) ||
>           (addr >=3D R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_sla=
ves) ||
>           (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slave=
s)) {
> +
> +        trace_aspeed_smc_read(addr, size, s->regs[addr]);
> +
>           return s->regs[addr];
>       } else {
>           qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx=
 "\n",
> @@ -1091,6 +1105,7 @@ static void aspeed_smc_dma_checksum(AspeedSMCState =
*s)
>                             __func__, s->regs[R_DMA_FLASH_ADDR]);
>               return;
>           }
> +        trace_aspeed_smc_dma_checksum(s->regs[R_DMA_FLASH_ADDR], data);
>  =20
>           /*
>            * When the DMA is on-going, the DMA registers are updated
> @@ -1225,6 +1240,8 @@ static void aspeed_smc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
>  =20
>       addr >>=3D 2;
>  =20
> +    trace_aspeed_smc_write(addr, size, data);
> +
>       if (addr =3D=3D s->r_conf ||
>           (addr >=3D s->r_timings &&
>            addr < s->r_timings + s->ctrl->nregs_timings) ||
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> new file mode 100644
> index 000000000000..ffe531a500aa
> --- /dev/null
> +++ b/hw/ssi/trace-events
> @@ -0,0 +1,9 @@
> +# aspeed_smc.c
> +
> +aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint6=
4_t end) "CS%d segreg=3D0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
> +aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t da=
ta, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
> +aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d inde=
x:0x%x dummies:%d data:0x%x"
> +aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t d=
ata, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
> +aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRI=
x64 " size %u: 0x%" PRIx64
> +aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
> +aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PR=
Ix64 " size %u: 0x%" PRIx64
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



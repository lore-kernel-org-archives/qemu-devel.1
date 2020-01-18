Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C64C33CB6
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 09:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37762468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 09:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KerHwAdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37762468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isk8Q-0007QO-T7
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 04:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isk7G-0006kH-Mn
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isk7F-0004ez-Av
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:10:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isk7F-0004eP-7m
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579338600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxwM+ygsbmPLVuVMHFiKlUPZjvSHJyaiMS81XNiGRdo=;
 b=KerHwAdSFgOoCYJFi5vxlFOybc6HeyQUxHM72B9R1rBbHpy6HbrAOPPZfHNUsddqxIouC4
 T3QEQARLnjb/Xcnos56jBx+GiJ+BeSqIZAl2mZu6XYwa1bKqGpxE+o+ifO8zFdWSIYXaly
 NX98YCnk8iGGrwWEGdYYSe/x0RVWnRw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-1cgWZQMcN2Caz53cyAa-9A-1; Sat, 18 Jan 2020 04:09:57 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so11477658wrt.21
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 01:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YR/ze6cbF7opX5cNd+rfmrTw6/hZTLCkg5OIhEZRAvw=;
 b=ZOp+U+76XlAYOfAgdFSI3wNDi/9wGvSOCHffohxhD8X/fk24VPflxD7yeVeFAtv1nC
 79c/IXu7948Y0H9jC5z09QbXatMEH+sGhNfHWc28317yEQZIKqMH62WC23xX9nqEiUe4
 kARrigDq4Ic5fdSiUoGGfpT0sQQFxKR/ra7ZEE1GMNHfQvV6M/qcpGky/LWrfiZcI1/R
 Q2VzkW1krNYy0MGS3lELfUVX0w+mT4iegzES8h7SebzD3JKI/Os8Gy/GzLpqqXb5CAVs
 w094sIW7RQxrZHQTxNVELz2NUCd6LJrbatf5LWIjiFPU+8+3Wa+j7tg1AMF8v4+6BrkM
 vcrQ==
X-Gm-Message-State: APjAAAUPKw0QPKRZmU4RgFQFgZXyHcdmNqNT68EVbYTFX0PO/xb7NB79
 SV+KmkTdwdSyjIiCVJPskUQmEez5NfgjIfXYVpN7ZEljxu+C7ZWF/hAbOfIRiohWJL367uveDnb
 uFpAoyjiqkncn1/s=
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr7916653wrx.39.1579338595634; 
 Sat, 18 Jan 2020 01:09:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYbbOS6xyoYeWAWRfux6HnH6JU7pMA1sY6fnDDBX7wEaXmDpBSSTgaxWmWMq6rNfRWfPFkHQ==
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr7916634wrx.39.1579338595346; 
 Sat, 18 Jan 2020 01:09:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r5sm37145399wrt.43.2020.01.18.01.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 01:09:54 -0800 (PST)
Subject: Re: [PATCH v3 10/17] hw/arm/allwinner-h3: add Boot ROM support
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-11-nieklinnenbank@gmail.com>
 <9c878f16-b18c-cc1a-9e82-40dbdd31b823@redhat.com>
 <CAPan3WpNxGRfixQp5CwCwTU_boCq4h-BdJgD=KJEhRrGt7S7wg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <316c94b7-fea2-f44e-6d31-10fb41b09be3@redhat.com>
Date: Sat, 18 Jan 2020 10:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WpNxGRfixQp5CwCwTU_boCq4h-BdJgD=KJEhRrGt7S7wg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 1cgWZQMcN2Caz53cyAa-9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 12:10 AM, Niek Linnenbank wrote:
> On Tue, Jan 14, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 1/8/20 9:00 PM, Niek Linnenbank wrote:
>      > A real Allwinner H3 SoC contains a Boot ROM which is the
>      > first code that runs right after the SoC is powered on.
>      > The Boot ROM is responsible for loading user code (e.g. a bootload=
er)
>      > from any of the supported external devices and writing the downloa=
ded
>      > code to internal SRAM. After loading the SoC begins executing the
>     code
>      > written to SRAM. This commits adds emulation of the Boot ROM firmw=
are
>      > setup functionality by loading user code from SD card.
>      >
>      > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>
>      > ---
>      >=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++=
++++
>      >=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 28 ++++++++++++++++++++++++++++
>      >=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 3 +++
>      >=C2=A0 =C2=A03 files changed, 54 insertions(+)
>      >
>      > diff --git a/include/hw/arm/allwinner-h3.h
>     b/include/hw/arm/allwinner-h3.h
>      > index 5d74cca28e..4b66227ac4 100644
>      > --- a/include/hw/arm/allwinner-h3.h
>      > +++ b/include/hw/arm/allwinner-h3.h
>      > @@ -50,6 +50,7 @@
>      >=C2=A0 =C2=A0#include "hw/sd/allwinner-sdhost.h"
>      >=C2=A0 =C2=A0#include "hw/net/allwinner-sun8i-emac.h"
>      >=C2=A0 =C2=A0#include "target/arm/cpu.h"
>      > +#include "sysemu/block-backend.h"
>      >
>      >=C2=A0 =C2=A0/**
>      >=C2=A0 =C2=A0 * Allwinner H3 device list
>      > @@ -130,4 +131,26 @@ typedef struct AwH3State {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_c;
>      >=C2=A0 =C2=A0} AwH3State;
>      >
>      > +/**
>      > + * Emulate Boot ROM firmware setup functionality.
>      > + *
>      > + * A real Allwinner H3 SoC contains a Boot ROM
>      > + * which is the first code that runs right after
>      > + * the SoC is powered on. The Boot ROM is responsible
>      > + * for loading user code (e.g. a bootloader) from any
>      > + * of the supported external devices and writing the
>      > + * downloaded code to internal SRAM. After loading the SoC
>      > + * begins executing the code written to SRAM.
>      > + *
>      > + * This function emulates the Boot ROM by copying 32 KiB
>      > + * of data from the given block device and writes it to
>      > + * the start of the first internal SRAM memory.
>      > + *
>      > + * @s: Allwinner H3 state object pointer
>      > + * @blk: Block backend device object pointer
>      > + * @errp: Error object pointer for raising errors
>      > + */
>      > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk,
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);
>      > +
>      >=C2=A0 =C2=A0#endif /* HW_ARM_ALLWINNER_H3_H */
>      > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>      > index e692432b4e..e7b768ad5b 100644
>      > --- a/hw/arm/allwinner-h3.c
>      > +++ b/hw/arm/allwinner-h3.c
>      > @@ -27,6 +27,7 @@
>      >=C2=A0 =C2=A0#include "hw/char/serial.h"
>      >=C2=A0 =C2=A0#include "hw/misc/unimp.h"
>      >=C2=A0 =C2=A0#include "hw/usb/hcd-ehci.h"
>      > +#include "hw/loader.h"
>      >=C2=A0 =C2=A0#include "sysemu/sysemu.h"
>      >=C2=A0 =C2=A0#include "hw/arm/allwinner-h3.h"
>      >
>      > @@ -168,6 +169,33 @@ enum {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0AW_H3_GIC_NUM_SPI=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 128
>      >=C2=A0 =C2=A0};
>      >
>      > +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk,
>     Error **errp)
>      > +{
>      > +=C2=A0 =C2=A0 uint8_t *buffer;
>      > +=C2=A0 =C2=A0 int64_t rom_size =3D 32 * KiB;
>=20
>     Why restrict to 32K? The A1 SRAM is 64K.
>=20
>=20
> The reason is that the actual Boot ROM on the H3 also uses 32K:
> https://linux-sunxi.org/BROM
>=20
> See the 'U-Boot SPL Limitations' table at the end of the page.
>=20
> You can see the comment in the table there regarding the 32 KiB:
>  =C2=A0 "Sizes larger than 32 KiB are rejected by the BROM. Exactly 32 Ki=
B is=20
> fine, as verified by writing a special pattern at the end of the SPL and=
=20
> checking it in the SRAM."
> Probably it would not harm to increase it to the full size of the SRAM,=
=20
> but I tried to model
> the behavior as close to the real hardware as possible.

OK, then please document this difference in the commit description -=20
such "While the A1 SRAM is 64K, we limit to 32K because ..." - and add a=20
reference to https://linux-sunxi.org/BROM#U-Boot_SPL_limitations



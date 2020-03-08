Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD1C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3050206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DN6HkEhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3050206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAy4i-0002Nd-UB
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAy47-0001xG-TS
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAy45-0008P3-9R
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:42:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAy45-0008Nm-6B
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583682124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwaBmVtJNVoWngiTb8mhBg6k96OaYekMQGJyQSPpywU=;
 b=DN6HkEhwqc0CteHhf5Z5bp3kxeo2ZkXJ++ZuOjJOhSwEU5qIb0taBPhJmLRxT7sOmAextQ
 CsTEVOttezMtVahWwCWx7IRrHn7iFq+cQQ+7LbuqSoQ/ZamDtxXZ0Qx8vvRfKKz13JPQh0
 uqrn5nBQI8H+g4ejKg09g0G7p25SdQY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-oqXTILq1MMeQyAEhenBWbg-1; Sun, 08 Mar 2020 11:41:48 -0400
X-MC-Unique: oqXTILq1MMeQyAEhenBWbg-1
Received: by mail-ed1-f69.google.com with SMTP id y35so6032412ede.4
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 08:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KEBP4j9klGmtgc1DEvuwpVMRbx/bK11kknAWNJ8e9ck=;
 b=ML8qcVobAwsKo4mhCaieBs/7+dQL+b6fgbmdF9F6TvCIZ1FcfOno1d6EeItsl3zKzX
 oCfo3V2KYiZoFfhCoL8fcpaopNI4HzIUsi0NAGSDpqKERDYNbyDnSPxhgpAVx31Rkjl1
 jF2++DawqzSGpVjq7Hokz31KAwnpYlvC3sb2U/lBa8dccGFKVbEmtOPqYTY/no8xUxnr
 /vonpm+amYHRcTUGxPpYQ2vGj8mMtyaQjkJlNmfXmEADOzz2p8l+yb862PjCqU7mPe26
 2DBIZr4aAQ4ujuVw3etcI46HdKQYOGw8NwX5edmqU6PTy+ctIcLpLGVNesIBns5b81Wd
 VDog==
X-Gm-Message-State: ANhLgQ0VrgeatuCfgbTTPUR8SwuoZlieXTeWzEZopZrFDHvKJ+30V2db
 kR68vZeyAFkwRiQFyd+4Wz7HaIzAT1tdJmbCIlYqVxMSHOPRNRfUQMkhRlrTfgVn5YsCQgVUsF7
 8xKxHpuk11CiBjOk=
X-Received: by 2002:aa7:d9d9:: with SMTP id v25mr12794518eds.291.1583682107625; 
 Sun, 08 Mar 2020 08:41:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbHEZexN3X5dkoe4RSplWIN+HeZF4uHHBwUH/FVK33vbhKh3LkAljNe+E99Svn2wgm1JuhuA==
X-Received: by 2002:aa7:d9d9:: with SMTP id v25mr12794508eds.291.1583682107316; 
 Sun, 08 Mar 2020 08:41:47 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f4sm2273962edr.39.2020.03.08.08.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2020 08:41:46 -0700 (PDT)
Subject: Re: [PATCH v32 16/22] hw/char: RX62N serial communication interface
 (SCI)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200224141923.82118-1-ysato@users.sourceforge.jp>
 <20200224141923.82118-17-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a20c7bc-6d32-7384-c8a6-7ff8c852e08b@redhat.com>
Date: Sun, 8 Mar 2020 16:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224141923.82118-17-ysato@users.sourceforge.jp>
Content-Language: en-US
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 2/24/20 3:19 PM, Yoshinori Sato wrote:
> This module supported only non FIFO type.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190607091116.49044-8-ysato@users.sourceforge.jp>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/char/renesas_sci.h |  45 +++++
>   hw/char/renesas_sci.c         | 342 ++++++++++++++++++++++++++++++++++
>   hw/char/Kconfig               |   3 +
>   hw/char/Makefile.objs         |   1 +
>   4 files changed, 391 insertions(+)
>   create mode 100644 include/hw/char/renesas_sci.h
>   create mode 100644 hw/char/renesas_sci.c
>=20
> diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.=
h
> new file mode 100644
> index 0000000000..50d1336944
> --- /dev/null
> +++ b/include/hw/char/renesas_sci.h
> @@ -0,0 +1,45 @@
> +/*
> + * Renesas Serial Communication Interface
> + *
> + * Copyright (c) 2018 Yoshinori Sato
> + *
> + * This code is licensed under the GPL version 2 or later.
> + *
> + */
> +
> +#include "chardev/char-fe.h"
> +#include "qemu/timer.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_RENESAS_SCI "renesas-sci"
> +#define RSCI(obj) OBJECT_CHECK(RSCIState, (obj), TYPE_RENESAS_SCI)
> +
> +enum {
> +    ERI =3D 0,
> +    RXI =3D 1,
> +    TXI =3D 2,
> +    TEI =3D 3,
> +    SCI_NR_IRQ =3D 4,
> +};
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion memory;
> +
> +    uint8_t smr;
> +    uint8_t brr;
> +    uint8_t scr;
> +    uint8_t tdr;
> +    uint8_t ssr;
> +    uint8_t rdr;
> +    uint8_t scmr;
> +    uint8_t semr;
> +
> +    uint8_t read_ssr;
> +    int64_t trtime;
> +    int64_t rx_next;
> +    QEMUTimer *timer;
> +    CharBackend chr;
> +    uint64_t input_freq;
> +    qemu_irq irq[SCI_NR_IRQ];
> +} RSCIState;
> diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
> new file mode 100644
> index 0000000000..0760a51f43
> --- /dev/null
> +++ b/hw/char/renesas_sci.c
> @@ -0,0 +1,342 @@
> +/*
> + * Renesas Serial Communication Interface

Looking at this again, have you looked at the SH model=20
(hw/char/sh_serial.c)? This seems the same.
(Similarly your timer model with hw/timer/sh_timer.c).

> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "hw/hw.h"
> +#include "hw/irq.h"
> +#include "hw/sysbus.h"
> +#include "hw/registerfields.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/char/renesas_sci.h"
> +#include "migration/vmstate.h"
> +#include "qemu/error-report.h"
> +
> +/* SCI register map */
> +REG8(SMR, 0)
> +  FIELD(SMR, CKS,  0, 2)
> +  FIELD(SMR, MP,   2, 1)
> +  FIELD(SMR, STOP, 3, 1)
> +  FIELD(SMR, PM,   4, 1)
> +  FIELD(SMR, PE,   5, 1)
> +  FIELD(SMR, CHR,  6, 1)
> +  FIELD(SMR, CM,   7, 1)
> +REG8(BRR, 1)
> +REG8(SCR, 2)
> +  FIELD(SCR, CKE, 0, 2)
> +  FIELD(SCR, TEIE, 2, 1)
> +  FIELD(SCR, MPIE, 3, 1)
> +  FIELD(SCR, RE,   4, 1)
> +  FIELD(SCR, TE,   5, 1)
> +  FIELD(SCR, RIE,  6, 1)
> +  FIELD(SCR, TIE,  7, 1)
> +REG8(TDR, 3)
> +REG8(SSR, 4)
> +  FIELD(SSR, MPBT, 0, 1)
> +  FIELD(SSR, MPB,  1, 1)
> +  FIELD(SSR, TEND, 2, 1)
> +  FIELD(SSR, ERR, 3, 3)
> +    FIELD(SSR, PER,  3, 1)
> +    FIELD(SSR, FER,  4, 1)
> +    FIELD(SSR, ORER, 5, 1)
> +  FIELD(SSR, RDRF, 6, 1)
> +  FIELD(SSR, TDRE, 7, 1)
> +REG8(RDR, 5)
> +REG8(SCMR, 6)
> +  FIELD(SCMR, SMIF, 0, 1)
> +  FIELD(SCMR, SINV, 2, 1)
> +  FIELD(SCMR, SDIR, 3, 1)
> +  FIELD(SCMR, BCP2, 7, 1)
> +REG8(SEMR, 7)
> +  FIELD(SEMR, ACS0, 0, 1)
> +  FIELD(SEMR, ABCS, 4, 1)
> +
> +static int can_receive(void *opaque)
> +{
> +    RSCIState *sci =3D RSCI(opaque);
> +    if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
> +        return 0;
> +    } else {
> +        return FIELD_EX8(sci->scr, SCR, RE);
> +    }
> +}
> +
> +static void receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    RSCIState *sci =3D RSCI(opaque);
> +    sci->rx_next =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime=
;
> +    if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, ORER, 1);
> +        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> +            qemu_set_irq(sci->irq[ERI], 1);
> +        }
> +    } else {
> +        sci->rdr =3D buf[0];
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, RDRF, 1);
> +        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> +            qemu_irq_pulse(sci->irq[RXI]);
> +        }
> +    }
> +}
[...]



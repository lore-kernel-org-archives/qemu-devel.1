Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EBD20659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnVsSuFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EBD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkuK-0003yT-8Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFktY-0003WC-2C
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:11:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFktU-0004fn-Vf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:11:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so440335wme.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i5XT4XUVsZ0PCoTXaggGusVfF6PC60jDyBke3gainC8=;
 b=MnVsSuFY40xFk12Se+r/HGPGuvIqakscbPfmI1H8vvDYaN88ZIrFBMLg7iDjhbTYyE
 Kb+JWCiXYX+aJ4x8oPbjQ99XR5GyQoYSqOKWuu+P+tG1s6UIqnjhbnRkkMd3TywoAVtC
 Uqf9pCSfz/DA/X+ahAht3sERqcUq3aXSQt9CvhDTVb0fbk2c2+sfE0yJiBiqygPo0EnZ
 J2dfwddcCD4qjkDXD1/+PLt7CYQrwBZh1t/TM80uAUDxKnziruyu3kGqejiDeSouTYPa
 qpLQN3HRKC088oy/L+O6+ZpTnw7STTvq7+Dfeh/k4jPhuL+OxOWEul5iuzMXVPnZtGw1
 Imww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=i5XT4XUVsZ0PCoTXaggGusVfF6PC60jDyBke3gainC8=;
 b=HmxyQF8WMv37cbdmbA8/1qjYFgl9JcMQy0tTXm3hUX/DTdpt6wRpsfC/ijOeLNzF8b
 FYRGLNwTEZv6+qlRczb4TZ3NSZOdGmFPHsjmB62z5+oDrfndv23xBXYYjmMrH4QEPDUG
 51dBgCwDcOkpUdHpZL+r77l5C8MmJ11zFawK4fFQwMZW4+XrknovNPKB19CG8YFYL48k
 g+KTS8//Gf30VruutnH2Cr0ff4RDSjPmeGosRKQPeQQ696f+Uviz4eJ5pdvoWD6HKluY
 DGswnwZqeevGghqNh8sEYP1GwH3DIHOtArRsKsUIFp5M2gQ8vmgxfvLhfHqhdVeH1Koe
 6vlw==
X-Gm-Message-State: AOAM5322tQIYn1rrIam+hXYQxqMDx5HFLRqc5163+6lnZxU/rWIMN6tz
 oy/zLoX7VhDv4WhknKv9IVfw27aVM58=
X-Google-Smtp-Source: ABdhPJyFfkOftPhFx97wIJppIr6rnusxzZrDffqKr+FEboVrHV3AU6kNva+MxL+8KjGvQd0yA+iBCg==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr349593wmi.28.1599599470107;
 Tue, 08 Sep 2020 14:11:10 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a11sm765963wmm.18.2020.09.08.14.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 14:11:09 -0700 (PDT)
Subject: Re: [PATCH 05/20] hw/rx: Add RX62N Clock generator
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-6-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <15c1a609-3857-e15e-fa9b-13a75840b542@amsat.org>
Date: Tue, 8 Sep 2020 23:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-6-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> This module generated core and peripheral clock.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx62n-cpg.h |  72 ++++++++
>  include/hw/rx/rx62n.h     |   5 +-
>  hw/rx/rx62n-cpg.c         | 344 ++++++++++++++++++++++++++++++++++++++
>  hw/rx/rx62n.c             |  52 +++---
>  hw/rx/meson.build         |   2 +-
>  5 files changed, 447 insertions(+), 28 deletions(-)
>  create mode 100644 include/hw/rx/rx62n-cpg.h
>  create mode 100644 hw/rx/rx62n-cpg.c
> 
> diff --git a/include/hw/rx/rx62n-cpg.h b/include/hw/rx/rx62n-cpg.h
> new file mode 100644
> index 0000000000..d90a067313
> --- /dev/null
> +++ b/include/hw/rx/rx62n-cpg.h
> @@ -0,0 +1,72 @@
> +/*
> + * RX62N Clock generator circuit
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2020 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RX_RX62N_CPG_H
> +#define HW_RX_RX62N_CPG_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/qdev-clock.h"
> +
> +#define TYPE_RX62N_CPG "rx62n-cpg"
> +#define RX62NCPG(obj) OBJECT_CHECK(RX62NCPGState, (obj), TYPE_RX62N_CPG)
> +
> +enum {
> +    CK_TMR8_1,
> +    CK_TMR8_0,
> +    CK_MTU_1,
> +    CK_MTU_0,
> +    CK_CMT_1,
> +    CK_CMT_0,
> +    CK_EDMAC,
> +    CK_SCI6,
> +    CK_SCI5,
> +    CK_SCI3,
> +    CK_SCI2,
> +    CK_SCI1,
> +    CK_SCI0,
> +    NUM_SUBCLOCK,
> +};
> +
> +typedef struct RX62NCPGState {
> +    SysBusDevice parent_obj;
> +    uint32_t mstpcr[3];
> +    uint32_t sckcr;
> +    uint8_t  bckcr;
> +    uint8_t  ostdcr;
> +
> +    int ick;
> +    Clock *clk_ick;
> +    int bck;
> +    Clock *clk_bck;
> +    int pck;
> +    Clock *clk_pck;
> +    Clock *dev_clocks[NUM_SUBCLOCK];
> +    uint32_t xtal_freq_hz;
> +    MemoryRegion memory;
> +} RX62NCPGState;
> +
> +typedef struct RX62NCPGClass {
> +    SysBusDeviceClass parent;
> +} RX62NCPGClass;
> +
> +#define OSTDCR_KEY 0xac

Please move the key to rx62n-cpg.c.

> +
> +#endif
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> index 32e460bbad..e0ca1cfc33 100644
> --- a/include/hw/rx/rx62n.h
> +++ b/include/hw/rx/rx62n.h
> @@ -29,6 +29,7 @@
>  #include "hw/timer/renesas_tmr.h"
>  #include "hw/timer/renesas_cmt.h"
>  #include "hw/char/renesas_sci.h"
> +#include "hw/rx/rx62n-cpg.h"
>  #include "qemu/units.h"
>  
>  #define TYPE_RX62N_MCU "rx62n-mcu"
> @@ -70,9 +71,9 @@ typedef struct RX62NState {
>      RTMRState tmr[RX62N_NR_TMR];
>      RCMTState cmt[RX62N_NR_CMT];
>      RSCIState sci[RX62N_NR_SCI];
> +    RX62NCPGState cpg;
>  
>      MemoryRegion *sysmem;
> -    bool kernel;
>  
>      MemoryRegion iram;
>      MemoryRegion iomem1;
> @@ -84,8 +85,6 @@ typedef struct RX62NState {
>  
>      /* Input Clock (XTAL) frequency */
>      uint32_t xtal_freq_hz;
> -    /* Peripheral Module Clock frequency */
> -    uint32_t pclk_freq_hz;
>  } RX62NState;
>  
>  #endif
> diff --git a/hw/rx/rx62n-cpg.c b/hw/rx/rx62n-cpg.c
> new file mode 100644
> index 0000000000..9d70004302
> --- /dev/null
> +++ b/hw/rx/rx62n-cpg.c
> @@ -0,0 +1,344 @@
> +/*
> + * RX62N Clock Generation Circuit
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2020 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/hw.h"
> +#include "hw/rx/rx62n-cpg.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/registerfields.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/clock.h"
> +#include "migration/vmstate.h"
> +
> +#define RX62N_XTAL_MIN_HZ  (8 * 1000 * 1000)
> +#define RX62N_XTAL_MAX_HZ (14 * 1000 * 1000)
> +
> +REG32(MSTPCRA, 0)
> +REG32(MSTPCRB, 4)
> +REG32(MSTPCRC, 8)
> +REG32(SCKCR, 16)
> +  FIELD(SCKCR, PCK,  8, 3)
> +  FIELD(SCKCR, BCK, 16, 3)
> +  FIELD(SCKCR, PSTOP, 22, 2)
> +  FIELD(SCKCR, ICK, 24, 3)
> +REG8(BCKCR, 32)
> +  FIELD(BCKCR, BCLKDIV, 0, 1)
> +REG16(OSTDCR, 48)
> +  FIELD(OSTDCR, OSTDF, 6, 1)
> +  FIELD(OSTDCR, OSTDE, 7, 1)
> +
> +static const int access_size[] = {4, 4, 1, 2};
> +
> +typedef struct {
> +    const char *name;
> +    int devnum;
> +    int reg;
> +    int offset;
> +    int parentck;
> +} dev_clock_t;
> +
> +enum {
> +    parent_ick, parent_bck, parent_pck,
> +};
> +
> +static const dev_clock_t dev_clock_list[] = {
> +    { .name = "pck_tmr8-1",
> +      .devnum = CK_TMR8_1, .reg = 0, .offset = 4, .parentck = parent_pck, },
> +    { .name = "pck_tmr8-0",
> +      .devnum = CK_TMR8_0, .reg = 0, .offset = 5, .parentck = parent_pck, },
> +    { .name = "pck_mtu-1",
> +      .devnum = CK_MTU_1, .reg = 0, .offset = 8, .parentck = parent_pck, },
> +    { .name = "pck_mtu-0",
> +      .devnum = CK_MTU_0, .reg = 0, .offset = 9, .parentck = parent_pck, },
> +    { .name = "pck_cmt-1",
> +      .devnum = CK_CMT_1, .reg = 0, .offset = 14, .parentck = parent_pck, },
> +    { .name = "pck_cmt-0",
> +      .devnum = CK_CMT_0, .reg = 0, .offset = 15, .parentck = parent_pck, },
> +    { .name = "ick_edmac",
> +      .devnum = CK_EDMAC, .reg = 1, .offset = 15, .parentck = parent_ick, },
> +    { .name = "pck_sci-6",
> +      .devnum = CK_SCI6, .reg = 1, .offset = 25, .parentck = parent_pck, },
> +    { .name = "pck_sci-5",
> +      .devnum = CK_SCI5, .reg = 1, .offset = 26, .parentck = parent_pck, },
> +    { .name = "pck_sci-3",
> +      .devnum = CK_SCI3, .reg = 1, .offset = 28, .parentck = parent_pck, },
> +    { .name = "pck_sci-2",
> +      .devnum = CK_SCI2, .reg = 1, .offset = 29, .parentck = parent_pck, },
> +    { .name = "pck_sci-1",
> +      .devnum = CK_SCI1, .reg = 1, .offset = 30, .parentck = parent_pck, },
> +    { .name = "pck_sci-0",
> +      .devnum = CK_SCI0, .reg = 1, .offset = 31, .parentck = parent_pck, },
> +    { },
> +};

Could simplify to remove offset field, and index by offset:

static const dev_clock_t dev_clock_list[32] = {
 [ 4] = { .name = "pck_tmr8-1", .devnum = CK_TMR8_1,
          .reg = 0, .offset = 4, .parentck = parent_pck, },
 ...

 [31] = { .name = "pck_sci-0", .devnum = CK_SCI0,
          .reg = 1, .parentck = parent_pck, }
};

And replace the while (p->name) by
for (... ARRAY_SIZE(dev_clock_list) ...).

> +
> +static void set_clock_in(RX62NCPGState *cpg, const dev_clock_t *ck)
> +{
> +    Clock *out;
> +    uint64_t period;
> +
> +    out = qdev_get_clock_out(DEVICE(cpg), ck->name);
> +    g_assert(out);
> +    period = 0;
> +    if (extract32(cpg->mstpcr[ck->reg], ck->offset, 1) == 0) {
> +        switch (ck->parentck) {
> +        case parent_ick:
> +            period = clock_get(cpg->clk_ick);
> +            break;
> +        case parent_pck:
> +            period = clock_get(cpg->clk_pck);
> +            break;
> +        }
> +    }
> +    if (clock_get(out) != period) {
> +        clock_update(out, period);
> +    }
> +}
> +
> +#define update_ck(ckname)                                             \
> +    if (cpg->ckname != ckname) {                                      \
> +        cpg->ckname = ckname;                                         \
> +        ckname =  8 / (1 << ckname);                                  \
> +        clock_update_hz(cpg->clk_ ## ckname,                          \
> +                        cpg->xtal_freq_hz * ckname);                  \
> +    }
> +
> +#define validate_setting(ckname)                                 \
> +    if (ick > ckname) {                                         \
> +        qemu_log_mask(LOG_GUEST_ERROR,                           \
> +                      "rx62n-cpg: Invalid " #ckname " setting."   \
> +                      " (ick=%d " #ckname "=%d)\n", ick, ckname); \
> +        cpg->ckname = ckname = ick;                              \
> +    }

Can you replace by a update_ck(clk, const char *name) function?
(validate_setting too).

> +
> +static void update_divrate(RX62NCPGState *cpg)
> +{
> +    int ick = FIELD_EX32(cpg->sckcr, SCKCR, ICK);
> +    int bck = FIELD_EX32(cpg->sckcr, SCKCR, BCK);
> +    int pck = FIELD_EX32(cpg->sckcr, SCKCR, PCK);
> +    const dev_clock_t *p = dev_clock_list;
> +    validate_setting(pck);
> +    validate_setting(bck);
> +    update_ck(ick);
> +    update_ck(bck);
> +    update_ck(pck);
> +    while (p->name) {
> +        set_clock_in(cpg, p);
> +        p++;
> +    }
> +}
> +
> +static const dev_clock_t *find_clock_list(int crno, int bit)
> +{
> +    const dev_clock_t *ret = dev_clock_list;
> +    while (ret->name) {
> +        if (ret->reg == crno && ret->offset == bit) {
> +            return ret;
> +        }
> +        ret++;
> +    }
> +    return NULL;
> +}
> +
> +static void update_mstpcr(RX62NCPGState *cpg, int crno, uint32_t diff)
> +{
> +    int bit = 0;
> +    const dev_clock_t *p;
> +
> +    while (diff) {
> +        if (diff & 1) {
> +            p = find_clock_list(crno, bit);
> +            if (p) {
> +                set_clock_in(cpg, p);
> +            } else {
> +                qemu_log_mask(LOG_UNIMP, "rx62n-cpg: MSTPCR%c "
> +                              " bit %d is not implement.\n", 'A' + crno, bit);
> +            }
> +        }
> +        bit++;
> +        diff >>= 1;
> +    }
> +}
> +
> +static uint64_t cpg_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RX62NCPGState *cpg = RX62NCPG(opaque);
> +
> +    if (access_size[addr >> 4] != size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "rx62n-cpg: Register 0x%"
> +                      HWADDR_PRIX " Invalid access size.\n", addr);
> +        return UINT64_MAX;
> +    }
> +    switch (addr) {
> +    case A_MSTPCRA:
> +        return cpg->mstpcr[0] | 0x473530cf;
> +    case A_MSTPCRB:
> +        return cpg->mstpcr[1] | 0x09407ffe;
> +    case A_MSTPCRC:
> +        return (cpg->mstpcr[2] | 0xffff0000) & 0xffff0003;
> +    case A_SCKCR:
> +        return cpg->sckcr & 0x0fcf0f00;
> +    case A_BCKCR:
> +        return cpg->bckcr & 0x01;
> +    case A_OSTDCR:
> +        /* Main OSC always good */
> +        return cpg->ostdcr & 0x0080;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "rx62n-cpg: Register 0x%"
> +                      HWADDR_PRIX " Invalid address.\n", addr);
> +        return UINT64_MAX;
> +    }
> +}
> +
> +static void cpg_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    RX62NCPGState *cpg = RX62NCPG(opaque);
> +    uint32_t old_mstpcr;
> +    int cr_no;
> +    if (access_size[addr >> 4] != size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "rx62n-cpg: Register 0x%"
> +                      HWADDR_PRIX " Invalid access size.\n", addr);
> +        return;
> +    }
> +    switch (addr) {
> +    case A_MSTPCRA:
> +    case A_MSTPCRB:
> +    case A_MSTPCRC:
> +        cr_no = (addr & 0x0f) >> 2;
> +        old_mstpcr = cpg->mstpcr[cr_no];
> +        old_mstpcr ^= val;
> +        cpg->mstpcr[cr_no] = val;
> +        update_mstpcr(cpg, cr_no, old_mstpcr);
> +        break;
> +    case A_SCKCR:
> +        cpg->sckcr = val;
> +        update_divrate(cpg);
> +        break;
> +    case A_BCKCR:
> +        cpg->bckcr = val;
> +        break;
> +    case A_OSTDCR:
> +        if (extract16(val, 8, 8) == OSTDCR_KEY) {
> +            cpg->ostdcr = val;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "rx62n-cpg: Register 0x%"
> +                          HWADDR_PRIX " Invalid key value.\n", addr);
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "rx62n-cpg: Register 0x%"
> +                      HWADDR_PRIX " Invalid address.\n", addr);
> +    }
> +}
> +
> +static const MemoryRegionOps cpg_ops = {
> +    .write = cpg_write,
> +    .read  = cpg_read,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static const ClockPortInitArray rx62n_cpg_clocks = {
> +    QDEV_CLOCK_OUT(RX62NCPGState, clk_ick),
> +    QDEV_CLOCK_OUT(RX62NCPGState, clk_bck),
> +    QDEV_CLOCK_OUT(RX62NCPGState, clk_pck),
> +    QDEV_CLOCK_END
> +};
> +
> +static void cpg_realize(DeviceState *dev, Error **errp)
> +{
> +    RX62NCPGState *cpg = RX62NCPG(dev);
> +    const dev_clock_t *p = dev_clock_list;
> +
> +    if (cpg->xtal_freq_hz == 0) {
> +        error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
> +        return;
> +    }
> +    /* XTAL range: 8-14 MHz */
> +    if (cpg->xtal_freq_hz < RX62N_XTAL_MIN_HZ ||
> +        cpg->xtal_freq_hz > RX62N_XTAL_MAX_HZ) {
> +        error_setg(errp, "\"xtal-frequency-hz\" property in incorrect range.");
> +        return;
> +    }
> +
> +    cpg->sckcr = FIELD_DP32(cpg->sckcr, SCKCR, ICK, 2);
> +    cpg->sckcr = FIELD_DP32(cpg->sckcr, SCKCR, BCK, 2);
> +    cpg->sckcr = FIELD_DP32(cpg->sckcr, SCKCR, PCK, 2);
> +    cpg->ostdcr = FIELD_DP8(cpg->ostdcr, OSTDCR, OSTDE, 1);
> +    cpg->mstpcr[0] = 0x47ffffff;
> +    cpg->mstpcr[1] = 0xffffffff;
> +    cpg->mstpcr[2] = 0xffff0000;
> +
> +    /* set initial state */
> +    while (p->name) {
> +        set_clock_in(cpg, p);
> +        p++;
> +    }
> +    update_divrate(cpg);
> +}
> +
> +static void rx62n_cpg_init(Object *obj)
> +{
> +    RX62NCPGState *cpg = RX62NCPG(obj);
> +    const dev_clock_t *p = dev_clock_list;
> +    qdev_init_clocks(DEVICE(obj), rx62n_cpg_clocks);
> +    /* connect parent clock */
> +    while (p->name) {
> +        cpg->dev_clocks[p->devnum] = qdev_init_clock_out(DEVICE(obj),
> +                                                         p->name);
> +        p++;
> +    }
> +
> +    memory_region_init_io(&cpg->memory, OBJECT(cpg), &cpg_ops,
> +                          cpg, "rx62n-cpg", 0x40);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &cpg->memory);
> +}
> +
> +static Property rx62n_cpg_properties[] = {
> +    DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NCPGState, xtal_freq_hz, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rx62n_cpg_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = cpg_realize;
> +    device_class_set_props(dc, rx62n_cpg_properties);
> +}
> +
> +static const TypeInfo rx62n_cpg_info[] = {
> +    {
> +        .name       = TYPE_RX62N_CPG,
> +        .parent     = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(RX62NCPGState),
> +        .instance_init = rx62n_cpg_init,
> +        .class_init = rx62n_cpg_class_init,
> +        .class_size = sizeof(RX62NCPGClass),
> +    },
> +};
> +
> +DEFINE_TYPES(rx62n_cpg_info)
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index 4b5c3c1079..ec63fa5db1 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -47,6 +47,7 @@
>  #define RX62N_TMR_BASE  0x00088200
>  #define RX62N_CMT_BASE  0x00088000
>  #define RX62N_SCI_BASE  0x00088240
> +#define RX62N_CPG_BASE  0x00080010
>  
>  /*
>   * RX62N Peripheral IRQ
> @@ -56,10 +57,6 @@
>  #define RX62N_CMT_IRQ   28
>  #define RX62N_SCI_IRQ   214
>  
> -#define RX62N_XTAL_MIN_HZ  (8 * 1000 * 1000)
> -#define RX62N_XTAL_MAX_HZ (14 * 1000 * 1000)
> -#define RX62N_PCLK_MAX_HZ (50 * 1000 * 1000)
> -
>  /*
>   * IRQ -> IPR mapping table
>   * 0x00 - 0x91: IPR no (IPR00 to IPR91)
> @@ -149,36 +146,45 @@ static void register_tmr(RX62NState *s, int unit)
>  {
>      SysBusDevice *tmr;
>      int i, irqbase;
> +    char ckname[16];
>  
>      object_initialize_child(OBJECT(s), "tmr[*]",
>                              &s->tmr[unit], TYPE_RENESAS_TMR);
>      tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
> -    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
> -    sysbus_realize(tmr, &error_abort);

Please move here:

> +    qdev_prop_set_uint32(DEVICE(tmr), "unit", unit);
> +    snprintf(ckname, sizeof(ckname), "pck_tmr8-%d", unit);
> +    qdev_connect_clock_in(DEVICE(tmr), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
> +    sysbus_realize(tmr, &error_abort);

Note, you need to call sysbus_realize() *after* qdev_connect_clock_in().

>  
>      irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
>      for (i = 0; i < TMR_NR_IRQ; i++) {
>          sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
>      }
>      sysbus_mmio_map(tmr, 0, RX62N_TMR_BASE + unit * 0x10);
> +
> +    qdev_prop_set_uint32(DEVICE(tmr), "unit", unit);
> +    sysbus_realize(tmr, &error_abort);
> +    snprintf(ckname, sizeof(ckname), "pck_tmr8-%d", unit);
> +    qdev_connect_clock_in(DEVICE(tmr), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
>  }
>  
>  static void register_cmt(RX62NState *s, int unit)
>  {
>      SysBusDevice *cmt;
>      int i, irqbase;
> +    char ckname[16];
>  
>      object_initialize_child(OBJECT(s), "cmt[*]",
>                              &s->cmt[unit], TYPE_RENESAS_CMT);
>      cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
> -    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", s->pclk_freq_hz);
> -    sysbus_realize(cmt, &error_abort);
> +    qdev_prop_set_uint32(DEVICE(cmt), "unit", unit);
>  
>      irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
>      for (i = 0; i < CMT_NR_IRQ; i++) {
>          sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
>      }
>      sysbus_mmio_map(cmt, 0, RX62N_CMT_BASE + unit * 0x10);
> +    sysbus_realize(cmt, &error_abort);
> +    snprintf(ckname, sizeof(ckname), "pck_cmt-%d", unit);
> +    qdev_connect_clock_in(DEVICE(cmt), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));

Ditto move.

>  }
>  
>  static void register_sci(RX62NState *s, int unit)
> @@ -190,7 +196,6 @@ static void register_sci(RX62NState *s, int unit)
>                              &s->sci[unit], TYPE_RENESAS_SCI);
>      sci = SYS_BUS_DEVICE(&s->sci[unit]);
>      qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> -    qdev_prop_set_uint64(DEVICE(sci), "input-freq", s->pclk_freq_hz);
>      sysbus_realize(sci, &error_abort);
>  
>      irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
> @@ -200,26 +205,23 @@ static void register_sci(RX62NState *s, int unit)
>      sysbus_mmio_map(sci, 0, RX62N_SCI_BASE + unit * 0x08);
>  }
>  
> +static void register_cpg(RX62NState *s)
> +{
> +    SysBusDevice *cpg;
> +
> +    object_initialize_child(OBJECT(s), "rx62n-cpg", &s->cpg,
> +                            TYPE_RX62N_CPG);
> +    cpg = SYS_BUS_DEVICE(&s->cpg);
> +    qdev_prop_set_uint64(DEVICE(cpg), "xtal-frequency-hz", s->xtal_freq_hz);

Eventually you can alias the property from the CPG on the SOC
using object_property_add_alias(), and remove RX62NState::xtal_freq_hz.

> +
> +    sysbus_mmio_map(cpg, 0, RX62N_CPG_BASE);
> +}
> +
>  static void rx62n_realize(DeviceState *dev, Error **errp)
>  {
>      RX62NState *s = RX62N_MCU(dev);
>      RX62NClass *rxc = RX62N_MCU_GET_CLASS(dev);
>  
> -    if (s->xtal_freq_hz == 0) {
> -        error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
> -        return;
> -    }
> -    /* XTAL range: 8-14 MHz */
> -    if (s->xtal_freq_hz < RX62N_XTAL_MIN_HZ
> -            || s->xtal_freq_hz > RX62N_XTAL_MAX_HZ) {
> -        error_setg(errp, "\"xtal-frequency-hz\" property in incorrect range.");
> -        return;
> -    }
> -    /* Use a 4x fixed multiplier */
> -    s->pclk_freq_hz = 4 * s->xtal_freq_hz;
> -    /* PCLK range: 8-50 MHz */
> -    assert(s->pclk_freq_hz <= RX62N_PCLK_MAX_HZ);
> -
>      memory_region_init_ram(&s->iram, OBJECT(dev), "iram",
>                             rxc->ram_size, &error_abort);
>      memory_region_add_subregion(s->sysmem, RX62N_IRAM_BASE, &s->iram);
> @@ -236,11 +238,13 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
>  
>      register_icu(s);
>      s->cpu.env.ack = qdev_get_gpio_in_named(DEVICE(&s->icu), "ack", 0);
> +    register_cpg(s);
>      register_tmr(s, 0);
>      register_tmr(s, 1);
>      register_cmt(s, 0);
>      register_cmt(s, 1);
>      register_sci(s, 0);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpg), &error_abort);
>  }
>  
>  static Property rx62n_properties[] = {
> diff --git a/hw/rx/meson.build b/hw/rx/meson.build
> index e73850f303..3a81d85a53 100644
> --- a/hw/rx/meson.build
> +++ b/hw/rx/meson.build
> @@ -1,6 +1,6 @@
>  rx_ss = ss.source_set()
>  rx_ss.add(files('loader.c'))
>  rx_ss.add(when: 'CONFIG_RX_GDBSIM', if_true: files('rx-gdbsim.c'))
> -rx_ss.add(when: 'CONFIG_RX62N_MCU', if_true: files('rx62n.c'))
> +rx_ss.add(when: 'CONFIG_RX62N_MCU', if_true: files('rx62n.c', 'rx62n-cpg.c'))
>  
>  hw_arch += {'rx': rx_ss}
> 

Very good patch :)


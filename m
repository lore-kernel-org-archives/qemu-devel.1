Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23268C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEE42076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWIApO5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEE42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU98U-0000fa-Oq
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU960-0005uG-53
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU93y-0003zb-Ob
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:19:19 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU93y-0003zI-8w; Thu, 30 Apr 2020 09:17:14 -0400
Received: by mail-lf1-x142.google.com with SMTP id b20so903784lff.2;
 Thu, 30 Apr 2020 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hN5h8duPqefLRLaviyorxl7OltUZ9z09gEElZDrzR0w=;
 b=ZWIApO5ejiEC5i0hhHZw5BQYfgqAm1GsviUj+qycg3c4QOXVTmSgqx9qi/BAalYfqB
 7K5LAnJif8FOYYAGnRoocxRKUHSnVVxIP+ti/XdMQIM2HhxUuCPoZvCIL0vLPaKVrWiQ
 1NfGkrTUPJO22BVWPHm69cf5l10QAygz9GJ2XpdBU0l+h0KjBtGXhuuslxJLgk42QB4Z
 qHxKi+5k+YhHTN5mhFY7u9kTpyEbES0z7scCATvbsdbgvLXCYNq/swvh1TL8soau7d2B
 tBOSvzGPc8l4VdYBgrmNEJvHEcfc+LINN9363F3zacmXO7BXwroNXZYBt+wmEOfU16mx
 OSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hN5h8duPqefLRLaviyorxl7OltUZ9z09gEElZDrzR0w=;
 b=cx8XuL79KFgznNPyWf0lvbchDWTasMCcL3b4MV7I288ppxECEooYwFyTzFeS6GMjNw
 +2QTD6Wtk4sXIgBzi/naaQL4EE/Sv9A4yENXywXUo1wAKsDyIAm1sq3+jRx3wEnxfJVy
 ippE3Gd20uhD8DgfteACPyvwg81UbOyLwsjoUkWtl5eHP5h0N9i7iShGxFi/gKPyHEsr
 zqmsR++f4becQ4zyWi3c8eGUebxGXGL9TpjG1WgMDxI6B0dM3OD4j4zu8L7Y6t8707nB
 bC+m9AFEeeS/AzIsn+ZI2/UKPa6sE5UEy48sDnyVg66+dzhRCwbcj82Mgq5fQTBAB4Oc
 doGQ==
X-Gm-Message-State: AGi0PuZ5yjSoYQV7+qzSGmzp3Q9jjHgTdS1SyGd4Z4d7uNG3LJ2qDAG1
 HlC1ekSufi0lgaDmmKUJAlc=
X-Google-Smtp-Source: APiQypLQY27Hgg8R9h+JocpT+aBTtPfwV7Obou3x9Aeg0RTPnFY7R+9mWlALQlbVXH/cnK5DSK46JQ==
X-Received: by 2002:a19:e86:: with SMTP id 128mr2135346lfo.169.1588252631789; 
 Thu, 30 Apr 2020 06:17:11 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t13sm4281572ljd.38.2020.04.30.06.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 06:17:10 -0700 (PDT)
Date: Thu, 30 Apr 2020 15:16:38 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Vikram Garhwal <fnuv@xilinx.com>
Subject: Re: [PATCH v3 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN controller
Message-ID: <20200430131638.GO2669@toto>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
 <1587603369-14644-2-git-send-email-fnu.vikram@xilinx.com>
 <20200428162823.GL2669@toto>
 <BYAPR02MB4823827AA2BA91908BDECDF6BCAC0@BYAPR02MB4823.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4823827AA2BA91908BDECDF6BCAC0@BYAPR02MB4823.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::142
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
Cc: "damien.hedde@greensocs.com" <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 05:35:46PM +0000, Vikram Garhwal wrote:
> Hi Edgar,
> Thanks for review.
> 
> > -----Original Message-----
> > From: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> > Sent: Tuesday, April 28, 2020 9:28 AM
> > To: Vikram Garhwal <fnuv@xilinx.com>
> > Cc: qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > Alistair Francis <alistair@alistair23.me>; Peter Maydell
> > <peter.maydell@linaro.org>; open list:Xilinx ZynqMP <qemu-
> > arm@nongnu.org>; damien.hedde@greensocs.com; Francisco Eduardo
> > Iglesias <figlesia@xilinx.com>
> > Subject: Re: [PATCH v3 1/4] hw/net/can: Introduce Xilinx ZynqMP CAN
> > controller
> > 
> > On Wed, Apr 22, 2020 at 05:56:06PM -0700, Vikram Garhwal wrote:
> > > XlnxCAN is developed based on SocketCAN, QEMU CAN bus
> > implementation.
> > > Bus connection and socketCAN connection for each CAN module can be
> > set
> > > through command lines.
> > 
> > + Damien (there's a reset question for you inline) Francisco
> > 
> > Nice Vikram!
> > 
> > I've copied Francisco since he was quite invovled with this too.
> > 
> > Some comments inline.
> > 
> > Cheers,
> > Edgar
> > 
> > >
> > > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > > ---
> > >  hw/net/can/Makefile.objs         |    1 +
> > >  hw/net/can/xlnx-zynqmp-can.c     | 1113
> > ++++++++++++++++++++++++++++++++++++++
> > >  include/hw/net/xlnx-zynqmp-can.h |   76 +++
> > >  3 files changed, 1190 insertions(+)
> > >  create mode 100644 hw/net/can/xlnx-zynqmp-can.c  create mode
> > 100644
> > > include/hw/net/xlnx-zynqmp-can.h
> > >
> > > diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs index
> > > 9f0c4ee..0fe87dd 100644
> > > --- a/hw/net/can/Makefile.objs
> > > +++ b/hw/net/can/Makefile.objs
> > > @@ -2,3 +2,4 @@ common-obj-$(CONFIG_CAN_SJA1000) +=
> > can_sja1000.o
> > >  common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
> > >  common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
> > >  common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
> > > +common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-can.o
> > > diff --git a/hw/net/can/xlnx-zynqmp-can.c
> > > b/hw/net/can/xlnx-zynqmp-can.c new file mode 100644 index
> > > 0000000..31799c0
> > > --- /dev/null
> > > +++ b/hw/net/can/xlnx-zynqmp-can.c
> > > @@ -0,0 +1,1113 @@
> > > +/*
> > > + * QEMU model of the Xilinx CAN device.
> > > + *
> > > + * Copyright (c) 2020 Xilinx Inc.
> > > + *
> > > + * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
> > > + *
> > > + * Based on QEMU CAN Device emulation implemented by Jin Yang,
> > Deniz
> > > +Eren and
> > > + * Pavel Pisa
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person
> > > +obtaining a copy
> > > + * of this software and associated documentation files (the
> > > +"Software"), to deal
> > > + * in the Software without restriction, including without limitation
> > > +the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense,
> > > +and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software
> > > +is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be
> > > +included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> > KIND,
> > > +EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > > +MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> > EVENT
> > > +SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> > DAMAGES
> > > +OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > OTHERWISE,
> > > +ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > OTHER
> > > +DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/sysbus.h"
> > > +#include "hw/register.h"
> > > +#include "hw/irq.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/bitops.h"
> > > +#include "qemu/log.h"
> > > +#include "qemu/cutils.h"
> > > +#include "sysemu/sysemu.h"
> > > +#include "migration/vmstate.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "net/can_emu.h"
> > > +#include "net/can_host.h"
> > > +#include "qemu/event_notifier.h"
> > > +#include "qom/object_interfaces.h"
> > > +#include "hw/net/xlnx-zynqmp-can.h"
> > > +
> > > +#ifndef XLNX_ZYNQMP_CAN_ERR_DEBUG
> > > +#define XLNX_ZYNQMP_CAN_ERR_DEBUG 0
> > > +#endif
> > > +
> > > +#define DB_PRINT(...) do { \
> > > +    if (XLNX_ZYNQMP_CAN_ERR_DEBUG) { \
> > > +        qemu_log(__VA_ARGS__); \
> > > +    } \
> > > +} while (0)
> > > +
> > > +#define MAX_DLC            8
> > > +#undef ERROR
> > > +
> > > +REG32(SOFTWARE_RESET_REGISTER, 0x0)
> > > +    FIELD(SOFTWARE_RESET_REGISTER, CEN, 1, 1)
> > > +    FIELD(SOFTWARE_RESET_REGISTER, SRST, 0, 1)
> > > +REG32(MODE_SELECT_REGISTER, 0x4)
> > > +    FIELD(MODE_SELECT_REGISTER, SNOOP, 2, 1)
> > > +    FIELD(MODE_SELECT_REGISTER, LBACK, 1, 1)
> > > +    FIELD(MODE_SELECT_REGISTER, SLEEP, 0, 1)
> > > +REG32(ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER, 0x8)
> > > +    FIELD(ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER, BRP,
> > 0, 8)
> > > +REG32(ARBITRATION_PHASE_BIT_TIMING_REGISTER, 0xc)
> > > +    FIELD(ARBITRATION_PHASE_BIT_TIMING_REGISTER, SJW, 7, 2)
> > > +    FIELD(ARBITRATION_PHASE_BIT_TIMING_REGISTER, TS2, 4, 3)
> > > +    FIELD(ARBITRATION_PHASE_BIT_TIMING_REGISTER, TS1, 0, 4)
> > > +REG32(ERROR_COUNTER_REGISTER, 0x10)
> > > +    FIELD(ERROR_COUNTER_REGISTER, REC, 8, 8)
> > > +    FIELD(ERROR_COUNTER_REGISTER, TEC, 0, 8)
> > > +REG32(ERROR_STATUS_REGISTER, 0x14)
> > > +    FIELD(ERROR_STATUS_REGISTER, ACKER, 4, 1)
> > > +    FIELD(ERROR_STATUS_REGISTER, BERR, 3, 1)
> > > +    FIELD(ERROR_STATUS_REGISTER, STER, 2, 1)
> > > +    FIELD(ERROR_STATUS_REGISTER, FMER, 1, 1)
> > > +    FIELD(ERROR_STATUS_REGISTER, CRCER, 0, 1)
> > REG32(STATUS_REGISTER,
> > > +0x18)
> > > +    FIELD(STATUS_REGISTER, SNOOP, 12, 1)
> > > +    FIELD(STATUS_REGISTER, ACFBSY, 11, 1)
> > > +    FIELD(STATUS_REGISTER, TXFLL, 10, 1)
> > > +    FIELD(STATUS_REGISTER, TXBFLL, 9, 1)
> > > +    FIELD(STATUS_REGISTER, ESTAT, 7, 2)
> > > +    FIELD(STATUS_REGISTER, ERRWRN, 6, 1)
> > > +    FIELD(STATUS_REGISTER, BBSY, 5, 1)
> > > +    FIELD(STATUS_REGISTER, BIDLE, 4, 1)
> > > +    FIELD(STATUS_REGISTER, NORMAL, 3, 1)
> > > +    FIELD(STATUS_REGISTER, SLEEP, 2, 1)
> > > +    FIELD(STATUS_REGISTER, LBACK, 1, 1)
> > > +    FIELD(STATUS_REGISTER, CONFIG, 0, 1)
> > > +REG32(INTERRUPT_STATUS_REGISTER, 0x1c)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, TXFEMP, 14, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, TXFWMEMP, 13, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, RXFWMFLL, 12, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, WKUP, 11, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, SLP, 10, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, BSOFF, 9, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, ERROR, 8, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, RXNEMP, 7, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, RXOFLW, 6, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, RXUFLW, 5, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, RXOK, 4, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, TXBFLL, 3, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, TXFLL, 2, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, TXOK, 1, 1)
> > > +    FIELD(INTERRUPT_STATUS_REGISTER, ARBLST, 0, 1)
> > > +REG32(INTERRUPT_ENABLE_REGISTER, 0x20)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXFEMP, 14, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXFWMEMP, 13, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXFWMFLL, 12, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, EWKUP, 11, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ESLP, 10, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, EBSOFF, 9, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, EERROR, 8, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXNEMP, 7, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXOFLW, 6, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXUFLW, 5, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXOK, 4, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXBFLL, 3, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXFLL, 2, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXOK, 1, 1)
> > > +    FIELD(INTERRUPT_ENABLE_REGISTER, EARBLST, 0, 1)
> > > +REG32(INTERRUPT_CLEAR_REGISTER, 0x24)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXFEMP, 14, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXFWMEMP, 13, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXFWMFLL, 12, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CWKUP, 11, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CSLP, 10, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CBSOFF, 9, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CERROR, 8, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXNEMP, 7, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXOFLW, 6, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXUFLW, 5, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CRXOK, 4, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXBFLL, 3, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXFLL, 2, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CTXOK, 1, 1)
> > > +    FIELD(INTERRUPT_CLEAR_REGISTER, CARBLST, 0, 1)
> > > +REG32(TIMESTAMP_REGISTER, 0x28)
> > > +    FIELD(TIMESTAMP_REGISTER, CTS, 0, 1) REG32(WIR, 0x2c)
> > > +    FIELD(WIR, EW, 8, 8)
> > > +    FIELD(WIR, FW, 0, 8)
> > > +REG32(TXFIFO_ID, 0x30)
> > > +    FIELD(TXFIFO_ID, IDH, 21, 11)
> > > +    FIELD(TXFIFO_ID, SRRRTR, 20, 1)
> > > +    FIELD(TXFIFO_ID, IDE, 19, 1)
> > > +    FIELD(TXFIFO_ID, IDL, 1, 18)
> > > +    FIELD(TXFIFO_ID, RTR, 0, 1)
> > > +REG32(TXFIFO_DLC, 0x34)
> > > +    FIELD(TXFIFO_DLC, DLC, 28, 4)
> > > +REG32(TXFIFO_DATA1, 0x38)
> > > +    FIELD(TXFIFO_DATA1, DB0, 24, 8)
> > > +    FIELD(TXFIFO_DATA1, DB1, 16, 8)
> > > +    FIELD(TXFIFO_DATA1, DB2, 8, 8)
> > > +    FIELD(TXFIFO_DATA1, DB3, 0, 8)
> > > +REG32(TXFIFO_DATA2, 0x3c)
> > > +    FIELD(TXFIFO_DATA2, DB4, 24, 8)
> > > +    FIELD(TXFIFO_DATA2, DB5, 16, 8)
> > > +    FIELD(TXFIFO_DATA2, DB6, 8, 8)
> > > +    FIELD(TXFIFO_DATA2, DB7, 0, 8)
> > > +REG32(TXHPB_ID, 0x40)
> > > +    FIELD(TXHPB_ID, IDH, 21, 11)
> > > +    FIELD(TXHPB_ID, SRRRTR, 20, 1)
> > > +    FIELD(TXHPB_ID, IDE, 19, 1)
> > > +    FIELD(TXHPB_ID, IDL, 1, 18)
> > > +    FIELD(TXHPB_ID, RTR, 0, 1)
> > > +REG32(TXHPB_DLC, 0x44)
> > > +    FIELD(TXHPB_DLC, DLC, 28, 4)
> > > +REG32(TXHPB_DATA1, 0x48)
> > > +    FIELD(TXHPB_DATA1, DB0, 24, 8)
> > > +    FIELD(TXHPB_DATA1, DB1, 16, 8)
> > > +    FIELD(TXHPB_DATA1, DB2, 8, 8)
> > > +    FIELD(TXHPB_DATA1, DB3, 0, 8)
> > > +REG32(TXHPB_DATA2, 0x4c)
> > > +    FIELD(TXHPB_DATA2, DB4, 24, 8)
> > > +    FIELD(TXHPB_DATA2, DB5, 16, 8)
> > > +    FIELD(TXHPB_DATA2, DB6, 8, 8)
> > > +    FIELD(TXHPB_DATA2, DB7, 0, 8)
> > > +REG32(RXFIFO_ID, 0x50)
> > > +    FIELD(RXFIFO_ID, IDH, 21, 11)
> > > +    FIELD(RXFIFO_ID, SRRRTR, 20, 1)
> > > +    FIELD(RXFIFO_ID, IDE, 19, 1)
> > > +    FIELD(RXFIFO_ID, IDL, 1, 18)
> > > +    FIELD(RXFIFO_ID, RTR, 0, 1)
> > > +REG32(RXFIFO_DLC, 0x54)
> > > +    FIELD(RXFIFO_DLC, DLC, 28, 4)
> > > +    FIELD(RXFIFO_DLC, RXT, 0, 16)
> > > +REG32(RXFIFO_DATA1, 0x58)
> > > +    FIELD(RXFIFO_DATA1, DB0, 24, 8)
> > > +    FIELD(RXFIFO_DATA1, DB1, 16, 8)
> > > +    FIELD(RXFIFO_DATA1, DB2, 8, 8)
> > > +    FIELD(RXFIFO_DATA1, DB3, 0, 8)
> > > +REG32(RXFIFO_DATA2, 0x5c)
> > > +    FIELD(RXFIFO_DATA2, DB4, 24, 8)
> > > +    FIELD(RXFIFO_DATA2, DB5, 16, 8)
> > > +    FIELD(RXFIFO_DATA2, DB6, 8, 8)
> > > +    FIELD(RXFIFO_DATA2, DB7, 0, 8)
> > > +REG32(AFR, 0x60)
> > > +    FIELD(AFR, UAF4, 3, 1)
> > > +    FIELD(AFR, UAF3, 2, 1)
> > > +    FIELD(AFR, UAF2, 1, 1)
> > > +    FIELD(AFR, UAF1, 0, 1)
> > > +REG32(AFMR1, 0x64)
> > > +    FIELD(AFMR1, AMIDH, 21, 11)
> > > +    FIELD(AFMR1, AMSRR, 20, 1)
> > > +    FIELD(AFMR1, AMIDE, 19, 1)
> > > +    FIELD(AFMR1, AMIDL, 1, 18)
> > > +    FIELD(AFMR1, AMRTR, 0, 1)
> > > +REG32(AFIR1, 0x68)
> > > +    FIELD(AFIR1, AIIDH, 21, 11)
> > > +    FIELD(AFIR1, AISRR, 20, 1)
> > > +    FIELD(AFIR1, AIIDE, 19, 1)
> > > +    FIELD(AFIR1, AIIDL, 1, 18)
> > > +    FIELD(AFIR1, AIRTR, 0, 1)
> > > +REG32(AFMR2, 0x6c)
> > > +    FIELD(AFMR2, AMIDH, 21, 11)
> > > +    FIELD(AFMR2, AMSRR, 20, 1)
> > > +    FIELD(AFMR2, AMIDE, 19, 1)
> > > +    FIELD(AFMR2, AMIDL, 1, 18)
> > > +    FIELD(AFMR2, AMRTR, 0, 1)
> > > +REG32(AFIR2, 0x70)
> > > +    FIELD(AFIR2, AIIDH, 21, 11)
> > > +    FIELD(AFIR2, AISRR, 20, 1)
> > > +    FIELD(AFIR2, AIIDE, 19, 1)
> > > +    FIELD(AFIR2, AIIDL, 1, 18)
> > > +    FIELD(AFIR2, AIRTR, 0, 1)
> > > +REG32(AFMR3, 0x74)
> > > +    FIELD(AFMR3, AMIDH, 21, 11)
> > > +    FIELD(AFMR3, AMSRR, 20, 1)
> > > +    FIELD(AFMR3, AMIDE, 19, 1)
> > > +    FIELD(AFMR3, AMIDL, 1, 18)
> > > +    FIELD(AFMR3, AMRTR, 0, 1)
> > > +REG32(AFIR3, 0x78)
> > > +    FIELD(AFIR3, AIIDH, 21, 11)
> > > +    FIELD(AFIR3, AISRR, 20, 1)
> > > +    FIELD(AFIR3, AIIDE, 19, 1)
> > > +    FIELD(AFIR3, AIIDL, 1, 18)
> > > +    FIELD(AFIR3, AIRTR, 0, 1)
> > > +REG32(AFMR4, 0x7c)
> > > +    FIELD(AFMR4, AMIDH, 21, 11)
> > > +    FIELD(AFMR4, AMSRR, 20, 1)
> > > +    FIELD(AFMR4, AMIDE, 19, 1)
> > > +    FIELD(AFMR4, AMIDL, 1, 18)
> > > +    FIELD(AFMR4, AMRTR, 0, 1)
> > > +REG32(AFIR4, 0x80)
> > > +    FIELD(AFIR4, AIIDH, 21, 11)
> > > +    FIELD(AFIR4, AISRR, 20, 1)
> > > +    FIELD(AFIR4, AIIDE, 19, 1)
> > > +    FIELD(AFIR4, AIIDL, 1, 18)
> > > +    FIELD(AFIR4, AIRTR, 0, 1)
> > > +
> > > +static void can_update_irq(XlnxZynqMPCANState *s) {
> > > +    unsigned int irq;
> > > +
> > > +    /* Watermark register interrupts. */
> > > +    if ((fifo32_num_free(&s->tx_fifo) / CAN_FRAME_SIZE) >
> > > +            ARRAY_FIELD_EX32(s->regs, WIR, EW)) {
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > TXFWMEMP, 1);
> > > +    }
> > > +
> > > +    if ((fifo32_num_used(&s->rx_fifo) / CAN_FRAME_SIZE) >
> > > +            ARRAY_FIELD_EX32(s->regs, WIR, FW)) {
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > RXFWMFLL, 1);
> > > +    }
> > > +
> > > +    /* RX Interrupts. */
> > > +    if (fifo32_num_used(&s->rx_fifo) >= CAN_FRAME_SIZE) {
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > RXNEMP, 1);
> > > +    }
> > > +
> > > +    /* TX interrupts. */
> > > +    if (fifo32_is_empty(&s->tx_fifo)) {
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > TXFEMP, 1);
> > > +    }
> > > +
> > > +    if (fifo32_is_full(&s->tx_fifo)) {
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXFLL,
> > 1);
> > > +    }
> > > +
> > > +    if (fifo32_is_full(&s->txhpb_fifo)) {
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXBFLL,
> > 1);
> > > +    }
> > > +
> > > +    irq = s->regs[R_INTERRUPT_STATUS_REGISTER];
> > > +    irq &= s->regs[R_INTERRUPT_ENABLE_REGISTER];
> > 
> > Since you're working with s->regs[], it would be cleaner to make irq the
> > same type as the regs (i.e uint32_t).
> [Vikram Garhwal] I will change the irq data type.
> > 
> > > +
> > > +    qemu_set_irq(s->irq, irq);
> > > +}
> > > +
> > > +static void can_ier_post_write(RegisterInfo *reg, uint64_t val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +
> > > +    can_update_irq(s);
> > > +}
> > > +
> > > +static uint64_t can_icr_pre_write(RegisterInfo *reg, uint64_t val64)
> > > +{
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +
> > > +    s->regs[R_INTERRUPT_STATUS_REGISTER] &= ~val;
> > > +    can_update_irq(s);
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static void can_config_reset(XlnxZynqMPCANState *s) {
> > > +    /* Reset all the configuration registers. */
> > > +    register_reset(&s->reg_info[R_SOFTWARE_RESET_REGISTER]);
> > > +    register_reset(&s->reg_info[R_MODE_SELECT_REGISTER]);
> > > +    register_reset(
> > > +              &s-
> > >reg_info[R_ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER]);
> > > +    register_reset(&s-
> > >reg_info[R_ARBITRATION_PHASE_BIT_TIMING_REGISTER]);
> > > +    register_reset(&s->reg_info[R_STATUS_REGISTER]);
> > > +    register_reset(&s->reg_info[R_INTERRUPT_STATUS_REGISTER]);
> > > +    register_reset(&s->reg_info[R_INTERRUPT_ENABLE_REGISTER]);
> > > +    register_reset(&s->reg_info[R_INTERRUPT_CLEAR_REGISTER]);
> > > +    register_reset(&s->reg_info[R_WIR]);
> > > +}
> > > +
> > > +static void can_config_mode(XlnxZynqMPCANState *s) {
> > > +    register_reset(&s->reg_info[R_ERROR_COUNTER_REGISTER]);
> > > +    register_reset(&s->reg_info[R_ERROR_STATUS_REGISTER]);
> > > +
> > > +    /* Put XlnxZynqMPCANState in configuration mode. */
> > > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, CONFIG, 1);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, WKUP,
> > 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, SLP, 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, BSOFF,
> > 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, ERROR,
> > 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXOFLW,
> > 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXOK, 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXOK, 0);
> > > +    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, ARBLST,
> > 0);
> > > +
> > > +    can_update_irq(s);
> > > +}
> > > +
> > > +static void update_status_register_mode_bits(XlnxZynqMPCANState *s)
> > {
> > > +    /* Wake up interrupt bit. */
> > > +    bool wakeup_irq_val = (ARRAY_FIELD_EX32(s->regs,
> > MODE_SELECT_REGISTER,
> > > +                            SLEEP) == 0) && ARRAY_FIELD_EX32(s->regs,
> > > +                            STATUS_REGISTER, SLEEP);
> > 
> > Looks like you have too many layers of parentheses here?
> > 
> [Vikram Garhwal] I will make this look more cleaner.
> > > +
> > > +    /* Sleep interrupt bit. */
> > > +    bool sleep_irq_val = (ARRAY_FIELD_EX32(s->regs,
> > MODE_SELECT_REGISTER,
> > > +                            SLEEP) && (ARRAY_FIELD_EX32(s->regs,
> > > +                            STATUS_REGISTER, SLEEP) == 0));
> > 
> > Here too.
> > 
> > 
> > > +
> > > +    /* Clear previous core mode status bits. */
> > > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, LBACK, 0);
> > > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SLEEP, 0);
> > > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SNOOP, 0);
> > > +    ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, NORMAL, 0);
> > > +
> > > +    /* set current mode bit and generate irqs accordingly. */
> > > +    if (ARRAY_FIELD_EX32(s->regs, MODE_SELECT_REGISTER, LBACK)) {
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, LBACK, 1);
> > > +    } else if (ARRAY_FIELD_EX32(s->regs, MODE_SELECT_REGISTER, SLEEP))
> > {
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SLEEP, 1);
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, SLP,
> > > +                            sleep_irq_val);
> > > +    } else if (ARRAY_FIELD_EX32(s->regs, MODE_SELECT_REGISTER,
> > SNOOP)) {
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, SNOOP, 1);
> > > +    } else {
> > > +        /*
> > > +         * If all bits are zero then XlnxZynqMPCANState is set in normal
> > mode.
> > > +         */
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, NORMAL, 1);
> > > +        /* Set wakeup interrupt bit. */
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, WKUP,
> > > +                            wakeup_irq_val);
> > > +    }
> > > +
> > > +    can_update_irq(s);
> > > +}
> > > +
> > > +static void can_exit_sleep_mode(XlnxZynqMPCANState *s) {
> > > +    ARRAY_FIELD_DP32(s->regs, MODE_SELECT_REGISTER, SLEEP, 0);
> > > +    update_status_register_mode_bits(s);
> > > +}
> > > +
> > > +static void generate_frame(qemu_can_frame *frame, uint32_t *data) {
> > > +    frame->can_id = data[0];
> > > +    frame->can_dlc = FIELD_EX32(data[1], TXFIFO_DLC, DLC);
> > > +
> > > +    frame->data[0] = FIELD_EX32(data[2], TXFIFO_DATA1, DB3);
> > > +    frame->data[1] = FIELD_EX32(data[2], TXFIFO_DATA1, DB2);
> > > +    frame->data[2] = FIELD_EX32(data[2], TXFIFO_DATA1, DB1);
> > > +    frame->data[3] = FIELD_EX32(data[2], TXFIFO_DATA1, DB0);
> > > +
> > > +    frame->data[4] = FIELD_EX32(data[3], TXFIFO_DATA2, DB7);
> > > +    frame->data[5] = FIELD_EX32(data[3], TXFIFO_DATA2, DB6);
> > > +    frame->data[6] = FIELD_EX32(data[3], TXFIFO_DATA2, DB5);
> > > +    frame->data[7] = FIELD_EX32(data[3], TXFIFO_DATA2, DB4); }
> > > +
> > > +static bool tx_ready_check(XlnxZynqMPCANState *s) {
> > > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, SRST)) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to transfer data
> > while"
> > > +                      " XlnxZynqMPCANState%d is in reset mode\n",
> > > +                      s->cfg.ctrl_idx);
> > > +        return false;
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN) ==
> > 0) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to transfer data
> > while"
> > > +                      " XlnxZynqMPCANState%d is in configuration mode.Reset
> > the"
> > 
> > Missing space after dot "mode.Reset".                                  ^^^
> [Vikram Garhwal] I will add the missing space in v4.
> > 
> > > +                      " core so operations can start fresh\n",
> > > +                      s->cfg.ctrl_idx);
> > > +        return false;
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SNOOP)) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to transfer data
> > while"
> > > +                        " XlnxZynqMPCANState%d is in SNOOP MODE\n",
> > > +                         s->cfg.ctrl_idx);
> > > +        return false;
> > > +    }
> > > +
> > > +    return true;
> > > +}
> > > +
> > > +static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo) {
> > > +    qemu_can_frame frame;
> > > +    uint32_t data[CAN_FRAME_SIZE];
> > > +    int i;
> > > +    bool can_tx = tx_ready_check(s);
> > > +
> > > +    if (can_tx) {
> > > +        while (!fifo32_is_empty(fifo)) {
> > > +            for (i = 0; i < CAN_FRAME_SIZE; i++) {
> > > +                data[i] = fifo32_pop(fifo);
> > > +            }
> > > +
> > > +            if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
> > > +                /*
> > > +                 * Controller is in loopback. In Loopback mode, the CAN core
> > > +                 * transmits a recessive bitstream on to the
> > XlnxZynqMPCANState
> > > +                 * Bus. Any message transmitted is looped back to the RX line
> > > +                 * and acknowledged. The XlnxZynqMPCANState core receives
> > any
> > > +                 * message that it transmits.
> > > +                 */
> > > +                if (fifo32_is_full(&s->rx_fifo)) {
> > > +                    DB_PRINT("Loopback: RX FIFO is full."
> > > +                             "TX FIFO will be flushed.\n");
> > > +
> > > +                    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > > +                                      RXOFLW, 1);
> > > +                } else {
> > > +                    for (i = 0; i < CAN_FRAME_SIZE; i++) {
> > > +                        fifo32_push(&s->rx_fifo, data[i]);
> > > +                    }
> > > +
> > > +                    ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > > +                                      RXOK, 1);
> > > +                }
> > > +            } else {
> > > +                /* Normal mode Tx. */
> > > +                generate_frame(&frame, data);
> > > +
> > > +                can_bus_client_send(&s->bus_client, &frame, 1);
> > > +            }
> > > +        }
> > > +
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXOK,
> > 1);
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, TXBFLL, 0);
> > > +
> > > +        if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, SLEEP)) {
> > > +            can_exit_sleep_mode(s);
> > > +        }
> > > +    } else {
> > > +        DB_PRINT("CAN is not enabled for data transfer.\n");
> > > +    }
> > > +
> > > +    can_update_irq(s);
> > > +}
> > > +
> > > +static uint64_t can_srr_pre_write(RegisterInfo *reg, uint64_t val64)
> > > +{
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +
> > > +    ARRAY_FIELD_DP32(s->regs, SOFTWARE_RESET_REGISTER, CEN,
> > > +                        FIELD_EX32(val, SOFTWARE_RESET_REGISTER,
> > > + CEN));
> > > +
> > > +    if (FIELD_EX32(val, SOFTWARE_RESET_REGISTER, SRST)) {
> > > +        DB_PRINT("Resetting XlnxZynqMPCANState%d\n",
> > > + s->cfg.ctrl_idx);
> > > +
> > > +        /* First, core will do software reset then will enter in config mode.
> > */
> > > +        can_config_reset(s);
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN) ==
> > 0) {
> > > +        can_config_mode(s);
> > > +
> > 
> > I would drop this blank line.
> [Vikram Garhwal] I will remove it in next patch.
> > 
> > 
> > > +    } else {
> > > +        /*
> > > +         * Leave config mode. Now XlnxZynqMPCANState core will enter
> > Normal,
> > > +         * Sleep, snoop or Loopback mode depending upon LBACK, SLEEP,
> > SNOOP
> > > +         * register states.
> > > +         */
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, CONFIG, 0);
> > > +
> > > +        /* XlnxZynqMP CAN is out of config mode. it will send pending data.
> > */
> > > +        transfer_fifo(s, &s->txhpb_fifo);
> > > +        transfer_fifo(s, &s->tx_fifo);
> > > +    }
> > > +
> > > +    update_status_register_mode_bits(s);
> > > +
> > > +    return s->regs[R_SOFTWARE_RESET_REGISTER];
> > > +}
> > > +
> > > +static uint64_t can_msr_pre_write(RegisterInfo *reg, uint64_t val64)
> > > +{
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +    uint8_t multi_mode = 0;
> > > +
> > > +    /*
> > > +     * Multiple mode set check. This is done to make sure user doesn't set
> > > +     * multiple modes.
> > > +     */
> > > +    multi_mode = FIELD_EX32(val, MODE_SELECT_REGISTER, LBACK) +
> > > +                 FIELD_EX32(val, MODE_SELECT_REGISTER, SLEEP) +
> > > +                 FIELD_EX32(val, MODE_SELECT_REGISTER, SNOOP);
> > > +
> > > +    if (multi_mode > 1) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to configure
> > several modes "
> > > +                     "simultaneously. One mode will be selected according to "
> > > +                     "their priority: LBACK > SLEEP > SNOOP.\n ");
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN) ==
> > 0) {
> > > +        /* We are in configuration mode, any mode can be selected. */
> > > +        s->regs[R_MODE_SELECT_REGISTER] = val;
> > > +    } else {
> > > +        bool sleep_mode_bit = FIELD_EX32(val, MODE_SELECT_REGISTER,
> > > + SLEEP);
> > > +
> > > +        ARRAY_FIELD_DP32(s->regs, MODE_SELECT_REGISTER, SLEEP,
> > > + sleep_mode_bit);
> > > +
> > > +        if (FIELD_EX32(val, MODE_SELECT_REGISTER, LBACK)) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "Attempting to set LBACK
> > mode "
> > > +                          "without setting CEN bit as 0\n");
> > > +        } else if (FIELD_EX32(val, MODE_SELECT_REGISTER, SNOOP)) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "Attempting to set SNOOP
> > mode "
> > > +                              "without setting CEN bit as 0\n");
> > > +        }
> > > +
> > > +        update_status_register_mode_bits(s);
> > > +    }
> > > +    return s->regs[R_MODE_SELECT_REGISTER]; }
> > > +
> > > +static uint64_t can_brpr_pre_write(RegisterInfo  *reg, uint64_t
> > > +val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +
> > > +    /* Only allow writes when in config mode. */
> > > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN)) {
> > > +        val = s-
> > >regs[R_ARBITRATION_PHASE_BAUD_RATE_PRESCALER_REGISTER];
> > > +    }
> > > +
> > > +    return val;
> > > +}
> > > +
> > > +static uint64_t can_btr_pre_write(RegisterInfo  *reg, uint64_t val64)
> > > +{
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +
> > > +    /* Only allow writes when in config mode. */
> > > +    if (ARRAY_FIELD_EX32(s->regs, SOFTWARE_RESET_REGISTER, CEN)) {
> > > +        val = s->regs[R_ARBITRATION_PHASE_BIT_TIMING_REGISTER];
> > > +    }
> > > +
> > > +    return val;
> > > +}
> > > +
> > > +static uint64_t can_tcr_pre_write(RegisterInfo  *reg, uint64_t val64)
> > > +{
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +
> > > +    if (FIELD_EX32(val, TIMESTAMP_REGISTER, CTS)) {
> > > +        s->rx_time_stamp = 0;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static void update_rx_fifo(XlnxZynqMPCANState *s, const
> > > +qemu_can_frame *frame) {
> > > +    uint32_t filter_pass = 0;
> > > +
> > > +    /* If no filter is enabled. Message will be stored in FIFO. */
> > > +    if (!((ARRAY_FIELD_EX32(s->regs, AFR, UAF1)) |
> > > +       (ARRAY_FIELD_EX32(s->regs, AFR, UAF2)) |
> > > +       (ARRAY_FIELD_EX32(s->regs, AFR, UAF3)) |
> > > +       (ARRAY_FIELD_EX32(s->regs, AFR, UAF4)))) {
> > > +        filter_pass = 1;
> > > +    }
> > > +
> > > +    /*
> > > +     * Messages that pass any of the acceptance filters will be stored in
> > > +     * the RX FIFO.
> > > +     */
> > > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF1)) {
> > > +        uint32_t id_masked = s->regs[R_AFMR1] & frame->can_id;
> > > +        uint32_t filter_id_masked = s->regs[R_AFMR1] &
> > > + s->regs[R_AFIR1];
> > > +
> > > +        if (filter_id_masked == id_masked) {
> > > +            filter_pass = 1;
> > > +        }
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF2)) {
> > > +        uint32_t id_masked = s->regs[R_AFMR2] & frame->can_id;
> > > +        uint32_t filter_id_masked = s->regs[R_AFMR2] &
> > > + s->regs[R_AFIR2];
> > > +
> > > +        if (filter_id_masked == id_masked) {
> > > +            filter_pass = 1;
> > > +        }
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF3)) {
> > > +        uint32_t id_masked = s->regs[R_AFMR3] & frame->can_id;
> > > +        uint32_t filter_id_masked = s->regs[R_AFMR3] &
> > > + s->regs[R_AFIR3];
> > > +
> > > +        if (filter_id_masked == id_masked) {
> > > +            filter_pass = 1;
> > > +        }
> > > +    }
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF4)) {
> > > +        uint32_t id_masked = s->regs[R_AFMR4] & frame->can_id;
> > > +        uint32_t filter_id_masked = s->regs[R_AFMR4] &
> > > + s->regs[R_AFIR4];
> > > +
> > > +        if (filter_id_masked == id_masked) {
> > > +            filter_pass = 1;
> > > +        }
> > > +    }
> > > +
> > > +    /* Store the message in fifo if it passed through any of the filters. */
> > > +    if (filter_pass && frame->can_dlc <= MAX_DLC) {
> > > +
> > > +        if (fifo32_is_full(&s->rx_fifo)) {
> > > +            DB_PRINT("RX FIFO is full.\n");
> > > +
> > > +            ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > RXOFLW, 1);
> > > +        } else {
> > > +            s->rx_time_stamp += 1;
> > > +
> > > +            fifo32_push(&s->rx_fifo, frame->can_id);
> > > +
> > > +            fifo32_push(&s->rx_fifo, (deposit32(0,
> > R_RXFIFO_DLC_DLC_SHIFT,
> > > +                                                R_RXFIFO_DLC_DLC_LENGTH,
> > > +                                                frame->can_dlc) |
> > > +                                      deposit32(0, R_RXFIFO_DLC_RXT_SHIFT,
> > > +                                                R_RXFIFO_DLC_RXT_LENGTH,
> > > +                                                s->rx_time_stamp)));
> > > +
> > > +            /* First 32 bit of the data. */
> > > +            fifo32_push(&s->rx_fifo, (deposit32(0,
> > R_TXFIFO_DATA1_DB3_SHIFT,
> > > +                                        R_TXFIFO_DATA1_DB3_LENGTH,
> > > +                                        frame->data[0]) |
> > > +                                      deposit32(0, R_TXFIFO_DATA1_DB2_SHIFT,
> > > +                                        R_TXFIFO_DATA1_DB2_LENGTH,
> > > +                                        frame->data[1]) |
> > > +                                      deposit32(0, R_TXFIFO_DATA1_DB1_SHIFT,
> > > +                                        R_TXFIFO_DATA1_DB1_LENGTH,
> > > +                                        frame->data[2]) |
> > > +                                      deposit32(0, R_TXFIFO_DATA1_DB0_SHIFT,
> > > +                                        R_TXFIFO_DATA1_DB0_LENGTH,
> > > +                                        frame->data[3])));
> > > +            /* Last 32 bit of the data. */
> > > +            fifo32_push(&s->rx_fifo, (deposit32(0,
> > R_TXFIFO_DATA2_DB7_SHIFT,
> > > +                                         R_TXFIFO_DATA2_DB7_LENGTH,
> > > +                                         frame->data[4]) |
> > > +                                      deposit32(0, R_TXFIFO_DATA2_DB6_SHIFT,
> > > +                                         R_TXFIFO_DATA2_DB6_LENGTH,
> > > +                                         frame->data[5]) |
> > > +                                      deposit32(0, R_TXFIFO_DATA2_DB5_SHIFT,
> > > +                                         R_TXFIFO_DATA2_DB5_LENGTH,
> > > +                                         frame->data[6]) |
> > > +                                      deposit32(0, R_TXFIFO_DATA2_DB4_SHIFT,
> > > +                                          R_TXFIFO_DATA2_DB4_LENGTH,
> > > +                                          frame->data[7])));
> > > +
> > > +            ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > RXOK, 1);
> > > +        }
> > > +
> > > +        can_update_irq(s);
> > > +
> > 
> > I would drop this blank line...
> [Vikram Garhwal] Will remove this in v4.
> > 
> > > +    } else {
> > > +        DB_PRINT("Message didn't pass through any filter"
> > > +                  "or dlc is not in range\n");
> > > +    }
> > > +}
> > > +
> > > +static uint64_t can_rxfifo_pre_read(RegisterInfo *reg, uint64_t
> > > +val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t r = 0;
> > > +
> > > +    if (!fifo32_is_empty(&s->rx_fifo)) {
> > > +        r = fifo32_pop(&s->rx_fifo);
> > > +    } else {
> > > +        DB_PRINT("No message in RXFIFO\n");
> > > +
> > > +        ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER,
> > RXUFLW, 1);
> > > +    }
> > > +
> > > +    can_update_irq(s);
> > > +    return r;
> > > +}
> > > +
> > > +static void can_filter_enable_post_write(RegisterInfo *reg, uint64_t
> > > +val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +
> > > +    if (ARRAY_FIELD_EX32(s->regs, AFR, UAF1) &&
> > > +        ARRAY_FIELD_EX32(s->regs, AFR, UAF2) &&
> > > +        ARRAY_FIELD_EX32(s->regs, AFR, UAF3) &&
> > > +        ARRAY_FIELD_EX32(s->regs, AFR, UAF4)) {
> > > +
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, ACFBSY, 1);
> > > +
> > 
> > Another odd blank line.
> [Vikram Garhwal] Will remove this in v4.
> > 
> > > +    } else {
> > > +        ARRAY_FIELD_DP32(s->regs, STATUS_REGISTER, ACFBSY, 0);
> > > +    }
> > > +}
> > > +
> > > +static uint64_t can_filter_mask_pre_write(RegisterInfo *reg, uint64_t
> > > +val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t reg_idx = (reg->access->addr) / 4;
> > > +    uint32_t val = val64;
> > > +    uint32_t filter_number = (reg_idx - R_AFMR1) / 2;
> > > +
> > > +    /* modify an acceptance filter, the corresponding UAF bit should be
> > '0.' */
> > > +    if (!(s->regs[R_AFR] & (1 << filter_number))) {
> > > +        s->regs[reg_idx] = val;
> > > +    } else {
> > > +        DB_PRINT("Acceptance filter %d mask is not set as it's
> > corresponding "
> > > +                 "UAF bit is not set to 0\n", filter_number + 1);
> > > +    }
> > > +
> > > +    return s->regs[reg_idx];
> > > +}
> > > +
> > > +static uint64_t can_filter_id_pre_write(RegisterInfo *reg, uint64_t
> > > +val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t reg_idx = (reg->access->addr) / 4;
> > > +    uint32_t val = val64;
> > > +    uint32_t filter_number = (reg_idx - R_AFIR1) / 2;
> > > +
> > > +    if (!(s->regs[R_AFR] & (1 << filter_number))) {
> > > +        s->regs[reg_idx] = val;
> > > +    } else {
> > > +        DB_PRINT("Acceptance filter %d id is not set as it's corresponding "
> > > +                 "UAF bit is not set to 0\n", filter_number + 1);
> > 
> > Should this be a LOG_GUEST_ERROR?
> [Vikram Garhwal] Thanks for catching this. This one affects functionality of CAN so LOG_GUEST_ERROR will do better here.
> > 
> > 
> > > +    }
> > > +
> > > +    return s->regs[reg_idx];
> > > +}
> > > +
> > > +static void can_tx_post_write(RegisterInfo *reg, uint64_t val64) {
> > > +    XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > > +    uint32_t val = val64;
> > > +
> > > +    bool is_txhpb = reg->access->addr > A_TXFIFO_DATA2;
> > > +
> > > +    bool initiate_transfer = (reg->access->addr == A_TXFIFO_DATA2) ||
> > > +                             (reg->access->addr == A_TXHPB_DATA2);
> > > +
> > > +    Fifo32 *f = is_txhpb ? &s->txhpb_fifo : &s->tx_fifo;
> > > +
> > > +    DB_PRINT("TX FIFO write for CAN%d\n", s->cfg.ctrl_idx);
> > > +
> > > +    if (!fifo32_is_full(f)) {
> > > +        fifo32_push(f, val);
> > > +    } else {
> > > +        DB_PRINT("TX FIFO is full.\n");
> > 
> > Doesn't this trigger any SW visible event like an interrupt, set some status
> > bit?
> [Vikram Garhwal] Yeah, at the end of this function it calls can_update_irq this will set the interrupt. 
> > We should probably LOG_GUEST_ERROR here too...

Not really, can_update_irq flags if the FIFO is full but it does not flag
anything if we lost data because SW tried to send something while the FIFO
was full. I couldn't see anything in the specs for that case but
you may want to LOG_GUEST_ERROR the else branch of the if-statement
rather than DB_PRINT.

Cheers,
Edgar



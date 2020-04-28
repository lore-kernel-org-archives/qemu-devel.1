Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DEC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A3E20B80
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS5mzIT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A3E20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVQU-0000Lu-SS
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jTVPT-0007vJ-Or
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jTVP0-0007iY-46
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:56:47 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jTVOz-0007h2-Mr; Tue, 28 Apr 2020 14:56:17 -0400
Received: by mail-lj1-x244.google.com with SMTP id u15so22642382ljd.3;
 Tue, 28 Apr 2020 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3WQb39qb3qFPRCFp9//hGfhfcbKualdj6DWguugT4sM=;
 b=PS5mzIT9W6+NMGb46exgifnv5s6PWmaslFSwUXObkx7oNYuse7FIovkhjf7woJ4PxV
 wKog6MpJfvaVFuJqbf/wdqtmJs8SY9j73H2qsGikzPMEVlpNRJEuSrzHpGxKvAXCa1fb
 UTLD8GHgiJUeBFA14sEOPHN+F9ph1iDZoCKAN8K0sGrRUe2JmC9FVYhatwgU2BReMr21
 ouz5VSEL2WGEYCrGCMj3PFYzFHPzmpeBsf5Fnu1bJAdi+XVQGRlSVrhAbfmnV0SE7XiJ
 nbGNIeaO0Z7O5IM8CtHbq5vWhnw++kovMRR36dR507RnF1Fu0BwG4dihpG2a693wUltg
 B3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3WQb39qb3qFPRCFp9//hGfhfcbKualdj6DWguugT4sM=;
 b=mLX2EJWV96DbHMsbbVvp6GDR+LeiQWngpEW9uuTV+uIDrwFpMlgitxhnWshPAwrd9N
 5EXWGURh5NPymcgal3FIZwlZmnCUU5zt56bYY0rBo0p9tKn3+gQHdPUgikW93MEFCmjt
 2Tq+eFJs3VDaNPtNEjAObTGkx6wyjlQ7HRTnRbe3OCWs12SQY1NXnZpnFmPI4XsQQsb+
 2kRyx2/pYQJ2JEFuL6RUcg4rPofPzmT/oUB788dzTQA89AmFQZyvmww5PPulqZrWSJuE
 HVu0j03QqrpS7Ns7dyHwrax5v8IFaghmrwryS13wPOLhn/C+rlvFZcAhaODVPKyW7plr
 UvNg==
X-Gm-Message-State: AGi0PuZEq6PFK7PTcY/OyaX/Y2zBh9lJykiUCX1h+q5fl4wa9UHWQWIp
 oB56hUGgM84JMJvvgSPGGV0=
X-Google-Smtp-Source: APiQypLjU9FWBw0yIoL+8MYsOiEH/p3XvOwKJeJL4GGlAnVPlh3DSR5WB4PTc06IczbFzaFh6VhgQw==
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr16614941ljg.187.1588100175013; 
 Tue, 28 Apr 2020 11:56:15 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 j22sm77869lfg.96.2020.04.28.11.56.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 28 Apr 2020 11:56:14 -0700 (PDT)
Date: Tue, 28 Apr 2020 20:56:12 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v3 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controller
Message-ID: <20200428185611.qn4nolfq2zklahxm@fralle-msi>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
 <1587603369-14644-3-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587603369-14644-3-git-send-email-fnu.vikram@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vikram,

A couple of more comments:

On the git summary:
s/controller/controllers/

On [2020 Apr 22] Wed 17:56:07, Vikram Garhwal wrote:
> Connect CAN0 and CAN1 to ZCU102 board.

Perhaps also:
s/to ZCU102 board/on the ZynqMP/

(even though zcu102 is the only board using it at the moment).

Best regards,
Francisco

> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  hw/arm/xlnx-zynqmp.c         | 26 ++++++++++++++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  3 +++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index b84d153..e5f0d9f 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -81,6 +81,14 @@ static const int uart_intr[XLNX_ZYNQMP_NUM_UARTS] = {
>      21, 22,
>  };
>  
> +static const uint64_t can_addr[XLNX_ZYNQMP_NUM_CAN] = {
> +    0xFF060000, 0xFF070000,
> +};
> +
> +static const int can_intr[XLNX_ZYNQMP_NUM_CAN] = {
> +    23, 24,
> +};
> +
>  static const uint64_t sdhci_addr[XLNX_ZYNQMP_NUM_SDHCI] = {
>      0xFF160000, 0xFF170000,
>  };
> @@ -254,6 +262,11 @@ static void xlnx_zynqmp_init(Object *obj)
>                                TYPE_CADENCE_UART);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        sysbus_init_child_obj(obj, "can[*]", &s->can[i], sizeof(s->can[i]),
> +                              TYPE_XLNX_ZYNQMP_CAN);
> +    }
> +
>      sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
>                            TYPE_SYSBUS_AHCI);
>  
> @@ -508,6 +521,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                             gic_spi[uart_intr[i]]);
>      }
>  
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_property_set_int(OBJECT(&s->can[i]), i, "ctrl-idx",
> +                                &error_abort);
> +        object_property_set_bool(OBJECT(&s->can[i]), true, "realized", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, can_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
> +                           gic_spi[can_intr[i]]);
> +    }
> +
>      object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
>                              &error_abort);
>      object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 53076fa..2be0ff9 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -22,6 +22,7 @@
>  #include "hw/intc/arm_gic.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/char/cadence_uart.h"
> +#include "hw/net/xlnx-zynqmp-can.h"
>  #include "hw/ide/ahci.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/ssi/xilinx_spips.h"
> @@ -41,6 +42,7 @@
>  #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
>  #define XLNX_ZYNQMP_NUM_GEMS 4
>  #define XLNX_ZYNQMP_NUM_UARTS 2
> +#define XLNX_ZYNQMP_NUM_CAN 2
>  #define XLNX_ZYNQMP_NUM_SDHCI 2
>  #define XLNX_ZYNQMP_NUM_SPIS 2
>  #define XLNX_ZYNQMP_NUM_GDMA_CH 8
> @@ -92,6 +94,7 @@ typedef struct XlnxZynqMPState {
>  
>      CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
>      CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
> +    XlnxZynqMPCANState    can[XLNX_ZYNQMP_NUM_CAN];
>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> -- 
> 2.7.4
> 
> 


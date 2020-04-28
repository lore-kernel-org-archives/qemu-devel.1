Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310DCC83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2441208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVK/hTwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2441208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTJn-0005zN-ST
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTTF5-0006OV-7O
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTTBc-0000pN-CV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:37:54 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jTTBb-0000ot-Sj; Tue, 28 Apr 2020 12:34:19 -0400
Received: by mail-lj1-x244.google.com with SMTP id g4so22196367ljl.2;
 Tue, 28 Apr 2020 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F/qJFRK2xdLo2lszjG6qf99vwjDSSthRThTt33h6GNQ=;
 b=qVK/hTwI5G+iBJRnYmHoEXEODGgN2hnNhyVigd4vVQ/YG4RNy6uuWFoN53W4Trg7l4
 FRcn6S+6k00cDBo/JW/E17Z+wOPW5oVn68ISQeO7rK5sDT5ewk7bmhuOjf8JNVMa051I
 fuIdh0I+yNZKAwmfUapgb9CZdHtR6mGTaPtgyxgQ7SEmN6x8Bshq70+SitWMLYSJgv+r
 3UL7742NtAsTz1rHnDFWIcBtEjCb6tBA7KOHECkydKYSU/RtBTlgP7qil8k+ee4RKPRc
 EydGakQNTsJHSL3VK5/jgh+pSfQsLdTGWGGuVFvvgEKg6nXuRlsIfaeibE0Ec3BSHJms
 TSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F/qJFRK2xdLo2lszjG6qf99vwjDSSthRThTt33h6GNQ=;
 b=Ia6b6C0rfIU07li0MYM7i5IaN29D5IGBUj8jaP4VdAyAKStg8WFWZuZBI1KdLHnvgj
 2MuhYDEv9D/X6gkYDliWPMixYhDPXZCud2rrliNpCDbIu2IgtuJtXgt2vpX8Vdf1+nC/
 yKEPwEzjmt2Po3d/Lbf1pZZPbRNsM9WFRxAqUT1i0xU33OtUF6DxwyHMPyrqjJcG+OlL
 rtCzubYiK9YqG4lk2leInEy7T4Gpt7bEossftPR3c7kRwQ7AuX9qE3QcwT2LAcScj7V4
 tLamXHPcNmbwYtdm1OwlRFmzlL1IwC2zOe/7v4ot+BZHjNheJMlKVTQSceJLs1+zQVqv
 SbXw==
X-Gm-Message-State: AGi0PubZIcIOxipbH6OHroWH3MyehWDCtUaC4NN2JP0S01WDKAw5tRxk
 6zWplvSYWWEMF/7XBz4vQbc=
X-Google-Smtp-Source: APiQypKQkYvtOCRX3j+ELph7LMb9j/d86WtfQn8T6PcQjeE4jBlMYCzHNzbf7qtTnEIKjzYxVJFTUA==
X-Received: by 2002:a2e:b0c5:: with SMTP id g5mr18233121ljl.203.1588091657503; 
 Tue, 28 Apr 2020 09:34:17 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id k18sm17383787lfg.81.2020.04.28.09.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 09:34:16 -0700 (PDT)
Date: Tue, 28 Apr 2020 18:33:44 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v3 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controller
Message-ID: <20200428163344.GM2669@toto>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
 <1587603369-14644-3-git-send-email-fnu.vikram@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587603369-14644-3-git-send-email-fnu.vikram@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 05:56:07PM -0700, Vikram Garhwal wrote:
> Connect CAN0 and CAN1 to ZCU102 board.

Comments inline.



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

All those spaces between type and array look odd here.

Without those spaces:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>




>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> -- 
> 2.7.4
> 


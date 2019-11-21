Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2456C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3EC206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Fkja8nNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3EC206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXq2u-0001sx-Tk
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iXq1x-0001L4-Hc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iXq1v-00036a-JA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:14:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iXq1v-00035T-8x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:14:07 -0500
Received: by mail-oi1-x244.google.com with SMTP id a14so3883138oid.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=b1YrrIJoqInpingjgTyZ8K2fdcJ7rd4qQmCHAj2Oo6E=;
 b=Fkja8nNXUHOG25MLfBusgP6J9kRZqrv2StRIsnsKe5kRBlZVv3voLwvRO74l4ndByC
 eXxnQGSC0Y/BYWPhzwZKMscrO5RAX626aWk2HJdv2rfU2Uo736O1bkeAbaDaK1u9b9I7
 AWNXiY0yg7w9L1Slgxc1/rk0cz8YrvOL6tdZyEa4wJ/C8EBtN7svqVU3+S48zKAAeTR2
 EO/f6SkHPVKakNmCNHhotIL3s3ON4EsWV7GGKRLuDN1zWu+WXMgf3QI4IdaZJTPGUell
 IjFFcVnPmJDxreobnQhfuzM6Y1aoyW3s0FSIYqhFJTaA7ZGEL4YtWYfXzGZ/ldl7jU6l
 Z5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=b1YrrIJoqInpingjgTyZ8K2fdcJ7rd4qQmCHAj2Oo6E=;
 b=ZEgs7WBI/YPY0zjGi4GIbDVpCx3BnFMErp7sRitDgIK2lMDJLM3n4Z0EVP2tnQXA3w
 fVmG5Y/m9fUlDngZQSCxpkaEoMKbIxDOLaE/Qi6spIsLqQr6S5pB40s92wbrCr6eAbXw
 OxMN5UIFbVM7cD55iDM3jGL98+sD9jf+5qNk3vTzLsQ5b85U1hT4a4Y2eLISkHKr1s7q
 fBETFPs2mjq5npha+J880I/wHQXXT/vcrYkafKV87xL1agxT7C9Acxm67EwkpoGLOVzG
 tw4svFkkV3vyEHGiN6xLgGvuAs9w0G0AoYsxCdA2To5i/6YufYwyQT0BX8bzUPPfBA+K
 dVMw==
X-Gm-Message-State: APjAAAW1+1WZB7JRjnexHZszyFtAU1c2Z+o0VD2Ffx40kTy7jPOG1kj0
 gwCl5Lxwbe72kHvxTvw6TY8WlA==
X-Google-Smtp-Source: APXvYqwFV65+3Bdqy+hHZdCBAhuMApg3hWz6Qu4xXNEMPg466zLG9NZH3vdZHs/f8rPkjA6PhdSc4w==
X-Received: by 2002:a05:6808:103:: with SMTP id
 b3mr8152280oie.38.1574356444555; 
 Thu, 21 Nov 2019 09:14:04 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id e93sm1173408otb.60.2019.11.21.09.14.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Nov 2019 09:14:03 -0800 (PST)
Date: Thu, 21 Nov 2019 11:14:02 -0600
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] ppc/pnv: Create BMC devices at machine init
Message-ID: <20191121171402.GI3556@minyard.net>
References: <20191121162340.11049-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121162340.11049-1-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Reply-To: cminyard@mvista.com
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 05:23:40PM +0100, Cédric Le Goater wrote:
> The BMC of the OpenPOWER systems monitors the machine state using
> sensors, controls the power and controls the access to the PNOR flash
> device containing the firmware image required to boot the host.
> 
> QEMU models the power cycle process, access to the sensors and access
> to the PNOR device. But, for these features to be available, the QEMU
> PowerNV machine needs two extras devices on the command line, an IPMI
> BT device for communication and a BMC backend device:
> 
>   -device ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10
> 
> The BMC properties are then defined accordingly in the device tree and
> OPAL self adapts. If a BMC device and an IPMI BT device are not
> available, OPAL does not try to communicate with the BMC in any
> manner. This is not how real systems behave.
> 
> To be closer to the default behavior, create an IPMI BMC simulator
> device and an IPMI BT device at machine initialization time. We loose
> the ability to define an external BMC device but there are benefits:
> 
>   - a better match with real systems,
>   - a better test coverage of the OPAL code,
>   - system powerdown and reset commands that work,
>   - a QEMU device tree compliant with the specifications (*).
> 
> (*) Still needs a MBOX device.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
> 
>  Changes since v1:
> 
>  - renamed ipmi_bt_init() to pnv_ipmi_bt_init()
> 
>  include/hw/ppc/pnv.h |  2 +-
>  hw/ppc/pnv.c         | 33 ++++++++++++++++-----------------
>  hw/ppc/pnv_bmc.c     | 20 +++++++++++++++++---
>  3 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 07c56c05ad30..90f1343ed07c 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -198,7 +198,7 @@ static inline bool pnv_is_power9(PnvMachineState *pnv)
>   */
>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>  void pnv_bmc_powerdown(IPMIBmc *bmc);
> -int pnv_bmc_hiomap(IPMIBmc *bmc);
> +IPMIBmc *pnv_bmc_create(void);
>  
>  /*
>   * POWER8 MMIO base addresses
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c3ac0d6d5b4a..f0adb06c8d65 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -551,27 +551,10 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
>  
>  static void pnv_reset(MachineState *machine)
>  {
> -    PnvMachineState *pnv = PNV_MACHINE(machine);
>      void *fdt;
> -    Object *obj;
>  
>      qemu_devices_reset();
>  
> -    /*
> -     * OpenPOWER systems have a BMC, which can be defined on the
> -     * command line with:
> -     *
> -     *   -device ipmi-bmc-sim,id=bmc0
> -     *
> -     * This is the internal simulator but it could also be an external
> -     * BMC.
> -     */
> -    obj = object_resolve_path_type("", "ipmi-bmc-sim", NULL);
> -    if (obj) {
> -        pnv->bmc = IPMI_BMC(obj);
> -        pnv_bmc_hiomap(pnv->bmc);
> -    }
> -
>      fdt = pnv_dt_create(machine);
>  
>      /* Pack resulting tree */
> @@ -629,6 +612,16 @@ static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
>      return ppc_default->pvr_match(ppc_default, ppc->pvr);
>  }
>  
> +static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
> +{
> +    Object *obj;
> +
> +    obj = OBJECT(isa_create(bus, "isa-ipmi-bt"));
> +    object_property_set_link(obj, OBJECT(bmc), "bmc", &error_fatal);
> +    object_property_set_int(obj, irq, "irq", &error_fatal);
> +    object_property_set_bool(obj, true, "realized", &error_fatal);
> +}
> +
>  static void pnv_init(MachineState *machine)
>  {
>      PnvMachineState *pnv = PNV_MACHINE(machine);
> @@ -751,6 +744,9 @@ static void pnv_init(MachineState *machine)
>      }
>      g_free(chip_typename);
>  
> +    /* Create the machine BMC simulator */
> +    pnv->bmc = pnv_bmc_create();
> +
>      /* Instantiate ISA bus on chip 0 */
>      pnv->isa_bus = pnv_isa_create(pnv->chips[0], &error_fatal);
>  
> @@ -760,6 +756,9 @@ static void pnv_init(MachineState *machine)
>      /* Create an RTC ISA device too */
>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
>  
> +    /* Create the IPMI BT device for communication with the BMC */
> +    pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
> +
>      /*
>       * OpenPOWER systems use a IPMI SEL Event message to notify the
>       * host to powerdown
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index aa5c89586c63..07fa1e1c7e45 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -17,6 +17,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
>  #include "target/ppc/cpu.h"
>  #include "qemu/log.h"
>  #include "hw/ipmi/ipmi.h"
> @@ -211,8 +213,20 @@ static const IPMINetfn hiomap_netfn = {
>      .cmd_handlers = hiomap_cmds
>  };
>  
> -int pnv_bmc_hiomap(IPMIBmc *bmc)
> +/*
> + * Instantiate the machine BMC. PowerNV uses the QEMU internal
> + * simulator but it could also be external.
> + */
> +IPMIBmc *pnv_bmc_create(void)
>  {
> -    return ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc),
> -                                   IPMI_NETFN_OEM, &hiomap_netfn);
> +    Object *obj;
> +
> +    obj = object_new(TYPE_IPMI_BMC_SIMULATOR);
> +    object_property_set_bool(obj, true, "realized", &error_fatal);
> +
> +    /* Install the HIOMAP protocol handlers to access the PNOR */
> +    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(obj), IPMI_NETFN_OEM,
> +                            &hiomap_netfn);
> +
> +    return IPMI_BMC(obj);
>  }
> -- 
> 2.21.0
> 


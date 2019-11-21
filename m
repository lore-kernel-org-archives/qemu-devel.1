Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E296DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A892070E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="HUj+VEzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A892070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoXZ-0000DQ-LF
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iXoVp-0006kD-UB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iXoVo-0001Mj-Dg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:53 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iXoVo-0001Ly-7A
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:52 -0500
Received: by mail-oi1-x244.google.com with SMTP id o12so3525129oic.9
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=udYZf5sS74CzYRl6RwVgfIh4cxg59Ss8igXYAX/tc9M=;
 b=HUj+VEzZNo5H6AZcIoWAVIo/fZpRfuswvxSTvJ7zUTTFAiaE00CptKIZowCaS6p8lZ
 uaDlBkJDS9hM7Vxl69AQE0RB1QlkUJqAI/xgTlv7g8tHaRvMttLjIR7olq2jEhpYA1gB
 dnu7CKEFY1lwdZWdq1B5I0EJIRHrOzligRzHvV6GT4QZUZBVqPMtNeBASFpmcExv92w6
 /BgdDY10Nbio4Mkb9sh4Q+bqLpYNvBqX+sJIquM91+J2baQzLk+oa5R+nTq1UlL08S8U
 IBaFX/nEPFaFuKMoZtKBpGj3cZd2t1JsCOrCU5uIIT9ns8DqrmWttvWpbLlLoSIgTjwO
 BgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=udYZf5sS74CzYRl6RwVgfIh4cxg59Ss8igXYAX/tc9M=;
 b=uXgOkppLxryCginhSJeqc/7lEuzJin7MUq0TRsfzmQ7Ql3lpW0ODK7HfWO4/bElPfu
 +LNbeintkZ092207Aw3l5dYrvxnEwmbMLwZHV2uV6IInD6TNtUG750L3q8cACfkOVufY
 Ta4+Gjwdg9+oJ2ORrbkPrwXLCO5isvVm+n0klWj0nJXOVH59lJZIdj1umTIgg+z+U/xJ
 r7+BeekmTXjeXVygMgfyXhnXP2Eg3YwT32I4ZuHLTfLhCP4DXYI5uGk+E3wcTAbQtMnC
 ylpZx1UicbqMN3jGxxTCQ93os2G/KBo80g4d9LhWRiEx7mMSiKt+nrnX09Zrbry95PTQ
 pyag==
X-Gm-Message-State: APjAAAWAR2dVuXPHx89b17aRZPOr0NiVD/SYkmJnZs1XH0lqdQaJDWWC
 q2wmBvukekUh2AUiKweGvrFueOl16kI=
X-Google-Smtp-Source: APXvYqzN2ebJfScTwZxsKbaRfyDsZr5IxKkLn4iL5OSSepGDYdLPVgga+krGk1D5zRNZxK32prmY4Q==
X-Received: by 2002:a05:6808:103:: with SMTP id
 b3mr7769932oie.38.1574350611061; 
 Thu, 21 Nov 2019 07:36:51 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id e93sm1082061otb.60.2019.11.21.07.36.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Nov 2019 07:36:50 -0800 (PST)
Date: Thu, 21 Nov 2019 09:36:49 -0600
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices at machine init
Message-ID: <20191121153649.GG3556@minyard.net>
References: <20191118092222.15691-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118092222.15691-1-clg@kaod.org>
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

On Mon, Nov 18, 2019 at 10:22:22AM +0100, Cédric Le Goater wrote:
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

With these changes, the above line will no longer be necessary, right?

Minor nit inline ...

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
> ---
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
> index c3ac0d6d5b4a..2117d879895c 100644
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
> +static void ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)

All the other names have pnv_ in front of them, could you add that to
this, too?

-corey

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
> +    ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
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


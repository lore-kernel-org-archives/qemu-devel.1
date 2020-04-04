Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A3C2BA15
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 21:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCD7206CC
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 21:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBuouQ8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCD7206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKqbq-0007O0-RQ
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 17:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <natechancellor@gmail.com>) id 1jKqb1-0006ld-7m
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 17:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <natechancellor@gmail.com>) id 1jKqaz-0004yq-ST
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 17:44:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <natechancellor@gmail.com>)
 id 1jKqaw-0004vG-OE; Sat, 04 Apr 2020 17:44:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id 111so11254689oth.13;
 Sat, 04 Apr 2020 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=QctO0HXP7XhLPiwpyDi7j7KhcHFMN3rW3jJOb2RV6ic=;
 b=LBuouQ8aQS0WUpZFCrWsO+GoIVHPHCQGjjRYdi3ZCjWuGjCOniy3h0xIvrzi3rNHvR
 AKGJzV8NgnYWuBpyZLZVPYG1K6t6pYFMIyB8OGP+CtLDjDgToLNhLwuDEb9weNMn+JJ5
 ZCoTpspmunfuHTQz+vWUoVp+N8hjybxxKcQS5dXbeML384AWRSKa40wjdCcIYDC21MaX
 5W6mYaxH4xIVnGuXyAA1opNEwN3aesN+Xle9xJqWxEzHJnluajKGPOLuWj/NOu6drQ4f
 5tu8WHb06qCxGvBuFIbrevyJ9B7EaYio0HpvrWvZvHYUG2o69OhUHiLVxViMHQA9WAw1
 zVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=QctO0HXP7XhLPiwpyDi7j7KhcHFMN3rW3jJOb2RV6ic=;
 b=rmEg6OmxNd7Kq6Ji8g+qQ+w2i3jiAyJsBABcDiIgm6lqFhsP/iHfBkKnYC8/ZLAf/H
 cBAYPNXee7IRcQyY2ep4PH0obgJgsQpb5RrU7W0mefIaVNOqsYPwt5eEhayPHoOrNhAp
 jgF+jlOXS8ERTFGdg1AqyB8IWuS6JU7CdRUSCoqv3LslehIoxXaRiIldI63HOZf8ktmR
 JRUwdBN3bk30B4XgkreZqZ0Cg2XdtszAYE9RvppUK5Vsv403wEWH4iUwd9cbTx73TOcW
 F+UcyInoI6kXr/Hc7T4UFztTvpRZ1Qz6VKIRT28JYvimBr9dt1uY3GWz4S8tPoiqbfPp
 K27A==
X-Gm-Message-State: AGi0PubXjWAKEmbD3kj2lsGlzSUu1dTXsvfqezcKRa0swCg5ugTWqWLA
 zUdUfuRQjJh4MbfCC5uTgmQ=
X-Google-Smtp-Source: APiQypJZWwcYKEqExUkax0NeT3vSP3J118+a6cHrfHXXP+1zl2nOOZbQwApt8YD7NrIV/0fg2sEfig==
X-Received: by 2002:a4a:4505:: with SMTP id y5mr11971752ooa.29.1586036689621; 
 Sat, 04 Apr 2020 14:44:49 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id m4sm3208410ots.22.2020.04.04.14.44.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 04 Apr 2020 14:44:49 -0700 (PDT)
Date: Sat, 4 Apr 2020 14:44:47 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices only when defaults are enabled
Message-ID: <20200404214447.GA34626@ubuntu-m2-xlarge-x86>
References: <20200404153655.166834-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200404153655.166834-1-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cédric,

On Sat, Apr 04, 2020 at 05:36:55PM +0200, Cédric Le Goater wrote:
> Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
> introduced default BMC devices which can be a problem when the same
> devices are defined on the command line with :
> 
>   -device ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10
> 
> QEMU fails with :
> 
>   qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
> 
> Use defaults_enabled() when creating the default BMC devices to let
> the user provide its own BMC devices using '-nodefaults'. If no BMC
> device are provided, output a warning but let QEMU run as this is a
> supported configuration. However, when multiple BMC devices are
> defined, stop QEMU with a clear error as the results are unexpected.
> 
> Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

This fixes my issue when -nodefaults is passed and that does not regress
QEMU 3.1.0 or 4.2.0. Thank you for the quick fix!

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

A few comments inline.

> ---
>  include/hw/ppc/pnv.h |  2 ++
>  hw/ppc/pnv.c         | 32 ++++++++++++++++++++++++++-----
>  hw/ppc/pnv_bmc.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fb4d0c0234b3..d4b0b0e2ff71 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -241,6 +241,8 @@ struct PnvMachineState {
>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>  void pnv_bmc_powerdown(IPMIBmc *bmc);
>  IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
> +IPMIBmc *pnv_bmc_find(Error **errp);
> +void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>  
>  /*
>   * POWER8 MMIO base addresses
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index ac83b8698b8e..a3b7a8d0ff32 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -573,10 +573,29 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
>  
>  static void pnv_reset(MachineState *machine)
>  {
> +    PnvMachineState *pnv = PNV_MACHINE(machine);
> +    IPMIBmc *bmc;
>      void *fdt;
>  
>      qemu_devices_reset();
>  
> +    /*
> +     * The machine should provide by default an internal BMC simulator.
> +     * If not, try to use the BMC device that was provided on the command
> +     * line.
> +     */
> +    bmc = pnv_bmc_find(&error_fatal);
> +    if (!pnv->bmc) {
> +        if (!bmc) {
> +            warn_report("machine has no BMC device. Use '-device "
> +                        "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
> +                        "to define one");

If I pass no -device flags + -nodefaults, I don't see this message. Is
that expected?

> +        } else {
> +            pnv_bmc_set_pnor(bmc, pnv->pnor);
> +            pnv->bmc = bmc;
> +        }
> +    }
> +
>      fdt = pnv_dt_create(machine);
>  
>      /* Pack resulting tree */
> @@ -835,9 +854,6 @@ static void pnv_init(MachineState *machine)
>      }
>      g_free(chip_typename);
>  
> -    /* Create the machine BMC simulator */
> -    pnv->bmc = pnv_bmc_create(pnv->pnor);
> -
>      /* Instantiate ISA bus on chip 0 */
>      pnv->isa_bus = pnv_isa_create(pnv->chips[0], &error_fatal);
>  
> @@ -847,8 +863,14 @@ static void pnv_init(MachineState *machine)
>      /* Create an RTC ISA device too */
>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
>  
> -    /* Create the IPMI BT device for communication with the BMC */
> -    pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
> +    /*
> +     * Create the machine BMC simulator and the IPMI BT device for
> +     * communication with the BMC
> +     */
> +    if (defaults_enabled()) {
> +        pnv->bmc = pnv_bmc_create(pnv->pnor);
> +        pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
> +    }
>  
>      /*
>       * OpenPOWER systems use a IPMI SEL Event message to notify the
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 8863354c1c08..4e018b8b70e4 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -213,6 +213,18 @@ static const IPMINetfn hiomap_netfn = {
>      .cmd_handlers = hiomap_cmds
>  };
>  
> +
> +void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
> +{
> +    object_ref(OBJECT(pnor));
> +    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor),
> +                                   &error_abort);
> +
> +    /* Install the HIOMAP protocol handlers to access the PNOR */
> +    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc), IPMI_NETFN_OEM,
> +                            &hiomap_netfn);
> +}
> +
>  /*
>   * Instantiate the machine BMC. PowerNV uses the QEMU internal
>   * simulator but it could also be external.
> @@ -232,3 +244,36 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
>  
>      return IPMI_BMC(obj);
>  }
> +
> +typedef struct ForeachArgs {
> +    const char *name;
> +    Object *obj;
> +} ForeachArgs;
> +
> +static int bmc_find(Object *child, void *opaque)
> +{
> +    ForeachArgs *args = opaque;
> +
> +    if (object_dynamic_cast(child, args->name)) {
> +        if (args->obj) {
> +            return 1;
> +        }
> +        args->obj = child;
> +    }
> +    return 0;
> +}
> +
> +IPMIBmc *pnv_bmc_find(Error **errp)
> +{
> +    ForeachArgs args = { TYPE_IPMI_BMC_SIMULATOR, NULL };
> +    int ret;
> +
> +    ret = object_child_foreach_recursive(object_get_root(), bmc_find, &args);
> +    if (ret) {
> +        error_setg(errp, "machine should have only one BMC device. "
> +                   "Use '-nodefaults'");

When passing the -device flags in the commit message as I did in my
original command without -nodefaults, I still see the

qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS

message. Is that expected?

> +        return NULL;
> +    }
> +
> +    return args.obj ? IPMI_BMC(args.obj) : NULL;
> +}
> -- 
> 2.25.1
> 


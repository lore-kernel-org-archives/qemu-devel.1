Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609B12067C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="q/QaA8FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609B12067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kyt-00061T-LB
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1k8ky8-0005ZO-9U
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:51:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1k8ky4-0004e0-B3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:51:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so2105249wrl.4
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vYXewd6GjmPAqPohPeYMcDLKpv4ENl+6z1KY0U8cKWI=;
 b=q/QaA8FJtXn+2+6b3vtOoKgn15alBYAV6MJS+x649wqRaH5BRy+Eh/Nxh8tzZSTojt
 AIXK+0V6JjdHHBzIjeqJuR+B9sXjoi6ornBWGbdGx6xf1XfQjF5WQYRD7EpxdAaDJI/S
 mW3Otm/kgSMoTjdFDLeViVtePl0lDcRmbX5DmKVT6CTdvTAD0GowzJHitZHKk4OYfkwr
 +SBHbWP/hpftjRtCNWhktpztKWSjsU2NfaXszo3lqotRWQMctXtVHvOR2PDzstwtWZkl
 4qraEYxdCdRrI8dPj4U2FBSA2RUMkVJlgeV9pismELTEs9wcRxUkqeFcVr5ceK0oMlGa
 r2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vYXewd6GjmPAqPohPeYMcDLKpv4ENl+6z1KY0U8cKWI=;
 b=QHSup/Ypz+sByFGiiL9OjU3DjhONRHewmKrJ/phO8BTK1JzbqNzaT97dfcIhwK/P3b
 E+yduk4VR0C6Ch44TbfXfQtfKhLTnPPt+CJ335ulGgIx+q2BnHKciTrBB4P3YiGt0brr
 K+mT1vTq7qKDqH7lwCNMkv/BJ2/TouGDdi33NcOpXP6vkJpXib7s6J7il8uQW3XV1VcB
 W/7ZRrwtG/IAYzN1blTZ9VB+SyOxXptt5PbDvezU0RIy8y9RA1AawlfB3GjIE8pyffdX
 IhU219MIqbiV9j9G3pYSoizAKOJZG6hRpvuMgD7nSrb4ZWVez6UgIrS2V9AqDczJkGtJ
 DSTw==
X-Gm-Message-State: AOAM530YvhH61+d4nZna2gv+YNtvPspFdtM/fs2g3Dfsy1Od6jbfaj2i
 BS2+IQ4Jt2nZfchEOHRk40nKYw==
X-Google-Smtp-Source: ABdhPJwdTE9KjCQPk11y+xZGVcZg8AqGZLo7kPmkB2HGB+RTHM60EfQpj84G/0Ei2CWxy7rRmw/4mA==
X-Received: by 2002:adf:f785:: with SMTP id q5mr3316581wrp.298.1597931458546; 
 Thu, 20 Aug 2020 06:50:58 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id t11sm4071719wrs.66.2020.08.20.06.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 06:50:58 -0700 (PDT)
Date: Thu, 20 Aug 2020 14:50:56 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded controller
Message-ID: <20200820135056.qgageqiaghz2iihx@xora-monster>
References: <20200820133201.80577-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820133201.80577-1-graeme@nuviainc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, rad@semihalf.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 02:32:01PM +0100, Graeme Gregory wrote:
> A difference between sbsa platform and the virt platform is PSCI is
> handled by ARM-TF in the sbsa platform. This means that the PSCI code
> there needs to communicate some of the platform power changes down
> to the qemu code for things like shutdown/reset control.
> 
> Space has been left to extend the EC if we find other use cases in
> future where ARM-TF and qemu need to communicate.
> 
> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> ---
>  hw/arm/sbsa-ref.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index f030a416fd..c8743fc1d0 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -41,6 +41,7 @@
>  #include "hw/usb.h"
>  #include "hw/char/pl011.h"
>  #include "net/net.h"
> +#include "migration/vmstate.h"
>  
>  #define RAMLIMIT_GB 8192
>  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> @@ -62,6 +63,7 @@ enum {
>      SBSA_CPUPERIPHS,
>      SBSA_GIC_DIST,
>      SBSA_GIC_REDIST,
> +    SBSA_SECURE_EC,
>      SBSA_SMMU,
>      SBSA_UART,
>      SBSA_RTC,
> @@ -98,6 +100,14 @@ typedef struct {
>  #define SBSA_MACHINE(obj) \
>      OBJECT_CHECK(SBSAMachineState, (obj), TYPE_SBSA_MACHINE)
>  
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +} SECUREECState;
> +
> +#define TYPE_SECURE_EC      "sbsa-secure-ec"
> +#define SECURE_EC(obj) OBJECT_CHECK(SECUREECState, (obj), TYPE_SECURE_EC)
> +
>  static const MemMapEntry sbsa_ref_memmap[] = {
>      /* 512M boot ROM */
>      [SBSA_FLASH] =              {          0, 0x20000000 },
> @@ -107,6 +117,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
>      [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
>      [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
> +    [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
>      [SBSA_UART] =               { 0x60000000, 0x00001000 },
>      [SBSA_RTC] =                { 0x60010000, 0x00001000 },
>      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> @@ -585,6 +596,65 @@ static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>      return board->fdt;
>  }
>  
> +enum sbsa_secure_ec_powerstates {
> +    SBSA_SECURE_EC_CMD_NULL,
> +    SBSA_SECURE_EC_CMD_POWEROFF,
> +    SBSA_SECURE_EC_CMD_REBOOT,
> +};
> +
> +static uint64_t secure_ec_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    /* No use for this currently */
> +    return 0;
> +}
> +
> +static void secure_ec_write(void *opaque, hwaddr offset,
> +                     uint64_t value, unsigned size)
> +{
> +    if (offset == 0) { /* PSCI machine power command register */
> +        switch (value) {
> +        case SBSA_SECURE_EC_CMD_NULL:
> +            break;
> +        case SBSA_SECURE_EC_CMD_POWEROFF:
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +            break;
> +        case SBSA_SECURE_EC_CMD_REBOOT:
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            break;
> +        default:
> +            error_report("sbsa-ref: ERROR Unkown power command");
> +        }
> +    } else {
> +        error_report("sbsa-ref: unknown EC register");
> +    }
> +}
> +
> +static const MemoryRegionOps secure_ec_ops = {
> +    .read = secure_ec_read,
> +    .write = secure_ec_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void secure_ec_init(Object *obj)
> +{
> +    SECUREECState *s = SECURE_EC(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &secure_ec_ops, s, "secure-ec",
> +                            0x1000);
> +    sysbus_init_mmio(dev, &s->iomem);
> +}
> +
> +static void create_secure_ec(MemoryRegion *mem)
> +{
> +    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
> +    DeviceState *dev = qdev_create(NULL, TYPE_SECURE_EC);

I've just discovered the API change here, I tested in an older tree, but
Ill wait for other reviews before re-issuing.

Graeme

> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_add_subregion(mem, base,
> +                                sysbus_mmio_get_region(s, 0));
> +}
> +
>  static void sbsa_ref_init(MachineState *machine)
>  {
>      unsigned int smp_cpus = machine->smp.cpus;
> @@ -708,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
>  
>      create_pcie(sms);
>  
> +    create_secure_ec(secure_sysmem);
> +
>      sms->bootinfo.ram_size = machine->ram_size;
>      sms->bootinfo.nb_cpus = smp_cpus;
>      sms->bootinfo.board_id = -1;
> @@ -798,8 +870,31 @@ static const TypeInfo sbsa_ref_info = {
>      .instance_size = sizeof(SBSAMachineState),
>  };
>  
> +static const VMStateDescription vmstate_secure_ec_info = {
> +    .name = "sbsa-secure-ec",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +};
> +
> +static void secure_ec_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_secure_ec_info;
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo secure_ec_info = {
> +    .name          = TYPE_SECURE_EC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SECUREECState),
> +    .instance_init = secure_ec_init,
> +    .class_init    = secure_ec_class_init,
> +};
> +
>  static void sbsa_ref_machine_init(void)
>  {
> +    type_register_static(&secure_ec_info);
>      type_register_static(&sbsa_ref_info);
>  }
>  
> -- 
> 2.25.1
> 


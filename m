Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1883BC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D335A20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="NTPJHBv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D335A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9d1Q-0003WJ-0Y
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1j9d0J-0002vO-Sz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1j9d0I-0000ST-C6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:00:39 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1j9d0H-0000S8-Sa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:00:38 -0500
Received: by mail-pj1-x1042.google.com with SMTP id o2so1609310pjp.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 15:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=A+8YyLnxsylnT/bWU3JoXEptrIiLtpYK4ca11ZtIoAs=;
 b=NTPJHBv7LkdVcUWy2EkjCDrONjt7gDGWd/PifAFSwwXzPJKFRXZZImih4SbsidHCp0
 ldMlnwzALdXXC61B/2SH9tF7WvOayz0FUkCTzfYinYYW9O+eRyynwFL5VmiT96voSweM
 77bqHAkkWibQJGnDGTj2YWienbf3Ba3uAdHUF84SiU8YvNIdX+K3O5SckGjQXJMT7H5L
 U9mCM020A/hALwHxv2Jr29ldwQqBS0kYci+JZPTJF6g5LLeoU+BJBFXsINUOYzMxCcE6
 eXolXU/tuR1UrVloSlOQPGEmaAaOucoKPKThSJ5UE8gJVXGZYuBh1o7wUyDFGnvA8AfN
 VajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=A+8YyLnxsylnT/bWU3JoXEptrIiLtpYK4ca11ZtIoAs=;
 b=i6xEFwGh/YvD4lSytyjQrFETnTK7w/GkT7o3gu5KXS2knEvYOqzpZLAU0ij2/33Nu5
 0yxmckzxhrIyxBIAB5aFIAdZxL1DBMvkOZ/XfDThuGUh5gCU75ggkSriKhQCHveNlT66
 eDDeD9q20IY+KAX1UuGc2NENrUJmRhPjwE0242Kpk/ZwPKxvn8QNLKBtcwVrBxO990sp
 NieoD2h6KNewa1Jb/WQ5w9/29IYirj8OIyOQLfFrS7FjOuuxYwgBWF8tpivn/wnEHunf
 410c8kVQ62ccdxeMkt3WRBPqV5yx3k1UUWav922Nh7jjzjVpR/lnv7QRS2d3P7dLvH0+
 NruQ==
X-Gm-Message-State: ANhLgQ1hTKPCDs1HG+EDCVHPlNJnn03yoZSx0N/A+2FttTwzyjKdCK1t
 MCDWJSqP0DkQYFSyasUfZgU2bg==
X-Google-Smtp-Source: ADFU+vvrG1qKiFIdxgmRRB+pjG2jOxtVpzaUwBiKVUq8u3S44i7fJ2gWwm4wtYnqkLQDQwe1/O6avQ==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1mr5251896plr.5.1583362836166; 
 Wed, 04 Mar 2020 15:00:36 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id k5sm14229898pfp.66.2020.03.04.15.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 15:00:35 -0800 (PST)
Date: Wed, 04 Mar 2020 15:00:35 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 15:00:20 PST (-0800)
Subject: Re: [PATCH v2] riscv: sifive_u: Add a "serial" property for board
 serial number
In-Reply-To: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-fb3ea639-87e6-406b-a679-a568f6d7edf9@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 sagark@eecs.berkeley.edu, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Feb 2020 05:55:17 PST (-0800), bmeng.cn@gmail.com wrote:
> At present the board serial number is hard-coded to 1, and passed
> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> the serial number to generate a unique MAC address for the on-chip
> ethernet controller. When multiple QEMU 'sifive_u' instances are
> created and connected to the same subnet, they all have the same
> MAC address hence it creates a unusable network.
>
> A new "serial" property is introduced to specify the board serial
> number. When not given, the default serial number 1 is used.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v2:
> - Move setting OTP serial number property from riscv_sifive_u_soc_init()
>   to riscv_sifive_u_soc_realize(), to fix the 'check-qtest-riscv' error.
>   I am not really sure why doing so could fix the 'make check' error.
>   The v1 patch worked fine and nothing seems wrong.
>
>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0e12b3c..ca561d3 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -34,6 +34,7 @@
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> @@ -434,7 +435,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                            TYPE_SIFIVE_U_PRCI);
>      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
>                            TYPE_SIFIVE_U_OTP);
> -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
>      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
>                            TYPE_CADENCE_GEM);
>  }
> @@ -453,6 +453,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
>      s->start_in_flash = value;
>  }
>
> +static void sifive_u_get_serial(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> +}
> +
> +static void sifive_u_set_serial(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> +}
> +
>  static void riscv_sifive_u_machine_instance_init(Object *obj)
>  {
>      SiFiveUState *s = RISCV_U_MACHINE(obj);
> @@ -464,11 +476,17 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
>                                      "Set on to tell QEMU's ROM to jump to " \
>                                      "flash. Otherwise QEMU will jump to DRAM",
>                                      NULL);
> +
> +    s->serial = OTP_SERIAL;
> +    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
> +                        sifive_u_set_serial, NULL, &s->serial, NULL);
> +    object_property_set_description(obj, "serial", "Board serial number", NULL);
>  }
>
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> +    SiFiveUState *us = RISCV_U_MACHINE(ms);
>      SiFiveUSoCState *s = RISCV_U_SOC(dev);
>      const struct MemmapEntry *memmap = sifive_u_memmap;
>      MemoryRegion *system_memory = get_system_memory();
> @@ -554,6 +572,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
>
> +    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", us->serial);
>      object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 82667b5..7cf742e 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -59,6 +59,7 @@ typedef struct SiFiveUState {
>      int fdt_size;
>
>      bool start_in_flash;
> +    uint32_t serial;
>  } SiFiveUState;
>
>  enum {

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks.  This is in the queue for the soft freeze.


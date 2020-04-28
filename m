Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E46C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8DD206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmd9u4b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8DD206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLIc-0003BS-Lc
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTLEb-0001eo-0f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTL6T-0004Oe-8Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:58:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTL0H-0000aX-KL; Tue, 28 Apr 2020 03:50:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id k1so23467347wrx.4;
 Tue, 28 Apr 2020 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YOAp7xg/NwCkIHFaf/WOoDd9Sy2z8sJnvl3QBX/Gj+4=;
 b=Gmd9u4b4pKCPffGZ9WetO+rKQNr3hsuplGxxoZusobYfn6esfshimOmZDitkxjr9Cg
 SGt8fFpWNBLz4VICdWzjdTTcxxa+2zodO6UV+5HjiPht5T2d/q26goqtfjHstErj2kvn
 qWd3KnroP5v9kXRGGTsPQfqfdva5+IQMkNS/z3SbAL5ssScucMui+5WXv2a6eVgvu2cq
 6xlAroU6MKFmad9kLVfnZuMOUBZH39L0KAB3PrwZqFOiD1q5FBpUamBZuWlTg81MrhWO
 4JyPb2y1NXHtDnP9gwiKuMpKIk3AUdVG6KMB8ISLEyzojAyblyO55CmMCJ/f2pQJolIG
 JLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YOAp7xg/NwCkIHFaf/WOoDd9Sy2z8sJnvl3QBX/Gj+4=;
 b=srFAK1YXDIWHdds7jaMXj1EzqDm6sotF7rK6dPHuHQSqeAeW8o38dwOBl5keWx19kp
 h03KWC/R6QM+NVqYA8sNlGiItF7NmZLPhSOPZhHVcLj4whDRJeDjuAi1YrmRX23SSAoh
 P3k9kCIPS3+JRpNYFNKI2blhIHX6Y+ZFvz7fIfividRLa9rQpdcXwsFuGaFfP4T7pQ/0
 LTFR3dXYMF6Dc+T0hh7gSzAuPbfo9h/EXusYRNiFeiYkNzsjIMOiBxTsS3oJ53RWenx2
 VvQKEP5G2n9wopNhEhY6ewIwB0JEprSU4HMyvrrBRs3TapWN/+7kMc/16nvPcAYyUaAO
 PKkQ==
X-Gm-Message-State: AGi0PubWapQYX7tlZi3gIGn4MjpMU5BoVNMLJ8QvnfT//8yEPQnw4+GT
 u67zcoDB1xKdKvZYyqlI4lo=
X-Google-Smtp-Source: APiQypLbP4s7VEipBodOuqgTFPTOeCi8zVUI+qyvPtQM6I+w1DWeniA7MpIKwNhGfwN0Ielv8nLAHA==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr31939290wrw.83.1588060203908; 
 Tue, 28 Apr 2020 00:50:03 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id q184sm2164128wma.25.2020.04.28.00.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:50:03 -0700 (PDT)
Subject: Re: [PATCH v1 07/11] hw/arm: versal: Embedd the APUs into the SoC type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-8-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <adc9d08b-ff74-7e15-dc55-b2ba5839c96e@amsat.org>
Date: Tue, 28 Apr 2020 09:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-8-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Embedd the APUs into the SoC type.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-versal-virt.c    |  4 ++--
>  hw/arm/xlnx-versal.c         | 19 +++++--------------
>  include/hw/arm/xlnx-versal.h |  2 +-
>  3 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 8a608074d1..d7be1ad494 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -469,9 +469,9 @@ static void versal_virt_init(MachineState *machine)
>      s->binfo.get_dtb = versal_virt_get_dtb;
>      s->binfo.modify_dtb = versal_virt_modify_dtb;
>      if (machine->kernel_filename) {
> -        arm_load_kernel(s->soc.fpd.apu.cpu[0], machine, &s->binfo);
> +        arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
>      } else {
> -        AddressSpace *as = arm_boot_address_space(s->soc.fpd.apu.cpu[0],
> +        AddressSpace *as = arm_boot_address_space(&s->soc.fpd.apu.cpu[0],
>                                                    &s->binfo);
>          /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
>           * Offset things by 4K.  */
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ebd2dc51be..c8a296e2e0 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -31,19 +31,11 @@ static void versal_create_apu_cpus(Versal *s)
>  
>      for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
>          Object *obj;
> -        char *name;
> -
> -        obj = object_new(XLNX_VERSAL_ACPU_TYPE);
> -        if (!obj) {
> -            error_report("Unable to create apu.cpu[%d] of type %s",
> -                         i, XLNX_VERSAL_ACPU_TYPE);
> -            exit(EXIT_FAILURE);
> -        }
> -
> -        name = g_strdup_printf("apu-cpu[%d]", i);
> -        object_property_add_child(OBJECT(s), name, obj, &error_fatal);
> -        g_free(name);
>  
> +        object_initialize_child(OBJECT(s), "apu-cpu[*]",
> +                                &s->fpd.apu.cpu[i], sizeof(s->fpd.apu.cpu[i]),
> +                                XLNX_VERSAL_ACPU_TYPE, &error_abort, NULL);

:)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        obj = OBJECT(&s->fpd.apu.cpu[i]);
>          object_property_set_int(obj, s->cfg.psci_conduit,
>                                  "psci-conduit", &error_abort);
>          if (i) {
> @@ -57,7 +49,6 @@ static void versal_create_apu_cpus(Versal *s)
>          object_property_set_link(obj, OBJECT(&s->fpd.apu.mr), "memory",
>                                   &error_abort);
>          object_property_set_bool(obj, true, "realized", &error_fatal);
> -        s->fpd.apu.cpu[i] = ARM_CPU(obj);
>      }
>  }
>  
> @@ -95,7 +86,7 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
>      }
>  
>      for (i = 0; i < nr_apu_cpus; i++) {
> -        DeviceState *cpudev = DEVICE(s->fpd.apu.cpu[i]);
> +        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
>          int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
>          qemu_irq maint_irq;
>          int ti;
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 94b7826fd4..426b66449d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -36,7 +36,7 @@ typedef struct Versal {
>      struct {
>          struct {
>              MemoryRegion mr;
> -            ARMCPU *cpu[XLNX_VERSAL_NR_ACPUS];
> +            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
>              GICv3State gic;
>          } apu;
>      } fpd;
> 


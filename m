Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA13FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A1920714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAcapgHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A1920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk4q-0001xd-PW
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGk1y-0007WF-OX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGk1x-0003nR-BX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:55:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGk1x-0003js-6B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585058144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDBWVbCfHDnELXfLrlEIuiDFenDqPtLPfcawa9U4/PU=;
 b=OAcapgHwuhMfqbDp+EjY+cLqf8rUi6XhWudTnCGeft26a1D1cicFSPBq7jrkKEYMF/uuYh
 2A4wmdcyT+h/EsxdES9qaWIno92Y1rJ6GGY8fsha+/rq6a3y87E7gVD24Sd7hkoQ8gu9+G
 fBHU/Qjg+ZtdtpaERt5CAlLLi3XWVms=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-XhZmhhrEOIiB-rAmknM3yQ-1; Tue, 24 Mar 2020 09:55:43 -0400
X-MC-Unique: XhZmhhrEOIiB-rAmknM3yQ-1
Received: by mail-ed1-f72.google.com with SMTP id c2so14858879edx.16
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QDBWVbCfHDnELXfLrlEIuiDFenDqPtLPfcawa9U4/PU=;
 b=bQSCPy3ZBZPaEPwNhscwYJHJb2Yend7nCBmB1Pqdk07Rg0OWR+U8KwyO/Enyrw4WCZ
 IK1l7ZpkV9E6M6aPmAVxSKvJ/rV1RT05iFo1iJEy75p2XSQlS3/UDN4WCQcK74dX4L1G
 aan/U15isGq+bbXGB6VoYt0b/F7ocrWDnlMqOsVJZe9ZXXUDNaYjnPw5rjHdo3RspK/q
 Kv7VhMRuxplgoRia3/qRaejn7lL0PGsZ9EAPcEdYDoabQTdV379W1/U5DxPgYycdjHM0
 UCUvCjYCVFNZTM8qoDoSU6hho4Ob2/paayHD+/byEF7huC4Il0ldKhS/4i5vE01dXmVl
 GW0Q==
X-Gm-Message-State: ANhLgQ0SqKXHqNkhpAokEmNRuvQzST9bdM9w32DxoDHd+ZoMTPCcReKr
 nj/04gxwkJJPpqApNkAkN3DMrvGAuYVMDZQGaPqxUmMCiAuF2b+KZSGY0TyrlDJ4BXwTvozaKUc
 8bg3CNrto7N6p1Eg=
X-Received: by 2002:aa7:dc06:: with SMTP id b6mr27414500edu.371.1585058142114; 
 Tue, 24 Mar 2020 06:55:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvT8BWpceGhdwXqe3AvSgcPT8NwZQ7MqQdTiO3ykQ0ISSxPb0/vbtjpuPiiRCuXhy9sTFOFzA==
X-Received: by 2002:aa7:dc06:: with SMTP id b6mr27414478edu.371.1585058141909; 
 Tue, 24 Mar 2020 06:55:41 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id g21sm1086266eds.38.2020.03.24.06.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:55:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/xlnx-zynqmp.c: Add missing error-propagation
 code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200324134947.15384-1-peter.maydell@linaro.org>
 <20200324134947.15384-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fe33505-e289-f401-bc52-cfdc9715354d@redhat.com>
Date: Tue, 24 Mar 2020 14:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324134947.15384-3-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 2:49 PM, Peter Maydell wrote:
> In some places in xlnx_zynqmp_realize() we were putting an
> error into our local Error*, but forgetting to check for
> failure and pass it back to the caller. Add the missing code.

This (incorrect) pattern is used in many places, so it might be easier 
to fix it once with a Coccinelle script...


i.e. a quick "git grep -3 object_property_set_uint":

hw/arm/bcm2835_peripherals.c:290
hw/arm/fsl-imx25.c:272
hw/arm/fsl-imx6.c:349
hw/i386/x86.c:110
hw/microblaze/xlnx-zynqmp-pmu.c:88
target/i386/cpu.c:5158

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Spotted while I was writing the previous patch.
> ---
>   hw/arm/xlnx-zynqmp.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index a13dbeeacec..b84d153d56a 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -530,8 +530,20 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>            * - eMMC Specification Version 4.51
>            */
>           object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>           object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>           object_property_set_uint(sdhci, UHS_I, "uhs", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>           object_property_set_bool(sdhci, true, "realized", &err);
>           if (err) {
>               error_propagate(errp, err);
> @@ -551,6 +563,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>           gchar *bus_name;
>   
>           object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>   
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
> @@ -565,6 +581,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       }
>   
>       object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi), 0, gic_spi[QSPI_IRQ]);
> @@ -619,6 +639,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>   
>       for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
>           object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>           object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
>           if (err) {
>               error_propagate(errp, err);
> 



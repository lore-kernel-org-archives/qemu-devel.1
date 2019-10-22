Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3B42075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu1J5mgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3B42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMy5w-00081t-H2
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMy5C-0007Ts-S2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMy5B-0001Rr-Nk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:36:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMy5B-0001RY-Jv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571765793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njvDPZmR9dAOTk7xcxUiwi+QN8u9RtbSx+C/NzEYklk=;
 b=Lu1J5mgioEpvwawnym4I+UakpIm6ggA9r+lJOWwh4fbsLqBERud0Qmz/bf5ihxYeqjwZQ+
 BSJYENZKyFx2ofGY1AyaMSw32+xX4XykXhcLltXrdFHUv7ZL1Xx5A/uWP7M+DD4KwLs3KD
 xfqvdGTpFsrOB6TWYSdCGf3QLXD52C8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-g4MmtLDDOMWFmiDgcBG9og-1; Tue, 22 Oct 2019 13:36:29 -0400
Received: by mail-wm1-f72.google.com with SMTP id o8so7804344wmc.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SqG/NGKXWX5u1rAz22J+hGb7pyFeNq29aXc9Mor0Zi4=;
 b=gXklLr1hYT3oV1/hli512hzEy3aedTTxK3ofJfExBhEyi08aBjT9KPIfEBFCUU70QV
 xGwvkd9dp7+sG2Db0HHbJcwdEJI/Oa9AIe0g1ZR1BiGe7JvVE9DIzTjhff1DcxuPsHM+
 NbUuy3ckSOVyQpVCLXHgDp5SdyyLo8/OGlunx34Zs/4+HmAbZieNYUy6itfBxr/S5Iaw
 wRB52hCGS95JQhdtack4WTbVGR4wB6llYO8GAYzXVOH7BN9+OJbbpBYEIYfafO0+eRi9
 9cjyN2iA3vEvhNae38TubJm+4PpwSMOsEPjLXqGeN6O13PsEvYTUnz/1FCwKxANR0feK
 8n9A==
X-Gm-Message-State: APjAAAWXr7NeYwlacX6sl6kMXtFgo+XFYsFVHNSxvAQgd/4FKe9Pvyw3
 bz5a0zFg/bOzNwqqqFvVnbBWgotw89BkEZxtXO14qS8Jppr5sncyDvtAQJFCxIaYgOW/03YYPVx
 WXvZ4CS5ePamM/Kc=
X-Received: by 2002:a1c:7414:: with SMTP id p20mr2328574wmc.175.1571765788417; 
 Tue, 22 Oct 2019 10:36:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzOugBPjseiho/o4f+8u2HW9IKGvr0e6uI8Mt2+XsYqdH0TP/mDI7cVMyKNKYyTbTC8pjDkJQ==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr2328557wmc.175.1571765788149; 
 Tue, 22 Oct 2019 10:36:28 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p10sm20997816wrx.2.2019.10.22.10.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 10:36:27 -0700 (PDT)
Subject: Re: [PATCH 3/5] aspeed: Add a DRAM memory region at the SoC level
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <01328c05-0f16-c53c-19b1-825d3b910dcf@redhat.com>
Date: Tue, 22 Oct 2019 19:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016085035.12136-4-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: g4MmtLDDOMWFmiDgcBG9og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 10:50 AM, C=C3=A9dric Le Goater wrote:
> Currently, we link the DRAM memory region to the FMC model (for DMAs)
> through a property alias at the SoC level. The I2C model will need a
> similar region for DMA support, add a DRAM region property at the SoC
> level for both model to use.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   include/hw/arm/aspeed_soc.h | 1 +
>   hw/arm/aspeed_ast2600.c     | 7 +++++--
>   hw/arm/aspeed_soc.c         | 9 +++++++--
>   3 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index cccb684a19bb..3375ef91607f 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -40,6 +40,7 @@ typedef struct AspeedSoCState {
>       ARMCPU cpu[ASPEED_CPUS_NUM];
>       uint32_t num_cpus;
>       A15MPPrivState     a7mpcore;
> +    MemoryRegion *dram_mr;
>       MemoryRegion sram;
>       AspeedVICState vic;
>       AspeedRtcState rtc;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931887ac681f..a403c2aae067 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -158,8 +158,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                             typename);
>       object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
>                                 &error_abort);
> -    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
> -                              &error_abort);
>  =20
>       for (i =3D 0; i < sc->spis_num; i++) {
>           snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, =
socname);
> @@ -362,6 +360,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
>       }
>  =20
>       /* FMC, The number of CS is set at the board level */
> +    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram"=
, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
>                               "sdram-base", &err);
>       if (err) {
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index f4fe243458fd..dd1ee0e3336d 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -175,8 +175,6 @@ static void aspeed_soc_init(Object *obj)
>                             typename);
>       object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
>                                 &error_abort);
> -    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
> -                              &error_abort);
>  =20
>       for (i =3D 0; i < sc->spis_num; i++) {
>           snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, =
socname);
> @@ -323,6 +321,11 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
>                          aspeed_soc_get_irq(s, ASPEED_I2C));
>  =20
>       /* FMC, The number of CS is set at the board level */
> +    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram"=
, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
>                               "sdram-base", &err);
>       if (err) {
> @@ -429,6 +432,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
>   }
>   static Property aspeed_soc_properties[] =3D {
>       DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
> +    DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION=
,
> +                     MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



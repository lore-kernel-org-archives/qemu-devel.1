Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF6C54FD2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B60D206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGiqX1lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B60D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjyx-0005MO-CI
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjxu-00040i-Je
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjxt-00047s-KZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:51:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjxt-000477-HQ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585057893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQ3BrcZcRe869MGEG3mEya/2DITKXWpltX6Obh6z5Y8=;
 b=WGiqX1lV7ONJtvEjoDk5bTaANGPrnCVLkcbIVab02zV3WEHVp/7n0Bcnzn473W02BpDysE
 l27RGqVqwxZ6O7DpH3GVZftMZvJK5tRmqTu3yMbLk+WAYYmkkG0y6Mn+rQiuS/PZ61WPik
 /HaA0jNMHskqyM0GLowBnTdEBkyOERc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-_ksLKr7kP-O3OMFPT_0qdw-1; Tue, 24 Mar 2020 09:51:31 -0400
X-MC-Unique: _ksLKr7kP-O3OMFPT_0qdw-1
Received: by mail-ed1-f70.google.com with SMTP id y10so14776585edw.23
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ckcfv+Xe3KOmGeQUVgWcTejMqOCF+il2FG+fbbla1sE=;
 b=q1LfL6PHsUqZKuzCWlHYARMzBLCDe74KrGBJHbMvo41QMco0YJDARwlPjzNW+B9Gbr
 r0udf51hq1X5FSa2OX7/vW6AM4Z8GP6FCa3PLr+3OlayveHOyxXyKSm0QyaJj6zn05wG
 yF1MnC23AXF9a1M8mwOb+iCmfYKmSAG/IQkxLWAAsqbRKXfYV+0OorNUtxBdP0OfDvFz
 EUbFCEO9pUBX/tzt2B5+1ge2VjB2wAUjTBEQge2/vQYZZJYPtIqueE4GMBcbPpDZZRg3
 hKKR/FWGPiDadfUBvB0rbiFg9kQ8bqmmGuS7vNgrwmF5llzIkRoH4elDbdzmBWNxw5m0
 vrlA==
X-Gm-Message-State: ANhLgQ1b7lNns9BcXeSzL/SL3dOiJVD8QEcE2kgLm7D8jLtVj8psBlgc
 r1xWxi8epuP7xcGScjhsPEJ5pajS/l8I6BCntV5yRmOJmInNnowQ7fFQS7tyaxtwUWPto1t57Sf
 1sFaT5DR0o4E0N90=
X-Received: by 2002:a17:906:4e12:: with SMTP id
 z18mr5854495eju.49.1585057890165; 
 Tue, 24 Mar 2020 06:51:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vspO85eeWJFGvSmvkOrJq3jqeFnhInco7xDVxTLuqwHq+8iavIMsRX77WEfyx4iJtd6BO9AKg==
X-Received: by 2002:a17:906:4e12:: with SMTP id
 z18mr5854481eju.49.1585057889833; 
 Tue, 24 Mar 2020 06:51:29 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id w20sm129122ejv.40.2020.03.24.06.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:51:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/arm/xlnx-zynqmp.c: Avoid memory leak in
 error-return path
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200324134947.15384-1-peter.maydell@linaro.org>
 <20200324134947.15384-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6451c169-3d1e-0106-42d6-95b2f5d69fd9@redhat.com>
Date: Tue, 24 Mar 2020 14:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324134947.15384-2-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 2:49 PM, Peter Maydell wrote:
> In xlnx_zynqmp_realize() if the attempt to realize the SD
> controller object fails then the error-return path will leak
> the 'bus_name' string. Fix this by deferring the allocation
> until after the realize has succeeded.
>=20
> Fixes: Coverity CID 1421911
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/xlnx-zynqmp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 49f1c8d0de2..a13dbeeacec 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -520,7 +520,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, gic_spi[SATA_INTR])=
;
>  =20
>       for (i =3D 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> -        char *bus_name =3D g_strdup_printf("sd-bus%d", i);
> +        char *bus_name;
>           SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->sdhci[i]);
>           Object *sdhci =3D OBJECT(&s->sdhci[i]);
>  =20
> @@ -541,6 +541,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>           sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
>  =20
>           /* Alias controller SD bus to the SoC itself */
> +        bus_name =3D g_strdup_printf("sd-bus%d", i);
>           object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
>                                     &error_abort);
>           g_free(bus_name);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



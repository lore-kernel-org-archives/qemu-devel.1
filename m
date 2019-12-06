Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B47C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4166B24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB5Icu99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4166B24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFWg-0005V8-US
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEkU-0008C8-7H
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEkR-0000Rh-Hd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:38:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEkQ-0000QO-Ud
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHE5pKBjPC9Eo13xA2DcLlnFPwJB9Iij33iqVbGoCik=;
 b=ZB5Icu99DcYVqpOToyKeS4VKGJww++sYOuoVytFXTlWZiWTuLwNSGhNvMssq+yNnFPyFix
 rwP50HcNnoPa7zp2fHvbvnQaB44TkloZ7QVR++axuqS5jJWpDKuJUL1flGUfU/cynOlt8k
 YnhBfjF3JLjOaa7McffhFFhuE1um+iI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-fPj-Odp2Oxi-lKAkAnHExA-1; Fri, 06 Dec 2019 02:36:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id c17so2750268wrp.10
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9YGfdoTEKQ4MSGhnrEsiqiotLGiTcUEsor7pwLNTxYA=;
 b=knxuMzmAY82ALZrfFn6ImhPAbcEo9AmWXnlrFsZPJ240qmQ0ZI4TXXp098fqT2x9UZ
 I8kUSmWEQX30ShV8aYTWi6n8RZCQ5AlaXKyj3Dp5GE9X46fLs2Ch4QNZSBl4VejD+54E
 i8+RNc2edeC1CwFGZZ6GMNMnBOaTeBdTJ/G9C7Q6KZTQ8AxwiVr2jRVF6pKNudz521pX
 uYBskW/FNNSaiQCf1jfIxYZHJumQKvrNCkbY25U4S5VxVNJnJOKyd7YAIU3WjSRZis7j
 2J+b3TAeZjzLoD6Dnq/D3gQ9mzAqMc+n55qiBTPFza9d1g+hzOonQyMGqBYuuOqjFVSy
 EpWw==
X-Gm-Message-State: APjAAAW+V+cBaBH4uVZw9VRxGkhkAGXJG/HubFQC5eWE2XN4Ui61ptoT
 OSfeu2dkYramoAF/RbfRL8B+XwxVAuRX+D49FO+dyoaYeCfBcioGBEjWZuvYcwGBf77a1c6x3yY
 588Zy/Qxj8WSd5qg=
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr14755613wrr.73.1575617797434; 
 Thu, 05 Dec 2019 23:36:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRz5F/mACRurL1XXdGqt4gxtMiHzHf9x/f5woKvUF8n6ZOLZDO5zQwTaobzqorqhFaejrgtA==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr14755585wrr.73.1575617797123; 
 Thu, 05 Dec 2019 23:36:37 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l26sm2474711wmj.48.2019.12.05.23.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:36:36 -0800 (PST)
Subject: Re: [PATCH v8 11/21] hw/i386/amd_iommu: rename Error ** parameter to
 more common errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-12-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1a1c80fb-63d5-d03b-c9d2-0cd1ed13f697@redhat.com>
Date: Fri, 6 Dec 2019 08:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-12-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: fPj-Odp2Oxi-lKAkAnHExA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: armbru@redhat.com, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/i386/amd_iommu.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index d55dbf07fc..b1175e52c7 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1533,7 +1533,7 @@ static void amdvi_reset(DeviceState *dev)
>       amdvi_init(s);
>   }
>  =20
> -static void amdvi_realize(DeviceState *dev, Error **err)
> +static void amdvi_realize(DeviceState *dev, Error **errp)
>   {
>       int ret =3D 0;
>       AMDVIState *s =3D AMD_IOMMU_DEVICE(dev);
> @@ -1549,21 +1549,21 @@ static void amdvi_realize(DeviceState *dev, Error=
 **err)
>       /* This device should take care of IOMMU PCI properties */
>       x86_iommu->type =3D TYPE_AMD;
>       qdev_set_parent_bus(DEVICE(&s->pci), &bus->qbus);
> -    object_property_set_bool(OBJECT(&s->pci), true, "realized", err);
> +    object_property_set_bool(OBJECT(&s->pci), true, "realized", errp);
>       ret =3D pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
> -                                         AMDVI_CAPAB_SIZE, err);
> +                                         AMDVI_CAPAB_SIZE, errp);
>       if (ret < 0) {
>           return;
>       }
>       s->capab_offset =3D ret;
>  =20
>       ret =3D pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0,
> -                             AMDVI_CAPAB_REG_SIZE, err);
> +                             AMDVI_CAPAB_REG_SIZE, errp);
>       if (ret < 0) {
>           return;
>       }
>       ret =3D pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0,
> -                             AMDVI_CAPAB_REG_SIZE, err);
> +                             AMDVI_CAPAB_REG_SIZE, errp);
>       if (ret < 0) {
>           return;
>       }
> @@ -1578,8 +1578,8 @@ static void amdvi_realize(DeviceState *dev, Error *=
*err)
>       sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
>       sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
>       pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
> -    s->devid =3D object_property_get_int(OBJECT(&s->pci), "addr", err);
> -    msi_init(&s->pci.dev, 0, 1, true, false, err);
> +    s->devid =3D object_property_get_int(OBJECT(&s->pci), "addr", errp);
> +    msi_init(&s->pci.dev, 0, 1, true, false, errp);
>       amdvi_init(s);
>   }
>  =20
>=20



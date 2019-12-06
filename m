Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EEC2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDABWr2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EEC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFzm-0006pi-DQ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEn9-0002Xm-9v
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEn8-0004AY-2u
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:41:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEn5-00046c-Rm
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SibZHbFF4fRgmeN5OPmw1waFQWRzZtqpvgt28e8/N3Q=;
 b=ZDABWr2rnnkNPnfnhI9gz2+NKaH2kP7t7QMtxjn597RE4iwFl2DOsU2iI6z0YgV0TPsiaF
 EgPs+QZaFJ9A43O+sfWSNuK4Nb1vhuRAIv0RX6j0Sp3VYHKXV4Q8qq8HaDwEpCeSEigS3+
 i4PJDJaLPyXJqCJqQBQDBAQwEkq1sEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-52mL24OMMKGsLvqpCyPEbA-1; Fri, 06 Dec 2019 02:38:05 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so2776017wru.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jv2/zsfesa2xmWFIePTHxsgoH0QMxvRzKKBdPdDYQs0=;
 b=FzHPk1Zx19G/DLS5UjP85T+ZdNDpzGjZqCCMyzKDxCl4xTghkhQjMw5JFM8fBP4QVZ
 WyTw8HHu9IWX/ZBGMrHx4v/LajDRZkv+4pro3YUK8YOPy803mCe6UuLT0LEH5BwkjqbW
 LR4SzrkeEc4Qz7wsE2TeU0O5NkzehJZTFkUtLM7nPwy5Z7NBYhfoQ3OXqLNCfH1/J43u
 bpPMo/kb6ZkAC1YY5wjtG8mpQlOIu6u5DtfcdfExRiXD9KrxT2WhiB6dAVtVcGK1GziQ
 nTFDZLhMhFts8zx6r84Y9DqumC9WGjSpte8ZHrXjdVh2ONKXtIAibwLRGLDl8/agdrFZ
 xnDA==
X-Gm-Message-State: APjAAAWFy8htQVFg7MotVdWNZ869aZab4IThYjbcXoaiA/oEigbtooHO
 Gqto0LFvENnC0diBVBskYbA5u1CIhf9R6fvoQmuIDXN9Z5cQ1Ei6L+k3IFO1XVIEXMYbYMwVEU4
 xXBETd05sW+xnlnQ=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr8823177wmh.5.1575617883842;
 Thu, 05 Dec 2019 23:38:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEUjtFl6NI+Lu1ZIVaIBswLn11fMpy6pnvMkvOyTBCiOHTPbjxc6+F3/KPtDe9twFVCc3DjQ==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr8823166wmh.5.1575617883678;
 Thu, 05 Dec 2019 23:38:03 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id e16sm15450790wrj.80.2019.12.05.23.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:38:03 -0800 (PST)
Subject: Re: [PATCH v8 15/21] hw/sd: drop extra whitespace in
 sdhci_sysbus_realize() header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-16-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d49a86d6-2af5-a956-7511-6de0ff04a072@redhat.com>
Date: Fri, 6 Dec 2019 08:38:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-16-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: 52mL24OMMKGsLvqpCyPEbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/sd/sdhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 88404d0e9d..18c0c052ce 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1459,7 +1459,7 @@ static void sdhci_sysbus_finalize(Object *obj)
>       sdhci_uninitfn(s);
>   }
>  =20
> -static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
> +static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
>   {
>       SDHCIState *s =3D SYSBUS_SDHCI(dev);
>       SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>=20



Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB8C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65AB2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8TyOIjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65AB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFtR-00074t-Ap
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEmG-0001pm-3s
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEmE-00035e-OG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:40:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEmE-000344-Fu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Boahr/sfSBA3a5P4fmAwvok+mVLxcoMrYfoTb05BH8=;
 b=O8TyOIjOUecFzgVx9w7fGD5nYnUg/jzDjzJ6u0+Rhc9HPiVuRR1LB7IC2ZFDJtFkFxXjC2
 SvVxDVXplHmkslfIBLW17EKEeABa0EJVo+u/O/4ABJhGkuo/lsbF3jlx/kpGtd1vVR+9Jt
 3wyy8n04yfteu8/2+UEKNDaABDZQjr8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-wPhphu9EP2qjl2-aWBOhLQ-1; Fri, 06 Dec 2019 02:38:39 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so1799214wma.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hwQ0ggcKlNb+kIUwNY97aTK3QosuOK9Y4cZvJtIEH/A=;
 b=GLAr+Q1Z/IxRG6pnzTKW84Bvadm18KTE6jfTfGmteyF0vHncUbFdcpcm566U7/ZLxj
 JuR0ewva2PCWcCMAUwyT10tn0uicyQMVPZLJ0sT2Y+zOl+FIiaE7+r5/rLkVA2ID14dE
 VSZD2Dvo9TTEBrHiD933+28LfXlMbhdO1x2PcjnbVy8i02Ub3J3T20PA8kOn4hjXKEMq
 wpJm1rP+dMk+Mcj+WtC69MFohOBiXcbcrf1tZHiVU0HZXOn29FIDlF/aa6dfRhAWu/os
 nD7DF5X6p4KZsuDd9ITz5ibrcpbK0j3o+rBIitToTlgUOIxNomNH4INjxXzNK1ecNh1K
 hYaA==
X-Gm-Message-State: APjAAAW5y2D47mEAngYEFSgIwBBq1MScwAxGI55sGezROxn3RWuO9m2B
 7L7tiUC9Rvo0ReLeiW1OW9f329fRMAcrw9H1FaxWN/8hZxTgOl4tri5oI3/fqGZQ17p3tCtcD2+
 usUf4G/wb41/i2kw=
X-Received: by 2002:a1c:9ec6:: with SMTP id h189mr2488324wme.28.1575617918172; 
 Thu, 05 Dec 2019 23:38:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFHO2fc0yYL1moFY1Mb4p2QSnfwyzuipPOI4X2k19Gj14utrvBzMdc52dmhW4iZSv6b+qehA==
X-Received: by 2002:a1c:9ec6:: with SMTP id h189mr2488308wme.28.1575617917998; 
 Thu, 05 Dec 2019 23:38:37 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x132sm4266224wmg.0.2019.12.05.23.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:38:37 -0800 (PST)
Subject: Re: [PATCH v8 17/21] hw/usb: rename Error ** parameter to more common
 errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-18-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1407847e-1e1d-9ecb-a522-103a09179f02@redhat.com>
Date: Fri, 6 Dec 2019 08:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-18-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: wPhphu9EP2qjl2-aWBOhLQ-1
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
Cc: armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   hw/usb/dev-network.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
> index 5de6213cc4..b81a8abe83 100644
> --- a/hw/usb/dev-network.c
> +++ b/hw/usb/dev-network.c
> @@ -1342,7 +1342,7 @@ static NetClientInfo net_usbnet_info =3D {
>       .cleanup =3D usbnet_cleanup,
>   };
>  =20
> -static void usb_net_realize(USBDevice *dev, Error **errrp)

Funny one.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +static void usb_net_realize(USBDevice *dev, Error **errp)
>   {
>       USBNetState *s =3D USB_NET(dev);
>  =20
>=20



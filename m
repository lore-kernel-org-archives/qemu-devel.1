Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C2CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1498821739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHcI5E+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1498821739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMMI-0002ju-6t
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaLBc-0006r5-P1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaLBV-0002sN-8c
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:54:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaLBU-0002SC-Ph
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574952855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHV1Eyf8uC3LYSu2U8Zq/CxZWGGQvWuQ1uaFhUtf0BA=;
 b=SHcI5E+UDL46uSO0E7o+xTEUDazI2FMPak6nnJ9k9RgxxXP24l2xy1aO/ilGczmSwVkvRU
 2pcz7r/W9L1mpVolTwKk3iXkjmvA3MRg+g0hSLEMbal9AWWjp9Tb46ymNbFy386qx7RKf5
 2kIfBcmme3Esy8wNe0mDS71buqY49ME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-O3MjHpYgPA-NsRudOOLeyg-1; Thu, 28 Nov 2019 09:54:14 -0500
Received: by mail-wm1-f72.google.com with SMTP id n18so3246802wmi.8
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 06:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p3E/8222RacGj97HRp98RDwGuYZify7STc5zCtCPmlA=;
 b=kP+BKdWB5Z5wY4WzS8tgRSdKd284jPzUSbKF/2x2Q55xw3jexOsUVfX7k1nFOeSh9o
 D+K0wbrdMOmuxPegwhcca1SgCrAWd1T1+Xz6BY12aCaFAleVOgrSqEXsldqiWl0XWLrq
 qCWCGKy9N40TP8NEMkfeVy7FilLXgp0rUOQu3nR98LyFoIa0pT+ItzJyCe6JYz+4IALZ
 xauLAfBICICp9o2mYToT+/1ha1mm4BlJvbL3IaA+bfCZ4tWTKdra8/rfBHfzW+QbkBNc
 ufxisYSeUscYUDpYUdYPFN2bxI/1thkjEqoYMygTEUg9T9Jrt3gu7AT3V/pYFb1PDcrd
 IohA==
X-Gm-Message-State: APjAAAU6BhSTb01KseOCgKXvgbY4b7UnVOQ36zGqlCqwQhF9YsXJpTWb
 vfzK6V33fz9KsGVoHI9EetSJHKWxRfaO+jdxw89bvFbFa3FY+w3o/SV1Rrwh4dfbVDERX0eRw17
 8qZPba1nl9qpcDLc=
X-Received: by 2002:a05:600c:2049:: with SMTP id
 p9mr9991235wmg.128.1574952853043; 
 Thu, 28 Nov 2019 06:54:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCKb/aNTSW2ihQ+T777nqsOYp6qTkaYQMxiBlXU7Z4sX3nKr7CirYN4GyG4/ya3fezDQCLKw==
X-Received: by 2002:a05:600c:2049:: with SMTP id
 p9mr9991217wmg.128.1574952852855; 
 Thu, 28 Nov 2019 06:54:12 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id y6sm23896220wrn.21.2019.11.28.06.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 06:54:12 -0800 (PST)
Subject: Re: [PATCH] vfio-ccw: Fix error message
To: Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-s390x@nongnu.org,
 cohuck@redhat.com, alex.williamson@redhat.com, farman@linux.ibm.com
References: <20191128143015.5231-1-fiuczy@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d285275-5964-2415-e52e-1b60397d2918@redhat.com>
Date: Thu, 28 Nov 2019 15:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128143015.5231-1-fiuczy@linux.ibm.com>
Content-Language: en-US
X-MC-Unique: O3MjHpYgPA-NsRudOOLeyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 3:30 PM, Boris Fiuczynski wrote:
> Signed-off-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/vfio/ccw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6863f6c69f..3b5520ae75 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -102,7 +102,7 @@ again:
>           if (errno =3D=3D EAGAIN) {
>               goto again;
>           }
> -        error_report("vfio-ccw: wirte I/O region failed with errno=3D%d"=
, errno);
> +        error_report("vfio-ccw: write I/O region failed with errno=3D%d"=
, errno);
>           ret =3D -errno;
>       } else {
>           ret =3D region->ret_code;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>



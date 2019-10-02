Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E78C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D9C21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4EB46rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D9C21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFd3x-00067W-Tb
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFcth-0003xu-TA
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFctg-0001iA-Sb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:34:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFctg-0001hS-PM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570016060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDxfLU4a4TfnY9kotfqPFmMmpyRglq2SiDTPTJe8QF4=;
 b=N4EB46rqIss19kouKc+N59+ki+PMdqZlewDl0WDjXbj5TMklcp9B2VHaFj22ohudGCCc0Z
 rLSUDmicD2PrmdeUsg+zwndEPn/s4qhJJuYvUAKR5UKEj/JiLgtCz2hhfpH/CqDkjHrcaq
 2uvrYuvyOl3N7q2yDru56VpAPztsewY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Gha7H-VLPtCElixuv2OwkQ-1; Wed, 02 Oct 2019 07:34:18 -0400
Received: by mail-wm1-f72.google.com with SMTP id q9so2863233wmj.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 04:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+2al4v1H04rUqJmXHpoc2GvF1Cdm1E8ZarmRdDHa7Y8=;
 b=CgsfvbHxHHjzQwR+MIAzFoLcusp6Upi3WfimVfWnLjco3FxynadLjlrY0JUf50t2t+
 L8HMSC4hemddj74mYvj7aE+rhdQPJ+5o43moNXtX1P4zHXKt9tpCcSR+hGDtqDJOs2PC
 42nKKH4HpA1pBg9kkXLHfOtc8plCpYxepMqA37d2GOetyzE4jsNpS6dUwAgar4b1w6S3
 4JB83/jT7e0EBvDRJ9AcdZH+ZrF5ABjWt4ZaJVz7WjWMF4J+sd2ddG+GRRy6Is2eVn1t
 j8d7Bl3I8lOFvxJqmZs/Oc9NwMzwscQU2dFv5+en4hvhcswCbvaItGjHBqRQCPF49TSi
 KFOQ==
X-Gm-Message-State: APjAAAUp55f905BFMEVttvy5WwULZtV0HAeMXrEBlWpKRzIaoXZaM//H
 XMFIMMaukXY+rW53TVHdZRADvfV0zQ7h3MFCquvUdM8zxGglo338RqsKS4+efITYcZDQY2InC2i
 yZXPAxT9bhw8ts2c=
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr2446826wmj.57.1570016057142; 
 Wed, 02 Oct 2019 04:34:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5OgkDuooyzwzi21EOuoxRqxdhq8Co4mpM4371GHmwlO47OTRnNJIj61HPtkqCLB+zkCDOMw==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr2446809wmj.57.1570016056971; 
 Wed, 02 Oct 2019 04:34:16 -0700 (PDT)
Received: from [10.201.33.15] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id b184sm6078559wmg.47.2019.10.02.04.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 04:34:16 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 04/19] hw/core: Declare device little or big
 endian
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566829168.git.tony.nguyen@bt.com>
 <5f28bb686a0c4e339bcff2df63492a1aee509c1c.1566829168.git.tony.nguyen@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9d318256-d859-83c1-fc85-23f22847a368@redhat.com>
Date: Wed, 2 Oct 2019 13:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5f28bb686a0c4e339bcff2df63492a1aee509c1c.1566829168.git.tony.nguyen@bt.com>
Content-Language: en-US
X-MC-Unique: Gha7H-VLPtCElixuv2OwkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 4:21 PM, Tony Nguyen wrote:
> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
>=20
> If the set of targets are all little or all big endian, re-declare
> as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.
>=20
> Then, on inspection:
> - if ununsed, re-declare as DEVICE_HOST_ENDIAN.

In all the series: 'ununsed' -> 'unused'


> - if max/min size=3D1, re-declare as DEVICE_HOST_ENDIAN.
> - if just a bit bucket, re-delcare as DEVICE_HOST_ENDIAN

In all the series: 're-delcare' -> 're-declare'

> - if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>   hw/core/empty_slot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
> index 3ba450e1ca..2785b6acf9 100644
> --- a/hw/core/empty_slot.c
> +++ b/hw/core/empty_slot.c
> @@ -49,7 +49,7 @@ static void empty_slot_write(void *opaque, hwaddr addr,
>   static const MemoryRegionOps empty_slot_ops =3D {
>       .read =3D empty_slot_read,
>       .write =3D empty_slot_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_HOST_ENDIAN,

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   };
>  =20
>   void empty_slot_init(hwaddr addr, uint64_t slot_size)
>=20



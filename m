Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE6C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6AE21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PekFU5T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6AE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkv8-0002Rn-7c
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifktZ-0001Nm-Og
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifktY-0007je-4l
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:22:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifktY-0007ie-0E
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576243331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jgspVajfgjE42ZvZQfn/amiK0x8QorJMMvgrfevHDE=;
 b=PekFU5T9/j6OhBJgSohsS3m+K9HmC5+aLgP2wRsylXEZs3VcqlzSmHkWVZM9362nYsm4Lf
 3h8lDvVS9YFMAa5xSImGKOOe8VDvBZcCrvMbzhMZH8hvIzkUZpANqNngdaXUgBA1RtqZ5R
 5pZEDGvkBA06QiPYkcw1B9SUthpolYY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-nI_HTVw2PcKznDOqT0uJeg-1; Fri, 13 Dec 2019 08:22:10 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so2555203wrm.17
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 05:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VY/4rF+g3Stxjk2j0HlkvEIE4fBT/7Xv9T82Gu/sONg=;
 b=Nu9FIVTjmzDZ82l60uaG94b8r5pnxocYY+xSI2h0B/RyRFnkGA0bCGbBfPTLLCR1SJ
 XwJ/nGAgouZJwFnpSwjNm/+D9JKyHU5epc/6RxyM36l+xTZzbnR+geBV3F09kmCCQHvp
 Is5z6Kq8qfslzNOAhI06qYxFqkQQvBatliiBdNJm24V64+yC8B8MRpP/LeHbBqCZ2Ihl
 6M4XccXiUB1L2cvN1LEog7BL08k2Vlk62nN488nHMxVIvx5ZyXpZDKD86xUPs4cPQNxI
 i9ULiVT2Dg2Ekc8AIB06sTXCFOY6h1vGfcJunaiberO+iqdoaDQz7cdxyYJo2JAzsPnN
 uchA==
X-Gm-Message-State: APjAAAUNdmvmTQHc0i3l9jCCmWqK3olijHgYs2W/wtgJMUCFAzDFgmND
 L7TKsCeLbHrFfO00D37T/CAHpuMQqtKoaDRihUBi/m+Qis3FmQXBdC+k0ByWo7NKn1nySMT+wMs
 WQN3hGAKPLxarvzU=
X-Received: by 2002:a1c:6585:: with SMTP id
 z127mr13324476wmb.113.1576243329175; 
 Fri, 13 Dec 2019 05:22:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrPpDti4gPsctX5koB9VTm1Tquxj03KYjvJPGJQKBSDmkVKjKjnaXIWDgcfvBIr4GAcm2yzA==
X-Received: by 2002:a1c:6585:: with SMTP id
 z127mr13324458wmb.113.1576243328984; 
 Fri, 13 Dec 2019 05:22:08 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c9sm9823992wmc.47.2019.12.13.05.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 05:22:08 -0800 (PST)
Subject: Re: [PATCH] hw/isa/isa-bus: Use ISA_NUM_IRQS instead of magic number
To: qemu-devel@nongnu.org
References: <20191213105921.9529-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0be14c5f-4d19-e633-8ed7-47bf99e632d9@redhat.com>
Date: Fri, 13 Dec 2019 14:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213105921.9529-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: nI_HTVw2PcKznDOqT0uJeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 11:59 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> We have a definition for the number of ISA IRQs, use it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/isa/isa-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 388800603b..1d79ed133c 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -85,7 +85,7 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs)
>   qemu_irq isa_get_irq(ISADevice *dev, int isairq)
>   {
>       assert(!dev || ISA_BUS(qdev_get_parent_bus(DEVICE(dev))) =3D=3D isa=
bus);
> -    if (isairq < 0 || isairq > 15) {
> +    if (isairq < 0 || isairq > >=3D ISA_NUM_IRQS) {

Oops, Pablo was quicker than patchew to notice this buggy patch =3D)

I messed when copy/pasting from a bigger series :/

So no need to review further.

>           hw_error("isa irq %d invalid", isairq);
>       }
>       return isabus->irqs[isairq];
>=20



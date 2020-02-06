Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC7C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AC3214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvF0Vuu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AC3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izm7l-0005d3-EU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izm3d-0000v2-9G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izm3c-0000Cx-3n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:39:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izm3b-0000BT-WE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581014359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBVMO5LDCoa1gnX6XztnMSUGsp5xXMpUZV2SehTYlzE=;
 b=IvF0Vuu2PN3GnFc/P1GQU4uy5hgdR3p/043vv+9pD2DvR+1ORL9PVfNn8BAr3cRWnMghoC
 kvjfK0t31nkXesrjsa205rIpq9AUTR69CmIKo0NZc6l1/KST3cQMjseAxDkV+UuYTrSl2d
 ZMmzcmV0qzM02ffFeSG4Cytox97g6RY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-xWhF9gKLN02wNfvBvYy5eg-1; Thu, 06 Feb 2020 13:39:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so3948010wro.14
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 10:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wycmG98GB1Km5bPiSwxvQs3qf839VppKphMS2syKTU4=;
 b=U6PrLR6ZYGJnGieZ5YjO80qqL5hF7vGlwVxeuNi0Rw4a9WQZyN9PS1LxlJ28ZexBMj
 ULJUtFzHZPsGGIyEeTiyWqOmik1HFpQrdz80putvqEXBGlhQUgoaf6bCHocaeIE2CMA8
 EvUtU9j43HjeoskSTHfHwLp3/aWvIvMpSvxJ8xbL6ZNbY1cFUjDAw3fFpQO6RtkGPvoQ
 GFlxr30tXL/rSErUPXdVEzvEMAafLNMj3ILC+NmjNcnB+Su19IzqicW6QQSr7EG1C0Hm
 jo+nbDCA/jxE25a8genQAQpM05mB67feAr1G2SNJbyUxA5OFTvWeoLefVEV+W2u8Yl8I
 lMaw==
X-Gm-Message-State: APjAAAVpddk0vEqkbyPgSG/awvtNfkki1V7u0Vtqnjo6Dc4i3ZgNw2rd
 TLaY+uYo3K16YI/u5niyBz96a1Wdgu3yw5B5xOdeZv0siCXD8RwRNFKu1rABIMwIrufoycmWcEN
 JevLXvO8wKRXTyEg=
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr5812293wmj.2.1581014354682; 
 Thu, 06 Feb 2020 10:39:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHG9NRmOoGsmcEI9xSeyKAO7t3ICqo570L25o+o6WVwZsriUYFA4FEwYfsqa+p5nIxfDFH0A==
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr5812271wmj.2.1581014354430; 
 Thu, 06 Feb 2020 10:39:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g18sm392660wmh.48.2020.02.06.10.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 10:39:13 -0800 (PST)
Subject: Re: [PATCH v2 4/4] aspeed/smc: Fix number of dummy cycles for
 FAST_READ_4 command
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
 <20200206183219.3756-4-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cb7f4ce-beed-7f33-8d29-536089289e5c@redhat.com>
Date: Thu, 6 Feb 2020 19:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206183219.3756-4-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: xWhF9gKLN02wNfvBvYy5eg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 7:32 PM, Guenter Roeck wrote:
> The Linux kernel recently started using FAST_READ_4 commands.
> This results in flash read failures. At the same time, the m25p80
> emulation is seen to read 8 more bytes than expected. Adjusting the
> expected number of dummy cycles to match FAST_READ fixes the problem.
>=20
> Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycle=
s")
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: No change
>=20
>   hw/ssi/aspeed_smc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 23c8d2f062..0444570750 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -787,11 +787,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
>       case FAST_READ:
>       case DOR:
>       case QOR:
> +    case FAST_READ_4:
>       case DOR_4:
>       case QOR_4:
>           return 1;
>       case DIOR:
> -    case FAST_READ_4:
>       case DIOR_4:
>           return 2;
>       case QIOR:
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC23FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD7920663
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQ9b0TEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD7920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmhM-0003HD-Kw
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKmfF-00025J-Hl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKmfD-00089y-Sh
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:00:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKmfD-00086j-Ip
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571245242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoeIkA5FMBsFWxcDl/jUg+TSsuA63LX1lxcILHEkpQc=;
 b=fQ9b0TEmMejrQU3PoIRkaKRkUfum94bWYypxajUS4iliqtKVvqpFaEzlXbXh6VDM/9DC/d
 16ewPVccWBCksOgsl2vVE+dKOpru01CgA+E2djzqwyBfkGN9VNiR0BzV57sv5nL1p99E6Z
 sinrmVxyceI1vF/PjWTzEHkSnJoiGAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-p8DOb8V5PRqTsUfolDs7cw-1; Wed, 16 Oct 2019 13:00:37 -0400
Received: by mail-wm1-f72.google.com with SMTP id f63so1221888wma.7
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 10:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TdtcEo87KEFVy9gKXMZOzv9BZkkuVr0Du3uRGSPxksg=;
 b=o8RRORlZ5Pol9uSV0RrWTJ6jw48cuGZhy6k+4cm9VF9bszQ7mZ2wubFkeuS5gdNxuC
 vQexihr5RQrAbDxT3EPQu/YFX/czvAuQt7240CLmydYfpsu4Ik0SNROzF5FYT6j2dThB
 CCT2eha5yamWWXmL7yz6DWLCbDHVG9EUFaWa5oTJhslUOttmD4hA366GANAtO96YG0j5
 siaSfVXQ0usCpfnv6+HSU5UKZ4wdUuEoY6MBoYwrNtLcw8UswYsdo53UmDGGTsQGowr/
 Q6U1BYfE4Pq5H/DYSwbhT8QW+/2qkRATltjN6lDm2YpNSiFHg7WANCnWVlESy9IfUiX9
 uIPg==
X-Gm-Message-State: APjAAAVxKRXExUyhaUDFejr9Yq7RiGMMkDyuDq2LW1A496Hx6uXWNzAG
 uS07IWmguEx+NSpjriRar6tt3NyOYWV7IgmcYdyCToFFNM2bVgatT+S4WCNvA3Fds3bdQ9l8q/k
 W1bQ+yiBXs/5/L9o=
X-Received: by 2002:adf:e544:: with SMTP id z4mr3827676wrm.6.1571245235551;
 Wed, 16 Oct 2019 10:00:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCkjGpoQVUbQPKuxU+QmBdsOZ28hp0+bjk6SmuuTucLGK7xDWzwrffg6opusJvTrM8os2lmA==
X-Received: by 2002:adf:e544:: with SMTP id z4mr3827586wrm.6.1571245234411;
 Wed, 16 Oct 2019 10:00:34 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id z22sm3501152wmf.2.2019.10.16.10.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 10:00:33 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] contrib/gitdm: add more entries individuals and
 academics
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b38dfd4e-afcd-69cf-4d4b-88d8e2de51ba@redhat.com>
Date: Wed, 16 Oct 2019 19:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014135905.24364-2-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: p8DOb8V5PRqTsUfolDs7cw-1
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
Cc: Li Qiang <liq3ea@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Li Qiang <liq3ea@163.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:59 PM, Alex Benn=C3=A9e wrote:
> Again this is guess work based on public websites. Please confirm.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
> Cc: Li Qiang <liq3ea@gmail.com>
> Cc: Li Qiang <liq3ea@163.com>
> ---
>   contrib/gitdm/group-map-academics   | 3 +++
>   contrib/gitdm/group-map-individuals | 4 ++++
>   2 files changed, 7 insertions(+)
>=20
> diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-=
academics
> index 08f9d81d13..5cbb9d84c8 100644
> --- a/contrib/gitdm/group-map-academics
> +++ b/contrib/gitdm/group-map-academics
> @@ -12,3 +12,6 @@ ispras.ru
>   # Columbia University
>   cs.columbia.edu
>   cota@braap.org
> +
> +# University of Paderborn
> +uni-paderborn.de
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-ma=
p-individuals
> index 1c84717438..301071b98b 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -14,3 +14,7 @@ noring@nocrew.org
>   samuel.thibault@ens-lyon.org
>   aurelien@aurel32.net
>   balaton@eik.bme.hu
> +e.emanuelegiuseppe@gmail.com
> +dirty.ice.hu@gmail.com
> +liq3ea@163.com
> +liq3ea@gmail.com

Also: liqiang6-s@360.cn



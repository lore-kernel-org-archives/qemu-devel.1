Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95399205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBurrbjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95399205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imJWl-0007O9-M4
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 10:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imJW0-0006yQ-BQ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imJVx-0001UY-MP
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:32:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imJVx-0001OP-CG
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577806376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ch3uQGZTQ2BQTZ8niF1vpR462eRRmJz+08m2sNtgEEY=;
 b=FBurrbjyt/bNm03+dQRDDIeKm8Qq+geynJpAjKubvSEyLFgjVgk3mbiLpxjAp/+v/m9uYk
 u/EOl0drOqILbrR24dNH/eS7FvIARVupBlTUD6MuPMfR4hJunmiJjBMQ41E62WFB2Z1pky
 gMBz2sOkpOhQXCf5z0ZWJIqSZL+AuxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-mBNA11N9PhSDpaJAHc_ekA-1; Tue, 31 Dec 2019 10:32:54 -0500
Received: by mail-wm1-f69.google.com with SMTP id 7so174287wmf.9
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 07:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WJtF8NAecESX3wc0S0f+2wYcZgXcsTwGim/EkU3Y7H4=;
 b=DXxw+3qegxPGOxw3zB5dm3RW0g6ko6kZtHbMnUnbhal41pqw+MsotcZ/xdSZc+wkfD
 ZZG2aO3BaQm1pqNZe01DQ1Nw+ptP/g43UDIjz+SxIlb/2RvS+qpsS7eMeywbBr4Y0STd
 LDQx/cTlwTRNk4iRkBGvW94Jqyz8pWElBrH2Jud+C3+Jfed7nGvaOUM65mfJPzy7SP2d
 zL/JwKmXpryTxhvRE/FkSYRAr93dIX4fz+JX5n//jfMLEx7GKnJn07uPinjaA8v5zTOf
 x4djA6fb2zk22xxd2eUV71rxHhqeLcgVdWSkqVHRUsBmGFB14FQ/YdZAr0hmQDyHaiC7
 +fRQ==
X-Gm-Message-State: APjAAAXOK5s+z0PIoe/DqrZSOwaUyZVbLdwgsQPbGBSTxgiV1h7Nmloq
 KYoB+xg0CuIUKHW2ommbzJyITCdVFVb6DpjSBckdy5bp93y9PVhOAwaqTqCrDiu8F8Luc/CJ4sr
 oVlxNn4hn1nQIhgc=
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr44108860wra.231.1577806373048; 
 Tue, 31 Dec 2019 07:32:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6OuCgQiSZOBDEMWL4vyBqcQymLBuN0Zge84WwvUFeMfx2zIaEfPG4cbAla0VGwnVAcaXxrw==
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr44108839wra.231.1577806372757; 
 Tue, 31 Dec 2019 07:32:52 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id a16sm49194997wrt.37.2019.12.31.07.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 07:32:51 -0800 (PST)
Subject: Re: [PATCH 41/86] null-machine: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-42-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f542a563-688f-00e4-6683-4b63343484fd@redhat.com>
Date: Tue, 31 Dec 2019 16:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-42-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: mBNA11N9PhSDpaJAHc_ekA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:03 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/core/null-machine.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 1aa0a9a..cb47d9d 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -32,11 +32,8 @@ static void machine_none_init(MachineState *mch)
>       }
>  =20
>       /* RAM at address zero */
> -    if (mch->ram_size) {
> -        MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> -
> -        memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_=
size);
> -        memory_region_add_subregion(get_system_memory(), 0, ram);
> +    if (mch->ram) {
> +        memory_region_add_subregion(get_system_memory(), 0, mch->ram);
>       }
>  =20
>       if (mch->kernel_filename) {
> @@ -52,6 +49,7 @@ static void machine_none_machine_init(MachineClass *mc)
>       mc->init =3D machine_none_init;
>       mc->max_cpus =3D 1;
>       mc->default_ram_size =3D 0;
> +    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("none", machine_none_machine_init)
>=20



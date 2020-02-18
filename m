Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0230C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DD8206EF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jesj9fc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DD8206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wX6-0004r7-HN
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wW0-0004AP-37
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wVz-0008AA-7i
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:37:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wVz-00089x-4c
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582007870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kk+AsAz6XiAvxVlVydRbGv1vQ0eTkYRksDPBW/NRObI=;
 b=Jesj9fc6iJ8vbn2CXcCqhQApwYKDYvZlO0WHYFMcb4sK1LxWWEJOBiuTHXHOYW9kXKMvSo
 IIIH/TS/NBxgBXUt5fD6Crgi/tdAOdHy9F+RMJvx4MpBh/vRXiThMO476/2Xnl9ytU7sh+
 8YucZc70Xopay9xTWKCxGnT/83oJlT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-xIPQjQU-P4-FQMMcdYhRoQ-1; Tue, 18 Feb 2020 01:37:46 -0500
Received: by mail-wr1-f72.google.com with SMTP id 50so10321994wrc.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zr4F/r9gq3V47vNBUvQLhxt9Zpw/a79sMTFDSyjzjMk=;
 b=M+iBgEpl34MzUG/M0sPdisJR2Njr9tL+LGS2QxQ8C/vKDeWHBSyUWLvYqi4zHe6LMV
 SMeg/E7zhGl0WKz4Yvh9Dq3D7aPymG35YZnshJ0aWAwp/VlcYQwTCtoy6PbZoms8gJ0j
 gyNvXUcX/EzYmtB2a1HyJ9QjGAVDikNvhEiRIhABl/bbLgvEcLl4+xO+XRXDD+jjZ369
 sM+oOxQKMPmT8+KU8BXl0CAnT3qXg6vp+Q2iaVnyox+fcDZ8g1+A9ZSKsrCB/bhFjnJ2
 ve8Ed0OEqtSzyJSBfTldcpCxmTUr/e+0moUzCggiF3qGG5gO17yxayOb3jHv9BL5nA8V
 1sRg==
X-Gm-Message-State: APjAAAVorVKKm1GhQ6csGcTfJ7NiTQM00DDrptT/Fnd5AIhfk1f1gY39
 YdULJZFm/iFRSn8oY6cz9Wmdb6WaSycF5jBuIa7gj7I6MgA0R8wF9fNp8s7wfXpxVe5I3bBtB3E
 s+oepXEn8tzMILWQ=
X-Received: by 2002:a1c:f003:: with SMTP id a3mr1124749wmb.41.1582007865049;
 Mon, 17 Feb 2020 22:37:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeZQa9E0hwgJpfOccA3U6QaaG1aAFR0CPaN6hMku2l5AetyPA50fKM2gufILfV04l89sarhA==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr1124731wmb.41.1582007864846;
 Mon, 17 Feb 2020 22:37:44 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id p26sm2208390wmc.24.2020.02.17.22.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:37:44 -0800 (PST)
Subject: Re: [PATCH] z2: Make providing flash images non-mandatory
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200217210903.18602-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9854376f-eb4f-2456-de03-52c72b810e37@redhat.com>
Date: Tue, 18 Feb 2020 07:37:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217210903.18602-1-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: xIPQjQU-P4-FQMMcdYhRoQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 10:09 PM, Guenter Roeck wrote:
> Up to now, the z2 machine only boots if a flash image is provided.
> This is not really necessary; the machine can boot from initrd or from
> SD without it. At the same time, having to provide dummy flash images
> is a nuisance and does not add any real value. Make it optional.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/arm/z2.c | 6 ------
>   1 file changed, 6 deletions(-)
>=20
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index 34794fe3ae..4bb237f22d 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -314,12 +314,6 @@ static void z2_init(MachineState *machine)
>       be =3D 0;
>   #endif
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
> -    if (!dinfo && !qtest_enabled()) {
> -        error_report("Flash image must be given with the "
> -                     "'pflash' parameter");
> -        exit(1);
> -    }
> -
>       if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZ=
E,
>                                  dinfo ? blk_by_legacy_dinfo(dinfo) : NUL=
L,
>                                  sector_len, 4, 0, 0, 0, 0, be)) {
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>



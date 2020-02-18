Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CBEC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8C5206EF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HExXNEck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8C5206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wYT-00062Y-2e
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wWU-0004aO-SF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wWT-0008G2-Oz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:38:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wWT-0008Ff-07
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582007899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qC+CGolcOBcc4a1J/+qzeVK5mL6D9yq6kCEYxmiKC0=;
 b=HExXNEckmY0kLrhnMDlFhER0z31vlVWMI3Ylr0IdJ0xOkffKn6S3xWwmgqVYa1isxiZQjw
 bSJESGgend0eqB8trSwznfkArjmMrBCk0Rd5xegaGFr3++9ZR8a4S5ldvp67TQQhXinGL6
 4P2rBlgvRS3nqorLw9xhelUmTTu2lQ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-StKrE1pSM0Sdq9DnhX7Ovw-1; Tue, 18 Feb 2020 01:38:18 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so10220598wrq.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fI270OyDYIHJ9RKxTaIBJnJDHlaj2fFo4SFEKm2BOhc=;
 b=WyH6nro7kgojR6k+DH6QgR21SNjy/q4HCKcjtsSz/FxZ2bScwg8iaD+tOP1yhVmeAV
 MWHAHn1A6HYfllt4kijfzj5GRXtCUzR4yopflWgvkq+Ewoh7nXwCfWvv/T1cij9EcdVh
 ESCMIxquNJuvHIEHNmVKcLofXX2RN69cK/4ZhRdGok/F7euR/ed+A7TLh6w9ZGFMXLrf
 fGIcGks+6B9uHHrB2LA4UQcZte9Z5BfjrFkWrdFMf+fBTo6HO/2HRJV531g4NbiTUofC
 JkONMQ2LqMJL1L+ZVJb+yZYtaJc80GpEVfx5Qk+JQpFEx8tgz7icItx86AOup3rHpfMt
 6jNw==
X-Gm-Message-State: APjAAAW2RVcAN/Snknzi+U3hkKhm4bLRnk+TI+CybZr9u2suIfVBgdeR
 tx3P3qzbjv/2vmW+4KCNPw6Sz1iWPWzuBjPOzUXGZMJmP0xpWMaGqH5bJhVV3WjxHkw8KSuwVmo
 Ktn1A1GiX1Waas2k=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr1087871wmb.81.1582007896923;
 Mon, 17 Feb 2020 22:38:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWJdqpZjkHV57omyBBLKYxLGOrmhOOPRaniZWjR+W2Dz0A39ndeNcJVDjdA+pk1P5ITBElYg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr1087843wmb.81.1582007896620;
 Mon, 17 Feb 2020 22:38:16 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j5sm4613871wrw.24.2020.02.17.22.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:38:16 -0800 (PST)
Subject: Re: [PATCH] mainstone: Make providing flash images non-mandatory
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200217210824.18513-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfeae9e1-38fe-163e-cbf5-071b587543da@redhat.com>
Date: Tue, 18 Feb 2020 07:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217210824.18513-1-linux@roeck-us.net>
Content-Language: en-US
X-MC-Unique: StKrE1pSM0Sdq9DnhX7Ovw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 10:08 PM, Guenter Roeck wrote:
> Up to now, the mainstone machine only boots if two flash images are
> provided. This is not really necessary; the machine can boot from initrd
> or from SD without it. At the same time, having to provide dummy flash
> images is a nuisance and does not add any real value. Make it optional.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/arm/mainstone.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
> index b01ce3ce08..6e64dfab50 100644
> --- a/hw/arm/mainstone.c
> +++ b/hw/arm/mainstone.c
> @@ -138,19 +138,10 @@ static void mainstone_common_init(MemoryRegion *add=
ress_space_mem,
>       /* There are two 32MiB flash devices on the board */
>       for (i =3D 0; i < 2; i ++) {
>           dinfo =3D drive_get(IF_PFLASH, 0, i);
> -        if (!dinfo) {
> -            if (qtest_enabled()) {
> -                break;
> -            }
> -            error_report("Two flash images must be given with the "
> -                         "'pflash' parameter");
> -            exit(1);
> -        }
> -
>           if (!pflash_cfi01_register(mainstone_flash_base[i],
>                                      i ? "mainstone.flash1" : "mainstone.=
flash0",
>                                      MAINSTONE_FLASH,
> -                                   blk_by_legacy_dinfo(dinfo),
> +                                   dinfo ? blk_by_legacy_dinfo(dinfo) : =
NULL,
>                                      sector_len, 4, 0, 0, 0, 0, be)) {
>               error_report("Error registering flash memory");
>               exit(1);
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>



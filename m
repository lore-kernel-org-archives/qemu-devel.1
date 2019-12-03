Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A769BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F932068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMRM2n98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F932068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2uM-0003H3-4f
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic2sb-0002N6-6t
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic2sU-0004g4-Dc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:45:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic2sT-0004bG-N4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575359144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bif+g3nyAEKfdplELih3TkyWPbIGJkApGiDVx2y1akA=;
 b=dMRM2n98xeQClhHOR+r3ODCdA2Ua4JDu8wWXF6lYI0mwQcBZRqYHqSsBQCVlLmvk0v9pM5
 Z2KRVQieX2WPMaaotHumErchEOkB47Ua/XH9Y6OLJz+bmTB0/lIQkQwdSnljswufRNxdSX
 2CKEOUAewsE8CmFvxJ3cXmfI9OJyjPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-vqNk2H4ZOTO2khjllkOZgA-1; Tue, 03 Dec 2019 02:45:43 -0500
Received: by mail-wm1-f70.google.com with SMTP id p5so645027wmc.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 23:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MF6ya+yhBfZz89Bc7HlubtExl84yETdG6zMEi/OrD0U=;
 b=Y4v8zsUT4BelxxDY3DXrFwIVwIlmTiDzlHpleo2NSk68WlK9hCM6VsTdnxD1MBSdoM
 Fricw7/Tk2Idr+Z8WpPdVr7Mt6GWCgsDtuch8e4gnWax8GWJENEvvtv7ptUotTmGuTmB
 0DJJ+setXQHvbFqk18AN76I8E+LDZlTc0mqevWLM2bSlTK7bVngi5Y+7EMgNXl3SdL64
 v/fae+oGjD+lcAwmYpxlW2QzFHPrNDmJd0yEKMFpAcnmhY5W+/rNDso1WHpRu2s0uJ9X
 kh14qUOh6lyWc6aaP1mOaMBxw2YK0ijBKqxT6Pyg2Cz8Qfh823lqz+8euXIYsOqqIj3m
 9KWg==
X-Gm-Message-State: APjAAAUGOr7Tc8AHOzBYJF/DMMk8SLF+I5HqVw99z+yvQ6pHFi0qeBfm
 l0rL1dq9oM9MCgmy4aPz1eUTj/O35vfodT19OEvm0b/ZenKroT2jUWdRdH1Z4kA3Z4DaBjdGUEA
 ZC4IGzaTpOjUrRHA=
X-Received: by 2002:a05:600c:388:: with SMTP id
 w8mr12470236wmd.177.1575359142233; 
 Mon, 02 Dec 2019 23:45:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwr0ghee+WnxPd7a2GuacnL9ZjNxpshjZvtmt/2HzTxnY06CdOXl46VIT3VA1vQP5hGprrjUA==
X-Received: by 2002:a05:600c:388:: with SMTP id
 w8mr12470213wmd.177.1575359141981; 
 Mon, 02 Dec 2019 23:45:41 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l4sm1939744wml.33.2019.12.02.23.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 23:45:41 -0800 (PST)
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
Date: Tue, 3 Dec 2019 08:45:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203072922.14981-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: vqNk2H4ZOTO2khjllkOZgA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 8:29 AM, Thomas Huth wrote:
> It's been deprecated since QEMU v3.1. The 40p machine should be
> used nowadays instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitmodules                |   3 -
>   MAINTAINERS                |   1 -
>   Makefile                   |   2 +-
>   docs/interop/firmware.json |   3 +-
>   hw/ppc/ppc.c               |  18 --
>   hw/ppc/prep.c              | 384 +------------------------------------
>   include/hw/ppc/ppc.h       |   1 -
>   pc-bios/README             |   3 -
>   pc-bios/ppc_rom.bin        | Bin 1048576 -> 0 bytes
>   qemu-deprecated.texi       |   6 -
>   qemu-doc.texi              |  15 +-
>   roms/openhackware          |   1 -
>   tests/boot-order-test.c    |  25 ---
>   tests/cdrom-test.c         |   2 +-
>   tests/endianness-test.c    |   2 +-
>   15 files changed, 10 insertions(+), 456 deletions(-)
>   delete mode 100644 pc-bios/ppc_rom.bin
>   delete mode 160000 roms/openhackware
[...]
> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
> index a725bce729..4a6218a516 100644
> --- a/tests/boot-order-test.c
> +++ b/tests/boot-order-test.c
> @@ -108,30 +108,6 @@ static void test_pc_boot_order(void)
>       test_boot_orders(NULL, read_boot_order_pc, test_cases_pc);
>   }
>  =20
> -static uint8_t read_m48t59(QTestState *qts, uint64_t addr, uint16_t reg)
> -{
> -    qtest_writeb(qts, addr, reg & 0xff);
> -    qtest_writeb(qts, addr + 1, reg >> 8);
> -    return qtest_readb(qts, addr + 3);
> -}
> -
> -static uint64_t read_boot_order_prep(QTestState *qts)
> -{
> -    return read_m48t59(qts, 0x80000000 + 0x74, 0x34);

I'd rather keep this generic mmio-mapped ISA test.
Maybe run it with the 40p machine?

Maybe we can rename this as read_boot_order_mm, and the previous=20
read_boot_order_pc as read_boot_order_io.

Except this comment, thanks for this cleaning.

Ideally keeping read_boot_order_io test:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> -}
> -
> -static const boot_order_test test_cases_prep[] =3D {
> -    { "", 'c', 'c' },
> -    { "-boot c", 'c', 'c' },
> -    { "-boot d", 'd', 'd' },
> -    {}
> -};
> -
> -static void test_prep_boot_order(void)
> -{
> -    test_boot_orders("prep", read_boot_order_prep, test_cases_prep);
> -}
> -
>   static uint64_t read_boot_order_pmac(QTestState *qts)
>   {
>       QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);
> @@ -190,7 +166,6 @@ int main(int argc, char *argv[])
>       if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D =
0) {
>           qtest_add_func("boot-order/pc", test_pc_boot_order);
>       } else if (strcmp(arch, "ppc") =3D=3D 0 || strcmp(arch, "ppc64") =
=3D=3D 0) {
> -        qtest_add_func("boot-order/prep", test_prep_boot_order);
>           qtest_add_func("boot-order/pmac_oldworld",
>                          test_pmac_oldworld_boot_order);
>           qtest_add_func("boot-order/pmac_newworld",
> diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
> index 34e9974634..006044f48a 100644
> --- a/tests/cdrom-test.c
> +++ b/tests/cdrom-test.c
> @@ -189,7 +189,7 @@ int main(int argc, char **argv)
>           add_s390x_tests();
>       } else if (g_str_equal(arch, "ppc64")) {
>           const char *ppcmachines[] =3D {
> -            "pseries", "mac99", "g3beige", "40p", "prep", NULL
> +            "pseries", "mac99", "g3beige", "40p", NULL
>           };
>           add_cdrom_param_tests(ppcmachines);
>       } else if (g_str_equal(arch, "sparc")) {
> diff --git a/tests/endianness-test.c b/tests/endianness-test.c
> index 58527952a5..2798802c63 100644
> --- a/tests/endianness-test.c
> +++ b/tests/endianness-test.c
> @@ -35,7 +35,7 @@ static const TestCase test_cases[] =3D {
>       { "mips64", "malta", 0x10000000, .bswap =3D true },
>       { "mips64el", "fulong2e", 0x1fd00000 },
>       { "ppc", "g3beige", 0xfe000000, .bswap =3D true, .superio =3D "i823=
78" },
> -    { "ppc", "prep", 0x80000000, .bswap =3D true },
> +    { "ppc", "40p", 0x80000000, .bswap =3D true },
>       { "ppc", "bamboo", 0xe8000000, .bswap =3D true, .superio =3D "i8237=
8" },
>       { "ppc64", "mac99", 0xf2000000, .bswap =3D true, .superio =3D "i823=
78" },
>       { "ppc64", "pseries", (1ULL << 45), .bswap =3D true, .superio =3D "=
i82378" },
>=20



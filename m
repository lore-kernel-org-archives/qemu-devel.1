Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D019C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEC2206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsU4ZhVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEC2206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8XF-0000qG-1i
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8Wc-0000Os-IS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8Wb-00042W-Fw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:28:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8Wb-00040t-BX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584437317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyDjqS/JT7sJAx/Obk30HpU3BrH9fPU9ECX7oiMfnpI=;
 b=hsU4ZhVQyV0tC216VK+E0uxnLic6A29CTGjdRObBMfH0FA1BFtqo/Ioc33zP86UeKDWEfQ
 mCKC9pkg0sfelH41YuGoBy7BRqyN/kycEdfU2g6Z4PLHYaIs2js47/0kFCNiE+9D4Uv5ij
 zhQAjtlmHnRNW+2Lpg5AYQ0/M/4qRyk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-T7JJCwv9M0aXW58J3OYyxg-1; Tue, 17 Mar 2020 05:28:34 -0400
X-MC-Unique: T7JJCwv9M0aXW58J3OYyxg-1
Received: by mail-wm1-f70.google.com with SMTP id z26so5703289wmk.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sgtlN/gnrp2Ocnkq97eBSGz6X6FdYdpaperbPDTjot8=;
 b=gYimeMqqka8x+hPsKMtxRT2Hwwtr7FozuPBvSyiQI4lPmCKWUlVqmtqupJEeXaeC94
 BIUqAAl1PFaZCHablscRh19vr5rWSr67jdW29HLSLaSTxUm+ABsc1Fl1cMCitAYM1spq
 xIZkILaweo7XQaQLLwX0NXT3r3hCNkNCn5NBRrkmq5fXBNgbiguAPxscIPS3g+eS8uZ0
 o2t+sLxc4rQ7YG/TKow0dfCjLVKHSEtq/0muOgSP43zZhJx7eKK1e1yPdW9lEozuQlOH
 XTsPv4kXwX5uZRaaEoLo4CqHm7TGM1W7mF00JaIq9FqL2gpDWeIa21HHviNq9N31JPVk
 hteA==
X-Gm-Message-State: ANhLgQ2a0cbm2fUFklynmbB6hQ1XIFgcglNDZyDL9GeFWYRUtWxz9ObJ
 kG2TKlEj7Zf2d0Ili14IpggclV2foZ98Kp5ciDxXtBpbfBzY+2lbANxNJiGeRfjY+4YYczwnjiG
 AW2cBe9fNGsfdkD0=
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr4298827wmg.168.1584437313754; 
 Tue, 17 Mar 2020 02:28:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu1IFcG5l8pdW7rAJ+9UEeyk2P48wkJLbXUvHE0Fv0Ag5ghO4lC3iaGcfac+5Zx1QMkPmJnZg==
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr4298812wmg.168.1584437313564; 
 Tue, 17 Mar 2020 02:28:33 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id s131sm3211408wmf.35.2020.03.17.02.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:28:32 -0700 (PDT)
Subject: Re: [PATCH] hd-geo-test: Clean up use of buf[] in
 create_qcow2_with_mbr()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317092354.31831-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d782061c-5c63-941f-97c8-d743aed0ed94@redhat.com>
Date: Tue, 17 Mar 2020 10:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317092354.31831-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Sam Eiderman <shmuel.eiderman@oracle.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 10:23 AM, Markus Armbruster wrote:
> valgrind reports write unitialized bytes from buf[].  Clear them.
>=20
> ASan reports we store to misaligned address in buf[].  Use stl_le_p()
> for that.
>=20
> Cc: Sam Eiderman <shmuel.eiderman@oracle.com>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/hd-geo-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> index a249800544..48e8e02d6e 100644
> --- a/tests/qtest/hd-geo-test.c
> +++ b/tests/qtest/hd-geo-test.c
> @@ -421,7 +421,7 @@ static char *create_qcow2_with_mbr(MBRpartitions mbr,=
 uint64_t sectors)
>       char *raw_path =3D strdup(template);
>       char *qcow2_path =3D strdup(template);
>       char cmd[100 + 2 * PATH_MAX];
> -    uint8_t buf[512];
> +    uint8_t buf[512] =3D {};
>       int i, ret, fd, offset;
>       uint64_t qcow2_size =3D sectors * 512;
>       uint8_t status, parttype, head, sector, cyl;
> @@ -457,8 +457,8 @@ static char *create_qcow2_with_mbr(MBRpartitions mbr,=
 uint64_t sectors)
>           buf[offset + 0x6] =3D sector;
>           buf[offset + 0x7] =3D cyl;
>  =20
> -        (*(uint32_t *)&buf[offset + 0x8]) =3D cpu_to_le32(mbr[i].start_s=
ect);
> -        (*(uint32_t *)&buf[offset + 0xc]) =3D cpu_to_le32(mbr[i].nr_sect=
s);
> +        stl_le_p(&buf[offset + 0x8], mbr[i].start_sect);
> +        stl_le_p(&buf[offset + 0xc], mbr[i].nr_sects);
>  =20
>           offset +=3D 0x10;
>       }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB8C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AA5206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbs/bnc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AA5206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lbA-00049m-HC
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1laT-0003dX-LB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1laS-0003rv-JL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:33:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1laS-0003ri-GU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581489208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiaSrhNJ3DDevNHnbuwF56IB49ZF1yXJIt6WnQQuxMo=;
 b=Kbs/bnc5xTgSBjYnV5U3YjIGMx73fa0D/ROflG8D9Q3WlSFcl0lgbF7XySfddoiHiuPS3U
 iP3q0MHjky0MmX76pijj6Qpjl66NUlVbL/qL/kndAEkUCx8xgjujo+bZ9YoldZO8AmtYnu
 K0TjpBzmkoOaUf8NQyYZxE0cgjVnVQ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-xKPdNyrvMHac2DXSROb3pA-1; Wed, 12 Feb 2020 01:33:24 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so388729wrs.22
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1tk/rnk8CV/dPmL1ve+WJvChj3DZRsf45islRpAC5B8=;
 b=rPjA6n5MtyqKgGaqSgpmiLkGQVrGybeaUHVzQb2XFyEvtjWrKyA66Blr5lowbkbT4e
 ZJTO2NpemizgfiBYRlgNOFTF3uqBVyphm/xukjoh7R1BgsKELfR9zRz9V7kkebeeCHFe
 3EHvOaYJg3cAgZpS8VK/ghj2XyHEUaYxLNHu8I6FpI9dsRR5mrBlJvKXFszDMo9XEj1P
 zEhNErMv6w5JacboJFbRqX2q0UROkXmrGQZlJ8cP8Ph8qoSm/xHhEZNRdUGMvG8tpHJM
 67cRTN5PuEVkP+nWLIM6DAxOW5NVV7QRZRi5+rzkW7/uallYcL/FtcV2aybKYSckXaSx
 JyrA==
X-Gm-Message-State: APjAAAV/LU5OSMNMTPmMhKsQV4P2PFtKEDYxOgDsY0rGMrBtDmx0RCsf
 lpLb5vOpRJGlMiP5cGPsfDdoW1qI5iEbDSEPP9rYfrWD76/AiujHFCNVD6sjjaySFZaaRt2fRN7
 jEw83Gt6Br5Qpc0E=
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr13083115wrs.272.1581489202899; 
 Tue, 11 Feb 2020 22:33:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYlL3owgDVBKGTn7CpYSC2kpOFRe/1zUePOucVFBafBMLkaSAaFUjqyfM50rI9c/24uEzCIg==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr13083087wrs.272.1581489202648; 
 Tue, 11 Feb 2020 22:33:22 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v15sm8671191wrf.7.2020.02.11.22.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:33:22 -0800 (PST)
Subject: Re: [PATCH] target/arm: Implement ARMv8.1-VMID16 extension
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200210120146.17631-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <679ea0df-0aed-6268-9b28-b377ba51a1dc@redhat.com>
Date: Wed, 12 Feb 2020 07:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210120146.17631-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: xKPdNyrvMHac2DXSROb3pA-1
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 1:01 PM, Peter Maydell wrote:
> The ARMv8.1-VMID16 extension extends the VMID from 8 bits to 16 bits:
>=20
>   * the ID_AA64MMFR1_EL1.VMIDBits field specifies whether the VMID is
>     8 or 16 bits
>   * the VMID field in VTTBR_EL2 is extended to 16 bits
>   * VTCR_EL2.VS lets the guest specify whether to use the full 16 bits,
>     or use the backwards-compatible 8 bits
>=20
> For QEMU implementing this is trivial:
>   * we do not track VMIDs in TLB entries, so we never use the VMID field
>   * we treat any write to VTTBR_EL2, not just a change to the VMID field
>     bits, as a "possible VMID change" that causes us to throw away TLB
>     entries, so that code doesn't need changing
>   * we allow the guest to read/write the VTCR_EL2.VS bit already
>=20
> So all that's missing is the ID register part: report that we support
> VMID16 in our 'max' CPU.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not something anybody's been asking for, but worthwhile as
> a step towards finishing off support for all the v8.1 extensions.
>=20
>   target/arm/cpu64.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 2d97bf45e1e..bf2cf278c03 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -672,6 +672,7 @@ static void aarch64_max_initfn(Object *obj)
>           t =3D cpu->isar.id_aa64mmfr1;
>           t =3D FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
>           t =3D FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
> +        t =3D FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
>           cpu->isar.id_aa64mmfr1 =3D t;
>  =20
>           /* Replicate the same data to the 32-bit id registers.  */
>=20

Trivial conflict with:

commit cd3f80aba0c559a6291f7c3e686422b15381f6b7
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Feb 7 14:04:27 2020 +0000

     target/arm: Enable ARMv8.1-VHE in -cpu max

     Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
     Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-id: 20200206105448.4726-38-richard.henderson@linaro.org
     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2d97bf45e1..c80fb5fd43 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -672,6 +672,7 @@ static void aarch64_max_initfn(Object *obj)
          t =3D cpu->isar.id_aa64mmfr1;
          t =3D FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
          t =3D FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        t =3D FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
          cpu->isar.id_aa64mmfr1 =3D t;

          /* Replicate the same data to the 32-bit id registers.  */



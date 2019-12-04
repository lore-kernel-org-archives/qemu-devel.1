Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6CC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123CE2073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkA3ViOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123CE2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icZtf-0008O7-32
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icZrG-0007w3-D2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icZrF-0003YN-2J
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:58:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icZrE-0003TW-Ns
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:58:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id f4so5517667wmj.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Rqqsz8mVWGSyxji7GiCyEF3Nyksk2Vowd9Agu6rPKps=;
 b=xkA3ViOgAcCEP7UK7LK8IjXd1Cz51ZRbxgrpkVNfGfFzIIpscUvsTgyc3uOrtJF9a3
 RSgz7Q19DNyjauiQAehmGOLFiIbhblsZ9b8yo7jcVek0JW0QyyLejBDR72U5AKzJvVxA
 nz0o4atCdDI+aA/GjQUuNgfBy/Gf4jdYLd0su7yc5wcDmLtK1MmkvPVEm1F3R1tzGRJU
 1EH5o9rq9+WiYTS3ypYpK7Euj1zZ8Ln5GN2qJhb0rkOcUml4xtGDQKxPM6Xpc2So7OP2
 HNhgC+kOE5pnYaZzI4Iuzl7qK4YxXOPWeEgr0bESEvtxZevw0w1OzK921KgGfs+6IQcC
 KL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Rqqsz8mVWGSyxji7GiCyEF3Nyksk2Vowd9Agu6rPKps=;
 b=ezDSRkLD0CJ/FElFOuVTsFisPnPXJRbB2VTghDFt0LkVnTwfn9cazkoN77UL0DTXs3
 UTj2Vr7NMfFa8nM+2lAKP2Cqk0v8+49G2fISOx+OB4njmbh7vCWULImdzw54L1IqBw55
 +I+rP3c+tY4ZRKxIyv4JGBzL0+GDyjxMtOfwVmP1JkVo8M2mSSe38khh591O6RPAIU4z
 HSDQGphAw7L0XxSSi3rIu+p4qwqYO5Q3xVc1QeFJW8DpkZcq8hePG0+pv+yntxuB1TyS
 6Kj/GhDfI7p5+NEFyZQhscy3Da2IkZrK058KUgCobwsIFWTc83te/dtPLtF6i7ji1SaK
 N9uA==
X-Gm-Message-State: APjAAAWT/yoSd//g+q/qGwvPz3k207d8nEfLemO3j/4RG4LlCXgT71Bo
 rokLV4lVV7v5VG8GCqnZllPvag==
X-Google-Smtp-Source: APXvYqy5JkREc7KKOqxdob0FH2X5FBBIUTFcv/+LvtlmJD+iJ3BXPcZqNV5NYk6rtEapzfOv6peleA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr1208970wmj.96.1575485919405; 
 Wed, 04 Dec 2019 10:58:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k4sm8124620wmk.26.2019.12.04.10.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 10:58:38 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7FFF21FF87;
 Wed,  4 Dec 2019 18:58:37 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-27-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 26/40] target/arm: Update
 define_one_arm_cp_reg_with_opaque for VHE
In-reply-to: <20191203022937.1474-27-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 18:58:37 +0000
Message-ID: <87tv6f7w9u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> For ARMv8.1, op1 =3D=3D 5 is reserved for EL2 aliases of
> EL1 and EL0 registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 023b8963cf..1812588fa1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7437,13 +7437,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cp=
u,
>              mask =3D PL0_RW;
>              break;
>          case 4:
> +        case 5:
>              /* min_EL EL2 */
>              mask =3D PL2_RW;
>              break;
> -        case 5:
> -            /* unallocated encoding, so not possible */
> -            assert(false);
> -            break;

This change is fine - I don't think we should have asserted here anyway.
But don't we generate an unallocated exception if the CPU is v8.0?


>          case 6:
>              /* min_EL EL3 */
>              mask =3D PL3_RW;


--=20
Alex Benn=C3=A9e


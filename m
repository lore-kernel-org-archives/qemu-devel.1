Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD0AC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322D20727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpE+iblq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322D20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2Cj-0000lg-1b
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1t0-0001xR-Qu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1sz-0004ph-PT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:59:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1sz-0004pE-IV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:59:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id s5so2766380wrg.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RxbkZ13uQJ/d2vXTLJ6WnKHPB9Aqr7X9J9zI1LwxZ2A=;
 b=GpE+iblqx2hlUnPOhVUhP/byQgIjI6wmHNZiKEzMhNpolbd67UOsl070PBJeq0q9NM
 aYtlNTma1bx1oxkOk9n7mKe+XEWBhxUfd9n31553f+X8PQEf3E4zSEFkUVz5DMTychHd
 NWxRLl8raDyWxN785aEHrn4pt0SkSL8tG5vL2XXYUdb1lRL8eSZFILRLzegfHBBGsQZX
 345uotzwGyrCxc8FP1TKL5tm3lfYxOFyH/5LF7gAqTu7nXhJm1tjdZLud5AK2VkzQyU+
 myye3kaNqwaRbRTm8njGM3ROm60Orv/DoZck4UM20AUVi8ZUwNsCDON45aIYueaVTnyU
 PQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RxbkZ13uQJ/d2vXTLJ6WnKHPB9Aqr7X9J9zI1LwxZ2A=;
 b=hawKQvZOmDBfYr2FML0oeqqhKfrMZVoquSGldS4gjbJ9qFTPT20z2fr0zCvKu4ul50
 fAOKpjac5f2AZAmmW4FBI1Kfb3Hil9ZnTrcwQwVb14obeD7JOoTB4JI2uG/5M+m9QLad
 8lgwf8gwn5afw1ZN1BfcyjsYEXhqBabYLLRGhfXW2C4dHel6CfEosxtbTNuOX3ehUQNA
 Y7le6YBCV7Vw8QpLgm+GGCWgS3ReWk1S7qwLWY10FU227hOMLkFNA5+8X6/cUKBMLpED
 suM17qk5ff75nFnX2AP1xylhFUL3yN8Z7G/ZfFF8lqvO0VQpdFQ9nr0Ya0BDwZCx7ZH5
 ajcg==
X-Gm-Message-State: ANhLgQ1bJWbYqQ5ZoQwy9Axn0b/zWe399qCNXVXL/M4psko1uLq468fj
 eAU4sd29oDZr4TsTyIHDTdXnhQ==
X-Google-Smtp-Source: ADFU+vsGNA7M5PqXWf0GccdOIDPoHByOG0iiRPrpfjWxNO3wV33VQYR8cWqXqzGqIee6yOr2V7CpRQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr4706977wrh.121.1583935140524; 
 Wed, 11 Mar 2020 06:59:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y200sm6246933wmc.20.2020.03.11.06.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:58:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 037BD1FF7E;
 Wed, 11 Mar 2020 13:58:59 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-13-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 12/18] hw/arm/allwinner: add RTC device support
In-reply-to: <20200310213203.18730-13-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 13:58:59 +0000
Message-ID: <878sk7gfh8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> Allwinner System-on-Chips usually contain a Real Time Clock (RTC)
> for non-volatile system date and time keeping. This commit adds a generic
> Allwinner RTC device that supports the RTC devices found in Allwinner SoC
> family sun4i (A10), sun7i (A20) and sun6i and newer (A31, H2+, H3, etc).
> The following RTC functionality and features are implemented:
>
>  * Year-Month-Day read/write
>  * Hour-Minute-Second read/write
>  * General Purpose storage
>
> The following boards are extended with the RTC device:
>
>  * Cubieboard (hw/arm/cubieboard.c)
>  * Orange Pi PC (hw/arm/orangepi.c)
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


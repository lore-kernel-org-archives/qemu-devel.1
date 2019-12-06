Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF49BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16B0206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/djSdw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16B0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHWW-00029T-Lk
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idGAR-0002Xa-8r
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idGAP-0005pV-0F
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:09:18 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idGAM-0005jw-W9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:09:16 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so202574oie.8
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dBCYNC/fDNcpqreMk3cgL+G1Zp+E5kLTKodmQwiI+GA=;
 b=C/djSdw52pDQ0MVhdu3Osr14unFfIR1PkxOlnMf8TqA4qodusycQui1/1opq7bfTIL
 ZiMeNI1MQnFi8s7ozMzwaRe/7fO7sZXaeQmq/oWzZf5ihEXk8EiUPfGupDpEMqaAO9nv
 HRyBpC/X1uP8tply+vJcPndB8kbhkEXLeS6arap4ZmpTcciHPfF1NQ0+I53iJD2zjeKP
 8rIxSh4dLwFVbeucOzCEhfqi2FjO6DrwF2EMz9LSrX+HkRDl3FyCkcS/Stu6zYQj2B9R
 4N4OGoGmseUvDJLtKe0UNjj/pA/brVFNDQGb2ErUqIqjSk4cgmkIDfg7qs2DMV21dy2P
 7l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dBCYNC/fDNcpqreMk3cgL+G1Zp+E5kLTKodmQwiI+GA=;
 b=ONa68z+YcT7O+ZqUgdqLP/oRIdj3loMUzyTZTjPTRGT0nJFkU+eAfToO2rkzD5H/SE
 f43N+7bFLzMj5JCie00bD4l9yFfQh2muJqGP/27eqmuSfH2zglyks9LMUI/sK23BglHP
 AqH/rseruVDWCmef8oOaa2H76KTmFS1drtuzS5VbsHU7lQwfwBzRDmnfhGx8eXj3usTv
 I6jPm1YoUHzYOmCBqVrrskD7CB0yZ7k6Exw8DxL0VosWFk4dx/r3/kcWl8IIYAgCX+qT
 dDqiotvO9Pe7g7PMVOzywRPQp8kpGd6AfTTshXgZg3DV3X5VwNsurh8/s8vcbAUyfD56
 2Krw==
X-Gm-Message-State: APjAAAVHrmIUuOElhoyejVGky79C0SSjrL6dtOle1I3RCMkcLt7lzsf+
 Yw0syGDgKhN6A7qCov35QN0TJVwf1eWp9f37J7DdFg==
X-Google-Smtp-Source: APXvYqzFel1MHIQfAC2V/+LQOC61EEVCNemh2oHPxdCu/hV0u3t42FL87rQxEctwJoD35NlnEtRq1amyx4vdmHbMBUs=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr12325031oic.146.1575648550523; 
 Fri, 06 Dec 2019 08:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-34-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:08:59 +0000
Message-ID: <CAFEAcA8i+OChXefW=mUBAPt_X4kq54fKW4N7EPSW9S9HrNPouQ@mail.gmail.com>
Subject: Re: [PATCH v4 33/40] target/arm: check TGE and E2H flags for EL0
 pauth traps
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> According to ARM ARM we should only trap from the EL1&0 regime.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/pauth_helper.c | 5 ++++-

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


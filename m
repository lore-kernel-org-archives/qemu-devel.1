Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CC92071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yw+bit16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CC92071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWgy4-00045b-43
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 08:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWguL-0001Y7-Gh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWguK-0004su-Cy
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:17:33 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWguK-0004ry-5k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:17:32 -0500
Received: by mail-oi1-x243.google.com with SMTP id l202so15281242oig.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Eoa0lfMY/dObl6n1jU07eiShjlhAXJn3pHQGX+i6g2o=;
 b=yw+bit16jVKtWaJkeCOGVivkQTVovdmqgyVzo0Cd7DOBkZhI4mI2NcynOVtah/nOBg
 bgCtg55N5kWFvRerr+a9/Oy2AImrXrflZBtE0T3e2LdKOuOr89KSI08SalKU50SgWrNx
 zFvcAdb2O4a+rIhBhzdlcmHumbckgazjMDNt30t8YzWGtr7TMab3d79h4pbW40aFnilu
 HIXaPR7gwIurLNNsSiXx/JvbHxlimtcuMgo/83iCdOB6d+aBW/f5gLJU2bIXXW/31pcm
 jPoCiVsHaqZR5hS3ILdKP8x49zQ+61KvBDg40o3DbSms81uMWct831Y5KjkwDYuULXJn
 SQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eoa0lfMY/dObl6n1jU07eiShjlhAXJn3pHQGX+i6g2o=;
 b=s9mRBUl9UzkHD1Sbq2yOLN/My7h63UcZKeJaxARmgAznjUbVXlroD1pUaDju0YeiBQ
 8PO89H9ZCPcAzp+Qvsaz25P+0gcNOuWaErL8z0y4uD6nnN/PEhnW+n+Vng/yJAGP1WaO
 Ief3IxX/oO6avME+puKpJPPYKiaPKsgg5769hmu4ja6UWE+KJysC4X/hRKnYZiwXb2Ya
 0aQRK/aMgUwhnHqBWU9EzxH6JJxxjgnxb1EWYmjXkNlqo1ormy7Ux76NcM+bNPo81gz4
 ta44zPEiYiv2A903JraRIUaJdoXTyIItfuCvOXQ7nN/OHL7GXZVPKd7o1XgpgXZvYLhX
 7SpQ==
X-Gm-Message-State: APjAAAXFYdlGw4ZWlKokXG6H+4VdkYqVOzaCW6A/Ks+xjsSjMr1dpS/m
 9zg3x6N4hcr3oFr00PAHDVfA0wZ5bplLedLNMymMiA==
X-Google-Smtp-Source: APXvYqzuQig05ca3QrdZQGwVzPvfDJ9uNj8DohDFaaVTMQs7n5YB13lrgIcbnubHu3CBUOXtZF6gITUXsbEiIRVn5QI=
X-Received: by 2002:aca:a9d4:: with SMTP id
 s203mr19534692oie.146.1574083051203; 
 Mon, 18 Nov 2019 05:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20191117090621.32425-1-richard.henderson@linaro.org>
 <20191117090621.32425-2-richard.henderson@linaro.org>
In-Reply-To: <20191117090621.32425-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 13:17:18 +0000
Message-ID: <CAFEAcA9A95+Nq7+YYZ4_gvg1_CFKRPR0-wGNdT8v524kqTyUJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Do not reject rt == rt2 for strexd
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 Nov 2019 at 09:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There was too much cut and paste between ldrexd and strexd,
> as ldrexd does prohibit two output registers the same.
>
> Fixes: af288228995
> Reported-by: Michael Goffioul <michael.goffioul@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2ea9da7637..b285b23858 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8934,7 +8934,7 @@ static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
>          || (s->thumb && (a->rd == 13 || a->rt == 13))
>          || (mop == MO_64
>              && (a->rt2 == 15
> -                || a->rd == a->rt2 || a->rt == a->rt2
> +                || a->rd == a->rt2
>                  || (s->thumb && a->rt2 == 13)))) {
>          unallocated_encoding(s);
>          return true;
> --
> 2.17.1


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


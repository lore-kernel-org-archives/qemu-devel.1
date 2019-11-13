Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F6C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72992084E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JP5K/NCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72992084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrqZ-0000IN-Sd
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrpD-0008A3-F2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrpC-0007s3-Dd
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:32:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrpC-0007pv-6T
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:32:42 -0500
Received: by mail-wm1-x342.google.com with SMTP id f3so1802848wmc.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 04:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=E7TSBkcarWyfiqsr4amM+cZj8eRrNuckggjlGrvXxaQ=;
 b=JP5K/NCgEw9DyypMbilZHpBkxJU4R8cKab/N9pRJgtN3z2fBni05wvsa+aOQoHwdrX
 +/XsKTNyKWXTYF0EBNNfz2AE56hh4caY941xv+AIMRiAmIlS6uYRjK0xIUtYVl9iZ5YF
 CvlmLeLRwLVArxQTFwbiggqmyH9KuooQz/JzSfwm3aK43EBTrTexb+xCVEdt7JJcSUkY
 FG0Beqe6n+H9mpPPqYIiGhCEW7lhHR17iZoG6UAghM53hFrIpzp++VQsuhL+fpSf/W8I
 4KQ+D2nJt06DashvCWyjO2RhLSjNlKYLghKW/kqx50uJwG9XuhFrt821WF5gGyrQ1Dm+
 sQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=E7TSBkcarWyfiqsr4amM+cZj8eRrNuckggjlGrvXxaQ=;
 b=IivmXt41OII5MYkQGZXQ68CMDm8UoFNd2cBVq1U5G8/wkeL6wPQuniRVVi2VzI7D8w
 7X9kk6r96EeDT3mvoa+6unt5ETUS6imI6oGnCOBsfIjVkZWIQ8kMCgywt9i/FXaV2vIM
 XAy5NKhTX62Ps9qDpNaCI5nR38KlVdk5r2nm7bDYCbmWqH5LC7FSJ4+FTX9dTCvGB/QC
 QsjIuYKJ2i1UK8H5hRzaVuYGerWkFqZ+nVOu0aXK4+D1b8TGJoIH/dPkjS6M/vT/flX/
 /KzvfV2oGQQuNLEZeuUaBiJE6gRLwteM+jAUIF2lkIRKQI+Fr6F/UqH7QE2YADT26tXG
 A8vA==
X-Gm-Message-State: APjAAAXIn5+HEHIirgYcU82iQX5WKHhCO4ZjSqme5qG3czJ5VdkJ1/wS
 ElWZwYFg7BP3+kdBg4OBwdIUg8nwy2k=
X-Google-Smtp-Source: APXvYqzKqVp3IV+X/iqg31nigaicB7pzQUwe0E28F57Dgzj52VwMYjtCvzKEssIXlZgByGtAIGzRew==
X-Received: by 2002:a1c:1d10:: with SMTP id d16mr2737413wmd.14.1573648360003; 
 Wed, 13 Nov 2019 04:32:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i13sm2636420wrp.12.2019.11.13.04.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 04:32:38 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 479AC1FF87;
 Wed, 13 Nov 2019 12:32:38 +0000 (GMT)
References: <20191113005201.19005-1-joel@jms.id.au>
 <20191113005201.19005-4-joel@jms.id.au>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/4] watchdog/aspeed: Improve watchdog timeout message
In-reply-to: <20191113005201.19005-4-joel@jms.id.au>
Date: Wed, 13 Nov 2019 12:32:38 +0000
Message-ID: <874kz87y8p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joel Stanley <joel@jms.id.au> writes:

> Users benefit from knowing which watchdog timer has expired. The address
> of the watchdog's registers unambiguously indicates which has expired,
> so log that.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Use HWADDR_PRIx
> ---
>  hw/watchdog/wdt_aspeed.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 145be6f99ce2..8787c5ad0f97 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -219,7 +219,8 @@ static void aspeed_wdt_timer_expired(void *dev)
>          return;
>      }
>
> -    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
> +    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %" HWADDR_PRIx " expire=
d.\n",
> +            s->iomem.addr);

nit: spacing off

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>      watchdog_perform_action();
>      timer_del(s->timer);
>  }


--
Alex Benn=C3=A9e


Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B85C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7342072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XL6HB12A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7342072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAJJ-0002DC-PI
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUAHd-0008Os-9P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUAHc-0006dL-5m
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:35:25 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:36121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUAHb-0006cp-N3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:35:23 -0400
Received: by mail-oi1-x22d.google.com with SMTP id s202so5396996oih.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=RYchbCsHS5ydDK77jC/7+dOs+dp/ANIHTH+FLGCQ8FM=;
 b=XL6HB12ACXkVTUF2P1Wrvc8kuoV8JZFXmRNfnypcPWeGRRx70BJXJsAE1cZ4diGkmw
 1Eer6D8qSxNibggyw2Ae9306blWUZE60e5arXImecsen3g/OWutF2rDVKo2IPK4AroO9
 S6CiyMvvvTIZe6/iOObhrVAcfZCrqpvkBC2tZQv1HE1OgZjeJbk5ucxUbppxyQP+Lu4z
 684g5KSOkMsJwCJRbZvUIpi9lXt+UeWPsN8ZdWrwjeFRwPUIbS4cgUsNsXYtVnFnCIJg
 yNDV+7TJC24xugr5PcelvQxp/B2ahkcFfH7UIHWagAqJxJ1ksrU1r6cKZ7MwaVB4s7T9
 pJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=RYchbCsHS5ydDK77jC/7+dOs+dp/ANIHTH+FLGCQ8FM=;
 b=g6U1t5rvfvtQhxh3/PMQqMqcpVJ850MFjJ+L94AVi9yisSnIwVx0L7AQOGpE52L0Eb
 rjdm3alxlMzPSTON2f0RH2bVkWUE7z1j1OcTXcXXYqlqMPIJk+xCDoGSNA/OrA1ERlgO
 uH2e3Vhmjxil5PcQNqumcqdQ0u8xC9vy/bEz9J3FKp074K5ZAvIjPbyZe3IyIXYsVJye
 xGDwtxLQ0QNXpscM/iKLcT1MbC7FV7gDDRVJOz5Q3a0R4P6i052PFSATdNftJHNgIMLD
 N8eZGMyGGiG3BP2KJp+bW4f0/F553amRXPwrSWK19OUvGq7cJUCqIp3GWj/IBvnC6EAt
 PsOQ==
X-Gm-Message-State: AGi0PubvQd6fHMTSV7sCpV46XvAvCz7sRN5QG4XyLZUTWfx8TyaKyA4y
 qD/6qvSWVCGjbcRBePdktucQMmWg3ZpWHUhU+6ubxTTHAZM=
X-Google-Smtp-Source: APiQypK1ca5pUBWzUYszNGf6LV1YhJex0dd36jycx4Fh4yLfx1cqyI67SSIlTrnRwcYuGf1Ju36TiJuK/X7+Xjy74fc=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr1858657oia.48.1588257321611; 
 Thu, 30 Apr 2020 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-10-peter.maydell@linaro.org>
In-Reply-To: <20200430115142.13430-10-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 15:35:10 +0100
Message-ID: <CAFEAcA-VqU3Z3+cK-AGYQ-xT4vUcQyWUPYGKPpHq69XLwD5KRg@mail.gmail.com>
Subject: Re: [PULL 09/31] hw/core/clock: introduce clock object
To: QEMU Developers <qemu-devel@nongnu.org>,
 Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::22d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 12:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This object may be used to represent a clock inside a clock tree.
>
> A clock may be connected to another clock so that it receives update,
> through a callback, whenever the source/parent clock is updated.
>
> Although only the root clock of a clock tree controls the values
> (represented as periods) of all clocks in tree, each clock holds
> a local state containing the current value so that it can be fetched
> independently. It will allows us to fullfill migration requirements
> by migrating each clock independently of others.

> +#define CLOCK_SECOND (1000000000llu << 32)

It turns out that FreeBSD's time.h defines a CLOCK_SECOND
macro, which means this doesn't compile on that platform.
I'm going to rename it CLOCK_PERIOD_1SEC; it's only used
in include/hw/clock.h so not a big change:

diff --git a/include/hw/clock.h b/include/hw/clock.h
index f3e44e9460c..f822a942209 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -32,15 +32,15 @@ typedef void ClockCallback(void *opaque);
  * + at 1Ghz,   resolution is ~0.2Hz
  * + at 10Ghz,  resolution is ~20Hz
  */
-#define CLOCK_SECOND (1000000000llu << 32)
+#define CLOCK_PERIOD_1SEC (1000000000llu << 32)

 /*
  * macro helpers to convert to hertz / nanosecond
  */
-#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
-#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
-#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) : 0u)
-#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_SECOND / (per) : 0u)
+#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_PERIOD_1SEC / 1000000000llu))
+#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_PERIOD_1SEC / 1000000000llu))
+#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_PERIOD_1SEC / (hz) : 0u)
+#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_PERIOD_1SEC / (per) : 0u)

 /**
  * Clock:

thanks
-- PMM


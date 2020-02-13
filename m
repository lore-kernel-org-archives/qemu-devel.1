Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE20C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17642217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkhrBQJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17642217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EkA-00042N-0g
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2EjF-0002uM-LS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2EjE-0006eq-Bb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:40:29 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2EjE-0006eb-6K
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:40:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id a142so5761015oii.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ljVj4STwM5UNaWAh2zvHFBMVkqOCUqG6AOnHf75eF+8=;
 b=rkhrBQJdvwmd+vWrfXS+jqxjpI5yZV6ZpKIJXxQu/m2ZnFsYM2kwJDBsNTtrIJj+EY
 ZXrazrva8sHjPGEqMb2dFjvl88yJJlW9/QzOI9pAt6hXnZuI++RRs7E65/FB+Xaj+7lu
 YYYoI8IgOtCVM/ioPDgSnwCh9VP98MzWAZJays2dzH2JYSD6JC/LIjllZ0rqfgcQCeHC
 8IqDjm9PNcfJVmbjdMUnOnPggHoeLuXzXJ6glKVQp78TYSH7LwJ1HBqBVR9ZDvxheSY6
 DsAgyb2UAcDJOoa2ToTeb7Ms4BJJsS0E4IsGNHrpr7nNw2DspZUcKmfsdocasKuk0JnX
 Lj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ljVj4STwM5UNaWAh2zvHFBMVkqOCUqG6AOnHf75eF+8=;
 b=X05kZuvIvx0uuuG25n9Abl6q6KuGo4f0OoThHACtznjpm1bKN/X1ZVB4hjbxHTPmEN
 lXK0Se3QUQMdTSW7xrj5U2SR1CHt2jhHPlhgVNzqGO+PpsliG/5lvHvI8gD2GRxFVCq9
 I1Fy6Cx0+uWRtR2pCojJ1wHGYubslhYtvKmu8aYQ5MGHdOCvMcyL0Emqb1kkSDo+BqiA
 9iTQl1NcGUTKBcBwyStQ1WlajhpDp1vG1cJfadiNjtfNroXwwINMgTj0QSZQoZQrrG7v
 3M8T8kguSeEXxwOKLDOrvpQ5ZJ1qyV6z6gZJpCxbZfxFIkdkTKT4kNF5KMM75b4hp1VV
 6NDg==
X-Gm-Message-State: APjAAAWS/Id1GRdGH+/EXfyQY1XOzTm4urOKaTN+K3PtFlZbu7yw9cqF
 ic5kMfC8kQpZTfEHji9JbA7o2MDIlz+2MwHbfhQjZw==
X-Google-Smtp-Source: APXvYqwIyWZdD8h0CO6dZxpTzJY1GEluzyAvM3jjKxZf/2ASw6qo9UAR19w5dQBWj002ucNrUZ6StqKg21qmaMWac6k=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2986112oiy.170.1581601227184; 
 Thu, 13 Feb 2020 05:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-4-f4bug@amsat.org>
In-Reply-To: <20200208165645.15657-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 13:40:16 +0000
Message-ID: <CAFEAcA8raRKW5OYJzO1kHs263_uJ_LucCa9tKgg70iX0jGqcGQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] hw/arm/raspi: Extract the version from the board
 revision
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 16:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The board revision encode the board version. Add a helper
> to extract the version, and use it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 818146fdbb..f285e2988f 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -16,6 +16,7 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/arm/bcm2836.h"
> +#include "hw/registerfields.h"
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> @@ -37,6 +38,28 @@ typedef struct RasPiState {
>      MemoryRegion ram;
>  } RasPiState;
>
> +/*
> + * Board revision codes:
> + * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes=
/
> + */
> +FIELD(REV_CODE, REVISION,           0, 4);
> +FIELD(REV_CODE, TYPE,               4, 8);
> +FIELD(REV_CODE, PROCESSOR,         12, 4);
> +FIELD(REV_CODE, MANUFACTURER,      16, 4);
> +FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
> +FIELD(REV_CODE, STYLE,             23, 1);
> +
> +static int board_processor_id(uint32_t board_rev)
> +{
> +    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
> +    return FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
> +}
> +
> +static int board_version(uint32_t board_rev)
> +{
> +    return board_processor_id(board_rev) + 1;

This uses the 'processor' field, which basically means the SoC
(0 for BCM2835, 1 for BCM2836, 2 for BCMM2837, 3 for BCM2711).
We use 'version' for a wider range of things in our code here:
 * do we need SMP setup?
 * which address does the firmware image go?
 * do we need to set up SMC vectors so no-op SMC works?
 * as well as "which SoC do we instantiate"?

We think of 'version' as basically "raspi 2 or 3?", but
according to the table in your url you can get a version of
the raspi 2b with a BCM2837 SoC, which confuses this idea.

Anyway, since what we have in this patch works OK for the set
of board models we support, I'm happy to leave the patch as-is,
but maybe worth checking and considering what in our code we
should really be making conditional on "actually the SoC type"
and what on something else...

thanks
-- PMM


Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0945EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA9C2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUP+aFt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA9C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwQW-0001Wu-2D
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuwPv-0000xm-NR
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuwPu-0002fi-Cr
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:42:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuwPu-0002e0-4k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:42:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so1398246wrr.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=56X4lhl7aUsrpjShD+4augsF21pKrzc55x7wSaRwTgQ=;
 b=NUP+aFt/Wp2O9lVrcoF3I3kWqJitIZlkZpebR+wHFsHCLre7xhIAlbkFh2GeenmL+/
 GRiThvSbYjYHnhI5lolFYa+WzX83NEHxqRPx6AuYavPzrvdyTOtpKYQ1iQlDeUq4SuKQ
 63YQinYBVHbFCLyT1iiQx8d9BvXXa4FqkGpa90/kpFtt8OC465xr2jWR5vwI8xXLlCeg
 0/TiF/BxdwQckmKN2yYUNSNVI8OXiqffkVyF6mxs/JT1NDqUS1vf/B/XkJF0FdjFOO4g
 NFSehBuQTeUKFJeKeD/EUbw8khXQfnPGRztK8QWkLvtxUmXAlbYSYUlV+tMhHxqzFKDa
 IXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=56X4lhl7aUsrpjShD+4augsF21pKrzc55x7wSaRwTgQ=;
 b=We4dTc7zFmJYVrskwl9O2YJHmNdiKEJ8lQy4/VtKlOV9NjYxNthfhn2iknhwkLiC11
 DsaTZ1IFagck3NfpJVs1gKb4huPZRghvnOypygKpT2FQqSzog3IPcmPNmiImwSyUDeR4
 CYDPVUEzOH5R0OrzqdfHRZBDykNgvtlCfVlv5D2OXrU1mLKzQwB/STRrQyTFcTPRL447
 mK5kot5IcJONYHBG0zjSyFjV2fkg9Mkf5+MnDz2qY3DpaJl36X2gCbszO67UHY06D1RK
 wvb86ViVNfOPMAXhCPyHrWP+j6HCiktiqtudtLvr1GIYjTBm4n7jTuzWPZq0G0asDqTH
 QkOg==
X-Gm-Message-State: APjAAAX9ynF4Z+T5ph7sUwvJHwrbv6rzZLeWnfyLH5eALkj8wqmFYd2Q
 omQ/Ig+oxsPV1s6S3F9ts/rP/A==
X-Google-Smtp-Source: APXvYqw2ELldAEOVUsONVf6STrTmfIEZ4vnSByUyHFX7DixVZ6YtEb4zeLjZ+IjXNAxJ7zoH/8sGfQ==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr3544652wrr.65.1579862540848;
 Fri, 24 Jan 2020 02:42:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm7021817wro.85.2020.01.24.02.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 02:42:19 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 18C7A1FF87;
 Fri, 24 Jan 2020 10:42:19 +0000 (GMT)
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-13-f4bug@amsat.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH rc2 12/25] hw/timer: Add limited support for Atmel 16
 bit timer peripheral
In-reply-to: <20200124005131.16276-13-f4bug@amsat.org>
Date: Fri, 24 Jan 2020 10:42:19 +0000
Message-ID: <875zh1yw38.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, S.E.Harris@kent.ac.uk,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, me@xcancerberox.com.ar,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, dovgaluk@ispras.ru,
 =?utf-8?Q?Marc-A?= =?utf-8?Q?ndr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 richard.henderson@linaro.org, mrolnik@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> These were designed to facilitate testing but should provide enough
> function to be useful in other contexts.  Only a subset of the functions
> of each peripheral is implemented, mainly due to the lack of a standard
> way to handle electrical connections (like GPIO pins).
>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Message-Id: <20200118191416.19934-13-mrolnik@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [rth: Squash info mtree fixes and a file rename from f4bug, which was:]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use qemu_log_mask(LOG_UNIMP), replace goto by return]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
<snip>
> --- /dev/null
> +++ b/include/hw/timer/atmel_timer16.h
> @@ -0,0 +1,94 @@
> +/*
> + * Atmel AVR 16 bit timer
> + *
> + * Copyright (c) 2018 University of Kent
> + * Author: Ed Robbins

No sign off from the author here?
> --- /dev/null
> +++ b/hw/timer/atmel_timer16.c
> @@ -0,0 +1,605 @@
<snip>
> +
> +/* Helper macros */
> +#define VAL16(l, h) ((h << 8) | l)
> +#define DB_PRINT(fmt, args...) /* Nothing */
> +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
> args)*/

Format strings are likely to bitrot. Either use a if (GATE) or
tracepoints.

<snip>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


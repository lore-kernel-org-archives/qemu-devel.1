Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2741C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F01E2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNWEKzyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F01E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ccM-0000gG-K3
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7caj-0007Q4-O7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7cai-00016w-KG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7cai-00016S-D7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id n7so17493575otk.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IQlmv4Fm0/2xbdCR9cFvvIB+nuOZ+HtDl18JGwG/mhY=;
 b=VNWEKzybiwWiYfL6JHg4n5toS1BCqueZ0AsBx6Y/Lapp3VBs+EtuRY8+IJ0QnvxpT2
 dkBYB6mgH3AsbsI5E6MPf9iJ7hYgyHhcaX0S5aQ1FNt39NTcbZtRl6aePGL8ugcYQnom
 UZFfY9Snt1JMi5SJOuRvf+ahHrHG07gnkvRE+az5AUKmEneKUiuNTZmX/5jeRSw1eMHA
 NAbTjbFlGxyTOBY8dSNGiDYHkUH53Y+ZW9McuG+0GgH99LGrAgGEH8JsOjNSx4sXaKt3
 7qsnnye4Hmae6XuMIdnyn3NnGj+7q/IvNY0LwJKqT18xCS6HgricrEHmV4PU78SqAkTz
 zmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IQlmv4Fm0/2xbdCR9cFvvIB+nuOZ+HtDl18JGwG/mhY=;
 b=C3FUx7lRRFypx/8CX14KHjH3n0yAtFRzmYaYV3YddU/sxXucR6/IFWug1C4FU+QgrV
 L5LriHVeJ0hLGOW7m5HTm1LXZbwsRFWq1bfaOIIt3T2WYxmdHaRS+0xOZl5Hb8znIvTR
 aj0VAO2FQFAtv/D7LncrzFqZezP7cKcep2fwrWJpm2obatar7zZrJVlPmYn+32KVBH29
 r0H1iZreGJkvKRYP4uoWCdsiKwrv6HSw82QQXtVfEP82MhuGlaqFzCZHlJ+I/wSILS3t
 mpDqpOesjeGPV33QtVONJZEU0RD3XIkw4WQDRXzmYLkLJVX5vim8492emruquROtqLrk
 Ov+A==
X-Gm-Message-State: APjAAAUydRVibu1M1Zq8yTJW+wbyVPZmKLWHQcWJzQpLe4WIrDdnKZHI
 zoFkfsYngb7K6+aa8lQENf522PoNhxbRsjgWMKSRkw==
X-Google-Smtp-Source: APXvYqwFjcus5f2fxScfXB9nLzJuMyyK25fDImfzDhOn0n3WS9tf09+js0TxpC374U1d7YQWygHuX5gyq5k2x9fGAQQ=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr25493214oti.91.1568108259223; 
 Tue, 10 Sep 2019 02:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190910090821.28327-1-sgarzare@redhat.com>
In-Reply-To: <20190910090821.28327-1-sgarzare@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 10:37:28 +0100
Message-ID: <CAFEAcA8tZgoC=U5-K7m=Lq-vhb65-jPadjV6_mKAD7Z4_fXs8g@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 at 10:08, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> This patch fixes a possible integer overflow when we calculate
> the total size of ELF segments loaded.
>
> Reported-by: Coverity (CID 1405299)
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Now we are limited to INT_MAX, should load_elf() returns ssize_t
> to support bigger ELFs?
> ---
>  include/hw/elf_ops.h | 6 ++++++
>  hw/core/loader.c     | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 1496d7e753..46dd3bf413 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -485,6 +485,12 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                  }
>              }
>
> +            if (mem_size > INT_MAX - total_size) {
> +                error_report("ELF total segments size is too big to load "
> +                             "max is %d)", INT_MAX);
> +                goto fail;
> +            }

This function doesn't report issues via error_report()
(some callers intentionally have fallback options for
what they try to do with the file), but by returning
a suitable error value in 'ret', so I think we should
continue that approach rather than adding an error_report()
call here.

I agree that accumulating the size in an 'int' is a bit
dubious these days.

thanks
-- PMM


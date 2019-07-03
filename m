Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD7C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100F42189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7drvBON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100F42189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiHA-0005jE-BS
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hii16-0006XF-3h
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hii0w-0008Kz-Km
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:21:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hii0r-0008GL-AO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:21:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id w79so2555032oif.10
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JTkMCE+1bIWB/0Z/U0bRa72NBPQAxVasXUCfH3PLeXY=;
 b=X7drvBONTUTucuka9XX3VamKPHYyERqofusUtejXNYYBxM84HP9/QZyczm7KZ6sOJ7
 JicJaZltRXiWRh0L1HrzrKRokweS6oSgQI4V8OEnxDhLjn8MNP1kZGAMUyAicuDm0ZFF
 0PEQrlOf9Kbs3xqSPDJnkYaAQZvcpFU/V5wt+zlU1/BPoD4Ij3O6nKBVwMJ1djSSofcZ
 eEbeeqgfcyI80INYIgsFhrtau3Cb/HK+Vj96Q0emRtNxhPMHNLrj+Rp/v1M68X/DullW
 6e37lu/7QqhapI99nr7yz4bXHI4Cdm2qQggUfPxKSWtJpWyFfdiRyyTAf08XvSbZT0qY
 XP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JTkMCE+1bIWB/0Z/U0bRa72NBPQAxVasXUCfH3PLeXY=;
 b=tAXJgfUbsGWEGAlqGJHMCqqdoHS8aQ49RGqbfv3WcV0V6aqqnpeyU+KXHsvU2JrBeS
 X0gTB7L/NFJ1enqrQhp01OojHtFvT2Qz5S567R881ZMXifbXEYh5GJuC5i7hlkFZ3r4l
 1x2+cWvrfVfXaAyo8hgpWp4gDX1TdD4CrVUoAF39xsfJe+LATjghKB7urg48CVRVU2D/
 2rTzZ7RaKIpQLuXO2aLl9G8hTI25ai96VZPEheI6G2dZd9YojYhOXrOQJTjtcFQjE5Yi
 TpwH0u9pi1BqdPdcq1A+QZuJbv9897r8pNRqEBQb4IzlEwSFxPU5x1m+mm3dLxgJIyjk
 mwEA==
X-Gm-Message-State: APjAAAUOr6UynLBrvXnUkawghU08Py+O2/PjVyF3rpTQK14IY/uF1Kex
 YViGeQ26qymBNP7yYAXyZwmkiLAClcc4yIuqAZrbeg==
X-Google-Smtp-Source: APXvYqxdtpmn06eG98u0Ll2aGq5N5AmhKyDxk9mW9OX5/7E2YcMEA9zHfIvu/qoGFdiByn88ticc2X/CuDzZabINWG0=
X-Received: by 2002:aca:5cd7:: with SMTP id q206mr6787428oib.146.1562170895186; 
 Wed, 03 Jul 2019 09:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150542.12008-1-richard.henderson@linaro.org>
In-Reply-To: <20190702150542.12008-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 17:21:24 +0100
Message-ID: <CAFEAcA8SH6OfWQ=3okD23pdpvp0LuG4H=2P0xR3b19UcZoHfpQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/3] tcg patch queue
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

On Tue, 2 Jul 2019 at 16:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit c4e42a9c2b714de5cddabffe46c7789fcff49c30:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190701' into staging (2019-07-02 12:58:32 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190702
>
> for you to fetch changes up to 0c3c385c62759e1427f88c5fc5b0d9741a456807:
>
>   tcg: Fix expansion of INDEX_op_not_vec (2019-07-02 15:59:42 +0200)
>
> ----------------------------------------------------------------
> Queued tcg bug fixes
>
> ----------------------------------------------------------------
> Alistair Francis (1):
>       tcg/riscv: Fix RISC-VH host build failure
>
> Richard Henderson (2):
>       tcg: Fix mmap lock assert on translation failure
>       tcg: Fix expansion of INDEX_op_not_vec

Hi. This seems to cause an assertion failure running an
x86-64 linux-user guest:

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
-L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
qemu-x86_64: /home/petmay01/linaro/qemu-for-merges/accel/tcg/translate-all.c:2562:
page_check_range: Assertion `start < ((target_ulong)1 <<
L1_MAP_ADDR_SPACE_BITS)' failed.
qemu-x86_64: /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:703:
cpu_exec: Assertion `!have_mmap_lock()' failed.
Makefile:6: recipe for target 'test' failed

thanks
-- PMM


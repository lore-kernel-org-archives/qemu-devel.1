Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A2FC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085F62076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kY5TNCw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085F62076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBZ0-00023m-1Z
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUBWT-0007bW-Td
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUBTb-0002iv-5D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:54:49 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUBTa-0002iG-NK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:51:50 -0400
Received: by mail-oo1-xc44.google.com with SMTP id c83so1389519oob.6
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vI7YEddwhwTYmUdEiDq/Zu2AuyvZd87ySpyZoFxZea4=;
 b=kY5TNCw0e5A/ZG2j0nUSN2SiBJjCSXx2ORsPn9aLyq09xjKtcMIds4d0+RGJlQu4Gi
 nK2XhgCTJRZ8qUwpiaILdEAWLA2VEnmUKupEecfS2wtNI/Vfz9OF/WtqFMhG3i1NGG1W
 2qEoOV5pOt9WRFOrZkhPB1Jy3rlvD21nz+U5ftY++LUpT5q1m3k2QZEfYSUKM0wR7zS9
 In2NFAgMkcm0wa5Ey0aVorgV7jyWq4ozst3WWVMC7hpg/8vdXH8qpHltnmvdFDJv/PUw
 axPnwHRSggnIb9VLVRm4vNzdQjqttbJiI4a1Xj1AjEYvT8V/5q5s196EM1kJmItTdm7B
 l99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vI7YEddwhwTYmUdEiDq/Zu2AuyvZd87ySpyZoFxZea4=;
 b=FfZ0WBYu/Ulefr4TIUEbpR5/Kik8X+5pP0kIUETJH60l/JKZNw6kVfNn59uFEGu20i
 DjroIXiDbZXpiqCHw9HLOLP5EfX/HhSpWfbHzQye97oI9bcWoK0bbEiFvZs8gQNs+//8
 wNSxFWRqs5tuoUHckzF9PwjMl7dov9JFaBmTgWet+EZY5IEHKM5x0ErdwMWOb9yIIlRW
 NzIdPKCtKBxbvSYPane1V+SeHtEuC2mdODcdx9vYxcxbrwyPGpZcT9Dab6Cy5VOGrNvv
 beY+tUcco+ktjCaRe5vS1gScfOoAa7Lx30LvBcQgcXJeeWsgTnuXAWo02E9KW2V8aczA
 SKnQ==
X-Gm-Message-State: AGi0PuZ/m6EcQFMfNUCBqULjH3yddcC66jA/L2P49kLfxVapewcYZBGj
 qiKFq+ItKu+72OTNXyi2LNSfXSqEkTBMP6HUbp57Lxih
X-Google-Smtp-Source: APiQypIXgVka7EChvCP9ElaUiGgbjjjXYgXJvPgdacn770aQS8AwgvG+PtasFRUH55zwpBLkjijL1JPedOotiwKLb1g=
X-Received: by 2002:a4a:3113:: with SMTP id k19mr3419743ooa.20.1588261908584; 
 Thu, 30 Apr 2020 08:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115953.1158-1-fredrik@strupe.net>
In-Reply-To: <20200408115953.1158-1-fredrik@strupe.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 16:51:35 +0100
Message-ID: <CAFEAcA-wtZxUCNs_GV=sUtGjpPnvPEg2YgiBn6GDmPDE=G=s7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Make VQDMULL undefined when U=1
To: Fredrik Strupe <fredrik@strupe.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Apr 2020 at 15:54, Fredrik Strupe <fredrik@strupe.net> wrote:
>
> According to Arm ARM, VQDMULL is only valid when U=0, while having
> U=1 is unallocated.
>
> Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
> Fixes: 695272dcb976 ("target-arm: Handle UNDEF cases for Neon 3-regs-different-widths")
> ---

I'm going to apply this patch to target-arm.next because
my refactoring of Neon hasn't got to this group of insns
yet, so putting the fix into the tree is the easiest way
to remind me to handle it during the refactoring.

(The other patch is in code I've already refactored; I'm
planning to send out a series with that refactoring shortly.)

thanks
-- PMM


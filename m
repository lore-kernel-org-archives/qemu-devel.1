Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98C5C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AF9206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oigkThx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AF9206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP33R-00078V-Or
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 07:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP32c-0006at-F2
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP32a-0004kK-Ep
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:50:46 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:47053
 helo=mail-oo1-xc42.google.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP32Z-0004jH-NF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:50:44 -0400
Received: by mail-oo1-xc42.google.com with SMTP id x16so583637oop.13
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LKuKZtmCFBBOmi/nYr8sqZGUnzBbIaXVXTkItTpLj8A=;
 b=oigkThx6KdQRyopIMQrInSKMs4GtZogaiLtjPtYL2f8MqEsn54NxZdO+f6NYn6wkCl
 lP8OwypkRNAynRyQjKF8MqbQEiZwcY0rN4F5Kr1KSDZ/pMikaeFdQOMnbyNlxtWCPgTv
 yPpsy9e1N4irqpEepX6TksKDQa7taGJA6W5RQiDoVuggglywclnrQ9BrcAfqmPFs3GpN
 rjzvGWycnQOmv5ytRGaFAE5tRw1CX/Jw/uATfm/mp0TSZDHQn1Lq3wdUPLdiuPLg5yLd
 gU2DMDnHucQ1irM2bFKeHHo13RY3J2tDzB3Gc/0bd4/asPv/eZ69EQDwsMNo51zQHh5U
 zUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LKuKZtmCFBBOmi/nYr8sqZGUnzBbIaXVXTkItTpLj8A=;
 b=YjkEGDoEFWWsxwQDjH9i+Uyqp47YGBM7IBlHLjkE0pL+bTmjfqI7ujbl0Q3U9/wJ4J
 K0cKJIJylK4WtXcyrl6vhGpNe5Cq/ccgwHq7oSYLno6ebO7qHiFhr8c0W1spg52IsaFn
 KsINRNsvOY8/cWHRJQzKRvF5T8eovEXBghKuw48ZHhPjTmmeDi4W5XcNEfch95BP9nFM
 h6AFUIXoTrQFclHeg7pxdAH7LjkLEBCKKsMOa/7aTyRNt2FsrUHnZlkKGm0aRDur7mXS
 72H/ZdcGGCGqW4M1T+voORRlhPB7XrwUgKbmAGPsKaxIIznhJY7Ektfob40ciWX+QTVO
 8fyQ==
X-Gm-Message-State: AGi0PuZjQnr86Hi+E9XN+IwdQxtgLGDoGnQ8V8p1UeIinOB4isod88yr
 MwJuYSutsk4n7oD7lZHfY3zhClhUnDiK69kWGLKdZw==
X-Google-Smtp-Source: APiQypIYqtf34XTvfXHIegU/YpjpBYvBJX3yNd36ELgPT05nNYZtsYzSwL+nR2s3odJyqxPEY74lJMzqscEGOrvF40w=
X-Received: by 2002:a4a:be89:: with SMTP id o9mr19951207oop.20.1587037841852; 
 Thu, 16 Apr 2020 04:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-2-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 12:50:30 +0100
Message-ID: <CAFEAcA_Y_9Pp2fRq-AScsZmbdDmAQgw4fJMLERmp9PJqD5UMHg@mail.gmail.com>
Subject: Re: [PATCH 01/16] accel/tcg: Add block comment for probe_access
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


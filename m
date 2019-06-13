Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D428C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD88207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLnW4V/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD88207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRB5-0002TV-4g
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbQSc-0008FW-5d
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbQSZ-0000R0-St
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:12:14 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbQSZ-0000Jk-MY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:12:11 -0400
Received: by mail-ot1-x32b.google.com with SMTP id l15so19066989otn.9
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=C6QiO8uErXZZokJdLNEn15+EHGb1LJ+9RvsMnxntUow=;
 b=qLnW4V/OKTvyp1fyVzilGx1zfYniRYjvqhAeY2q3j8ENEOptEJA351bpUcEii4zrdi
 CG13bqq9xcMF9sc/fB65j58t1mbjvQsy319whA9dECnwlpf73Y76fqS/R6rOcMqIHPTB
 DG1IJXBTzFPYj8T1TJ8NOhHlEQuxPDd0ZO5Eo2gDvGsdv1y5TJc+AKvSmuL1nGOa57TM
 E/BVxeU496tFPmwSHdSnBMYoxYjUOEFgu4tq6HW0rm67CatyMDaU6s/7VrlxLCqUbFt7
 4tQk/fe4vKCOX6xnZsyNvkW5jEp4SOWRlKOxZujGmGvvk6aQVG4pdVvI5pdq4fX4HTRK
 HGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=C6QiO8uErXZZokJdLNEn15+EHGb1LJ+9RvsMnxntUow=;
 b=VVq5IYMLkMXDtWzeh7ToGjU3p2+T8KL1DabAEGMWqgxiI6q9QBhsSumQb9wXHVydk6
 hwiSpCvAyagkmuAzte0yp2blT2k7N7bxgw/+S4D5MFwcf6EMXRj4TyP10Y3HCoGM2o7D
 nDlh0t+M06uGJbdmNAo2AOuoWGwILo2TMvWCwK4Z4tbp6QXi1qSwpTAQay426tMB0zCT
 LhDbu3AkLYlOTKmIMjcL+nc/8+qlz+cNZl6eFnkpgkQWqziCt7+UTEXKYfsnq8zcQNvW
 1AFnz3Kp9YCDQLfuPXcln6G/qcAymTHZ5+YD28YhoVCLxBUI8bQ8Vqv7iIWCVWoQZfP0
 bEZQ==
X-Gm-Message-State: APjAAAU2gi1vqFgRVU4rxDRUAYkcDOb4kkYdBz3W/GLTMTriWWZkvKLy
 KpTwNUIYbmELZFUlbaQ3w1VmVFEHU5P/wUnYWXyF1VnCQ1M=
X-Google-Smtp-Source: APXvYqwdbWBu9pShLbeD7nMZNrl1mnTBA6d7bSzjsvVS6mZL52jWbHARu9VZEyx+SWbfu0iQXtxRc5PcA5aA/k5rRMc=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr4652217otk.232.1560435114948; 
 Thu, 13 Jun 2019 07:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190613121433.5246-1-peter.maydell@linaro.org>
 <20190613121433.5246-2-peter.maydell@linaro.org>
In-Reply-To: <20190613121433.5246-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 15:11:43 +0100
Message-ID: <CAFEAcA-5Fg7vpBvU58s-9MdQB+ZuuPjCq9nUED70fGSfgqYHLQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 01/48] target/arm: Vectorize USHL and SSHL
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

On Thu, 13 Jun 2019 at 13:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> These instructions shift left or right depending on the sign
> of the input, and 7 bits are significant to the shift.  This
> requires several masks and selects in addition to the actual
> shifts to form the complete answer.
>
> That said, the operation is still a small improvement even for
> two 64-bit elements -- 13 vector operations instead of 2 * 7
> integer operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20190603232209.20704-1-richard.henderson@linaro.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi Richard -- I just noticed that this patch seems to
regress VSHL for AArch32.

     160:       f3026408        vshl.u8 d6, d8, d2
with
  d2: 429de8b85a8dee77
  d8: 279cd30880000000

now gives
  d6: 00000000008dee77
when previously both QEMU and real Cortex-A7 hardware
gave d6: all-zeroes.

(this is testcases/aarch32-all/insn_VSHL__INC.risu.bin
from Alex's set.)

I'm going to drop this patch from the pullreq.

thanks
-- PMM


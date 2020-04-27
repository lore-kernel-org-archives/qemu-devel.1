Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940BC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419F02063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIOiYKIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419F02063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1ax-000300-Ce
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1Yb-0008MS-C6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1Ya-0003Ay-BE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:04:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT1YZ-00033O-Tw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:04:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id c3so25379699otp.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HvlQefAiz25NF63fuWVIv5v7xOmESVGyuHEcJqxJtyI=;
 b=xIOiYKIGU9uUamWZ8nUVsg8mnsF6WiZ/ngYXzhb0MxLOiYDehDliPwevgVLLQ0cTvC
 N+GkUorL+6eFsKbauyhxeQtFtGp1Ah2T6G4Y/I3Zn1uA8R7ALKbOA8Xry4TjAgI3xzfL
 eYs2Eu3dGgrnWktHd8odzURzXqKS70sIdVYUTFSFM2wqRFwmrGwvlrANRjAHGEj3Huh3
 z844aZaubBxGY65XZ4G0mqX/FM4H+xFNJtIyV7NMl9JudPmFwVQVmqnJ/NDLMvRcgxyU
 hNV0KnMW7smmILgQMFjnCb4JfzS+aDSR58RUqa5XtUc3Su43whBN/3I+cCGLhOXfAS6o
 jHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HvlQefAiz25NF63fuWVIv5v7xOmESVGyuHEcJqxJtyI=;
 b=g3TJ5qCnmnCxVO5Wvmp9QT7YV2rxZ4EOhMAfvQtet8iehIosxtY07YzPGSWZPWKYBm
 j4yD4ZDcBmltullDuLG+867V8sQijaMerAvI/2OZE/vJqhJfuFbFobrH/TSgXF8vquBQ
 oZJiup2XWG0em+P1GyzfzI085KQzs9pYDpYqaSbM/s0jgf3dzk1msGcVcpLl1+TFYqxw
 JEQdOuSdKSQGhbxOrALEhTzbExfMEwV1XhiesVeMciUw+IMyOO6nQWIjyEjGWnQDxfAi
 YF74DdXZn6mL6yTduArHhKs/0Ue9kiaa/h67Hq9v676YGsxSTqLeORwu+agRvlGQkVOd
 D7YA==
X-Gm-Message-State: AGi0Pua5oQewhDiHs7BWnAbzjQER+KHB4W8E74IJ7qBBeFCMTPEUGA6G
 8anznP5kXGSjDOxLZev5zFtXox9CiIwZjV84EC7MKw==
X-Google-Smtp-Source: APiQypJ91BHYsRh/KA0PtJSm326Bn0HgKwqH1Va5bC+x5Q3V80ai3wxXKaS7IiT1PCDHKfccQdPE1gXV4gBhFj5ZekI=
X-Received: by 2002:aca:c751:: with SMTP id x78mr15440249oif.163.1587985450446; 
 Mon, 27 Apr 2020 04:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-14-richard.henderson@linaro.org>
In-Reply-To: <20200422043309.18430-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 12:03:59 +0100
Message-ID: <CAFEAcA8oWP9XGzD+pb_VhDth8zx8j1Gz4vwiK+dArpw8x1BmqA@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::343
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

On Wed, 22 Apr 2020 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With sve_cont_ldst_pages, the differences between first-fault and no-fault
> are minimal, so unify the routines.  With cpu_probe_watchpoint, we are able
> to make progress through pages with TLB_WATCHPOINT set when the watchpoint
> does not actually fire.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


>      /*
> -     * Perform one normal read, which will fault or not.
> -     * But it is likely to bring the page into the tlb.
> +     * From this point on, all memory operations are MemSingleNF.
> +     *
> +     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
> +     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
> +     * If you map non-RAM with Normal memory attributes and do a NF
> +     * load then it should access the bus -- but doing so is illegal.
> +     *
> +     * While we do not have access to the memory attributes from the PTE
> +     * to tell Device memory from Normal memory, we can validly assume that
> +     * non-RAM has been mapped as Device memory.  Thus we indicate fault
> +     * on all MMIO.

I still don't understand why this is right. All non-RAM is MMIO
but not all MMIO is non-RAM; so you might have something that's
MMIO (at least for the moment) and has been mapped Normal. That
shouldn't fault.

> +     *
> +     * Similarly, CPU_BP breakpoints would raise exceptions, and so
> +     * return (UNKNOWN, FAULT).  For simplicity, we consider gdb and
> +     * architectural breakpoints the same.
>       */
> -    tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
> +    if (unlikely(flags & TLB_MMIO)) {
> +        goto do_fault;
> +    }

thanks
-- PMM


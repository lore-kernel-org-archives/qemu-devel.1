Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA8C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C873206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+wYjquz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C873206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1N9-0007O0-Nr
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1MI-0006MI-8r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1MH-00059W-RT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:51:30 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT1MH-00056i-Di
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:51:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id b13so25376890oti.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4OBh4ec6GjwKLih0OoWVeBTKaaXA382J+Kz6YgpfMUc=;
 b=k+wYjquze8NFFaoMrV6C3I4N2K0AJzVLTlj6v+FLdJ98jjp1PJMNhsIZM93WD2cd7J
 BOrluea43f/fcV7KoXiX0YpatptJaMeJFrqkPGoOWXIzWXDgJ+Vrli+SeO9FL4IJJtnr
 FWABX/BEkLIrATGhawjR/0Pb8jgpts2oTwsKQJ8Xbhj3Keho/xZMzHYxYsIETLtFsY7L
 h2VafDqbte5N/JPLxyM/OjWGxcmKdrGq1cPEEtHhdA9peeHggDC6n5KImKyNYWWhp7vB
 MsXnMC7c/fC080EF/owRalgKMLGK/+PEZaSbNWkBBwxQqmiWtbKeJ1i0aTw03Dhjr4+E
 +xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4OBh4ec6GjwKLih0OoWVeBTKaaXA382J+Kz6YgpfMUc=;
 b=ebnRzJLJllmw9C0ouweSnhIdnEvyX8H6HZlawuR/klx/L7XWnRDeO+Xv+E5DgvzHu4
 YcAK91faWPSe5eT0U4w13HiB1VPG9ymkYj6OreWcScAWWIUAk7a/RJT3w6reTzn66xad
 D/JloCZs93z3OyVnxGG+w/LmXrhKK0KUi/PC/12c/UzEdrxdJDpOhrhiyZ8vZKydM309
 Ic93QEsv4TBHIcF/PI4sdTbhlmmRmIfLH2a6+ySYyS8+V+wfQb1XM4l0H7VgEg2T48V8
 ajYyXcwiBPzw+4j5FonHzW8f8Zl0eaPiorbB7KezQk9UwZG1QV1MbCq2qONQvpyYPtGX
 YD5A==
X-Gm-Message-State: AGi0PubZHQtP+wnR6LVYSmWwv4rvNTNmwAcHg0s7SwMXWPLms1WsdaNE
 mjV1UJiWB/nQtZhAOFq5MupIzKOufwpkALFbP9MLcA==
X-Google-Smtp-Source: APiQypIwYgEy53kURO5Dmgtw2Pp6vzPMmsBzt5j6sI41ydpnyt8UrOWQVBCzAo7Qv93YaTR7JMnzRHmzy2qJWYfMvlQ=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr17453149otj.91.1587984688271; 
 Mon, 27 Apr 2020 03:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-7-richard.henderson@linaro.org>
In-Reply-To: <20200422043309.18430-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 11:51:17 +0100
Message-ID: <CAFEAcA_tokLPQXCU64=FrC=dWGD7PAoPCuj=Z46pxbtWywEvfA@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] target/arm: Use cpu_*_data_ra for sve_ldst_tlb_fn
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
> Use the "normal" memory access functions, rather than the
> softmmu internal helper functions directly.
>
> Since fb901c905dc3, cpu_mem_index is now a simple extract
> from env->hflags and not a large computation.  Which means
> that it's now more work to pass around this value than it
> is to recompute it.
>
> This only adjusts the primitives, and does not clean up
> all of the uses within sve_helper.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


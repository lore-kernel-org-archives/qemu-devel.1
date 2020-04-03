Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAAB20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4eXJJ87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAAB20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKzd-0005K9-1h
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKKys-0004kE-6M
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKKyq-0007Cs-VN
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:59:25 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:46545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKKyq-0007Cg-MY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:59:24 -0400
Received: by mail-ot1-x32f.google.com with SMTP id 111so6900269oth.13
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rVMhZqUPGlUbxzAZJ/IO4L8uoCfj6DV0BgZYGjqkXZg=;
 b=X4eXJJ87KPRRdG3NK7U+glGjOtx6ra2QisbhitBCp18INwubUMWQktCpxEo1sjU7sj
 ibNLlgJGt9p00XoXG6a+WaVGI6M/GJg31NGh5yCPcQNrydIJn3tWE5gC5n+Yus9+r4hw
 BSZRT5wp6AuJwv9dfH8TLZD4ndQVxnIVyPdBcBBEV4d3TMP09g/cHBm4lWkoUeJflYwo
 sPUBW5OOByhVa0c3RiUSyvmmQGXZUPZci5aHHPVOP7O/i5kA8Qu33igijX5Kh9tnvBMi
 P4cY4Paua6T3CThEiC+RtUhHU5YevFPLSJfIoQkL6AEQIEzQASVtPXwIWKwUQDz3V5pS
 XlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rVMhZqUPGlUbxzAZJ/IO4L8uoCfj6DV0BgZYGjqkXZg=;
 b=j2p2ZwQr0Api4i/z5g/80GBXv+WwhIkExU5Vut6fT/K/sperXcqqWrwvHw0JNKM3jP
 K26Karotvmh3Seprj4BfE1DHKt0QZRv0Y/bPQfjNjf1DUui6TZwcWZW1p39bYReKYqSj
 WTWFqkbY4KB1eVT08x30LjTJLw1dDf4bPZ8wypxQpNpgxUclcvUJV5tVO3PFC/foXDd2
 +69OYuxGXETC/27cmUHxHKX5xxJsqLpzbCRlbPgOh4cXaIhEFmQa6FkoiMVuttIDBC2e
 8FoK0hLi55Puf1FHUszAhaxHJO5O3QBdMfbF+4B405W93DGBVKbzdmVtC92JupK+0SV0
 uNvA==
X-Gm-Message-State: AGi0PubcN5PnCovZBQ1Ykfr0mCAFn5C8dstnlZ61sg86Ovw+2QxiZboK
 u9VbQSYnLvy+hcERwnE3nBU8/7pJ+MziqBLVtedzYg==
X-Google-Smtp-Source: APiQypL/tcbavsVBYVYrsHdZSKaqwbyX3ajlvHNCoLf7uHMdEauKfms/8LapKarpmkATWh1cDFjn1J00rOJ5pYLeQtc=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5714180ota.221.1585915163801; 
 Fri, 03 Apr 2020 04:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200402222051.523093-1-ehabkost@redhat.com>
In-Reply-To: <20200402222051.523093-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 12:59:12 +0100
Message-ID: <CAFEAcA-4MPW1g1piKWVvMq+sS862c7+2SXfxW9J5LyfiK4oQBw@mail.gmail.com>
Subject: Re: [PULL 0/9] x86 queue for -rc2
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 23:20, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> This was supposed to be submitted before -rc1, but I've dropped
> the ball (sorry).
>
> The following changes since commit 2833ad487cfff7dc33703e4731b75facde1c561e:
>
>   Update version for v5.0.0-rc1 release (2020-03-31 18:02:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to d965dc35592d24c0c1519f1c566223c6277cb80e:
>
>   target/i386: Add ARCH_CAPABILITIES related bits into Icelake-Server CPU model (2020-03-31 19:13:32 -0300)
>
> ----------------------------------------------------------------
> x86 queue for -rc2
>
> Fixes:
> * EPYC CPU model APIC ID topology fixes (Babu Moger)
> * Fix crash when enabling intel-pt on older machine types
>   (Luwei Kang)
> * Add missing ARCH_CAPABILITIES bits to Icelake-Server CPU model
>   (Xiaoyao Li)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


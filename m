Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2987C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736C9214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736C9214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irXKl-0006hi-LZ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 20:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1irXJg-0005l4-N9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benh@kernel.crashing.org>) id 1irXJf-00051R-K8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:17:52 -0500
Received: from kernel.crashing.org ([76.164.61.194]:54426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
 id 1irXJd-0004xu-8y; Tue, 14 Jan 2020 20:17:49 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 00F1HbRe009195
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Jan 2020 19:17:41 -0600
Message-ID: <3ab2ca1f7a9b37b201a58f3a817edc5193e8b1f4.camel@kernel.crashing.org>
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jan 2020 12:17:35 +1100
In-Reply-To: <CAFEAcA-A_caQgwi5DzExdZChoTg-Qa73hq7Ho7dPLiN633Yj1Q@mail.gmail.com>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <CAFEAcA-A_caQgwi5DzExdZChoTg-Qa73hq7Ho7dPLiN633Yj1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 76.164.61.194
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-14 at 09:59 +0000, Peter Maydell wrote:
> Note that semihosting is not a "here's a handy QEMU feature"
> thing. It's an architecture-specific API and ABI, which should
> be defined somewhere in a standard external to QEMU.

There is no such standard for powerpc today that I know of.

> You need to start by having a definition for PPC of what
> semihosting is. If you're starting from scratch there, there
> are some important things you should do differently to Arm --
> there is no benefit to repeating the mistakes of API definition
> that we made! Most notably, you want to specify and require
> that any unrecognized semihosting call function fails in a
> clean and detectable way; you also should have a semihosting
> function for "ask for a feature bit mask" so you don't need
> the silly magic-filename approach Arm had to go for. You
> also want to standardize what the errno values are, which Arm
> forgot to do and which makes the errno handling in the spec
> pretty useless.

Keith and I are somewhat of a different mind here. From the perspective
of the user of that API (picolibc is one), it's easier to deal with a
single one and have everybody inherit the same bugs.

Now I understand the point of wanting to fix the mistakes made but I
would suggest we do so by proposing extensions to the existing one to
do so.

> TLDR: don't start by writing code, start by writing the *API/ABI
> spec*.
> I tried to push the RISCV folks in this direction as well.

AFAIK they are still just doing what ARM does for the above reason.

Cheers,
Ben.




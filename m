Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F742C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 06:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B69F20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 06:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B69F20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irFhg-0005OI-Es
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 01:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1irFh6-0004xq-VG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 01:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benh@kernel.crashing.org>) id 1irFh5-0005Om-Og
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 01:28:52 -0500
Received: from kernel.crashing.org ([76.164.61.194]:53876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
 id 1irFh3-0005Ka-FG; Tue, 14 Jan 2020 01:28:49 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 00E6Q1fA032280
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Jan 2020 00:28:33 -0600
Message-ID: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
Subject: Semihosting, arm, riscv, ppc and common code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 Jan 2020 17:25:59 +1100
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, keithp@keithp.com, qemu-arm@nongnu.org,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Folks !

So I started "porting" over (read: copying) the arm semihosting code to
ppc to mimmic what Keith did for risv (mostly for picolibc support).

I noticed that the bulk of arm-semi.c (or riscv-semi.c) is trivially
made completely generic by doing a couple of changes:

 - Make most functions take a CPUState instead of the architecture
specific "env"

 - Provide arch helpers to retreive the op, set the result, do the
flen bug hack and possibly a couple of others (I'm not done yet).

There are other archs who do semihosting completely differently but at
least those 3 can share code.

Any objection/comment on the approach ? What I'll probably do is get
things going first with my ppc version (which I made more/less generic
but still located in target/ppc) at which point I can post an RFC so
you get an idea, and we find a good location for it.

From thre we might consider fixing some of the worst crap in there
doing backwards compatible extensions if we care enough :-)

Cheers,
Ben.




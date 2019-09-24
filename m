Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6599C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5D320872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YlUJyc/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5D320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCcz5-0003KW-AA
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 01:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCcvl-0001GB-Tn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCcvk-0001vk-2I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:00:05 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46705 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCcvj-0001re-Bz; Tue, 24 Sep 2019 01:00:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46cps8217Kz9sP3; Tue, 24 Sep 2019 14:59:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569301196;
 bh=9NzoMqtDvCmAF/7Yv4ITRJ2EvJYSJatovRDejTD+MY8=;
 h=From:To:Cc:Subject:Date:From;
 b=YlUJyc/e8BYRTePs6K6057tu2yVGjAKByP2iaZD5Ew6EqFq8X9FyNS6o3ZgRDWHeC
 A2IB+Dp9VbBa+fmoYW9tgUKDEXC1OsKRdiVuGmd6YcRwbJuTGbNhT4O3uYwCEgMq7d
 xlX3bjEAj4yIiqAlCkJSlx26khLz/G0d7UCFf9Ho=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org
Subject: [PATCH 0/4] xics: Eliminate unnecessary class
Date: Tue, 24 Sep 2019 14:59:48 +1000
Message-Id: <20190924045952.11412-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XICS interrupt controller device used to have separate subtypes
for the KVM and non-KVM variant of the device.  That was a bad idea,
because it leaked information that should be entirely host-side
implementation specific to the kinda-sorta guest visible QOM class
names.

We eliminated the KVM specific class some time ago, but it's left
behind a distinction between the TYPE_ICS_BASE abstract class and
TYPE_ICS_SIMPLE subtype which no longer serves any purpose.

This series collapses the two types back into one.

David Gibson (4):
  xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
  xics: Merge reset and realize hooks
  xics: Rename misleading ics_simple_*() functions
  xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes

 hw/intc/trace-events  |  10 +-
 hw/intc/xics.c        | 211 ++++++++++++++----------------------------
 hw/intc/xics_spapr.c  |  12 +--
 hw/ppc/pnv_psi.c      |   6 +-
 hw/ppc/spapr_irq.c    |   6 +-
 include/hw/ppc/xics.h |  30 +-----
 6 files changed, 92 insertions(+), 183 deletions(-)

--=20
2.21.0



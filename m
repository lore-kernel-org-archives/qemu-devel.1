Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A04C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5006F20700
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5006F20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNvQ-0001OL-Rj
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iGNtR-0000AW-Av
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iGNtP-0002kk-AT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:45:12 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41304 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1iGNtM-000220-PW; Fri, 04 Oct 2019 09:45:10 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 218311A21BB;
 Fri,  4 Oct 2019 15:44:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 03E3C1A1DCD;
 Fri,  4 Oct 2019 15:44:02 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2] target/ppc: Fix for optimized vsl/vsr instructions
Date: Fri,  4 Oct 2019 15:43:58 +0200
Message-Id: <1570196639-7025-1-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: richard.hendreson@linaro.org, mark.cave-ayland@ilande.co.uk, pc@us.ibm.com,
 amarkovic@wavecomp.com, stefan.brankovic@rt-rk.com, alex.bennee@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes bug in optimized vsl/vsr instructions reported by Mark
Cave-Ayland and Paul Clarke. Sorry for not responding earlier, I was absent
last couple of days. I also integrated some suggestions made by Aleksandar
Markovic. New soultion is tested and still has noticable performance
improvement compared to old helper implementation.

V1 of this patch was not sent to qemu-devel and I am now sending V2 to
appropriate email adresses.

Stefan Brankovic (1):
  target/ppc: Fix for optimized vsl/vsr instructions

 target/ppc/translate/vmx-impl.inc.c | 84 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

-- 
2.7.4



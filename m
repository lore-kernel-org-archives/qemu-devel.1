Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9EC3524C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3731F20679
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iySSe-0004AY-Cw
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 22:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iySRN-0002iX-Bg
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iySRL-0006m1-FS
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:30:24 -0500
Received: from [107.174.27.60] (port=38966 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iySRJ-0006h1-8p; Sun, 02 Feb 2020 22:30:22 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 5E102AE8000F;
 Sun,  2 Feb 2020 22:28:22 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v6 0/6] spapr: Kill SLOF
Date: Mon,  3 Feb 2020 14:29:37 +1100
Message-Id: <20200203032943.121178-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v6 of an effort to implement Open Firmware Client Interface
in QEMU. The feature is described in 6/6, 1/6..5/6 are small
but necessary preparations.

With this thing, I can boot unmodified Ubuntu 18.04 and Fedora 30
directly from the disk without SLOF.


This is based on sha1
532fe321cf06 Richard Henderson "target/ppc: Use probe_write for DCBZ".

Please comment. Thanks.



Alexey Kardashevskiy (6):
  ppc: Start CPU in the default mode which is big-endian 32bit
  ppc/spapr: Move GPRs setup to one place
  spapr/spapr: Make vty_getchars public
  spapr/cas: Separate CAS handling from rebuilding the FDT
  spapr: Allow changing offset for -kernel image
  spapr: Implement Open Firmware client interface

 hw/ppc/Makefile.objs            |    1 +
 include/hw/ppc/spapr.h          |   29 +-
 include/hw/ppc/spapr_cpu_core.h |    4 +-
 include/hw/ppc/spapr_vio.h      |    1 +
 hw/char/spapr_vty.c             |    2 +-
 hw/ppc/spapr.c                  |  139 ++-
 hw/ppc/spapr_cpu_core.c         |    7 +-
 hw/ppc/spapr_hcall.c            |   73 +-
 hw/ppc/spapr_of_client.c        | 1526 +++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c             |    2 +-
 target/ppc/translate_init.inc.c |    6 -
 hw/ppc/trace-events             |   24 +
 12 files changed, 1744 insertions(+), 70 deletions(-)
 create mode 100644 hw/ppc/spapr_of_client.c

-- 
2.17.1



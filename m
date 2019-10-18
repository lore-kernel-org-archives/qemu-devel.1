Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48571CA9EC8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 00:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2305921852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 00:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2305921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLGVB-00083g-C2
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 20:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iLGSJ-0004Pv-2s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iLGSI-000177-4U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:49:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:15619)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iLGSH-0000zO-TP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:49:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Oct 2019 17:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; d="scan'208";a="199552611"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 17 Oct 2019 17:49:13 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 0/6] migration/postcopy: enable compress during postcopy
Date: Fri, 18 Oct 2019 08:48:44 +0800
Message-Id: <20191018004850.9888-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set tries enable compress during postcopy.

postcopy requires to place a whole host page, while migration thread migrate
memory in target page size. This makes postcopy need to collect all target
pages in one host page before placing via userfaultfd.

To enable compress during postcopy, there are two problems to solve:

    1. Random order for target page arrival
    2. Target pages in one host page arrives without interrupt by target
       page from other host page

The first one is handled by counting the number of target pages arrived
instead of the last target page arrived.

The second one is handled by:

    1. Flush compress thread for each host page
    2. Wait for decompress thread for before placing host page

With the combination of these two changes, compress is enabled during
postcopy.

Wei Yang (6):
  migration/postcopy: reduce memset when it is zero page and
    matches_target_page_size
  migration/postcopy: wait for decompress thread in precopy
  migration/postcopy: count target page number to decide the
    place_needed
  migration/postcopy: set all_zero to true on the first target page
  migration/postcopy: enable random order target page arrival
  migration/postcopy: enable compress during postcopy

 migration/migration.c | 11 --------
 migration/ram.c       | 65 ++++++++++++++++++++++++++++++-------------
 2 files changed, 45 insertions(+), 31 deletions(-)

-- 
2.17.1



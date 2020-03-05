Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C9D2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C9D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9siZ-0006Bj-8c
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1j9shg-0005lp-Gq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1j9she-0002HW-S8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:46:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:36303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1j9she-00024r-Ji
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:46:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 07:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="244307759"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by orsmga006.jf.intel.com with ESMTP; 05 Mar 2020 07:46:17 -0800
From: Jingqi Liu <jingqi.liu@intel.com>
To: mst@redhat.com,
	ehabkost@redhat.com
Subject: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
Date: Thu,  5 Mar 2020 23:41:42 +0800
Message-Id: <20200305154142.63070-1-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CONFIG_LINUX symbol is always not defined in this file.
This fixes that "config-host.h" header file is not included
for getting macros.

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 util/mmap-alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 27dcccd8ec..24c0e380f3 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -10,6 +10,8 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+#include "config-host.h"
+
 #ifdef CONFIG_LINUX
 #include <linux/mman.h>
 #else  /* !CONFIG_LINUX */
-- 
2.17.1



Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6CAC4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6712077B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6712077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsQF-0008FE-JR
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iGsBi-00022J-Dq
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iGsBh-0007BP-GV
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:06:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:4371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iGsBh-0007AF-9T
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:06:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Oct 2019 15:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,261,1566889200"; d="scan'208";a="195906828"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 05 Oct 2019 15:06:03 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 3/4] migration: pass in_postcopy instead of check state again
Date: Sun,  6 Oct 2019 06:05:16 +0800
Message-Id: <20191005220517.24029-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005220517.24029-1-richardw.yang@linux.intel.com>
References: <20191005220517.24029-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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

Not necessary to do the check again.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c8eaa85867..56031305e3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3148,8 +3148,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
             return MIG_ITERATE_SKIP;
         }
         /* Just another iteration step */
-        qemu_savevm_state_iterate(s->to_dst_file,
-            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+        qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
     } else {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
-- 
2.17.1



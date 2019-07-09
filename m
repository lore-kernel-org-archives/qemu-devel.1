Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED557C73C41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE7C2080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE7C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkqqJ-0000BM-L0
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hkqoo-0007MU-Ol
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hkqon-0008E7-GH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:10:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:42710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hkqon-0008DN-8T
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:10:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jul 2019 07:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; d="scan'208";a="176507530"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 09 Jul 2019 07:10:02 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 22:09:23 +0800
Message-Id: <20190709140924.13291-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709140924.13291-1-richardw.yang@linux.intel.com>
References: <20190709140924.13291-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [PATCH 2/3] migration/savevm: split
 qemu_savevm_state_complete_precopy() into two parts
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a preparation patch for further cleanup.

No functional change, just wrap two major part of
qemu_savevm_state_complete_precopy() into function.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 66 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index becedcc1c6..c41e13e322 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1246,23 +1246,12 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks)
+static
+int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy,
+                                                bool iterable_only)
 {
-    QJSON *vmdesc;
-    int vmdesc_len;
     SaveStateEntry *se;
     int ret;
-    bool in_postcopy = migration_in_postcopy();
-    Error *local_err = NULL;
-
-    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
-        error_report_err(local_err);
-    }
-
-    trace_savevm_state_complete_precopy();
-
-    cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
@@ -1291,9 +1280,18 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
         }
     }
 
-    if (iterable_only) {
-        goto flush;
-    }
+    return 0;
+}
+
+static
+int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
+                                                    bool in_postcopy,
+                                                    bool inactivate_disks)
+{
+    QJSON *vmdesc;
+    int vmdesc_len;
+    SaveStateEntry *se;
+    int ret;
 
     vmdesc = qjson_new();
     json_prop_int(vmdesc, "page_size", qemu_target_page_size());
@@ -1353,6 +1351,40 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
     }
     qjson_destroy(vmdesc);
 
+    return 0;
+}
+
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
+                                       bool inactivate_disks)
+{
+    int ret;
+    Error *local_err = NULL;
+    bool in_postcopy = migration_in_postcopy();
+
+    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
+        error_report_err(local_err);
+    }
+
+    trace_savevm_state_complete_precopy();
+
+    cpu_synchronize_all_states();
+
+    ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy,
+                                                      iterable_only);
+    if (ret) {
+        return ret;
+    }
+
+    if (iterable_only) {
+        goto flush;
+    }
+
+    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy,
+                                                          inactivate_disks);
+    if (ret) {
+        return ret;
+    }
+
 flush:
     qemu_fflush(f);
     return 0;
-- 
2.17.1



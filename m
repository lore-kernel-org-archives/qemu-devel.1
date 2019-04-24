Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60078218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60078218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ6CQ-0004cX-L3
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 20:55:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ab-0003Py-24
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64Z-00007J-Cj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:13721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64Z-00005J-54
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Apr 2019 17:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; d="scan'208";a="138265323"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 23 Apr 2019 17:47:37 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 08:47:00 +0800
Message-Id: <20190424004700.12766-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424004700.12766-1-richardw.yang@linux.intel.com>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [PATCH 4/4] migration/savevm: wrap into
 qemu_loadvm_state_header()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424004700.lzWIp1JJ5eFBpNen3IllxpdxS-dEvI3Iwp6fl5bo3Lo@z>

On source side, we have qemu_savevm_state_header() to send related data,
while on the receiving side those steps are scattered in
qemu_loadvm_state().

This patch wrap those related steps into qemu_loadvm_state_header() to
make it friendly to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 69 +++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a80ae83663..64d23682c6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2256,6 +2256,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     return 0;
 }
 
+static int qemu_loadvm_state_header(QEMUFile *f)
+{
+    unsigned int v;
+    int ret;
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_VM_FILE_MAGIC) {
+        error_report("Not a migration stream");
+        return -EINVAL;
+    }
+
+    v = qemu_get_be32(f);
+    if (v == QEMU_VM_FILE_VERSION_COMPAT) {
+        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        return -ENOTSUP;
+    }
+    if (v != QEMU_VM_FILE_VERSION) {
+        error_report("Unsupported migration stream version");
+        return -ENOTSUP;
+    }
+
+    if (migrate_get_current()->send_configuration) {
+        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
+            error_report("Configuration section missing");
+            qemu_loadvm_state_cleanup();
+            return -EINVAL;
+        }
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
+
+        if (ret) {
+            qemu_loadvm_state_cleanup();
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static int qemu_loadvm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
@@ -2403,7 +2440,6 @@ int qemu_loadvm_state(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
-    unsigned int v;
     int ret;
 
     if (migration_is_blocked(&local_err)) {
@@ -2411,34 +2447,9 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
-    v = qemu_get_be32(f);
-    if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
-        return -EINVAL;
-    }
-
-    v = qemu_get_be32(f);
-    if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
-        return -ENOTSUP;
-    }
-    if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
-        return -ENOTSUP;
-    }
-
-    if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
-            qemu_loadvm_state_cleanup();
-            return -EINVAL;
-        }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
-
-        if (ret) {
-            qemu_loadvm_state_cleanup();
-            return ret;
-        }
+    ret = qemu_loadvm_state_header(f);
+    if (ret) {
+        return ret;
     }
 
     if (qemu_loadvm_state_setup(f) != 0) {
-- 
2.19.1



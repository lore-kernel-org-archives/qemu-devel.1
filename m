Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92813C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D0B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 06:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D0B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCIZr-0004Zv-Je
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 02:43:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY7-0003dr-84
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY6-0004VL-DW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:40758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCIY6-0004O6-2b
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Apr 2019 23:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; d="scan'208";a="128814028"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga007.jf.intel.com with ESMTP; 04 Apr 2019 23:42:00 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Apr 2019 14:41:20 +0800
Message-Id: <20190405064121.23662-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190405064121.23662-1-richardw.yang@linux.intel.com>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH v2 3/4] vl: Clean up after previous commit
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405064120.w5eryYNfZPfxW03WuWpxlwpRiTpjmh298WpYALc7ugE@z>

From: Markus Armbruster <armbru@redhat.com>

Since the previous commit, find_machine() and find_default_machine()
don't have to deallocate on return.  This permits further
simplifications.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
 vl.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/vl.c b/vl.c
index cf08d96ce4..99f9cb2533 100644
--- a/vl.c
+++ b/vl.c
@@ -1421,40 +1421,31 @@ MachineState *current_machine;
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
-    MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *temp = el->data;
+        MachineClass *mc = el->data;
 
-        if (!strcmp(temp->name, name)) {
-            mc = temp;
-            break;
-        }
-        if (temp->alias &&
-            !strcmp(temp->alias, name)) {
-            mc = temp;
-            break;
+        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            return mc;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
-    MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *temp = el->data;
+        MachineClass *mc = el->data;
 
-        if (temp->is_default) {
-            mc = temp;
-            break;
+        if (mc->is_default) {
+            return mc;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 MachineInfoList *qmp_query_machines(Error **errp)
-- 
2.19.1



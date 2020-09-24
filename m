Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EAC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2B9235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jryqa+Ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2B9235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLThu-0007eO-8J
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAf-00020y-LG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAT-0005bW-CY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5k6W3+0iloCTmwAnOMqUxjv9rhJMHWO8oQaLoPBblX0=;
 b=Jryqa+UbNKBD4feIsMOCaP9k8ofFyeHB4i18OpZQ9lONm/dZG8XbbQESy3rq5hCy1o/bHE
 pAY3XrhExS6yNQaOT4HK25sEXxj1CZd4EKPG8xEB0KyPduzEu9REi+3m0gjnNrv7eMMy0/
 cj3FyVRB47pFqesLPp6xEZi1lZQbDzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-B5J4MHlJPCSwGFVhPeq3Og-1; Thu, 24 Sep 2020 11:28:18 -0400
X-MC-Unique: B5J4MHlJPCSwGFVhPeq3Og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEBFB8B1271;
 Thu, 24 Sep 2020 15:28:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E24460C04;
 Thu, 24 Sep 2020 15:28:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 24/31] block/export: Add query-block-exports
Date: Thu, 24 Sep 2020 17:27:10 +0200
Message-Id: <20200924152717.287415-25-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a simple QMP command to query the list of block exports.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json | 32 ++++++++++++++++++++++++++++++++
 block/export/export.c  | 23 +++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 3551c2e748..28d4766215 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -245,3 +245,35 @@
 ##
 { 'event': 'BLOCK_EXPORT_DELETED',
   'data': { 'id': 'str' } }
+
+##
+# @BlockExportInfo:
+#
+# Information about a single block export.
+#
+# @id: The unique identifier for the block export
+#
+# @type: The block export type
+#
+# @node-name: The node name of the block node that is exported
+#
+# @shutting-down: True if the export is shutting down (e.g. after a
+#                 block-export-del command, but before the shutdown has
+#                 completed)
+#
+# Since:  5.2
+##
+{ 'struct': 'BlockExportInfo',
+  'data': { 'id': 'str',
+            'type': 'BlockExportType',
+            'node-name': 'str',
+            'shutting-down': 'bool' } }
+
+##
+# @query-block-exports:
+#
+# Returns: A list of BlockExportInfo describing all block exports
+#
+# Since: 5.2
+##
+{ 'command': 'query-block-exports', 'returns': ['BlockExportInfo'] }
diff --git a/block/export/export.c b/block/export/export.c
index 8702c233f3..657bb58b51 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -286,3 +286,26 @@ void qmp_block_export_del(const char *id,
 
     blk_exp_request_shutdown(exp);
 }
+
+BlockExportInfoList *qmp_query_block_exports(Error **errp)
+{
+    BlockExportInfoList *head = NULL, **p_next = &head;
+    BlockExport *exp;
+
+    QLIST_FOREACH(exp, &block_exports, next) {
+        BlockExportInfoList *entry = g_new0(BlockExportInfoList, 1);
+        BlockExportInfo *info = g_new(BlockExportInfo, 1);
+        *info = (BlockExportInfo) {
+            .id             = g_strdup(exp->id),
+            .type           = exp->drv->type,
+            .node_name      = g_strdup(bdrv_get_node_name(blk_bs(exp->blk))),
+            .shutting_down  = !exp->user_owned,
+        };
+
+        entry->value = info;
+        *p_next = entry;
+        p_next = &entry->next;
+    }
+
+    return head;
+}
-- 
2.25.4



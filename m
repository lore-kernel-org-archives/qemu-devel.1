Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F65C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9B2206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBimEdBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B2206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GHC-00051i-FF
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7e-0002yl-UG
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7c-0001R0-05
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKRuhYBXPjoqOPnqg2H7rVfLDGMm5mTa/Z1J9mMKyhY=;
 b=iBimEdBYve6FJ+wfeypk8Y9WivznEiwi2kIy2rfnRjjdKslTeAO7oILK6tc1f/TVyVh1G9
 3rGb9GS7zxjpZqVvwaDSS+3Ar33d1RfUZF7ua9nIACmyLehkUqvsQ3dOMZml4lagy/eJp+
 NTbMi4UEXPuGnFo1QNqbO3CIGQRJTNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-NNZcsbLOOKCz9rx4gKJvdA-1; Thu, 13 Aug 2020 12:30:29 -0400
X-MC-Unique: NNZcsbLOOKCz9rx4gKJvdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F1AC1DDE0;
 Thu, 13 Aug 2020 16:30:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3575C1A3;
 Thu, 13 Aug 2020 16:30:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 22/22] block/export: Add query-block-exports
Date: Thu, 13 Aug 2020 18:29:35 +0200
Message-Id: <20200813162935.210070-23-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a simple QMP command to query the list of block exports.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json | 33 +++++++++++++++++++++++++++++++++
 block/export/export.c  | 23 +++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index a067de2ba3..0b184bbd7c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -226,3 +226,36 @@
 ##
 { 'command': 'block-export-del',
   'data': { 'id': 'str', '*mode': 'BlockExportRemoveMode' } }
+
+##
+# @BlockExportInfo:
+#
+# Information about a single block export.
+#
+# @id: The unique identifier for the block export
+#
+# @type: This field is returned only for compatibility reasons, it should
+#        not be used (always returns 'unknown')
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
index 3cd448ba72..71d17bd440 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -272,3 +272,26 @@ void qmp_nbd_server_remove(const char *name,
 
     qmp_block_export_del(name, has_mode, mode, errp);
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



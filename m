Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D736C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9282E20C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP3RqbZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9282E20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLxK-00032d-C3
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlK-0005qS-3B
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlH-0004fw-WA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bK+ifR3wkt+Es7s9DRYwoq1Qk7xHQcwwhiFnJO3KQZ4=;
 b=LP3RqbZjQoYn4CSG7YXGcP9OtJN6pMoJmSUzvz0FMUpSRo5B3ZAhFQObzW3M4M3xt6P/AZ
 WlxToS9w6A/3X16Dy2jJ7n12aRwiQ0qav/b4EjKVgijdFMavkaH8IWCgqrY7z68L3R6SU3
 tWITeyA15tzvx+yUjEW8wPByjFOYuXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-8x0SeIdaOceRNUg7Z-dP9Q-1; Mon, 07 Sep 2020 14:20:59 -0400
X-MC-Unique: 8x0SeIdaOceRNUg7Z-dP9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2FAF8030A7;
 Mon,  7 Sep 2020 18:20:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 981E26198E;
 Mon,  7 Sep 2020 18:20:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 24/29] block/export: Add query-block-exports
Date: Mon,  7 Sep 2020 20:20:06 +0200
Message-Id: <20200907182011.521007-25-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qapi/block-export.json | 32 ++++++++++++++++++++++++++++++++
 block/export/export.c  | 23 +++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index dac3250f08..d4e9290210 100644
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
index 52ec00dfcf..bbdb256267 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -279,3 +279,26 @@ void qmp_block_export_del(const char *id,
 
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



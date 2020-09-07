Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12ED2087D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nbu/giRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12ED2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLve-0000WE-Sx
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlH-0005jY-HM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlC-0004ek-B8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZH96r63WA6QU5Vypyz+MbcvZqXIiFQx84/t8vwSycOI=;
 b=Nbu/giRsTLSkv5hW9KB8hYtWxVJhBqjyIi6UDamUHxg0xeDSACB1AESbVS6qEfWGEmit4B
 lT+siSmgESBY/M8f8VaBpEq25Qd2UQoAkrdb46FHNiuqKP0oDiM+YfVsPx6cUQ24GIwWhh
 5Jq8+JNvNPf+bScGQnYzTMcbgNDj3+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NpIChmDWMlmNhoBlCiPcNQ-1; Mon, 07 Sep 2020 14:20:55 -0400
X-MC-Unique: NpIChmDWMlmNhoBlCiPcNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757AF807335;
 Mon,  7 Sep 2020 18:20:54 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A64F60BF3;
 Mon,  7 Sep 2020 18:20:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 21/29] block/export: Add BLOCK_EXPORT_DELETED event
Date: Mon,  7 Sep 2020 20:20:03 +0200
Message-Id: <20200907182011.521007-22-kwolf@redhat.com>
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

Clients may want to know when an export has finally disappeard
(block-export-del returns earlier than that in the general case), so add
a QAPI event for it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json     | 12 ++++++++++++
 block/export/export.c      |  2 ++
 tests/qemu-iotests/140.out |  1 +
 tests/qemu-iotests/223.out |  4 ++++
 4 files changed, 19 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 77a6b595e8..dac3250f08 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -233,3 +233,15 @@
 ##
 { 'command': 'block-export-del',
   'data': { 'id': 'str', '*mode': 'BlockExportRemoveMode' } }
+
+##
+# @BLOCK_EXPORT_DELETED:
+#
+# Emitted when a block export is removed and it's id can be reused.
+#
+# @id: Block export id.
+#
+# Since: 5.2
+##
+{ 'event': 'BLOCK_EXPORT_DELETED',
+  'data': { 'id': 'str' } }
diff --git a/block/export/export.c b/block/export/export.c
index 4af3b69186..ae7879e6a9 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -19,6 +19,7 @@
 #include "block/nbd.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-export.h"
+#include "qapi/qapi-events-block-export.h"
 #include "qemu/id.h"
 
 static const BlockExportDriver *blk_exp_drivers[] = {
@@ -113,6 +114,7 @@ static void blk_exp_delete_bh(void *opaque)
     assert(exp->refcount == 0);
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
+    qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
 
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 86b985da75..f1db409b26 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -15,6 +15,7 @@ read 65536/65536 bytes at offset 0
 qemu-io: can't open device nbd+unix:///drv?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'drv' not present
 { 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "drv"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 31ce9e6fe0..f6eac23f04 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -102,8 +102,10 @@ read 2097152/2097152 bytes at offset 2097152
 {"execute":"nbd-server-remove", "arguments":{"name":"n"}}
 {"return": {}}
 {"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
 {"return": {}}
 {"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"execute":"nbd-server-stop"}
 {"return": {}}
@@ -183,8 +185,10 @@ read 2097152/2097152 bytes at offset 2097152
 {"execute":"nbd-server-remove", "arguments":{"name":"n"}}
 {"return": {}}
 {"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
 {"return": {}}
 {"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"execute":"nbd-server-stop"}
 {"return": {}}
-- 
2.25.4



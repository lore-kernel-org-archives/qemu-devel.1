Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF7FC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65AC23A34
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2PVK5qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65AC23A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTtl-00029t-FD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAS-0001yF-Eg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAP-0005aV-6b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8+wXt46aADpCxQohqhH82gdAxWcUq+sbQryO7wOejY=;
 b=M2PVK5qEN0QlxPZ8THDArWOAMFZxGGpLJXvfme2FG6Y7A3Ux20vW8uDoaGQcMocn7EbUty
 UtCX+h5k7uS/xD4Z6yfFMqe+EwFIBRddnML5mYQn4psrIhlMyn9OWgDl/xcnUXgo92a+vL
 nvMyZu1nFgLFUilsnKyARHDwM//XT8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-hV10kG2iNg6DAr5AlD2UjQ-1; Thu, 24 Sep 2020 11:28:14 -0400
X-MC-Unique: hV10kG2iNg6DAr5AlD2UjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28A10884DDA;
 Thu, 24 Sep 2020 15:28:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDD9460C04;
 Thu, 24 Sep 2020 15:28:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 21/31] block/export: Add BLOCK_EXPORT_DELETED event
Date: Thu, 24 Sep 2020 17:27:07 +0200
Message-Id: <20200924152717.287415-22-kwolf@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Clients may want to know when an export has finally disappeard
(block-export-del returns earlier than that in the general case), so add
a QAPI event for it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json     | 12 ++++++++++++
 block/export/export.c      |  2 ++
 tests/qemu-iotests/140     |  9 ++++++++-
 tests/qemu-iotests/140.out |  2 +-
 tests/qemu-iotests/223.out |  4 ++++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 0ba4d84c97..3551c2e748 100644
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
+# Emitted when a block export is removed and its id can be reused.
+#
+# @id: Block export id.
+#
+# Since: 5.2
+##
+{ 'event': 'BLOCK_EXPORT_DELETED',
+  'data': { 'id': 'str' } }
diff --git a/block/export/export.c b/block/export/export.c
index d186beffe9..87940d5c40 100644
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
 
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 8d2ce5d9e3..309b177e77 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -81,10 +81,17 @@ $QEMU_IO_PROG -f raw -r -c 'read -P 42 0 64k' \
     "nbd+unix:///drv?socket=$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
 
+# The order of 'return' and the BLOCK_EXPORT_DELETED event is undefined. Just
+# wait until we've twice seen one of them. Filter the 'return' line out so that
+# the output is defined.
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'eject',
        'arguments': { 'device': 'drv' }}" \
-    'return'
+    'return\|BLOCK_EXPORT_DELETED' |
+    grep -v 'return'
+
+_send_qemu_cmd $QEMU_HANDLE '' 'return\|BLOCK_EXPORT_DELETED' |
+    grep -v 'return'
 
 $QEMU_IO_PROG -f raw -r -c close \
     "nbd+unix:///drv?socket=$SOCK_DIR/nbd" 2>&1 \
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 86b985da75..62d9c3ab3c 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -11,7 +11,7 @@ wrote 65536/65536 bytes at offset 0
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'eject', 'arguments': { 'device': 'drv' }}
-{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "drv"}}
 qemu-io: can't open device nbd+unix:///drv?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'drv' not present
 { 'execute': 'quit' }
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



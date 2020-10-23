Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C82AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6068E20882
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHVtCNdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6068E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1zq-0005fs-8y
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1w5-0000vD-4b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:61000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1w3-0001Vr-0F
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MiwuAkKEc3FV5+c3ylhbIiHZ/wkTuAFB6ReDkHrQwU=;
 b=XHVtCNdl0MqbEcdTHXz9C0exc/emTnHKvWubtLoW69u5pnb+v/bNlhpddZTGAS5lVrHAJN
 Qv/ik3Zu6Ywcj0On1/7u63L+0uOPjWaqVndxJ398EQRileTZTdpVO/lLd05QVb3WOuz7Mo
 LGh2effcmbnZIsuDNyaXTTEcKkS5jSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-sGYTtUpnPDa91tRFpUMM7w-1; Fri, 23 Oct 2020 14:37:04 -0400
X-MC-Unique: sGYTtUpnPDa91tRFpUMM7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E58785F9E1;
 Fri, 23 Oct 2020 18:37:02 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B6CC60BFA;
 Fri, 23 Oct 2020 18:36:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/12] qapi: Make QAPI_LIST_ADD() public
Date: Fri, 23 Oct 2020 13:36:42 -0500
Message-Id: <20201023183652.478921-3-eblake@redhat.com>
In-Reply-To: <20201023183652.478921-1-eblake@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a useful macro for inserting at the front of any
QAPI-generated list; move it from block.c to qapi/util.h so more
places can use it, including one earlier place in block.c.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/util.h |  8 ++++++++
 block.c             | 15 +++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 50201896c7a4..b6083055ce69 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -30,4 +30,12 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,

 int parse_qapi_name(const char *name, bool complete);

+/* For any GenericList @list, insert @element at the front. */
+#define QAPI_LIST_ADD(list, element) do { \
+    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
+    _tmp->value = (element); \
+    _tmp->next = (list); \
+    (list) = _tmp; \
+} while (0)
+
 #endif
diff --git a/block.c b/block.c
index 430edf79bb10..45bd79299611 100644
--- a/block.c
+++ b/block.c
@@ -39,6 +39,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/util.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
@@ -5211,7 +5212,7 @@ BlockDriverState *bdrv_find_node(const char *node_name)
 BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
                                            Error **errp)
 {
-    BlockDeviceInfoList *list, *entry;
+    BlockDeviceInfoList *list;
     BlockDriverState *bs;

     list = NULL;
@@ -5221,22 +5222,12 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
         }
-        entry = g_malloc0(sizeof(*entry));
-        entry->value = info;
-        entry->next = list;
-        list = entry;
+        QAPI_LIST_ADD(list, info);
     }

     return list;
 }

-#define QAPI_LIST_ADD(list, element) do { \
-    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
-    _tmp->value = (element); \
-    _tmp->next = (list); \
-    (list) = _tmp; \
-} while (0)
-
 typedef struct XDbgBlockGraphConstructor {
     XDbgBlockGraph *graph;
     GHashTable *graph_nodes;
-- 
2.29.0



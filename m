Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC0CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8752C20723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HA3zvfIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8752C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcj7-0002PZ-J2
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcf8-0005Ch-4U
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcf6-00034q-3R
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GahAtAd+aAFjS7BoLY7dnLsO6OwTXstkpAbCyXSvYig=;
 b=HA3zvfIysqvw49if3/JRIKte1niZtZYioLrWzOza7VCNedCkm+KYntIAbFi0BUSOLPZPDw
 ftgBNN5x1ntfTNkyuE6lfA35wJZvKUEquf2EDnxIQB2TWCPFmDFosxVE6Z2q1iFCTzoGsm
 jXkyyyqQwM7uVxqfCccTKBAPutQaIHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-iGQ9eDhSMSSVUENXVePW7Q-1; Tue, 26 May 2020 12:42:37 -0400
X-MC-Unique: iGQ9eDhSMSSVUENXVePW7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A42E5835B50;
 Tue, 26 May 2020 16:42:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3578E7D975;
 Tue, 26 May 2020 16:42:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] qemu-img: Factor out code for merging bitmaps
Date: Tue, 26 May 2020 11:42:09 -0500
Message-Id: <20200526164211.1569366-10-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will add another client that wants to merge dirty
bitmaps; it will be easier to refactor the code to construct the QAPI
struct correctly into a helper function.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200521192137.1120211-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b2311bd3f6b4..0778d8f56614 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1638,6 +1638,24 @@ out4:
     return ret;
 }

+/* Convenience wrapper around qmp_block_dirty_bitmap_merge */
+static void do_dirty_bitmap_merge(const char *dst_node, const char *dst_name,
+                                  const char *src_node, const char *src_name,
+                                  Error **errp)
+{
+    BlockDirtyBitmapMergeSource *merge_src;
+    BlockDirtyBitmapMergeSourceList *list;
+
+    merge_src = g_new0(BlockDirtyBitmapMergeSource, 1);
+    merge_src->type = QTYPE_QDICT;
+    merge_src->u.external.node = g_strdup(src_node);
+    merge_src->u.external.name = g_strdup(src_name);
+    list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
+    list->value = merge_src;
+    qmp_block_dirty_bitmap_merge(dst_node, dst_name, list, errp);
+    qapi_free_BlockDirtyBitmapMergeSourceList(list);
+}
+
 enum ImgConvertBlockStatus {
     BLK_DATA,
     BLK_ZERO,
@@ -4714,21 +4732,11 @@ static int img_bitmap(int argc, char **argv)
             qmp_block_dirty_bitmap_disable(bs->node_name, bitmap, &err);
             op = "disable";
             break;
-        case BITMAP_MERGE: {
-            BlockDirtyBitmapMergeSource *merge_src;
-            BlockDirtyBitmapMergeSourceList *list;
-
-            merge_src = g_new0(BlockDirtyBitmapMergeSource, 1);
-            merge_src->type = QTYPE_QDICT;
-            merge_src->u.external.node = g_strdup(src_bs->node_name);
-            merge_src->u.external.name = g_strdup(act->src);
-            list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
-            list->value = merge_src;
-            qmp_block_dirty_bitmap_merge(bs->node_name, bitmap, list, &err);
-            qapi_free_BlockDirtyBitmapMergeSourceList(list);
+        case BITMAP_MERGE:
+            do_dirty_bitmap_merge(bs->node_name, bitmap, src_bs->node_name,
+                                  act->src, &err);
             op = "merge";
             break;
-        }
         default:
             g_assert_not_reached();
         }
-- 
2.26.2



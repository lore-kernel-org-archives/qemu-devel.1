Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCDC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A872080A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6sbJT/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A872080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHDm-0005TU-W0
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBV-0003Zw-Dm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBR-0003ZU-6q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603775167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvTmrX5dvWmHG4tb3pp1JPR9105Ks56YCJEDsQySNkE=;
 b=L6sbJT/oPL9ttF7ShZgKMiX7a5TUn3xQxxhAt9hvr62HXx8E/Xgr6Kiv9UXlMBPaZZKN51
 bDYuKMVWAtueyNuHoQh4ncGhvYm/qjKCUc/KFigwpJoY9Eg3fRVWIKHdHpQdaayI1yxqD/
 JnOdq/IWNmYt+e7/zXKSJTl0dzC+nag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-VRXYWAVRN2-YK2aFBHnN7Q-1; Tue, 27 Oct 2020 01:06:05 -0400
X-MC-Unique: VRXYWAVRN2-YK2aFBHnN7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489618030A9;
 Tue, 27 Oct 2020 05:06:04 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 364CD10021AA;
 Tue, 27 Oct 2020 05:06:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/11] qapi: Make QAPI_LIST_ADD() public
Date: Tue, 27 Oct 2020 00:05:47 -0500
Message-Id: <20201027050556.269064-3-eblake@redhat.com>
In-Reply-To: <20201027050556.269064-1-eblake@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: kwolf@redhat.com, pkrempa@redhat.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 armbru@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a useful macro for inserting at the front of any
QAPI-generated list; move it from block.c to qapi/util.h so more
places can use it, including one earlier place in block.c.

There are many more places in the codebase that can benefit from using
the macro, but converting them will be left to later patches.

In theory, all QAPI list types are child classes of GenericList; but
in practice, that relationship is not explicitly spelled out in the C
type declarations (rather, it is something that happens implicitly due
to C compatible layouts), and the macro does not actually depend on
the GenericList type.  We considered moving GenericList from visitor.h
into util.h to group related code; however, such a move would be
awkward if we do not also move GenericAlternate.  Unfortunately,
moving GenericAlternate would introduce its own problems of
declaration circularity (qapi-builtin-types.h needs a complete
definition of QEnumLookup from util.h, but GenericAlternate needs a
complete definition of QType from qapi-builtin-types.h).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/util.h |  8 ++++++++
 block.c             | 14 ++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index a7c3c6414874..501abca38eaa 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -22,4 +22,12 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,

 int parse_qapi_name(const char *name, bool complete);

+/* For any GenericList @list, insert @element at the front. */
+#define QAPI_LIST_ADD(list, element) do { \
+    typeof(list) _tmp = g_malloc(sizeof(*(list))); \
+    _tmp->value = (element); \
+    _tmp->next = (list); \
+    (list) = _tmp; \
+} while (0)
+
 #endif
diff --git a/block.c b/block.c
index 857387f3912f..8f9df5547d5a 100644
--- a/block.c
+++ b/block.c
@@ -5211,7 +5211,7 @@ BlockDriverState *bdrv_find_node(const char *node_name)
 BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
                                            Error **errp)
 {
-    BlockDeviceInfoList *list, *entry;
+    BlockDeviceInfoList *list;
     BlockDriverState *bs;

     list = NULL;
@@ -5221,22 +5221,12 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
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
-    typeof(list) _tmp = g_malloc(sizeof(*(list))); \
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



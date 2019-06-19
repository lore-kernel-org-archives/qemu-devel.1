Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE65C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1584021881
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1584021881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcg8-0008Sh-5M
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcU1-0003TJ-BD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcU0-0002G1-9E
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcTx-00020a-NH; Wed, 19 Jun 2019 11:26:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 261BBF74CE;
 Wed, 19 Jun 2019 15:26:19 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B209B601A5;
 Wed, 19 Jun 2019 15:26:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 17:25:57 +0200
Message-Id: <20190619152603.5937-4-mreitz@redhat.com>
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
References: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 19 Jun 2019 15:26:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/9] block: Add bdrv_poll_drain_data_objs()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function polls all of the involved AioContexts for a GSList of
BdrvCoDrainData objects until all objects' .done is true.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/block/io.c b/block/io.c
index 6b518e5eb0..eb84774abd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -255,6 +255,63 @@ static void bdrv_drain_invoke(BlockDriverState *bs, =
bool begin,
     }
 }
=20
+/* TODO: Actually use this function and drop this forward declaration */
+static void bdrv_poll_drain_data_objs(GSList **data_objs, bool acquire_c=
tx)
+    __attribute__((unused));
+
+/*
+ * Poll the AioContexts in the given list of BdrvCoDrainData objects
+ * until all of those objects are "done" (i.e. their .done field is
+ * true).
+ * Also, free all objects and the list.
+ *
+ * If @acquire_ctx is true, the AioContexts are locked while they are
+ * polled.
+ */
+static void bdrv_poll_drain_data_objs(GSList **data_objs, bool acquire_c=
tx)
+{
+    GSList *contexts =3D NULL;
+    GSList *iter;
+
+    /* First collect the contexts while the BDSs are not gone */
+    for (iter =3D *data_objs; iter; iter =3D iter->next) {
+        BdrvCoDrainData *drain_data =3D iter->data;
+        contexts =3D g_slist_prepend(contexts,
+                                   bdrv_get_aio_context(drain_data->bs))=
;
+    }
+
+    /*
+     * Reverse the list so it is in the same order as *data_objs
+     * (prepend and then reverse has better performance than appending)
+     */
+    contexts =3D g_slist_reverse(contexts);
+
+    /* The BDSs may disappear here, but we only need their contexts */
+    while (*data_objs) {
+        GSList *next;
+        BdrvCoDrainData *drain_data =3D (*data_objs)->data;
+        AioContext *ctx =3D contexts->data;
+
+        if (acquire_ctx) {
+            aio_context_acquire(ctx);
+        }
+        AIO_WAIT_WHILE(ctx, !drain_data->done);
+        if (acquire_ctx) {
+            aio_context_release(ctx);
+        }
+
+        g_free(drain_data);
+
+        next =3D (*data_objs)->next;
+        g_slist_free_1(*data_objs);
+        *data_objs =3D next;
+
+        next =3D contexts->next;
+        g_slist_free_1(contexts);
+        contexts =3D next;
+    }
+}
+
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll(=
) */
 bool bdrv_drain_poll(BlockDriverState *bs, bool recursive,
                      BdrvChild *ignore_parent, bool ignore_bds_parents)
--=20
2.21.0



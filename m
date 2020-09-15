Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BCCC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3207206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMQD/Fgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3207206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8cX-00052Q-OS
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UD-0000UK-FI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8U9-0004YK-7R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP30DnVeODMLdNm9vUyTjR1z7jdsH9mOP9byIYWIgbY=;
 b=hMQD/FgyrT7yUMrdNdY0ye6/y+0UyH2J0GB3jC4uphtJcjlV++zDV+yiR2FlNVwY18Z2vA
 UqTMriTBmIk28QPc3IIaOG+Nlr4GeSLbgeHB6bYOW8LGQB8k4sEQWgJCgaQWbtbu7MsMQ1
 2m3o1icBiO5sNDvmyVgIHiFwGtncUKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-NX41xAwaP7SAoHmCzt_gVw-1; Tue, 15 Sep 2020 06:46:44 -0400
X-MC-Unique: NX41xAwaP7SAoHmCzt_gVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E798D64087;
 Tue, 15 Sep 2020 10:46:42 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5345DC1E;
 Tue, 15 Sep 2020 10:46:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/22] block/quorum.c: stable children names
Date: Tue, 15 Sep 2020 12:46:11 +0200
Message-Id: <20200915104627.699552-7-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

If we remove the child with the highest index from the quorum,
decrement s->next_child_index. This way we get stable children
names as long as we only remove the last child.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Fixes: https://bugs.launchpad.net/bugs/1881231
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <5d5f930424c1c770754041aa8ad6421dc4e2b58e.1596536719.git.lukasstraub2@web.de>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 6df9449fc2..e846a7e892 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -29,6 +29,8 @@
 
 #define HASH_LENGTH 32
 
+#define INDEXSTR_LEN 32
+
 #define QUORUM_OPT_VOTE_THRESHOLD "vote-threshold"
 #define QUORUM_OPT_BLKVERIFY      "blkverify"
 #define QUORUM_OPT_REWRITE        "rewrite-corrupted"
@@ -970,9 +972,9 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     opened = g_new0(bool, s->num_children);
 
     for (i = 0; i < s->num_children; i++) {
-        char indexstr[32];
-        ret = snprintf(indexstr, 32, "children.%d", i);
-        assert(ret < 32);
+        char indexstr[INDEXSTR_LEN];
+        ret = snprintf(indexstr, INDEXSTR_LEN, "children.%d", i);
+        assert(ret < INDEXSTR_LEN);
 
         s->children[i] = bdrv_open_child(NULL, options, indexstr, bs,
                                          &child_of_bds, BDRV_CHILD_DATA, false,
@@ -1024,7 +1026,7 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
 {
     BDRVQuorumState *s = bs->opaque;
     BdrvChild *child;
-    char indexstr[32];
+    char indexstr[INDEXSTR_LEN];
     int ret;
 
     if (s->is_blkverify) {
@@ -1039,8 +1041,8 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
         return;
     }
 
-    ret = snprintf(indexstr, 32, "children.%u", s->next_child_index);
-    if (ret < 0 || ret >= 32) {
+    ret = snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index);
+    if (ret < 0 || ret >= INDEXSTR_LEN) {
         error_setg(errp, "cannot generate child name");
         return;
     }
@@ -1068,6 +1070,7 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
                              Error **errp)
 {
     BDRVQuorumState *s = bs->opaque;
+    char indexstr[INDEXSTR_LEN];
     int i;
 
     for (i = 0; i < s->num_children; i++) {
@@ -1089,6 +1092,11 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
     /* We know now that num_children > threshold, so blkverify must be false */
     assert(!s->is_blkverify);
 
+    snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index - 1);
+    if (!strncmp(child->name, indexstr, INDEXSTR_LEN)) {
+        s->next_child_index--;
+    }
+
     bdrv_drained_begin(bs);
 
     /* We can safely remove this child now */
-- 
2.26.2



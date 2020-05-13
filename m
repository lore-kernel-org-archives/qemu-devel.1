Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8FDC2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E20620753
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMvcJ7Fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E20620753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpTD-0003kn-IF
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDt-0002S7-98
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDq-0003VC-G7
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiX1JoSl22iGBF2AQe+urEYSDM5hXwhOa/rnd7TcN/s=;
 b=UMvcJ7Fwh3XMfknaW/ZRQX14P/iCanHQFW5ky4+/4iby0iDnabgVgU0epjNlvqayz5hOsM
 Nkw7BwSkVbY9bnCmiO1jmMyc11/fSORAAbXSGCLHyBahrWoPmW3Je39ZkE2I8eHxHh67Ug
 qulk2cGlD6nCAWr93eYntmHjsuvYQ4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-z6uP1-F0OAahUwc5jlFhDA-1; Wed, 13 May 2020 07:06:44 -0400
X-MC-Unique: z6uP1-F0OAahUwc5jlFhDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19F5953;
 Wed, 13 May 2020 11:06:43 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A64661000337;
 Wed, 13 May 2020 11:06:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 21/34] block: Switch child_format users to child_of_bds
Date: Wed, 13 May 2020 13:05:31 +0200
Message-Id: <20200513110544.176672-22-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both users (quorum and blkverify) use child_format for
not-really-filtered children, so the appropriate BdrvChildRole in both
cases is DATA.  (Note that this will cause bdrv_inherited_options() to
force-allow format probing.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/blkverify.c | 4 ++--
 block/quorum.c    | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index ba4f6d7b7c..1684b7aa2e 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -134,8 +134,8 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Open the test file */
     s->test_file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options,
-                                   "test", bs, &child_format, 0, false,
-                                   &local_err);
+                                   "test", bs, &child_of_bds, BDRV_CHILD_DATA,
+                                   false, &local_err);
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/quorum.c b/block/quorum.c
index d37b77a522..616ac3a927 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -977,7 +977,8 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
         assert(ret < 32);
 
         s->children[i] = bdrv_open_child(NULL, options, indexstr, bs,
-                                         &child_format, 0, false, &local_err);
+                                         &child_of_bds, BDRV_CHILD_DATA, false,
+                                         &local_err);
         if (local_err) {
             ret = -EINVAL;
             goto close_exit;
@@ -1053,7 +1054,8 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
-    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format, 0, errp);
+    child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
+                              BDRV_CHILD_DATA, errp);
     if (child == NULL) {
         s->next_child_index--;
         goto out;
-- 
2.26.2



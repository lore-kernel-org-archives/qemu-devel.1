Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B0D2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiTW7wcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZsB-0003Wo-Pd
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjK-0003BZ-9i
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjJ-0002PC-GU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeE4iNX9RByu1DW8AR7ZX+mPV4S9p+H/9LoHgCtDmTM=;
 b=TiTW7wcZuWiAhh0XCE+o92Q8408eN3osKdSksI62gurvCjF8tVDFd3jIQnEGzeTkPGm3NR
 ArlLpIgqkWP9JEbBYqIc61aOiFEJI/A6mgSfxrEh2zWhuZcddQvF9ix+TUjUsSFmNSTnDX
 z7IWc3W7iJGXWsKjEZRDUaW7jfSfxls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-dKaF34I9Ma2CgA8wo3wYUg-1; Fri, 15 May 2020 08:46:15 -0400
X-MC-Unique: dKaF34I9Ma2CgA8wo3wYUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30CF18014D7;
 Fri, 15 May 2020 12:46:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3721C2E166;
 Fri, 15 May 2020 12:46:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/51] block: Relax *perms_for_storage for data children
Date: Fri, 15 May 2020 14:45:00 +0200
Message-Id: <20200515124521.335403-31-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We can be less restrictive about pure data children than those with
metadata on them, so let bdrv_default_perms_for_storage() handle
metadata children differently from pure data children.

As explained in the code, the restrictions on metadata children are
strictly stricter than those for pure data children, so in theory we
just have to distinguish between pure-data and all other storage
children (pure metadata or data+metadata).  In practice, that is not
obvious, though, so we have two independent code paths for metadata and
for data children, and data+metadata children will go through both
(without the path for data children doing anything meaningful).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-19-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 5d17aa1cc3..5ff6cbd796 100644
--- a/block.c
+++ b/block.c
@@ -2528,19 +2528,57 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
     bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
                               perm, shared, &perm, &shared);
 
-    /* Format drivers may touch metadata even if the guest doesn't write */
-    if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
-        perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    if (role & BDRV_CHILD_METADATA) {
+        /* Format drivers may touch metadata even if the guest doesn't write */
+        if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
+            perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+        }
+
+        /*
+         * bs->file always needs to be consistent because of the
+         * metadata. We can never allow other users to resize or write
+         * to it.
+         */
+        if (!(flags & BDRV_O_NO_IO)) {
+            perm |= BLK_PERM_CONSISTENT_READ;
+        }
+        shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
     }
 
-    /*
-     * bs->file always needs to be consistent because of the metadata. We
-     * can never allow other users to resize or write to it.
-     */
-    if (!(flags & BDRV_O_NO_IO)) {
-        perm |= BLK_PERM_CONSISTENT_READ;
+    if (role & BDRV_CHILD_DATA) {
+        /*
+         * Technically, everything in this block is a subset of the
+         * BDRV_CHILD_METADATA path taken above, and so this could
+         * be an "else if" branch.  However, that is not obvious, and
+         * this function is not performance critical, therefore we let
+         * this be an independent "if".
+         */
+
+        /*
+         * We cannot allow other users to resize the file because the
+         * format driver might have some assumptions about the size
+         * (e.g. because it is stored in metadata, or because the file
+         * is split into fixed-size data files).
+         */
+        shared &= ~BLK_PERM_RESIZE;
+
+        /*
+         * WRITE_UNCHANGED often cannot be performed as such on the
+         * data file.  For example, the qcow2 driver may still need to
+         * write copied clusters on copy-on-read.
+         */
+        if (perm & BLK_PERM_WRITE_UNCHANGED) {
+            perm |= BLK_PERM_WRITE;
+        }
+
+        /*
+         * If the data file is written to, the format driver may
+         * expect to be able to resize it by writing beyond the EOF.
+         */
+        if (perm & BLK_PERM_WRITE) {
+            perm |= BLK_PERM_RESIZE;
+        }
     }
-    shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
 
     if (bs->open_flags & BDRV_O_INACTIVE) {
         shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
-- 
2.25.4



Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB4C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB290207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="DpIKMuCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB290207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57475 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irACN-0004Eb-0P
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <8351c098c0bd0ff63a57587e0e6bbe09d4efb760@lizzy.crudebyte.com>)
 id 1irAAS-00081k-K6
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <8351c098c0bd0ff63a57587e0e6bbe09d4efb760@lizzy.crudebyte.com>)
 id 1irAAR-0000gN-FG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:34:48 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:45835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <8351c098c0bd0ff63a57587e0e6bbe09d4efb760@lizzy.crudebyte.com>)
 id 1irAAR-00083u-8a
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=d8arDOv455rogF2dRq1K5W98O1g4hMO9yNUA10vG7Sk=; b=DpIKM
 uCVI8zRpoZ/n8I0P6zJMhODbkjgXYPRQ75/YPf+XPN82ILj+LKjwz29zxvrWk+3frssEZDfkniHse
 gzsacxTwpSaBErVxZ//J1kU8Ay3genkKBh4R1i3fmweT70jJvVHm3WGebPH6ssgBQ4e5jsXQRx1ox
 A/ITRrPAtYYcDRZ3R46qS6GhfFZ1frLPyeuKspkKy+fntZeZGmWVgXWqYmEC3aq8XBwR2fu3wfPFB
 M3mBEPzjTYYyJIVNNJsphYvlvqHecmzIv/3uGuiEBRfZ/bcmyttw8VlSp3Lsd54jAs2Woxs12cjBx
 QIjb4zr6MqqVsjwwW/e+9PgCXsfoA==;
Message-Id: <8351c098c0bd0ff63a57587e0e6bbe09d4efb760.1578957500.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1578957500.git.qemu_oss@crudebyte.com>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 14 Jan 2020 00:16:41 +0100
Subject: [PATCH v3 09/11] hw/9pfs/9p-synth: avoid n-square issue in
 synth_readdir()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is just a temporary benchmark hack, not intended
to be merged!

9pfs synth driver's readdir() implementation has a severe
n-square performance problem. This patch is a quick and dirty
hack to prevent that performance problem from tainting the
readdir() benchmark results. In its current form, this patch
is not useful for anything else than for an isolated readdir
benchmark.

NOTE: This patch would break the new readdir/split test,
because it would alter the behaviour of seekdir() required
for retrieving directory entries splitted over several
requests.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-synth.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 7eb210ffa8..54dc30f37b 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -225,7 +225,8 @@ static void synth_direntry(V9fsSynthNode *node,
 }
 
 static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
-                                            struct dirent *entry, off_t off)
+                                       struct dirent *entry, off_t off,
+                                       V9fsSynthNode **hack)
 {
     int i = 0;
     V9fsSynthNode *node;
@@ -243,16 +244,38 @@ static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
         /* end of directory */
         return NULL;
     }
+    *hack = node;
     synth_direntry(node, entry, off);
     return entry;
 }
 
 static struct dirent *synth_readdir(FsContext *ctx, V9fsFidOpenState *fs)
 {
-    struct dirent *entry;
+    struct dirent *entry = NULL;
     V9fsSynthOpenState *synth_open = fs->private;
     V9fsSynthNode *node = synth_open->node;
-    entry = synth_get_dentry(node, &synth_open->dent, synth_open->offset);
+
+    /*
+     * HACK: This is just intended for benchmark, to avoid severe n-square
+     * performance problem of synth driver's readdir implementation here which
+     * would otherwise unncessarily taint the benchmark results. By simply
+     * caching (globally) the previous node (of the previous synth_readdir()
+     * call) we can simply proceed to next node in chained list efficiently.
+     *
+     * not a good idea for any production code ;-)
+     */
+    static struct V9fsSynthNode *cachedNode;
+
+    if (!cachedNode) {
+        entry = synth_get_dentry(node, &synth_open->dent, synth_open->offset,
+                                 &cachedNode);
+    } else {
+        cachedNode = cachedNode->sibling.le_next;
+        if (cachedNode) {
+            entry = &synth_open->dent;
+            synth_direntry(cachedNode, entry, synth_open->offset + 1);
+        }
+    }
     if (entry) {
         synth_open->offset++;
     }
-- 
2.20.1



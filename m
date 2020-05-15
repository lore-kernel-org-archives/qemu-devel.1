Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0276E2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATrTEEVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0276E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZyk-00006k-4G
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjA-0002oR-DM
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj7-0002Ix-PX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mk9ReFM1xpWL+5m+Wa5jigFpLRzNSjDioJie81B+hQE=;
 b=ATrTEEVQ3TVq/Ha2A1aL+lVehMzUyTehfb3WGgG4MCYwbNXDrrJIIjA2Zuk+QlrO2SMyOf
 eMt7Z86A8GJpnIZLfxJoso9epp9ue19pBO4KcszXPzL6ROP3y5aZUxmBoVbMN9meYlskbW
 YAlwNCgvD1MLB1aMp/q76J8LU6NQfiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-UBhOJoXpMS6FtpEPYy-bog-1; Fri, 15 May 2020 08:46:06 -0400
X-MC-Unique: UBhOJoXpMS6FtpEPYy-bog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B4E107ACCA;
 Fri, 15 May 2020 12:46:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C08A2E024;
 Fri, 15 May 2020 12:46:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/51] block: Use bdrv_inherited_options()
Date: Fri, 15 May 2020 14:44:53 +0200
Message-Id: <20200515124521.335403-24-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Let child_file's, child_format's, and child_backing's .inherit_options()
implementations fall back to bdrv_inherited_options() to show that it
would really work for all of these cases, if only the parents passed the
appropriate BdrvChildRole and parent_is_format values.

(Also, make bdrv_open_inherit(), the only place to explicitly call
bdrv_backing_options(), call bdrv_inherited_options() instead.)

This patch should incur only two visible changes, both for child_format
children, both of which are effectively bug fixes:

First, they no longer have discard=unmap set by default.  This reason it
was set is because bdrv_inherited_fmt_options() fell through to
bdrv_protocol_options(), and that set it because "format drivers take
care to send flushes and respect unmap policy".  None of the drivers
that use child_format for their children (quorum and blkverify) are
format drivers, though, so this reasoning does not apply here.

Second, they no longer have BDRV_O_NO_IO force-cleared.  child_format
was used solely for children that do not store any metadata and as such
will not be accessed by their parents as long as those parents do not
receive I/O themselves.  Thus, such children should inherit
BDRV_O_NO_IO.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-12-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 71 +++++++++++++++------------------------------------------
 1 file changed, 19 insertions(+), 52 deletions(-)

diff --git a/block.c b/block.c
index 9b0e13d537..b3b978a092 100644
--- a/block.c
+++ b/block.c
@@ -80,6 +80,11 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            BdrvChildRole child_role,
                                            Error **errp);
 
+/* TODO: Remove when no longer needed */
+static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
+                                   int *child_flags, QDict *child_options,
+                                   int parent_flags, QDict *parent_options);
+
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
 
@@ -1158,31 +1163,9 @@ static void bdrv_protocol_options(BdrvChildRole role, bool parent_is_format,
                                   int *child_flags, QDict *child_options,
                                   int parent_flags, QDict *parent_options)
 {
-    int flags = parent_flags;
-
-    /* Enable protocol handling, disable format probing for bs->file */
-    flags |= BDRV_O_PROTOCOL;
-
-    /* If the cache mode isn't explicitly set, inherit direct and no-flush from
-     * the parent. */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
-
-    /* Inherit the read-only option from the parent if it's not set */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_AUTO_READ_ONLY);
-
-    /* Our block drivers take care to send flushes and respect unmap policy,
-     * so we can default to enable both on lower layers regardless of the
-     * corresponding parent options. */
-    qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
-
-    /* Clear flags that only apply to the top layer */
-    flags &= ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ |
-               BDRV_O_NO_IO);
-
-    *child_flags = flags;
+    bdrv_inherited_options(BDRV_CHILD_IMAGE, true,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
 
 const BdrvChildClass child_file = {
@@ -1209,11 +1192,9 @@ static void bdrv_inherited_fmt_options(BdrvChildRole role,
                                        int *child_flags, QDict *child_options,
                                        int parent_flags, QDict *parent_options)
 {
-    child_file.inherit_options(role, parent_is_format,
-                               child_flags, child_options,
-                               parent_flags, parent_options);
-
-    *child_flags &= ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
+    bdrv_inherited_options(BDRV_CHILD_DATA, false,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
 
 const BdrvChildClass child_format = {
@@ -1295,23 +1276,9 @@ static void bdrv_backing_options(BdrvChildRole role, bool parent_is_format,
                                  int *child_flags, QDict *child_options,
                                  int parent_flags, QDict *parent_options)
 {
-    int flags = parent_flags;
-
-    /* The cache mode is inherited unmodified for backing files; except WCE,
-     * which is only applied on the top level (BlockBackend) */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
-
-    /* backing files always opened read-only */
-    qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
-    qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off");
-    flags &= ~BDRV_O_COPY_ON_READ;
-
-    /* snapshot=on is handled on the top layer */
-    flags &= ~(BDRV_O_SNAPSHOT | BDRV_O_TEMPORARY);
-
-    *child_flags = flags;
+    bdrv_inherited_options(BDRV_CHILD_COW, true,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
 
 static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
@@ -1360,10 +1327,9 @@ const BdrvChildClass child_backing = {
  * Returns the options and flags that a generic child of a BDS should
  * get, based on the given options and flags for the parent BDS.
  */
-static void __attribute__((unused))
-    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
-                           int *child_flags, QDict *child_options,
-                           int parent_flags, QDict *parent_options)
+static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
+                                   int *child_flags, QDict *child_options,
+                                   int parent_flags, QDict *parent_options)
 {
     int flags = parent_flags;
 
@@ -3300,7 +3266,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                    flags, options);
         /* Let bdrv_backing_options() override "read-only" */
         qdict_del(options, BDRV_OPT_READ_ONLY);
-        bdrv_backing_options(0, true, &flags, options, flags, options);
+        bdrv_inherited_options(BDRV_CHILD_COW, true,
+                               &flags, options, flags, options);
     }
 
     bs->open_flags = flags;
-- 
2.25.4



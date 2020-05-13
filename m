Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F33CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4334020740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rd2YI2RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4334020740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpJ3-0001xr-6H
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDR-0001WN-4p
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDQ-0003Q6-Ao
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZFqjDaFLxvo8UurgJBvkSnTJG3QR6zQLECRWFDl1ng=;
 b=Rd2YI2RDRA2rtsx/imcOKTNzMluxB1nxXBkyPZ7EqCGlQ9yC0v5G+ltMian8vuQMMSvUhE
 cuYZ1z0pVgR+23ERHgStVfEZ1JN0CJWGJyYu9m4rD5aXvq2CB6tSGxzJNvYXAvl2YDWScs
 lqr9IlD5/F0lRzFotRbfcZmtjsQz7YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-CfHAhI87N7-bM8AOwqaPrw-1; Wed, 13 May 2020 07:06:16 -0400
X-MC-Unique: CfHAhI87N7-bM8AOwqaPrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D6671005510;
 Wed, 13 May 2020 11:06:15 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 195255C1C3;
 Wed, 13 May 2020 11:06:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 10/34] block: Add generic bdrv_inherited_options()
Date: Wed, 13 May 2020 13:05:20 +0200
Message-Id: <20200513110544.176672-11-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After the series this patch belongs to, we want to have a common
BdrvChildClass that encompasses all of child_file, child_format, and
child_backing.  Such a single class needs a single .inherit_options()
implementation, and this patch introduces it.

The next patch will show how the existing implementations can fall back
to it just by passing appropriate BdrvChildRole and parent_is_format
values.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/block.c b/block.c
index a17c29f54b..9b0e13d537 100644
--- a/block.c
+++ b/block.c
@@ -1356,6 +1356,87 @@ const BdrvChildClass child_backing = {
     .set_aio_ctx     = bdrv_child_cb_set_aio_ctx,
 };
 
+/*
+ * Returns the options and flags that a generic child of a BDS should
+ * get, based on the given options and flags for the parent BDS.
+ */
+static void __attribute__((unused))
+    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
+                           int *child_flags, QDict *child_options,
+                           int parent_flags, QDict *parent_options)
+{
+    int flags = parent_flags;
+
+    /*
+     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
+     * Generally, the question to answer is: Should this child be
+     * format-probed by default?
+     */
+
+    /*
+     * Pure and non-filtered data children of non-format nodes should
+     * be probed by default (even when the node itself has BDRV_O_PROTOCOL
+     * set).  This only affects a very limited set of drivers (namely
+     * quorum and blkverify when this comment was written).
+     * Force-clear BDRV_O_PROTOCOL then.
+     */
+    if (!parent_is_format &&
+        (role & BDRV_CHILD_DATA) &&
+        !(role & (BDRV_CHILD_METADATA | BDRV_CHILD_FILTERED)))
+    {
+        flags &= ~BDRV_O_PROTOCOL;
+    }
+
+    /*
+     * All children of format nodes (except for COW children) and all
+     * metadata children in general should never be format-probed.
+     * Force-set BDRV_O_PROTOCOL then.
+     */
+    if ((parent_is_format && !(role & BDRV_CHILD_COW)) ||
+        (role & BDRV_CHILD_METADATA))
+    {
+        flags |= BDRV_O_PROTOCOL;
+    }
+
+    /*
+     * If the cache mode isn't explicitly set, inherit direct and no-flush from
+     * the parent.
+     */
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
+
+    if (role & BDRV_CHILD_COW) {
+        /* backing files are opened read-only by default */
+        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off");
+    } else {
+        /* Inherit the read-only option from the parent if it's not set */
+        qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
+        qdict_copy_default(child_options, parent_options,
+                           BDRV_OPT_AUTO_READ_ONLY);
+    }
+
+    /*
+     * bdrv_co_pdiscard() respects unmap policy for the parent, so we
+     * can default to enable it on lower layers regardless of the
+     * parent option.
+     */
+    qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
+
+    /* Clear flags that only apply to the top layer */
+    flags &= ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ);
+
+    if (role & BDRV_CHILD_METADATA) {
+        flags &= ~BDRV_O_NO_IO;
+    }
+    if (role & BDRV_CHILD_COW) {
+        flags &= ~BDRV_O_TEMPORARY;
+    }
+
+    *child_flags = flags;
+}
+
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
 {
     int open_flags = flags;
-- 
2.26.2



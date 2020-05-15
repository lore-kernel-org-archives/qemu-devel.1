Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3C6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F172074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwFk3L//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F172074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZv0-0001U6-Ct
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZil-0002Re-OL
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZik-00028Y-Ol
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBEmMGqi6ZNN1IyZqPkJsTyC3XdJqJlJpc+mdmfSHvc=;
 b=XwFk3L//j96UTR+LwFb7+qf5tUmYD73YjDskn1UQgtKLzKQxlxS2/HOLZhLcr9q1s+sPky
 rZ7m+8zx4Iru8VlC9YAa0fLVkoIM1LBIHqjqTf+10joGGESHL27mHrZUGQe0W84YMZdqpj
 OYhQYP/YKxngPzxcwewnJiuBnTzju+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-xXo0nGq6MbCS5OCEtoT_ZQ-1; Fri, 15 May 2020 08:45:41 -0400
X-MC-Unique: xXo0nGq6MbCS5OCEtoT_ZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2620F100CCC6;
 Fri, 15 May 2020 12:45:40 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1222E024;
 Fri, 15 May 2020 12:45:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/51] block: Add bdrv_make_empty()
Date: Fri, 15 May 2020 14:44:38 +0200
Message-Id: <20200515124521.335403-9-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
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

Right now, all users of bdrv_make_empty() call the BlockDriver method
directly.  That is not only bad style, it is also wrong, unless the
caller has a BdrvChild with a WRITE or WRITE_UNCHANGED permission.
(WRITE_UNCHANGED suffices, because callers generally use this function
to clear a node with a backing file after a commit operation.)

Introduce bdrv_make_empty() that verifies that it does.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200429141126.85159-2-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 4de8d8f8a6..8f3eb70df4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -352,6 +352,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
+int bdrv_make_empty(BdrvChild *c, Error **errp);
 int bdrv_change_backing_file(BlockDriverState *bs,
     const char *backing_file, const char *backing_fmt);
 void bdrv_register(BlockDriver *bdrv);
diff --git a/block.c b/block.c
index 0653ccb913..c6a5c144b7 100644
--- a/block.c
+++ b/block.c
@@ -6764,3 +6764,26 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
+
+int bdrv_make_empty(BdrvChild *c, Error **errp)
+{
+    BlockDriver *drv = c->bs->drv;
+    int ret;
+
+    assert(c->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED));
+
+    if (!drv->bdrv_make_empty) {
+        error_setg(errp, "%s does not support emptying nodes",
+                   drv->format_name);
+        return -ENOTSUP;
+    }
+
+    ret = drv->bdrv_make_empty(c->bs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to empty %s",
+                         c->bs->filename);
+        return ret;
+    }
+
+    return 0;
+}
-- 
2.25.4



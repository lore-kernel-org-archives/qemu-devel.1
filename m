Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCEC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D512083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVPEc3ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D512083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnSL-00069x-2K
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnR9-0004EV-HH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnR7-0003oX-Rn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTnR7-0003nk-C7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQKFlGPfdHV/T7NfahVMwoaWj+cSCQ1SVe+ijrXL3rg=;
 b=XVPEc3nikVDduR09PvJntAbYq75FwyZaUwSxPWlH1XzDLr9rOl54+hEOsJF6UDwMIpTtzd
 MT9E4XaoRTuXoc78WL4sGz0sO1A7UuV17G2fJ7HZWTDIVt6o5aaZoIuebxV1wdJoWKY7cS
 rA7z7lNxMjP0fIyd3U6V7XjhIX2Aptc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-rRQztMSCNl-09LJIAtdX2g-1; Wed, 29 Apr 2020 10:11:38 -0400
X-MC-Unique: rRQztMSCNl-09LJIAtdX2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AAF918FE894;
 Wed, 29 Apr 2020 14:11:30 +0000 (UTC)
Received: from localhost (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC60A1E4;
 Wed, 29 Apr 2020 14:11:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/4] block: Add bdrv_make_empty()
Date: Wed, 29 Apr 2020 16:11:23 +0200
Message-Id: <20200429141126.85159-2-mreitz@redhat.com>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
References: <20200429141126.85159-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Right now, all users of bdrv_make_empty() call the BlockDriver method
directly.  That is not only bad style, it is also wrong, unless the
caller has a BdrvChild with a WRITE or WRITE_UNCHANGED permission.
(WRITE_UNCHANGED suffices, because callers generally use this function
to clear a node with a backing file after a commit operation.)

Introduce bdrv_make_empty() that verifies that it does.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 8b62429aa4..1dee50419c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -352,6 +352,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOp=
ts *opts,
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
+int bdrv_make_empty(BdrvChild *c, Error **errp);
 int bdrv_change_backing_file(BlockDriverState *bs,
     const char *backing_file, const char *backing_fmt);
 void bdrv_register(BlockDriver *bdrv);
diff --git a/block.c b/block.c
index 03cc5813a2..d6580db0e2 100644
--- a/block.c
+++ b/block.c
@@ -6792,3 +6792,26 @@ void bdrv_del_child(BlockDriverState *parent_bs, Bdr=
vChild *child, Error **errp)
=20
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
+
+int bdrv_make_empty(BdrvChild *c, Error **errp)
+{
+    BlockDriver *drv =3D c->bs->drv;
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
+    ret =3D drv->bdrv_make_empty(c->bs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to empty %s",
+                         c->bs->filename);
+        return ret;
+    }
+
+    return 0;
+}
--=20
2.25.4



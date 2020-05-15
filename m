Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62125C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC9420759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtYjOoXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC9420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZrS-0001sp-9k
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj2-0002fV-0X
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55473
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZiy-0002HZ-Se
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6lTg6a3QM18al2S3+S2XLqdZEbQ4UGskqMO+IKKf34=;
 b=OtYjOoXXz4R5u5IxW88NrAfUBKL3RP0Jhv2JNBbzYwWPbTa1qEVUqiiKzuKoubN7ZkZqFm
 lwTAGaJQsiOyYTFUq4ciTTXpXOgNlUs3TtxK6zL9naHRATijgZ60T6fzNLndssy7/X2v6h
 LuSxMLTYF/mTsHOXBrsIhcK9vY4bLoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-IaqU17rrO2agvILcRLZY5Q-1; Fri, 15 May 2020 08:45:54 -0400
X-MC-Unique: IaqU17rrO2agvILcRLZY5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 197EF460;
 Fri, 15 May 2020 12:45:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D70A2E047;
 Fri, 15 May 2020 12:45:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/51] block: Add BdrvChildRole and BdrvChildRoleBits
Date: Fri, 15 May 2020 14:44:46 +0200
Message-Id: <20200515124521.335403-17-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

This mask will supplement BdrvChildClass when it comes to what role (or
combination of roles) a child takes for its parent.  It consists of
BdrvChildRoleBits values (which is an enum).

Because empty enums are not allowed, let us just start with it filled.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-5-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index bc42e507bb..35f1a1cecf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -268,6 +268,62 @@ enum {
     DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
+/*
+ * Flags that parent nodes assign to child nodes to specify what kind of
+ * role(s) they take.
+ *
+ * At least one of DATA, METADATA, FILTERED, or COW must be set for
+ * every child.
+ */
+enum BdrvChildRoleBits {
+    /*
+     * This child stores data.
+     * Any node may have an arbitrary number of such children.
+     */
+    BDRV_CHILD_DATA         = (1 << 0),
+
+    /*
+     * This child stores metadata.
+     * Any node may have an arbitrary number of metadata-storing
+     * children.
+     */
+    BDRV_CHILD_METADATA     = (1 << 1),
+
+    /*
+     * A child that always presents exactly the same visible data as
+     * the parent, e.g. by virtue of the parent forwarding all reads
+     * and writes.
+     * This flag is mutually exclusive with DATA, METADATA, and COW.
+     * Any node may have at most one filtered child at a time.
+     */
+    BDRV_CHILD_FILTERED     = (1 << 2),
+
+    /*
+     * Child from which to read all data that isn’t allocated in the
+     * parent (i.e., the backing child); such data is copied to the
+     * parent through COW (and optionally COR).
+     * This field is mutually exclusive with DATA, METADATA, and
+     * FILTERED.
+     * Any node may have at most one such backing child at a time.
+     */
+    BDRV_CHILD_COW          = (1 << 3),
+
+    /*
+     * The primary child.  For most drivers, this is the child whose
+     * filename applies best to the parent node.
+     * Any node may have at most one primary child at a time.
+     */
+    BDRV_CHILD_PRIMARY      = (1 << 4),
+
+    /* Useful combination of flags */
+    BDRV_CHILD_IMAGE        = BDRV_CHILD_DATA
+                              | BDRV_CHILD_METADATA
+                              | BDRV_CHILD_PRIMARY,
+};
+
+/* Mask of BdrvChildRoleBits values */
+typedef unsigned int BdrvChildRole;
+
 char *bdrv_perm_names(uint64_t perm);
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
 
-- 
2.25.4



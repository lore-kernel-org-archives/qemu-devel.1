Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872FC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5468D2068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp5ldQCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5468D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxJC-00018K-7M
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBM-0003q2-E2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBL-000646-Ay
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBL-00063U-1Z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B666mKMkBiF/0bIbF/qaWNLGs3ALQtMJiHnqAmP93zo=;
 b=Lp5ldQCNqy4bLzHVePZaChNewojc5r2nLXKSooPHjb+tTDje6B5Y7Obd1coAWcWJm/nhKp
 g8pAYWgevqh5xu0sGHp91R96YOS3n7ECssWSOSfdNYHK27ye+GRYCkt0SSgJoX3IhIjzND
 BxTyStBtkCKamaP/5nAARgWKbhW+2Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-JEj7GpKCOyq52t69Od1TYg-1; Wed, 27 Nov 2019 08:16:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE9B0802585;
 Wed, 27 Nov 2019 13:16:31 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 793345C219;
 Wed, 27 Nov 2019 13:16:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 02/31] block: Add BdrvChildRole
Date: Wed, 27 Nov 2019 14:15:55 +0100
Message-Id: <20191127131624.1062403-3-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JEj7GpKCOyq52t69Od1TYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

This enum will supplement BdrvChildClass when it comes to what role (or
combination of roles) a child takes for its parent.

Because empty enums are not allowed, let us just start with it filled.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 38963ef203..36817d5689 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -279,6 +279,44 @@ enum {
     DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROU=
GH,
 };
=20
+typedef enum BdrvChildRole {
+    /*
+     * If present, bdrv_replace_node() will not change the node this
+     * BdrvChild points to.
+     */
+    BDRV_CHILD_STAY_AT_NODE =3D (1 << 0),
+
+    /* Child stores data */
+    BDRV_CHILD_DATA         =3D (1 << 1),
+
+    /* Child stores metadata */
+    BDRV_CHILD_METADATA     =3D (1 << 2),
+
+    /* Filtered child */
+    BDRV_CHILD_FILTERED     =3D (1 << 3),
+
+    /* Child to COW from (backing child) */
+    BDRV_CHILD_COW          =3D (1 << 4),
+
+    /* Child is expected to be a protocol node */
+    BDRV_CHILD_PROTOCOL     =3D (1 << 5),
+
+    /* Child is expected to be a format node */
+    BDRV_CHILD_FORMAT       =3D (1 << 6),
+
+    /*
+     * The primary child.  For most drivers, this is the child whose
+     * filename applies best to the parent node.
+     */
+    BDRV_CHILD_PRIMARY      =3D (1 << 7),
+
+    /* Useful combination of flags */
+    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
+                              | BDRV_CHILD_METADATA
+                              | BDRV_CHILD_PROTOCOL
+                              | BDRV_CHILD_PRIMARY,
+} BdrvChildRole;
+
 char *bdrv_perm_names(uint64_t perm);
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
=20
--=20
2.23.0



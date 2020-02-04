Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50715C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5CE2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNbYwqWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5CE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1ka-0008Ag-8a
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hC-0002cO-CW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hB-0001nR-Fm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hB-0001md-Cg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqIQyGKK1jBaGsPdtuKlUu2WkAmKUzmE4Za7JI6HE3k=;
 b=gNbYwqWaFf4Nd9PrcQT1bAltlXo+R7u6oJTCoBLEDCHpWxxFJuFmHP9wdPoPPeEO3yfY1N
 VfuMw4Rju/JuEkYD+EhC8bxuhpVDJjllwMsxaEikekE05PPG9hO+vhio4Lj6NBi/CVGKk9
 Z3al38TzaegLN3vEZz/VVuqfjryghvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-flwW7yBbNP-7xUXXlMn4Lw-1; Tue, 04 Feb 2020 12:09:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5419E1882CCC;
 Tue,  4 Feb 2020 17:09:00 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE80787B12;
 Tue,  4 Feb 2020 17:08:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 03/33] block: Add BdrvChildRole
Date: Tue,  4 Feb 2020 18:08:18 +0100
Message-Id: <20200204170848.614480-4-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: flwW7yBbNP-7xUXXlMn4Lw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This enum will supplement BdrvChildClass when it comes to what role (or
combination of roles) a child takes for its parent.

Because empty enums are not allowed, let us just start with it filled.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 38963ef203..0f7e8caa5b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -279,6 +279,33 @@ enum {
     DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROU=
GH,
 };
=20
+typedef enum BdrvChildRole {
+    /* Child stores data */
+    BDRV_CHILD_DATA         =3D (1 << 0),
+
+    /* Child stores metadata */
+    BDRV_CHILD_METADATA     =3D (1 << 1),
+
+    /* Filtered child */
+    BDRV_CHILD_FILTERED     =3D (1 << 2),
+
+    /* Child to COW from (backing child) */
+    BDRV_CHILD_COW          =3D (1 << 3),
+
+    /*
+     * The primary child.  For most drivers, this is the child whose
+     * filename applies best to the parent node.
+     * Each parent must give this flag to no more than one child at a
+     * time.
+     */
+    BDRV_CHILD_PRIMARY      =3D (1 << 4),
+
+    /* Useful combination of flags */
+    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
+                              | BDRV_CHILD_METADATA
+                              | BDRV_CHILD_PRIMARY,
+} BdrvChildRole;
+
 char *bdrv_perm_names(uint64_t perm);
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
=20
--=20
2.24.1



Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEBC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A3C206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A3C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIx1d-0006Pw-V3
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqi-000235-Vd
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqh-0006jp-U5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:29:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqf-0006hI-KN; Fri, 11 Oct 2019 11:28:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4CF3C059B80;
 Fri, 11 Oct 2019 15:28:56 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CFFC5D6C8;
 Fri, 11 Oct 2019 15:28:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 14/16] qcow2: Fix v3 snapshot table entry compliancy
Date: Fri, 11 Oct 2019 17:28:12 +0200
Message-Id: <20191011152814.14791-15-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 11 Oct 2019 15:28:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

qcow2 v3 images require every snapshot table entry to have at least 16
bytes of extra data.  If they do not, let qemu-img check -r all fix it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-snapshot.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index dac8a778e4..5ab64da1ec 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -516,6 +516,24 @@ int coroutine_fn qcow2_check_read_snapshot_table(Blo=
ckDriverState *bs,
         result->corruptions -=3D nb_clusters_reduced;
     }
=20
+    /*
+     * All of v3 images' snapshot table entries need to have at least
+     * 16 bytes of extra data.
+     */
+    if (s->qcow_version >=3D 3) {
+        int i;
+        for (i =3D 0; i < s->nb_snapshots; i++) {
+            if (s->snapshots[i].extra_data_size <
+                sizeof_field(QCowSnapshotExtraData, vm_state_size_large)=
 +
+                sizeof_field(QCowSnapshotExtraData, disk_size))
+            {
+                result->corruptions++;
+                fprintf(stderr, "%s snapshot table entry %i is incomplet=
e\n",
+                        fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i=
);
+            }
+        }
+    }
+
     return 0;
 }
=20
--=20
2.21.0



Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8546ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E590206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E590206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwsX-0003MT-1k
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqB-0001GI-IQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqA-0006Pv-IM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwq8-0006Mx-FQ; Fri, 11 Oct 2019 11:28:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4D3B3090FDD;
 Fri, 11 Oct 2019 15:28:23 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BDD3600C4;
 Fri, 11 Oct 2019 15:28:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 02/16] qcow2: Use endof()
Date: Fri, 11 Oct 2019 17:28:00 +0200
Message-Id: <20191011152814.14791-3-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 15:28:23 +0000 (UTC)
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-snapshot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index d0e7fa9311..752883e5c3 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -92,11 +92,12 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         }
         offset +=3D extra_data_size;
=20
-        if (extra_data_size >=3D 8) {
+        if (extra_data_size >=3D endof(QCowSnapshotExtraData,
+                                     vm_state_size_large)) {
             sn->vm_state_size =3D be64_to_cpu(extra.vm_state_size_large)=
;
         }
=20
-        if (extra_data_size >=3D 16) {
+        if (extra_data_size >=3D endof(QCowSnapshotExtraData, disk_size)=
) {
             sn->disk_size =3D be64_to_cpu(extra.disk_size);
         } else {
             sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
@@ -251,7 +252,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs=
)
     }
=20
     QEMU_BUILD_BUG_ON(offsetof(QCowHeader, snapshots_offset) !=3D
-        offsetof(QCowHeader, nb_snapshots) + sizeof(header_data.nb_snaps=
hots));
+                      endof(QCowHeader, nb_snapshots));
=20
     header_data.nb_snapshots        =3D cpu_to_be32(s->nb_snapshots);
     header_data.snapshots_offset    =3D cpu_to_be64(snapshots_offset);
--=20
2.21.0



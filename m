Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA64CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57E7214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kwg1/Zze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57E7214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4rc-0004JQ-D9
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3x9-00039i-Tn
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3x4-00023N-Ea
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wz-0001zx-BQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfzDy2KOnVpKUUBJ6sbP5TwiIljc61cRVIU05TJ6Nzo=;
 b=Kwg1/ZzequqmGweGqhEvyqFezooPf24qToLsysaF3MU2e3XqDHn+2t82qyRTRb07cJNSbK
 9YVeS3nSEWdY0MUAkKz1Uq25VcXwgq5yHWwYUXf20WeatjTDTvaQNYbLireAbbfg6CYPX+
 FBlDf+j6ugSel8HxaEq/aLyTZzh+Yvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-gzAlgX6tPyiLnt8sFGTySw-1; Mon, 28 Oct 2019 08:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86BD3107AD29;
 Mon, 28 Oct 2019 12:16:38 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2983360850;
 Mon, 28 Oct 2019 12:16:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 46/69] qcow2: Use endof()
Date: Mon, 28 Oct 2019 13:14:38 +0100
Message-Id: <20191028121501.15279-47-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: gzAlgX6tPyiLnt8sFGTySw-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191011152814.14791-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
             sn->vm_state_size =3D be64_to_cpu(extra.vm_state_size_large);
         }
=20
-        if (extra_data_size >=3D 16) {
+        if (extra_data_size >=3D endof(QCowSnapshotExtraData, disk_size)) =
{
             sn->disk_size =3D be64_to_cpu(extra.disk_size);
         } else {
             sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
@@ -251,7 +252,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs)
     }
=20
     QEMU_BUILD_BUG_ON(offsetof(QCowHeader, snapshots_offset) !=3D
-        offsetof(QCowHeader, nb_snapshots) + sizeof(header_data.nb_snapsho=
ts));
+                      endof(QCowHeader, nb_snapshots));
=20
     header_data.nb_snapshots        =3D cpu_to_be32(s->nb_snapshots);
     header_data.snapshots_offset    =3D cpu_to_be64(snapshots_offset);
--=20
2.21.0



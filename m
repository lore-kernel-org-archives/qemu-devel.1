Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07164C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C867F2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLO8LJFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C867F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBiF-0000Lu-Pq
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBWo-0007pT-ME
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBUl-0003OS-B2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUBUk-0003OA-SR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbZF22i6dBX88TQIycZD5gVM88/TPJPcQrNB8HIRnRA=;
 b=FLO8LJFRhO7rKaM6nFoSiiU5woOCO57plkCTtTReKCxZ42TMrSyA91pcdad/CoUn8yluTz
 nIGL1GU/DyJSfGa7N+c0vOfK5pdDRKOxTl6oHu0WPLHU8Zl2dlmPVECWq5CuxURYnHRpyf
 5xfpAcwYpLklLoHQmgT/Fhw+LOuz1mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-QMGQVT7uNPGSj7qr5nsuog-1; Thu, 30 Apr 2020 11:53:00 -0400
X-MC-Unique: QMGQVT7uNPGSj7qr5nsuog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1528804055;
 Thu, 30 Apr 2020 15:52:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DDDB619F8;
 Thu, 30 Apr 2020 15:52:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/15] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Thu, 30 Apr 2020 17:52:22 +0200
Message-Id: <20200430155231.473156-7-kwolf@redhat.com>
In-Reply-To: <20200430155231.473156-1-kwolf@redhat.com>
References: <20200430155231.473156-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
undo any previous preallocation, but just adds the zero flag to all
relevant L2 entries. If an external data file is in use, a write_zeroes
request to the data file is made instead.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200424125448.63318-5-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c |  2 +-
 block/qcow2.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 17f1363279..4b5fc8c4a7 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1795,7 +1795,7 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint6=
4_t offset,
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
-           end_offset =3D=3D bs->total_sectors << BDRV_SECTOR_BITS);
+           end_offset >=3D bs->total_sectors << BDRV_SECTOR_BITS);
=20
     /* The zero flag is only supported by version 3 and newer */
     if (s->qcow_version < 3) {
diff --git a/block/qcow2.c b/block/qcow2.c
index 9cfbdfc939..98065d7808 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
=20
     bs->supported_zero_flags =3D header.version >=3D 3 ?
                                BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK :=
 0;
+    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
=20
     /* Repair image if dirty */
     if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
@@ -4214,6 +4215,39 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
         g_assert_not_reached();
     }
=20
+    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
+        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_size)=
;
+
+        /*
+         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
+         * requires a cluster-aligned start. The end may be unaligned if i=
t is
+         * at the end of the image (which it is here).
+         */
+        ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_start,=
 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to zero out new clusters"=
);
+            goto fail;
+        }
+
+        /* Write explicit zeros for the unaligned head */
+        if (zero_start > old_length) {
+            uint64_t len =3D zero_start - old_length;
+            uint8_t *buf =3D qemu_blockalign0(bs, len);
+            QEMUIOVector qiov;
+            qemu_iovec_init_buf(&qiov, buf, len);
+
+            qemu_co_mutex_unlock(&s->lock);
+            ret =3D qcow2_co_pwritev_part(bs, old_length, len, &qiov, 0, 0=
);
+            qemu_co_mutex_lock(&s->lock);
+
+            qemu_vfree(buf);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to zero out the new a=
rea");
+                goto fail;
+            }
+        }
+    }
+
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         /* Flush metadata before actually changing the image size */
         ret =3D qcow2_write_caches(bs);
--=20
2.25.3



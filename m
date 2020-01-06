Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3115C33C9B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821872075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4Sgx+G4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821872075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTwA-00008j-5r
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbk-0007Uu-7X
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbi-0000wl-9O
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbi-0000wM-5K
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALrgf1ejh1uyRY0B/Cnfkz3HYp0WNNSyUUF0a8TRbWI=;
 b=d4Sgx+G4qMJMH9JJIUJkOmaoxqmrWH+ngnEs/oGVfZhhATVBh8x9tv2ConIEidAzDQGCf4
 T9U7lT26FBb1O/pQN8kMdi+GHUGm37uaLuAM+omnBqVxWcFy9Swyi/vePmRQbpuzgndaLW
 9lUygPVNXBwMCBNNWlSlt9D2eD+B4O4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-LI9gq9H9P9GZYo67oqi6Lw-1; Mon, 06 Jan 2020 09:43:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B953805141;
 Mon,  6 Jan 2020 14:43:45 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99F91691AD;
 Mon,  6 Jan 2020 14:43:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/34] block: introduce compress filter driver
Date: Mon,  6 Jan 2020 15:42:02 +0100
Message-Id: <20200106144206.698920-31-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: LI9gq9H9P9GZYo67oqi6Lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Allow writing all the data compressed through the filter driver.
The written data will be aligned by the cluster size.
Based on the QEMU current implementation, that data can be written to
unallocated clusters only. May be used for a backup job.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 1575288906-551879-2-git-send-email-andrey.shinkevich@virtuozzo.=
com
[mreitz: Replace NULL bdrv_get_format_name() by "(no format)"]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs     |   1 +
 block/filter-compress.c | 168 ++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json    |  10 ++-
 3 files changed, 175 insertions(+), 4 deletions(-)
 create mode 100644 block/filter-compress.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index e394fe0b6c..330529b0b7 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
=20
 block-obj-y +=3D aio_task.o
 block-obj-y +=3D backup-top.o
+block-obj-y +=3D filter-compress.o
=20
 common-obj-y +=3D stream.o
=20
diff --git a/block/filter-compress.c b/block/filter-compress.c
new file mode 100644
index 0000000000..60137fb680
--- /dev/null
+++ b/block/filter-compress.c
@@ -0,0 +1,168 @@
+/*
+ * Compress filter block driver
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH
+ *
+ * Author:
+ *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
+ *   (based on block/copy-on-read.c by Max Reitz)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) any later version of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+
+
+static int compress_open(BlockDriverState *bs, QDict *options, int flags,
+                         Error **errp)
+{
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, f=
alse,
+                               errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    if (!bs->file->bs->drv || !block_driver_can_compress(bs->file->bs->drv=
)) {
+        error_setg(errp,
+                   "Compression is not supported for underlying format: %s=
",
+                   bdrv_get_format_name(bs->file->bs) ?: "(no format)");
+
+        return -ENOTSUP;
+    }
+
+    bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
+
+    bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+        ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
+            bs->file->bs->supported_zero_flags);
+
+    return 0;
+}
+
+
+static int64_t compress_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+
+static int coroutine_fn compress_co_preadv_part(BlockDriverState *bs,
+                                                uint64_t offset, uint64_t =
bytes,
+                                                QEMUIOVector *qiov,
+                                                size_t qiov_offset,
+                                                int flags)
+{
+    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
+                               flags);
+}
+
+
+static int coroutine_fn compress_co_pwritev_part(BlockDriverState *bs,
+                                                 uint64_t offset,
+                                                 uint64_t bytes,
+                                                 QEMUIOVector *qiov,
+                                                 size_t qiov_offset, int f=
lags)
+{
+    return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset=
,
+                                flags | BDRV_REQ_WRITE_COMPRESSED);
+}
+
+
+static int coroutine_fn compress_co_pwrite_zeroes(BlockDriverState *bs,
+                                                  int64_t offset, int byte=
s,
+                                                  BdrvRequestFlags flags)
+{
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+
+static int coroutine_fn compress_co_pdiscard(BlockDriverState *bs,
+                                             int64_t offset, int bytes)
+{
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
+}
+
+
+static void compress_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    BlockDriverInfo bdi;
+    int ret;
+
+    if (!bs->file) {
+        return;
+    }
+
+    ret =3D bdrv_get_info(bs->file->bs, &bdi);
+    if (ret < 0 || bdi.cluster_size =3D=3D 0) {
+        return;
+    }
+
+    bs->bl.request_alignment =3D bdi.cluster_size;
+}
+
+
+static void compress_eject(BlockDriverState *bs, bool eject_flag)
+{
+    bdrv_eject(bs->file->bs, eject_flag);
+}
+
+
+static void compress_lock_medium(BlockDriverState *bs, bool locked)
+{
+    bdrv_lock_medium(bs->file->bs, locked);
+}
+
+
+static bool compress_recurse_is_first_non_filter(BlockDriverState *bs,
+                                                 BlockDriverState *candida=
te)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+
+static BlockDriver bdrv_compress =3D {
+    .format_name                        =3D "compress",
+
+    .bdrv_open                          =3D compress_open,
+    .bdrv_child_perm                    =3D bdrv_filter_default_perms,
+
+    .bdrv_getlength                     =3D compress_getlength,
+
+    .bdrv_co_preadv_part                =3D compress_co_preadv_part,
+    .bdrv_co_pwritev_part               =3D compress_co_pwritev_part,
+    .bdrv_co_pwrite_zeroes              =3D compress_co_pwrite_zeroes,
+    .bdrv_co_pdiscard                   =3D compress_co_pdiscard,
+    .bdrv_refresh_limits                =3D compress_refresh_limits,
+
+    .bdrv_eject                         =3D compress_eject,
+    .bdrv_lock_medium                   =3D compress_lock_medium,
+
+    .bdrv_co_block_status               =3D bdrv_co_block_status_from_file=
,
+
+    .bdrv_recurse_is_first_non_filter   =3D compress_recurse_is_first_non_=
filter,
+
+    .has_variable_length                =3D true,
+    .is_filter                          =3D true,
+};
+
+static void bdrv_compress_init(void)
+{
+    bdrv_register(&bdrv_compress);
+}
+
+block_init(bdrv_compress_init);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 839b10b3f0..7ff5e5edaf 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2884,15 +2884,16 @@
 # @copy-on-read: Since 3.0
 # @blklogwrites: Since 3.0
 # @blkreplay: Since 4.2
+# @compress: Since 5.0
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
   'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
-            'cloop', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluste=
r',
-            'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
-            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qco=
w',
-            'qcow2', 'qed', 'quorum', 'raw', 'rbd',
+            'cloop', 'compress', 'copy-on-read', 'dmg', 'file', 'ftp', 'ft=
ps',
+            'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscs=
i',
+            'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallel=
s',
+            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
             { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' }=
,
             'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxh=
s' ] }
@@ -4060,6 +4061,7 @@
       'blkreplay':  'BlockdevOptionsBlkreplay',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
+      'compress':   'BlockdevOptionsGenericFormat',
       'copy-on-read':'BlockdevOptionsGenericFormat',
       'dmg':        'BlockdevOptionsGenericFormat',
       'file':       'BlockdevOptionsFile',
--=20
2.24.1



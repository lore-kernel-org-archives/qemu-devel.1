Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE1C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C120021911
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C120021911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKqJ-0000ah-ET
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqKp7-0004Mr-Sh
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqKp6-0005Up-N9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqKp4-0005Hm-8i; Wed, 24 Jul 2019 13:13:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 994F9C03D478;
 Wed, 24 Jul 2019 17:13:01 +0000 (UTC)
Received: from localhost (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13AD919C70;
 Wed, 24 Jul 2019 17:13:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 24 Jul 2019 19:12:34 +0200
Message-Id: <20190724171239.8764-7-mreitz@redhat.com>
In-Reply-To: <20190724171239.8764-1-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 24 Jul 2019 17:13:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/11] qcow2: Fix .bdrv_has_zero_init()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a qcow2 file is preallocated, it can no longer guarantee that it
initially appears as filled with zeroes.

So implement .bdrv_has_zero_init() by checking whether the file is
preallocated; if so, forward the call to the underlying storage node,
except for when it is encrypted: Encrypted preallocated images always
return effectively random data, so .bdrv_has_zero_init() must always
return 0 for them.

.bdrv_has_zero_init_truncate() can remain bdrv_has_zero_init_1(),
because it presupposes PREALLOC_MODE_OFF.

Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5c40f54d64..b4e73aa443 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4631,6 +4631,33 @@ static ImageInfoSpecific *qcow2_get_specific_info(=
BlockDriverState *bs,
     return spec_info;
 }
=20
+static int qcow2_has_zero_init(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    bool preallocated;
+
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_lock(&s->lock);
+    }
+    /*
+     * Check preallocation status: Preallocated images have all L2
+     * tables allocated, nonpreallocated images have none.  It is
+     * therefore enough to check the first one.
+     */
+    preallocated =3D s->l1_size > 0 && s->l1_table[0] !=3D 0;
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_unlock(&s->lock);
+    }
+
+    if (!preallocated) {
+        return 1;
+    } else if (bs->encrypted) {
+        return 0;
+    } else {
+        return bdrv_has_zero_init(s->data_file->bs);
+    }
+}
+
 static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
@@ -5186,7 +5213,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_child_perm      =3D bdrv_format_default_perms,
     .bdrv_co_create_opts  =3D qcow2_co_create_opts,
     .bdrv_co_create       =3D qcow2_co_create,
-    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init   =3D qcow2_has_zero_init,
     .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status =3D qcow2_co_block_status,
=20
--=20
2.21.0



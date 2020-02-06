Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82927C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB67214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeA+Iwe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB67214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgwe-0001fh-FZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgda-0003eX-9k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdZ-0001bN-4x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdZ-0001a8-05
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqo7MVHTBI7kl9I3qqaNlxz1m3T5533p6sUiSY8WrKA=;
 b=CeA+Iwe9tXAFVp8YHJKzFc+wt10adkr8vMS4y6p8RqLrkaxFrbaQK4OB9GowNhFPhBXrpY
 zkPkFCxEhHcRLVZfQGH+REgz+yF4gaViCNpEDv5GgG88DfN6vsRJq2DD+JuMk5Ux+Rz8dI
 rsZSizX6wgx7o+xxj94RRGEXvv/u4Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-qMjctD4yMEiZRI6zpZDwvw-1; Thu, 06 Feb 2020 07:52:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A9C78C2FE1;
 Thu,  6 Feb 2020 12:52:01 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC9326E4B;
 Thu,  6 Feb 2020 12:52:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/17] qcow2: Use bs->bl.request_alignment when updating an L1
 entry
Date: Thu,  6 Feb 2020 13:51:28 +0100
Message-Id: <20200206125132.594625-14-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qMjctD4yMEiZRI6zpZDwvw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

When updating an L1 entry the qcow2 driver writes a (512-byte) sector
worth of data to avoid a read-modify-write cycle. Instead of always
writing 512 bytes we should follow the alignment requirements of the
storage backend.

(the only exception is when the alignment is larger than the cluster
size because then we could be overwriting data after the L1 table)

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 71f34d4ae4b367b32fb36134acbf4f4f7ee681f4.1579374329.git.berto@i=
galia.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0384fb2339..1947f13a2d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -216,26 +216,31 @@ static int l2_load(BlockDriverState *bs, uint64_t off=
set,
 }
=20
 /*
- * Writes one sector of the L1 table to the disk (can't update single entr=
ies
- * and we really don't want bdrv_pread to perform a read-modify-write)
+ * Writes an L1 entry to disk (note that depending on the alignment
+ * requirements this function may write more that just one entry in
+ * order to prevent bdrv_pwrite from performing a read-modify-write)
  */
-#define L1_ENTRIES_PER_SECTOR (512 / 8)
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    uint64_t buf[L1_ENTRIES_PER_SECTOR] =3D { 0 };
     int l1_start_index;
     int i, ret;
+    int bufsize =3D MAX(sizeof(uint64_t),
+                      MIN(bs->file->bs->bl.request_alignment, s->cluster_s=
ize));
+    int nentries =3D bufsize / sizeof(uint64_t);
+    g_autofree uint64_t *buf =3D g_try_new0(uint64_t, nentries);
=20
-    l1_start_index =3D l1_index & ~(L1_ENTRIES_PER_SECTOR - 1);
-    for (i =3D 0; i < L1_ENTRIES_PER_SECTOR && l1_start_index + i < s->l1_=
size;
-         i++)
-    {
+    if (buf =3D=3D NULL) {
+        return -ENOMEM;
+    }
+
+    l1_start_index =3D QEMU_ALIGN_DOWN(l1_index, nentries);
+    for (i =3D 0; i < MIN(nentries, s->l1_size - l1_start_index); i++) {
         buf[i] =3D cpu_to_be64(s->l1_table[l1_start_index + i]);
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L1,
-            s->l1_table_offset + 8 * l1_start_index, sizeof(buf), false);
+            s->l1_table_offset + 8 * l1_start_index, bufsize, false);
     if (ret < 0) {
         return ret;
     }
@@ -243,7 +248,7 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_i=
ndex)
     BLKDBG_EVENT(bs->file, BLKDBG_L1_UPDATE);
     ret =3D bdrv_pwrite_sync(bs->file,
                            s->l1_table_offset + 8 * l1_start_index,
-                           buf, sizeof(buf));
+                           buf, bufsize);
     if (ret < 0) {
         return ret;
     }
--=20
2.24.1



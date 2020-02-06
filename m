Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD68C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF63621741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiM+5Z4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF63621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izghM-0003TC-0i
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdC-0002hA-78
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgd9-00006e-Q4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgd9-0008UK-MC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfhWKSPujBhyPDKoAjyuD6mRn/QZgvQar/qO4t/5+O4=;
 b=fiM+5Z4pKm/ZK9NqSYk+uDymjemGGh+yP6bQc+yXwZMcF1e3DLkCFWe4zz+CTwtpiJo1Ma
 aREmAqwK3GsBatQZfQgZSyakv68VfEijSFyqbwNd3fbJw49o1NKbd73C4NvZgHeBdsHHJa
 WvwdVwwMI2EPtuZNoh0uzqz7kuHmC0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-ajy2vLtDNJ6WlNLcnvC8uw-1; Thu, 06 Feb 2020 07:51:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333AB7A136;
 Thu,  6 Feb 2020 12:51:36 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C831D26FB0;
 Thu,  6 Feb 2020 12:51:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/17] qcow2: Assert that host cluster offsets fit in L2 table
 entries
Date: Thu,  6 Feb 2020 13:51:16 +0100
Message-Id: <20200206125132.594625-2-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ajy2vLtDNJ6WlNLcnvC8uw-1
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

The standard cluster descriptor in L2 table entries has a field to
store the host cluster offset. When we need to get that offset from an
entry we use L2E_OFFSET_MASK to ensure that we only use the bits that
belong to that field.

But while that mask is used every time we read from an L2 entry, it
is never used when we write to it. Due to the QCOW_MAX_CLUSTER_OFFSET
limit set in the cluster allocation code QEMU can never produce
offsets that don't fit in that field so any such offset would indicate
a bug in QEMU.

Compressed cluster descriptors contain two fields (host cluster offset
and size of the compressed data) and the situation with them is
similar. In this case the masks are not constant but are stored in the
csize_mask and cluster_offset_mask fields of BDRVQcow2State.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20200113161146.20099-1-berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8982b7b762..e9431f6785 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -777,6 +777,10 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriverS=
tate *bs,
         (cluster_offset + compressed_size - 1) / QCOW2_COMPRESSED_SECTOR_S=
IZE -
         (cluster_offset / QCOW2_COMPRESSED_SECTOR_SIZE);
=20
+    /* The offset and size must fit in their fields of the L2 table entry =
*/
+    assert((cluster_offset & s->cluster_offset_mask) =3D=3D cluster_offset=
);
+    assert((nb_csectors & s->csize_mask) =3D=3D nb_csectors);
+
     cluster_offset |=3D QCOW_OFLAG_COMPRESSED |
                       ((uint64_t)nb_csectors << s->csize_shift);
=20
@@ -972,6 +976,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, Q=
CowL2Meta *m)
=20
     assert(l2_index + m->nb_clusters <=3D s->l2_slice_size);
     for (i =3D 0; i < m->nb_clusters; i++) {
+        uint64_t offset =3D cluster_offset + (i << s->cluster_bits);
         /* if two concurrent writes happen to the same unallocated cluster
          * each write allocates separate cluster and writes data concurren=
tly.
          * The first one to complete updates l2 table with pointer to its
@@ -982,8 +987,10 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, =
QCowL2Meta *m)
             old_cluster[j++] =3D l2_slice[l2_index + i];
         }
=20
-        l2_slice[l2_index + i] =3D cpu_to_be64((cluster_offset +
-                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
+        /* The offset must fit in the offset field of the L2 table entry *=
/
+        assert((offset & L2E_OFFSET_MASK) =3D=3D offset);
+
+        l2_slice[l2_index + i] =3D cpu_to_be64(offset | QCOW_OFLAG_COPIED)=
;
      }
=20
=20
@@ -1913,6 +1920,9 @@ static int expand_zero_clusters_in_l1(BlockDriverStat=
e *bs, uint64_t *l1_table,
                         goto fail;
                     }
=20
+                    /* The offset must fit in the offset field */
+                    assert((offset & L2E_OFFSET_MASK) =3D=3D offset);
+
                     if (l2_refcount > 1) {
                         /* For shared L2 tables, set the refcount accordin=
gly
                          * (it is already 1 and needs to be l2_refcount) *=
/
--=20
2.24.1



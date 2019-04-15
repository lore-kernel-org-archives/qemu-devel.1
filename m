Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33AC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD2420818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD2420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52191 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3yr-0000dT-GK
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:57:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3x1-0007bi-4l
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3wz-0003Qf-5p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hG3wt-0003Ch-EJ; Mon, 15 Apr 2019 11:55:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 152163002713;
	Mon, 15 Apr 2019 15:55:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-113.ams2.redhat.com
	[10.36.117.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8401060123;
	Mon, 15 Apr 2019 15:55:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:54:49 +0200
Message-Id: <20190415155452.5115-2-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-1-kwolf@redhat.com>
References: <20190415155452.5115-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 15 Apr 2019 15:55:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] qcow2: Avoid COW during metadata
 preallocation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415155449.GlPt-rLayiQeQL8Wu0qzaMcYM2Ic1rbiJXRua7M2DIE@z>

Limiting the allocation to INT_MAX bytes isn't particularly clever
because it means that the final cluster will be a partial cluster which
will be completed through a COW operation. This results in unnecessary
data read and write requests which lead to an unwanted non-sparse
filesystem block for metadata preallocation.

Align the maximum allocation size down to the cluster size to avoid this
situation.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d507ee0686..c8400e9712 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2723,6 +2723,7 @@ static int qcow2_set_up_encryption(BlockDriverState=
 *bs,
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t of=
fset,
                                        uint64_t new_length)
 {
+    BDRVQcow2State *s =3D bs->opaque;
     uint64_t bytes;
     uint64_t host_offset =3D 0;
     unsigned int cur_bytes;
@@ -2733,7 +2734,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
     bytes =3D new_length - offset;
=20
     while (bytes) {
-        cur_bytes =3D MIN(bytes, INT_MAX);
+        cur_bytes =3D MIN(bytes, QEMU_ALIGN_DOWN(INT_MAX, s->cluster_siz=
e));
         ret =3D qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
--=20
2.20.1



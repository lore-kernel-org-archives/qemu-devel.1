Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E17C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D6121743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D6121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV8B-0002Pi-2V
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:57:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUur-000833-Kf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-00025l-2Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuk-0001wg-5b; Tue, 30 Apr 2019 11:43:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 901D43084249;
	Tue, 30 Apr 2019 15:43:22 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94DB117106;
	Tue, 30 Apr 2019 15:43:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:32 +0200
Message-Id: <20190430154244.30083-16-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 30 Apr 2019 15:43:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/27] qcow2: Fix error handling in the
 compression code
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154232.u5QYWGITADahOybUdPJhT2H4BrSBEK7mrLPp_iKrWBc@z>

From: Alberto Garcia <berto@igalia.com>

This patch fixes a few things in the way error codes are handled in
the qcow2 compression code:

a) qcow2_co_pwritev_compressed() expects qcow2_co_compress() to only
   return -1 or -2 on failure, but this is not correct. Since the
   change from qcow2_compress() to qcow2_co_compress() in commit
   ceb029cd6feccf9f7607 the new code can also return -EINVAL (although
   there does not seem to exist any code path that would cause that
   error in the current implementation).

b) -1 and -2 are ad-hoc error codes defined in qcow2_compress().
   This patch replaces them with standard constants from errno.h.

c) Both qcow2_compress() and qcow2_co_do_compress() return a negative
   value on failure, but qcow2_co_pwritev_compressed() stores the
   value in an unsigned data type.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 840f289a48..c5c17734d7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3929,8 +3929,8 @@ fail:
  * @src - source buffer, @src_size bytes
  *
  * Returns: compressed size on success
- *          -1 destination buffer is not enough to store compressed data
- *          -2 on any other error
+ *          -ENOMEM destination buffer is not enough to store compressed=
 data
+ *          -EIO    on any other error
  */
 static ssize_t qcow2_compress(void *dest, size_t dest_size,
                               const void *src, size_t src_size)
@@ -3943,7 +3943,7 @@ static ssize_t qcow2_compress(void *dest, size_t de=
st_size,
     ret =3D deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
                        -12, 9, Z_DEFAULT_STRATEGY);
     if (ret !=3D Z_OK) {
-        return -2;
+        return -EIO;
     }
=20
     /* strm.next_in is not const in old zlib versions, such as those use=
d on
@@ -3957,7 +3957,7 @@ static ssize_t qcow2_compress(void *dest, size_t de=
st_size,
     if (ret =3D=3D Z_STREAM_END) {
         ret =3D dest_size - strm.avail_out;
     } else {
-        ret =3D (ret =3D=3D Z_OK ? -1 : -2);
+        ret =3D (ret =3D=3D Z_OK ? -ENOMEM : -EIO);
     }
=20
     deflateEnd(&strm);
@@ -4096,7 +4096,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
     BDRVQcow2State *s =3D bs->opaque;
     QEMUIOVector hd_qiov;
     int ret;
-    size_t out_len;
+    ssize_t out_len;
     uint8_t *buf, *out_buf;
     uint64_t cluster_offset;
=20
@@ -4135,16 +4135,16 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs,=
 uint64_t offset,
=20
     out_len =3D qcow2_co_compress(bs, out_buf, s->cluster_size - 1,
                                 buf, s->cluster_size);
-    if (out_len =3D=3D -2) {
-        ret =3D -EINVAL;
-        goto fail;
-    } else if (out_len =3D=3D -1) {
+    if (out_len =3D=3D -ENOMEM) {
         /* could not compress: write normal cluster */
         ret =3D qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
             goto fail;
         }
         goto success;
+    } else if (out_len < 0) {
+        ret =3D -EINVAL;
+        goto fail;
     }
=20
     qemu_co_mutex_lock(&s->lock);
--=20
2.20.1



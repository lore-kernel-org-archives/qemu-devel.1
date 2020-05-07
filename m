Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B12C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBD520575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIImAfmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBD520575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhnA-0007uC-SN
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWhmJ-00072N-Mx
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:45:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWhmH-0003dR-Ty
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588862732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mD0J+BqA3hH5L2MGfLPWpRGM1gavaMsHDS4Z1HMFV8=;
 b=dIImAfmVm4Hq5ztONVKR2f+yph+yoA7ayEsTEOfugcDgByZqRZ2+7j++x71qEPlyBj59dr
 IcU6dBYsrboTX1f1FYioYXVVNWSOCziFilNbfoY+qWR3x5cy0bWX05wSjhiqaC2XsS/ORM
 nydYzIkxqeY3BELUGdj55rxJBUeZP1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-O-Z3v2kDNKCZoshuF8wnRA-1; Thu, 07 May 2020 10:45:29 -0400
X-MC-Unique: O-Z3v2kDNKCZoshuF8wnRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F867460;
 Thu,  7 May 2020 14:45:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A86C15C1B0;
 Thu,  7 May 2020 14:45:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/9] qed: Simplify backing reads
Date: Thu,  7 May 2020 09:45:13 -0500
Message-Id: <20200507144513.348470-1-eblake@redhat.com>
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com,
 "open list:qed" <qemu-block@nongnu.org>, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The other four drivers that support backing files (qcow, qcow2,
parallels, vmdk) all rely on the block layer to populate zeroes when
reading beyond EOF of a short backing file.  We can simplify the qed
code by doing likewise.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I noticed this during my audit that v1 of Vladimir's series was correct.

No change in iotests results (test 274 is currently failing for qed,
but for other reasons:
+Traceback (most recent call last):
+  File "274", line 24, in <module>
+    iotests.verify_image_format(supported_fmts=3D['qcow2'])
+AttributeError: module 'iotests' has no attribute 'verify_image_format'
)

 block/qed.h |  1 -
 block/qed.c | 64 +++++------------------------------------------------
 2 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/block/qed.h b/block/qed.h
index 42c115d8220c..3d12bf78d412 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -140,7 +140,6 @@ typedef struct QEDAIOCB {

     /* Current cluster scatter-gather list */
     QEMUIOVector cur_qiov;
-    QEMUIOVector *backing_qiov;
     uint64_t cur_pos;               /* position on block device, in bytes =
*/
     uint64_t cur_cluster;           /* cluster offset in image file */
     unsigned int cur_nclusters;     /* number of clusters being accessed *=
/
diff --git a/block/qed.c b/block/qed.c
index 927382995a0c..bea4b9f6cc97 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -849,56 +849,18 @@ static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
  * @s:              QED state
  * @pos:            Byte position in device
  * @qiov:           Destination I/O vector
- * @backing_qiov:   Possibly shortened copy of qiov, to be allocated here
- * @cb:             Completion function
- * @opaque:         User data for completion function
  *
  * This function reads qiov->size bytes starting at pos from the backing f=
ile.
  * If there is no backing file then zeroes are read.
  */
 static int coroutine_fn qed_read_backing_file(BDRVQEDState *s, uint64_t po=
s,
-                                              QEMUIOVector *qiov,
-                                              QEMUIOVector **backing_qiov)
+                                              QEMUIOVector *qiov)
 {
-    uint64_t backing_length =3D 0;
-    size_t size;
-    int ret;
-
-    /* If there is a backing file, get its length.  Treat the absence of a
-     * backing file like a zero length backing file.
-     */
     if (s->bs->backing) {
-        int64_t l =3D bdrv_getlength(s->bs->backing->bs);
-        if (l < 0) {
-            return l;
-        }
-        backing_length =3D l;
-    }
-
-    /* Zero all sectors if reading beyond the end of the backing file */
-    if (pos >=3D backing_length ||
-        pos + qiov->size > backing_length) {
-        qemu_iovec_memset(qiov, 0, 0, qiov->size);
-    }
-
-    /* Complete now if there are no backing file sectors to read */
-    if (pos >=3D backing_length) {
-        return 0;
-    }
-
-    /* If the read straddles the end of the backing file, shorten it */
-    size =3D MIN((uint64_t)backing_length - pos, qiov->size);
-
-    assert(*backing_qiov =3D=3D NULL);
-    *backing_qiov =3D g_new(QEMUIOVector, 1);
-    qemu_iovec_init(*backing_qiov, qiov->niov);
-    qemu_iovec_concat(*backing_qiov, qiov, 0, size);
-
-    BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
-    ret =3D bdrv_co_preadv(s->bs->backing, pos, size, *backing_qiov, 0);
-    if (ret < 0) {
-        return ret;
+        BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
+        return bdrv_co_preadv(s->bs->backing, pos, qiov->size, qiov, 0);
     }
+    qemu_iovec_memset(qiov, 0, 0, qiov->size);
     return 0;
 }

@@ -915,7 +877,6 @@ static int coroutine_fn qed_copy_from_backing_file(BDRV=
QEDState *s,
                                                    uint64_t offset)
 {
     QEMUIOVector qiov;
-    QEMUIOVector *backing_qiov =3D NULL;
     int ret;

     /* Skip copy entirely if there is no work to do */
@@ -925,13 +886,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDR=
VQEDState *s,

     qemu_iovec_init_buf(&qiov, qemu_blockalign(s->bs, len), len);

-    ret =3D qed_read_backing_file(s, pos, &qiov, &backing_qiov);
-
-    if (backing_qiov) {
-        qemu_iovec_destroy(backing_qiov);
-        g_free(backing_qiov);
-        backing_qiov =3D NULL;
-    }
+    ret =3D qed_read_backing_file(s, pos, &qiov);

     if (ret) {
         goto out;
@@ -1339,8 +1294,7 @@ static int coroutine_fn qed_aio_read_data(void *opaqu=
e, int ret,
         qemu_iovec_memset(&acb->cur_qiov, 0, 0, acb->cur_qiov.size);
         r =3D 0;
     } else if (ret !=3D QED_CLUSTER_FOUND) {
-        r =3D qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                                  &acb->backing_qiov);
+        r =3D qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov);
     } else {
         BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
         r =3D bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
@@ -1365,12 +1319,6 @@ static int coroutine_fn qed_aio_next_io(QEDAIOCB *ac=
b)
     while (1) {
         trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size=
);

-        if (acb->backing_qiov) {
-            qemu_iovec_destroy(acb->backing_qiov);
-            g_free(acb->backing_qiov);
-            acb->backing_qiov =3D NULL;
-        }
-
         acb->qiov_offset +=3D acb->cur_qiov.size;
         acb->cur_pos +=3D acb->cur_qiov.size;
         qemu_iovec_reset(&acb->cur_qiov);
--=20
2.26.2



Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86672C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BE821929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BE821929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6EV-0007GW-4f
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pj-0001Uc-GP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5ph-0002Wk-Sa
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pg-0002DE-II; Tue, 05 Nov 2019 15:53:45 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpUxx056536; Tue, 5 Nov 2019 15:53:23 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3b2ettuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:23 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KqLMR058342;
 Tue, 5 Nov 2019 15:53:23 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3b2ettu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:23 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5Knur2017653;
 Tue, 5 Nov 2019 20:53:21 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03wdc.us.ibm.com with ESMTP id 2w11e7h8ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:21 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrLQn45220200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 163A1124058;
 Tue,  5 Nov 2019 20:53:21 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03ADF124052;
 Tue,  5 Nov 2019 20:53:21 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:20 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/55] block/file-posix: Reduce xfsctl() use
Date: Tue,  5 Nov 2019 14:51:56 -0600
Message-Id: <20191105205243.3766-9-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xA5KpUxx056536
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This patch removes xfs_write_zeroes() and xfs_discard().  Both functions
have been added just before the same feature was present through
fallocate():

- fallocate() has supported PUNCH_HOLE for XFS since Linux 2.6.38 (March
  2011); xfs_discard() was added in December 2010.

- fallocate() has supported ZERO_RANGE for XFS since Linux 3.15 (June
  2014); xfs_write_zeroes() was added in November 2013.

Nowadays, all systems that qemu runs on should support both fallocate()
features (RHEL 7's kernel does).

xfsctl() is still useful for getting the request alignment for O_DIRECT,
so this patch does not remove our dependency on it completely.

Note that xfs_write_zeroes() had a bug: It calls ftruncate() when the
file is shorter than the specified range (because ZERO_RANGE does not
increase the file length).  ftruncate() may yield and then discard data
that parallel write requests have written past the EOF in the meantime.
Dropping the function altogether fixes the bug.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 50ba5b2d994853b38fed10e0841b119da0f8b8e5
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b2c6f23f4a9f6d8f1b648705cd46d3713b78d6a2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/file-posix.c | 77 +---------------------------------------------
 1 file changed, 1 insertion(+), 76 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7ab4..992eb4a798 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1445,59 +1445,6 @@ out:
     }
 }
=20
-#ifdef CONFIG_XFS
-static int xfs_write_zeroes(BDRVRawState *s, int64_t offset, uint64_t by=
tes)
-{
-    int64_t len;
-    struct xfs_flock64 fl;
-    int err;
-
-    len =3D lseek(s->fd, 0, SEEK_END);
-    if (len < 0) {
-        return -errno;
-    }
-
-    if (offset + bytes > len) {
-        /* XFS_IOC_ZERO_RANGE does not increase the file length */
-        if (ftruncate(s->fd, offset + bytes) < 0) {
-            return -errno;
-        }
-    }
-
-    memset(&fl, 0, sizeof(fl));
-    fl.l_whence =3D SEEK_SET;
-    fl.l_start =3D offset;
-    fl.l_len =3D bytes;
-
-    if (xfsctl(NULL, s->fd, XFS_IOC_ZERO_RANGE, &fl) < 0) {
-        err =3D errno;
-        trace_file_xfs_write_zeroes(strerror(errno));
-        return -err;
-    }
-
-    return 0;
-}
-
-static int xfs_discard(BDRVRawState *s, int64_t offset, uint64_t bytes)
-{
-    struct xfs_flock64 fl;
-    int err;
-
-    memset(&fl, 0, sizeof(fl));
-    fl.l_whence =3D SEEK_SET;
-    fl.l_start =3D offset;
-    fl.l_len =3D bytes;
-
-    if (xfsctl(NULL, s->fd, XFS_IOC_UNRESVSP64, &fl) < 0) {
-        err =3D errno;
-        trace_file_xfs_discard(strerror(errno));
-        return -err;
-    }
-
-    return 0;
-}
-#endif
-
 static int translate_err(int err)
 {
     if (err =3D=3D -ENODEV || err =3D=3D -ENOSYS || err =3D=3D -EOPNOTSU=
PP ||
@@ -1553,10 +1500,8 @@ static ssize_t handle_aiocb_write_zeroes_block(Raw=
PosixAIOData *aiocb)
 static int handle_aiocb_write_zeroes(void *opaque)
 {
     RawPosixAIOData *aiocb =3D opaque;
-#if defined(CONFIG_FALLOCATE) || defined(CONFIG_XFS)
-    BDRVRawState *s =3D aiocb->bs->opaque;
-#endif
 #ifdef CONFIG_FALLOCATE
+    BDRVRawState *s =3D aiocb->bs->opaque;
     int64_t len;
 #endif
=20
@@ -1564,12 +1509,6 @@ static int handle_aiocb_write_zeroes(void *opaque)
         return handle_aiocb_write_zeroes_block(aiocb);
     }
=20
-#ifdef CONFIG_XFS
-    if (s->is_xfs) {
-        return xfs_write_zeroes(s, aiocb->aio_offset, aiocb->aio_nbytes)=
;
-    }
-#endif
-
 #ifdef CONFIG_FALLOCATE_ZERO_RANGE
     if (s->has_write_zeroes) {
         int ret =3D do_fallocate(s->fd, FALLOC_FL_ZERO_RANGE,
@@ -1632,14 +1571,6 @@ static int handle_aiocb_write_zeroes_unmap(void *o=
paque)
     }
 #endif
=20
-#ifdef CONFIG_XFS
-    if (s->is_xfs) {
-        /* xfs_discard() guarantees that the discarded area reads as all=
-zero
-         * afterwards, so we can use it here. */
-        return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
-    }
-#endif
-
     /* If we couldn't manage to unmap while guaranteed that the area rea=
ds as
      * all-zero afterwards, just write zeroes without unmapping */
     ret =3D handle_aiocb_write_zeroes(aiocb);
@@ -1716,12 +1647,6 @@ static int handle_aiocb_discard(void *opaque)
         ret =3D -errno;
 #endif
     } else {
-#ifdef CONFIG_XFS
-        if (s->is_xfs) {
-            return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
-        }
-#endif
-
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
         ret =3D do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEE=
P_SIZE,
                            aiocb->aio_offset, aiocb->aio_nbytes);
--=20
2.17.1



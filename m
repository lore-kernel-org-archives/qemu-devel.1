Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0490CC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02072053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02072053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhGY-0005kK-Mg
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:19:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNhFB-0005BW-E3
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNhFA-0004Mg-HE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hNhFA-0004M0-Bi; Mon, 06 May 2019 13:17:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CA173086227;
	Mon,  6 May 2019 17:17:35 +0000 (UTC)
Received: from localhost (unknown [10.40.205.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BB0DD60BEC;
	Mon,  6 May 2019 17:17:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon,  6 May 2019 19:17:30 +0200
Message-Id: <20190506171730.17556-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 06 May 2019 17:17:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC] s390/css: handle CCW_FLAG_SKIP
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a ccw has CCW_FLAG_SKIP set, and the command is of type
read, read backwards, or sense, no data should be written
to the guest for that command.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Only extremely lightly tested (i.e., can boot a guest.)

---
 hw/s390x/css.c         | 22 ++++++++++++++++++----
 include/hw/s390x/css.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 8fc9e35ba5d3..6ee31cc2e08f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -830,8 +830,12 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cds=
, void *buff, int len,
     if (op =3D=3D CDS_OP_A) {
         goto incr;
     }
-    ret =3D address_space_rw(&address_space_memory, cds->cda,
-                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
+    if (!cds->do_skip) {
+        ret =3D address_space_rw(&address_space_memory, cds->cda,
+                               MEMTXATTRS_UNSPECIFIED, buff, len, op);
+    } else {
+        ret =3D 0;
+    }
     if (ret !=3D MEMTX_OK) {
         cds->flags |=3D CDS_F_STREAM_BROKEN;
         return -EINVAL;
@@ -928,8 +932,13 @@ static int ccw_dstream_rw_ida(CcwDataStream *cds, vo=
id *buff, int len,
     do {
         iter_len =3D MIN(len, cont_left);
         if (op !=3D CDS_OP_A) {
-            ret =3D address_space_rw(&address_space_memory, cds->cda,
-                                   MEMTXATTRS_UNSPECIFIED, buff, iter_le=
n, op);
+            if (!cds->do_skip) {
+                ret =3D address_space_rw(&address_space_memory, cds->cda=
,
+                                       MEMTXATTRS_UNSPECIFIED, buff, ite=
r_len,
+                                       op);
+            } else {
+                ret =3D 0;
+            }
             if (ret !=3D MEMTX_OK) {
                 /* assume inaccessible address */
                 ret =3D -EINVAL; /* channel program check */
@@ -968,6 +977,11 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const=
 *ccw, ORB const *orb)
=20
     cds->count =3D ccw->count;
     cds->cda_orig =3D ccw->cda;
+    /* skip is only effective for read, read backwards, or sense command=
s */
+    cds->do_skip =3D (ccw->flags & CCW_FLAG_SKIP) &&
+        (ccw->cmd_code & CCW_CMD_BASIC_SENSE ||
+         ccw->cmd_code & 0x02 /* read */ ||
+         ccw->cmd_code & 0x0c /* read backwards */);
     ccw_dstream_rewind(cds);
     if (!(cds->flags & CDS_F_IDA)) {
         cds->op_handler =3D ccw_dstream_rw_noflags;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index aae19c427229..7cc183ef4366 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -97,6 +97,7 @@ typedef struct CcwDataStream {
     int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
                       CcwDataStreamOp op);
     hwaddr cda;
+    bool do_skip;
 } CcwDataStream;
=20
 /*
--=20
2.20.1



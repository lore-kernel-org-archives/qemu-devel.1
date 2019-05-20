Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE71C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5E8216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5E8216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlja-0001VX-3y
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:05:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlhZ-0000GP-Ht
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlhY-0002Sn-Fc
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlhY-0002SD-6w; Mon, 20 May 2019 13:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E8048830E;
	Mon, 20 May 2019 17:03:51 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 146DF5DE8F;
	Mon, 20 May 2019 17:03:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:13 +0200
Message-Id: <20190520170302.13643-6-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 20 May 2019 17:03:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/54] s390/css: handle CCW_FLAG_SKIP
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

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190516133327.11430-1-cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 22 ++++++++++++++++++----
 include/hw/s390x/css.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 8fc9e35ba5d3..ad310b9f94bc 100644
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
+        ret =3D MEMTX_OK;
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
+                ret =3D MEMTX_OK;
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
+        ((ccw->cmd_code & 0x0f) =3D=3D CCW_CMD_BASIC_SENSE ||
+         (ccw->cmd_code & 0x03) =3D=3D 0x02 /* read */ ||
+         (ccw->cmd_code & 0x0f) =3D=3D 0x0c /* read backwards */);
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



Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA3EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC3E21927
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC3E21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2jE-0004bF-BX
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iB2dB-00068Y-2n
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iB2QA-000273-D7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iB2Q8-000263-DT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73C0A3D965
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 19:48:51 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6C855D6D0;
 Thu, 19 Sep 2019 19:48:50 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com
Subject: [RFC 2/4] SCSI media error reporting
Date: Thu, 19 Sep 2019 14:48:45 -0500
Message-Id: <20190919194847.18518-3-tasleson@redhat.com>
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 19 Sep 2019 19:48:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add abilility to return media errors for SCSI block devices.  Needs
improvement.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 hw/scsi/scsi-disk.c  | 33 +++++++++++++++++++++++++++++++++
 include/scsi/utils.h |  4 ++++
 scsi/utils.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 915641a0f1..a7f3274cdf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -37,6 +37,7 @@
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
 #include "trace.h"
+#include "block/error_inject.h"
=20
 #ifdef __linux
 #include <scsi/sg.h>
@@ -132,6 +133,18 @@ static void scsi_check_condition(SCSIDiskReq *r, SCS=
ISense sense)
     scsi_req_complete(&r->req, CHECK_CONDITION);
 }
=20
+/* Helper function for SCSI media error  */
+static void scsi_media_error(SCSIDiskReq *r, SCSISense sense, uint32_t l=
ba)
+{
+    trace_scsi_disk_check_condition(r->req.tag, sense.key, sense.asc,
+                                    sense.ascq);
+
+    r->req.sense_len =3D scsi_build_sense_buf_info(r->req.sense,
+                                                  SCSI_SENSE_LEN, sense,=
 lba,
+                                                  0x80, 32);
+    scsi_req_complete(&r->req, CHECK_CONDITION);
+}
+
 static void scsi_init_iovec(SCSIDiskReq *r, size_t size)
 {
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
@@ -2170,6 +2183,26 @@ static int32_t scsi_disk_dma_command(SCSIRequest *=
req, uint8_t *buf)
         }
         r->sector =3D r->req.cmd.lba * (s->qdev.blocksize / 512);
         r->sector_count =3D len * (s->qdev.blocksize / 512);
+
+        /*
+         * TODO Move this check to a more appropriate spot.  Additionall=
y we
+         * also need to transfer the data that was read up before encoun=
tering
+         * the media error.
+         */
+        uint64_t error_sector =3D 0;
+        char device_id[32];
+        sprintf(device_id, "%lu", s->qdev.wwn);
+        if (error_in_read(device_id, r->sector, r->sector_count,
+                          &error_sector)) {
+            /*
+             * TODO Fix error reporting for disks > 2TiB
+             */
+            if (error_sector > 0xFFFFFFFF) {
+                error_sector =3D 0xFFFFFFFF;
+            }
+            scsi_media_error(r, SENSE_CODE(READ_ERROR), (uint32_t)error_=
sector);
+            return 0;
+        }
         break;
     case WRITE_6:
     case WRITE_10:
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index fbc5588279..02ae74287f 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -35,6 +35,10 @@ SCSISense scsi_parse_sense_buf(const uint8_t *in_buf, =
int in_len);
 int scsi_build_sense_buf(uint8_t *buf, size_t max_size, SCSISense sense,
                          bool fixed_sense);
=20
+int scsi_build_sense_buf_info(uint8_t *out_buf, size_t size, SCSISense s=
ense,
+                              uint32_t information, uint8_t sksv,
+                              uint16_t sense_key_specific_info);
+
 /*
  * Predefined sense codes
  */
diff --git a/scsi/utils.c b/scsi/utils.c
index c50e81fdb8..9c9f1735d0 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -147,6 +147,37 @@ int scsi_build_sense_buf(uint8_t *out_buf, size_t si=
ze, SCSISense sense,
     return len;
 }
=20
+int scsi_build_sense_buf_info(uint8_t *out_buf, size_t size, SCSISense s=
ense,
+                                uint32_t information, uint8_t sksv,
+                                uint16_t sense_key_specific_info)
+{
+    uint8_t buf[SCSI_SENSE_LEN] =3D { 0 };
+
+    buf[0] =3D 0xF0;  /* Valid bit set. */
+    buf[2] =3D sense.key;
+
+    /*
+     * Set bytes 3, 4, 5, 6 value of information field
+     */
+    *((uint32_t *)(&buf[3])) =3D cpu_to_be32(information);
+
+    buf[7] =3D 10;
+    buf[12] =3D sense.asc;
+    buf[13] =3D sense.ascq;
+
+    if (sksv) {
+        buf[15] =3D sksv;
+        /*
+         * Set bytes 16, 17 to Sense-key specific bytes
+         */
+        *((uint16_t *)&buf[16]) =3D cpu_to_be16(sense_key_specific_info)=
;
+    }
+
+    int len =3D MIN(SCSI_SENSE_LEN, size);
+    memcpy(out_buf, buf, len);
+    return len;
+}
+
 int scsi_build_sense(uint8_t *buf, SCSISense sense)
 {
     return scsi_build_sense_buf(buf, SCSI_SENSE_LEN, sense, true);
--=20
2.21.0



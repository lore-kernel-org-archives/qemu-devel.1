Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC2C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369F2206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JV8mEeJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369F2206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Es-0001lD-DQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95r-0001Hw-Gb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95o-0003c0-AX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:03 -0400
Received: from ozlabs.org ([203.11.71.1]:32855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95n-0002yq-Ro; Tue, 17 Mar 2020 06:05:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKy6Zkvz9sTG; Tue, 17 Mar 2020 21:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439478;
 bh=48ImQCW8f6mEY6ZIE+2mS92Voyx9RR4s4+J+AWbKKsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JV8mEeJUaWZnmJTWDLFDYuiUyafhz2iW/RyH30kAC99/bHSmBQg+f3bWFgj2b9cPy
 7P6MLbJ8ZVI1SY11uELvScltlh9YEPSJsRBZMy1u5fNcXyQTHemL6XgStw9V/ij8JS
 sO2UIq6PaJPsnHO2ULNRSHqfOhXYIOWWw7cuvaGE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 27/45] hw/scsi/spapr_vscsi: Prevent buffer overflow
Date: Tue, 17 Mar 2020 21:04:05 +1100
Message-Id: <20200317100423.622643-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Depending on the length of sense data, vscsi_send_rsp() can
overrun the buffer size.
Do not copy more than SRP_MAX_IU_DATA_LEN bytes, and assert
that vscsi_send_iu() is always called with a size in range.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305121253.19078-7-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index acf9bb50bc..c4c4f31170 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -55,6 +55,8 @@
 #define VSCSI_MAX_SECTORS       4096
 #define VSCSI_REQ_LIMIT         24
=20
+/* Maximum size of a IU payload */
+#define SRP_MAX_IU_DATA_LEN     (SRP_MAX_IU_LEN - sizeof(union srp_iu))
 #define SRP_RSP_SENSE_DATA_LEN  18
=20
 #define SRP_REPORT_LUNS_WLUN    0xc10100000000000ULL
@@ -181,6 +183,8 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *re=
q,
 {
     long rc, rc1;
=20
+    assert(length <=3D SRP_MAX_IU_LEN);
+
     /* First copy the SRP */
     rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
                              &req->viosrp_iu_buf, length);
@@ -266,10 +270,12 @@ static int vscsi_send_rsp(VSCSIState *s, vscsi_req =
*req,
     if (status) {
         iu->srp.rsp.sol_not =3D (sol_not & 0x04) >> 2;
         if (req->senselen) {
+            int sense_data_len =3D MIN(req->senselen, SRP_MAX_IU_DATA_LE=
N);
+
             iu->srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
-            iu->srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen);
-            memcpy(iu->srp.rsp.data, req->sense, req->senselen);
-            total_len +=3D req->senselen;
+            iu->srp.rsp.sense_data_len =3D cpu_to_be32(sense_data_len);
+            memcpy(iu->srp.rsp.data, req->sense, sense_data_len);
+            total_len +=3D sense_data_len;
         }
     } else {
         iu->srp.rsp.sol_not =3D (sol_not & 0x02) >> 1;
@@ -896,6 +902,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
     }
=20
     /* Compose the response here as  */
+    QEMU_BUILD_BUG_ON(SRP_MAX_IU_DATA_LEN < 4);
     memset(iu, 0, sizeof(struct srp_rsp) + 4);
     iu->srp.rsp.opcode =3D SRP_RSP;
     iu->srp.rsp.req_lim_delta =3D cpu_to_be32(1);
--=20
2.24.1



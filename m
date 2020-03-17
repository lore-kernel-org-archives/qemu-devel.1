Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E305C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B97205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TtqEkIRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B97205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9QW-0006ms-6G
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE968-0001j9-Tr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE967-0005lZ-Gw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:20 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43911 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE967-0002pG-5f; Tue, 17 Mar 2020 06:05:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKy1tGPz9sT9; Tue, 17 Mar 2020 21:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439478;
 bh=7Oc6dJy7mdLvgRsq59r4wXTl8bUk0MLKqWTXTRm3oTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TtqEkIRIQtvxiAUC0ZN/ZKE28huXHZY6JAoB5ePi6a/zZBCKEBOdmCfE0NeOYjhxa
 Wl6x30ewA05+rFw/V5Y0gME2KlVUuUkZHjFs77V0Pfm8227gHXIeud8YMDv0ZzeiHZ
 Qq9TwrZ+RSEam3oZETXnBx0sLPS0tB75hbrClDlU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 26/45] hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA
 buffer size
Date: Tue, 17 Mar 2020 21:04:04 +1100
Message-Id: <20200317100423.622643-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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

The 'union srp_iu' is meant as a pointer to any SRP Information
Unit type, it is not related to the size of a VIO DMA buffer.

Use a plain buffer for the VIO DMA read/write calls.
We can remove the reserved buffer from the 'union srp_iu'.

This issue was noticed when replacing the zero-length arrays
from hw/scsi/srp.h with flexible array member,
'clang -fsanitize=3Dundefined' reported:

  hw/scsi/spapr_vscsi.c:69:29: error: field 'iu' with variable sized type=
 'union viosrp_iu' not at the end of a struct or class is a GNU extension=
 [-Werror,-Wgnu-variable-sized-type-not-at-end]
       union viosrp_iu         iu;
                               ^

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305121253.19078-6-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 10 +++++-----
 hw/scsi/viosrp.h      |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 70547f98ac..acf9bb50bc 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -66,7 +66,7 @@ typedef union vscsi_crq {
=20
 typedef struct vscsi_req {
     vscsi_crq               crq;
-    union viosrp_iu         iu;
+    uint8_t                 viosrp_iu_buf[SRP_MAX_IU_LEN];
=20
     /* SCSI request tracking */
     SCSIRequest             *sreq;
@@ -99,7 +99,7 @@ typedef struct {
=20
 static union viosrp_iu *req_iu(vscsi_req *req)
 {
-    return &req->iu;
+    return (union viosrp_iu *)req->viosrp_iu_buf;
 }
=20
 static struct vscsi_req *vscsi_get_req(VSCSIState *s)
@@ -183,7 +183,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *re=
q,
=20
     /* First copy the SRP */
     rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
-                             &req->iu, length);
+                             &req->viosrp_iu_buf, length);
     if (rc) {
         fprintf(stderr, "vscsi_send_iu: DMA write failure !\n");
     }
@@ -602,7 +602,7 @@ static const VMStateDescription vmstate_spapr_vscsi_r=
eq =3D {
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(crq.raw, vscsi_req),
-        VMSTATE_BUFFER(iu.srp.reserved, vscsi_req),
+        VMSTATE_BUFFER(viosrp_iu_buf, vscsi_req),
         VMSTATE_UINT32(qtag, vscsi_req),
         VMSTATE_BOOL(active, vscsi_req),
         VMSTATE_UINT32(data_len, vscsi_req),
@@ -1103,7 +1103,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
     }
=20
     /* XXX Handle failure differently ? */
-    if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->iu,
+    if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->viosrp_iu=
_buf,
                            crq->s.IU_length)) {
         fprintf(stderr, "vscsi_got_payload: DMA read failure !\n");
         vscsi_put_req(req);
diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
index 25676c2383..e5f9768e8f 100644
--- a/hw/scsi/viosrp.h
+++ b/hw/scsi/viosrp.h
@@ -49,7 +49,6 @@ union srp_iu {
     struct srp_tsk_mgmt tsk_mgmt;
     struct srp_cmd cmd;
     struct srp_rsp rsp;
-    uint8_t reserved[SRP_MAX_IU_LEN];
 };
=20
 enum viosrp_crq_formats {
--=20
2.24.1



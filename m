Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4DE20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJEuigYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4DE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W6J-0008Do-RD
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W1q-0007NX-Lz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W1p-00046v-5e
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W1p-00046N-28
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6bOA2bmzs7vUmurz3p844VtrEnDUzC6kMVk052Rcfs=;
 b=ZJEuigYYTHAfK+kJHJ0POC4ELIj12yMAiYVyTGeGBPmVGLRAVFNN+pMnKU4WNFQ/m/3+L7
 MF4EqaXvhDWK53RVxEwNzIbvM78AeR11CGLCxotDgSi/vmTCCexxY/BLvZh9H1PAgSsbQu
 7aWPVpaKBJoaTg7LEKArxNJocQ2y74o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-bm9XURKgM6iR7sGxVrtWBg-1; Wed, 04 Mar 2020 10:33:43 -0500
X-MC-Unique: bm9XURKgM6iR7sGxVrtWBg-1
Received: by mail-wm1-f70.google.com with SMTP id v21so694466wml.5
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UqS7KKOYNA08wTI1vIP1P7qHtBq16EhluaX19XU82to=;
 b=P1oYxNpU3rVlPQDw0hFfeIIDZqEPM11lHO9z51lZ3okHY9vc5isSlYmoqSAq76ieYh
 YG9O/iP5Ior2uK04EH5J7ehaM7L1Be+fyPPvfHCloB822oF2xQlsxP/b8sQgJOtiE8o1
 rNGeVgdBOauHqT1HLwPZAJjK84LOYxcHKCaSrhTearqvYt8wkr6Wq0iMrprE0HO6MRk0
 LBBkhhsoZah6Gyh98IlpIDp/2LzC2nwZe7DY9/W6aXxqy2WYN2X+FLq7LNIoRAmx+7tp
 MRvux/KXv6AQLghSwyg/cCB90xVJxfKC+vsWnCf5Vlp7vOHtrsvM0XEUsSe36R3Rnqr2
 hE9w==
X-Gm-Message-State: ANhLgQ00RH3UDoV4KaY9Zgl6aZCG8AtK/dZTaqbUqiZMyBdRuTszFPfU
 DxEbTYyVFuZoh2++vMkLr/JWb0X3VpYRg3kZd1MbAhzBCADCirCPf6vSZZDvWuGA+pGEUv3YE01
 73N9oSXaOA6OZTCs=
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr4498463wrn.86.1583336021882;
 Wed, 04 Mar 2020 07:33:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs3DEEsqfl+Fix8m+E1ul4OTPsKX/aNWB+jmFCsGcVuJb1J59/YT49qLAcYOzAnSWSCy32sSg==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr4498450wrn.86.1583336021688;
 Wed, 04 Mar 2020 07:33:41 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c26sm4622481wmb.8.2020.03.04.07.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:33:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA
 buffer size
Date: Wed,  4 Mar 2020 16:33:11 +0100
Message-Id: <20200304153311.22959-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304153311.22959-1-philmd@redhat.com>
References: <20200304153311.22959-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'union srp_iu' is meant as a pointer to any SRP Information
Unit type, it is not related to the size of a VIO DMA buffer.

Use a plain buffer for the VIO DMA read/write calls.
We can remove the reserved buffer from the 'union srp_iu'.

This issue was noticed when replacing the zero-length arrays
from hw/scsi/srp.h with flexible array member,
'clang -fsanitize=3Dundefined' reported:

  hw/scsi/spapr_vscsi.c:69:29: error: field 'iu' with variable sized type '=
union viosrp_iu' not at the end of a struct or class is a GNU extension [-W=
error,-Wgnu-variable-sized-type-not-at-end]
       union viosrp_iu         iu;
                               ^

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/viosrp.h      |  2 +-
 hw/scsi/spapr_vscsi.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
index 25676c2383..aba3203028 100644
--- a/hw/scsi/viosrp.h
+++ b/hw/scsi/viosrp.h
@@ -49,8 +49,8 @@ union srp_iu {
     struct srp_tsk_mgmt tsk_mgmt;
     struct srp_cmd cmd;
     struct srp_rsp rsp;
-    uint8_t reserved[SRP_MAX_IU_LEN];
 };
+_Static_assert(sizeof(union srp_iu) <=3D SRP_MAX_IU_LEN, "srp_iu size inco=
rrect");
=20
 enum viosrp_crq_formats {
     VIOSRP_SRP_FORMAT =3D 0x01,
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index f1a0bbdc31..f9be68e44e 100644
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
-    return (union viosrp_iu *)req->iu.srp.reserved;
+    return (union viosrp_iu *)req->viosrp_iu_buf;
 }
=20
=20
@@ -184,7 +184,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *req,
=20
     /* First copy the SRP */
     rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
-                             &req->iu, length);
+                             &req->viosrp_iu_buf, length);
     if (rc) {
         fprintf(stderr, "vscsi_send_iu: DMA write failure !\n");
     }
@@ -603,7 +603,7 @@ static const VMStateDescription vmstate_spapr_vscsi_req=
 =3D {
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(crq.raw, vscsi_req),
-        VMSTATE_BUFFER(iu.srp.reserved, vscsi_req),
+        VMSTATE_BUFFER(viosrp_iu_buf, vscsi_req),
         VMSTATE_UINT32(qtag, vscsi_req),
         VMSTATE_BOOL(active, vscsi_req),
         VMSTATE_UINT32(data_len, vscsi_req),
@@ -1104,7 +1104,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
q *crq)
     }
=20
     /* XXX Handle failure differently ? */
-    if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->iu,
+    if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->viosrp_iu_b=
uf,
                            crq->s.IU_length)) {
         fprintf(stderr, "vscsi_got_payload: DMA read failure !\n");
         vscsi_put_req(req);
--=20
2.21.1



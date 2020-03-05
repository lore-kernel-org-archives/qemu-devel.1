Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1167BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D150220870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFk1jNaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D150220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lxs-0004bu-21
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9lvN-0008PP-4g
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9lvL-0007ya-Tr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9lvL-0007yC-Q2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0bmDBDPFoTvSkhNSJzybouAoWVHY8olJiJkirrUp6g=;
 b=JFk1jNaExbzYLqCGYczYxIZkFF8eEPaZ+IPGnT/kV6sHYtU/ewKpd/BQ+Xu2egV6+B5xZi
 sT9dKUiQNxWN2PGSvETwn5BH29drjvVEPI3+z9wFTIzpba39WlRMqGb3v7ayGJ5rHWs1LK
 hzTkjVDztEe8takCHsSaDubryo/hvVM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-rRB7jTMoMU-XkEvhcIQBpg-1; Thu, 05 Mar 2020 03:32:05 -0500
X-MC-Unique: rRB7jTMoMU-XkEvhcIQBpg-1
Received: by mail-wr1-f70.google.com with SMTP id b12so2031983wro.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CeCFgKi/6lzEJDfMDMZ1O5Vx3FuqOcjKrlxywn/DvYg=;
 b=XN3Ax7362+aME33Zm7vJBI+zkdoY5XNngTvOV6RHjQXFeKuUUiM+pKfafzcCyF8/gk
 IqO19HDJppDa7x/bAY5TcocxsZfEcTjjqiEzKhe2VMRJAZ8s/I111af4DTwHr4zu6zV9
 XzqEv4NYdFAL853tS6lqwjhFrXmtPzsitYf1EGdQFDw8XGCGHOhBcR5edtqsKprAkfUf
 4u3wgzXaWTn5tWzPoFCny69IRfYKeOjkx0/WdCO64i3N/kYrjE+ZyuXUOXDegBcIo2Mi
 Zy1G1IIFf1ahRcA6s/BvNhWOKchY/iWvRZ7zINSsaoFrYi3uZiSju6VdoBd/Vt27wsYk
 x6cw==
X-Gm-Message-State: ANhLgQ2YRmGbjaWi92pGcbN7Obyl4gkDTIUb9/lksE78ijTKgb+KO1g6
 4Dl6V+A1MmuWcYZUuece3FdA3GDJOGWX7W2rXSYiBUf6xYHpMxbjjyjql8KrGneTfSZcXEWrQB4
 bUV7OjcAMeeSU+pE=
X-Received: by 2002:a1c:5684:: with SMTP id k126mr8342207wmb.181.1583397124304; 
 Thu, 05 Mar 2020 00:32:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtqggX8IZnDOMAeOqTsguTuAZMrz8Ixt7FkA14MByYOLu1ECW7sT6wddjSyoH2+RWnMJ/VM9w==
X-Received: by 2002:a1c:5684:: with SMTP id k126mr8342186wmb.181.1583397124107; 
 Thu, 05 Mar 2020 00:32:04 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u20sm7698158wmj.14.2020.03.05.00.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 00:32:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA
 buffer size
Date: Thu,  5 Mar 2020 09:31:35 +0100
Message-Id: <20200305083135.8270-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305083135.8270-1-philmd@redhat.com>
References: <20200305083135.8270-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
v2: Removed unuseful _Static_assert (dgibson)

 hw/scsi/viosrp.h      |  1 -
 hw/scsi/spapr_vscsi.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

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
@@ -183,7 +183,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *req,
=20
     /* First copy the SRP */
     rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
-                             &req->iu, length);
+                             &req->viosrp_iu_buf, length);
     if (rc) {
         fprintf(stderr, "vscsi_send_iu: DMA write failure !\n");
     }
@@ -602,7 +602,7 @@ static const VMStateDescription vmstate_spapr_vscsi_req=
 =3D {
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(crq.raw, vscsi_req),
-        VMSTATE_BUFFER(iu.srp.reserved, vscsi_req),
+        VMSTATE_BUFFER(viosrp_iu_buf, vscsi_req),
         VMSTATE_UINT32(qtag, vscsi_req),
         VMSTATE_BOOL(active, vscsi_req),
         VMSTATE_UINT32(data_len, vscsi_req),
@@ -1103,7 +1103,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
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



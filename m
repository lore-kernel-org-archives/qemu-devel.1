Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F187C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8B7208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Enw6AUFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8B7208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pRI-0003KA-5t
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pNg-0006lZ-CY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pNd-0000cd-Dt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pNd-0000c8-AW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeMYYJM4rZHjEQE/kaChO98H7SkxnIdxqobYmNOE1qU=;
 b=Enw6AUFbZN5cQPVi803fj2RzEbcC2VPozduVlI2Aw2FO9JQQEQEo8gx5+k2w9d8u/L9jfj
 M8ZJnSSwTagHz/EJn8/c6CD+iYTLgIDZiZqUpBYs/PBF4KxDYuZTLH1LFC8CzlZTXwDub6
 JQ7EFQBhVwxLB704XYNnLgmzf7mR0pw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-71PN0rMTPj-Y847AkHZUfg-1; Thu, 05 Mar 2020 07:13:30 -0500
X-MC-Unique: 71PN0rMTPj-Y847AkHZUfg-1
Received: by mail-wr1-f70.google.com with SMTP id q18so2228387wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=km1ZrpW4qZf4ZJfWNb4+tgog9PwiHithuRYIeTrt3yA=;
 b=TnK5Zw/Ytkn/MXbxiU9AqNxNyyx090XcUNiGnQe7TuMM9b12+KhujYyy/ALKI+DxAY
 CE6GB3wnV6qDeeAidmjryMv48sUOisW1E/94TZsQRF/6qkRi24h9hvmOoB9zWyKWNeX3
 ToOHV9HWOm1EuhOukYr4upVDpC+UXIsWOoli3meaGfyLQNmvx10kLOir8uslXLG0TmH+
 7ouy1DhJFQll5bT3Uh2vs8MsalgdZ8GK9g3FrbqWsYqbz4p6e9K5sNnBgQSCHbuM7X3a
 pkkOl8gY/435mhoQoMrw+LTvpXNXI/PXrf4edv/YxnsBVLmS9A8ZaVPqfpbkchOsYtWi
 BUDw==
X-Gm-Message-State: ANhLgQ0ijm2YHK6SolXcV7xS1pLA3Id8yaxWUm/VuVyYtCe5f3tc2uFQ
 IEmfTH3cLLd949emFo6+GUgXWB05oFv3LrpojgS7TZT2hxX3m9u7wfMZye8C9d/UseBodY4Vhc3
 Zxa3rveLOLANTfZo=
X-Received: by 2002:a5d:4805:: with SMTP id l5mr9196701wrq.11.1583410408632;
 Thu, 05 Mar 2020 04:13:28 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuzE27IqO/AvypAGce+Zas6OjQogDbhR1DrzPAhyML7+07Wz285lX7xs+jUujuvpOO3ixXzmg==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr9196683wrq.11.1583410408463;
 Thu, 05 Mar 2020 04:13:28 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j66sm9149600wmb.21.2020.03.05.04.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:13:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] hw/scsi/spapr_vscsi: Prevent buffer overflow
Date: Thu,  5 Mar 2020 13:12:52 +0100
Message-Id: <20200305121253.19078-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305121253.19078-1-philmd@redhat.com>
References: <20200305121253.19078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Depending on the length of sense data, vscsi_send_rsp() can
overrun the buffer size.
Do not copy more than SRP_MAX_IU_DATA_LEN bytes, and assert
that vscsi_send_iu() is always called with a size in range.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
@@ -181,6 +183,8 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *req,
 {
     long rc, rc1;
=20
+    assert(length <=3D SRP_MAX_IU_LEN);
+
     /* First copy the SRP */
     rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
                              &req->viosrp_iu_buf, length);
@@ -266,10 +270,12 @@ static int vscsi_send_rsp(VSCSIState *s, vscsi_req *r=
eq,
     if (status) {
         iu->srp.rsp.sol_not =3D (sol_not & 0x04) >> 2;
         if (req->senselen) {
+            int sense_data_len =3D MIN(req->senselen, SRP_MAX_IU_DATA_LEN)=
;
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
@@ -896,6 +902,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
     }
=20
     /* Compose the response here as  */
+    QEMU_BUILD_BUG_ON(SRP_MAX_IU_DATA_LEN < 4);
     memset(iu, 0, sizeof(struct srp_rsp) + 4);
     iu->srp.rsp.opcode =3D SRP_RSP;
     iu->srp.rsp.req_lim_delta =3D cpu_to_be32(1);
--=20
2.21.1



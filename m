Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318C620870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKFPYTTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318C620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lxc-00049e-Cc
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9lvE-00088V-Ar
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9lvD-0007tS-7L
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:32:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9lvD-0007t7-3B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=im9FKb6/7VxBNBG6RzscUZZ3f5mRdei8ZDLvabjVaI0=;
 b=IKFPYTTIzYYkgDTiQ3lJpOalgFV0qz7OwjxiToZm1Fx/y8K2Xz31hqFRuRXJISUKdApkrx
 Sj5EWFAurbH/cl8r4chToDx2a8ip0i1O/xFWj9z0ZWR2cME1AazUbiB3znlAO0oCzi52zC
 5K469pSMbcnvOUeQCO6JfBsO9GuI5lQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-yVP4-0rWOrycuNqlYJ_c6g-1; Thu, 05 Mar 2020 03:31:55 -0500
X-MC-Unique: yVP4-0rWOrycuNqlYJ_c6g-1
Received: by mail-wm1-f71.google.com with SMTP id t2so1289234wmj.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0iGeS84THZ+OQAErS0AboPyoiOZizq7Y6Bk3c2GM1TU=;
 b=d07tIo5yOFU+IeCDLzQGjBQCHxercrKvApYZM/tZ9rcM4DaMNL9aJBXSB6fPiRmspx
 yEdUOy+ueWBb4GWmf5GfgoChP+UYRdkTqZxZHPU5XH21ugB6lJ1J/esYeTCVlr6D6kn9
 ZoUxWHWCKW5tZESuUDzvD6RbE0QhQ6lP6phKjCeYTZx+JOIgg3PMN6VZSaiHRtJm7BB3
 XkKU+69p/waZKKQASZNNkPxM6HnqSuewASmXQqpWgRbrXZ9Fm9kefRX0LePLxFUaozK/
 5KbQVBi7A67JbeNj8lHGVg5W8/SoRX/sS622KKaq8wX44cvETlS7Jhch80OtFmwS9FtC
 +VjQ==
X-Gm-Message-State: ANhLgQ0DqZEJADnnpAxW8qJZTkFaMca3wYmvmgl26LdpsZQss88VWQ4W
 XDbfxM5+gxoR2YyjmbdfnkL4d6cFhRMw5csUoTQRn/DABAhkRNgXE6omQE+W6rGUDHyEEM7UeN8
 QBp5WEdVCEh3clEE=
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr8241201wmj.85.1583397113942; 
 Thu, 05 Mar 2020 00:31:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vun5m0hDfIXFfVLUDRM42t0j64w0gvvlHRv+PiRoPIxglId8JyyXbHh1UPf5JXu8d7n2dRH2Q==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr8241182wmj.85.1583397113767; 
 Thu, 05 Mar 2020 00:31:53 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p17sm40713617wre.89.2020.03.05.00.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 00:31:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [MERGED PATCH v2 3/5] hw/scsi/spapr_vscsi: Simplify a bit
Date: Thu,  5 Mar 2020 09:31:33 +0100
Message-Id: <20200305083135.8270-4-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have a ui pointer, use it (to simplify the next commit).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Patch already applied to ppc-for-5.0.

 hw/scsi/spapr_vscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7e397ed797..3cb5a38181 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -261,9 +261,9 @@ static int vscsi_send_rsp(VSCSIState *s, vscsi_req *req=
,
     if (status) {
         iu->srp.rsp.sol_not =3D (sol_not & 0x04) >> 2;
         if (req->senselen) {
-            req->iu.srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
-            req->iu.srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen);
-            memcpy(req->iu.srp.rsp.data, req->sense, req->senselen);
+            iu->srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
+            iu->srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen);
+            memcpy(iu->srp.rsp.data, req->sense, req->senselen);
             total_len +=3D req->senselen;
         }
     } else {
--=20
2.21.1



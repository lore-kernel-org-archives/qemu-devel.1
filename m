Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB78AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37D6208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WL14pG/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37D6208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pPA-0000Df-RA
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pNO-00065W-IH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pNN-0000Td-Ke
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pNN-0000T2-Hj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rG8Y7O79Oza1E4EtHnotT9wEc0MgFuHlwA25y0EWOjc=;
 b=WL14pG/t5R4uTiTVSICpXme9tdR9+1G2kAGM1OVKqd800uHzYWbSwnRFq1zCRZjt6q4wO1
 yyfCWcCE3cIanBZ8qKeMMHQp2ufyeRPVdhwZfAUCcdYIkQkQRKr0MG6f4m016FKYcoaH8E
 Pwf0c7qUjlszBQtcPqNflyKtjt4xpIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-ulghJ_k6NA60OLHJgfyDbQ-1; Thu, 05 Mar 2020 07:13:13 -0500
X-MC-Unique: ulghJ_k6NA60OLHJgfyDbQ-1
Received: by mail-wm1-f71.google.com with SMTP id e26so493241wmk.8
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rYF0P2Wybp24BR2c5EPUo6wbbWoDVqZzcDGxlMTgfhI=;
 b=UgosUTYh0Kmjt+F32CG04Qc12JIidJPYqDTfnshtaI4MBqCPgd934eBNLUKKCremCy
 qsNnu5PaefNdynraGoMtsYuTIDz+GYtVq0objpJEX33QPdsfYenjnDl9F0QrQXDSfZ7U
 E27k8TpnSxgez9SJCgZuhnmn3fkjQYWYcQIsH/CNK+HjAihTJArqWmGh8MpM91ci2Zdm
 hVf5bQl7ncfvxrU03Okz/9eNNRzerbw0I/A/wWSgYT9u/uLU5miosAtVqNzoKAPhRQ+I
 1zS+ndPwWSD8/eoXqzlx8v3/nbIvArUXzgkDofL/oYwwBXC0gZ4KiSmztE56fhB/Ylfl
 55tQ==
X-Gm-Message-State: ANhLgQ1PAQezLyF6lVSEq0siQKN16Wc66EjqBhIr+nkCe0qX6v4o/2O8
 gViycg+lZk5oA8XqqfVwc/gzqmnQc2SlhM9fRYrRTu9rTBznZqppDeWGydZK4RZiKkTY/3VLMU8
 Ytk8d18OpIvc/les=
X-Received: by 2002:adf:e74e:: with SMTP id c14mr10335545wrn.128.1583410392074; 
 Thu, 05 Mar 2020 04:13:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs79/ix+uVENHHbayrZfX7scKVeWpGzajfjWZwLa4XAuEUhfb73W+x3PbI+m2gAR4r8WEorYA==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr10335519wrn.128.1583410391879; 
 Thu, 05 Mar 2020 04:13:11 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u17sm8180841wmj.47.2020.03.05.04.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:13:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] hw/scsi/spapr_vscsi: Simplify a bit
Date: Thu,  5 Mar 2020 13:12:49 +0100
Message-Id: <20200305121253.19078-4-philmd@redhat.com>
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

We already have a 'iu' pointer, use it
(this simplifies the next commit).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
since v2: fixed typo in description (Greg Kurz)
---
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



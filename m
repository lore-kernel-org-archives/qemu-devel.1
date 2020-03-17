Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E35C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1947206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NQSNsgj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1947206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Ht-0007Jg-1Y
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95q-0001G5-AN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95n-0003Xz-LT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:02 -0400
Received: from ozlabs.org ([203.11.71.1]:43399)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95n-0002rh-8h; Tue, 17 Mar 2020 06:04:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKy3N2Xz9sTK; Tue, 17 Mar 2020 21:04:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439478;
 bh=uQp81HKqcQMQGuUZd2mCb4gRCwE3YNLsmBa2mm3EkEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NQSNsgj1zL3hLBu2aLFJ65wrPf+rW0aDySYtLovErcqUZRC+rXDOqPgzfhgApBgK3
 S32YRE+R2+illdIT2qpxwThF845Vb6yjVEyLuzmZ4ABAVzAraNRP5FRQvXiBPGdp5N
 jTFU1lPsLrAHQ0nNnUEO5I3dRdiB6836PUQe7VRA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 24/45] hw/scsi/spapr_vscsi: Simplify a bit
Date: Tue, 17 Mar 2020 21:04:02 +1100
Message-Id: <20200317100423.622643-25-david@gibson.dropbear.id.au>
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

We already have a 'iu' pointer, use it
(this simplifies the next commit).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305121253.19078-4-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7e397ed797..3cb5a38181 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -261,9 +261,9 @@ static int vscsi_send_rsp(VSCSIState *s, vscsi_req *r=
eq,
     if (status) {
         iu->srp.rsp.sol_not =3D (sol_not & 0x04) >> 2;
         if (req->senselen) {
-            req->iu.srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
-            req->iu.srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen=
);
-            memcpy(req->iu.srp.rsp.data, req->sense, req->senselen);
+            iu->srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
+            iu->srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen);
+            memcpy(iu->srp.rsp.data, req->sense, req->senselen);
             total_len +=3D req->senselen;
         }
     } else {
--=20
2.24.1



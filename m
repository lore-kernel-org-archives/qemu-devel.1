Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27423C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66E722DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d8j2wIRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66E722DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LPE-0001Ie-Ub
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0T-0004dm-Ld
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0Q-000868-FW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:09 -0400
Received: from ozlabs.org ([203.11.71.1]:57403)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0O-00081U-A0; Wed, 21 Aug 2019 03:26:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjC3WPxz9sPn; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372351;
 bh=/Dle6wZbIMbneQ+F1agaSsQQsfyIA7WAL1f4+JCNAao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d8j2wIRUJmBhNjWfYl7uoXnxf08Au1I3LH/wmEnWcUGgbvLH+6QpQrvmFmOptdeSJ
 P0vyDc9NEACcVmAE0hnQ0W3+ZQSIBjo5DgmLHCsCxjql+f3YjphP6IufUCUHHMkQx+
 wEHFX9jLttP2NA+UhFx4oQ2Dtho5MjPwUY1sJch4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:14 +1000
Message-Id: <20190821072542.23090-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 14/42] ppc: fix leak in
 h_client_architecture_support
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
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Free all SpaprOptionVector local pointers after use.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-Id: <156335160761.82682.11912058325777251614.stgit@lep8c.aus.stgl=
abs.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 225c60a9fc..47b566882b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1613,6 +1613,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     ov5_updates =3D spapr_ovec_new();
     spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
                                         ov5_cas_old, spapr->ov5_cas);
+    spapr_ovec_cleanup(ov5_cas_old);
     /* Now that processing is finished, set the radix/hash bit for the
      * guest if it requested a valid mode; otherwise terminate the boot.=
 */
     if (guest_radix) {
@@ -1630,6 +1631,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     }
     spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
                                                           OV1_PPC_3_00);
+    spapr_ovec_cleanup(ov1_guest);
     if (!spapr->cas_reboot) {
         /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
          * (because the guest isn't going to use radix) then set it up h=
ere. */
--=20
2.21.0



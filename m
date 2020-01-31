Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728F3C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAD9206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JAPs3N/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAD9206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixPZM-0007G8-Dg
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUr-0006bA-A2
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUq-0000PT-3o
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:41 -0500
Received: from ozlabs.org ([203.11.71.1]:52511)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixPUp-0000Kj-Oi; Fri, 31 Jan 2020 01:09:40 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4886Hs0wtmz9sRp; Fri, 31 Jan 2020 17:09:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580450969;
 bh=PVwxscjrI7jhsuwlQkAC7qDnh7+BHJbvc7CrDJ8cLlc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JAPs3N/ehNEn3ob3K+o4piuvtfLu7p8V/z5R5x3vWu2pf8N4vbyuD+hnoJIXCatdE
 S6AIAZ77O2px21dTOCWGWhc7h2SdKBKa3I5dWFdRchFDg+GVpikFypUq/2ByjIZPle
 CtXeUEnL0BZPCqq38v9B2HlHSW8zLHl+LPehDs5c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/34] spapr: Fail CAS if option vector table cannot be parsed
Date: Fri, 31 Jan 2020 17:08:56 +1100
Message-Id: <20200131060924.147449-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131060924.147449-1-david@gibson.dropbear.id.au>
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Most of the option vector helpers have assertions to check their
arguments aren't null. The guest can provide an arbitrary address
for the CAS structure that would result in such null arguments.
Fail CAS with H_PARAMETER and print a warning instead of aborting
QEMU.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <157925255250.397143.10855183619366882459.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f1799b1b70..ffb14641f9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1703,7 +1703,15 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
     ov_table =3D addr;
=20
     ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
+    if (!ov1_guest) {
+        warn_report("guest didn't provide option vector 1");
+        return H_PARAMETER;
+    }
     ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
+    if (!ov5_guest) {
+        warn_report("guest didn't provide option vector 5");
+        return H_PARAMETER;
+    }
     if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
         error_report("guest requested hash and radix MMU, which is inval=
id.");
         exit(EXIT_FAILURE);
--=20
2.24.1



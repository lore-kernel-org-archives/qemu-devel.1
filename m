Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3572CC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0197B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XavMABBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0197B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbx8-0000SC-2Y
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu8-0004a8-5N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu7-0001eB-4X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:08 -0400
Received: from ozlabs.org ([203.11.71.1]:32931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu6-0001bo-OK; Tue, 24 Mar 2020 01:15:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW6fZVz9sSV; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=OKcovYR9VNB4z7gkjGackfXxGtFZioSygC+HVi/Nk3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XavMABBr2AHB/fJPnzGjzA1tzrlyu94ez/FXyWe78tjVibwJZNMQiLAogE2SaHjZd
 eQf0g+wytaiX/SB2F/LgE2CdrMTRes+Wh+/guFPpFckjTd+TaF6hfsXoVvcKW0aMLB
 TGptYa2swJecs/lCBknjeSTJmUS1/2b0ztRhLEnU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 5/7] spapr: Fix memory leak in h_client_architecture_support()
Date: Tue, 24 Mar 2020 16:14:54 +1100
Message-Id: <20200324051456.256116-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324051456.256116-1-david@gibson.dropbear.id.au>
References: <20200324051456.256116-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

This is the only error path that needs to free the previously allocated
ov1.

Reported-by: Coverity (CID 1421924)
Fixes: cbd0d7f36322 "spapr: Fail CAS if option vector table cannot be par=
sed"
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158481206205.336182.16106097429336044843.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_hcall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 40c86e91eb..0d50fc9117 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1726,6 +1726,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     }
     ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
     if (!ov5_guest) {
+        spapr_ovec_cleanup(ov1_guest);
         warn_report("guest didn't provide option vector 5");
         return H_PARAMETER;
     }
--=20
2.25.1



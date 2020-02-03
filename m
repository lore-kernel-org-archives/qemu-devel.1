Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D688EC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E80120658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ec0b6pyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E80120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVEx-0003Ti-PD
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUy2-0003ie-2i
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxr-0003Xu-2D
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:12 -0500
Received: from ozlabs.org ([203.11.71.1]:42153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxq-0003Tc-Kw; Mon, 03 Feb 2020 01:12:06 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBv14Ssz9sTB; Mon,  3 Feb 2020 17:11:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710295;
 bh=5sM9Lz2RmC8JDBadeQkrCEvJ50g3Y0oRMAd6UT8RVTA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ec0b6pyvH4a9697DR7i0cUUZ4UHB6YR/1ljm/78ApANeS1oxKvgj/IRT5Df14bUn2
 Hv2kEjdAtKqsrKgNWDoCmNaDGSzIYXGBXv8S/4exmWidyTaLsCG8a3/89cYe3pTNJG
 Sx8W6i95x69oK142c3Zf1U8gcSGoujUrpf3mVGWA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 34/35] target/ppc: Use probe_write for DCBZ
Date: Mon,  3 Feb 2020 17:11:22 +1100
Message-Id: <20200203061123.59150-35-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Using probe_write instead of tlb_vaddr_to_host means that we
process watchpoints and notdirty pages more efficiently.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200129235040.24022-5-richard.henderson@linaro.org>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 0cb78777e7..98f589552b 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -298,7 +298,7 @@ static void dcbz_common(CPUPPCState *env, target_ulon=
g addr,
     }
=20
     /* Try fast path translate */
-    haddr =3D tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
+    haddr =3D probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (haddr) {
         memset(haddr, 0, dcbz_size);
     } else {
--=20
2.24.1



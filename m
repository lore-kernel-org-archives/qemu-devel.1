Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D52C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308AE206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dTGzGbed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308AE206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuVd-0003Gs-CS
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:38:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1P-0006TO-9m
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1O-0005ks-7n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46241 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu1N-0005AP-RF; Fri, 26 Apr 2019 02:07:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tr2vFVz9sP7; Fri, 26 Apr 2019 16:06:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258800;
	bh=BGUxo+69DyxWOcoYW0v+TrohW3b5SGY5IZ68jpOhStM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTGzGbedQ+PzgKasO/vdbhEELR4cCBVnkjItpDnAvpfLWSA3QpC1th9zNBL2NcMbp
	wj4+ACrw1kwtRWvxiRrZxE0kZVhuc/GEtHkfc2uuFi8Shsm9y5D8NUIte7zz5Oklnk
	3A3z/0mjZ4aL51S2KKYN/z5VcLMdutnnooxqlcPc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:24 +1000
Message-Id: <20190426060627.18153-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 33/36] ppc/spapr: Use proper HPTE accessors for
 H_READ
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060624.LaJTX_0-SakkjUrRlXk85kZzw9GV4ra2tZflg-QaOZE@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190411080004.8690-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..3534079777 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -304,8 +304,8 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
 {
     target_ulong flags =3D args[0];
     target_ulong ptex =3D args[1];
-    uint8_t *hpte;
     int i, ridx, n_entries =3D 1;
+    const ppc_hash_pte64_t *hptes;
=20
     if (!valid_ptex(cpu, ptex)) {
         return H_PARAMETER;
@@ -317,13 +317,12 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
         n_entries =3D 4;
     }
=20
-    hpte =3D spapr->htab + (ptex * HASH_PTE_SIZE_64);
-
+    hptes =3D ppc_hash64_map_hptes(cpu, ptex, n_entries);
     for (i =3D 0, ridx =3D 0; i < n_entries; i++) {
-        args[ridx++] =3D ldq_p(hpte);
-        args[ridx++] =3D ldq_p(hpte + (HASH_PTE_SIZE_64/2));
-        hpte +=3D HASH_PTE_SIZE_64;
+        args[ridx++] =3D ppc_hash64_hpte0(cpu, hptes, i);
+        args[ridx++] =3D ppc_hash64_hpte1(cpu, hptes, i);
     }
+    ppc_hash64_unmap_hptes(cpu, hptes, ptex, n_entries);
=20
     return H_SUCCESS;
 }
--=20
2.20.1



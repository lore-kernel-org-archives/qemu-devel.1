Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3059C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE1C2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jtj+Zv1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE1C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuTu-0001ui-Q2
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:37:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu19-0006F4-HO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu17-0005K5-JP
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:27 -0400
Received: from ozlabs.org ([203.11.71.1]:42197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu13-0005AE-SU; Fri, 26 Apr 2019 02:07:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tr5kQTz9sP2; Fri, 26 Apr 2019 16:06:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258800;
	bh=4SF6Qz690a2Klih/QbUrTHpCEcnykbkSd2N349hfpFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jtj+Zv1wBmzfEvIS//+r2/BgOnp608Vs/I18RWPwAVN0OyDo6iUpevjC4e9Yg0uEm
	1r2vUpxnoALswKKk/+DQoqM1R9dN2OQpJQPLC+uoKDxBINCu1ZTksOx+jzfBAL9QAA
	1GhdgyXMRnq9FTkpNZP6PoA1qNNTbHIa8KbGRQDg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:23 +1000
Message-Id: <20190426060627.18153-33-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 32/36] target/ppc: Don't check UPRT in radix
 mode when in HV real mode
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
Message-ID: <20190426060623.UNmq3SJf6L0So695AWA50OIfRh_IzhqidBOera8PMKA@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It appears that during kexec, we run for a while in hypervisor
real mode with LPCR:HR set and LPCR:UPRT clear, which trips
the assertion in ppc_radix64_handle_mmu_fault().

First this shouldn't be an assertion, it's a guest error.

Then we shouldn't be checking these things in hypervisor real
mode (or in virtual hypervisor guest real mode which is similar)
as the real HW won't use those LPCR bits in those cases anyway,
so technically it's ok to have this discrepancy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190411080004.8690-2-clg@kaod.org>
[dwg: Fix for 32-bit builds]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index ca1fb2673f..066e324464 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -228,10 +228,10 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
     ppc_v3_pate_t pate;
=20
     assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
-    assert(ppc64_use_proc_tbl(cpu));
=20
-    /* Real Mode Access */
-    if (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_d=
r =3D=3D 0))) {
+    /* HV or virtual hypervisor Real Mode Access */
+    if ((msr_hv || cpu->vhyp) &&
+        (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_=
dr =3D=3D 0)))) {
         /* In real mode top 4 effective addr bits (mostly) ignored */
         raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
=20
@@ -241,6 +241,16 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
         return 0;
     }
=20
+    /*
+     * Check UPRT (we avoid the check in real mode to deal with
+     * transitional states during kexec.
+     */
+    if (!ppc64_use_proc_tbl(cpu)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "LPCR:UPRT not set in radix mode ! LPCR=3D"
+                      TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
+    }
+
     /* Virtual Mode Access - get the fully qualified address */
     if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) =
{
         ppc_radix64_raise_segi(cpu, rwx, eaddr);
--=20
2.20.1



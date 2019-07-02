Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2CEC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5592064A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OJfzxeV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5592064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCfV-0006bV-Gl
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByn-00056r-QO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBym-0002yn-4t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40081 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByl-0002ul-G4; Tue, 02 Jul 2019 02:09:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMk3nxbz9sPq; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047746;
 bh=u8LjWJnfOy8kTg3+UAQuQQu7l/+b+yYblJTltUYGq94=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OJfzxeV+mG9fB5YR3L1sbO/PcEExeMQalIk7e2j0yNLRTlDxvOiFX/wUTdQulfLZW
 4XBYOjgcdAQtOFntGqb1J7A493g7c3sTp1df5aSLIZItnnadk0C0V0QuQ42atOiJNG
 z4uqiPeK0uymbON1U/Koyd1yZElV46BIvQqmy2Kg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:37 +1000
Message-Id: <20190702060857.3926-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 29/49] target/ppc: remove getVSR()/putVSR() from
 int_helper.c
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
registers are in host endian order" functions getVSR() and putVSR() which=
 used
to convert the VSR registers into host endian order are no longer require=
d.

Now that there are now no more users of getVSR()/putVSR() these functions=
 can
be completely removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 22 ++++++++++------------
 target/ppc/internal.h   | 12 ------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 8ce89f2ad9..3b8939edcc 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1902,38 +1902,36 @@ VEXTRACT(d, u64)
 void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
                         target_ulong xbn, uint32_t index)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt =3D &env->vsr[xtn];
+    ppc_vsr_t *xb =3D &env->vsr[xbn];
+    ppc_vsr_t t =3D { };
     size_t es =3D sizeof(uint32_t);
     uint32_t ext_index;
     int i;
=20
-    getVSR(xbn, &xb, env);
-    memset(&xt, 0, sizeof(xt));
-
     ext_index =3D index;
     for (i =3D 0; i < es; i++, ext_index++) {
-        xt.VsrB(8 - es + i) =3D xb.VsrB(ext_index % 16);
+        t.VsrB(8 - es + i) =3D xb->VsrB(ext_index % 16);
     }
=20
-    putVSR(xtn, &xt, env);
+    *xt =3D t;
 }
=20
 void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
                       target_ulong xbn, uint32_t index)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt =3D &env->vsr[xtn];
+    ppc_vsr_t *xb =3D &env->vsr[xbn];
+    ppc_vsr_t t =3D *xt;
     size_t es =3D sizeof(uint32_t);
     int ins_index, i =3D 0;
=20
-    getVSR(xbn, &xb, env);
-    getVSR(xtn, &xt, env);
-
     ins_index =3D index;
     for (i =3D 0; i < es && ins_index < 16; i++, ins_index++) {
-        xt.VsrB(ins_index) =3D xb.VsrB(8 - es + i);
+        t.VsrB(ins_index) =3D xb->VsrB(8 - es + i);
     }
=20
-    putVSR(xtn, &xt, env);
+    *xt =3D t;
 }
=20
 #define VEXT_SIGNED(name, element, cast)                            \
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index fb6f64ed1e..d3d327e548 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -204,18 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
=20
-static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    vsr->VsrD(0) =3D env->vsr[n].VsrD(0);
-    vsr->VsrD(1) =3D env->vsr[n].VsrD(1);
-}
-
-static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    env->vsr[n].VsrD(0) =3D vsr->VsrD(0);
-    env->vsr[n].VsrD(1) =3D vsr->VsrD(1);
-}
-
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
--=20
2.21.0



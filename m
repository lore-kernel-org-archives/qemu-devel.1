Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA886C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838602146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oB2v3oqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838602146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiC9f-0005aE-RQ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByj-0004w1-MR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByi-0002uF-As
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:21 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51465 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByh-0002pT-Js; Tue, 02 Jul 2019 02:09:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMh6Mv9z9sPZ; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047744;
 bh=GxG5T4mAzmDQk9JNvDaF99IBjK7p6c67pWLzMujSZMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oB2v3oqtRK2X5T+RwGJ6e2VOB2p6owaKm7v3HVAGGWgYLrL4odFjtHP/H216ocgyk
 Vkrb1jO4Ee/uMnXnqkr6R4m3Q8ZxORYOjpIQj8BBO4L82clVKXjwKTmDoFXLEHXwRd
 cpEo+QMCawZ5NIe0Ykn8JHR4UgwZMy+s/Rw+Akx4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:21 +1000
Message-Id: <20190702060857.3926-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 13/49] target/ppc: remove getVSR()/putVSR() from
 mem_helper.c
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190616123751.781-3-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mem_helper.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 5b0f9ee50d..87632ccf53 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -417,26 +417,27 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 void helper_##name(CPUPPCState *env, target_ulong addr,                 =
\
                    target_ulong xt_num, target_ulong rb)                =
\
 {                                                                       =
\
-    int i;                                                              =
\
-    ppc_vsr_t xt;                                                       =
\
+    ppc_vsr_t *xt =3D &env->vsr[xt_num];                                =
  \
+    ppc_vsr_t t;                                                        =
\
     uint64_t nb =3D GET_NB(rb);                                         =
  \
+    int i;                                                              =
\
                                                                         =
\
-    xt.s128 =3D int128_zero();                                          =
  \
+    t.s128 =3D int128_zero();                                           =
  \
     if (nb) {                                                           =
\
         nb =3D (nb >=3D 16) ? 16 : nb;                                  =
    \
         if (msr_le && !lj) {                                            =
\
             for (i =3D 16; i > 16 - nb; i--) {                          =
  \
-                xt.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC());=
  \
+                t.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC()); =
  \
                 addr =3D addr_add(env, addr, 1);                        =
  \
             }                                                           =
\
         } else {                                                        =
\
             for (i =3D 0; i < nb; i++) {                                =
  \
-                xt.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());    =
  \
+                t.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());     =
  \
                 addr =3D addr_add(env, addr, 1);                        =
  \
             }                                                           =
\
         }                                                               =
\
     }                                                                   =
\
-    putVSR(xt_num, &xt, env);                                           =
\
+    *xt =3D t;                                                          =
  \
 }
=20
 VSX_LXVL(lxvl, 0)
@@ -447,23 +448,23 @@ VSX_LXVL(lxvll, 1)
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
                    target_ulong xt_num, target_ulong rb)          \
 {                                                                 \
-    int i;                                                        \
-    ppc_vsr_t xt;                                                 \
+    ppc_vsr_t *xt =3D &env->vsr[xt_num];                            \
     target_ulong nb =3D GET_NB(rb);                                 \
+    int i;                                                        \
                                                                   \
     if (!nb) {                                                    \
         return;                                                   \
     }                                                             \
-    getVSR(xt_num, &xt, env);                                     \
+                                                                  \
     nb =3D (nb >=3D 16) ? 16 : nb;                                    \
     if (msr_le && !lj) {                                          \
         for (i =3D 16; i > 16 - nb; i--) {                          \
-            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
+            cpu_stb_data_ra(env, addr, xt->VsrB(i - 1), GETPC()); \
             addr =3D addr_add(env, addr, 1);                        \
         }                                                         \
     } else {                                                      \
         for (i =3D 0; i < nb; i++) {                                \
-            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
+            cpu_stb_data_ra(env, addr, xt->VsrB(i), GETPC());     \
             addr =3D addr_add(env, addr, 1);                        \
         }                                                         \
     }                                                             \
--=20
2.21.0



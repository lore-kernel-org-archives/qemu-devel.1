Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8FC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE162464B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE162464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPTi-0002E5-2n
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vt@altlinux.org>) id 1jBPI1-0002nL-6u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vt@altlinux.org>) id 1jBPI0-0002mA-6v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:46:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52566)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <vt@altlinux.org>)
 id 1jBPHz-0002kj-W0; Mon, 09 Mar 2020 16:46:16 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 4285672CCE7;
 Mon,  9 Mar 2020 23:46:13 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [83.220.44.62])
 by imap.altlinux.org (Postfix) with ESMTPSA id 07E304A4A16;
 Mon,  9 Mar 2020 23:46:13 +0300 (MSK)
From: Vitaly Chikunov <vt@altlinux.org>
To: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] target/ppc: Fix rlwinm on ppc64
Date: Mon,  9 Mar 2020 23:45:57 +0300
Message-Id: <20200309204557.14836-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 194.107.17.57
X-Mailman-Approved-At: Mon, 09 Mar 2020 16:57:38 -0400
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
Cc: Vitaly Chikunov <vt@altlinux.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

rlwinm cannot just AND with Mask if shift value is zero on ppc64 when
Mask Begin is greater than Mask End and high bits are set to 1.

Note that PowerISA 3.0B says that for `rlwinm' ROTL32 is used, and
ROTL32 is defined (in 3.3.14) so that rotated value should have two
copies of lower word of the source value.

This seems to be another incarnation of the fix from 820724d170
("target-ppc: Fix rlwimi, rlwinm, rlwnm again"), except I leave
optimization when Mask value is less than 32 bits.

Fixes: 7b4d326f47 ("target-ppc: Use the new deposit and extract ops")
Cc: qemu-stable@nongnu.org
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 target/ppc/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 36fa27367c..127c82a24e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1938,15 +1938,17 @@ static void gen_rlwinm(DisasContext *ctx)
         me +=3D 32;
 #endif
         mask =3D MASK(mb, me);
-        if (sh =3D=3D 0) {
-            tcg_gen_andi_tl(t_ra, t_rs, mask);
-        } else if (mask <=3D 0xffffffffu) {
-            TCGv_i32 t0 =3D tcg_temp_new_i32();
-            tcg_gen_trunc_tl_i32(t0, t_rs);
-            tcg_gen_rotli_i32(t0, t0, sh);
-            tcg_gen_andi_i32(t0, t0, mask);
-            tcg_gen_extu_i32_tl(t_ra, t0);
-            tcg_temp_free_i32(t0);
+        if (mask <=3D 0xffffffffu) {
+            if (sh =3D=3D 0) {
+                tcg_gen_andi_tl(t_ra, t_rs, mask);
+            } else {
+                TCGv_i32 t0 =3D tcg_temp_new_i32();
+                tcg_gen_trunc_tl_i32(t0, t_rs);
+                tcg_gen_rotli_i32(t0, t0, sh);
+                tcg_gen_andi_i32(t0, t0, mask);
+                tcg_gen_extu_i32_tl(t_ra, t0);
+                tcg_temp_free_i32(t0);
+            }
         } else {
 #if defined(TARGET_PPC64)
             tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
--=20
2.11.0



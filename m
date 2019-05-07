Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B97FC04A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C2F206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZxT8PG47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C2F206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36083 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNoMT-0002T0-38
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 20:53:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHZ-0006ro-J8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHY-0002yu-GU
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hNoHY-0002wg-3H; Mon, 06 May 2019 20:48:32 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id 44ygvd5Fx3z9sND; Tue,  7 May 2019 10:48:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557190109; bh=pd86ZNq3VMQQNY5S3wUDjnzZfH284LDiZLHzu0Db7Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxT8PG479+DtwDuPcFGSg1EOtSh4s0HJIgemL+LywMIe9cqHNpetexY5wa2Kse9nr
	QUwoOVph/chJ9KgLbF1nO+aTkzdk97GRm2ljpF7GJsQ8KOsy2iUzOvsa8RJpk+6Ysk
	/YmRq1WG4DLcEXbyXG77E1krXhfabjA3f6ZKmYVj54l+qQqDO9zgKOKxfgQj9H9Aqq
	UOyVeXd6Dy5diM7BNDuZPNzMjT+1pizyIohZVv4reYs0lp/pftWrYott2+AqIWVYRA
	JvheyOLUjvRCvv/oYL0B8fSnoq423T+cnUwvJE100qXFnpUPl+xrKO1jtmKBmkgLYo
	qCM2JNhJmrrdA==
From: Anton Blanchard <anton@ozlabs.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:48:09 +1000
Message-Id: <20190507004811.29968-7-anton@ozlabs.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507004811.29968-1-anton@ozlabs.org>
References: <20190507004811.29968-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 7/9] target/ppc: Fix vrlwmi and vrlwnm
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, mark.cave-ayland@ilande.co.uk,
	f4bug@amsat.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should only look at 5 bits of each byte, not 6.

Fixes: 3e00884f4e9f ("target-ppc: add vrldnmi and vrlwmi instructions")
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 target/ppc/int_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index fd715b4076..111586c981 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1652,7 +1652,7 @@ void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *=
r, ppc_avr_t *b)
     }
 }
=20
-#define VRLMI(name, size, element, insert)                            \
+#define VRLMI(name, size, element, insert, modifier_bits)             \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)          \
 {                                                                     \
     int i;                                                            \
@@ -1662,9 +1662,9 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)          \
         uint##size##_t src3 =3D r->element[i];                          =
\
         uint##size##_t begin, end, shift, mask, rot_val;              \
                                                                       \
-        shift =3D extract##size(src2, 0, 6);                            =
\
-        end   =3D extract##size(src2, 8, 6);                            =
\
-        begin =3D extract##size(src2, 16, 6);                           =
\
+        shift =3D extract##size(src2, 0, modifier_bits);                =
\
+        end   =3D extract##size(src2, 8, modifier_bits);                =
\
+        begin =3D extract##size(src2, 16, modifier_bits);               =
\
         rot_val =3D rol##size(src1, shift);                             =
\
         mask =3D mask_u##size(begin, end);                              =
\
         if (insert) {                                                 \
@@ -1675,10 +1675,10 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, pp=
c_avr_t *b)          \
     }                                                                 \
 }
=20
-VRLMI(vrldmi, 64, u64, 1);
-VRLMI(vrlwmi, 32, u32, 1);
-VRLMI(vrldnm, 64, u64, 0);
-VRLMI(vrlwnm, 32, u32, 0);
+VRLMI(vrldmi, 64, u64, 1, 6);
+VRLMI(vrlwmi, 32, u32, 1, 5);
+VRLMI(vrldnm, 64, u64, 0, 6);
+VRLMI(vrlwnm, 32, u32, 0, 5);
=20
 void helper_vsel(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t=
 *b,
                  ppc_avr_t *c)
--=20
2.20.1



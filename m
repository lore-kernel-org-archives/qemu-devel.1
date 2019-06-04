Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15140C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2D9243BD
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2D9243BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY5uw-0002aK-38
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 05:39:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hY5sQ-0000yN-BC
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hY5sP-0004xa-7c
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hY5sP-0004wp-2T; Tue, 04 Jun 2019 05:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AF14308793B;
	Tue,  4 Jun 2019 09:37:04 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-61.ams2.redhat.com [10.36.117.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE8B1001DD9;
	Tue,  4 Jun 2019 09:36:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 11:36:56 +0200
Message-Id: <20190604093656.23565-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 04 Jun 2019 09:37:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1] linux-user: elf: ELF_HWCAP for s390x
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's add all HWCAPs that we can support under TCG right now, when the
respective CPU facilities are enabled.

Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This patch is based on "[PATCH v2 00/22] s390x/tcg: Vector Instruction
Support Part 4". I guess it is best if I just include it in my next
pull request.

---
 include/elf.h        |  1 +
 linux-user/elfload.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index ea7708a4ea..3501e0c8d0 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -598,6 +598,7 @@ typedef struct {
 #define HWCAP_S390_ETF3EH       256
 #define HWCAP_S390_HIGH_GPRS    512
 #define HWCAP_S390_TE           1024
+#define HWCAP_S390_VXRS         2048
=20
 /* M68K specific definitions. */
 /* We use the top 24 bits to encode information about the
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a57b7049dd..59b813066c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1308,6 +1308,45 @@ static inline void init_thread(struct target_pt_re=
gs *regs,
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
=20
+#include "elf.h"
+
+#define ELF_HWCAP get_elf_hwcap()
+
+static uint32_t get_elf_hwcap(void)
+{
+    uint32_t hwcap =3D 0;
+
+    if (s390_has_feat(S390_FEAT_ESAN3)) {
+        hwcap |=3D HWCAP_S390_ESAN3;
+    }
+    if (s390_has_feat(S390_FEAT_ZARCH)) {
+        hwcap |=3D HWCAP_S390_ZARCH;
+    }
+    if (s390_has_feat(S390_FEAT_STFLE)) {
+        hwcap |=3D HWCAP_S390_STFLE;
+    }
+    if (s390_has_feat(S390_FEAT_MSA)) {
+        hwcap |=3D HWCAP_S390_MSA;
+    }
+    if (s390_has_feat(S390_FEAT_LONG_DISPLACEMENT)) {
+        hwcap |=3D HWCAP_S390_LDISP;
+    }
+    if (s390_has_feat(S390_FEAT_EXTENDED_IMMEDIATE)) {
+        hwcap |=3D HWCAP_S390_EIMM;
+    }
+    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
+        s390_has_feat(S390_FEAT_ETF3_ENH)) {
+        hwcap |=3D HWCAP_S390_ETF3EH;
+    }
+    /* 31-bit processes can use 64-bit registers */
+    hwcap |=3D HWCAP_S390_HIGH_GPRS;
+    if (s390_has_feat(S390_FEAT_VECTOR)) {
+        hwcap |=3D HWCAP_S390_VXRS;
+    }
+
+    return hwcap;
+}
+
 static inline void init_thread(struct target_pt_regs *regs, struct image=
_info *infop)
 {
     regs->psw.addr =3D infop->entry;
--=20
2.21.0



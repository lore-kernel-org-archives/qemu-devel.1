Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35628C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091E12064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091E12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJvx-0002k1-QK
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJOe-0002yu-I1
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJOd-0004Wk-7X
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iCJOd-0004WM-2L; Mon, 23 Sep 2019 04:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55995C0546FB;
 Mon, 23 Sep 2019 08:08:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE9C719C78;
 Mon, 23 Sep 2019 08:08:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 29/30] tests/tcg: target/s390x: Test MVO
Date: Mon, 23 Sep 2019 10:07:11 +0200
Message-Id: <20190923080712.23951-30-david@redhat.com>
In-Reply-To: <20190923080712.23951-1-david@redhat.com>
References: <20190923080712.23951-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 23 Sep 2019 08:08:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's add the simple test based on the example from the PoP.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/tcg/s390x/Makefile.target |  1 +
 tests/tcg/s390x/mvo.c           | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/tcg/s390x/mvo.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.t=
arget
index 151dc075aa..6a3bfa8b29 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -6,3 +6,4 @@ TESTS+=3Dipm
 TESTS+=3Dexrl-trt
 TESTS+=3Dexrl-trtr
 TESTS+=3Dpack
+TESTS+=3Dmvo
diff --git a/tests/tcg/s390x/mvo.c b/tests/tcg/s390x/mvo.c
new file mode 100644
index 0000000000..5546fe2a97
--- /dev/null
+++ b/tests/tcg/s390x/mvo.c
@@ -0,0 +1,25 @@
+#include <stdint.h>
+#include <stdio.h>
+
+int main(void)
+{
+    uint8_t dest[6] =3D {0xff, 0x77, 0x88, 0x99, 0x0c, 0xff};
+    uint8_t src[5] =3D {0xee, 0x12, 0x34, 0x56, 0xee};
+    uint8_t expected[6] =3D {0xff, 0x01, 0x23, 0x45, 0x6c, 0xff};
+    int i;
+
+    asm volatile (
+        "    mvo 0(4,%[dest]),0(3,%[src])\n"
+        :
+        : [dest] "d" (dest + 1),
+          [src] "d" (src + 1)
+        : "memory");
+
+    for (i =3D 0; i < sizeof(expected); i++) {
+        if (dest[i] !=3D expected[i]) {
+            fprintf(stderr, "bad data\n");
+            return 1;
+        }
+    }
+    return 0;
+}
--=20
2.21.0



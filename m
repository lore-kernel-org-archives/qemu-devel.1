Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24FF2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24FF2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ1AT-00037x-JE
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ19i-0001sL-EG
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:51:18 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:62985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ19h-0002RL-9d
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:51:18 -0400
IronPort-SDR: GV2QDaaxGtPX+rus/4DwNvqmWrDrWz/K/3lyc76KOXKx20VotUqHHbizKjxux5mkcGOr9ztx7b
 4SkI5JUyHWXINa2DL1Q5b8xoUfoijXlpfQx+upXFLXGUzurOn/wfY0YKb8wtjVpZ3f3XJX+cFH
 i9ELBMu2ypnFbcx4MJxE7urdlIqhhigeu4x5Sz4fZ3vjvu1Q4Vqy+jBrRVSFxhAwmjs9fEHir6
 QaPLLNl39T/Ov43sMoj9N0+hQMoyMSQIT7xqNg84KfPuSQC7g4tAivG+fzseRoVXjQtNP7pF2n
 1gc=
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="48761597"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 13 May 2020 15:51:14 -0800
IronPort-SDR: sZrkrfRRXT+HpjaJ/WnrolmPGH3vAO+4jzWccM4+xG5lEn1ZfXOGpfSfdP9P++ovTKUfpu/uBZ
 UWso7jMJXWBkM9WyO+vVb5WOQyQ3J1eSUx5uBNVQHX+B/4sJjeha4Zh8YlvuvgJpRh+P8gqkvu
 FQ5ty12w28YeAj6nEIwKa2vBowcSxl28B2QX7jXLLvFpIuwvxp0tE/WxY2mMHwU1GCbCZr9cV9
 lUIpb/Ykw9mmi3Q3NvmxbcP0gEG6d24E+kJKVQh0XJZb8Q0XlYic4YxAF5tlOaEkthV2YHq5KM
 GGQ=
Date: Wed, 13 May 2020 23:51:09 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 3/4] target/i386: fix fbstp handling of negative zero
In-Reply-To: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005132350230.11687@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:51:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fbstp implementation stores +0 when the rounded result should be
-0 because it compares an integer value with 0 to determine the sign.
Fix this by checking the sign bit of the operand instead.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c         |  5 ++++-
 tests/tcg/i386/test-i386-fbstp.c | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/test-i386-fbstp.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 51372c371b..e1872b3fc0 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -726,11 +726,14 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     int v;
     target_ulong mem_ref, mem_end;
     int64_t val;
+    CPU_LDoubleU temp;
+
+    temp.d = ST0;
 
     val = floatx80_to_int64(ST0, &env->fp_status);
     mem_ref = ptr;
     mem_end = mem_ref + 9;
-    if (val < 0) {
+    if (SIGND(temp)) {
         cpu_stb_data_ra(env, mem_end, 0x80, GETPC());
         val = -val;
     } else {
diff --git a/tests/tcg/i386/test-i386-fbstp.c b/tests/tcg/i386/test-i386-fbstp.c
new file mode 100644
index 0000000000..d368949188
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fbstp.c
@@ -0,0 +1,25 @@
+/* Test fbstp instruction.  */
+
+#include <stdio.h>
+#include <string.h>
+
+int main(void)
+{
+    int ret = 0;
+    unsigned char out[10];
+    memset(out, 0xfe, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-0.0L) : "st");
+    out[9] &= 0x80;
+    if (memcmp(out, "\0\0\0\0\0\0\0\0\0\x80", sizeof out) != 0) {
+        printf("FAIL: fbstp -0\n");
+        ret = 1;
+    }
+    memset(out, 0x12, sizeof out);
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-0.1L) : "st");
+    out[9] &= 0x80;
+    if (memcmp(out, "\0\0\0\0\0\0\0\0\0\x80", sizeof out) != 0) {
+        printf("FAIL: fbstp -0.1\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com


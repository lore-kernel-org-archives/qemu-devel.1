Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD39C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAFF2072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0oqySV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAFF2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isEGZ-0003bf-Rk
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFV-0002fi-Uo
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFU-00083V-JX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:25 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isEFU-000830-E8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:24 -0500
Received: by mail-pj1-x1044.google.com with SMTP id l35so2386452pje.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=stg+e2AWftdtGimCGELoLi5XJTSvE6Z/YM/75Jku7WI=;
 b=D0oqySV8LJ8grKcCh5HHIZ2ipDkwodX3bQlK0laaOctxQ5U6BqQZZfzXITL5mrT5j1
 ASlEjCj2DoEt0Lu7mEyZZDidGEglfh13jp7Lz+1qf225Js5Y9R3ALB1/1ltt5YQNXoQB
 N8dUvS+IE55tpw0oU9A5qr2hCKu1QrSyTIEyb/gEdW+zSMCIJzkssmWqm89tZmInJuw8
 5GUSj5o9Zx4PK6B47VYrZw0cqQvXHjnarD/vsXpYfegdCmux+D4p0zn+uPJDBFZJ/EU4
 ViDct44a411BXPH/N5On/yMuwTK6k6xhkEx18FfJ/kuRKN6y42ji448RBvwLD7ARnTV3
 D2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=stg+e2AWftdtGimCGELoLi5XJTSvE6Z/YM/75Jku7WI=;
 b=NXfdL/LTGRJchHHQDKW48wWa8nI+towV2DZaulWuEsR0W+F+Xwok6/sctGohrYsPXD
 MyJsvDD3PsujmQ/XivYtj0BGSeYT2mvqyZ6NLOdB3p56F8aY9Susbkym3tiLDGvoFHcO
 ZdmNEkwYmI2pofVN+YV7PyP/mKsMrlHWDuRA8b59nqYPApSNVNvsEiYaiV737GB6Nx3q
 11hDkSVSkyvIgcMi6+cAvzJWC/OBBX2RPCGTef1qxnP9D1jAMOS2ThVrtIwDiTblXP7P
 Eoy6Dkb0Wmkp03R9Ojp5pX5PDQQxS8CMEWfE+ytuA50L1Nad/qM1fYBy6xbEHAGpI2zW
 X0pQ==
X-Gm-Message-State: APjAAAXgCkGbSxsdd8JG3+O/rWtDxnSLAkYS716UXiyjj9qLKRAo/h8M
 LSMHEAAE3EEgOWYGBlitWAgl7wYovNQ=
X-Google-Smtp-Source: APXvYqwzbTV0eZ0wMahPSoFM7fxp8Iq9TwQet1uF7AvOKQTxheDl7XpaRv/NbcA4RFXQWx6V/UL1/A==
X-Received: by 2002:a17:90b:258:: with SMTP id
 fz24mr2002106pjb.6.1579216103138; 
 Thu, 16 Jan 2020 15:08:23 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s7sm5111578pjk.22.2020.01.16.15.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 15:08:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tests/tcg/aarch64: Add pauth-3
Date: Thu, 16 Jan 2020 13:08:08 -1000
Message-Id: <20200116230809.19078-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116230809.19078-1-richard.henderson@linaro.org>
References: <20200116230809.19078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the test vector from the QARMA paper, run through PACGA.

Suggested-by: Vincent Dehors <vincent.dehors@smile.fr>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/system/pauth-3.c        | 40 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  5 ++-
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/system/pauth-3.c

diff --git a/tests/tcg/aarch64/system/pauth-3.c b/tests/tcg/aarch64/system/pauth-3.c
new file mode 100644
index 0000000000..42eff4d5ea
--- /dev/null
+++ b/tests/tcg/aarch64/system/pauth-3.c
@@ -0,0 +1,40 @@
+#include <inttypes.h>
+#include <minilib.h>
+
+int main()
+{
+    /*
+     * Test vector from QARMA paper (https://eprint.iacr.org/2016/444.pdf)
+     * to verify one computation of the pauth_computepac() function,
+     * which uses sbox2.
+     *
+     * Use PACGA, because it returns the most bits from ComputePAC.
+     * We still only get the most significant 32-bits of the result.
+     */
+
+    static const uint64_t d[5] = {
+        0xfb623599da6e8127ull,
+        0x477d469dec0b8762ull,
+        0x84be85ce9804e94bull,
+        0xec2802d4e0a488e9ull,
+        0xc003b93999b33765ull & 0xffffffff00000000ull
+    };
+    uint64_t r;
+
+    asm("msr apgakeyhi_el1, %[w0]\n\t"
+        "msr apgakeylo_el1, %[k0]\n\t"
+        "pacga %[r], %[P], %[T]"
+        : [r] "=r"(r)
+        : [P] "r" (d[0]),
+          [T] "r" (d[1]),
+          [w0] "r" (d[2]),
+          [k0] "r" (d[3]));
+
+    if (r == d[4]) {
+        ml_printf("OK\n");
+        return 0;
+    } else {
+        ml_printf("FAIL: %lx != %lx\n", r, d[4]);
+        return 1;
+    }
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 7b4eede3f0..f6b5121f5c 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -61,4 +61,7 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-EXTRA_TESTS+=memory-record memory-replay
+run-pauth-3: pauth-3
+pauth-3: CFLAGS += -march=armv8.3-a
+
+EXTRA_TESTS+=memory-record memory-replay pauth-3
-- 
2.20.1



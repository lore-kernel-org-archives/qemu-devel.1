Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9761C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34AD21848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="HqR67s9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34AD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfyg-0005Ef-PE
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iFfxN-0004Oq-Pk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iFfxM-000763-LD
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:50:21 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:35944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iFfxM-00072S-EX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:50:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1570027819; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
 Date: Subject: Cc: To: From: Sender;
 bh=EHhfHLVDFb0Ou/NSqI45n9804z/nKay+LpZFpt/Dpv0=;
 b=HqR67s9boOXw3RHABao3DjdXuhIE7958gwey/qfghspf/GlZfsdis2O4vU4RTJ0DBl27k8jY
 vsJ6x7akrwUGGlmkqQ3SFjatR/5PU1F9g1J0NzovoUv4A3cPEIjySOPK/2slOFDRimvrIXOc
 2hdMHS+D//R68g8hvxGBYej2ZXJK1sKayo5Vv6Uz0Z+xLrtXNl6ktTYvSScAivOWbi+/OE/w
 lWIT1eRe8zJn59mpll79wdcTfs4fdZo6Je2r7wYgtetYevrl/hbYIWTjdxg+VsObYx6IZIbT
 oX5E4Pqp6OwV00tDPjjzb7/2XXU6hDzvLu6iv+Qcus7966acfxIcsw==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.csail.mit.edu
 (30-10-182.wireless.csail.mit.edu [128.30.10.182])
 by mxa.mailgun.org with ESMTP id 5d94b926.7f3c59b89e90-smtp-out-n04;
 Wed, 02 Oct 2019 14:50:14 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH] target/riscv: Expose "priv" register for GDB
Date: Wed,  2 Oct 2019 10:48:59 -0400
Message-Id: <20191002144859.18208-1-jonathan@fintelia.io>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch enables a debugger to read and write the current privilege level via
a special "priv" register. When compiled with CONFIG_USER_ONLY the register is
still visible but is hardwired to zero.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
---
 gdb-xml/riscv-32bit-cpu.xml |  1 +
 gdb-xml/riscv-64bit-cpu.xml |  1 +
 target/riscv/cpu.c          |  2 +-
 target/riscv/gdbstub.c      | 14 ++++++++++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/gdb-xml/riscv-32bit-cpu.xml b/gdb-xml/riscv-32bit-cpu.xml
index 0d07aaec85..d6d76aafd8 100644
--- a/gdb-xml/riscv-32bit-cpu.xml
+++ b/gdb-xml/riscv-32bit-cpu.xml
@@ -44,4 +44,5 @@
   <reg name="t5" bitsize="32" type="int"/>
   <reg name="t6" bitsize="32" type="int"/>
   <reg name="pc" bitsize="32" type="code_ptr"/>
+  <reg name="priv" bitsize="32" type="int"/>
 </feature>
diff --git a/gdb-xml/riscv-64bit-cpu.xml b/gdb-xml/riscv-64bit-cpu.xml
index b8aa424ae4..0758d1b5fe 100644
--- a/gdb-xml/riscv-64bit-cpu.xml
+++ b/gdb-xml/riscv-64bit-cpu.xml
@@ -44,4 +44,5 @@
   <reg name="t5" bitsize="64" type="int"/>
   <reg name="t6" bitsize="64" type="int"/>
   <reg name="pc" bitsize="64" type="code_ptr"/>
+  <reg name="priv" bitsize="64" type="int" />
 </feature>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f13e298a36..347989858f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -475,7 +475,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->synchronize_from_tb = riscv_cpu_synchronize_from_tb;
     cc->gdb_read_register = riscv_cpu_gdb_read_register;
     cc->gdb_write_register = riscv_cpu_gdb_write_register;
-    cc->gdb_num_core_regs = 33;
+    cc->gdb_num_core_regs = 34;
 #if defined(TARGET_RISCV32)
     cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
 #elif defined(TARGET_RISCV64)
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index ded140e8d8..dc8cb4d26c 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -278,6 +278,12 @@ int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         return gdb_get_regl(mem_buf, env->gpr[n]);
     } else if (n == 32) {
         return gdb_get_regl(mem_buf, env->pc);
+    } else if (n == 33) {
+#ifdef CONFIG_USER_ONLY
+        return gdb_get_regl(mem_buf, 0);
+#else
+        return gdb_get_regl(mem_buf, env->priv);
+#endif
     }
     return 0;
 }
@@ -296,6 +302,14 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else if (n == 32) {
         env->pc = ldtul_p(mem_buf);
         return sizeof(target_ulong);
+    } else if (n == 33) {
+#ifndef CONFIG_USER_ONLY
+        env->priv = ldtul_p(mem_buf) & 0x3;
+        if (env->priv == 2) {
+            env->priv = 1;
+        }
+#endif
+        return sizeof(target_ulong);
     }
     return 0;
 }
-- 
2.23.0


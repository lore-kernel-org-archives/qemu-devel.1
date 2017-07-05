Received: from eggs.gnu.org ([2001:4830:134:3::10]:46711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWv-0004pA-Vt
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWv-0007lo-1R
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:21 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWu-0007lY-Rv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:20 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so30408742wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:20 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:28 +0200
Message-Id: <1499238885-26161-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/42] vl: convert -tb-size to qemu_strtoul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c    | 2 +-
 include/sysemu/accel.h | 2 +-
 vl.c                   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index dba9931..e327d90 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,7 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qom/object.h"
 
-int tcg_tb_size;
+unsigned long tcg_tb_size;
 static bool tcg_allowed = true;
 
 static int tcg_init(MachineState *ms)
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index ecc5c84..5a632ce 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -63,7 +63,7 @@ typedef struct AccelClass {
 #define ACCEL_GET_CLASS(obj) \
     OBJECT_GET_CLASS(AccelClass, (obj), TYPE_ACCEL)
 
-extern int tcg_tb_size;
+extern unsigned long tcg_tb_size;
 
 void configure_accelerator(MachineState *ms);
 /* Register accelerator specific global properties */
diff --git a/vl.c b/vl.c
index 36ff3f4..ea8ef5f 100644
--- a/vl.c
+++ b/vl.c
@@ -3933,9 +3933,9 @@ int main(int argc, char **argv, char **envp)
                 configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
-                tcg_tb_size = strtol(optarg, NULL, 0);
-                if (tcg_tb_size < 0) {
-                    tcg_tb_size = 0;
+                if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
+                    error_report("Invalid argument to -tb-size");
+                    exit(1);
                 }
                 break;
             case QEMU_OPTION_icount:
-- 
1.8.3.1

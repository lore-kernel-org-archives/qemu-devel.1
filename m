Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLq-0008Vv-C6
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLp-0001ck-Gb
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:14583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyLp-0001cL-6i
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:05 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:10 +0800
Message-Id: <1499076743-15477-3-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 02/15] vl: add tcg_enabled() for tcg related
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Need to disable the tcg related code in the vl.c if the
disable-tcg option is added into ./configure command.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 accel/tcg/tcg-all.c    |  2 +-
 include/sysemu/accel.h |  2 +-
 vl.c                   | 15 +++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index dba9931..b86c896 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,7 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qom/object.h"
 
-int tcg_tb_size;
+long tcg_tb_size;
 static bool tcg_allowed = true;
 
 static int tcg_init(MachineState *ms)
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index ecc5c84..7b905b7 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -63,7 +63,7 @@ typedef struct AccelClass {
 #define ACCEL_GET_CLASS(obj) \
     OBJECT_GET_CLASS(AccelClass, (obj), TYPE_ACCEL)
 
-extern int tcg_tb_size;
+extern long tcg_tb_size;
 
 void configure_accelerator(MachineState *ms);
 /* Register accelerator specific global properties */
diff --git a/vl.c b/vl.c
index 36ff3f4..f28c1ac 100644
--- a/vl.c
+++ b/vl.c
@@ -3933,9 +3933,14 @@ int main(int argc, char **argv, char **envp)
                 configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
-                tcg_tb_size = strtol(optarg, NULL, 0);
-                if (tcg_tb_size < 0) {
-                    tcg_tb_size = 0;
+                if (tcg_enabled()) {
+                    qemu_strtol(optarg, NULL, 0, &tcg_tb_size);
+                    if (tcg_tb_size < 0) {
+                        tcg_tb_size = 0;
+                    }
+                } else {
+                    error_report("TCG is disabled");
+                    exit(1);
                 }
                 break;
             case QEMU_OPTION_icount:
@@ -4481,7 +4486,9 @@ int main(int argc, char **argv, char **envp)
         qemu_opts_del(icount_opts);
     }
 
-    qemu_tcg_configure(accel_opts, &error_fatal);
+    if (tcg_enabled()) {
+        qemu_tcg_configure(accel_opts, &error_fatal);
+    }
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.9.1

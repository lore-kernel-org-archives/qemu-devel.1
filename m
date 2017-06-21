Received: from eggs.gnu.org ([2001:4830:134:3::10]:55702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckJ-0002P5-Nn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckI-00051R-BG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckI-0004zB-1d
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:22 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:48 +0800
Message-Id: <1498040401-16361-3-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 02/15] vl: add CONFIG_TCG for tcg related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Need to disable the tcg related code in the vl.c if the
disable-tcg option is added into ./configure command.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 cpus.c |  3 ++-
 vl.c   | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 14bb8d5..a86ea10 100644
--- a/cpus.c
+++ b/cpus.c
@@ -170,7 +170,7 @@ bool mttcg_enabled;
  * implicit memory order requirements which would likely slow things
  * down a lot.
  */
-
+#ifdef CONFIG_TCG
 static bool check_tcg_memory_orders_compatible(void)
 {
 #if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
@@ -223,6 +223,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
         mttcg_enabled = default_mttcg_enabled();
     }
 }
+#endif
 
 /* The current number of executed instructions is based on what we
  * originally budgeted minus the current state of the decrementing
diff --git a/vl.c b/vl.c
index 59fea15..a01faf9 100644
--- a/vl.c
+++ b/vl.c
@@ -3738,8 +3738,13 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
              case QEMU_OPTION_no_kvm:
+#ifdef CONFIG_TCG
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=tcg", false);
+#else
+                error_report("TCG is disabled");
+                exit(1);
+#endif
                 break;
             case QEMU_OPTION_no_kvm_pit: {
                 error_report("warning: ignoring deprecated option");
@@ -3915,10 +3920,15 @@ int main(int argc, char **argv, char **envp)
                 configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
+#ifdef CONFIG_TCG
                 tcg_tb_size = strtol(optarg, NULL, 0);
                 if (tcg_tb_size < 0) {
                     tcg_tb_size = 0;
                 }
+#else
+                error_report("TCG is disabled");
+                exit(1);
+#endif
                 break;
             case QEMU_OPTION_icount:
                 icount_opts = qemu_opts_parse_noisily(qemu_find_opts("icount"),
@@ -4457,7 +4467,9 @@ int main(int argc, char **argv, char **envp)
         qemu_opts_del(icount_opts);
     }
 
+#ifdef CONFIG_TCG
     qemu_tcg_configure(accel_opts, &error_fatal);
+#endif
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.9.1

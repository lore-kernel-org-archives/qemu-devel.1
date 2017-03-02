Received: from eggs.gnu.org ([2001:4830:134:3::10]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnG-0007xC-Nt
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnE-0002Sv-T2
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:42 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnE-0002Rr-Mc
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:40 -0500
Received: by mail-wm0-x233.google.com with SMTP id 196so4752098wmm.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:38 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:27 +0000
Message-Id: <20170302195337.31558-2-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/11] vl/cpus: be smarter with icount and
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

The sense of the test was inverted. Make it simple, if icount is
enabled then we disabled MTTCG by default. If the user tries to force
MTTCG upon us then we tell them "no".

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 cpus.c | 7 +++----
 vl.c   | 7 ++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/cpus.c b/cpus.c
index 8200ac6b75..e9aab9f70f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -185,10 +185,7 @@ static bool check_tcg_memory_orders_compatible(void)
 
 static bool default_mttcg_enabled(void)
 {
-    QemuOpts *icount_opts = qemu_find_opts_singleton("icount");
-    const char *rr = qemu_opt_get(icount_opts, "rr");
-
-    if (rr || TCG_OVERSIZED_GUEST) {
+    if (use_icount || TCG_OVERSIZED_GUEST) {
         return false;
     } else {
 #ifdef TARGET_SUPPORTS_MTTCG
@@ -206,6 +203,8 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
         if (strcmp(t, "multi") == 0) {
             if (TCG_OVERSIZED_GUEST) {
                 error_setg(errp, "No MTTCG when guest word size > hosts");
+            } else if (use_icount) {
+                error_setg(errp, "No MTTCG when icount is enabled");
             } else {
                 if (!check_tcg_memory_orders_compatible()) {
                     error_report("Guest expects a stronger memory ordering "
diff --git a/vl.c b/vl.c
index e10a27bdd6..bbbf1baadf 100644
--- a/vl.c
+++ b/vl.c
@@ -4025,8 +4025,6 @@ int main(int argc, char **argv, char **envp)
 
     replay_configure(icount_opts);
 
-    qemu_tcg_configure(accel_opts, &error_fatal);
-
     machine_class = select_machine();
 
     set_memory_options(&ram_slots, &maxram_size, machine_class);
@@ -4393,14 +4391,13 @@ int main(int argc, char **argv, char **envp)
         if (!tcg_enabled()) {
             error_report("-icount is not allowed with hardware virtualization");
             exit(1);
-        } else if (qemu_tcg_mttcg_enabled()) {
-            error_report("-icount does not currently work with MTTCG");
-            exit(1);
         }
         configure_icount(icount_opts, &error_abort);
         qemu_opts_del(icount_opts);
     }
 
+    qemu_tcg_configure(accel_opts, &error_fatal);
+
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
         qemu_opts_set(net, NULL, "type", "nic", &error_abort);
-- 
2.11.0

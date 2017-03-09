Received: from eggs.gnu.org ([2001:4830:134:3::10]:54393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4G-0005AJ-R8
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4C-0006SR-DM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:12 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clw4C-0006Rl-6y
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:08 -0500
Received: by mail-wm0-x229.google.com with SMTP id v186so136671760wmd.0
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:17:06 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Mar 2017 11:17:04 +0000
Message-Id: <20170309111714.20394-2-alex.bennee@linaro.org>
In-Reply-To: <20170309111714.20394-1-alex.bennee@linaro.org>
References: <20170309111714.20394-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/11] vl/cpus: be smarter with icount and MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

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
index c857ad2957..6a817fec13 100644
--- a/cpus.c
+++ b/cpus.c
@@ -181,10 +181,7 @@ static bool check_tcg_memory_orders_compatible(void)
 
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
@@ -202,6 +199,8 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
         if (strcmp(t, "multi") == 0) {
             if (TCG_OVERSIZED_GUEST) {
                 error_setg(errp, "No MTTCG when guest word size > hosts");
+            } else if (use_icount) {
+                error_setg(errp, "No MTTCG when icount is enabled");
             } else {
                 if (!check_tcg_memory_orders_compatible()) {
                     error_report("Guest expects a stronger memory ordering "
diff --git a/vl.c b/vl.c
index 7f1644a2be..1a95500ac7 100644
--- a/vl.c
+++ b/vl.c
@@ -4055,8 +4055,6 @@ int main(int argc, char **argv, char **envp)
 
     replay_configure(icount_opts);
 
-    qemu_tcg_configure(accel_opts, &error_fatal);
-
     machine_class = select_machine();
 
     set_memory_options(&ram_slots, &maxram_size, machine_class);
@@ -4423,14 +4421,13 @@ int main(int argc, char **argv, char **envp)
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

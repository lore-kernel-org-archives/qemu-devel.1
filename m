Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMy-0003e9-2j
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMv-0002mj-9j
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:16 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cijMv-0002mM-3b
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:13 -0500
Received: by mail-wm0-x22d.google.com with SMTP id i17so3363544wmf.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:07:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Feb 2017 15:07:07 +0000
Message-Id: <20170228150709.27453-2-alex.bennee@linaro.org>
In-Reply-To: <20170228150709.27453-1-alex.bennee@linaro.org>
References: <20170228150709.27453-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/3] vl/cpus: be smarter with icount and
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

The sense of the test was inverted. Make it simple, if icount is
enabled then we disabled MTTCG by default. If the user tries to force
MTTCG upon us then we tell them "no".

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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

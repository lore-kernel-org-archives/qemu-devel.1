Received: from eggs.gnu.org ([2001:4830:134:3::10]:34208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csmcA-0008GY-IG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csmc9-00015z-Fs
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:30 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csmc9-00015R-AN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:36:29 -0400
Received: by mail-wr0-x232.google.com with SMTP id l43so92602043wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 01:36:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 09:36:21 +0100
Message-Id: <20170328083623.10396-5-alex.bennee@linaro.org>
In-Reply-To: <20170328083623.10396-1-alex.bennee@linaro.org>
References: <20170328083623.10396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/6] ui/console: use exclusive mechanism
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The previous commit (8bb93c6f99) using async_safe_run_on_cpu() doesn't
work on graphics sub-system which restrict which threads can do GUI
updates. Rather the special casing MacOS we just directly call the
helper and move all the exclusive handling into do_dafe_dpy_refresh().

The unfortunate bouncing of the BQL is to ensure there is no deadlock
as vCPUs waiting on the BQL are kicked into their quiescent state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 ui/console.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index dd27c9501b..419b098c11 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1576,19 +1576,22 @@ bool dpy_gfx_check_format(QemuConsole *con,
 }
 
 /*
- * Safe DPY refresh for TCG guests. This runs when the TCG vCPUs are
- * quiescent so we can avoid races between dirty page tracking for
- * direct frame-buffer access by the guest.
+ * Safe DPY refresh for TCG guests. We use the exclusive mechanism to
+ * ensure the TCG vCPUs are quiescent so we can avoid races between
+ * dirty page tracking for direct frame-buffer access by the guest.
  *
  * This is a temporary stopgap until we've fixed the dirty tracking
  * races in display adapters.
  */
-static void do_safe_dpy_refresh(CPUState *cpu, run_on_cpu_data opaque)
+static void do_safe_dpy_refresh(DisplayChangeListener *dcl)
 {
-    DisplayChangeListener *dcl = opaque.host_ptr;
+    qemu_mutex_unlock_iothread();
+    start_exclusive();
     qemu_mutex_lock_iothread();
     dcl->ops->dpy_refresh(dcl);
     qemu_mutex_unlock_iothread();
+    end_exclusive();
+    qemu_mutex_lock_iothread();
 }
 
 static void dpy_refresh(DisplayState *s)
@@ -1598,8 +1601,7 @@ static void dpy_refresh(DisplayState *s)
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (dcl->ops->dpy_refresh) {
             if (tcg_enabled()) {
-                async_safe_run_on_cpu(first_cpu, do_safe_dpy_refresh,
-                                      RUN_ON_CPU_HOST_PTR(dcl));
+                do_safe_dpy_refresh(dcl);
             } else {
                 dcl->ops->dpy_refresh(dcl);
             }
-- 
2.11.0

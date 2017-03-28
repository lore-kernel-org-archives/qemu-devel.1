Received: from eggs.gnu.org ([2001:4830:134:3::10]:48418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-0004Gw-3y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0Q-00037y-GE
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0Q-00037S-9p
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:42 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l43so98994392wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:34 +0100
Message-Id: <20170328110936.24806-5-alex.bennee@linaro.org>
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/6] ui/console: use exclusive mechanism directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

The previous commit (8bb93c6f99) using async_safe_run_on_cpu() doesn't
work on graphics sub-system which restrict which threads can do GUI
updates. Rather the special casing MacOS we just directly call the
helper and move all the exclusive handling into do_dafe_dpy_refresh().

The unfortunate bouncing of the BQL is to ensure there is no deadlock
as vCPUs waiting on the BQL are kicked into their quiescent state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
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

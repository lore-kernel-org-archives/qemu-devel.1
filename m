Received: from eggs.gnu.org ([2001:4830:134:3::10]:46300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coADz-0002rS-3Y
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coADv-0004lA-6X
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:48:27 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coADu-0004kI-V4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:48:23 -0400
Received: by mail-wr0-x233.google.com with SMTP id l37so12665396wrc.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:48:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 15 Mar 2017 14:48:25 +0000
Message-Id: <20170315144825.3108-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] ui/console: ensure graphic updates don't
 race with TCG vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Commit 8d04fb55..

  tcg: drop global lock during TCG code execution

..broke the assumption that updates to the GUI couldn't happen at the
same time as TCG vCPUs where running. As a result the TCG vCPU could
still be updating a directly mapped frame-buffer while the display
side was updating. This would cause artefacts to appear when the
update code assumed that memory block hadn't changed.

The simplest solution is to ensure the two things can't happen at the
same time like the old BQL locking scheme. Here we use the solution
introduced for MTTCG and schedule the update as async_safe_work when
we know no vCPUs can be running.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 ui/console.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index d1ff7504ec..37a69e27de 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1575,13 +1575,29 @@ bool dpy_gfx_check_format(QemuConsole *con,
     return true;
 }
 
+/*
+ * Safe DPY refresh for TCG guests. This runs when the TCG vCPUs are
+ * quiescent so we can avoid races between dirty page tracking for
+ * direct frame-buffer access by the guest.
+ */
+static void do_safe_dpy_refresh(CPUState *cpu, run_on_cpu_data opaque)
+{
+    DisplayChangeListener *dcl = opaque.host_ptr;
+    dcl->ops->dpy_refresh(dcl);
+}
+
 static void dpy_refresh(DisplayState *s)
 {
     DisplayChangeListener *dcl;
 
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (dcl->ops->dpy_refresh) {
-            dcl->ops->dpy_refresh(dcl);
+            if (tcg_enabled()) {
+                async_safe_run_on_cpu(first_cpu, do_safe_dpy_refresh,
+                                      RUN_ON_CPU_HOST_PTR(dcl));
+            } else {
+                dcl->ops->dpy_refresh(dcl);
+            }
         }
     }
 }
-- 
2.11.0

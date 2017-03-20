Received: from eggs.gnu.org ([2001:4830:134:3::10]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5W-0003Cd-Eo
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5T-0000Gj-Al
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpt5T-0000GQ-2I
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:47 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 09:54:36 +0100
Message-Id: <1490000078-31202-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
References: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 1/3] ui/console: ensure graphic updates
 don't race with TCG vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-id: 20170315144825.3108-1-alex.bennee@linaro.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

[ kraxel: updated comment clarifying the display adapters are buggy
          and this is a temporary workaround ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index 4c70d8b..937c950 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1575,13 +1575,32 @@ bool dpy_gfx_check_format(QemuConsole *con,
     return true;
 }
=20
+/*
+ * Safe DPY refresh for TCG guests. This runs when the TCG vCPUs are
+ * quiescent so we can avoid races between dirty page tracking for
+ * direct frame-buffer access by the guest.
+ *
+ * This is a temporary stopgap until we've fixed the dirty tracking
+ * races in display adapters.
+ */
+static void do_safe_dpy_refresh(CPUState *cpu, run_on_cpu_data opaque)
+{
+    DisplayChangeListener *dcl =3D opaque.host_ptr;
+    dcl->ops->dpy_refresh(dcl);
+}
+
 static void dpy_refresh(DisplayState *s)
 {
     DisplayChangeListener *dcl;
=20
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
--=20
1.8.3.1

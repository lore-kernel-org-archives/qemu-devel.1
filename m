Received: from eggs.gnu.org ([209.51.188.92]:51628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd4C-0001xE-Bm
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd4A-00050y-Mz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmd4A-00050G-HL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 12:20:53 +0100
Message-Id: <20190124112055.547-5-kraxel@redhat.com>
In-Reply-To: <20190124112055.547-1-kraxel@redhat.com>
References: <20190124112055.547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/6] audio: check for pulseaudio daemon
 pidfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Check whenever the pulseaudio daemon pidfile is present before trying to
initialize the pulseaudio backend.  Just return NULL if that is not the
case, so qemu will check the next backend in line.

In case the user explicitly configured a non-default pulseaudio server
skip the check.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 4c100bc318..6153b908da 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -814,6 +814,21 @@ static PAConf glob_conf = {
 
 static void *qpa_audio_init (void)
 {
+    if (glob_conf.server == NULL) {
+        char pidfile[64];
+        char *runtime;
+        struct stat st;
+
+        runtime = getenv("XDG_RUNTIME_DIR");
+        if (!runtime) {
+            return NULL;
+        }
+        snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
+        if (stat(pidfile, &st) != 0) {
+            return NULL;
+        }
+    }
+
     paaudio *g = g_malloc(sizeof(paaudio));
     g->conf = glob_conf;
     g->mainloop = NULL;
-- 
2.9.3

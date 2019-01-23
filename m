Received: from eggs.gnu.org ([209.51.188.92]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDSf-0003dq-L6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDSZ-0000Ca-Jq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmDSZ-00004z-Cx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:31 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Jan 2019 09:00:02 +0100
Message-Id: <20190123080005.31078-2-kraxel@redhat.com>
In-Reply-To: <20190123080005.31078-1-kraxel@redhat.com>
References: <20190123080005.31078-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] audio: use pkg-config
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

Use pkg-config to probe for alsa and pulseaudio.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/configure b/configure
index 3eee3fcf70..bdb80f8cb1 100755
--- a/configure
+++ b/configure
@@ -3297,39 +3297,26 @@ fi
 ##########################################
 # Sound support libraries probe
 
-audio_drv_probe()
-{
-    drv=$1
-    hdr=$2
-    lib=$3
-    exp=$4
-    cfl=$5
-        cat > $TMPC << EOF
-#include <$hdr>
-int main(void) { $exp }
-EOF
-    if compile_prog "$cfl" "$lib" ; then
-        :
-    else
-        error_exit "$drv check failed" \
-            "Make sure to have the $drv libs and headers installed."
-    fi
-}
-
 audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/,/ /g')
 for drv in $audio_drv_list; do
     case $drv in
     alsa)
-    audio_drv_probe $drv alsa/asoundlib.h -lasound \
-        "return snd_pcm_close((snd_pcm_t *)0);"
-    alsa_libs="-lasound"
+    if $pkg_config alsa --exists; then
+        alsa_libs=$($pkg_config alsa --libs)
+    else
+        error_exit "$drv check failed" \
+            "Make sure to have the $drv libs and headers installed."
+    fi
     ;;
 
     pa)
-    audio_drv_probe $drv pulse/pulseaudio.h "-lpulse" \
-        "pa_context_set_source_output_volume(NULL, 0, NULL, NULL, NULL); return 0;"
-    pulse_libs="-lpulse"
-    audio_pt_int="yes"
+    if $pkg_config libpulse --exists; then
+        pulse_libs=$($pkg_config libpulse --libs)
+        audio_pt_int="yes"
+    else
+        error_exit "$drv check failed" \
+            "Make sure to have the $drv libs and headers installed."
+    fi
     ;;
 
     sdl)
-- 
2.9.3

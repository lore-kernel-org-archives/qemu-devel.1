Received: from eggs.gnu.org ([209.51.188.92]:54414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew1-00067m-4f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmevz-0007Tz-7W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmevx-0007Nq-6V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 14:20:15 +0100
Message-Id: <20190124132020.13571-3-kraxel@redhat.com>
In-Reply-To: <20190124132020.13571-1-kraxel@redhat.com>
References: <20190124132020.13571-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] audio: use pkg-config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>

Use pkg-config to probe for alsa and pulseaudio.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190124112055.547-2-kraxel@redhat.com
---
 configure | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/configure b/configure
index 8f312ac3e2..5fcd0f4795 100755
--- a/configure
+++ b/configure
@@ -3342,39 +3342,26 @@ fi
 ##########################################
 # Sound support libraries probe
=20
-audio_drv_probe()
-{
-    drv=3D$1
-    hdr=3D$2
-    lib=3D$3
-    exp=3D$4
-    cfl=3D$5
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
 audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/,/ /g')
 for drv in $audio_drv_list; do
     case $drv in
     alsa)
-    audio_drv_probe $drv alsa/asoundlib.h -lasound \
-        "return snd_pcm_close((snd_pcm_t *)0);"
-    alsa_libs=3D"-lasound"
+    if $pkg_config alsa --exists; then
+        alsa_libs=3D$($pkg_config alsa --libs)
+    else
+        error_exit "$drv check failed" \
+            "Make sure to have the $drv libs and headers installed."
+    fi
     ;;
=20
     pa)
-    audio_drv_probe $drv pulse/pulseaudio.h "-lpulse" \
-        "pa_context_set_source_output_volume(NULL, 0, NULL, NULL, NULL);=
 return 0;"
-    pulse_libs=3D"-lpulse"
-    audio_pt_int=3D"yes"
+    if $pkg_config libpulse --exists; then
+        pulse_libs=3D$($pkg_config libpulse --libs)
+        audio_pt_int=3D"yes"
+    else
+        error_exit "$drv check failed" \
+            "Make sure to have the $drv libs and headers installed."
+    fi
     ;;
=20
     sdl)
--=20
2.9.3

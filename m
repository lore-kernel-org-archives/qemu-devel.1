Received: from eggs.gnu.org ([209.51.188.92]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew7-0006CT-21
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew5-0007YD-3l
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmew1-0007Li-64
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:47 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 14:20:16 +0100
Message-Id: <20190124132020.13571-4-kraxel@redhat.com>
In-Reply-To: <20190124132020.13571-1-kraxel@redhat.com>
References: <20190124132020.13571-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] audio: allow optional audio drivers.
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

For those audio drivers which can be probed (sdl, alsa, pulse) add a
try-$name variants.  Unlike the variants without try- prefix they will
not error out on probe failure, the driver will be dropped from the list
instead.  Mainly useful for the audio_drv_list default values.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190124112055.547-3-kraxel@redhat.com
---
 configure | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 5fcd0f4795..6a2aa3b533 100755
--- a/configure
+++ b/configure
@@ -3345,22 +3345,36 @@ fi
 audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/,/ /g')
 for drv in $audio_drv_list; do
     case $drv in
-    alsa)
+    alsa | try-alsa)
     if $pkg_config alsa --exists; then
         alsa_libs=$($pkg_config alsa --libs)
+        if test "$drv" = "try-alsa"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-alsa/alsa/')
+        fi
     else
-        error_exit "$drv check failed" \
-            "Make sure to have the $drv libs and headers installed."
+        if test "$drv" = "try-alsa"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-alsa//')
+        else
+            error_exit "$drv check failed" \
+                "Make sure to have the $drv libs and headers installed."
+        fi
     fi
     ;;
 
-    pa)
+    pa | try-pa)
     if $pkg_config libpulse --exists; then
         pulse_libs=$($pkg_config libpulse --libs)
         audio_pt_int="yes"
+        if test "$drv" = "try-pa"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-pa/pa/')
+        fi
     else
-        error_exit "$drv check failed" \
-            "Make sure to have the $drv libs and headers installed."
+        if test "$drv" = "try-pa"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-pa//')
+        else
+            error_exit "$drv check failed" \
+                "Make sure to have the $drv libs and headers installed."
+        fi
     fi
     ;;
 
@@ -3370,6 +3384,14 @@ for drv in $audio_drv_list; do
     fi
     ;;
 
+    try-sdl)
+    if test "$sdl" = "no"; then
+        audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-sdl//')
+    else
+        audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-sdl/sdl/')
+    fi
+    ;;
+
     coreaudio)
       coreaudio_libs="-framework CoreAudio"
     ;;
-- 
2.9.3

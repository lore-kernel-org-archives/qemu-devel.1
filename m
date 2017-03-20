Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cptGH-0007DS-PR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cptGD-0004US-Rb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cptGD-0004U7-LW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 833A27F415
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 09:05:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 10:05:43 +0100
Message-Id: <1490000743-3615-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] audio: catch missing sdl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

sdl is probed before audio, so we can simply look at $sdl so see
whenever we have support or not.  Throw an error in case sdl audio
is requested without sdl being available.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 99d8bec..2d088c6 100755
--- a/configure
+++ b/configure
@@ -2894,6 +2894,12 @@ for drv in $audio_drv_list; do
     audio_pt_int="yes"
     ;;
 
+    sdl)
+    if test "$sdl" = "no"; then
+        error_exit "sdl not found or disabled, can not use sdl audio driver"
+    fi
+    ;;
+
     coreaudio)
       libs_softmmu="-framework CoreAudio $libs_softmmu"
     ;;
@@ -2907,8 +2913,8 @@ for drv in $audio_drv_list; do
       libs_softmmu="$oss_lib $libs_softmmu"
     ;;
 
-    sdl|wav)
-    # XXX: Probes for CoreAudio, DirectSound, SDL(?)
+    wav)
+    # XXX: Probes for CoreAudio, DirectSound
     ;;
 
     *)
-- 
1.8.3.1

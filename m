Received: from eggs.gnu.org ([2001:4830:134:3::10]:55773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz4-0005vz-VS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz3-0001fu-IO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fWJz3-0001fj-E5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:05 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Jun 2018 13:12:00 +0200
Message-Id: <20180622111200.30561-6-kraxel@redhat.com>
In-Reply-To: <20180622111200.30561-1-kraxel@redhat.com>
References: <20180622111200.30561-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/5] audio/hda: enable new timer code by
 default.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: martin@schrodt.org, maxehr@umiacs.umd.edu, Gerd Hoffmann <kraxel@redhat.com>

Also add a compat property to disable it for old machine types,
needed for live migration compatibility.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/compat.h  | 4 ++++
 hw/audio/hda-codec.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 563908b874..44d5964060 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -6,6 +6,10 @@
         .driver   = "migration",\
         .property = "decompress-error-check",\
         .value    = "off",\
+    },{\
+        .driver   = "hda-audio",\
+        .property = "use-timer",\
+        .value    = "false",\
     },
 
 #define HW_COMPAT_2_11 \
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index ac67b9aada..fc4945086b 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -839,7 +839,7 @@ static const VMStateDescription vmstate_hda_audio = {
 static Property hda_audio_properties[] = {
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
-    DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer, false),
+    DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.3

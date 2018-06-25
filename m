Received: from eggs.gnu.org ([2001:4830:134:3::10]:34149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIh-0008QK-NS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRId-0001XA-Qc
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXRId-0001W1-M9
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C169401C9AA
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 13:12:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 25 Jun 2018 15:12:52 +0200
Message-Id: <20180625131253.11218-6-kraxel@redhat.com>
In-Reply-To: <20180625131253.11218-1-kraxel@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] audio/hda: enable new timer code by default.
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

Also add a compat property to disable it for old machine types,
needed for live migration compatibility.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180622111200.30561-6-kraxel@redhat.com
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

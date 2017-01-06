Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWst-0004vI-BE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWss-0005Mf-IG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWss-0005M5-DX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7848681252
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:50 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:31 +0000
Message-Id: <20170106155543.12827-36-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 35/47] trace: switch audio/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the audio/ directory to include the
audio/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs       | 2 +-
 audio/Makefile.objs | 2 ++
 audio/alsaaudio.c   | 2 +-
 audio/ossaudio.c    | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 355cb78..dc3a51e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -153,7 +153,7 @@ trace-events-subdirs += hw/acpi
 trace-events-subdirs += hw/arm
 trace-events-subdirs += hw/alpha
 trace-events-subdirs += ui
-trace-events-y += audio/trace-events
+trace-events-subdirs += audio
 trace-events-y += net/trace-events
 trace-events-y += target/arm/trace-events
 trace-events-y += target/i386/trace-events
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index 481d1aa..4eef4b4 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -9,5 +9,7 @@ common-obj-$(CONFIG_PA) += paaudio.o
 common-obj-$(CONFIG_AUDIO_PT_INT) += audio_pt_int.o
 common-obj-$(CONFIG_AUDIO_WIN_INT) += audio_win_int.o
 common-obj-y += wavcapture.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 sdlaudio.o-cflags := $(SDL_CFLAGS)
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3652a7b..1111b71 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/main-loop.h"
 #include "audio.h"
-#include "trace.h"
+#include "audio/trace.h"
 
 #if QEMU_GNUC_PREREQ(4, 3)
 #pragma GCC diagnostic ignored "-Waddress"
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0edd7ea..c04da5e 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/host-utils.h"
 #include "audio.h"
-#include "trace.h"
+#include "audio/trace.h"
 
 #define AUDIO_CAP "oss"
 #include "audio_int.h"
-- 
2.9.3

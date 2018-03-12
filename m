Received: from eggs.gnu.org ([2001:4830:134:3::10]:41476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKur-00029r-VF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKuo-0000jL-S2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evKuo-0000iH-Ma
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 269CB401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:42:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:42:38 +0100
Message-Id: <20180312104241.24965-6-kraxel@redhat.com>
In-Reply-To: <20180312104241.24965-1-kraxel@redhat.com>
References: <20180312104241.24965-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] audio/alsa: build as module
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180306074053.22856-5-kraxel@redhat.com
---
 configure           | 7 ++++++-
 audio/Makefile.objs | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 973dbb99ac..b150ee80c6 100755
--- a/configure
+++ b/configure
@@ -5973,7 +5973,12 @@ fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
     def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
-    echo "$def=y" >> $config_host_mak
+    case "$drv" in
+	alsa)
+	    echo "$def=m" >> $config_host_mak ;;
+	*)
+	    echo "$def=y" >> $config_host_mak ;;
+    esac
 done
 echo "ALSA_LIBS=$alsa_libs" >> $config_host_mak
 echo "PULSE_LIBS=$pulse_libs" >> $config_host_mak
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index f6ce5c6744..97f22ec097 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -3,7 +3,6 @@ common-obj-$(CONFIG_AUDIO_SDL) += sdlaudio.o
 common-obj-$(CONFIG_AUDIO_OSS) += ossaudio.o
 common-obj-$(CONFIG_SPICE) += spiceaudio.o
 common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
-common-obj-$(CONFIG_AUDIO_ALSA) += alsaaudio.o
 common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
 common-obj-$(CONFIG_AUDIO_PA) += paaudio.o
 common-obj-$(CONFIG_AUDIO_PT_INT) += audio_pt_int.o
@@ -12,8 +11,12 @@ common-obj-y += wavcapture.o
 
 sdlaudio.o-cflags := $(SDL_CFLAGS)
 sdlaudio.o-libs := $(SDL_LIBS)
-alsaaudio.o-libs := $(ALSA_LIBS)
 paaudio.o-libs := $(PULSE_LIBS)
 coreaudio.o-libs := $(COREAUDIO_LIBS)
 dsoundaudio.o-libs := $(DSOUND_LIBS)
 ossaudio.o-libs := $(OSS_LIBS)
+
+# alsa module
+common-obj-$(CONFIG_AUDIO_ALSA) += alsa.mo
+alsa.mo-objs = alsaaudio.o
+alsa.mo-libs := $(ALSA_LIBS)
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBx-00070T-7O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBs-0001mx-Iq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBs-0001mn-Cl
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B5DD4E4F3
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:35 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:13 +0800
Message-Id: <20170907082918.7299-5-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/9] buildsys: Move audio libs to per object
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 audio/Makefile.objs |  5 +++++
 configure           | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index c20695668f..8a5ede6e2b 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -12,3 +12,8 @@ common-obj-y += wavcapture.o
 
 sdlaudio.o-cflags := $(SDL_CFLAGS)
 sdlaudio.o-libs := $(SDL_LIBS)
+alsaaudio.o-libs := $(ALSA_LIBS)
+paaudio.o-libs := $(PULSE_LIBS)
+coreaudio.o-libs := $(COREAUDIO_LIBS)
+dsoundaudio.o-libs := $(DSOUND_LIBS)
+ossaudio.o-libs := $(OSS_LIBS)
diff --git a/configure b/configure
index 9b0eb91a9b..71fa9717ff 100755
--- a/configure
+++ b/configure
@@ -3040,13 +3040,13 @@ for drv in $audio_drv_list; do
     alsa)
     audio_drv_probe $drv alsa/asoundlib.h -lasound \
         "return snd_pcm_close((snd_pcm_t *)0);"
-    libs_softmmu="-lasound $libs_softmmu"
+    alsa_libs="-lasound"
     ;;
 
     pa)
     audio_drv_probe $drv pulse/pulseaudio.h "-lpulse" \
         "pa_context_set_source_output_volume(NULL, 0, NULL, NULL, NULL); return 0;"
-    libs_softmmu="-lpulse $libs_softmmu"
+    pulse_libs="-lpulse"
     audio_pt_int="yes"
     ;;
 
@@ -3057,16 +3057,16 @@ for drv in $audio_drv_list; do
     ;;
 
     coreaudio)
-      libs_softmmu="-framework CoreAudio $libs_softmmu"
+      coreaudio_libs="-framework CoreAudio"
     ;;
 
     dsound)
-      libs_softmmu="-lole32 -ldxguid $libs_softmmu"
+      dsound_libs="-lole32 -ldxguid"
       audio_win_int="yes"
     ;;
 
     oss)
-      libs_softmmu="$oss_lib $libs_softmmu"
+      oss_libs="$oss_lib"
     ;;
 
     wav)
@@ -5548,6 +5548,11 @@ for drv in $audio_drv_list; do
     def=CONFIG_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
     echo "$def=y" >> $config_host_mak
 done
+echo "ALSA_LIBS=$alsa_libs" >> $config_host_mak
+echo "PULSE_LIBS=$pulse_libs" >> $config_host_mak
+echo "COREAUDIO_LIBS=$coreaudio_libs" >> $config_host_mak
+echo "DSOUND_LIBS=$dsound_libs" >> $config_host_mak
+echo "OSS_LIBS=$oss_libs" >> $config_host_mak
 if test "$audio_pt_int" = "yes" ; then
   echo "CONFIG_AUDIO_PT_INT=y" >> $config_host_mak
 fi
-- 
2.13.5

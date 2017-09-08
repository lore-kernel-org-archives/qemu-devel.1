Received: from eggs.gnu.org ([2001:4830:134:3::10]:42159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1L-0008VC-RZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1C-00055m-FI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG1C-000558-9Y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:59 +0800
Message-Id: <20170908095506.13594-32-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/38] buildsys: Move audio libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907082918.7299-5-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 audio/Makefile.objs |  5 +++++
 configure           | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index c20695668f..8a5ede6e2b 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -12,3 +12,8 @@ common-obj-y +=3D wavcapture.o
=20
 sdlaudio.o-cflags :=3D $(SDL_CFLAGS)
 sdlaudio.o-libs :=3D $(SDL_LIBS)
+alsaaudio.o-libs :=3D $(ALSA_LIBS)
+paaudio.o-libs :=3D $(PULSE_LIBS)
+coreaudio.o-libs :=3D $(COREAUDIO_LIBS)
+dsoundaudio.o-libs :=3D $(DSOUND_LIBS)
+ossaudio.o-libs :=3D $(OSS_LIBS)
diff --git a/configure b/configure
index 2b3db2f5c3..ddddfde599 100755
--- a/configure
+++ b/configure
@@ -3044,13 +3044,13 @@ for drv in $audio_drv_list; do
     alsa)
     audio_drv_probe $drv alsa/asoundlib.h -lasound \
         "return snd_pcm_close((snd_pcm_t *)0);"
-    libs_softmmu=3D"-lasound $libs_softmmu"
+    alsa_libs=3D"-lasound"
     ;;
=20
     pa)
     audio_drv_probe $drv pulse/pulseaudio.h "-lpulse" \
         "pa_context_set_source_output_volume(NULL, 0, NULL, NULL, NULL);=
 return 0;"
-    libs_softmmu=3D"-lpulse $libs_softmmu"
+    pulse_libs=3D"-lpulse"
     audio_pt_int=3D"yes"
     ;;
=20
@@ -3061,16 +3061,16 @@ for drv in $audio_drv_list; do
     ;;
=20
     coreaudio)
-      libs_softmmu=3D"-framework CoreAudio $libs_softmmu"
+      coreaudio_libs=3D"-framework CoreAudio"
     ;;
=20
     dsound)
-      libs_softmmu=3D"-lole32 -ldxguid $libs_softmmu"
+      dsound_libs=3D"-lole32 -ldxguid"
       audio_win_int=3D"yes"
     ;;
=20
     oss)
-      libs_softmmu=3D"$oss_lib $libs_softmmu"
+      oss_libs=3D"$oss_lib"
     ;;
=20
     wav)
@@ -5553,6 +5553,11 @@ for drv in $audio_drv_list; do
     def=3DCONFIG_$(echo $drv | LC_ALL=3DC tr '[a-z]' '[A-Z]')
     echo "$def=3Dy" >> $config_host_mak
 done
+echo "ALSA_LIBS=3D$alsa_libs" >> $config_host_mak
+echo "PULSE_LIBS=3D$pulse_libs" >> $config_host_mak
+echo "COREAUDIO_LIBS=3D$coreaudio_libs" >> $config_host_mak
+echo "DSOUND_LIBS=3D$dsound_libs" >> $config_host_mak
+echo "OSS_LIBS=3D$oss_libs" >> $config_host_mak
 if test "$audio_pt_int" =3D "yes" ; then
   echo "CONFIG_AUDIO_PT_INT=3Dy" >> $config_host_mak
 fi
--=20
2.13.5

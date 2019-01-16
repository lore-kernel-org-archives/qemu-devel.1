Received: from eggs.gnu.org ([209.51.188.92]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul9-0004RM-QT
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul6-0003YW-JA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul6-0003VH-6O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id d15so3886090wmb.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:38:08 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:20 +0100
Message-Id: <82a755097c6aaa16363348599110f9af3bb07583.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 47/50] paaudio: channel-map option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Add an option to change the channel map used by pulseaudio.  If not
specified, falls back to an OSS compatible channel map.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 qapi/audio.json |  5 ++++-
 audio/paaudio.c | 18 ++++++++++++++----
 qemu-options.hx |  9 +++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 7bcea6240f..86078039dc 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -107,11 +107,14 @@
 #
 # @name: name of the sink/source to use
 #
+# @channel-map: channel map to use (default: OSS compatible map)
+#
 # Since: 4.0
 ##
 { 'struct': 'AudiodevPaPerDirectionOptions',
   'data': {
-    '*name': 'str' } }
+    '*name':        'str',
+    '*channel-map': 'str' } }
 
 ##
 # @AudiodevPaOptions:
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 0d67c03b4c..b0e311584a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -337,17 +337,27 @@ static pa_stream *qpa_simple_new (
         pa_stream_direction_t dir,
         const char *dev,
         const pa_sample_spec *ss,
-        const pa_channel_map *map,
+        const char *map,
         const pa_buffer_attr *attr,
         int *rerror)
 {
     int r;
     pa_stream *stream;
     pa_stream_flags_t flags;
+    pa_channel_map pa_map;
 
     pa_threaded_mainloop_lock(c->mainloop);
 
-    stream = pa_stream_new(c->context, name, ss, map);
+    if (map && !pa_channel_map_parse(&pa_map, map)) {
+        dolog("Invalid channel map specified: '%s'\n", map);
+        map = NULL;
+    }
+    if (!map) {
+        pa_channel_map_init_extend(&pa_map, ss->channels,
+                                   PA_CHANNEL_MAP_OSS);
+    }
+
+    stream = pa_stream_new(c->context, name, ss, &pa_map);
     if (!stream) {
         goto fail;
     }
@@ -424,7 +434,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
+        ppdo->has_channel_map ? ppdo->channel_map : NULL,
         &ba,                    /* buffering attributes */
         &error
         );
@@ -472,7 +482,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
+        ppdo->has_channel_map ? ppdo->channel_map : NULL,
         NULL,                   /* buffering attributes */
         &error
         );
diff --git a/qemu-options.hx b/qemu-options.hx
index 53fc5ef453..c4835f77c3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -468,6 +468,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "-audiodev pa,id=id[,prop[=value][,...]]\n"
     "                server= PulseAudio server address\n"
     "                sink|source.name= sink/source device name\n"
+    "                sink|source.channel-map= channel map to use\n"
 #endif
 #ifdef CONFIG_SDL
     "-audiodev sdl,id=id[,prop[=value][,...]]\n"
@@ -621,6 +622,14 @@ Sets the PulseAudio @var{server} to connect to.
 @item sink|source.name=@var{sink}
 Use the specified sink/source for playback/recording.
 
+@item sink|source.channel-map=@var{map}
+Use the specified channel map.  The default is an OSS compatible
+channel map.  Do not forget to escape commas inside the map:
+
+@example
+-audiodev pa,id=example,sink.channel-map=front-left,,front-right
+@end example
+
 @end table
 
 @item -audiodev sdl,id=@var{id}[,@var{prop}[=@var{value}][,...]]
-- 
2.20.1

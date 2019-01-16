Received: from eggs.gnu.org ([209.51.188.92]:57765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukj-00042K-4H
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukf-0002nc-Cw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjuke-0002av-R4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so3893764wml.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:29 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:36 +0100
Message-Id: <bebb78b3870bfaf1314fa32be1c956b82dada319.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/50] audio: -audiodev command line option:
 documentation
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

This patch adds documentation of an -audiodev command line option, that
deprecates the old QEMU_* environment variables for audio backend
configuration.  It's syntax is similar to existing options (-netdev,
-device, etc):

  -audiodev driver_name,property=value,...

Although now it's possible to specify multiple -audiodev options on
command line, multiple audio backends are not supported yet.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 qemu-options.hx | 222 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 521511ec13..a12931899b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -416,14 +416,230 @@ The default is @code{en-us}.
 ETEXI
 
 
+HXCOMM Deprecated by -audiodev
 DEF("audio-help", 0, QEMU_OPTION_audio_help,
-    "-audio-help     print list of audio drivers and their options\n",
+    "-audio-help     show -audiodev equivalent of the currently specified audio settings\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -audio-help
 @findex -audio-help
-Will show the audio subsystem help: list of drivers, tunable
-parameters.
+Will show the -audiodev equivalent of the currently specified
+(deprecated) environment variables.
+ETEXI
+
+DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
+    "-audiodev [driver=]driver,id=id[,prop[=value][,...]]\n"
+    "                specifies the audio backend to use\n"
+    "                id= identifier of the backend\n"
+    "                timer-period= timer period in microseconds\n"
+    "                in|out.fixed-settings= use fixed settings for host audio\n"
+    "                in|out.frequency= frequency to use with fixed settings\n"
+    "                in|out.channels= number of channels to use with fixed settings\n"
+    "                in|out.format= sample format to use with fixed settings\n"
+    "                valid values: s8, s16, s32, u8, u16, u32\n"
+    "                in|out.voices= number of voices to use\n"
+    "                in|out.buffer-len= size of buffer in microseconds\n"
+    "                in|out.buffer-count= number of buffers\n"
+    "-audiodev none,id=id,[,prop[=value][,...]]\n"
+    "                dummy driver that discards all output\n"
+#ifdef CONFIG_ALSA
+    "-audiodev alsa,id=id[,prop[=value][,...]]\n"
+    "                alsa-in|alsa-out.dev= name of the audio device to use\n"
+    "                alsa-in|alsa-out.try-poll= attempt to use poll mode\n"
+    "                threshold= threshold (in microseconds) when playback starts\n"
+#endif
+#ifdef CONFIG_COREAUDIO
+    "-audiodev coreaudio,id=id[,prop[=value][,...]]\n"
+#endif
+#ifdef CONFIG_DSOUND
+    "-audiodev dsound,id=id[,prop[=value][,...]]\n"
+    "                latency= add extra latency to playback in microseconds\n"
+#endif
+#ifdef CONFIG_OSS
+    "-audiodev oss,id=id[,prop[=value][,...]]\n"
+    "                oss-in|oss-out.dev= path of the audio device to use\n"
+    "                oss-in|oss-out.try-poll= attempt to use poll mode\n"
+    "                try-mmap= try using memory mapped access\n"
+    "                exclusive= open device in exclusive mode\n"
+    "                dsp-policy= set timing policy (0..10), -1 to use fragment mode\n"
+#endif
+#ifdef CONFIG_PA
+    "-audiodev pa,id=id[,prop[=value][,...]]\n"
+    "                server= PulseAudio server address\n"
+    "                sink|source.name= sink/source device name\n"
+#endif
+#ifdef CONFIG_SDL
+    "-audiodev sdl,id=id[,prop[=value][,...]]\n"
+#endif
+#ifdef CONFIG_SPICE
+    "-audiodev spice,id=id[,prop[=value][,...]]\n"
+#endif
+    "-audiodev wav,id=id[,prop[=value][,...]]\n"
+    "                path= path of wav file to record\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -audiodev [driver=]@var{driver},id=@var{id}[,@var{prop}[=@var{value}][,...]]
+@findex -audiodev
+Adds a new audio backend @var{driver} identified by @var{id}.  There are
+global and driver specific properties.  Some values can be set
+differently for input and output, they're marked with @code{in|out.}.
+You can set the input's property with @code{in.@var{prop}} and the
+output's property with @code{out.@var{prop}}. For example:
+@example
+-audiodev alsa,id=example,in.frequency=44110,out.frequency=8000
+-audiodev alsa,id=example,out.channels=1 # leaves in.channels unspecified
+@end example
+
+Valid global options are:
+
+@table @option
+@item id=@var{identifier}
+Identifies the audio backend.
+
+@item timer-period=@var{period}
+Sets the timer @var{period} used by the audio subsystem in microseconds.
+Default is 10000 (10 ms).
+
+@item in|out.fixed-settings=on|off
+Use fixed settings for host audio.  When off, it will change based on
+how the guest opens the sound card.  In this case you must not specify
+@var{frequency}, @var{channels} or @var{format}.  Default is on.
+
+@item in|out.frequency=@var{frequency}
+Specify the @var{frequency} to use when using @var{fixed-settings}.
+Default is 44100Hz.
+
+@item in|out.channels=@var{channels}
+Specify the number of @var{channels} to use when using
+@var{fixed-settings}. Default is 2 (stereo).
+
+@item in|out.format=@var{format}
+Specify the sample @var{format} to use when using @var{fixed-settings}.
+Valid values are: @code{s8}, @code{s16}, @code{s32}, @code{u8},
+@code{u16}, @code{u32}. Default is @code{s16}.
+
+@item in|out.voices=@var{voices}
+Specify the number of @var{voices} to use.  Default is 1.
+
+@item in|out.buffer=@var{usecs}
+Sets the size of the buffer in microseconds.
+
+@item in|out.buffer-count=@var{count}
+Sets the @var{count} of the buffers.
+
+@end table
+
+@item -audiodev none,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a dummy backend that discards all outputs.  This backend has no
+backend specific properties.
+
+@item -audiodev alsa,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates backend using the ALSA.  This backend is only available on
+Linux.
+
+ALSA specific options are:
+
+@table @option
+@item alsa-in|alsa-out.dev=@var{device}
+Specify the ALSA @var{device} to use for input and/or output.  Default
+is @code{default}.
+
+@item alsa-in|alsa-out.try-poll=on|off
+Attempt to use poll mode with the device.  Default is on.
+
+@item threshold=@var{threshold}
+Threshold (in microseconds) when playback starts.  Default is 0.
+
+@end table
+
+@item -audiodev coreaudio,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using Apple's Core Audio.  This backend is only
+available on Mac OS and only supports playback.  This backend has no
+backend specific properties.
+
+@item -audiodev dsound,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using Microsoft's DirectSound.  This backend is only
+available on Windows and only supports playback.
+
+Backend specific options are:
+
+@table @option
+
+@item latency=@var{usecs}
+Add extra @var{usecs} microseconds latency to playback.  Default is
+10000 (10 ms).
+
+@end table
+
+@item -audiodev oss,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using OSS.  This backend is available on most
+Unix-like systems.
+
+OSS specific options are:
+
+@table @option
+
+@item oss-in|oss-out.dev=@var{device}
+Specify the file name of the OSS @var{device} to use.  Default is
+@code{/dev/dsp}.
+
+@item oss-in|oss-out.try-poll=on|of
+Attempt to use poll mode with the device.  Default is on.
+
+@item try-mmap=on|off
+Try using memory mapped device access.  Default is off.
+
+@item exclusive=on|off
+Open the device in exclusive mode (vmix won't work in this case).
+Default is off.
+
+@item dsp-policy=@var{policy}
+Sets the timing policy (between 0 and 10, where smaller number means
+smaller latency but higher CPU usage).  Use -1 to use buffer sizes
+specified by @code{buffer} and @code{buffer-count}.  This option is
+ignored if you do not have OSS 4. Default is 5.
+
+@end table
+
+@item -audiodev pa,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using PulseAudio.  This backend is available on most
+systems.
+
+PulseAudio specific options are:
+
+@table @option
+
+@item server=@var{server}
+Sets the PulseAudio @var{server} to connect to.
+
+@item sink|source.name=@var{sink}
+Use the specified sink/source for playback/recording.
+
+@end table
+
+@item -audiodev sdl,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using SDL.  This backend is available on most systems,
+but you should use your platform's native backend if possible.  This
+backend has no backend specific properties.
+
+@item -audiodev spice,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend that sends audio through SPICE.  This backend requires
+@code{-spice} and automatically selected in that case, so usually you
+can ignore this option.  This backend has no backend specific
+properties.
+
+@item -audiodev wav,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend that writes audio to a WAV file.
+
+Backend specific options are:
+
+@table @option
+
+@item path=@var{path}
+Write recorded audio into the specified file.  Default is
+@code{qemu.wav}.
+
+@end table
 ETEXI
 
 DEF("soundhw", HAS_ARG, QEMU_OPTION_soundhw,
-- 
2.20.1

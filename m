Received: from eggs.gnu.org ([209.51.188.92]:38599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4Y-0007cZ-6M
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4W-0002b9-Gb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:34 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1h2O4W-0002aa-59
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id x10so13567014wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 14:34:32 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Fri,  8 Mar 2019 23:34:14 +0100
Message-Id: <ca5e761e58dcfaf591cf46080af3548551b42bb2.1552083282.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
References: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 03/14] audio: -audiodev command line option:
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "reviewer:Incompatible changes" <libvir-list@redhat.com>

This patch adds documentation of an -audiodev command line option, that
deprecates the old QEMU_* environment variables for audio backend
configuration.  It's syntax is similar to existing options (-netdev,
-device, etc):

  -audiodev driver_name,property=value,...

Although now it's possible to specify multiple -audiodev options on
command line, multiple audio backends are not supported yet.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v4:
    
    * deprecated QEMU_AUDIO_ env vars
    * updated to reflect qapi changes
    * added info to qemu-deprecated.texi

 qemu-deprecated.texi |   7 ++
 qemu-options.hx      | 236 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 240 insertions(+), 3 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 45c57952da..5c07ad4acb 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -60,6 +60,13 @@ Support for invalid topologies will be removed, the user must ensure
 topologies described with -smp include all possible cpus, i.e.
   @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.
 
+@subsection QEMU_AUDIO_ environment variables and -audio-help (since 4.0)
+
+The ``-audiodev'' argument is now the preferred way to specify audio
+backend settings instead of environment variables.  To ease migration to
+the new format, the ``-audiodev-help'' option can be used to convert
+the current values of the environment variables to ``-audiodev'' options.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac1fe..52ea13e6a2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -416,14 +416,244 @@ The default is @code{en-us}.
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
+    "                in|out.buffer-len= length of buffer in microseconds\n"
+    "-audiodev none,id=id,[,prop[=value][,...]]\n"
+    "                dummy driver that discards all output\n"
+#ifdef CONFIG_AUDIO_ALSA
+    "-audiodev alsa,id=id[,prop[=value][,...]]\n"
+    "                in|out.dev= name of the audio device to use\n"
+    "                in|out.period-len= length of period in microseconds\n"
+    "                in|out.try-poll= attempt to use poll mode\n"
+    "                threshold= threshold (in microseconds) when playback starts\n"
+#endif
+#ifdef CONFIG_AUDIO_COREAUDIO
+    "-audiodev coreaudio,id=id[,prop[=value][,...]]\n"
+    "                in|out.buffer-count= number of buffers\n"
+#endif
+#ifdef CONFIG_AUDIO_DSOUND
+    "-audiodev dsound,id=id[,prop[=value][,...]]\n"
+    "                latency= add extra latency to playback in microseconds\n"
+#endif
+#ifdef CONFIG_AUDIO_OSS
+    "-audiodev oss,id=id[,prop[=value][,...]]\n"
+    "                in|out.dev= path of the audio device to use\n"
+    "                in|out.buffer-count= number of buffers\n"
+    "                in|out.try-poll= attempt to use poll mode\n"
+    "                try-mmap= try using memory mapped access\n"
+    "                exclusive= open device in exclusive mode\n"
+    "                dsp-policy= set timing policy (0..10), -1 to use fragment mode\n"
+#endif
+#ifdef CONFIG_AUDIO_PA
+    "-audiodev pa,id=id[,prop[=value][,...]]\n"
+    "                server= PulseAudio server address\n"
+    "                in|out.name= source/sink device name\n"
+#endif
+#ifdef CONFIG_AUDIO_SDL
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
+
+@item in|out.dev=@var{device}
+Specify the ALSA @var{device} to use for input and/or output.  Default
+is @code{default}.
+
+@item in|out.period-len=@var{usecs}
+Sets the period length in microseconds.
+
+@item in|out.try-poll=on|off
+Attempt to use poll mode with the device.  Default is on.
+
+@item threshold=@var{threshold}
+Threshold (in microseconds) when playback starts.  Default is 0.
+
+@end table
+
+@item -audiodev coreaudio,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using Apple's Core Audio.  This backend is only
+available on Mac OS and only supports playback.
+
+Core Audio specific options are:
+
+@table @option
+
+@item in|out.buffer-count=@var{count}
+Sets the @var{count} of the buffers.
+
+@end table
+
+@item -audiodev dsound,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using Microsoft's DirectSound.  This backend is only
+available on Windows and only supports playback.
+
+DirectSound specific options are:
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
+@item in|out.dev=@var{device}
+Specify the file name of the OSS @var{device} to use.  Default is
+@code{/dev/dsp}.
+
+@item in|out.buffer-count=@var{count}
+Sets the @var{count} of the buffers.
+
+@item in|out.try-poll=on|of
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
+@item in|out.name=@var{sink}
+Use the specified source/sink for recording/playback.
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

Received: from eggs.gnu.org ([209.51.188.92]:47659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdA-0007mi-DX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFd6-0003P4-DC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFd6-0003Mh-15
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so19940209wrx.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:41 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:24 +0100
Message-Id: <2ea7c5fe169dc201b4f3276f02d93e65aa9780fe.1548714862.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/14] qapi: qapi for audio backends
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

This patch adds structures into qapi to replace the existing
configuration structures used by audio backends currently. This qapi
will be the base of the -audiodev command line parameter (that replaces
the old environment variables based config).

This is not a 1:1 translation of the old options, I've tried to make
them much more consistent (e.g. almost every backend had an option to
specify buffer size, but the name was different for every backend, and
some backends required usecs, while some other required frames, samples
or bytes). Also tried to reduce the number of abbreviations used by the
config keys.

Some of the more important changes:
* use `in` and `out` instead of `ADC` and `DAC`, as the former is more
  user friendly imho
* moved buffer settings into the global setting area (so it's the same
  for all backends that support it. Backends that can't change buffer
  size will simply ignore them). Also using usecs, as it's probably more
  user friendly than samples or bytes.
* try-poll is now an alsa backend specific option (as all other backends
  currently ignore it)

AudiodevPaPerDirectionOptions struct might look pointless right now, but
later we will have new per-direction options, so it's more future-proof
this way.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v2:
    
    * update copyright, version numbers
    * remove #optional
    * per-direction options are now optional (needed for qobject_object_visitor_new_str)
    * removed unnecessary AudiodevNoOptions
    * changed integers to unsigned

 Makefile.objs         |   6 +-
 qapi/audio.json       | 233 ++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |   1 +
 3 files changed, 237 insertions(+), 3 deletions(-)
 create mode 100644 qapi/audio.json

diff --git a/Makefile.objs b/Makefile.objs
index 67a054b08a..d9ee3fed32 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,6 +1,6 @@
-QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
-QAPI_MODULES += ui
+QAPI_MODULES = audio block-core block char common crypto introspect job
+QAPI_MODULES += migration misc net rdma rocker run-state sockets tpm trace
+QAPI_MODULES += transaction ui
 
 #######################################################################
 # Common libraries for tools and emulators
diff --git a/qapi/audio.json b/qapi/audio.json
new file mode 100644
index 0000000000..bd6e2494bd
--- /dev/null
+++ b/qapi/audio.json
@@ -0,0 +1,233 @@
+# -*- mode: python -*-
+#
+# Copyright (C) 2015-2019 Zoltán Kővágó <DirtY.iCE.hu@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# @AudiodevAlsaPerDirectionOptions:
+#
+# Options of the alsa backend that are used for both playback and recording.
+#
+# @dev: the name of the alsa device to use (default 'default')
+#
+# @try-poll: attempt to use poll mode, falling back to non polling access on
+#            failure (default on)
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevAlsaPerDirectionOptions',
+  'data': {
+    '*dev':      'str',
+    '*try-poll': 'bool' } }
+
+##
+# @AudiodevAlsaOptions:
+#
+# Options of the alsa audio backend.
+#
+# @alsa-in: options of the capture stream
+#
+# @alsa-out: options of the playback stream
+#
+# @threshold: set the threshold (in microseconds) when playback starts
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevAlsaOptions',
+  'data': {
+    '*alsa-in':   'AudiodevAlsaPerDirectionOptions',
+    '*alsa-out':  'AudiodevAlsaPerDirectionOptions',
+    '*threshold': 'uint32' } }
+
+##
+# @AudiodevDsoundOptions:
+#
+# Options of the dsound audio backend.
+#
+# @latency: add extra latency to playback in microseconds (default 10000)
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevDsoundOptions',
+  'data': {
+    '*latency': 'uint32' } }
+
+##
+# @AudiodevOssPerDirectionOptions:
+#
+# Options of the oss backend that are used for both playback and recording.
+#
+# @dev: file name of the oss device (default '/dev/dsp')
+#
+# @try-poll: attempt to use poll mode, falling back to non polling access on
+#            failure (default on)
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevOssPerDirectionOptions',
+  'data': {
+    '*dev':      'str',
+    '*try-poll': 'bool' } }
+
+##
+# @AudiodevOssOptions:
+#
+# Options of the oss audio backend.
+#
+# @oss-in: options of the capture stream
+#
+# @oss-out: options of the playback stream
+#
+# @try-mmap: try using memory mapped access, falling back to non
+#            memory mapped access on failure (default off)
+#
+# @exclusive: open device in exclusive mode (vmix won't work) (default off)
+#
+# @dsp-policy: set the timing policy of the device (between 0 and 10, where
+#              smaller number means smaller latency but higher CPU usage) or -1
+#              to use fragment mode (option ignored on some platforms)
+#              (default 5)
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevOssOptions',
+  'data': {
+    '*oss-in':     'AudiodevOssPerDirectionOptions',
+    '*oss-out':    'AudiodevOssPerDirectionOptions',
+    '*try-mmap':   'bool',
+    '*exclusive':  'bool',
+    '*dsp-policy': 'uint32' } }
+
+##
+# @AudiodevPaPerDirectionOptions:
+#
+# Options of the pa backend that are used for both playback and recording.
+#
+# @name: name of the sink/source to use
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevPaPerDirectionOptions',
+  'data': {
+    '*name': 'str' } }
+
+##
+# @AudiodevPaOptions:
+#
+# Options of the pa (PulseAudio) audio backend.
+#
+# @server: PulseAudio server address (default: let PulseAudio choose)
+#
+# @sink: name of the sink to use
+#
+# @source: name of the source to use
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevPaOptions',
+  'data': {
+    '*server': 'str',
+    '*sink':   'AudiodevPaPerDirectionOptions',
+    '*source': 'AudiodevPaPerDirectionOptions' } }
+
+##
+# @AudiodevWavOptions:
+#
+# Options of the wav audio backend.
+#
+# @path: name of the wav file to record (default 'qemu.wav')
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevWavOptions',
+  'data': {
+    '*path': 'str' } }
+
+
+##
+# @AudioFormat:
+#
+# An enumeration of possible audio formats.
+#
+# Since: 4.0
+##
+{ 'enum': 'AudioFormat',
+  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
+
+##
+# @AudiodevDriver:
+#
+# An enumeration of possible audio backend drivers.
+#
+# Since: 4.0
+##
+{ 'enum': 'AudiodevDriver',
+  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl', 'spice',
+            'wav' ] }
+
+##
+# @AudiodevPerDirectionOptions:
+#
+# General audio backend options that are used for both playback and recording.
+#
+# @fixed-settings: use fixed settings for host input/output. When off,
+#                  frequency, channels and format must not be specified
+#                  (default on)
+#
+# @frequency: frequency to use when using fixed settings (default 44100)
+#
+# @channels: number of channels when using fixed settings (default 2)
+#
+# @voices: number of voices to use (default 1)
+#
+# @format: sample format to use when using fixed settings (default s16)
+#
+# @buffer-len: the buffer size in microseconds
+#
+# @buffer-count: number of buffers
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevPerDirectionOptions',
+  'data': {
+    '*fixed-settings': 'bool',
+    '*frequency':      'uint32',
+    '*channels':       'uint32',
+    '*voices':         'uint32',
+    '*format':         'AudioFormat',
+    '*buffer-len':     'uint32',
+    '*buffer-count':   'uint32' } }
+
+##
+# @Audiodev:
+#
+# Options of an audio backend.
+#
+# @id: identifier of the backend
+#
+# @driver: the backend driver to use
+#
+# @in: options of the capture stream
+#
+# @out: options of the playback stream
+#
+# @timer-period: timer period (in microseconds, 0: use lowest possible)
+#
+# Since: 4.0
+##
+{ 'union': 'Audiodev',
+  'base': {
+    'id':            'str',
+    'driver':        'AudiodevDriver',
+    '*in':           'AudiodevPerDirectionOptions',
+    '*out':          'AudiodevPerDirectionOptions',
+    '*timer-period': 'uint32' },
+  'discriminator': 'driver',
+  'data': {
+    'alsa':      'AudiodevAlsaOptions',
+    'dsound':    'AudiodevDsoundOptions',
+    'oss':       'AudiodevOssOptions',
+    'pa':        'AudiodevPaOptions',
+    'wav':       'AudiodevWavOptions' } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 3bbdfcee84..d5f9856be7 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -95,3 +95,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'audio.json' }
-- 
2.20.1

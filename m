Received: from eggs.gnu.org ([208.118.235.92]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjk-0007MS-EI
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAji-0001Z4-V9
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:36 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAji-0001Vb-MT
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so10089842wrx.9
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:34 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:39 +0100
Message-Id: <b35ceed43600ab8572d8d7881adc14f3937ef91f.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/52] qapi: qapi for audio backends
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 Makefile.objs         |   6 +-
 qapi/audio.json       | 253 ++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |   1 +
 3 files changed, 257 insertions(+), 3 deletions(-)
 create mode 100644 qapi/audio.json

diff --git a/Makefile.objs b/Makefile.objs
index bc5b8a8442..3f833a70c0 100644
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
index 0000000000..56d8ce439f
--- /dev/null
+++ b/qapi/audio.json
@@ -0,0 +1,253 @@
+# -*- mode: python -*-
+#
+# Copyright (C) 2015 Zoltán Kővágó <DirtY.iCE.hu@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# @AudiodevNoOptions:
+#
+# The none, coreaudio, sdl and spice audio backend have no options.
+#
+# Since: 3.2
+##
+{ 'struct': 'AudiodevNoOptions',
+  'data': { } }
+
+##
+# @AudiodevAlsaPerDirectionOptions:
+#
+# Options of the alsa backend that are used for both playback and recording.
+#
+# @dev: #optional the name of the alsa device to use (default 'default')
+#
+# @try-poll: #optional attempt to use poll mode, falling back to non polling
+#            access on failure (default on)
+#
+# Since: 3.2
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
+# @threshold: #optional set the threshold (in microseconds) when playback starts
+#
+# Since: 3.2
+##
+{ 'struct': 'AudiodevAlsaOptions',
+  'data': {
+    'alsa-in':    'AudiodevAlsaPerDirectionOptions',
+    'alsa-out':   'AudiodevAlsaPerDirectionOptions',
+    '*threshold': 'int' } }
+
+##
+# @AudiodevDsoundOptions:
+#
+# Options of the dsound audio backend.
+#
+# @latency: #optional add extra latency to playback in microseconds (default
+#           10000)
+#
+# Since: 3.2
+##
+{ 'struct': 'AudiodevDsoundOptions',
+  'data': {
+    '*latency': 'int' } }
+
+##
+# @AudiodevOssPerDirectionOptions:
+#
+# Options of the oss backend that are used for both playback and recording.
+#
+# @dev: #optional file name of the oss device (default '/dev/dsp')
+#
+# @try-poll: #optional attempt to use poll mode, falling back to non polling
+#            access on failure (default on)
+#
+# Since: 3.2
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
+# @try-mmap: #optional try using memory mapped access, falling back to non
+#            memory mapped access on failure (default off)
+#
+# @exclusive: #optional open device in exclusive mode (vmix won't work)
+#             (default off)
+#
+# @dsp-policy: #optional set the timing policy of the device (between 0 and 10,
+#              where smaller number means smaller latency but higher CPU usage)
+#              or -1 to use fragment mode (option ignored on some platforms)
+#              (default 5)
+#
+# Since: 3.2
+##
+{ 'struct': 'AudiodevOssOptions',
+  'data': {
+    'oss-in':      'AudiodevOssPerDirectionOptions',
+    'oss-out':     'AudiodevOssPerDirectionOptions',
+    '*try-mmap':   'bool',
+    '*exclusive':  'bool',
+    '*dsp-policy': 'int' } }
+
+##
+# @AudiodevPaPerDirectionOptions:
+#
+# Options of the pa backend that are used for both playback and recording.
+#
+# @name: #optional name of the sink/source to use
+#
+# Since: 3.2
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
+# @server: #optional PulseAudio server address (default: let PulseAudio choose)
+#
+# @sink: sink specific options
+#
+# @source: source specific options
+#
+# Since: 3.2
+##
+{ 'struct': 'AudiodevPaOptions',
+  'data': {
+    '*server': 'str',
+    'sink':    'AudiodevPaPerDirectionOptions',
+    'source':  'AudiodevPaPerDirectionOptions' } }
+
+##
+# @AudiodevWavOptions:
+#
+# Options of the wav audio backend.
+#
+# @path: #optional name of the wav file to record (default 'qemu.wav')
+#
+# Since: 3.2
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
+# Since: 3.2
+##
+{ 'enum': 'AudioFormat',
+  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
+
+##
+# @AudiodevDriver:
+#
+# An enumeration of possible audio backend drivers.
+#
+# Since: 3.2
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
+# @fixed-settings: #optional use fixed settings for host input/output.  When
+#                  off, frequency, channels and format must not be specified
+#                  (default on)
+#
+# @frequency: #optional frequency to use when using fixed settings
+#             (default 44100)
+#
+# @channels: #optional number of channels when using fixed settings
+#            (default 2)
+#
+# @voices: #optional number of voices to use (default 1)
+#
+# @format: #optional sample format to use when using fixed settings
+#          (default s16)
+#
+# @buffer-len: #optional the buffer size in microseconds
+#
+# @buffer-count: #optional number of buffers
+#
+# Since: 3.2
+##
+{ 'struct': 'AudiodevPerDirectionOptions',
+  'data': {
+    '*fixed-settings': 'bool',
+    '*frequency':      'int',
+    '*channels':       'int',
+    '*voices':         'int',
+    '*format':         'AudioFormat',
+    '*buffer-len':     'int',
+    '*buffer-count':   'int' } }
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
+# @timer-period: #optional timer period (in microseconds, 0: use lowest
+#                possible)
+#
+# Since: 3.2
+##
+{ 'union': 'Audiodev',
+  'base': {
+    'id':            'str',
+    'driver':        'AudiodevDriver',
+    'in':            'AudiodevPerDirectionOptions',
+    'out':           'AudiodevPerDirectionOptions',
+    '*timer-period': 'int' },
+  'discriminator': 'driver',
+  'data': {
+    'none':      'AudiodevNoOptions',
+    'alsa':      'AudiodevAlsaOptions',
+    'coreaudio': 'AudiodevNoOptions',
+    'dsound':    'AudiodevDsoundOptions',
+    'oss':       'AudiodevOssOptions',
+    'pa':        'AudiodevPaOptions',
+    'sdl':       'AudiodevNoOptions',
+    'spice':     'AudiodevNoOptions',
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

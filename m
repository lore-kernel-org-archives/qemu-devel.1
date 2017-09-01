Received: from eggs.gnu.org ([2001:4830:134:3::10]:54109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUs-0000Sx-I1
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0007Mt-Np
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007LP-6R
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A3D9C03BD72
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:45 +0200
Message-Id: <20170901125611.29295-22-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/47] qapi-schema: Collect char device stuff in
 qapi/char.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-7-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS      |   1 +
 Makefile         |   1 +
 qapi-schema.json | 511 +------------------------------------------------=
---
 qapi/char.json   | 538 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 qapi/event.json  |  21 ---
 5 files changed, 541 insertions(+), 531 deletions(-)
 create mode 100644 qapi/char.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 289ea8c575..6a808d33ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1253,6 +1253,7 @@ M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com>
 S: Maintained
 F: chardev/
 F: include/chardev/
+F: qapi/char.json
=20
 Character Devices (Braille)
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
diff --git a/Makefile b/Makefile
index d3ba41afb8..59ef46cc3e 100644
--- a/Makefile
+++ b/Makefile
@@ -410,6 +410,7 @@ $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/=
qapi-commands.py $(qapi-py)
=20
 qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
+               $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
                $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.j=
son \
                $(SRC_PATH)/qapi/rocker.json \
diff --git a/qapi-schema.json b/qapi-schema.json
index f42d61b664..4f30d21340 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -83,6 +83,7 @@
 { 'include': 'qapi/run-state.json' }
 { 'include': 'qapi/crypto.json' }
 { 'include': 'qapi/block.json' }
+{ 'include': 'qapi/char.json' }
 { 'include': 'qapi/rocker.json' }
 { 'include': 'qapi/event.json' }
 { 'include': 'qapi/trace.json' }
@@ -274,189 +275,6 @@
 { 'command': 'query-uuid', 'returns': 'UuidInfo' }
=20
 ##
-# @ChardevInfo:
-#
-# Information about a character device.
-#
-# @label: the label of the character device
-#
-# @filename: the filename of the character device
-#
-# @frontend-open: shows whether the frontend device attached to this bac=
kend
-#                 (eg. with the chardev=3D... option) is in open or clos=
ed state
-#                 (since 2.1)
-#
-# Notes: @filename is encoded using the QEMU command line character devi=
ce
-#        encoding.  See the QEMU man page for details.
-#
-# Since: 0.14.0
-##
-{ 'struct': 'ChardevInfo', 'data': {'label': 'str',
-                                  'filename': 'str',
-                                  'frontend-open': 'bool'} }
-
-##
-# @query-chardev:
-#
-# Returns information about current character devices.
-#
-# Returns: a list of @ChardevInfo
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-chardev" }
-# <- {
-#       "return": [
-#          {
-#             "label": "charchannel0",
-#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agen=
t,server",
-#             "frontend-open": false
-#          },
-#          {
-#             "label": "charmonitor",
-#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.moni=
tor,server",
-#             "frontend-open": true
-#          },
-#          {
-#             "label": "charserial0",
-#             "filename": "pty:/dev/pts/2",
-#             "frontend-open": true
-#          }
-#       ]
-#    }
-#
-##
-{ 'command': 'query-chardev', 'returns': ['ChardevInfo'] }
-
-##
-# @ChardevBackendInfo:
-#
-# Information about a character device backend
-#
-# @name: The backend name
-#
-# Since: 2.0
-##
-{ 'struct': 'ChardevBackendInfo', 'data': {'name': 'str'} }
-
-##
-# @query-chardev-backends:
-#
-# Returns information about character device backends.
-#
-# Returns: a list of @ChardevBackendInfo
-#
-# Since: 2.0
-#
-# Example:
-#
-# -> { "execute": "query-chardev-backends" }
-# <- {
-#       "return":[
-#          {
-#             "name":"udp"
-#          },
-#          {
-#             "name":"tcp"
-#          },
-#          {
-#             "name":"unix"
-#          },
-#          {
-#             "name":"spiceport"
-#          }
-#       ]
-#    }
-#
-##
-{ 'command': 'query-chardev-backends', 'returns': ['ChardevBackendInfo']=
 }
-
-##
-# @DataFormat:
-#
-# An enumeration of data format.
-#
-# @utf8: Data is a UTF-8 string (RFC 3629)
-#
-# @base64: Data is Base64 encoded binary (RFC 3548)
-#
-# Since: 1.4
-##
-{ 'enum': 'DataFormat',
-  'data': [ 'utf8', 'base64' ] }
-
-##
-# @ringbuf-write:
-#
-# Write to a ring buffer character device.
-#
-# @device: the ring buffer character device name
-#
-# @data: data to write
-#
-# @format: data encoding (default 'utf8').
-#          - base64: data must be base64 encoded text.  Its binary
-#            decoding gets written.
-#          - utf8: data's UTF-8 encoding is written
-#          - data itself is always Unicode regardless of format, like
-#            any other string.
-#
-# Returns: Nothing on success
-#
-# Since: 1.4
-#
-# Example:
-#
-# -> { "execute": "ringbuf-write",
-#      "arguments": { "device": "foo",
-#                     "data": "abcdefgh",
-#                     "format": "utf8" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'ringbuf-write',
-  'data': {'device': 'str', 'data': 'str',
-           '*format': 'DataFormat'} }
-
-##
-# @ringbuf-read:
-#
-# Read from a ring buffer character device.
-#
-# @device: the ring buffer character device name
-#
-# @size: how many bytes to read at most
-#
-# @format: data encoding (default 'utf8').
-#          - base64: the data read is returned in base64 encoding.
-#          - utf8: the data read is interpreted as UTF-8.
-#            Bug: can screw up when the buffer contains invalid UTF-8
-#            sequences, NUL characters, after the ring buffer lost
-#            data, and when reading stops because the size limit is
-#            reached.
-#          - The return value is always Unicode regardless of format,
-#            like any other string.
-#
-# Returns: data read from the device
-#
-# Since: 1.4
-#
-# Example:
-#
-# -> { "execute": "ringbuf-read",
-#      "arguments": { "device": "foo",
-#                     "size": 1000,
-#                     "format": "utf8" } }
-# <- { "return": "abcdefgh" }
-#
-##
-{ 'command': 'ringbuf-read',
-  'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
-  'returns': 'str' }
-
-##
 # @EventInfo:
 #
 # Information about a QMP event
@@ -4713,333 +4531,6 @@
=20
=20
 ##
-# @ChardevCommon:
-#
-# Configuration shared across all chardev backends
-#
-# @logfile: The name of a logfile to save output
-# @logappend: true to append instead of truncate
-#             (default to false to truncate)
-#
-# Since: 2.6
-##
-{ 'struct': 'ChardevCommon', 'data': { '*logfile': 'str',
-                                       '*logappend': 'bool' } }
-
-##
-# @ChardevFile:
-#
-# Configuration info for file chardevs.
-#
-# @in:  The name of the input file
-# @out: The name of the output file
-# @append: Open the file in append mode (default false to
-#          truncate) (Since 2.6)
-#
-# Since: 1.4
-##
-{ 'struct': 'ChardevFile', 'data': { '*in' : 'str',
-                                   'out' : 'str',
-                                   '*append': 'bool' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevHostdev:
-#
-# Configuration info for device and pipe chardevs.
-#
-# @device: The name of the special file for the device,
-#          i.e. /dev/ttyS0 on Unix or COM1: on Windows
-#
-# Since: 1.4
-##
-{ 'struct': 'ChardevHostdev', 'data': { 'device' : 'str' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevSocket:
-#
-# Configuration info for (stream) socket chardevs.
-#
-# @addr: socket address to listen on (server=3Dtrue)
-#        or connect to (server=3Dfalse)
-# @tls-creds: the ID of the TLS credentials object (since 2.6)
-# @server: create server socket (default: true)
-# @wait: wait for incoming connection on server
-#        sockets (default: false).
-# @nodelay: set TCP_NODELAY socket option (default: false)
-# @telnet: enable telnet protocol on server
-#          sockets (default: false)
-# @tn3270: enable tn3270 protocol on server
-#          sockets (default: false) (Since: 2.10)
-# @reconnect: For a client socket, if a socket is disconnected,
-#          then attempt a reconnect after the given number of seconds.
-#          Setting this to zero disables this function. (default: 0)
-#          (Since: 2.2)
-#
-# Since: 1.4
-##
-{ 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddressLega=
cy',
-                                     '*tls-creds'  : 'str',
-                                     '*server'    : 'bool',
-                                     '*wait'      : 'bool',
-                                     '*nodelay'   : 'bool',
-                                     '*telnet'    : 'bool',
-                                     '*tn3270'    : 'bool',
-                                     '*reconnect' : 'int' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevUdp:
-#
-# Configuration info for datagram socket chardevs.
-#
-# @remote: remote address
-# @local: local address
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevUdp', 'data': { 'remote' : 'SocketAddressLegacy',
-                                  '*local' : 'SocketAddressLegacy' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevMux:
-#
-# Configuration info for mux chardevs.
-#
-# @chardev: name of the base chardev.
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevMux', 'data': { 'chardev' : 'str' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevStdio:
-#
-# Configuration info for stdio chardevs.
-#
-# @signal: Allow signals (such as SIGINT triggered by ^C)
-#          be delivered to qemu.  Default: true in -nographic mode,
-#          false otherwise.
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevStdio', 'data': { '*signal' : 'bool' },
-  'base': 'ChardevCommon' }
-
-
-##
-# @ChardevSpiceChannel:
-#
-# Configuration info for spice vm channel chardevs.
-#
-# @type: kind of channel (for example vdagent).
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevSpicePort:
-#
-# Configuration info for spice port chardevs.
-#
-# @fqdn: name of the channel (see docs/spice-port-fqdn.txt)
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevVC:
-#
-# Configuration info for virtual console chardevs.
-#
-# @width:  console width,  in pixels
-# @height: console height, in pixels
-# @cols:   console width,  in chars
-# @rows:   console height, in chars
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevVC', 'data': { '*width'  : 'int',
-                                 '*height' : 'int',
-                                 '*cols'   : 'int',
-                                 '*rows'   : 'int' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevRingbuf:
-#
-# Configuration info for ring buffer chardevs.
-#
-# @size: ring buffer size, must be power of two, default is 65536
-#
-# Since: 1.5
-##
-{ 'struct': 'ChardevRingbuf', 'data': { '*size'  : 'int' },
-  'base': 'ChardevCommon' }
-
-##
-# @ChardevBackend:
-#
-# Configuration info for the new chardev backend.
-#
-# Since: 1.4 (testdev since 2.2, wctablet since 2.9)
-##
-{ 'union': 'ChardevBackend', 'data': { 'file'   : 'ChardevFile',
-                                       'serial' : 'ChardevHostdev',
-                                       'parallel': 'ChardevHostdev',
-                                       'pipe'   : 'ChardevHostdev',
-                                       'socket' : 'ChardevSocket',
-                                       'udp'    : 'ChardevUdp',
-                                       'pty'    : 'ChardevCommon',
-                                       'null'   : 'ChardevCommon',
-                                       'mux'    : 'ChardevMux',
-                                       'msmouse': 'ChardevCommon',
-                                       'wctablet' : 'ChardevCommon',
-                                       'braille': 'ChardevCommon',
-                                       'testdev': 'ChardevCommon',
-                                       'stdio'  : 'ChardevStdio',
-                                       'console': 'ChardevCommon',
-                                       'spicevmc' : 'ChardevSpiceChannel=
',
-                                       'spiceport' : 'ChardevSpicePort',
-                                       'vc'     : 'ChardevVC',
-                                       'ringbuf': 'ChardevRingbuf',
-                                       # next one is just for compatibil=
ity
-                                       'memory' : 'ChardevRingbuf' } }
-
-##
-# @ChardevReturn:
-#
-# Return info about the chardev backend just created.
-#
-# @pty: name of the slave pseudoterminal device, present if
-#       and only if a chardev of type 'pty' was created
-#
-# Since: 1.4
-##
-{ 'struct' : 'ChardevReturn', 'data': { '*pty' : 'str' } }
-
-##
-# @chardev-add:
-#
-# Add a character device backend
-#
-# @id: the chardev's ID, must be unique
-# @backend: backend type and parameters
-#
-# Returns: ChardevReturn.
-#
-# Since: 1.4
-#
-# Example:
-#
-# -> { "execute" : "chardev-add",
-#      "arguments" : { "id" : "foo",
-#                      "backend" : { "type" : "null", "data" : {} } } }
-# <- { "return": {} }
-#
-# -> { "execute" : "chardev-add",
-#      "arguments" : { "id" : "bar",
-#                      "backend" : { "type" : "file",
-#                                    "data" : { "out" : "/tmp/bar.log" }=
 } } }
-# <- { "return": {} }
-#
-# -> { "execute" : "chardev-add",
-#      "arguments" : { "id" : "baz",
-#                      "backend" : { "type" : "pty", "data" : {} } } }
-# <- { "return": { "pty" : "/dev/pty/42" } }
-#
-##
-{ 'command': 'chardev-add', 'data': {'id'      : 'str',
-                                     'backend' : 'ChardevBackend' },
-  'returns': 'ChardevReturn' }
-
-##
-# @chardev-change:
-#
-# Change a character device backend
-#
-# @id: the chardev's ID, must exist
-# @backend: new backend type and parameters
-#
-# Returns: ChardevReturn.
-#
-# Since: 2.10
-#
-# Example:
-#
-# -> { "execute" : "chardev-change",
-#      "arguments" : { "id" : "baz",
-#                      "backend" : { "type" : "pty", "data" : {} } } }
-# <- { "return": { "pty" : "/dev/pty/42" } }
-#
-# -> {"execute" : "chardev-change",
-#     "arguments" : {
-#         "id" : "charchannel2",
-#         "backend" : {
-#             "type" : "socket",
-#             "data" : {
-#                 "addr" : {
-#                     "type" : "unix" ,
-#                     "data" : {
-#                         "path" : "/tmp/charchannel2.socket"
-#                     }
-#                  },
-#                  "server" : true,
-#                  "wait" : false }}}}
-# <- {"return": {}}
-#
-##
-{ 'command': 'chardev-change', 'data': {'id'      : 'str',
-                                        'backend' : 'ChardevBackend' },
-  'returns': 'ChardevReturn' }
-
-##
-# @chardev-remove:
-#
-# Remove a character device backend
-#
-# @id: the chardev's ID, must exist and not be in use
-#
-# Returns: Nothing on success
-#
-# Since: 1.4
-#
-# Example:
-#
-# -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'chardev-remove', 'data': {'id': 'str'} }
-
-##
-# @chardev-send-break:
-#
-# Send a break to a character device
-#
-# @id: the chardev's ID, must exist
-#
-# Returns: Nothing on success
-#
-# Since: 2.10
-#
-# Example:
-#
-# -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'chardev-send-break', 'data': {'id': 'str'} }
-
-
-##
 # @TpmModel:
 #
 # An enumeration of TPM models
diff --git a/qapi/char.json b/qapi/char.json
new file mode 100644
index 0000000000..ae19dcd1ed
--- /dev/null
+++ b/qapi/char.json
@@ -0,0 +1,538 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D Character devices
+##
+
+{ 'include': 'sockets.json' }
+
+##
+# @ChardevInfo:
+#
+# Information about a character device.
+#
+# @label: the label of the character device
+#
+# @filename: the filename of the character device
+#
+# @frontend-open: shows whether the frontend device attached to this bac=
kend
+#                 (eg. with the chardev=3D... option) is in open or clos=
ed state
+#                 (since 2.1)
+#
+# Notes: @filename is encoded using the QEMU command line character devi=
ce
+#        encoding.  See the QEMU man page for details.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'ChardevInfo', 'data': {'label': 'str',
+                                  'filename': 'str',
+                                  'frontend-open': 'bool'} }
+
+##
+# @query-chardev:
+#
+# Returns information about current character devices.
+#
+# Returns: a list of @ChardevInfo
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-chardev" }
+# <- {
+#       "return": [
+#          {
+#             "label": "charchannel0",
+#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agen=
t,server",
+#             "frontend-open": false
+#          },
+#          {
+#             "label": "charmonitor",
+#             "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.moni=
tor,server",
+#             "frontend-open": true
+#          },
+#          {
+#             "label": "charserial0",
+#             "filename": "pty:/dev/pts/2",
+#             "frontend-open": true
+#          }
+#       ]
+#    }
+#
+##
+{ 'command': 'query-chardev', 'returns': ['ChardevInfo'] }
+
+##
+# @ChardevBackendInfo:
+#
+# Information about a character device backend
+#
+# @name: The backend name
+#
+# Since: 2.0
+##
+{ 'struct': 'ChardevBackendInfo', 'data': {'name': 'str'} }
+
+##
+# @query-chardev-backends:
+#
+# Returns information about character device backends.
+#
+# Returns: a list of @ChardevBackendInfo
+#
+# Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "query-chardev-backends" }
+# <- {
+#       "return":[
+#          {
+#             "name":"udp"
+#          },
+#          {
+#             "name":"tcp"
+#          },
+#          {
+#             "name":"unix"
+#          },
+#          {
+#             "name":"spiceport"
+#          }
+#       ]
+#    }
+#
+##
+{ 'command': 'query-chardev-backends', 'returns': ['ChardevBackendInfo']=
 }
+
+##
+# @DataFormat:
+#
+# An enumeration of data format.
+#
+# @utf8: Data is a UTF-8 string (RFC 3629)
+#
+# @base64: Data is Base64 encoded binary (RFC 3548)
+#
+# Since: 1.4
+##
+{ 'enum': 'DataFormat',
+  'data': [ 'utf8', 'base64' ] }
+
+##
+# @ringbuf-write:
+#
+# Write to a ring buffer character device.
+#
+# @device: the ring buffer character device name
+#
+# @data: data to write
+#
+# @format: data encoding (default 'utf8').
+#          - base64: data must be base64 encoded text.  Its binary
+#            decoding gets written.
+#          - utf8: data's UTF-8 encoding is written
+#          - data itself is always Unicode regardless of format, like
+#            any other string.
+#
+# Returns: Nothing on success
+#
+# Since: 1.4
+#
+# Example:
+#
+# -> { "execute": "ringbuf-write",
+#      "arguments": { "device": "foo",
+#                     "data": "abcdefgh",
+#                     "format": "utf8" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'ringbuf-write',
+  'data': {'device': 'str', 'data': 'str',
+           '*format': 'DataFormat'} }
+
+##
+# @ringbuf-read:
+#
+# Read from a ring buffer character device.
+#
+# @device: the ring buffer character device name
+#
+# @size: how many bytes to read at most
+#
+# @format: data encoding (default 'utf8').
+#          - base64: the data read is returned in base64 encoding.
+#          - utf8: the data read is interpreted as UTF-8.
+#            Bug: can screw up when the buffer contains invalid UTF-8
+#            sequences, NUL characters, after the ring buffer lost
+#            data, and when reading stops because the size limit is
+#            reached.
+#          - The return value is always Unicode regardless of format,
+#            like any other string.
+#
+# Returns: data read from the device
+#
+# Since: 1.4
+#
+# Example:
+#
+# -> { "execute": "ringbuf-read",
+#      "arguments": { "device": "foo",
+#                     "size": 1000,
+#                     "format": "utf8" } }
+# <- { "return": "abcdefgh" }
+#
+##
+{ 'command': 'ringbuf-read',
+  'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
+  'returns': 'str' }
+
+##
+# @ChardevCommon:
+#
+# Configuration shared across all chardev backends
+#
+# @logfile: The name of a logfile to save output
+# @logappend: true to append instead of truncate
+#             (default to false to truncate)
+#
+# Since: 2.6
+##
+{ 'struct': 'ChardevCommon', 'data': { '*logfile': 'str',
+                                       '*logappend': 'bool' } }
+
+##
+# @ChardevFile:
+#
+# Configuration info for file chardevs.
+#
+# @in:  The name of the input file
+# @out: The name of the output file
+# @append: Open the file in append mode (default false to
+#          truncate) (Since 2.6)
+#
+# Since: 1.4
+##
+{ 'struct': 'ChardevFile', 'data': { '*in' : 'str',
+                                   'out' : 'str',
+                                   '*append': 'bool' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevHostdev:
+#
+# Configuration info for device and pipe chardevs.
+#
+# @device: The name of the special file for the device,
+#          i.e. /dev/ttyS0 on Unix or COM1: on Windows
+#
+# Since: 1.4
+##
+{ 'struct': 'ChardevHostdev', 'data': { 'device' : 'str' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevSocket:
+#
+# Configuration info for (stream) socket chardevs.
+#
+# @addr: socket address to listen on (server=3Dtrue)
+#        or connect to (server=3Dfalse)
+# @tls-creds: the ID of the TLS credentials object (since 2.6)
+# @server: create server socket (default: true)
+# @wait: wait for incoming connection on server
+#        sockets (default: false).
+# @nodelay: set TCP_NODELAY socket option (default: false)
+# @telnet: enable telnet protocol on server
+#          sockets (default: false)
+# @tn3270: enable tn3270 protocol on server
+#          sockets (default: false) (Since: 2.10)
+# @reconnect: For a client socket, if a socket is disconnected,
+#          then attempt a reconnect after the given number of seconds.
+#          Setting this to zero disables this function. (default: 0)
+#          (Since: 2.2)
+#
+# Since: 1.4
+##
+{ 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddressLega=
cy',
+                                     '*tls-creds'  : 'str',
+                                     '*server'    : 'bool',
+                                     '*wait'      : 'bool',
+                                     '*nodelay'   : 'bool',
+                                     '*telnet'    : 'bool',
+                                     '*tn3270'    : 'bool',
+                                     '*reconnect' : 'int' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevUdp:
+#
+# Configuration info for datagram socket chardevs.
+#
+# @remote: remote address
+# @local: local address
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevUdp', 'data': { 'remote' : 'SocketAddressLegacy',
+                                  '*local' : 'SocketAddressLegacy' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevMux:
+#
+# Configuration info for mux chardevs.
+#
+# @chardev: name of the base chardev.
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevMux', 'data': { 'chardev' : 'str' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevStdio:
+#
+# Configuration info for stdio chardevs.
+#
+# @signal: Allow signals (such as SIGINT triggered by ^C)
+#          be delivered to qemu.  Default: true in -nographic mode,
+#          false otherwise.
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevStdio', 'data': { '*signal' : 'bool' },
+  'base': 'ChardevCommon' }
+
+
+##
+# @ChardevSpiceChannel:
+#
+# Configuration info for spice vm channel chardevs.
+#
+# @type: kind of channel (for example vdagent).
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevSpicePort:
+#
+# Configuration info for spice port chardevs.
+#
+# @fqdn: name of the channel (see docs/spice-port-fqdn.txt)
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevVC:
+#
+# Configuration info for virtual console chardevs.
+#
+# @width:  console width,  in pixels
+# @height: console height, in pixels
+# @cols:   console width,  in chars
+# @rows:   console height, in chars
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevVC', 'data': { '*width'  : 'int',
+                                 '*height' : 'int',
+                                 '*cols'   : 'int',
+                                 '*rows'   : 'int' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevRingbuf:
+#
+# Configuration info for ring buffer chardevs.
+#
+# @size: ring buffer size, must be power of two, default is 65536
+#
+# Since: 1.5
+##
+{ 'struct': 'ChardevRingbuf', 'data': { '*size'  : 'int' },
+  'base': 'ChardevCommon' }
+
+##
+# @ChardevBackend:
+#
+# Configuration info for the new chardev backend.
+#
+# Since: 1.4 (testdev since 2.2, wctablet since 2.9)
+##
+{ 'union': 'ChardevBackend', 'data': { 'file'   : 'ChardevFile',
+                                       'serial' : 'ChardevHostdev',
+                                       'parallel': 'ChardevHostdev',
+                                       'pipe'   : 'ChardevHostdev',
+                                       'socket' : 'ChardevSocket',
+                                       'udp'    : 'ChardevUdp',
+                                       'pty'    : 'ChardevCommon',
+                                       'null'   : 'ChardevCommon',
+                                       'mux'    : 'ChardevMux',
+                                       'msmouse': 'ChardevCommon',
+                                       'wctablet' : 'ChardevCommon',
+                                       'braille': 'ChardevCommon',
+                                       'testdev': 'ChardevCommon',
+                                       'stdio'  : 'ChardevStdio',
+                                       'console': 'ChardevCommon',
+                                       'spicevmc' : 'ChardevSpiceChannel=
',
+                                       'spiceport' : 'ChardevSpicePort',
+                                       'vc'     : 'ChardevVC',
+                                       'ringbuf': 'ChardevRingbuf',
+                                       # next one is just for compatibil=
ity
+                                       'memory' : 'ChardevRingbuf' } }
+
+##
+# @ChardevReturn:
+#
+# Return info about the chardev backend just created.
+#
+# @pty: name of the slave pseudoterminal device, present if
+#       and only if a chardev of type 'pty' was created
+#
+# Since: 1.4
+##
+{ 'struct' : 'ChardevReturn', 'data': { '*pty' : 'str' } }
+
+##
+# @chardev-add:
+#
+# Add a character device backend
+#
+# @id: the chardev's ID, must be unique
+# @backend: backend type and parameters
+#
+# Returns: ChardevReturn.
+#
+# Since: 1.4
+#
+# Example:
+#
+# -> { "execute" : "chardev-add",
+#      "arguments" : { "id" : "foo",
+#                      "backend" : { "type" : "null", "data" : {} } } }
+# <- { "return": {} }
+#
+# -> { "execute" : "chardev-add",
+#      "arguments" : { "id" : "bar",
+#                      "backend" : { "type" : "file",
+#                                    "data" : { "out" : "/tmp/bar.log" }=
 } } }
+# <- { "return": {} }
+#
+# -> { "execute" : "chardev-add",
+#      "arguments" : { "id" : "baz",
+#                      "backend" : { "type" : "pty", "data" : {} } } }
+# <- { "return": { "pty" : "/dev/pty/42" } }
+#
+##
+{ 'command': 'chardev-add', 'data': {'id'      : 'str',
+                                     'backend' : 'ChardevBackend' },
+  'returns': 'ChardevReturn' }
+
+##
+# @chardev-change:
+#
+# Change a character device backend
+#
+# @id: the chardev's ID, must exist
+# @backend: new backend type and parameters
+#
+# Returns: ChardevReturn.
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "execute" : "chardev-change",
+#      "arguments" : { "id" : "baz",
+#                      "backend" : { "type" : "pty", "data" : {} } } }
+# <- { "return": { "pty" : "/dev/pty/42" } }
+#
+# -> {"execute" : "chardev-change",
+#     "arguments" : {
+#         "id" : "charchannel2",
+#         "backend" : {
+#             "type" : "socket",
+#             "data" : {
+#                 "addr" : {
+#                     "type" : "unix" ,
+#                     "data" : {
+#                         "path" : "/tmp/charchannel2.socket"
+#                     }
+#                  },
+#                  "server" : true,
+#                  "wait" : false }}}}
+# <- {"return": {}}
+#
+##
+{ 'command': 'chardev-change', 'data': {'id'      : 'str',
+                                        'backend' : 'ChardevBackend' },
+  'returns': 'ChardevReturn' }
+
+##
+# @chardev-remove:
+#
+# Remove a character device backend
+#
+# @id: the chardev's ID, must exist and not be in use
+#
+# Returns: Nothing on success
+#
+# Since: 1.4
+#
+# Example:
+#
+# -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'chardev-remove', 'data': {'id': 'str'} }
+
+##
+# @chardev-send-break:
+#
+# Send a break to a character device
+#
+# @id: the chardev's ID, must exist
+#
+# Returns: Nothing on success
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'chardev-send-break', 'data': {'id': 'str'} }
+
+##
+# @VSERPORT_CHANGE:
+#
+# Emitted when the guest opens or closes a virtio-serial port.
+#
+# @id: device identifier of the virtio-serial port
+#
+# @open: true if the guest has opened the virtio-serial port
+#
+# Since: 2.1
+#
+# Example:
+#
+# <- { "event": "VSERPORT_CHANGE",
+#      "data": { "id": "channel0", "open": true },
+#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+##
+{ 'event': 'VSERPORT_CHANGE',
+  'data': { 'id': 'str', 'open': 'bool' } }
diff --git a/qapi/event.json b/qapi/event.json
index 9c6126d278..b9aa6ed7cf 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -397,27 +397,6 @@
             'sector-num': 'int', 'sectors-count': 'int' } }
=20
 ##
-# @VSERPORT_CHANGE:
-#
-# Emitted when the guest opens or closes a virtio-serial port.
-#
-# @id: device identifier of the virtio-serial port
-#
-# @open: true if the guest has opened the virtio-serial port
-#
-# Since: 2.1
-#
-# Example:
-#
-# <- { "event": "VSERPORT_CHANGE",
-#      "data": { "id": "channel0", "open": true },
-#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
-#
-##
-{ 'event': 'VSERPORT_CHANGE',
-  'data': { 'id': 'str', 'open': 'bool' } }
-
-##
 # @MEM_UNPLUG_ERROR:
 #
 # Emitted when memory hot unplug error occurs.
--=20
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUw-0000Y3-5n
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0007Px-Pe
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUl-0007Ob-Ch
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 422347F3F6
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:43 +0200
Message-Id: <20170901125611.29295-20-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/47] qapi-schema: Collect sockets stuff in
 qapi/sockets.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-5-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS          |   1 +
 Makefile             |   4 +-
 qapi-schema.json     | 152 +--------------------------------------------=
------
 qapi/block-core.json |   2 +-
 qapi/common.json     |  11 ++++
 qapi/sockets.json    | 147 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 6 files changed, 164 insertions(+), 153 deletions(-)
 create mode 100644 qapi/sockets.json

diff --git a/MAINTAINERS b/MAINTAINERS
index ccee28b12d..fb90a19b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1535,6 +1535,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/sockets.h
 F: util/qemu-sockets.c
+F: qapi/sockets.json
=20
 Throttling infrastructure
 M: Alberto Garcia <berto@igalia.com>
diff --git a/Makefile b/Makefile
index 81447b1f08..ca4a03c376 100644
--- a/Makefile
+++ b/Makefile
@@ -410,8 +410,10 @@ $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts=
/qapi-commands.py $(qapi-py)
=20
 qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
+               $(SRC_PATH)/qapi/crypto.json \
                $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.j=
son \
-               $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json=
 \
+               $(SRC_PATH)/qapi/rocker.json \
+               $(SRC_PATH)/qapi/sockets.json \
                $(SRC_PATH)/qapi/trace.json
=20
 qapi-types.c qapi-types.h :\
diff --git a/qapi-schema.json b/qapi-schema.json
index add4777e9a..d69b6da5ec 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -79,6 +79,7 @@
 # include it first in qapi-schema.json.
=20
 { 'include': 'qapi/common.json' }
+{ 'include': 'qapi/sockets.json' }
 { 'include': 'qapi/crypto.json' }
 { 'include': 'qapi/block.json' }
 { 'include': 'qapi/rocker.json' }
@@ -1616,26 +1617,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
=20
 ##
-# @NetworkAddressFamily:
-#
-# The network address family
-#
-# @ipv4: IPV4 family
-#
-# @ipv6: IPV6 family
-#
-# @unix: unix socket
-#
-# @vsock: vsock family (since 2.8)
-#
-# @unknown: otherwise
-#
-# Since: 2.1
-##
-{ 'enum': 'NetworkAddressFamily',
-  'data': [ 'ipv4', 'ipv6', 'unix', 'vsock', 'unknown' ] }
-
-##
 # @VncBasicInfo:
 #
 # The basic information for vnc network connection
@@ -3696,17 +3677,6 @@
     '*vectors': 'uint32' } }
=20
 ##
-# @String:
-#
-# A fat type wrapping 'str', to be embedded in lists.
-#
-# Since: 1.2
-##
-{ 'struct': 'String',
-  'data': {
-    'str': 'str' } }
-
-##
 # @NetdevUserOptions:
 #
 # Use the user mode network stack which requires no administrator privil=
ege to
@@ -4157,126 +4127,6 @@
   'data': [ 'all', 'rx', 'tx' ] }
=20
 ##
-# @InetSocketAddressBase:
-#
-# @host: host part of the address
-# @port: port part of the address
-##
-{ 'struct': 'InetSocketAddressBase',
-  'data': {
-    'host': 'str',
-    'port': 'str' } }
-
-##
-# @InetSocketAddress:
-#
-# Captures a socket address or address range in the Internet namespace.
-#
-# @numeric: true if the host/port are guaranteed to be numeric,
-#           false if name resolution should be attempted. Defaults to fa=
lse.
-#           (Since 2.9)
-#
-# @to: If present, this is range of possible addresses, with port
-#      between @port and @to.
-#
-# @ipv4: whether to accept IPv4 addresses, default try both IPv4 and IPv=
6
-#
-# @ipv6: whether to accept IPv6 addresses, default try both IPv4 and IPv=
6
-#
-# Since: 1.3
-##
-{ 'struct': 'InetSocketAddress',
-  'base': 'InetSocketAddressBase',
-  'data': {
-    '*numeric':  'bool',
-    '*to': 'uint16',
-    '*ipv4': 'bool',
-    '*ipv6': 'bool' } }
-
-##
-# @UnixSocketAddress:
-#
-# Captures a socket address in the local ("Unix socket") namespace.
-#
-# @path: filesystem path to use
-#
-# Since: 1.3
-##
-{ 'struct': 'UnixSocketAddress',
-  'data': {
-    'path': 'str' } }
-
-##
-# @VsockSocketAddress:
-#
-# Captures a socket address in the vsock namespace.
-#
-# @cid: unique host identifier
-# @port: port
-#
-# Note: string types are used to allow for possible future hostname or
-# service resolution support.
-#
-# Since: 2.8
-##
-{ 'struct': 'VsockSocketAddress',
-  'data': {
-    'cid': 'str',
-    'port': 'str' } }
-
-##
-# @SocketAddressLegacy:
-#
-# Captures the address of a socket, which could also be a named file des=
criptor
-#
-# Note: This type is deprecated in favor of SocketAddress.  The
-# difference between SocketAddressLegacy and SocketAddress is that the
-# latter is a flat union rather than a simple union. Flat is nicer
-# because it avoids nesting on the wire, i.e. that form has fewer {}.
-
-#
-# Since: 1.3
-##
-{ 'union': 'SocketAddressLegacy',
-  'data': {
-    'inet': 'InetSocketAddress',
-    'unix': 'UnixSocketAddress',
-    'vsock': 'VsockSocketAddress',
-    'fd': 'String' } }
-
-##
-# @SocketAddressType:
-#
-# Available SocketAddress types
-#
-# @inet:  Internet address
-#
-# @unix:  Unix domain socket
-#
-# Since: 2.9
-##
-{ 'enum': 'SocketAddressType',
-  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
-
-##
-# @SocketAddress:
-#
-# Captures the address of a socket, which could also be a named file
-# descriptor
-#
-# @type:       Transport type
-#
-# Since: 2.9
-##
-{ 'union': 'SocketAddress',
-  'base': { 'type': 'SocketAddressType' },
-  'discriminator': 'type',
-  'data': { 'inet': 'InetSocketAddress',
-            'unix': 'UnixSocketAddress',
-            'vsock': 'VsockSocketAddress',
-            'fd': 'String' } }
-
-##
 # @getfd:
 #
 # Receive a file descriptor via SCM rights and assign it a name
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602150..5379674292 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4,8 +4,8 @@
 # =3D=3D QAPI block core definitions (vm unrelated)
 ##
=20
-# QAPI common definitions
 { 'include': 'common.json' }
+{ 'include': 'sockets.json' }
=20
 ##
 # @SnapshotInfo:
diff --git a/qapi/common.json b/qapi/common.json
index 8355d5a2f3..862e73f982 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -162,3 +162,14 @@
 ##
 { 'enum': 'OnOffSplit',
   'data': [ 'on', 'off', 'split' ] }
+
+##
+# @String:
+#
+# A fat type wrapping 'str', to be embedded in lists.
+#
+# Since: 1.2
+##
+{ 'struct': 'String',
+  'data': {
+    'str': 'str' } }
diff --git a/qapi/sockets.json b/qapi/sockets.json
new file mode 100644
index 0000000000..ac022c6ad0
--- /dev/null
+++ b/qapi/sockets.json
@@ -0,0 +1,147 @@
+# -*- Mode: Python -*-
+
+##
+# =3D Socket data types
+##
+
+{ 'include': 'common.json' }
+
+##
+# @NetworkAddressFamily:
+#
+# The network address family
+#
+# @ipv4: IPV4 family
+#
+# @ipv6: IPV6 family
+#
+# @unix: unix socket
+#
+# @vsock: vsock family (since 2.8)
+#
+# @unknown: otherwise
+#
+# Since: 2.1
+##
+{ 'enum': 'NetworkAddressFamily',
+  'data': [ 'ipv4', 'ipv6', 'unix', 'vsock', 'unknown' ] }
+
+##
+# @InetSocketAddressBase:
+#
+# @host: host part of the address
+# @port: port part of the address
+##
+{ 'struct': 'InetSocketAddressBase',
+  'data': {
+    'host': 'str',
+    'port': 'str' } }
+
+##
+# @InetSocketAddress:
+#
+# Captures a socket address or address range in the Internet namespace.
+#
+# @numeric: true if the host/port are guaranteed to be numeric,
+#           false if name resolution should be attempted. Defaults to fa=
lse.
+#           (Since 2.9)
+#
+# @to: If present, this is range of possible addresses, with port
+#      between @port and @to.
+#
+# @ipv4: whether to accept IPv4 addresses, default try both IPv4 and IPv=
6
+#
+# @ipv6: whether to accept IPv6 addresses, default try both IPv4 and IPv=
6
+#
+# Since: 1.3
+##
+{ 'struct': 'InetSocketAddress',
+  'base': 'InetSocketAddressBase',
+  'data': {
+    '*numeric':  'bool',
+    '*to': 'uint16',
+    '*ipv4': 'bool',
+    '*ipv6': 'bool' } }
+
+##
+# @UnixSocketAddress:
+#
+# Captures a socket address in the local ("Unix socket") namespace.
+#
+# @path: filesystem path to use
+#
+# Since: 1.3
+##
+{ 'struct': 'UnixSocketAddress',
+  'data': {
+    'path': 'str' } }
+
+##
+# @VsockSocketAddress:
+#
+# Captures a socket address in the vsock namespace.
+#
+# @cid: unique host identifier
+# @port: port
+#
+# Note: string types are used to allow for possible future hostname or
+# service resolution support.
+#
+# Since: 2.8
+##
+{ 'struct': 'VsockSocketAddress',
+  'data': {
+    'cid': 'str',
+    'port': 'str' } }
+
+##
+# @SocketAddressLegacy:
+#
+# Captures the address of a socket, which could also be a named file des=
criptor
+#
+# Note: This type is deprecated in favor of SocketAddress.  The
+# difference between SocketAddressLegacy and SocketAddress is that the
+# latter is a flat union rather than a simple union. Flat is nicer
+# because it avoids nesting on the wire, i.e. that form has fewer {}.
+
+#
+# Since: 1.3
+##
+{ 'union': 'SocketAddressLegacy',
+  'data': {
+    'inet': 'InetSocketAddress',
+    'unix': 'UnixSocketAddress',
+    'vsock': 'VsockSocketAddress',
+    'fd': 'String' } }
+
+##
+# @SocketAddressType:
+#
+# Available SocketAddress types
+#
+# @inet:  Internet address
+#
+# @unix:  Unix domain socket
+#
+# Since: 2.9
+##
+{ 'enum': 'SocketAddressType',
+  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
+
+##
+# @SocketAddress:
+#
+# Captures the address of a socket, which could also be a named file
+# descriptor
+#
+# @type:       Transport type
+#
+# Since: 2.9
+##
+{ 'union': 'SocketAddress',
+  'base': { 'type': 'SocketAddressType' },
+  'discriminator': 'type',
+  'data': { 'inet': 'InetSocketAddress',
+            'unix': 'UnixSocketAddress',
+            'vsock': 'VsockSocketAddress',
+            'fd': 'String' } }
--=20
2.13.5

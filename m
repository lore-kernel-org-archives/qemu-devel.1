Received: from eggs.gnu.org ([209.51.188.92]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4Gs-0001X4-AA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4Gq-0008Q7-Ep
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:24:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gs4Go-0008Oi-J5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:24:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDAD62D0FB2
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:24:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Feb 2019 12:23:46 +0100
Message-Id: <20190208112357.31615-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-1-marcandre.lureau@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/13] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
review, let's define a common set of backend conventions to help with
management layer implementation, and interoperability.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS                  |   1 +
 docs/interop/vhost-user.json | 232 +++++++++++++++++++++++++++++++++++
 docs/interop/vhost-user.txt  | 101 ++++++++++++++-
 3 files changed, 332 insertions(+), 2 deletions(-)
 create mode 100644 docs/interop/vhost-user.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845581..16b6264412 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1421,6 +1421,7 @@ vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
 F: hw/*/*vhost*
+F: docs/interop/vhost-user.json
 F: docs/interop/vhost-user.txt
 F: contrib/vhost-user-*/
=20
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
new file mode 100644
index 0000000000..ae88c03117
--- /dev/null
+++ b/docs/interop/vhost-user.json
@@ -0,0 +1,232 @@
+# -*- Mode: Python -*-
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# Authors:
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+##
+# =3D vhost user backend discovery & capabilities
+##
+
+##
+# @VHostUserBackendType:
+#
+# List the various vhost user backend types.
+#
+# @9p: 9p virtio console
+# @balloon: virtio balloon
+# @block: virtio block
+# @caif: virtio caif
+# @console: virtio console
+# @crypto: virtio crypto
+# @gpu: virtio gpu
+# @input: virtio input
+# @net: virtio net
+# @rng: virtio rng
+# @rpmsg: virtio remote processor messaging
+# @rproc-serial: virtio remoteproc serial link
+# @scsi: virtio scsi
+# @vsock: virtio vsock transport
+#
+# Since: 4.0
+##
+{
+  'enum': 'VHostUserBackendType',
+  'data': [
+      '9p',
+      'balloon',
+      'block',
+      'caif',
+      'console',
+      'crypto',
+      'gpu',
+      'input',
+      'net',
+      'rng',
+      'rpmsg',
+      'rproc-serial',
+      'scsi',
+      'vsock'
+  ]
+}
+
+##
+# @VHostUserBackendInputFeature:
+#
+# List of vhost user "input" features.
+#
+# @evdev-path: The --evdev-path command line option is supported.
+# @no-grab: The --no-grab command line option is supported.
+#
+# Since: 4.0
+##
+{
+  'enum': 'VHostUserBackendInputFeature',
+  'data': [ 'evdev-path', 'no-grab' ]
+}
+
+##
+# @VHostUserBackendCapabilitiesInput:
+#
+# Capabilities reported by vhost user "input" backends
+#
+# @features: list of supported features.
+#
+# Since: 4.0
+##
+{
+  'struct': 'VHostUserBackendCapabilitiesInput',
+  'data': {
+    'features': [ 'VHostUserBackendInputFeature' ]
+  }
+}
+
+##
+# @VHostUserBackendGPUFeature:
+#
+# List of vhost user "gpu" features.
+#
+# @render-node: The --render-node command line option is supported.
+# @virgl: The --virgl command line option is supported.
+#
+# Since: 4.0
+##
+{
+  'enum': 'VHostUserBackendGPUFeature',
+  'data': [ 'render-node', 'virgl' ]
+}
+
+##
+# @VHostUserBackendCapabilitiesGPU:
+#
+# Capabilities reported by vhost user "gpu" backends.
+#
+# @features: list of supported features.
+#
+# Since: 4.0
+##
+{
+  'struct': 'VHostUserBackendCapabilitiesGPU',
+  'data': {
+    'features': [ 'VHostUserBackendGPUFeature' ]
+  }
+}
+
+##
+# @VHostUserBackendCapabilities:
+#
+# Capabilities reported by vhost user backends.
+#
+# @type: The vhost user backend type.
+#
+# Since: 4.0
+##
+{
+  'union': 'VHostUserBackendCapabilities',
+  'base': { 'type': 'VHostUserBackendType' },
+  'discriminator': 'type',
+  'data': {
+    'input': 'VHostUserBackendCapabilitiesInput',
+    'gpu': 'VHostUserBackendCapabilitiesGPU'
+  }
+}
+
+##
+# @VhostUserBackend:
+#
+# Describes a vhost user backend to management software.
+#
+# It is possible for multiple @VhostUserBackend elements to match the
+# search criteria of management software. Applications thus need rules
+# to pick one of the many matches, and users need the ability to
+# override distro defaults.
+#
+# It is recommended to create vhost user backend JSON files (each
+# containing a single @VhostUserBackend root element) with a
+# double-digit prefix, for example "50-qemu-gpu.json",
+# "50-crosvm-gpu.json", etc, so they can be sorted in predictable
+# order. The backend JSON files should be searched for in three
+# directories:
+#
+#   - /usr/share/qemu/vhost-user -- populated by distro-provided
+#                                   packages (XDG_DATA_DIRS covers
+#                                   /usr/share by default),
+#
+#   - /etc/qemu/vhost-user -- exclusively for sysadmins' local additions=
,
+#
+#   - $XDG_CONFIG_HOME/qemu/vhost-user -- exclusively for per-user local
+#                                         additions (XDG_CONFIG_HOME
+#                                         defaults to $HOME/.config).
+#
+# Top-down, the list of directories goes from general to specific.
+#
+# Management software should build a list of files from all three
+# locations, then sort the list by filename (i.e., basename
+# component). Management software should choose the first JSON file on
+# the sorted list that matches the search criteria. If a more specific
+# directory has a file with same name as a less specific directory,
+# then the file in the more specific directory takes effect. If the
+# more specific file is zero length, it hides the less specific one.
+#
+# For example, if a distro ships
+#
+#   - /usr/share/qemu/vhost-user/50-qemu-gpu.json
+#
+#   - /usr/share/qemu/vhost-user/50-crosvm-gpu.json
+#
+# then the sysadmin can prevent the default QEMU being used at all with
+#
+#   $ touch /etc/qemu/vhost-user/50-qemu-gpu.json
+#
+# The sysadmin can replace/alter the distro default OVMF with
+#
+#   $ vim /etc/qemu/vhost-user/50-qemu-gpu.json
+#
+# or they can provide a parallel QEMU GPU with higher priority
+#
+#   $ vim /etc/qemu/vhost-user/10-qemu-gpu.json
+#
+# or they can provide a parallel OVMF with lower priority
+#
+#   $ vim /etc/qemu/vhost-user/99-qemu-gpu.json
+#
+# @type: The vhost user backend type.
+#
+# @description: Provides a human-readable description of the backend.
+#               Management software may or may not display @description.
+#
+# @binary: Absolute path to the backend binary.
+#
+# @tags: An optional list of auxiliary strings associated with the
+#        backend for which @description is not appropriate, due to the
+#        latter's possible exposure to the end-user. @tags serves
+#        development and debugging purposes only, and management
+#        software shall explicitly ignore it.
+#
+# Since: 4.0
+#
+# Example:
+#
+# {
+#   "description": "QEMU vhost-user-gpu",
+#   "type": "gpu",
+#   "binary": "/usr/libexec/qemu/vhost-user-gpu",
+#   "tags": [
+#     "CONFIG_OPENGL_DMABUF=3Dy"
+#   ]
+# }
+#
+##
+{
+  'struct' : 'VhostUserBackend',
+  'data'   : {
+    'description': 'str',
+    'type': 'VHostUserBackendType',
+    'binary': 'str',
+    '*tags': [ 'str' ]
+  }
+}
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index c2194711d9..9ee2a60cfb 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication, mas=
ter and slave. Master is
 the application that shares its virtqueues, in our case QEMU. Slave is t=
he
 consumer of the virtqueues.
=20
-In the current implementation QEMU is the Master, and the Slave is inten=
ded to
-be a software Ethernet switch running in user space, such as Snabbswitch=
.
+In the current implementation QEMU is the Master, and the Slave is the
+external process consuming the virtio queues, for example a software
+Ethernet switch running in user space, such as Snabbswitch, or a block
+device backend processing read & write to a virtual disk. In order to
+facilitate interoperability between various backend implementations,
+it is recommended to follow the "Backend program conventions"
+described in this document.
=20
 Master and slave can be either a client (i.e. connecting) or server (lis=
tening)
 in the socket communication.
@@ -835,3 +840,95 @@ resilient for selective requests.
 For the message types that already solicit a reply from the client, the
 presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being set =
brings
 no behavioural change. (See the 'Communication' section for details.)
+
+Backend program conventions
+---------------------------
+
+vhost-user backends can provide various devices & services and may
+need to be configured manually depending on the use case. However, it
+is a good idea to follow the conventions listed here when
+possible. Users, QEMU or libvirt, can then rely on some common
+behaviour to avoid heterogenous configuration and management of the
+backend programs and facilitate interoperability.
+
+Each backend installed on a host system should come with at least one
+JSON file that conforms to the vhost-user.json schema. Each file
+informs the management applications about the backend type, and binary
+location. In addition, it defines rules for management apps for
+picking the highest priority backend when multiple match the search
+criteria (see @VhostUserBackend documentation in the schema file).
+
+If the backend is not capable of enabling a requested feature on the
+host (such as 3D acceleration with virgl), or the initialization
+failed, the backend should fail to start early and exit with a status
+!=3D 0. It may also print a message to stderr for further details.
+
+The backend program must not daemonize itself, but it may be
+daemonized by the management layer. It may also have a restricted
+access to the system.
+
+File descriptors 0, 1 and 2 will exist, and have regular
+stdin/stdout/stderr usage (they may have been redirected to /dev/null
+by the management layer, or to a log handler).
+
+The backend program must end (as quickly and cleanly as possible) when
+the SIGTERM signal is received. Eventually, it may receive SIGKILL by
+the management layer after a few seconds.
+
+The following command line options have an expected behaviour. They
+are mandatory, unless explicitly said differently:
+
+* --socket-path=3DPATH
+
+This option specify the location of the vhost-user Unix domain socket.
+It is incompatible with --fd.
+
+* --fd=3DFDNUM
+
+When this argument is given, the backend program is started with the
+vhost-user socket as file descriptor FDNUM. It is incompatible with
+--socket-path.
+
+* --print-capabilities
+
+Output to stdout the backend capabilities in JSON format, and then
+exit successfully. Other options and arguments should be ignored, and
+the backend program should not perform its normal function.  The
+capabilities can be reported dynamically depending on the host
+capabilities.
+
+The JSON output is described in the vhost-user.json schema, by
+@VHostUserBackendCapabilities.  Example:
+{
+  "type": "foo",
+  "features": [
+    "feature-a",
+    "feature-b"
+  ]
+}
+
+vhost-user-input
+----------------
+
+Command line options:
+
+* --evdev-path=3DPATH (optional)
+
+Specify the linux input device.
+
+* --no-grab (optional)
+
+Do no request exclusive access to the input device.
+
+vhost-user-gpu
+--------------
+
+Command line options:
+
+* --render-node=3DPATH (optional)
+
+Specify the GPU DRM render node.
+
+* --virgl (optional)
+
+Enable virgl rendering support.
--=20
2.20.1.519.g8feddda32c

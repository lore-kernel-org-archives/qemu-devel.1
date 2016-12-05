Received: from eggs.gnu.org ([2001:4830:134:3::10]:47279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOH-0007Vg-0p
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOF-0006x7-K1
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOF-0006wY-Bu
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:19 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A8B319CFF0
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:11 +0100
Message-Id: <1480956313-31322-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] qapi: fix various symbols mismatch in
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

There are various mismatch:
- invalid symbols
- section and member symbols mismatch
- enum or union values vs 'type'

The documentation parser catches all these cases.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20161117155504.21843-7-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 20 +++++++++-----------
 qapi/block-core.json |  4 ----
 qapi/common.json     |  6 +++---
 qapi/rocker.json     |  2 +-
 qga/qapi-schema.json |  6 +++---
 5 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 824d205..9c0b46a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -695,8 +695,6 @@
 #
 # Set various migration parameters.  See MigrationParameters for details=
.
 #
-# @x-checkpoint-delay: the delay time between two checkpoints. (Since 2.=
8)
-#
 # Since: 2.4
 ##
 { 'command': 'migrate-set-parameters', 'boxed': true,
@@ -1173,7 +1171,7 @@
            '*service': 'str', '*auth': 'str', '*clients': ['VncClientInf=
o']} }
=20
 ##
-# @VncPriAuth:
+# @VncPrimaryAuth:
 #
 # vnc primary authentication method.
 #
@@ -3176,7 +3174,7 @@
 #
 # @alias: #optional an alias for the machine name
 #
-# @default: #optional whether the machine is default
+# @is-default: #optional whether the machine is default
 #
 # @cpu-max: maximum number of CPUs supported by the machine type
 #           (since 1.5.0)
@@ -3729,7 +3727,6 @@
 #
 # @device: The name of the special file for the device,
 #          i.e. /dev/ttyS0 on Unix or COM1: on Windows
-# @type: What kind of device this is.
 #
 # Since: 1.4
 ##
@@ -3994,7 +3991,7 @@
 #
 # A union referencing different TPM backend types' configuration options
 #
-# @passthrough: The configuration options for the TPM passthrough type
+# @type: 'passthrough' The configuration options for the TPM passthrough=
 type
 #
 # Since: 1.5
 ##
@@ -4002,7 +3999,7 @@
    'data': { 'passthrough' : 'TPMPassthroughOptions' } }
=20
 ##
-# @TpmInfo:
+# @TPMInfo:
 #
 # Information about the TPM
 #
@@ -4346,10 +4343,11 @@
 #
 # Input event union.
 #
-# @key: Input event of Keyboard
-# @btn: Input event of pointer buttons
-# @rel: Input event of relative pointer motion
-# @abs: Input event of absolute pointer motion
+# @type: the input type, one of:
+#  - 'key': Input event of Keyboard
+#  - 'btn': Input event of pointer buttons
+#  - 'rel': Input event of relative pointer motion
+#  - 'abs': Input event of absolute pointer motion
 #
 # Since: 2.0
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d98fe73..33bc93a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2160,10 +2160,6 @@
 #
 # @type:       Transport type used for gluster connection
 #
-# @unix:       socket file
-#
-# @tcp:        host address and port number
-#
 # This is similar to SocketAddress, only distinction:
 #
 # 1. GlusterServer is a flat union, SocketAddress is a simple union.
diff --git a/qapi/common.json b/qapi/common.json
index 9353a7b..6987100 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -34,11 +34,11 @@
 #
 # A three-part version number.
 #
-# @qemu.major:  The major version number.
+# @major:  The major version number.
 #
-# @qemu.minor:  The minor version number.
+# @minor:  The minor version number.
 #
-# @qemu.micro:  The micro version number.
+# @micro:  The micro version number.
 #
 # Since: 2.4
 ##
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 2fe7fdf..ace2776 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,5 +1,5 @@
 ##
-# @Rocker:
+# @RockerSwitch:
 #
 # Rocker switch information.
 #
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 7a35267..ad0a31d 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -203,7 +203,7 @@
 #
 # Open a file in the guest and retrieve a file handle for it
 #
-# @filepath: Full path to the file in the guest to open.
+# @path: Full path to the file in the guest to open.
 #
 # @mode: #optional open mode, as per fopen(), "r" is the default.
 #
@@ -378,7 +378,7 @@
   'data': { 'handle': 'int' } }
=20
 ##
-# @GuestFsFreezeStatus
+# @GuestFsfreezeStatus
 #
 # An enumeration of filesystem freeze states
 #
@@ -770,7 +770,7 @@
 # @GuestDiskAddress:
 #
 # @pci-controller: controller's PCI address
-# @type: bus type
+# @bus-type: bus type
 # @bus: bus id
 # @target: target id
 # @unit: unit id
--=20
2.5.5

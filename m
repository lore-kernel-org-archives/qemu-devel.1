Received: from eggs.gnu.org ([2001:4830:134:3::10]:51546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1N-0006fK-Ly
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1L-0001hs-CD
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1L-0001ga-1f
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 022F2C057FA1
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A8BA7FB9F
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:39 +0200
Message-Id: <20170901153758.8628-29-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 28/47] qapi-schema: Fold event.json back into
 qapi-schema.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-14-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile         |   2 +-
 qapi-schema.json | 134 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 qapi/event.json  | 138 -------------------------------------------------=
------
 3 files changed, 134 insertions(+), 140 deletions(-)
 delete mode 100644 qapi/event.json

diff --git a/Makefile b/Makefile
index 3dde210662..337a1f6f9b 100644
--- a/Makefile
+++ b/Makefile
@@ -412,7 +412,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
-               $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.j=
son \
+               $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/migration.json \
                $(SRC_PATH)/qapi/net.json \
                $(SRC_PATH)/qapi/rocker.json \
diff --git a/qapi-schema.json b/qapi-schema.json
index 0ad4e0237d..4964d927bd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -90,7 +90,6 @@
 { 'include': 'qapi/ui.json' }
 { 'include': 'qapi/migration.json' }
 { 'include': 'qapi/transaction.json' }
-{ 'include': 'qapi/event.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
=20
@@ -552,6 +551,28 @@
 { 'command': 'query-balloon', 'returns': 'BalloonInfo' }
=20
 ##
+# @BALLOON_CHANGE:
+#
+# Emitted when the guest changes the actual BALLOON level. This value is
+# equivalent to the @actual field return by the 'query-balloon' command
+#
+# @actual: actual level of the guest memory balloon in bytes
+#
+# Note: this event is rate-limited.
+#
+# Since: 1.2
+#
+# Example:
+#
+# <- { "event": "BALLOON_CHANGE",
+#      "data": { "actual": 944766976 },
+#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
+##
+{ 'event': 'BALLOON_CHANGE',
+  'data': { 'actual': 'int' } }
+
+##
 # @PciMemoryRange:
 #
 # A PCI device memory region
@@ -1434,6 +1455,30 @@
 { 'command': 'device_del', 'data': {'id': 'str'} }
=20
 ##
+# @DEVICE_DELETED:
+#
+# Emitted whenever the device removal completion is acknowledged by the =
guest.
+# At this point, it's safe to reuse the specified device ID. Device remo=
val can
+# be initiated by the guest or by HMP/QMP commands.
+#
+# @device: device name
+#
+# @path: device path
+#
+# Since: 1.5
+#
+# Example:
+#
+# <- { "event": "DEVICE_DELETED",
+#      "data": { "device": "virtio-net-pci-0",
+#                "path": "/machine/peripheral/virtio-net-pci-0" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'DEVICE_DELETED',
+  'data': { '*device': 'str', 'path': 'str' } }
+
+##
 # @DumpGuestMemoryFormat:
 #
 # An enumeration of guest-memory-dump's format.
@@ -1569,6 +1614,29 @@
 { 'command': 'query-dump', 'returns': 'DumpQueryResult' }
=20
 ##
+# @DUMP_COMPLETED:
+#
+# Emitted when background dump has completed
+#
+# @result: DumpQueryResult type described in qapi-schema.json.
+#
+# @error: human-readable error string that provides
+#         hint on why dump failed. Only presents on failure. The
+#         user should not try to interpret the error string.
+#
+# Since: 2.6
+#
+# Example:
+#
+# { "event": "DUMP_COMPLETED",
+#   "data": {"result": {"total": 1090650112, "status": "completed",
+#                       "completed": 1090650112} } }
+#
+##
+{ 'event': 'DUMP_COMPLETED' ,
+  'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
+
+##
 # @DumpGuestMemoryCapability:
 #
 # A list of the available formats for dump-guest-memory
@@ -2652,6 +2720,29 @@
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
=20
 ##
+# @MEM_UNPLUG_ERROR:
+#
+# Emitted when memory hot unplug error occurs.
+#
+# @device: device name
+#
+# @msg: Informative message
+#
+# Since: 2.4
+#
+# Example:
+#
+# <- { "event": "MEM_UNPLUG_ERROR"
+#      "data": { "device": "dimm1",
+#                "msg": "acpi: device unplug for unsupported device"
+#      },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'MEM_UNPLUG_ERROR',
+  'data': { 'device': 'str', 'msg': 'str' } }
+
+##
 # @ACPISlotType:
 #
 # @DIMM: memory slot
@@ -2706,6 +2797,25 @@
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
=20
 ##
+# @ACPI_DEVICE_OST:
+#
+# Emitted when guest executes ACPI _OST method.
+#
+# @info: ACPIOSTInfo type as described in qapi-schema.json
+#
+# Since: 2.1
+#
+# Example:
+#
+# <- { "event": "ACPI_DEVICE_OST",
+#      "data": { "device": "d1", "slot": "0",
+#                "slot-type": "DIMM", "source": 1, "status": 0 } }
+#
+##
+{ 'event': 'ACPI_DEVICE_OST',
+     'data': { 'info': 'ACPIOSTInfo' } }
+
+##
 # @IoOperationType:
 #
 # An enumeration of the I/O operation types
@@ -2738,6 +2848,28 @@
 { 'command': 'rtc-reset-reinjection' }
=20
 ##
+# @RTC_CHANGE:
+#
+# Emitted when the guest changes the RTC time.
+#
+# @offset: offset between base RTC clock (as specified by -rtc base), an=
d
+#          new RTC clock value
+#
+# Note: This event is rate-limited.
+#
+# Since: 0.13.0
+#
+# Example:
+#
+# <-   { "event": "RTC_CHANGE",
+#        "data": { "offset": 78 },
+#        "timestamp": { "seconds": 1267020223, "microseconds": 435656 } =
}
+#
+##
+{ 'event': 'RTC_CHANGE',
+  'data': { 'offset': 'int' } }
+
+##
 # @ReplayMode:
 #
 # Mode of the replay subsystem.
diff --git a/qapi/event.json b/qapi/event.json
deleted file mode 100644
index 48a5d8fb21..0000000000
--- a/qapi/event.json
+++ /dev/null
@@ -1,138 +0,0 @@
-# -*- Mode: Python -*-
-
-##
-# =3D Other events
-##
-
-##
-# @RTC_CHANGE:
-#
-# Emitted when the guest changes the RTC time.
-#
-# @offset: offset between base RTC clock (as specified by -rtc base), an=
d
-#          new RTC clock value
-#
-# Note: This event is rate-limited.
-#
-# Since: 0.13.0
-#
-# Example:
-#
-# <-   { "event": "RTC_CHANGE",
-#        "data": { "offset": 78 },
-#        "timestamp": { "seconds": 1267020223, "microseconds": 435656 } =
}
-#
-##
-{ 'event': 'RTC_CHANGE',
-  'data': { 'offset': 'int' } }
-
-##
-# @DEVICE_DELETED:
-#
-# Emitted whenever the device removal completion is acknowledged by the =
guest.
-# At this point, it's safe to reuse the specified device ID. Device remo=
val can
-# be initiated by the guest or by HMP/QMP commands.
-#
-# @device: device name
-#
-# @path: device path
-#
-# Since: 1.5
-#
-# Example:
-#
-# <- { "event": "DEVICE_DELETED",
-#      "data": { "device": "virtio-net-pci-0",
-#                "path": "/machine/peripheral/virtio-net-pci-0" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-#
-##
-{ 'event': 'DEVICE_DELETED',
-  'data': { '*device': 'str', 'path': 'str' } }
-
-##
-# @ACPI_DEVICE_OST:
-#
-# Emitted when guest executes ACPI _OST method.
-#
-# @info: ACPIOSTInfo type as described in qapi-schema.json
-#
-# Since: 2.1
-#
-# Example:
-#
-# <- { "event": "ACPI_DEVICE_OST",
-#      "data": { "device": "d1", "slot": "0",
-#                "slot-type": "DIMM", "source": 1, "status": 0 } }
-#
-##
-{ 'event': 'ACPI_DEVICE_OST',
-     'data': { 'info': 'ACPIOSTInfo' } }
-
-##
-# @BALLOON_CHANGE:
-#
-# Emitted when the guest changes the actual BALLOON level. This value is
-# equivalent to the @actual field return by the 'query-balloon' command
-#
-# @actual: actual level of the guest memory balloon in bytes
-#
-# Note: this event is rate-limited.
-#
-# Since: 1.2
-#
-# Example:
-#
-# <- { "event": "BALLOON_CHANGE",
-#      "data": { "actual": 944766976 },
-#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
-#
-##
-{ 'event': 'BALLOON_CHANGE',
-  'data': { 'actual': 'int' } }
-
-##
-# @MEM_UNPLUG_ERROR:
-#
-# Emitted when memory hot unplug error occurs.
-#
-# @device: device name
-#
-# @msg: Informative message
-#
-# Since: 2.4
-#
-# Example:
-#
-# <- { "event": "MEM_UNPLUG_ERROR"
-#      "data": { "device": "dimm1",
-#                "msg": "acpi: device unplug for unsupported device"
-#      },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-#
-##
-{ 'event': 'MEM_UNPLUG_ERROR',
-  'data': { 'device': 'str', 'msg': 'str' } }
-
-##
-# @DUMP_COMPLETED:
-#
-# Emitted when background dump has completed
-#
-# @result: DumpQueryResult type described in qapi-schema.json.
-#
-# @error: human-readable error string that provides
-#         hint on why dump failed. Only presents on failure. The
-#         user should not try to interpret the error string.
-#
-# Since: 2.6
-#
-# Example:
-#
-# { "event": "DUMP_COMPLETED",
-#   "data": {"result": {"total": 1090650112, "status": "completed",
-#                       "completed": 1090650112} } }
-#
-##
-{ 'event': 'DUMP_COMPLETED' ,
-  'data': { 'result': 'DumpQueryResult', '*error': 'str' } }
--=20
2.13.5

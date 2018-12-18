Received: from eggs.gnu.org ([2001:4830:134:3::10]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCK1-000624-Lu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJv-000879-Bd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJu-00080Z-Qr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:47 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 11:09:37 +0100
Message-Id: <20181218100941.25267-4-armbru@redhat.com>
In-Reply-To: <20181218100941.25267-1-armbru@redhat.com>
References: <20181218100941.25267-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] qmp: Split ShutdownCause host-qmp into quit
 and system-reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dominik Csapak <d.csapak@proxmox.com>

From: Dominik Csapak <d.csapak@proxmox.com>

It is interesting to know whether the shutdown cause was 'quit' or
'reset', especially when using "--no-reboot". In that case, a management
layer can now determine if the guest wanted a reboot or shutdown, and
can act accordingly.

Changes the output of the reason in the iotests from 'host-qmp' to
'host-qmp-quit'. This does not break compatibility because
the field was introduced in the same version.

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
Message-Id: <20181205110131.23049-4-d.csapak@proxmox.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/run-state.json        | 10 +++++----
 qmp.c                      |  4 ++--
 tests/qemu-iotests/060.out |  4 ++--
 tests/qemu-iotests/071.out |  4 ++--
 tests/qemu-iotests/081.out | 14 ++++++------
 tests/qemu-iotests/087.out | 12 +++++------
 tests/qemu-iotests/094.out |  2 +-
 tests/qemu-iotests/109.out | 44 +++++++++++++++++++-------------------
 tests/qemu-iotests/117.out |  2 +-
 tests/qemu-iotests/119.out |  2 +-
 tests/qemu-iotests/120.out |  2 +-
 tests/qemu-iotests/127.out |  2 +-
 tests/qemu-iotests/140.out |  2 +-
 tests/qemu-iotests/143.out |  2 +-
 tests/qemu-iotests/156.out |  2 +-
 tests/qemu-iotests/176.out | 16 +++++++-------
 tests/qemu-iotests/183.out |  4 ++--
 tests/qemu-iotests/184.out |  8 +++----
 tests/qemu-iotests/185.out | 10 ++++-----
 tests/qemu-iotests/191.out |  4 ++--
 tests/qemu-iotests/195.out |  4 ++--
 tests/qemu-iotests/223.out |  2 +-
 tests/qemu-iotests/227.out |  8 +++----
 23 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 436ba4e14e..d7477cd715 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -68,7 +68,9 @@
 #
 # @host-error: An error prevents further use of guest
 #
-# @host-qmp: Reaction to a QMP command, like 'quit'
+# @host-qmp-quit: Reaction to the QMP command 'quit'
+#
+# @host-qmp-system-reset: Reaction to the QMP command 'system_reset'
 #
 # @host-signal: Reaction to a signal, such as SIGINT
 #
@@ -89,9 +91,9 @@
 ##
 { 'enum': 'ShutdownCause',
   # Beware, shutdown_caused_by_guest() depends on enumeration order
-  'data': [ 'none', 'host-error', 'host-qmp', 'host-signal', 'host-ui',
-            'guest-shutdown', 'guest-reset', 'guest-panic',
-            'subsystem-reset'] }
+  'data': [ 'none', 'host-error', 'host-qmp-quit', 'host-qmp-system-reset',
+            'host-signal', 'host-ui', 'guest-shutdown', 'guest-reset',
+            'guest-panic', 'subsystem-reset'] }
 
 ##
 # @StatusInfo:
diff --git a/qmp.c b/qmp.c
index e7c0a2fd60..82298f6cb0 100644
--- a/qmp.c
+++ b/qmp.c
@@ -88,7 +88,7 @@ UuidInfo *qmp_query_uuid(Error **errp)
 void qmp_quit(Error **errp)
 {
     no_shutdown = 0;
-    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP);
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_QUIT);
 }
 
 void qmp_stop(Error **errp)
@@ -109,7 +109,7 @@ void qmp_stop(Error **errp)
 
 void qmp_system_reset(Error **errp)
 {
-    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
+    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
 }
 
 void qmp_system_powerdown(Error **erp)
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 27c3287771..af623cfd86 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -419,7 +419,7 @@ QMP_VERSION
 write failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 === Testing incoming inactive corrupted image ===
 
@@ -430,7 +430,7 @@ qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); fur
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
     corrupt: false
 *** done
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index c1e8d9e83b..bca0c02f5c 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -46,7 +46,7 @@ QMP_VERSION
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Testing blkverify on existing block device ===
@@ -85,7 +85,7 @@ wrote 512/512 bytes at offset 0
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
 
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 4ac8a468aa..8ec1783ffe 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -36,7 +36,7 @@ read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 == using quorum rewrite corrupted mode ==
@@ -80,7 +80,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing:
 QMP_VERSION
@@ -89,7 +89,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot add a child to a quorum in blkverify mode"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 == dynamically removing a child from a quorum ==
@@ -99,7 +99,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing:
 QMP_VERSION
@@ -107,7 +107,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "The number of children cannot be lower than the vote threshold 2"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing:
 QMP_VERSION
@@ -115,7 +115,7 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "blkverify=on can only be set if there are exactly two files and vote-threshold is 2"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=drive0-quorum nor node_name=drive0-quorum"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing:
 QMP_VERSION
@@ -123,6 +123,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "The number of children cannot be lower than the vote threshold 2"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 *** done
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index ea9d73968a..2d92ea847b 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -8,7 +8,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Duplicate ID ===
@@ -19,7 +19,7 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "node-name=disk is conflicting with a device id"}}
 {"error": {"class": "GenericError", "desc": "Duplicate node name"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === aio=native without O_DIRECT ===
@@ -29,7 +29,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "aio=native was specified, but it requires cache.direct=on, which was not specified."}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Encrypted image QCow ===
@@ -41,7 +41,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Encrypted image LUKS ===
@@ -53,7 +53,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Missing driver ===
@@ -64,6 +64,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Parameter 'driver' is missing"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 *** done
diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index e9af88c2f9..f3b9ecf22b 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -14,5 +14,5 @@ Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 6382bcc626..9c1159bf08 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -18,7 +18,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -29,7 +29,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -56,7 +56,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -67,7 +67,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
@@ -94,7 +94,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -105,7 +105,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -132,7 +132,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -143,7 +143,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
@@ -170,7 +170,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -181,7 +181,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
@@ -208,7 +208,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -219,7 +219,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -245,7 +245,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -256,7 +256,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
@@ -282,7 +282,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -293,7 +293,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
@@ -319,7 +319,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -330,7 +330,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
@@ -356,7 +356,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": []}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
@@ -367,7 +367,7 @@ read 65536/65536 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
@@ -390,7 +390,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
@@ -406,7 +406,7 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index be52974a13..57079af167 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -7,7 +7,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 No errors were found on the image.
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/119.out b/tests/qemu-iotests/119.out
index a8ff6a6373..7b7f0f4bcc 100644
--- a/tests/qemu-iotests/119.out
+++ b/tests/qemu-iotests/119.out
@@ -6,6 +6,6 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 *** done
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index f13b3cf8d4..0744c1f136 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -6,7 +6,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index b5012cd1fb..6c98b1824e 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -17,5 +17,5 @@ wrote 42/42 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 1402128bbd..704adcef40 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -11,5 +11,5 @@ read 65536/65536 bytes at offset 0
 can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: Requested export not available
 server reported: export 'drv' not present
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 67cafc5736..3e55fcd0ac 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -4,5 +4,5 @@ QA output created by 143
 can't open device nbd+unix:///no_such_export?socket=TEST_DIR/nbd: Requested export not available
 server reported: export 'no_such_export' not present
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 16dfc692b5..4c391a7603 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -41,7 +41,7 @@ read 65536/65536 bytes at offset 196608
 {"return": ""}
 
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index cbca97405f..cc33def96b 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -170,7 +170,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -207,7 +207,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 === Test pass bitmap.1 ===
 
@@ -219,7 +219,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -257,7 +257,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 === Test pass bitmap.2 ===
 
@@ -269,7 +269,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -307,7 +307,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 === Test pass bitmap.3 ===
 
@@ -319,7 +319,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -354,5 +354,5 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index 7b8455e269..112cf31f8b 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -36,8 +36,8 @@ wrote 65536/65536 bytes at offset 1048576
 
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 No errors were found on the image.
 No errors were found on the image.
 wrote 65536/65536 bytes at offset 1048576
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 0ce9e48541..3deb3cfb94 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -95,7 +95,7 @@ Testing:
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -175,7 +175,7 @@ Testing:
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -217,7 +217,7 @@ Testing:
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -253,7 +253,7 @@ Testing:
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 25f4b09775..ddfbf3c765 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -21,7 +21,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "commit"}}
 
 === Start active commit job and exit qemu ===
@@ -31,7 +31,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
 
 === Start mirror job and exit qemu ===
@@ -42,7 +42,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 
 === Start backup job and exit qemu ===
@@ -53,7 +53,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 65536, "speed": 65536, "type": "backup"}}
 
 === Start streaming job and exit qemu ===
@@ -63,7 +63,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "stream"}}
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 99e4e29a04..a513ccca0b 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -390,7 +390,7 @@ wrote 65536/65536 bytes at offset 1048576
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 image: TEST_DIR/t.IMGFMT
@@ -808,7 +808,7 @@ wrote 65536/65536 bytes at offset 1048576
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 image: TEST_DIR/t.IMGFMT
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index 07e7173ff0..1e9330b1be 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -29,7 +29,7 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,backing.node-name=mid
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -67,7 +67,7 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index ba2d8273f3..99ca172fbb 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -12,7 +12,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Write part of the file under active bitmap ===
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index 2c2e9fb275..e77efaf4cf 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -54,7 +54,7 @@ Testing: -drive driver=null-co,if=virtio
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -112,7 +112,7 @@ Testing: -drive driver=null-co,if=none
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -143,7 +143,7 @@ Testing: -blockdev driver=null-co,node-name=null
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
@@ -202,7 +202,7 @@ Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,i
     "event": "SHUTDOWN",
     "data": {
         "guest": false,
-        "reason": "host-qmp"
+        "reason": "host-qmp-quit"
     }
 }
 
-- 
2.17.2

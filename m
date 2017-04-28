Received: from eggs.gnu.org ([2001:4830:134:3::10]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3vQ3-0006fN-6b
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 22:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3vQ1-00025u-9t
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 22:14:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 27 Apr 2017 21:13:17 -0500
Message-Id: <20170428021317.24711-5-eblake@redhat.com>
In-Reply-To: <20170428021317.24711-1-eblake@redhat.com>
References: <20170428021317.24711-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/4] RFC: shutdown: Expose full
 ShutdownCause across QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Since all reset/shutdown requests have been associated with a
reason, we can expose the full reason rather than a simple bool
to the guest. Document that any future additions to the enum
type will still use a 'host-' or 'guest-' prefix.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
v3: new patch. If we like this approach better than just the
'guest':'bool' of the previous, then I will squash the two
patches together and tweak the commit message for a v4 posting.
---
 qapi-schema.json           |  5 ++++-
 qapi/event.json            | 17 ++++++-----------
 vl.c                       |  6 ++----
 tests/qemu-iotests/071.out |  4 ++--
 tests/qemu-iotests/081.out |  2 +-
 tests/qemu-iotests/087.out | 12 ++++++------
 tests/qemu-iotests/094.out |  2 +-
 tests/qemu-iotests/117.out |  2 +-
 tests/qemu-iotests/119.out |  2 +-
 tests/qemu-iotests/120.out |  2 +-
 tests/qemu-iotests/140.out |  2 +-
 tests/qemu-iotests/143.out |  2 +-
 tests/qemu-iotests/156.out |  2 +-
 13 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index a4ebdd1..f699f04 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2306,7 +2306,10 @@
 ##
 # @ShutdownCause:
 #
-# Enumeration of various causes for shutdown.
+# Enumeration of various causes for shutdown, used in SHUTDOWN and RESET
+# events.  It is anticipated that if any new reasons are added, the prefix
+# will still make it possible to distinguish whether it was the guest or
+# the host that requested the change in state.
 #
 # @host-qmp: Reaction to a QMP command, such as 'quit'
 # @host-signal: Reaction to a signal, such as SIGINT
diff --git a/qapi/event.json b/qapi/event.json
index 6d22b02..48648ac 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -10,9 +10,7 @@
 # Emitted when the virtual machine has shut down, indicating that qemu is
 # about to exit.
 #
-# @guest: If true, the shutdown was triggered by a guest request (such as
-# a guest-initiated ACPI shutdown request or other hardware-specific action)
-# rather than a host request (such as sending qemu a SIGINT). (since 2.10)
+# @reason: What triggered the reset. (since 2.10)
 #
 # Note: If the command-line option "-no-shutdown" has been specified, qemu will
 # not exit, and a STOP event will eventually follow the SHUTDOWN event
@@ -21,11 +19,11 @@
 #
 # Example:
 #
-# <- { "event": "SHUTDOWN", "data": { "guest": true },
+# <- { "event": "SHUTDOWN", "data": { "reason": "guest-shutdown" },
 #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
 #
 ##
-{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
+{ 'event': 'SHUTDOWN', 'data': { 'reason': 'ShutdownCause' } }

 ##
 # @POWERDOWN:
@@ -48,20 +46,17 @@
 #
 # Emitted when the virtual machine is reset
 #
-# @guest: If true, the reset was triggered by a guest request (such as
-# a guest-initiated ACPI reboot request or other hardware-specific action)
-# rather than a host request (such as the QMP command system_reset).
-# (since 2.10)
+# @reason: What triggered the reset. (since 2.10)
 #
 # Since: 0.12.0
 #
 # Example:
 #
-# <- { "event": "RESET", "data": { "guest": false },
+# <- { "event": "RESET", "data": { "reason": "host-qmp" },
 #      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
 #
 ##
-{ 'event': 'RESET', 'data': { 'guest': 'bool' } }
+{ 'event': 'RESET', 'data': { 'reason': 'ShutdownCause' } }

 ##
 # @STOP:
diff --git a/vl.c b/vl.c
index 0a933ba..e226a59 100644
--- a/vl.c
+++ b/vl.c
@@ -1706,8 +1706,7 @@ void qemu_system_reset(bool report, int reason)
     }
     if (report) {
         assert(reason >= 0);
-        qapi_event_send_reset(reason >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
-                              &error_abort);
+        qapi_event_send_reset(reason, &error_abort);
     }
     cpu_synchronize_all_post_reset();
 }
@@ -1864,8 +1863,7 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request >= 0) {
         qemu_kill_report();
-        qapi_event_send_shutdown(request >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
-                                 &error_abort);
+        qapi_event_send_shutdown(request, &error_abort);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index 1d5e28d..aa6edc2 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -46,7 +46,7 @@ QMP_VERSION
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}


 === Testing blkverify on existing block device ===
@@ -85,7 +85,7 @@ wrote 512/512 bytes at offset 0
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error

diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 2533c31..ed79421 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -36,7 +36,7 @@ read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}


 == using quorum rewrite corrupted mode ==
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 59c5208..a494659 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -8,7 +8,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}


 === Duplicate ID ===
@@ -19,7 +19,7 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "node-name=disk is conflicting with a device id"}}
 {"error": {"class": "GenericError", "desc": "Duplicate node name"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}


 === aio=native without O_DIRECT ===
@@ -29,7 +29,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "aio=native was specified, but it requires cache.direct=on, which was not specified."}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}


 === Encrypted image ===
@@ -40,14 +40,14 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}

 Testing:
 QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}


 === Missing driver ===
@@ -58,6 +58,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Parameter 'driver' is missing"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}

 *** done
diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index f52baff..6059f20 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -7,5 +7,5 @@ Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}
 *** done
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 851e214..d325f64 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -7,7 +7,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}
 No errors were found on the image.
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/119.out b/tests/qemu-iotests/119.out
index a8743b8..80d2750 100644
--- a/tests/qemu-iotests/119.out
+++ b/tests/qemu-iotests/119.out
@@ -6,6 +6,6 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}

 *** done
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 1af1aeb..fe717f0 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -6,7 +6,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 0689b2b..2da1c0a 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -10,5 +10,5 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: No export with name 'drv' available
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 0978b89..efec8a0 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -3,5 +3,5 @@ QA output created by 143
 {"return": {}}
 can't open device nbd+unix:///no_such_export?socket=TEST_DIR/nbd: No export with name 'no_such_export' available
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}
 *** done
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index f96a564..cfa7665 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -34,7 +34,7 @@ read 65536/65536 bytes at offset 196608
 {"return": ""}

 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"reason": "host-qmp"}}

 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.9.3

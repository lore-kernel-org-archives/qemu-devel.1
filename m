Received: from eggs.gnu.org ([2001:4830:134:3::10]:41467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6j3m-0004kw-5q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6j3k-0003zx-Ad
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 May 2017 14:38:10 -0500
Message-Id: <20170505193810.2934-6-eblake@redhat.com>
In-Reply-To: <20170505193810.2934-1-eblake@redhat.com>
References: <20170505193810.2934-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 5/5] shutdown: Expose bool cause in SHUTDOWN
 and RESET events
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

Libvirt would like to be able to distinguish between a SHUTDOWN
event triggered solely by guest request and one triggered by a
SIGTERM or other action on the host.  While qemu_kill_report() was
already able to give different output to stderr based on whether a
shutdown was triggered by a host signal (but NOT by a host UI event,
such as clicking the X on the window), that information was then
lost to management.  The previous patches improved things to use an
enum throughout all callsites, so now we have something ready to
expose through QMP.

Note that for now, the decision was to expose ONLY a boolean,
rather than promoting ShutdownCause to a QAPI enum; this is because
libvirt has not expressed an interest in anything finer-grained.
We can still add additional details, in a backwards-compatible
manner, if a need later arises (if the addition happens before 2.10,
we can replace the bool with an enum; otherwise, the enum will have
to be in addition to the bool).

Update expected iotest outputs to match the new data (complete
coverage of the affected tests is obtained by -raw, -qcow2, and -nbd).

Here is output from 'virsh qemu-monitor-event --loop' with the
patch installed:

event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":true}
event STOP at 1492639680.732116 for domain fedora_13: <null>
event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":false}

Note that libvirt runs qemu with -no-quit: the first SHUTDOWN event
was triggered by an action I took directly in the guest (shutdown -h),
at which point qemu stops the vcpus and waits for libvirt to do any
final cleanups; the second SHUTDOWN event is the result of libvirt
sending SIGTERM now that it has completed cleanup.

See also https://bugzilla.redhat.com/1384007

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: split out from 'shutdown: Add source information to SHUTDOWN and RESET'
---
 qapi/event.json            | 17 +++++++++++++----
 vl.c                       |  6 ++++--
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
 12 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/qapi/event.json b/qapi/event.json
index e80f3f4..6d22b02 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -10,6 +10,10 @@
 # Emitted when the virtual machine has shut down, indicating that qemu is
 # about to exit.
 #
+# @guest: If true, the shutdown was triggered by a guest request (such as
+# a guest-initiated ACPI shutdown request or other hardware-specific action)
+# rather than a host request (such as sending qemu a SIGINT). (since 2.10)
+#
 # Note: If the command-line option "-no-shutdown" has been specified, qemu will
 # not exit, and a STOP event will eventually follow the SHUTDOWN event
 #
@@ -17,11 +21,11 @@
 #
 # Example:
 #
-# <- { "event": "SHUTDOWN",
+# <- { "event": "SHUTDOWN", "data": { "guest": true },
 #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
 #
 ##
-{ 'event': 'SHUTDOWN' }
+{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }

 ##
 # @POWERDOWN:
@@ -44,15 +48,20 @@
 #
 # Emitted when the virtual machine is reset
 #
+# @guest: If true, the reset was triggered by a guest request (such as
+# a guest-initiated ACPI reboot request or other hardware-specific action)
+# rather than a host request (such as the QMP command system_reset).
+# (since 2.10)
+#
 # Since: 0.12.0
 #
 # Example:
 #
-# <- { "event": "RESET",
+# <- { "event": "RESET", "data": { "guest": false },
 #      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
 #
 ##
-{ 'event': 'RESET' }
+{ 'event': 'RESET', 'data': { 'guest': 'bool' } }

 ##
 # @STOP:
diff --git a/vl.c b/vl.c
index 0b73437..60a8526 100644
--- a/vl.c
+++ b/vl.c
@@ -1707,7 +1707,8 @@ void qemu_system_reset(bool report, ShutdownCause reason)
     }
     if (report) {
         assert(reason);
-        qapi_event_send_reset(&error_abort);
+        qapi_event_send_reset(reason >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
+                              &error_abort);
     }
     cpu_synchronize_all_post_reset();
 }
@@ -1864,7 +1865,8 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(&error_abort);
+        qapi_event_send_shutdown(request >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
+                                 &error_abort);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index dd879f1..1d5e28d 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -46,7 +46,7 @@ QMP_VERSION
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Testing blkverify on existing block device ===
@@ -85,7 +85,7 @@ wrote 512/512 bytes at offset 0
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error

diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 97df69d..2533c31 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -36,7 +36,7 @@ read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 == using quorum rewrite corrupted mode ==
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index dc6baf9..59c5208 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -8,7 +8,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Duplicate ID ===
@@ -19,7 +19,7 @@ QMP_VERSION
 {"error": {"class": "GenericError", "desc": "node-name=disk is conflicting with a device id"}}
 {"error": {"class": "GenericError", "desc": "Duplicate node name"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === aio=native without O_DIRECT ===
@@ -29,7 +29,7 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "aio=native was specified, but it requires cache.direct=on, which was not specified."}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Encrypted image ===
@@ -40,14 +40,14 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

 Testing:
 QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Missing driver ===
@@ -58,6 +58,6 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Parameter 'driver' is missing"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

 *** done
diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index b66dc07..f52baff 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -7,5 +7,5 @@ Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index f52dc1a..851e214 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -7,7 +7,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 No errors were found on the image.
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/119.out b/tests/qemu-iotests/119.out
index 58e7114..a8743b8 100644
--- a/tests/qemu-iotests/119.out
+++ b/tests/qemu-iotests/119.out
@@ -6,6 +6,6 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

 *** done
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 9131b1b..1af1aeb 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -6,7 +6,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 6c04456..0689b2b 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -10,5 +10,5 @@ read 65536/65536 bytes at offset 0
 {"return": {}}
 can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: No export with name 'drv' available
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index d24ad20..0978b89 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -3,5 +3,5 @@ QA output created by 143
 {"return": {}}
 can't open device nbd+unix:///no_such_export?socket=TEST_DIR/nbd: No export with name 'no_such_export' available
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 3af82ae..f96a564 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -34,7 +34,7 @@ read 65536/65536 bytes at offset 196608
 {"return": ""}

 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.9.3

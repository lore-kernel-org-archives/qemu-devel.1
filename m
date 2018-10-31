Received: from eggs.gnu.org ([2001:4830:134:3::10]:40544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1gHp3I-0004Xj-Rt
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1gHp3F-00042J-Hi
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:52:48 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:18941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1gHp3F-00040J-6e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:52:45 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Wed, 31 Oct 2018 12:52:41 +0100
Message-Id: <20181031115242.6558-3-d.csapak@proxmox.com>
In-Reply-To: <20181031115242.6558-1-d.csapak@proxmox.com>
References: <20181031115242.6558-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH 2/3] qapi: split host-qmp into quit and
 system-reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com

it is interesting to know whether the shutdown cause was 'quit' or
'reset', especially when using --no-reboot

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
---
 qapi/run-state.json | 10 ++++++----
 qmp.c               |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 883bed167c..c215b6ef83 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -68,7 +68,9 @@
 #
 # @host-error: An error prevented further use of guest
 #
-# @host-qmp: Reaction to a QMP command, like 'quit'
+# @host-qmp-quit: Reaction to the QMP command 'quit'
+#
+# @host-qmp-system-reset: Reaction to the QMP command 'system_reset'
 #
 # @host-signal: Reaction to a signal, such as SIGINT
 #
@@ -88,9 +90,9 @@
 #
 ##
 { 'enum': 'ShutdownCause',
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
-- 
2.11.0

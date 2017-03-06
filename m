Received: from eggs.gnu.org ([2001:4830:134:3::10]:35853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cktHA-0001NX-3C
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cktH5-0000Xf-BX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:06:12 -0500
Received: from [45.249.212.187] (port=2995 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cktH4-0000UG-Ga
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:06:07 -0500
From: hangaohuai <hangaohuai@huawei.com>
Date: Mon, 6 Mar 2017 22:05:41 +0800
Message-ID: <20170306140541.10600-1-hangaohuai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Fix the vm state after vm migration when vm
 panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, arei.gonglei@huawei.com, hangaohuai@huawei.com

Bug steps:
1. windows VM with pvpanic device:<panic model='isa'/>in xml
2. inject the panic in windows, the vm state is paused (guest-panicked)
3. migrate the vm to other host, vm state is running

Check the vmstate before runstate_set(RUN_STATE_RUNNING)

Signed-off-by: hangaohuai <hangaohuai@huawei.com>
---
 cpus.c                  | 3 +++
 include/sysemu/sysemu.h | 1 +
 vl.c                    | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/cpus.c b/cpus.c
index c857ad2..37b93aa 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1734,6 +1734,9 @@ int vm_prepare_start(void)
     if (runstate_is_running()) {
         qapi_event_send_stop(&error_abort);
         res = -1;
+    } else if (runstate_is_paniced()) {
+        qemu_system_guest_panicked(NULL);
+        res = -1;
     } else {
         replay_enable_events();
         cpu_enable_ticks();
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..08015c7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -23,6 +23,7 @@ extern bool qemu_uuid_set;
 bool runstate_check(RunState state);
 void runstate_set(RunState new_state);
 int runstate_is_running(void);
+int runstate_is_paniced(void);
 bool runstate_needs_reset(void);
 bool runstate_store(char *str, size_t size);
 typedef struct vm_change_state_entry VMChangeStateEntry;
diff --git a/vl.c b/vl.c
index 16a3b5e..ea7e3f8 100644
--- a/vl.c
+++ b/vl.c
@@ -729,6 +729,11 @@ int runstate_is_running(void)
     return runstate_check(RUN_STATE_RUNNING);
 }
 
+int runstate_is_paniced(void)
+{
+    return runstate_check(RUN_STATE_GUEST_PANICKED);
+}
+
 bool runstate_needs_reset(void)
 {
     return runstate_check(RUN_STATE_INTERNAL_ERROR) ||
-- 
1.8.3.1

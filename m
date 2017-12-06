Received: from eggs.gnu.org ([2001:4830:134:3::10]:55745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPV-0005qM-3v
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPQ-000525-3W
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39466
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMYPP-000512-Te
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6BxJou120829
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:02:37 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epcha2y3v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:02:35 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 07:02:35 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 10:02:15 -0200
In-Reply-To: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/3] qmp: introduce
 query-wakeup-from-suspend-support command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

When issuing the qmp/hmp 'system_wakeup' command, what happens in a
nutshell is:

- qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reason
and notify the event
- in the main_loop, all vcpus are paused, a system reset is issued, all
subscribers of wakeup_notifiers receives a notification, vcpus are then
resumed and the wake up QAPI event is fired

Note that this procedure alone doesn't ensure that the guest will awake
from SUSPENDED state - the subscribers of the wake up event must take
action to resume the guest, otherwise the guest will simply reboot.

At this moment there are only two subscribers of the wake up event: one
in hw/acpi/core.c and another one in hw/i386/xen/xen-hvm.c. This means
that system_wakeup does not work as intended with other architectures.

However, only the presence of 'system_wakeup' is required for QGA to
support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
This means that the user/management will expect to suspend the guest using
one of those suspend commands and then resume execution using system_wakeup,
regardless of the support offered in system_wakeup in the first place.

This patch implements a new QMP command called
'query-wakeup-from-suspend-support' that allows the caller to query
if the guest supports wake up from suspend via system_wakeup. It
goes over the subscribers of the wake up event and, if it's empty,
it assumes that the guest does not support wake up from suspend
(and thus, pm-suspend itself).

This is the expected output of the command when running a x86 guest:

{"execute" : "query-wakeup-from-suspend-support"}
{"return": {"enabled": true}}

This is the output when running a pseries guest:

{"execute" : "query-wakeup-from-suspend-support"}
{"return": {"enabled": false}}

With this extra tool, management can avoid situations where a guest
that does not have proper suspend/wake capabilities ends up in
inconsistent state (e.g.
https://github.com/open-power-host-os/qemu/issues/31).

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 include/sysemu/sysemu.h |  1 +
 qapi-schema.json        | 23 +++++++++++++++++++++++
 qmp.c                   |  9 +++++++++
 vl.c                    |  5 +++++
 4 files changed, 38 insertions(+)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index c083869fcf..70b94dcda5 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -69,6 +69,7 @@ typedef enum WakeupReason {
 void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
+bool qemu_wakeup_notifier_is_empty(void);
 void qemu_system_wakeup_request(WakeupReason reason);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..cf5bf327bd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3200,3 +3200,26 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @WakeupSuspendSupportInfo:
+#
+# Information about the wake up from suspend support of the VM.
+#
+# @enabled: true if the target supports wake up from suspend
+#
+# Since: 2.12
+##
+{ 'struct': 'WakeupSuspendSupportInfo',
+  'data': { 'enabled': 'bool' } }
+
+##
+# @query-wakeup-from-suspend-support:
+#
+# Return information about the wake up from suspend support of the VM.
+#
+# Returns: WakeupSuspendSupportInfo
+#
+# Since: 2.12
+##
+{ 'command': 'query-wakeup-from-suspend-support', 'returns': 'WakeupSuspendSupportInfo' }
diff --git a/qmp.c b/qmp.c
index e8c303116a..26fefbbe88 100644
--- a/qmp.c
+++ b/qmp.c
@@ -722,3 +722,12 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
     return mem_info;
 }
+
+WakeupSuspendSupportInfo *qmp_query_wakeup_from_suspend_support(Error **errp)
+{
+    WakeupSuspendSupportInfo *info = g_malloc0(sizeof(*info));
+
+    info->enabled = !qemu_wakeup_notifier_is_empty();
+
+    return info;
+}
diff --git a/vl.c b/vl.c
index 1ad1c04637..b07aa6f098 100644
--- a/vl.c
+++ b/vl.c
@@ -1889,6 +1889,11 @@ void qemu_register_wakeup_notifier(Notifier *notifier)
     notifier_list_add(&wakeup_notifiers, notifier);
 }
 
+bool qemu_wakeup_notifier_is_empty(void)
+{
+    return QLIST_EMPTY(&wakeup_notifiers.notifiers);
+}
+
 void qemu_system_killed(int signal, pid_t pid)
 {
     shutdown_signal = signal;
-- 
2.13.6

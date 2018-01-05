Received: from eggs.gnu.org ([2001:4830:134:3::10]:34754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eXRep-0000pV-PX
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eXRem-0004tY-Fw
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:03:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42284
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eXRem-0004sm-9K
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:03:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05CxNa4109814
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 08:03:31 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fa9849mau-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 08:03:30 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 08:03:30 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 11:03:13 -0200
In-Reply-To: <20180105130314.26026-1-danielhb@linux.vnet.ibm.com>
References: <20180105130314.26026-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20180105130314.26026-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/2] qmp: adding 'wakeup-suspend-support' in
 query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

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

This patch adds a new flag called 'wakeup-suspend-support' in TargetInfo
that allows the caller to query if the guest supports wake up from
suspend via system_wakeup. It goes over the subscribers of the wake up
event and, if it's empty, it assumes that the guest does not support
wake up from suspend (and thus, pm-suspend itself).

This is the expected output of query-target when running a x86 guest:

{"execute" : "query-target"}
{"return": {"arch": "x86_64", "wakeup-suspend-support": true}}

This is the output when running a pseries guest:

{"execute" : "query-target"}
{"return": {"arch": "ppc64", "wakeup-suspend-support": false}}

Given that the TargetInfo structure is read-only, adding a new flag to
it is backwards compatible. There is no need to deprecate the old
TargetInfo format.

With this extra tool, management can avoid situations where a guest
that does not have proper suspend/wake capabilities ends up in
inconsistent state (e.g.
https://github.com/open-power-host-os/qemu/issues/31).

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 arch_init.c             |  1 +
 include/sysemu/sysemu.h |  1 +
 qapi-schema.json        |  4 +++-
 vl.c                    | 29 +++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch_init.c b/arch_init.c
index a0b8ed6167..9c5c519d9d 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -109,6 +109,7 @@ TargetInfo *qmp_query_target(Error **errp)
     TargetInfo *info = g_malloc0(sizeof(*info));
 
     info->arch = g_strdup(TARGET_NAME);
+    info->wakeup_suspend_support = !qemu_wakeup_notifier_is_empty();
 
     return info;
 }
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 31612caf10..b15374e0b8 100644
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
index 5c06745c79..2f1c08fde7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2388,11 +2388,13 @@
 # Information describing the QEMU target.
 #
 # @arch: the target architecture (eg "x86_64", "i386", etc)
+# @wakeup-suspend-support: true if the target supports wake up from
+#                          suspend (since 2.12)
 #
 # Since: 1.2.0
 ##
 { 'struct': 'TargetInfo',
-  'data': { 'arch': 'str' } }
+  'data': { 'arch': 'str', 'wakeup-suspend-support': 'bool' } }
 
 ##
 # @query-target:
diff --git a/vl.c b/vl.c
index d3a5c5d021..56d6a1ce5b 100644
--- a/vl.c
+++ b/vl.c
@@ -1839,11 +1839,40 @@ void qemu_system_wakeup_enable(WakeupReason reason, bool enabled)
     }
 }
 
+/* The existence of a wake-up notifier is being checked in the function
+ * qemu_wakeup_notifier_is_empty and it's used in the logic of the
+ * wakeup-suspend-support flag of QMP 'query-target' command. The idea
+ * of this flag is to indicate whether the guest supports wake-up from
+ * suspend (via system_wakeup QMP/HMP call for example), warning the user
+ * that the guest can't handle both wake-up from suspend and the suspend
+ * itself via QGA guest-suspend-ram and guest-suspend-hybrid (if it
+ * can't wake up, it can't be suspended safely).
+ *
+ * The motivation of this design is that this notification will only
+ * fire if a wake up attempt is made by qemu_system_wakeup_request and
+ * the current runstate is RUN_STATE_SUSPENDED. This run state is set by
+ * qemu_system_suspend_request, which at this moment is only being
+ * called in hw/acpi/core.c. This means that, today, only ACPI implements
+ * the proper suspend support and can successfully execute both
+ * guest-suspend-(ram/hybrid) and system_wakeup.
+ *
+ * Thus, an assumption is made by the wakeup-suspend-support flag that
+ * only the guests that can go to RUN_STATE_SUSPENDED and wake up properly
+ * would be interested in this wakeup_notifier. Adding a wakeup_notifier
+ * for any other reason will break the logic of the wakeup-suspend-support
+ * flag and can lead to user/management confusion about the suspend/wake-up
+ * support of the guest.
+ */
 void qemu_register_wakeup_notifier(Notifier *notifier)
 {
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

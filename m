Received: from eggs.gnu.org ([2001:4830:134:3::10]:49714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fbAYN-0004Ch-0k
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fbAYL-0002dd-LA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fbAYL-0002cn-Fo
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:33 -0400
Received: by mail-qt0-x243.google.com with SMTP id a18-v6so8189585qtj.4
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:08:33 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu,  5 Jul 2018 17:08:11 -0300
Message-Id: <20180705200813.2033-2-danielhb413@gmail.com>
In-Reply-To: <20180705200813.2033-1-danielhb413@gmail.com>
References: <20180705200813.2033-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v8 1/3] qmp: query-current-machine with
 wakeup-suspend-support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

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

At this moment, there are only two subscribers of the wake up event: one
in hw/acpi/core.c and another in hw/i386/xen/xen-hvm.c. This means
that system_wakeup does not work as intended with other architectures.

However, only the presence of 'system_wakeup' is required for QGA to
support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
This means that the user/management will expect to suspend the guest using
one of those suspend commands and then resume execution using system_wakeup,
regardless of the support offered in system_wakeup in the first place.

This patch creates a new API called query-current-machine [1], that holds
a new flag called 'wakeup-suspend-support', which indicates if the guest
supports wake up from suspend via system_wakeup. The guest is considered
to implement wake-up support if:

- there is at least one subscriber for the wake up event;

and, for the PC machine type:

- ACPI is enabled.

This is the expected output of query-current-machine when running a x86
guest:

{"execute" : "query-current-machine"}
{"return": {"wakeup-suspend-support": true}}

Running the same x86 guest, but with the --no-acpi option:

{"execute" : "query-current-machine"}
{"return": {"wakeup-suspend-support": false}}

This is the output when running a pseries guest:

{"execute" : "query-current-machine"}
{"return": {"wakeup-suspend-support": false}}

With this extra tool, management can avoid situations where a guest
that does not have proper suspend/wake capabilities ends up in
inconsistent state (e.g.
https://github.com/open-power-host-os/qemu/issues/31).

[1] the decision of creating the query-current-machine API is based
on discussions in the QEMU mailing list where it was decided that
query-target wasn't a proper place to store the wake-up flag, neither
was query-machines because this isn't a static property of the
machine object. This new API can then be used to store other
dynamic machine properties that are scattered around the code
ATM. More info at:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04235.html

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qapi/misc.json | 24 ++++++++++++++++++++++++
 vl.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 29da7856e3..266f88cb09 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2003,6 +2003,30 @@
 ##
 { 'command': 'query-machines', 'returns': ['MachineInfo'] }
 
+##
+# @CurrentMachineParams:
+#
+# Information describing the running machine parameters.
+#
+# @wakeup-suspend-support: true if the target supports wake up from
+#                          suspend
+#
+# Since: 3.0.0
+##
+{ 'struct': 'CurrentMachineParams',
+  'data': { 'wakeup-suspend-support': 'bool'} }
+
+##
+# @query-current-machine:
+#
+# Return a list of parameters of the running machine.
+#
+# Returns: CurrentMachineParams
+#
+# Since: 3.0.0
+##
+{ 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
+
 ##
 # @CpuDefinitionInfo:
 #
diff --git a/vl.c b/vl.c
index ef6cfcec40..96ad448d57 100644
--- a/vl.c
+++ b/vl.c
@@ -1747,11 +1747,41 @@ void qemu_system_wakeup_enable(WakeupReason reason, bool enabled)
     }
 }
 
+/*
+ * The existence of a wake-up notifier is being checked in the function
+ * qemu_wakeup_suspend_support and it's used in the logic of the
+ * wakeup-suspend-support flag of QMP 'query-current-machine' command.
+ * The idea of this flag is to indicate whether the guest supports wake-up
+ * from suspend (via system_wakeup QMP/HMP call for example), warning the
+ * user that the guest can't handle both wake-up from suspend and the
+ * suspend itself via QGA guest-suspend-ram and guest-suspend-hybrid (if
+ * it can't wake up, it can't be suspended safely).
+ *
+ * An assumption is made by the wakeup-suspend-support flag that only the
+ * guests that can go to RUN_STATE_SUSPENDED and wake up properly would
+ * be interested in this wakeup_notifier. Adding a wakeup_notifier for
+ * any other reason will break the logic of the wakeup-suspend-support
+ * flag and can lead to user/management confusion about the suspend/wake-up
+ * support of the guest.
+ */
 void qemu_register_wakeup_notifier(Notifier *notifier)
 {
     notifier_list_add(&wakeup_notifiers, notifier);
 }
 
+static bool qemu_wakeup_suspend_support(void)
+{
+    return !QLIST_EMPTY(&wakeup_notifiers.notifiers) && acpi_enabled;
+}
+
+CurrentMachineParams *qmp_query_current_machine(Error **errp)
+{
+    CurrentMachineParams *params = g_malloc0(sizeof(*params));
+    params->wakeup_suspend_support = qemu_wakeup_suspend_support();
+
+    return params;
+}
+
 void qemu_system_killed(int signal, pid_t pid)
 {
     shutdown_signal = signal;
-- 
2.17.1

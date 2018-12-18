Received: from eggs.gnu.org ([2001:4830:134:3::10]:55900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJx-00060R-HW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJv-000871-AJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJu-0007zK-Sm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:47 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 11:09:38 +0100
Message-Id: <20181218100941.25267-5-armbru@redhat.com>
In-Reply-To: <20181218100941.25267-1-armbru@redhat.com>
References: <20181218100941.25267-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] qmp: query-current-machine with
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

When issuing the qmp/hmp 'system_wakeup' command, what happens in a
nutshell is:

- qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reason
and notify the event
- in the main_loop, all vcpus are paused, a system reset is issued, all
subscribers of wakeup_notifiers receives a notification, vcpus are then
resumed and the wake up QAPI event is fired

Note that this procedure alone doesn't ensure that the guest will awake
from SUSPENDED state - the subscribers of the wake up event must take
action to resume the guest, otherwise the guest will simply reboot. At
this moment, only the ACPI machines via acpi_pm1_cnt_init and xen_hvm_init
have wake-up from suspend support.

However, only the presence of 'system_wakeup' is required for QGA to
support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
This means that the user/management will expect to suspend the guest using
one of those suspend commands and then resume execution using system_wakeup,
regardless of the support offered in system_wakeup in the first place.

This patch creates a new API called query-current-machine [1], that holds
a new flag called 'wakeup-suspend-support' that indicates if the guest
supports wake up from suspend via system_wakeup. The machine is considered
to implement wake-up support if a call to a new 'qemu_register_wakeup_support'
is made during its init, as it is now being done inside acpi_pm1_cnt_init
and xen_hvm_init. This allows for any other machine type to declare wake-up
support regardless of ACPI state or wakeup_notifiers subscription, making easier
for newer implementations that might have their own mechanisms in the future.

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
Message-Id: <20181205194701.17836-2-danielhb413@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/core.c          |  6 ++++++
 hw/i386/xen/xen-hvm.c   |  5 +++++
 include/sysemu/sysemu.h |  1 +
 qapi/misc.json          | 24 ++++++++++++++++++++++++
 vl.c                    | 19 +++++++++++++++++++
 5 files changed, 55 insertions(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index aafdc61648..52e18d7810 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -617,6 +617,12 @@ void acpi_pm1_cnt_init(ACPIREGS *ar, MemoryRegion *parent,
     ar->pm1.cnt.s4_val = s4_val;
     ar->wakeup.notify = acpi_notify_wakeup;
     qemu_register_wakeup_notifier(&ar->wakeup);
+
+    /*
+     * Register wake-up support in QMP query-current-machine API
+     */
+    qemu_register_wakeup_support();
+
     memory_region_init_io(&ar->pm1.cnt.io, memory_region_owner(parent),
                           &acpi_pm_cnt_ops, ar, "acpi-cnt", 2);
     memory_region_add_subregion(parent, 4, &ar->pm1.cnt.io);
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 935a3676c8..2143d33b18 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1405,6 +1405,11 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     state->wakeup.notify = xen_wakeup_notifier;
     qemu_register_wakeup_notifier(&state->wakeup);
 
+    /*
+     * Register wake-up support in QMP query-current-machine API
+     */
+    qemu_register_wakeup_support();
+
     rc = xen_map_ioreq_server(state);
     if (rc < 0) {
         goto err;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index f83522c7e7..d9cabb34bd 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -57,6 +57,7 @@ void qemu_register_suspend_notifier(Notifier *notifier);
 void qemu_system_wakeup_request(WakeupReason reason);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
+void qemu_register_wakeup_support(void);
 void qemu_system_shutdown_request(ShutdownCause reason);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
diff --git a/qapi/misc.json b/qapi/misc.json
index 8325e0dc9c..c4696ef150 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2012,6 +2012,30 @@
 ##
 { 'command': 'query-machines', 'returns': ['MachineInfo'] }
 
+##
+# @CurrentMachineParams:
+#
+# Information describing the running machine parameters.
+#
+# @wakeup-suspend-support: true if the machine supports wake up from
+#                          suspend
+#
+# Since: 4.0
+##
+{ 'struct': 'CurrentMachineParams',
+  'data': { 'wakeup-suspend-support': 'bool'} }
+
+##
+# @query-current-machine:
+#
+# Return information on the current virtual machine.
+#
+# Returns: CurrentMachineParams
+#
+# Since: 4.0
+##
+{ 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
+
 ##
 # @CpuDefinitionInfo:
 #
diff --git a/vl.c b/vl.c
index 4152e2d3c0..2bd869580f 100644
--- a/vl.c
+++ b/vl.c
@@ -192,6 +192,7 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
+bool wakeup_suspend_enabled;
 
 int icount_align_option;
 
@@ -1780,6 +1781,24 @@ void qemu_register_wakeup_notifier(Notifier *notifier)
     notifier_list_add(&wakeup_notifiers, notifier);
 }
 
+void qemu_register_wakeup_support(void)
+{
+    wakeup_suspend_enabled = true;
+}
+
+static bool qemu_wakeup_suspend_enabled(void)
+{
+    return wakeup_suspend_enabled;
+}
+
+CurrentMachineParams *qmp_query_current_machine(Error **errp)
+{
+    CurrentMachineParams *params = g_malloc0(sizeof(*params));
+    params->wakeup_suspend_support = qemu_wakeup_suspend_enabled();
+
+    return params;
+}
+
 void qemu_system_killed(int signal, pid_t pid)
 {
     shutdown_signal = signal;
-- 
2.17.2

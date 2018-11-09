Received: from eggs.gnu.org ([2001:4830:134:3::10]:58447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gLAfD-0002L3-A9
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gLAf9-0007Ls-AD
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:46 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gLAf9-0007Ax-2S
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:43 -0500
Received: by mail-qk1-x744.google.com with SMTP id e4so2927691qkh.6
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 09:33:31 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Fri,  9 Nov 2018 15:33:09 -0200
Message-Id: <20181109173309.25212-4-danielhb413@gmail.com>
In-Reply-To: <20181109173309.25212-1-danielhb413@gmail.com>
References: <20181109173309.25212-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.2 v10 3/3] qmp hmp: Make system_wakeup
 check wake-up support and run state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, ehabkost@redhat.com, armbru@redhat.com, mst@redhat.com, imammedo@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

The qmp/hmp command 'system_wakeup' is simply a direct call to
'qemu_system_wakeup_request' from vl.c. This function verifies if
runstate is SUSPENDED and if the wake up reason is valid before
proceeding. However, no error or warning is thrown if any of those
pre-requirements isn't met. There is no way for the caller to
differentiate between a successful wakeup or an error state caused
when trying to wake up a guest that wasn't suspended.

This means that system_wakeup is silently failing, which can be
considered a bug. Adding error handling isn't an API break in this
case - applications that didn't check the result will remain broken,
the ones that check it will have a chance to deal with it.

Adding to that, the commit before previous created a new QMP API called
query-current-machine, with a new flag called wakeup-suspend-support,
that indicates if the guest has the capability of waking up from suspended
state. Although such guest will never reach SUSPENDED state and erroring
it out in this scenario would suffice, it is more informative for the user
to differentiate between a failure because the guest isn't suspended versus
a failure because the guest does not have support for wake up at all.

All this considered, this patch changes qmp_system_wakeup to check if
the guest is capable of waking up from suspend, and if it is suspended.
After this patch, this is the output of system_wakeup in a guest that
does not have wake-up from suspend support (ppc64):

(qemu) system_wakeup
wake-up from suspend is not supported by this guest
(qemu)

And this is the output of system_wakeup in a x86 guest that has the
support but isn't suspended:

(qemu) system_wakeup
Unable to wake up: guest is not in suspended state
(qemu)

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hmp.c                   |  5 ++++-
 hw/acpi/core.c          |  4 +++-
 hw/char/serial.c        |  3 ++-
 hw/input/ps2.c          |  9 ++++++---
 hw/timer/mc146818rtc.c  |  3 ++-
 include/sysemu/sysemu.h |  3 ++-
 migration/migration.c   |  7 +++++--
 qapi/misc.json          |  8 +++++++-
 qmp.c                   | 13 ++++++++++++-
 vl.c                    |  6 ++++--
 10 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/hmp.c b/hmp.c
index 7828f93a39..0f5d943413 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1220,7 +1220,10 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
 
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
 {
-    qmp_system_wakeup(NULL);
+    Error *err = NULL;
+
+    qmp_system_wakeup(&err);
+    hmp_handle_error(mon, &err);
 }
 
 void hmp_nmi(Monitor *mon, const QDict *qdict)
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 52e18d7810..a7073dd435 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -514,7 +514,9 @@ static uint32_t acpi_pm_tmr_get(ACPIREGS *ar)
 static void acpi_pm_tmr_timer(void *opaque)
 {
     ACPIREGS *ar = opaque;
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_PMTIMER);
+    Error *err = NULL;
+
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_PMTIMER, &err);
     ar->tmr.update_sci(ar);
 }
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 02463e3388..23c5d2870c 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -609,9 +609,10 @@ static int serial_can_receive1(void *opaque)
 static void serial_receive1(void *opaque, const uint8_t *buf, int size)
 {
     SerialState *s = opaque;
+    Error *err = NULL;
 
     if (s->wakeup) {
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &err);
     }
     if(s->fcr & UART_FCR_FE) {
         int i;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 6c43fc2912..fc742b0061 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -253,9 +253,10 @@ void ps2_queue_4(PS2State *s, int b1, int b2, int b3, int b4)
 static void ps2_put_keycode(void *opaque, int keycode)
 {
     PS2KbdState *s = opaque;
+    Error *err = NULL;
 
     trace_ps2_put_keycode(opaque, keycode);
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &err);
 
     if (s->translate) {
         if (keycode == 0xf0) {
@@ -276,6 +277,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 {
     PS2KbdState *s = (PS2KbdState *)dev;
     InputKeyEvent *key = evt->u.key.data;
+    Error *err = NULL;
     int qcode;
     uint16_t keycode = 0;
     int mod;
@@ -285,7 +287,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
         return;
     }
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &err);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
     qcode = qemu_input_key_value_to_qcode(key->key);
 
@@ -741,6 +743,7 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
 static void ps2_mouse_sync(DeviceState *dev)
 {
     PS2MouseState *s = (PS2MouseState *)dev;
+    Error *err = NULL;
 
     /* do not sync while disabled to prevent stream corruption */
     if (!(s->mouse_status & MOUSE_STATUS_ENABLED)) {
@@ -748,7 +751,7 @@ static void ps2_mouse_sync(DeviceState *dev)
     }
 
     if (s->mouse_buttons) {
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &err);
     }
     if (!(s->mouse_status & MOUSE_STATUS_REMOTE)) {
         /* if not remote, send event. Multiple events are sent if
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index e4e4de8b8a..e65962cdb4 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -443,6 +443,7 @@ static uint64_t get_next_alarm(RTCState *s)
 static void rtc_update_timer(void *opaque)
 {
     RTCState *s = opaque;
+    Error *err = NULL;
     int32_t irqs = REG_C_UF;
     int32_t new_irqs;
 
@@ -455,7 +456,7 @@ static void rtc_update_timer(void *opaque)
     if (qemu_clock_get_ns(rtc_clock) >= s->next_alarm_time) {
         irqs |= REG_C_AF;
         if (s->cmos_data[RTC_REG_B] & REG_B_AIE) {
-            qemu_system_wakeup_request(QEMU_WAKEUP_REASON_RTC);
+            qemu_system_wakeup_request(QEMU_WAKEUP_REASON_RTC, &err);
         }
     }
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 0446adacc6..162c4b16d9 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -74,7 +74,8 @@ void qemu_exit_preconfig_request(void);
 void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
-void qemu_system_wakeup_request(WakeupReason reason);
+bool qemu_wakeup_suspend_enabled(void);
+void qemu_system_wakeup_request(WakeupReason reason, Error **errp);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
 void qemu_register_wakeup_support(void);
diff --git a/migration/migration.c b/migration/migration.c
index b261c1e4ce..8e9b4af71c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2390,6 +2390,8 @@ static int postcopy_start(MigrationState *ms)
     int64_t bandwidth = migrate_max_postcopy_bandwidth();
     bool restart_block = false;
     int cur_state = MIGRATION_STATUS_ACTIVE;
+    Error *err = NULL;
+
     if (!migrate_pause_before_switchover()) {
         migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_POSTCOPY_ACTIVE);
@@ -2399,7 +2401,7 @@ static int postcopy_start(MigrationState *ms)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &err);
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2597,13 +2599,14 @@ static int migration_maybe_pause(MigrationState *s,
  */
 static void migration_completion(MigrationState *s)
 {
+    Error *err = NULL;
     int ret;
     int current_active_state = s->state;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &err);
         s->vm_was_running = runstate_is_running();
         ret = global_state_store();
 
diff --git a/qapi/misc.json b/qapi/misc.json
index 9b86576e61..471f6e680c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1235,12 +1235,18 @@
 ##
 # @system_wakeup:
 #
-# Wakeup guest from suspend.  Does nothing in case the guest isn't suspended.
+# Wake-up guest from suspend. If the guest has wake-up from suspend
+# support enabled (wakeup-suspend-support flag from
+# query-current-machine), wake-up guest from suspend if the guest is
+# in SUSPENDED state. Returns an error otherwise.
 #
 # Since:  1.1
 #
 # Returns:  nothing.
 #
+# Note: prior to 3.2, this command does nothing in case the guest
+# isn't suspended.
+#
 # Example:
 #
 # -> { "execute": "system_wakeup" }
diff --git a/qmp.c b/qmp.c
index e7c0a2fd60..2265aa48b9 100644
--- a/qmp.c
+++ b/qmp.c
@@ -183,7 +183,18 @@ void qmp_cont(Error **errp)
 
 void qmp_system_wakeup(Error **errp)
 {
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
+    Error *local_err = NULL;
+
+    if (!qemu_wakeup_suspend_enabled()) {
+        error_setg(errp,
+                   "wake-up from suspend is not supported by this guest");
+        return;
+    }
+
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
 }
 
 ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
diff --git a/vl.c b/vl.c
index 5813a8785f..b057796e48 100644
--- a/vl.c
+++ b/vl.c
@@ -1754,11 +1754,13 @@ void qemu_register_suspend_notifier(Notifier *notifier)
     notifier_list_add(&suspend_notifiers, notifier);
 }
 
-void qemu_system_wakeup_request(WakeupReason reason)
+void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
 {
     trace_system_wakeup_request(reason);
 
     if (!runstate_check(RUN_STATE_SUSPENDED)) {
+        error_setg(errp,
+                   "Unable to wake up: guest is not in suspended state");
         return;
     }
     if (!(wakeup_reason_mask & (1 << reason))) {
@@ -1788,7 +1790,7 @@ void qemu_register_wakeup_support(void)
     wakeup_suspend_enabled = true;
 }
 
-static bool qemu_wakeup_suspend_enabled(void)
+bool qemu_wakeup_suspend_enabled(void)
 {
     return wakeup_suspend_enabled;
 }
-- 
2.19.1

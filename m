Received: from eggs.gnu.org ([2001:4830:134:3::10]:43603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwq6-0001vK-Km
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwq5-0005yZ-LX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:23 +0200
Message-Id: <20180702111737.18970-2-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

kexec/kdump as well as the bootloader use a subcode of diagnose 308
that is supposed to reset the I/O subsystem but not comprise a full
"reboot". With the latest refactoring this is now broken when
-no-reboot is used or when libvirt acts on a reboot QMP event, for
example a virt-install from iso images.

We need to mark these "subsystem resets" as special.

Fixes: a30fb811cbe9 (s390x: refactor reset/reipl handling)
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180622102928.173420-1-borntraeger@de.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c          | 8 +++++++-
 include/sysemu/sysemu.h | 4 ++++
 vl.c                    | 4 ++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0d67349004..f278036fa7 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -535,7 +535,13 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
             ipl->iplb_valid = s390_gen_initial_iplb(ipl);
         }
     }
-    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    if (reset_type == S390_RESET_MODIFIED_CLEAR ||
+        reset_type == S390_RESET_LOAD_NORMAL) {
+        /* ignore -no-reboot, send no event  */
+        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
+    } else {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
     /* as this is triggered by a CPU, make sure to exit the loop */
     if (tcg_enabled()) {
         cpu_loop_exit(cs);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index b921c6f3b7..76ef6196a7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -44,6 +44,10 @@ typedef enum ShutdownCause {
                                      turns that into a shutdown */
     SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
                                      that into a shutdown */
+    SHUTDOWN_CAUSE_SUBSYSTEM_RESET,/* Partial guest reset that does not trigger
+                                      QMP events and ignores --no-reboot. This
+                                      is useful for sanitize hypercalls on s390
+                                      that are used during kexec/kdump/boot */
     SHUTDOWN_CAUSE__MAX,
 } ShutdownCause;
 
diff --git a/vl.c b/vl.c
index ef6cfcec40..9442beee21 100644
--- a/vl.c
+++ b/vl.c
@@ -1645,7 +1645,7 @@ void qemu_system_reset(ShutdownCause reason)
     } else {
         qemu_devices_reset();
     }
-    if (reason) {
+    if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         qapi_event_send_reset(shutdown_caused_by_guest(reason),
                               &error_abort);
     }
@@ -1691,7 +1691,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 
 void qemu_system_reset_request(ShutdownCause reason)
 {
-    if (no_reboot) {
+    if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         shutdown_requested = reason;
     } else {
         reset_requested = reason;
-- 
2.14.4

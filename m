Received: from eggs.gnu.org ([2001:4830:134:3::10]:52390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mc-0000tb-AZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000H1-Ti
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MY-0000Ea-A7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: by mail-wm1-x32b.google.com with SMTP id n190so6209731wmd.0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:49 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:49 +0100
Message-Id: <1544628195-37728-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/54] qemu/queue.h: typedef QTAILQ heads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This will be needed when we change the QTAILQ head and elem structs
to unions.  However, it is also consistent with the usage elsewhere
in QEMU for other list head structs (see for example FsMountList).

Note that most QTAILQs only need their name in order to do backwards
walks.  Those do not break with the struct->union change, and anyway
the change will also remove the need to name heads when doing backwards
walks, so those are not touched here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                        |  3 ++-
 hw/vfio/common.c              |  2 +-
 include/hw/vfio/vfio-common.h |  3 ++-
 include/qom/cpu.h             |  5 +++--
 ui/input.c                    | 14 ++++++++------
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index b6b2007..a629c98 100644
--- a/exec.c
+++ b/exec.c
@@ -94,7 +94,8 @@ int target_page_bits;
 bool target_page_bits_decided;
 #endif
 
-struct CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+
 /* current CPU in the current thread. It is only valid inside
    cpu_exec() */
 __thread CPUState *current_cpu;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7aa804e..4262b80 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -37,7 +37,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-struct vfio_group_head vfio_group_list =
+VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 127ca47..7624c9f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -180,7 +180,8 @@ int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
 extern const MemoryRegionOps vfio_region_ops;
-extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
+typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+extern VFIOGroupList vfio_group_list;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 62aef77..4662a20 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -435,8 +435,9 @@ struct CPUState {
     GArray *iommu_notifiers;
 };
 
-QTAILQ_HEAD(CPUTailQ, CPUState);
-extern struct CPUTailQ cpus;
+typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
+extern CPUTailQ cpus;
+
 #define first_cpu        QTAILQ_FIRST_RCU(&cpus)
 #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
 #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus, node)
diff --git a/ui/input.c b/ui/input.c
index 7c9a410..35c7964 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -19,6 +19,9 @@ struct QemuInputHandlerState {
 };
 
 typedef struct QemuInputEventQueue QemuInputEventQueue;
+typedef QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue)
+    QemuInputEventQueueHead;
+
 struct QemuInputEventQueue {
     enum {
         QEMU_INPUT_QUEUE_DELAY = 1,
@@ -37,8 +40,7 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =
 static NotifierList mouse_mode_notifiers =
     NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
 
-static QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue) kbd_queue =
-    QTAILQ_HEAD_INITIALIZER(kbd_queue);
+static QemuInputEventQueueHead kbd_queue = QTAILQ_HEAD_INITIALIZER(kbd_queue);
 static QEMUTimer *kbd_timer;
 static uint32_t kbd_default_delay_ms = 10;
 static uint32_t queue_count;
@@ -257,7 +259,7 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
 
 static void qemu_input_queue_process(void *opaque)
 {
-    struct QemuInputEventQueueHead *queue = opaque;
+    QemuInputEventQueueHead *queue = opaque;
     QemuInputEventQueue *item;
 
     g_assert(!QTAILQ_EMPTY(queue));
@@ -288,7 +290,7 @@ static void qemu_input_queue_process(void *opaque)
     }
 }
 
-static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
+static void qemu_input_queue_delay(QemuInputEventQueueHead *queue,
                                    QEMUTimer *timer, uint32_t delay_ms)
 {
     QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
@@ -306,7 +308,7 @@ static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
     }
 }
 
-static void qemu_input_queue_event(struct QemuInputEventQueueHead *queue,
+static void qemu_input_queue_event(QemuInputEventQueueHead *queue,
                                    QemuConsole *src, InputEvent *evt)
 {
     QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
@@ -318,7 +320,7 @@ static void qemu_input_queue_event(struct QemuInputEventQueueHead *queue,
     queue_count++;
 }
 
-static void qemu_input_queue_sync(struct QemuInputEventQueueHead *queue)
+static void qemu_input_queue_sync(QemuInputEventQueueHead *queue)
 {
     QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
 
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29L-0001DM-Bg
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29H-0004SD-In
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ29H-0004Op-0y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 431BA88E62
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:52 +0100
Message-Id: <20181217231700.24482-28-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/35] qemu/queue.h: typedef QTAILQ heads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>

This will be needed when we change the QTAILQ head and elem structs
to unions.  However, it is also consistent with the usage elsewhere
in QEMU for other list head structs (see for example FsMountList).

Note that most QTAILQs only need their name in order to do backwards
walks.  Those do not break with the struct->union change, and anyway
the change will also remove the need to name heads when doing backwards
walks, so those are not touched here.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
index b6b2007f27..a629c98eb5 100644
--- a/exec.c
+++ b/exec.c
@@ -94,7 +94,8 @@ int target_page_bits;
 bool target_page_bits_decided;
 #endif
=20
-struct CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
+CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
+
 /* current CPU in the current thread. It is only valid inside
    cpu_exec() */
 __thread CPUState *current_cpu;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7aa804ea0b..4262b80c44 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -37,7 +37,7 @@
 #include "trace.h"
 #include "qapi/error.h"
=20
-struct vfio_group_head vfio_group_list =3D
+VFIOGroupList vfio_group_list =3D
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =3D
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 127ca47815..7624c9f511 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -180,7 +180,8 @@ int vfio_get_device(VFIOGroup *group, const char *nam=
e,
                     VFIODevice *vbasedev, Error **errp);
=20
 extern const MemoryRegionOps vfio_region_ops;
-extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
+typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+extern VFIOGroupList vfio_group_list;
=20
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 62aef77b87..4662a205c1 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -435,8 +435,9 @@ struct CPUState {
     GArray *iommu_notifiers;
 };
=20
-QTAILQ_HEAD(CPUTailQ, CPUState);
-extern struct CPUTailQ cpus;
+typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
+extern CPUTailQ cpus;
+
 #define first_cpu        QTAILQ_FIRST_RCU(&cpus)
 #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
 #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus, node)
diff --git a/ui/input.c b/ui/input.c
index 7c9a4109c4..35c7964f64 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -19,6 +19,9 @@ struct QemuInputHandlerState {
 };
=20
 typedef struct QemuInputEventQueue QemuInputEventQueue;
+typedef QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue)
+    QemuInputEventQueueHead;
+
 struct QemuInputEventQueue {
     enum {
         QEMU_INPUT_QUEUE_DELAY =3D 1,
@@ -37,8 +40,7 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =3D
 static NotifierList mouse_mode_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
=20
-static QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue) kbd_que=
ue =3D
-    QTAILQ_HEAD_INITIALIZER(kbd_queue);
+static QemuInputEventQueueHead kbd_queue =3D QTAILQ_HEAD_INITIALIZER(kbd=
_queue);
 static QEMUTimer *kbd_timer;
 static uint32_t kbd_default_delay_ms =3D 10;
 static uint32_t queue_count;
@@ -257,7 +259,7 @@ static void qemu_input_event_trace(QemuConsole *src, =
InputEvent *evt)
=20
 static void qemu_input_queue_process(void *opaque)
 {
-    struct QemuInputEventQueueHead *queue =3D opaque;
+    QemuInputEventQueueHead *queue =3D opaque;
     QemuInputEventQueue *item;
=20
     g_assert(!QTAILQ_EMPTY(queue));
@@ -288,7 +290,7 @@ static void qemu_input_queue_process(void *opaque)
     }
 }
=20
-static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue=
,
+static void qemu_input_queue_delay(QemuInputEventQueueHead *queue,
                                    QEMUTimer *timer, uint32_t delay_ms)
 {
     QemuInputEventQueue *item =3D g_new0(QemuInputEventQueue, 1);
@@ -306,7 +308,7 @@ static void qemu_input_queue_delay(struct QemuInputEv=
entQueueHead *queue,
     }
 }
=20
-static void qemu_input_queue_event(struct QemuInputEventQueueHead *queue=
,
+static void qemu_input_queue_event(QemuInputEventQueueHead *queue,
                                    QemuConsole *src, InputEvent *evt)
 {
     QemuInputEventQueue *item =3D g_new0(QemuInputEventQueue, 1);
@@ -318,7 +320,7 @@ static void qemu_input_queue_event(struct QemuInputEv=
entQueueHead *queue,
     queue_count++;
 }
=20
-static void qemu_input_queue_sync(struct QemuInputEventQueueHead *queue)
+static void qemu_input_queue_sync(QemuInputEventQueueHead *queue)
 {
     QemuInputEventQueue *item =3D g_new0(QemuInputEventQueue, 1);
=20
--=20
2.20.1

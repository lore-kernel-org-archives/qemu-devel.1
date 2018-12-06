Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2zf-0003DD-Ma
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV2ze-0001Qh-7Q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV2zb-0001Eh-Ok
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:23:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B27B82D7E0
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:38 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-16.ams2.redhat.com
	[10.36.112.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 159866155E
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 23:23:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  7 Dec 2018 00:23:30 +0100
Message-Id: <20181206232333.22408-4-pbonzini@redhat.com>
In-Reply-To: <20181206232333.22408-1-pbonzini@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] qemu/queue.h: typedef QTAILQ heads
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c            |  3 ++-
 include/qom/cpu.h |  5 +++--
 ui/input.c        | 14 ++++++++------
 3 files changed, 13 insertions(+), 9 deletions(-)

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
2.19.2

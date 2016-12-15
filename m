Received: from eggs.gnu.org ([2001:4830:134:3::10]:42200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBh-0002Ap-Sf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBe-00018u-Qt
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59019
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBe-00018O-LT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jfZO079889
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:18 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm7902y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:17 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:17 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:11 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-18-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 17/67] iothread: Stop threads before main()
 quits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

Right after main_loop ends, we release various things but keep iothread
alive. The latter is not prepared to the sudden change of resources.

Specifically, after bdrv_close_all(), virtio-scsi dataplane get a
surprise at the empty BlockBackend:

(gdb) bt
    at /usr/src/debug/qemu-2.6.0/hw/scsi/virtio-scsi.c:543
    at /usr/src/debug/qemu-2.6.0/hw/scsi/virtio-scsi.c:577

It is because the d->conf.blk->root is set to NULL, then
blk_get_aio_context() returns qemu_aio_context, whereas s->ctx is still
pointing to the iothread:

    hw/scsi/virtio-scsi.c:543:

    if (s->dataplane_started) {
        assert(blk_get_aio_context(d->conf.blk) == s->ctx);
    }

To fix this, let's stop iothreads before doing bdrv_close_all().

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1473326931-9699-1-git-send-email-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit dce8921b2baaf95974af8176406881872067adfa)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/sysemu/iothread.h |  1 +
 iothread.c                | 24 ++++++++++++++++++++----
 vl.c                      |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 2eefea1..68ac2de 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -35,5 +35,6 @@ typedef struct {
 
 char *iothread_get_id(IOThread *iothread);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+void iothread_stop_all(void);
 
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index f183d38..fb08a60 100644
--- a/iothread.c
+++ b/iothread.c
@@ -54,16 +54,25 @@ static void *iothread_run(void *opaque)
     return NULL;
 }
 
-static void iothread_instance_finalize(Object *obj)
+static int iothread_stop(Object *object, void *opaque)
 {
-    IOThread *iothread = IOTHREAD(obj);
+    IOThread *iothread;
 
-    if (!iothread->ctx) {
-        return;
+    iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
+    if (!iothread || !iothread->ctx) {
+        return 0;
     }
     iothread->stopping = true;
     aio_notify(iothread->ctx);
     qemu_thread_join(&iothread->thread);
+    return 0;
+}
+
+static void iothread_instance_finalize(Object *obj)
+{
+    IOThread *iothread = IOTHREAD(obj);
+
+    iothread_stop(obj, NULL);
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
     aio_context_unref(iothread->ctx);
@@ -174,3 +183,10 @@ IOThreadInfoList *qmp_query_iothreads(Error **errp)
     object_child_foreach(container, query_one_iothread, &prev);
     return head;
 }
+
+void iothread_stop_all(void)
+{
+    Object *container = object_get_objects_root();
+
+    object_child_foreach(container, iothread_stop, NULL);
+}
diff --git a/vl.c b/vl.c
index b3c80d5..3414e1a 100644
--- a/vl.c
+++ b/vl.c
@@ -121,6 +121,7 @@ int main(int argc, char **argv)
 #include "crypto/init.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
+#include "sysemu/iothread.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 #define MAX_SCLP_CONSOLES 1
@@ -4603,6 +4604,7 @@ int main(int argc, char **argv, char **envp)
     trace_init_vcpu_events();
     main_loop();
     replay_disable_events();
+    iothread_stop_all();
 
     bdrv_close_all();
     pause_all_vcpus();
-- 
1.9.1

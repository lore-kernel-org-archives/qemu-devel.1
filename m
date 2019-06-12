Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E0C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7550C208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7550C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb28U-0003rY-Bm
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hb24U-0001RY-66
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hb202-0007Ff-EU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:05:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hb200-00070u-El
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31DBA3162919;
 Wed, 12 Jun 2019 12:04:28 +0000 (UTC)
Received: from localhost (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35401614C4;
 Wed, 12 Jun 2019 12:04:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 13:04:21 +0100
Message-Id: <20190612120421.20336-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 12 Jun 2019 12:04:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4] virtio-scsi: restart DMA after iothread
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the 'cont' command resumes guest execution the vm change state
handlers are invoked.  Unfortunately there is no explicit ordering
between vm change state handlers.  When two layers of code both use vm
change state handlers, we don't control which handler runs first.

virtio-scsi with iothreads hits a deadlock when a failed SCSI command is
restarted and completes before the iothread is re-initialized.

This patch introduces priorities for VM change state handlers so the
IOThread is guaranteed to be initialized before DMA requests are
restarted.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v4:
Paolo and Michael were interested in a priorities system.  Kevin wasn't
convinced.  Here is a patch implementing the priorities approach so you
can decide whether you prefer this or not.

The customer has now confirmed that the deadlock is fixed.  I have
changed the Subject line from RFC to PATCH.

 include/sysemu/sysemu.h | 10 ++++++++++
 hw/scsi/scsi-bus.c      |  6 ++++--
 hw/virtio/virtio.c      |  6 ++++--
 vl.c                    | 44 +++++++++++++++++++++++++++++++----------
 4 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 61579ae71e..1a4db092c7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -27,8 +27,18 @@ bool runstate_store(char *str, size_t size);
 typedef struct vm_change_state_entry VMChangeStateEntry;
 typedef void VMChangeStateHandler(void *opaque, int running, RunState st=
ate);
=20
+enum {
+    /* Low priorities run first when the VM starts */
+    VM_CHANGE_STATE_HANDLER_PRIO_UNDEFINED =3D 0,
+    VM_CHANGE_STATE_HANDLER_PRIO_IOTHREAD =3D 100,
+    VM_CHANGE_STATE_HANDLER_PRIO_DEVICE =3D 200,
+    /* High priorities run first when the VM stops */
+};
+
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
                                                      void *opaque);
+VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
+        VMChangeStateHandler *cb, void *opaque, int priority);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 void vm_state_notify(int running, RunState state);
=20
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c480553083..eda5b9a19e 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -206,8 +206,10 @@ static void scsi_qdev_realize(DeviceState *qdev, Err=
or **errp)
         error_propagate(errp, local_err);
         return;
     }
-    dev->vmsentry =3D qemu_add_vm_change_state_handler(scsi_dma_restart_=
cb,
-                                                     dev);
+    dev->vmsentry =3D qemu_add_vm_change_state_handler_prio(
+            scsi_dma_restart_cb,
+            dev,
+            VM_CHANGE_STATE_HANDLER_PRIO_DEVICE);
 }
=20
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 07f4a64b48..9256af587a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2354,8 +2354,10 @@ void virtio_init(VirtIODevice *vdev, const char *n=
ame,
     } else {
         vdev->config =3D NULL;
     }
-    vdev->vmstate =3D qemu_add_vm_change_state_handler(virtio_vmstate_ch=
ange,
-                                                     vdev);
+    vdev->vmstate =3D qemu_add_vm_change_state_handler_prio(
+            virtio_vmstate_change,
+            vdev,
+            VM_CHANGE_STATE_HANDLER_PRIO_IOTHREAD);
     vdev->device_endian =3D virtio_default_endian();
     vdev->use_guest_notifier_mask =3D true;
 }
diff --git a/vl.c b/vl.c
index cd1fbc4cdc..26c82063d2 100644
--- a/vl.c
+++ b/vl.c
@@ -1469,27 +1469,45 @@ static int machine_help_func(QemuOpts *opts, Mach=
ineState *machine)
 struct vm_change_state_entry {
     VMChangeStateHandler *cb;
     void *opaque;
-    QLIST_ENTRY (vm_change_state_entry) entries;
+    QTAILQ_ENTRY (vm_change_state_entry) entries;
+    int priority;
 };
=20
-static QLIST_HEAD(, vm_change_state_entry) vm_change_state_head;
+static QTAILQ_HEAD(, vm_change_state_entry) vm_change_state_head;
=20
-VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
-                                                     void *opaque)
+VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
+        VMChangeStateHandler *cb, void *opaque, int priority)
 {
     VMChangeStateEntry *e;
+    VMChangeStateEntry *other;
=20
     e =3D g_malloc0(sizeof (*e));
-
     e->cb =3D cb;
     e->opaque =3D opaque;
-    QLIST_INSERT_HEAD(&vm_change_state_head, e, entries);
+    e->priority =3D priority;
+
+    /* Keep list sorted in ascending priority order */
+    QTAILQ_FOREACH(other, &vm_change_state_head, entries) {
+        if (priority < other->priority) {
+            QTAILQ_INSERT_BEFORE(other, e, entries);
+            return e;
+        }
+    }
+
+    QTAILQ_INSERT_TAIL(&vm_change_state_head, e, entries);
     return e;
 }
=20
+VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
+                                                     void *opaque)
+{
+    return qemu_add_vm_change_state_handler_prio(cb, opaque,
+            VM_CHANGE_STATE_HANDLER_PRIO_UNDEFINED);
+}
+
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
 {
-    QLIST_REMOVE (e, entries);
+    QTAILQ_REMOVE (&vm_change_state_head, e, entries);
     g_free (e);
 }
=20
@@ -1499,8 +1517,14 @@ void vm_state_notify(int running, RunState state)
=20
     trace_vm_state_notify(running, state, RunState_str(state));
=20
-    QLIST_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-        e->cb(e->opaque, running, state);
+    if (running) {
+        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
+            e->cb(e->opaque, running, state);
+        }
+    } else {
+        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, n=
ext) {
+            e->cb(e->opaque, running, state);
+        }
     }
 }
=20
@@ -3009,7 +3033,7 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
=20
-    QLIST_INIT (&vm_change_state_head);
+    QTAILQ_INIT (&vm_change_state_head);
     os_setup_early_signal_handling();
=20
     cpu_option =3D NULL;
--=20
2.21.0



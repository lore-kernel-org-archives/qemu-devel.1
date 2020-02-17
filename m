Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7FDC3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B224420726
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B224420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3V7C-0003Dg-Ry
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 20:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j3V6M-0001t4-Qu
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j3V6L-0006U2-Af
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2713 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j3V6K-0006GX-Nn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:33 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 889FB81645C126A7E2DC;
 Mon, 17 Feb 2020 09:21:24 +0800 (CST)
Received: from huawei.com (10.133.214.142) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 09:21:17 +0800
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/3] migration/colo: wrap incoming checkpoint process into new
 helper
Date: Mon, 17 Feb 2020 09:20:47 +0800
Message-ID: <20200217012049.22988-2-zhang.zhanghailiang@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
References: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.214.142]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: danielcho@qnap.com, chen.zhang@intel.com,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split checkpoint incoming process into a helper.

Signed-off-by: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 260 ++++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 127 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 2c88aa57a2..93c5a452fb 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -664,13 +664,138 @@ void migrate_start_colo_process(MigrationState *s)
     qemu_mutex_lock_iothread();
 }
=20
-static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_reques=
t,
-                                     Error **errp)
+static void colo_incoming_process_checkpoint(MigrationIncomingState *mis=
,
+                      QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp=
)
+{
+    uint64_t total_size;
+    uint64_t value;
+    Error *local_err =3D NULL;
+    int ret;
+
+    qemu_mutex_lock_iothread();
+    vm_stop_force_state(RUN_STATE_COLO);
+    trace_colo_vm_state_change("run", "stop");
+    qemu_mutex_unlock_iothread();
+
+    /* FIXME: This is unnecessary for periodic checkpoint mode */
+    colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
+                 &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    colo_receive_check_message(mis->from_src_file,
+                       COLO_MESSAGE_VMSTATE_SEND, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_mutex_lock_iothread();
+    cpu_synchronize_all_pre_loadvm();
+    ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
+    qemu_mutex_unlock_iothread();
+
+    if (ret < 0) {
+        error_setg(errp, "Load VM's live state (ram) error");
+        return;
+    }
+
+    value =3D colo_receive_message_value(mis->from_src_file,
+                             COLO_MESSAGE_VMSTATE_SIZE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * Read VM device state data into channel buffer,
+     * It's better to re-use the memory allocated.
+     * Here we need to handle the channel buffer directly.
+     */
+    if (value > bioc->capacity) {
+        bioc->capacity =3D value;
+        bioc->data =3D g_realloc(bioc->data, bioc->capacity);
+    }
+    total_size =3D qemu_get_buffer(mis->from_src_file, bioc->data, value=
);
+    if (total_size !=3D value) {
+        error_setg(errp, "Got %" PRIu64 " VMState data, less than expect=
ed"
+                    " %" PRIu64, total_size, value);
+        return;
+    }
+    bioc->usage =3D total_size;
+    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
+
+    colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_RECEIVED,
+                 &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_mutex_lock_iothread();
+    vmstate_loading =3D true;
+    ret =3D qemu_load_device_state(fb);
+    if (ret < 0) {
+        error_setg(errp, "COLO: load device state failed");
+        qemu_mutex_unlock_iothread();
+        return;
+    }
+
+#ifdef CONFIG_REPLICATION
+    replication_get_error_all(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        qemu_mutex_unlock_iothread();
+        return;
+    }
+
+    /* discard colo disk buffer */
+    replication_do_checkpoint_all(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        qemu_mutex_unlock_iothread();
+        return;
+    }
+#else
+    abort();
+#endif
+    /* Notify all filters of all NIC to do checkpoint */
+    colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        qemu_mutex_unlock_iothread();
+        return;
+    }
+
+    vmstate_loading =3D false;
+    vm_start();
+    trace_colo_vm_state_change("stop", "run");
+    qemu_mutex_unlock_iothread();
+
+    if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
+        failover_set_state(FAILOVER_STATUS_RELAUNCH,
+                        FAILOVER_STATUS_NONE);
+        failover_request_active(NULL);
+        return;
+    }
+
+    colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_LOADED,
+                 &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
+
+static void colo_wait_handle_message(MigrationIncomingState *mis,
+                QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
 {
     COLOMessage msg;
     Error *local_err =3D NULL;
=20
-    msg =3D colo_receive_message(f, &local_err);
+    msg =3D colo_receive_message(mis->from_src_file, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -678,10 +803,9 @@ static void colo_wait_handle_message(QEMUFile *f, in=
t *checkpoint_request,
=20
     switch (msg) {
     case COLO_MESSAGE_CHECKPOINT_REQUEST:
-        *checkpoint_request =3D 1;
+        colo_incoming_process_checkpoint(mis, fb, bioc, errp);
         break;
     default:
-        *checkpoint_request =3D 0;
         error_setg(errp, "Got unknown COLO message: %d", msg);
         break;
     }
@@ -692,10 +816,7 @@ void *colo_process_incoming_thread(void *opaque)
     MigrationIncomingState *mis =3D opaque;
     QEMUFile *fb =3D NULL;
     QIOChannelBuffer *bioc =3D NULL; /* Cache incoming device state */
-    uint64_t total_size;
-    uint64_t value;
     Error *local_err =3D NULL;
-    int ret;
=20
     rcu_register_thread();
     qemu_sem_init(&mis->colo_incoming_sem, 0);
@@ -749,134 +870,19 @@ void *colo_process_incoming_thread(void *opaque)
     }
=20
     while (mis->state =3D=3D MIGRATION_STATUS_COLO) {
-        int request =3D 0;
-
-        colo_wait_handle_message(mis->from_src_file, &request, &local_er=
r);
+        colo_wait_handle_message(mis, fb, bioc, &local_err);
         if (local_err) {
-            goto out;
+            error_report_err(local_err);
+            break;
         }
-        assert(request);
         if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
             error_report("failover request");
-            goto out;
-        }
-
-        qemu_mutex_lock_iothread();
-        vm_stop_force_state(RUN_STATE_COLO);
-        trace_colo_vm_state_change("run", "stop");
-        qemu_mutex_unlock_iothread();
-
-        /* FIXME: This is unnecessary for periodic checkpoint mode */
-        colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPL=
Y,
-                     &local_err);
-        if (local_err) {
-            goto out;
-        }
-
-        colo_receive_check_message(mis->from_src_file,
-                           COLO_MESSAGE_VMSTATE_SEND, &local_err);
-        if (local_err) {
-            goto out;
-        }
-
-        qemu_mutex_lock_iothread();
-        cpu_synchronize_all_pre_loadvm();
-        ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
-        qemu_mutex_unlock_iothread();
-
-        if (ret < 0) {
-            error_report("Load VM's live state (ram) error");
-            goto out;
-        }
-
-        value =3D colo_receive_message_value(mis->from_src_file,
-                                 COLO_MESSAGE_VMSTATE_SIZE, &local_err);
-        if (local_err) {
-            goto out;
-        }
-
-        /*
-         * Read VM device state data into channel buffer,
-         * It's better to re-use the memory allocated.
-         * Here we need to handle the channel buffer directly.
-         */
-        if (value > bioc->capacity) {
-            bioc->capacity =3D value;
-            bioc->data =3D g_realloc(bioc->data, bioc->capacity);
-        }
-        total_size =3D qemu_get_buffer(mis->from_src_file, bioc->data, v=
alue);
-        if (total_size !=3D value) {
-            error_report("Got %" PRIu64 " VMState data, less than expect=
ed"
-                        " %" PRIu64, total_size, value);
-            goto out;
-        }
-        bioc->usage =3D total_size;
-        qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
-
-        colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_RECEIVE=
D,
-                     &local_err);
-        if (local_err) {
-            goto out;
-        }
-
-        qemu_mutex_lock_iothread();
-        vmstate_loading =3D true;
-        ret =3D qemu_load_device_state(fb);
-        if (ret < 0) {
-            error_report("COLO: load device state failed");
-            qemu_mutex_unlock_iothread();
-            goto out;
-        }
-
-#ifdef CONFIG_REPLICATION
-        replication_get_error_all(&local_err);
-        if (local_err) {
-            qemu_mutex_unlock_iothread();
-            goto out;
-        }
-
-        /* discard colo disk buffer */
-        replication_do_checkpoint_all(&local_err);
-        if (local_err) {
-            qemu_mutex_unlock_iothread();
-            goto out;
-        }
-#else
-        abort();
-#endif
-        /* Notify all filters of all NIC to do checkpoint */
-        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
-
-        if (local_err) {
-            qemu_mutex_unlock_iothread();
-            goto out;
-        }
-
-        vmstate_loading =3D false;
-        vm_start();
-        trace_colo_vm_state_change("stop", "run");
-        qemu_mutex_unlock_iothread();
-
-        if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
-            failover_set_state(FAILOVER_STATUS_RELAUNCH,
-                            FAILOVER_STATUS_NONE);
-            failover_request_active(NULL);
-            goto out;
-        }
-
-        colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_LOADED,
-                     &local_err);
-        if (local_err) {
-            goto out;
+            break;
         }
     }
=20
 out:
     vmstate_loading =3D false;
-    /* Throw the unreported error message after exited from loop */
-    if (local_err) {
-        error_report_err(local_err);
-    }
=20
     /*
      * There are only two reasons we can get here, some error happened
--=20
2.21.0




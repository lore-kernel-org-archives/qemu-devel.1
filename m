Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E671EC3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55A1246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUVVNzqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55A1246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7bzr-0002kc-MA
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7bu1-0000lc-OO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7bu0-0004EP-03
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7btz-0004E9-Sz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582881947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHQvkIrJwASSeuU++Wd5hvR4gc9mmlZ3ev3VOatSSHg=;
 b=IUVVNzqW2oRMLNx5A5rxmXD2c+PvSq4LAly2X7f3fvbIfJUgkfCRW7z9CJtxIYIjHQbyMZ
 h9twS+4YxyEKUTZ4j8F7yc7J6z0YO9XlZwVRkhE10r7QxjqeOPl3dSJZDpjy4WSw76BcXs
 KWePaEUeWxdNlhkvv7FJ1sRCq5eP8zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-ExGlHOqwM_-KFX_fklaMBA-1; Fri, 28 Feb 2020 04:25:45 -0500
X-MC-Unique: ExGlHOqwM_-KFX_fklaMBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A73A1005513;
 Fri, 28 Feb 2020 09:25:44 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E561760BE0;
 Fri, 28 Feb 2020 09:25:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] migration/colo: wrap incoming checkpoint process into
 new helper
Date: Fri, 28 Feb 2020 10:24:19 +0100
Message-Id: <20200228092420.103757-15-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-1-quintela@redhat.com>
References: <20200228092420.103757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Split checkpoint incoming process into a helper.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
-static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
-                                     Error **errp)
+static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
+                      QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
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
+    total_size =3D qemu_get_buffer(mis->from_src_file, bioc->data, value);
+    if (total_size !=3D value) {
+        error_setg(errp, "Got %" PRIu64 " VMState data, less than expected=
"
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
@@ -678,10 +803,9 @@ static void colo_wait_handle_message(QEMUFile *f, int =
*checkpoint_request,
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
-        colo_wait_handle_message(mis->from_src_file, &request, &local_err)=
;
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
-        colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
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
-        total_size =3D qemu_get_buffer(mis->from_src_file, bioc->data, val=
ue);
-        if (total_size !=3D value) {
-            error_report("Got %" PRIu64 " VMState data, less than expected=
"
-                        " %" PRIu64, total_size, value);
-            goto out;
-        }
-        bioc->usage =3D total_size;
-        qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
-
-        colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_RECEIVED,
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
2.24.1



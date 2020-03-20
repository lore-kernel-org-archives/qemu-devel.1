Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C3C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F75C20732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhQ8rYt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F75C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGRK-0003OI-NR
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGPN-0000HV-96
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGPK-0008JG-KB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:49 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>)
 id 1jFGPK-0008J0-BI; Fri, 20 Mar 2020 08:05:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id i13so3137154pfe.3;
 Fri, 20 Mar 2020 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GujFRSzJOGYDr6YVy7fdZab487Vei1YklehHD5S0Hr4=;
 b=rhQ8rYt3d/kSZdD0fCYESYpfLV7/awjsKdGGaqZ4+KVRpRm1J3XfmWsnyu6IUcjdLz
 L8/ft/OuhGc+DykL2G8Ll2YKYVOgK48XdjVYCD14aANIwUH3eE/khh2YWiVvYXzJMOVH
 GCbwbQaI0kjkD7tMFcH0GTC/j9Irw5qaIdOzCTDpggDPa7sMfNe9XJVf4H1RNtPj5OQL
 Ud3uwno58uuqxD5d+5J4BACLS8L5ZueaKuqAqYd+VqYWurkDKfPzkOaZSDlAqOrS8HMT
 nMm2z/R2VEYh59a5P/0MjHWrExIJ7HdN1Bp9OZiVBXgWyIdcpSsqwzW8sYfVchQBVp5o
 dIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GujFRSzJOGYDr6YVy7fdZab487Vei1YklehHD5S0Hr4=;
 b=eMQyeca5yrTn9XuoERuSrnRAExEwKtHKsl7P7u8vHTgVoieYYhCr9FLZjpI/FRrWHR
 eioNu8STM0e1h8hHowBj9m84jOGfiNm7hp8aDbnVDebkkAVCOoB0uCTmUVTXDzNSF7GC
 nJPw6I7/p08RsLv2wX02WZqx+E+Y1xsnU2LVCWPN9G7IcYDHIC96H6K9SYdgpUXY+XAi
 iSvyw8O3fH+QRa1Tc9s91kYJ1yNxyYmhCr92P+kZMLehhvqAvBKPASNX25UJP/LtYd2I
 iGcUffP77mjDKW88wTGcnegiQXoXcpmBwSk0sYZmzuE0u0X2Mb+9Tq7qBCX6AP6+hTW5
 JmdA==
X-Gm-Message-State: ANhLgQ2tMzidjU8anJi9fQ1KS+s1ZmxUvfpxenUfHzyv69zXCmJP8Dmg
 HotkMJgrfHmZuV03p3Ut52g=
X-Google-Smtp-Source: ADFU+vuovUstLBQSvbDHGRYUVcwLH6vzCcQuszGjMqoj5IJOykTxab5UfMLpAflrDg3nRUU1Ct/qAg==
X-Received: by 2002:a62:342:: with SMTP id 63mr9765257pfd.19.1584705944267;
 Fri, 20 Mar 2020 05:05:44 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id z125sm5617660pfz.92.2020.03.20.05.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 05:05:43 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v3 2/2] lockable: replaced locks with lock guard macros where
 appropriate
Date: Fri, 20 Mar 2020 05:04:56 -0700
Message-Id: <20200320120456.1931482-3-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320120456.1931482-1-dnbrdsky@gmail.com>
References: <20200320120456.1931482-1-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Brodsky <dnbrdsky@gmail.com>

- ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
- replaced result with QEMU_LOCK_GUARD if all unlocks at function end
- replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end

Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
---
 block/iscsi.c         | 11 +++-------
 block/nfs.c           | 51 ++++++++++++++++++++-----------------------
 cpus-common.c         | 13 +++++------
 hw/display/qxl.c      | 43 +++++++++++++++++-------------------
 hw/vfio/platform.c    |  5 ++---
 migration/migration.c |  3 +--
 migration/multifd.c   |  8 +++----
 migration/ram.c       |  3 +--
 monitor/misc.c        |  4 +---
 ui/spice-display.c    | 14 ++++++------
 util/log.c            |  4 ++--
 util/qemu-timer.c     | 17 +++++++--------
 util/rcu.c            |  8 +++----
 util/thread-pool.c    |  3 +--
 util/vfio-helpers.c   |  4 ++--
 15 files changed, 84 insertions(+), 107 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 682abd8e09..89f8a656a4 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1086,7 +1086,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb->task->expxferlen = acb->ioh->dxfer_len;
 
     data.size = 0;
-    qemu_mutex_lock(&iscsilun->mutex);
+    QEMU_LOCK_GUARD(&iscsilun->mutex);
     if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
         if (acb->ioh->iovec_count == 0) {
             data.data = acb->ioh->dxferp;
@@ -1102,7 +1102,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
                                  iscsi_aio_ioctl_cb,
                                  (data.size > 0) ? &data : NULL,
                                  acb) != 0) {
-        qemu_mutex_unlock(&iscsilun->mutex);
         scsi_free_scsi_task(acb->task);
         qemu_aio_unref(acb);
         return NULL;
@@ -1122,7 +1121,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     }
 
     iscsi_set_events(iscsilun);
-    qemu_mutex_unlock(&iscsilun->mutex);
 
     return &acb->common;
 }
@@ -1395,20 +1393,17 @@ static void iscsi_nop_timed_event(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
-    qemu_mutex_lock(&iscsilun->mutex);
+    QEMU_LOCK_GUARD(&iscsilun->mutex);
     if (iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
     } else if (iscsi_nop_out_async(iscsilun->iscsi, NULL, NULL, 0, NULL) != 0) {
         error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messages.");
-        goto out;
+        return;
     }
 
     timer_mod(iscsilun->nop_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NOP_INTERVAL);
     iscsi_set_events(iscsilun);
-
-out:
-    qemu_mutex_unlock(&iscsilun->mutex);
 }
 
 static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
diff --git a/block/nfs.c b/block/nfs.c
index 9a6311e270..09a78aede8 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -273,15 +273,14 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
     nfs_co_init_task(bs, &task);
     task.iov = iov;
 
-    qemu_mutex_lock(&client->mutex);
-    if (nfs_pread_async(client->context, client->fh,
-                        offset, bytes, nfs_co_generic_cb, &task) != 0) {
-        qemu_mutex_unlock(&client->mutex);
-        return -ENOMEM;
-    }
+    WITH_QEMU_LOCK_GUARD(&client->mutex) {
+        if (nfs_pread_async(client->context, client->fh,
+                            offset, bytes, nfs_co_generic_cb, &task) != 0) {
+            return -ENOMEM;
+        }
 
-    nfs_set_events(client);
-    qemu_mutex_unlock(&client->mutex);
+        nfs_set_events(client);
+    }
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -320,19 +319,18 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
         buf = iov->iov[0].iov_base;
     }
 
-    qemu_mutex_lock(&client->mutex);
-    if (nfs_pwrite_async(client->context, client->fh,
-                         offset, bytes, buf,
-                         nfs_co_generic_cb, &task) != 0) {
-        qemu_mutex_unlock(&client->mutex);
-        if (my_buffer) {
-            g_free(buf);
+    WITH_QEMU_LOCK_GUARD(&client->mutex) {
+        if (nfs_pwrite_async(client->context, client->fh,
+                             offset, bytes, buf,
+                             nfs_co_generic_cb, &task) != 0) {
+            if (my_buffer) {
+                g_free(buf);
+            }
+            return -ENOMEM;
         }
-        return -ENOMEM;
-    }
 
-    nfs_set_events(client);
-    qemu_mutex_unlock(&client->mutex);
+        nfs_set_events(client);
+    }
     while (!task.complete) {
         qemu_coroutine_yield();
     }
@@ -355,15 +353,14 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
 
     nfs_co_init_task(bs, &task);
 
-    qemu_mutex_lock(&client->mutex);
-    if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
-                        &task) != 0) {
-        qemu_mutex_unlock(&client->mutex);
-        return -ENOMEM;
-    }
+    WITH_QEMU_LOCK_GUARD(&client->mutex) {
+        if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
+                            &task) != 0) {
+            return -ENOMEM;
+        }
 
-    nfs_set_events(client);
-    qemu_mutex_unlock(&client->mutex);
+        nfs_set_events(client);
+    }
     while (!task.complete) {
         qemu_coroutine_yield();
     }
diff --git a/cpus-common.c b/cpus-common.c
index eaf590cb38..a058f3e44c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -22,6 +22,7 @@
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpus.h"
+#include "qemu/lockable.h"
 
 static QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -71,7 +72,7 @@ static int cpu_get_free_index(void)
 
 void cpu_list_add(CPUState *cpu)
 {
-    qemu_mutex_lock(&qemu_cpu_list_lock);
+    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
         cpu->cpu_index = cpu_get_free_index();
         assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
@@ -79,12 +80,11 @@ void cpu_list_add(CPUState *cpu)
         assert(!cpu_index_auto_assigned);
     }
     QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
-    qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
 void cpu_list_remove(CPUState *cpu)
 {
-    qemu_mutex_lock(&qemu_cpu_list_lock);
+    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (!QTAILQ_IN_USE(cpu, node)) {
         /* there is nothing to undo since cpu_exec_init() hasn't been called */
         qemu_mutex_unlock(&qemu_cpu_list_lock);
@@ -95,7 +95,6 @@ void cpu_list_remove(CPUState *cpu)
 
     QTAILQ_REMOVE_RCU(&cpus, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
-    qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
 struct qemu_work_item {
@@ -237,7 +236,7 @@ void cpu_exec_start(CPUState *cpu)
      * see cpu->running == true, and it will kick the CPU.
      */
     if (unlikely(atomic_read(&pending_cpus))) {
-        qemu_mutex_lock(&qemu_cpu_list_lock);
+        QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
         if (!cpu->has_waiter) {
             /* Not counted in pending_cpus, let the exclusive item
              * run.  Since we have the lock, just set cpu->running to true
@@ -252,7 +251,6 @@ void cpu_exec_start(CPUState *cpu)
              * waiter at cpu_exec_end.
              */
         }
-        qemu_mutex_unlock(&qemu_cpu_list_lock);
     }
 }
 
@@ -280,7 +278,7 @@ void cpu_exec_end(CPUState *cpu)
      * next cpu_exec_start.
      */
     if (unlikely(atomic_read(&pending_cpus))) {
-        qemu_mutex_lock(&qemu_cpu_list_lock);
+        QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
         if (cpu->has_waiter) {
             cpu->has_waiter = false;
             atomic_set(&pending_cpus, pending_cpus - 1);
@@ -288,7 +286,6 @@ void cpu_exec_end(CPUState *cpu)
                 qemu_cond_signal(&exclusive_cond);
             }
         }
-        qemu_mutex_unlock(&qemu_cpu_list_lock);
     }
 }
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 227da69a50..d5627119ec 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -478,18 +478,19 @@ static int qxl_track_command(PCIQXLDevice *qxl, struct QXLCommandExt *ext)
                               cmd->u.surface_create.stride);
             return 1;
         }
-        qemu_mutex_lock(&qxl->track_lock);
-        if (cmd->type == QXL_SURFACE_CMD_CREATE) {
-            qxl->guest_surfaces.cmds[id] = ext->cmd.data;
-            qxl->guest_surfaces.count++;
-            if (qxl->guest_surfaces.max < qxl->guest_surfaces.count)
-                qxl->guest_surfaces.max = qxl->guest_surfaces.count;
+        WITH_QEMU_LOCK_GUARD(&qxl->track_lock) {
+            if (cmd->type == QXL_SURFACE_CMD_CREATE) {
+                qxl->guest_surfaces.cmds[id] = ext->cmd.data;
+                qxl->guest_surfaces.count++;
+                if (qxl->guest_surfaces.max < qxl->guest_surfaces.count) {
+                    qxl->guest_surfaces.max = qxl->guest_surfaces.count;
+                }
+            }
+            if (cmd->type == QXL_SURFACE_CMD_DESTROY) {
+                qxl->guest_surfaces.cmds[id] = 0;
+                qxl->guest_surfaces.count--;
+            }
         }
-        if (cmd->type == QXL_SURFACE_CMD_DESTROY) {
-            qxl->guest_surfaces.cmds[id] = 0;
-            qxl->guest_surfaces.count--;
-        }
-        qemu_mutex_unlock(&qxl->track_lock);
         break;
     }
     case QXL_CMD_CURSOR:
@@ -958,10 +959,9 @@ static void interface_update_area_complete(QXLInstance *sin,
     int i;
     int qxl_i;
 
-    qemu_mutex_lock(&qxl->ssd.lock);
+    QEMU_LOCK_GUARD(&qxl->ssd.lock);
     if (surface_id != 0 || !num_updated_rects ||
         !qxl->render_update_cookie_num) {
-        qemu_mutex_unlock(&qxl->ssd.lock);
         return;
     }
     trace_qxl_interface_update_area_complete(qxl->id, surface_id, dirty->left,
@@ -980,7 +980,6 @@ static void interface_update_area_complete(QXLInstance *sin,
          * Don't bother copying or scheduling the bh since we will flip
          * the whole area anyway on completion of the update_area async call
          */
-        qemu_mutex_unlock(&qxl->ssd.lock);
         return;
     }
     qxl_i = qxl->num_dirty_rects;
@@ -991,7 +990,6 @@ static void interface_update_area_complete(QXLInstance *sin,
     trace_qxl_interface_update_area_complete_schedule_bh(qxl->id,
                                                          qxl->num_dirty_rects);
     qemu_bh_schedule(qxl->update_area_bh);
-    qemu_mutex_unlock(&qxl->ssd.lock);
 }
 
 /* called from spice server thread context only */
@@ -1694,15 +1692,14 @@ static void ioport_write(void *opaque, hwaddr addr,
     case QXL_IO_MONITORS_CONFIG_ASYNC:
 async_common:
         async = QXL_ASYNC;
-        qemu_mutex_lock(&d->async_lock);
-        if (d->current_async != QXL_UNDEFINED_IO) {
-            qxl_set_guest_bug(d, "%d async started before last (%d) complete",
-                io_port, d->current_async);
-            qemu_mutex_unlock(&d->async_lock);
-            return;
+        WITH_QEMU_LOCK_GUARD(&d->async_lock) {
+            if (d->current_async != QXL_UNDEFINED_IO) {
+                qxl_set_guest_bug(d, "%d async started before last (%d) complete",
+                    io_port, d->current_async);
+                return;
+            }
+            d->current_async = orig_io_port;
         }
-        d->current_async = orig_io_port;
-        qemu_mutex_unlock(&d->async_lock);
         break;
     default:
         break;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 6b2952c034..ac2cefc9b1 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -22,6 +22,7 @@
 #include "hw/vfio/vfio-platform.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
@@ -216,7 +217,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
     VFIOPlatformDevice *vdev = intp->vdev;
     bool delay_handling = false;
 
-    qemu_mutex_lock(&vdev->intp_mutex);
+    QEMU_LOCK_GUARD(&vdev->intp_mutex);
     if (intp->state == VFIO_IRQ_INACTIVE) {
         QLIST_FOREACH(tmp, &vdev->intp_list, next) {
             if (tmp->state == VFIO_IRQ_ACTIVE ||
@@ -236,7 +237,6 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
         QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
                              intp, pqnext);
         ret = event_notifier_test_and_clear(intp->interrupt);
-        qemu_mutex_unlock(&vdev->intp_mutex);
         return;
     }
 
@@ -266,7 +266,6 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
                       vdev->mmap_timeout);
     }
-    qemu_mutex_unlock(&vdev->intp_mutex);
 }
 
 /**
diff --git a/migration/migration.c b/migration/migration.c
index c1d88ace7f..2f0bd6d8b4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1652,11 +1652,10 @@ static void migrate_fd_cleanup_bh(void *opaque)
 
 void migrate_set_error(MigrationState *s, const Error *error)
 {
-    qemu_mutex_lock(&s->error_mutex);
+    QEMU_LOCK_GUARD(&s->error_mutex);
     if (!s->error) {
         s->error = error_copy(error);
     }
-    qemu_mutex_unlock(&s->error_mutex);
 }
 
 void migrate_fd_error(MigrationState *s, const Error *error)
diff --git a/migration/multifd.c b/migration/multifd.c
index cb6a4a3ab8..9123c111a3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -894,11 +894,11 @@ void multifd_recv_sync_main(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        if (multifd_recv_state->packet_num < p->packet_num) {
-            multifd_recv_state->packet_num = p->packet_num;
+        WITH_QEMU_LOCK_GUARD(&p->mutex) {
+            if (multifd_recv_state->packet_num < p->packet_num) {
+                multifd_recv_state->packet_num = p->packet_num;
+            }
         }
-        qemu_mutex_unlock(&p->mutex);
         trace_multifd_recv_sync_main_signal(p->id);
         qemu_sem_post(&p->sem_sync);
     }
diff --git a/migration/ram.c b/migration/ram.c
index c12cfdbe26..87a670cfbf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1368,7 +1368,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
         return NULL;
     }
 
-    qemu_mutex_lock(&rs->src_page_req_mutex);
+    QEMU_LOCK_GUARD(&rs->src_page_req_mutex);
     if (!QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
         struct RAMSrcPageRequest *entry =
                                 QSIMPLEQ_FIRST(&rs->src_page_requests);
@@ -1385,7 +1385,6 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
             migration_consume_urgent_request();
         }
     }
-    qemu_mutex_unlock(&rs->src_page_req_mutex);
 
     return block;
 }
diff --git a/monitor/misc.c b/monitor/misc.c
index 6c45fa490f..9723b466cd 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1473,7 +1473,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     MonFdsetFd *mon_fdset_fd;
     AddfdInfo *fdinfo;
 
-    qemu_mutex_lock(&mon_fdsets_lock);
+    QEMU_LOCK_GUARD(&mon_fdsets_lock);
     if (has_fdset_id) {
         QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
             /* Break if match found or match impossible due to ordering by ID */
@@ -1494,7 +1494,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
             if (fdset_id < 0) {
                 error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdset-id",
                            "a non-negative value");
-                qemu_mutex_unlock(&mon_fdsets_lock);
                 return NULL;
             }
             /* Use specified fdset ID */
@@ -1545,7 +1544,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     fdinfo->fdset_id = mon_fdset->id;
     fdinfo->fd = mon_fdset_fd->fd;
 
-    qemu_mutex_unlock(&mon_fdsets_lock);
     return fdinfo;
 }
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 6babe24909..19632fdf6c 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "ui/qemu-spice.h"
 #include "qemu/timer.h"
+#include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
@@ -483,12 +484,12 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 {
     graphic_hw_update(ssd->dcl.con);
 
-    qemu_mutex_lock(&ssd->lock);
-    if (QTAILQ_EMPTY(&ssd->updates) && ssd->ds) {
-        qemu_spice_create_update(ssd);
-        ssd->notify++;
+    WITH_QEMU_LOCK_GUARD(&ssd->lock) {
+        if (QTAILQ_EMPTY(&ssd->updates) && ssd->ds) {
+            qemu_spice_create_update(ssd);
+            ssd->notify++;
+        }
     }
-    qemu_mutex_unlock(&ssd->lock);
 
     trace_qemu_spice_display_refresh(ssd->qxl.id, ssd->notify);
     if (ssd->notify) {
@@ -580,7 +581,7 @@ static int interface_get_cursor_command(QXLInstance *sin, QXLCommandExt *ext)
     SimpleSpiceDisplay *ssd = container_of(sin, SimpleSpiceDisplay, qxl);
     int ret;
 
-    qemu_mutex_lock(&ssd->lock);
+    QEMU_LOCK_GUARD(&ssd->lock);
     if (ssd->ptr_define) {
         *ext = ssd->ptr_define->ext;
         ssd->ptr_define = NULL;
@@ -592,7 +593,6 @@ static int interface_get_cursor_command(QXLInstance *sin, QXLCommandExt *ext)
     } else {
         ret = false;
     }
-    qemu_mutex_unlock(&ssd->lock);
     return ret;
 }
 
diff --git a/util/log.c b/util/log.c
index 2da6cb31dc..bdb3d712e8 100644
--- a/util/log.c
+++ b/util/log.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "trace/control.h"
 #include "qemu/thread.h"
+#include "qemu/lockable.h"
 
 static char *logfilename;
 static QemuMutex qemu_logfile_mutex;
@@ -94,7 +95,7 @@ void qemu_set_log(int log_flags)
     if (qemu_loglevel && (!is_daemonized() || logfilename)) {
         need_to_open_file = true;
     }
-    qemu_mutex_lock(&qemu_logfile_mutex);
+    QEMU_LOCK_GUARD(&qemu_logfile_mutex);
     if (qemu_logfile && !need_to_open_file) {
         logfile = qemu_logfile;
         atomic_rcu_set(&qemu_logfile, NULL);
@@ -136,7 +137,6 @@ void qemu_set_log(int log_flags)
         }
         atomic_rcu_set(&qemu_logfile, logfile);
     }
-    qemu_mutex_unlock(&qemu_logfile_mutex);
 }
 
 void qemu_log_needs_buffers(void)
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index d548d3c1ad..b6575a2cd5 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -459,17 +459,16 @@ void timer_mod_anticipate_ns(QEMUTimer *ts, int64_t expire_time)
     QEMUTimerList *timer_list = ts->timer_list;
     bool rearm;
 
-    qemu_mutex_lock(&timer_list->active_timers_lock);
-    if (ts->expire_time == -1 || ts->expire_time > expire_time) {
-        if (ts->expire_time != -1) {
-            timer_del_locked(timer_list, ts);
+    WITH_QEMU_LOCK_GUARD(&timer_list->active_timers_lock) {
+        if (ts->expire_time == -1 || ts->expire_time > expire_time) {
+            if (ts->expire_time != -1) {
+                timer_del_locked(timer_list, ts);
+            }
+            rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
+        } else {
+            rearm = false;
         }
-        rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
-    } else {
-        rearm = false;
     }
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
-
     if (rearm) {
         timerlist_rearm(timer_list);
     }
diff --git a/util/rcu.c b/util/rcu.c
index 177a675619..60a37f72c3 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -31,6 +31,7 @@
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockable.h"
 #if defined(CONFIG_MALLOC_TRIM)
 #include <malloc.h>
 #endif
@@ -141,14 +142,14 @@ static void wait_for_readers(void)
 
 void synchronize_rcu(void)
 {
-    qemu_mutex_lock(&rcu_sync_lock);
+    QEMU_LOCK_GUARD(&rcu_sync_lock);
 
     /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
      * Pairs with smp_mb_placeholder() in rcu_read_lock().
      */
     smp_mb_global();
 
-    qemu_mutex_lock(&rcu_registry_lock);
+    QEMU_LOCK_GUARD(&rcu_registry_lock);
     if (!QLIST_EMPTY(&registry)) {
         /* In either case, the atomic_mb_set below blocks stores that free
          * old RCU-protected pointers.
@@ -169,9 +170,6 @@ void synchronize_rcu(void)
 
         wait_for_readers();
     }
-
-    qemu_mutex_unlock(&rcu_registry_lock);
-    qemu_mutex_unlock(&rcu_sync_lock);
 }
 
 
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 4ed9b89ab2..d763cea505 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -210,7 +210,7 @@ static void thread_pool_cancel(BlockAIOCB *acb)
 
     trace_thread_pool_cancel(elem, elem->common.opaque);
 
-    qemu_mutex_lock(&pool->lock);
+    QEMU_LOCK_GUARD(&pool->lock);
     if (elem->state == THREAD_QUEUED &&
         /* No thread has yet started working on elem. we can try to "steal"
          * the item from the worker if we can get a signal from the
@@ -225,7 +225,6 @@ static void thread_pool_cancel(BlockAIOCB *acb)
         elem->ret = -ECANCELED;
     }
 
-    qemu_mutex_unlock(&pool->lock);
 }
 
 static AioContext *thread_pool_get_aio_context(BlockAIOCB *acb)
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index ddd9a96e76..b310b23003 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -21,6 +21,7 @@
 #include "standard-headers/linux/pci_regs.h"
 #include "qemu/event_notifier.h"
 #include "qemu/vfio-helpers.h"
+#include "qemu/lockable.h"
 #include "trace.h"
 
 #define QEMU_VFIO_DEBUG 0
@@ -667,14 +668,13 @@ int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
         .size = QEMU_VFIO_IOVA_MAX - s->high_water_mark,
     };
     trace_qemu_vfio_dma_reset_temporary(s);
-    qemu_mutex_lock(&s->lock);
+    QEMU_LOCK_GUARD(&s->lock);
     if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
         qemu_mutex_unlock(&s->lock);
         return -errno;
     }
     s->high_water_mark = QEMU_VFIO_IOVA_MAX;
-    qemu_mutex_unlock(&s->lock);
     return 0;
 }
 
-- 
2.25.1



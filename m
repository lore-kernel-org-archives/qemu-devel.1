Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B4C2D0F0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391BA20658
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKADJlKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391BA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJg7I-0004oN-E2
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJg6W-0004CZ-81
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJg6U-0003m5-MR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:20:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jJg6U-0003lg-Df
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:20:34 -0400
Received: by mail-pg1-x542.google.com with SMTP id 142so271486pgf.11
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=L1BXvk7EYyavYoWC6+PnjJYI+2tyuoHez4RGx6hJQJE=;
 b=vKADJlKSb31veShb5qDLYy1prCW+B91t7fQiOKdGiTAXuWurttSd1cJT35rFKp08+q
 /Bp49eAZvEejZ/aZ6UqoCueqNrlFwyuzqY4+MeGLRW4rF+fpx6GAJu4CNKRihHr11K19
 Rr5jGtZzfhZAENfS2hpN4cgBHsU8Xm7xhPWm4iuaOVtoZHozWMQW/GmJUyy349UCDMzG
 gzQoGwDhGONHYaveoVTREztBg7TTxI7vwZBLKS4IGMXFwd/B2de8sLxa3+s6YdSaf8Tu
 CxWc/5udWHJfKBfGLQBadxUNsTXASTpXhxIdQ3FKT1yN5F8L+wO8CLk6lOZHErLA8U0s
 I97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=L1BXvk7EYyavYoWC6+PnjJYI+2tyuoHez4RGx6hJQJE=;
 b=jcVbXk5jITz0YV5q8VaRD67JQtwJm+bHeBEHrOiSk3PvJkvuyi1c1nhXJAbRHUcpyB
 735IK2OmDqZ2dKIWOf5HZEKI8yF2OJTg4Ar9PexzkGpE2D9+snmUBLFcERw6AW3sPvtB
 8ATJ0NgmifhqnUCqzJOX62j8Wl7XtJtmvXwHeJdjW2wZib+AZfMVjIO9MZk2kmzSm2Ik
 6Pa2IWl1BnUVS6EmVWeW0r0lNBFUhmml13XLVGS3iRrxb3o8QjIgJ8qwb2ZMZCC7LaBE
 XQmzUm4/tY65Wt/EbsdCQWOlnCsiu7vYCV2CNWASLah5udB8FuoG7J1R6ly+wtSQxlpx
 OaSw==
X-Gm-Message-State: AGi0PuZ6lzV1huYKz5NfkyPxU1iiuckD2jW8g4s2UC5vjKVpwlQ0tjtc
 +C/DjPGJb1O5dZAmLqiqPzk=
X-Google-Smtp-Source: APiQypJ51j8P4sDw65/2KQYptRmrUfKsAjG4JQWqs46B1XfSqHC+nTScR+IGQ917fx+M8qQkzKVcdA==
X-Received: by 2002:a63:e70d:: with SMTP id b13mr9750512pgi.8.1585758030648;
 Wed, 01 Apr 2020 09:20:30 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:200f:7af7:4926:6e0b:60ca:635c])
 by smtp.gmail.com with ESMTPSA id e7sm1908849pfm.3.2020.04.01.09.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 09:20:29 -0700 (PDT)
Date: Wed, 1 Apr 2020 21:50:23 +0530
From: Simran Singhal <singhalsimran0@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] lockable: Replace locks with lock guard macros
Message-ID: <20200401162023.GA15912@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace manual lock()/unlock() calls with lock guard macros
(QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 hw/hyperv/hyperv.c     | 15 ++++++-------
 hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
 hw/rdma/rdma_rm.c      |  3 +--
 hw/rdma/rdma_utils.c   | 15 +++++--------
 4 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8ca3706f5b..4ddafe1de1 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -15,6 +15,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "qemu/queue.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
@@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
     int ret;
     MsgHandler *mh;
 
-    qemu_mutex_lock(&handlers_mutex);
+    QEMU_LOCK_GUARD(&handlers_mutex);
     QLIST_FOREACH(mh, &msg_handlers, link) {
         if (mh->conn_id == conn_id) {
             if (handler) {
@@ -501,7 +502,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
                 g_free_rcu(mh, rcu);
                 ret = 0;
             }
-            goto unlock;
+            return ret;
         }
     }
 
@@ -515,8 +516,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
     } else {
         ret = -ENOENT;
     }
-unlock:
-    qemu_mutex_unlock(&handlers_mutex);
+
     return ret;
 }
 
@@ -565,7 +565,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
     int ret;
     EventFlagHandler *handler;
 
-    qemu_mutex_lock(&handlers_mutex);
+    QEMU_LOCK_GUARD(&handlers_mutex);
     QLIST_FOREACH(handler, &event_flag_handlers, link) {
         if (handler->conn_id == conn_id) {
             if (notifier) {
@@ -575,7 +575,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
                 g_free_rcu(handler, rcu);
                 ret = 0;
             }
-            goto unlock;
+            return ret;
         }
     }
 
@@ -588,8 +588,7 @@ static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
     } else {
         ret = -ENOENT;
     }
-unlock:
-    qemu_mutex_unlock(&handlers_mutex);
+
     return ret;
 }
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 3dd39fe1a7..db7e5c8be5 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -95,36 +95,36 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
     struct ibv_wc wc[2];
     RdmaProtectedGSList *cqe_ctx_list;
 
-    qemu_mutex_lock(&rdma_dev_res->lock);
-    do {
-        ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
+    WITH_QEMU_LOCK_GUARD(&rdma_dev_res->lock) {
+        do {
+            ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
 
-        trace_rdma_poll_cq(ne, ibcq);
+            trace_rdma_poll_cq(ne, ibcq);
 
-        for (i = 0; i < ne; i++) {
-            bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
-            if (unlikely(!bctx)) {
-                rdma_error_report("No matching ctx for req %"PRId64,
-                                  wc[i].wr_id);
-                continue;
-            }
+            for (i = 0; i < ne; i++) {
+                bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
+                if (unlikely(!bctx)) {
+                    rdma_error_report("No matching ctx for req %"PRId64,
+                                      wc[i].wr_id);
+                    continue;
+                }
 
-            comp_handler(bctx->up_ctx, &wc[i]);
+                comp_handler(bctx->up_ctx, &wc[i]);
 
-            if (bctx->backend_qp) {
-                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
-            } else {
-                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
-            }
+                if (bctx->backend_qp) {
+                    cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
+                } else {
+                    cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
+                }
 
-            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
-            rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
-            g_free(bctx);
-        }
-        total_ne += ne;
-    } while (ne > 0);
-    atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
-    qemu_mutex_unlock(&rdma_dev_res->lock);
+                rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
+                rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
+                g_free(bctx);
+            }
+            total_ne += ne;
+        } while (ne > 0);
+        atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
+    }
 
     if (ne < 0) {
         rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 7e9ea283c9..60957f88db 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -147,14 +147,13 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
 {
     trace_rdma_res_tbl_dealloc(tbl->name, handle);
 
-    qemu_mutex_lock(&tbl->lock);
+    QEMU_LOCK_GUARD(&tbl->lock);
 
     if (handle < tbl->tbl_sz) {
         clear_bit(handle, tbl->bitmap);
         tbl->used--;
     }
 
-    qemu_mutex_unlock(&tbl->lock);
 }
 
 int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index 73f279104c..ef43606c84 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -71,18 +71,17 @@ void rdma_protected_qlist_destroy(RdmaProtectedQList *list)
 
 void rdma_protected_qlist_append_int64(RdmaProtectedQList *list, int64_t value)
 {
-    qemu_mutex_lock(&list->lock);
+    QEMU_LOCK_GUARD(&list->lock);
     qlist_append_int(list->list, value);
-    qemu_mutex_unlock(&list->lock);
 }
 
 int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
 {
     QObject *obj;
 
-    qemu_mutex_lock(&list->lock);
-    obj = qlist_pop(list->list);
-    qemu_mutex_unlock(&list->lock);
+    WITH_QEMU_LOCK_GUARD(&list->lock) {
+        obj = qlist_pop(list->list);
+    }
 
     if (!obj) {
         return -ENOENT;
@@ -107,15 +106,13 @@ void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
 void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,
                                         int32_t value)
 {
-    qemu_mutex_lock(&list->lock);
+    QEMU_LOCK_GUARD(&list->lock);
     list->list = g_slist_prepend(list->list, GINT_TO_POINTER(value));
-    qemu_mutex_unlock(&list->lock);
 }
 
 void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,
                                         int32_t value)
 {
-    qemu_mutex_lock(&list->lock);
+    QEMU_LOCK_GUARD(&list->lock);
     list->list = g_slist_remove(list->list, GINT_TO_POINTER(value));
-    qemu_mutex_unlock(&list->lock);
 }
-- 
2.17.1



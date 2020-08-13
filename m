Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A412078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="JTeWUZR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A412078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6DR9-0004TO-SQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1k6574-00034d-Cn
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 00:45:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1k6571-0000Z7-UV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 00:45:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id c6so2191688pje.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 21:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NTJ9ZgzPgFlnOoLLbMVDGOWHarYuAiQjzjWcdYsVGvI=;
 b=JTeWUZR/VSCvHFHQBFfhgKs1Qi0iseE8+VsoqlmK2+/r4Kns2Iu45KYwARGiuUIUuu
 b5cpCyd3S0MasO4dFvVGwbw0oat8TkIKrbewh+elUXZH8TIQHMGfV3wqRGIhnzmi/eiy
 /pnl32OiKq+njid3qXxUK2eN40PSjpBZhT2SRkreX0lZWg3NtNJ7FFsNYTWSo7uTYpos
 ylSNtrdyNBPs+hA9GtgIBfOd2tT7JEyLBP11BOQrrUgXSptbFOpj75HatHHR56Ltr/E+
 U/rDhJaZrH69NreSoz5GfM6bIVS2iibuTwUxYcQX+bS+5oOeVzIKGtIuYOgyFmKQeh15
 MENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NTJ9ZgzPgFlnOoLLbMVDGOWHarYuAiQjzjWcdYsVGvI=;
 b=rn1BPWL/eLTVZjbdSvcwmop3/do+Rg1KGEYs+LxdSe2jKL9zxcxj/NyxAvwWYgumOt
 jbshMaPHjU5459OGSwh9K9Uy6bMqQQBg3Woiajc/dUkqv08q5o3VUZuY4DBCArRh5kgY
 p8WWM7GRncwLPvMfCR1rZW6zIeNTNbpdkzj7UsjPqS8qNvlCXjvwalnwIlr9GF/9A+K9
 YcgqTCfzwYdXZKD2XuO+ZJWPl0vlTld9k8coywwk/6gYx6GHLqTZ1ZHdOqU64zC/OYdc
 cZGfAQ/c/z5EPSGTcvcJh30NezhZopSFA9csEAZNKWbxB9YSRFlYHGGyLRapunWvEHip
 tBQw==
X-Gm-Message-State: AOAM530zdrGGPshoo1HlPVP93SvQy1Hzwo1kAo/iVCPArcKlIuUTXxZk
 BDO4lMlaY/sbuQONmaJuW/SoKzvYVVpEWQ==
X-Google-Smtp-Source: ABdhPJw85lkYuQ97o6QZk0VQP4PAf55fSv0ayKXM0DUO06ISNuZqznrZCpku9/3B6NuyTrlwD+cDlQ==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr2357286plb.23.1597293910331; 
 Wed, 12 Aug 2020 21:45:10 -0700 (PDT)
Received: from MacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id z29sm4109746pfj.182.2020.08.12.21.45.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Aug 2020 21:45:09 -0700 (PDT)
From: wanghonghao <wanghonghao@bytedance.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] coroutine: take exactly one batch from global pool at a
 time
Date: Thu, 13 Aug 2020 12:44:45 +0800
Message-Id: <20200813044445.23233-2-wanghonghao@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200813044445.23233-1-wanghonghao@bytedance.com>
References: <20200813044445.23233-1-wanghonghao@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Aug 2020 09:37:10 -0400
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
Cc: kwolf@redhat.com, wanghonghao <wanghonghao@bytedance.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch replace the global coroutine queue with a lock-free stack of which
the elements are coroutine queues. Threads can put coroutine queues into the
stack or take queues from it and each coroutine queue has exactly
POOL_BATCH_SIZE coroutines. Note that the stack is not strictly LIFO, but it's
enough for buffer pool.

Coroutines will be put into thread-local pools first while release. Now the
fast pathes of both allocation and release are atomic-free, and there won't
be too many coroutines remain in a single thread since POOL_BATCH_SIZE has been
reduced to 16.

In practice, I've run a VM with two block devices binding to two different
iothreads, and run fio with iodepth 128 on each device. It maintains around
400 coroutines and has about 1% chance of calling to `qemu_coroutine_new`
without this patch. And with this patch, it maintains no more than 273
coroutines and doesn't call `qemu_coroutine_new` after initial allocations.

Signed-off-by: wanghonghao <wanghonghao@bytedance.com>
---
 util/qemu-coroutine.c | 63 ++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index c3caa6c770..02cd68bc4a 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -21,13 +21,14 @@
 #include "block/aio.h"
 
 enum {
-    POOL_BATCH_SIZE = 64,
+    POOL_BATCH_SIZE = 16,
+    POOL_MAX_BATCHES = 32,
 };
 
-/** Free list to speed up creation */
-static QSLIST_HEAD(, Coroutine) release_pool = QSLIST_HEAD_INITIALIZER(pool);
-static unsigned int release_pool_size;
-static __thread QSLIST_HEAD(, Coroutine) alloc_pool = QSLIST_HEAD_INITIALIZER(pool);
+/** Free stack to speed up creation */
+static QSLIST_HEAD(, Coroutine) pool[POOL_MAX_BATCHES];
+static int pool_top;
+static __thread QSLIST_HEAD(, Coroutine) alloc_pool;
 static __thread unsigned int alloc_pool_size;
 static __thread Notifier coroutine_pool_cleanup_notifier;
 
@@ -49,20 +50,26 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
     if (CONFIG_COROUTINE_POOL) {
         co = QSLIST_FIRST(&alloc_pool);
         if (!co) {
-            if (release_pool_size > POOL_BATCH_SIZE) {
-                /* Slow path; a good place to register the destructor, too.  */
-                if (!coroutine_pool_cleanup_notifier.notify) {
-                    coroutine_pool_cleanup_notifier.notify = coroutine_pool_cleanup;
-                    qemu_thread_atexit_add(&coroutine_pool_cleanup_notifier);
+            int top;
+
+            /* Slow path; a good place to register the destructor, too.  */
+            if (!coroutine_pool_cleanup_notifier.notify) {
+                 coroutine_pool_cleanup_notifier.notify = coroutine_pool_cleanup;
+                 qemu_thread_atexit_add(&coroutine_pool_cleanup_notifier);
+            }
+
+            while ((top = atomic_read(&pool_top)) > 0) {
+                if (atomic_cmpxchg(&pool_top, top, top - 1) != top) {
+                    continue;
                 }
 
-                /* This is not exact; there could be a little skew between
-                 * release_pool_size and the actual size of release_pool.  But
-                 * it is just a heuristic, it does not need to be perfect.
-                 */
-                alloc_pool_size = atomic_xchg(&release_pool_size, 0);
-                QSLIST_MOVE_ATOMIC(&alloc_pool, &release_pool);
+                QSLIST_MOVE_ATOMIC(&alloc_pool, &pool[top - 1]);
                 co = QSLIST_FIRST(&alloc_pool);
+
+                if (co) {
+                    alloc_pool_size = POOL_BATCH_SIZE;
+                    break;
+                }
             }
         }
         if (co) {
@@ -86,16 +93,30 @@ static void coroutine_delete(Coroutine *co)
     co->caller = NULL;
 
     if (CONFIG_COROUTINE_POOL) {
-        if (release_pool_size < POOL_BATCH_SIZE * 2) {
-            QSLIST_INSERT_HEAD_ATOMIC(&release_pool, co, pool_next);
-            atomic_inc(&release_pool_size);
-            return;
-        }
+        int top, value, old;
+
         if (alloc_pool_size < POOL_BATCH_SIZE) {
             QSLIST_INSERT_HEAD(&alloc_pool, co, pool_next);
             alloc_pool_size++;
             return;
         }
+
+        for (top = atomic_read(&pool_top); top < POOL_MAX_BATCHES; top++) {
+            QSLIST_REPLACE_ATOMIC(&pool[top], &alloc_pool);
+            if (!QSLIST_EMPTY(&alloc_pool)) {
+                continue;
+            }
+
+            value = top + 1;
+
+            do {
+                old = atomic_cmpxchg(&pool_top, top, value);
+            } while (old != top && (top = old) < value);
+
+            QSLIST_INSERT_HEAD(&alloc_pool, co, pool_next);
+            alloc_pool_size = 1;
+            return;
+        }
     }
 
     qemu_coroutine_delete(co);
-- 
2.24.3 (Apple Git-128)



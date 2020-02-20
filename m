Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D0C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B51D24654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU/877VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B51D24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jEq-0002Do-0j
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j4jE2-0001ox-Ka
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j4jE1-0002Yn-7H
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:38:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j4jE0-0002Yh-VA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:38:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so3986852wrx.11
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5YCilSFFWtLWlcpaHNeLRMfIZWehJ5IyMtE4Hluj81g=;
 b=OU/877VSgwEeGjWP7BDtoI8LN/TIfZw1RcYInIwGT7qg8keC/9V+Gtk1IYCQBb3aTG
 Q+4rr847WIUd8k+jMfgil7vUESJXbk2C47f+nCmgm2WhKcRydzqQnrL1stCmQG6ZDt33
 5j3JTmFMy0i+ItPGSi6dCV2PTW5cNvTJ0zmNYqZXcd8p/QkPw5HI2gPv38MME2pueAsn
 xCSsc2zSJliymvHOZlHrGl7WCAN5AUQTgPzIm3Vxx67MqH+cvFsbcNscmRSVMZLiv775
 yoVx+2fvYYL6sVidMhI5QP8qq/CZnio2yFg3V2264naUHtLfmBc5D3V2oK4Ceb3a/di1
 JRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5YCilSFFWtLWlcpaHNeLRMfIZWehJ5IyMtE4Hluj81g=;
 b=p+GRZrPxlJd964kzrhtCXeeqGePTEg9bJLb/TU+YrXa8XC0vK+BSpk0WxOThqttkKs
 M/mv/xkWbYDnhxye4x6flCpueTa454PqKKUWCPR1K8zFao9xEfsiqEGLY13yBViBrcsk
 Sz2aqZrGU7v9rGAezejhTGk4ZWjCB/UGBnocJxXbsGUH+sbRvz0mNr/agF2uu4Jw9TWa
 i6RSMXzPad/0Rc77Sxq/aUXpqSw/HXGQugzuoPB39xpaiJRRaTUWTZ+bwtDSdOGX9cG4
 B8Iy1VevlH4EV5ItJA9D4LC5rsqJe8t3OGVq5KOvZWpK1hePVTub7VESGth6w4d8v5cW
 2+Zg==
X-Gm-Message-State: APjAAAXFOJ9QCRbFrEyTlJC4WmoY1A17xZCIiqcSKs3DPf4I8AJdDWpX
 HMS73/nh0dx1n203L1+PZRGp0yi0
X-Google-Smtp-Source: APXvYqy1pnWis1XcTk6gWXts3+Ejs3Y53Cc0+e37OgMZlhzt4msZQdf6m+ivqGx9h2k76cFzOzhrvg==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr8721743wrn.8.1582195110661;
 Thu, 20 Feb 2020 02:38:30 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com.
 [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id s23sm4058602wra.15.2020.02.20.02.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 02:38:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rcu_queue: add QSLIST functions
Date: Thu, 20 Feb 2020 11:38:28 +0100
Message-Id: <20200220103828.24525-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QSLIST is the only family of lists for which we do not have RCU-friendly accessors,
add them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/queue.h     | 15 +++++++++++--
 include/qemu/rcu_queue.h | 47 ++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include   |  2 ++
 tests/test-rcu-list.c    | 16 ++++++++++++++
 tests/test-rcu-slist.c   |  2 ++
 5 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 tests/test-rcu-slist.c

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 19425f973f..fcecb70228 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -211,9 +211,20 @@ struct {                                                                \
         (head)->slh_first = (head)->slh_first->field.sle_next;          \
 } while (/*CONSTCOND*/0)
 
-#define QSLIST_REMOVE_AFTER(slistelm, field) do {                        \
+#define QSLIST_REMOVE_AFTER(slistelm, field) do {                       \
         (slistelm)->field.sle_next =                                    \
-            QSLIST_NEXT(QSLIST_NEXT((slistelm), field), field);           \
+            QSLIST_NEXT(QSLIST_NEXT((slistelm), field), field);         \
+} while (/*CONSTCOND*/0)
+
+#define QSLIST_REMOVE(head, elm, type, field) do {                      \
+    if ((head)->slh_first == (elm)) {                                   \
+        QSLIST_REMOVE_HEAD((head), field);                              \
+    } else {                                                            \
+        struct type *curelm = (head)->slh_first;                        \
+        while (curelm->field.sle_next != (elm))                         \
+            curelm = curelm->field.sle_next;                            \
+        curelm->field.sle_next = curelm->field.sle_next->field.sle_next; \
+    }                                                                   \
 } while (/*CONSTCOND*/0)
 
 #define QSLIST_FOREACH(var, head, field)                                 \
diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index 2d386f303e..558961cc27 100644
--- a/include/qemu/rcu_queue.h
+++ b/include/qemu/rcu_queue.h
@@ -262,6 +262,53 @@ extern "C" {
          (var) && ((next) = atomic_rcu_read(&(var)->field.tqe_next), 1); \
          (var) = (next))
 
+/*
+ * RCU singly-linked list
+ */
+
+/* Singly-linked list access methods */
+#define QSLIST_EMPTY_RCU(head)      (atomic_read(&(head)->slh_first) == NULL)
+#define QSLIST_FIRST_RCU(head)       atomic_rcu_read(&(head)->slh_first)
+#define QSLIST_NEXT_RCU(elm, field)  atomic_rcu_read(&(elm)->field.sle_next)
+
+/* Singly-linked list functions */
+#define QSLIST_INSERT_HEAD_RCU(head, elm, field) do {           \
+    (elm)->field.sle_next = (head)->slh_first;                  \
+    atomic_rcu_set(&(head)->slh_first, (elm));                  \
+} while (/*CONSTCOND*/0)
+
+#define QSLIST_INSERT_AFTER_RCU(head, listelm, elm, field) do {         \
+    (elm)->field.sle_next = (listelm)->field.sle_next;                  \
+    atomic_rcu_set(&(listelm)->field.sle_next, (elm));                  \
+} while (/*CONSTCOND*/0)
+
+#define QSLIST_REMOVE_HEAD_RCU(head, field) do {                       \
+    atomic_set(&(head)->slh_first, (head)->slh_first->field.sle_next); \
+} while (/*CONSTCOND*/0)
+
+#define QSLIST_REMOVE_RCU(head, elm, type, field) do {              \
+    if ((head)->slh_first == (elm)) {                               \
+        QSLIST_REMOVE_HEAD_RCU((head), field);                      \
+    } else {                                                        \
+        struct type *curr = (head)->slh_first;                      \
+        while (curr->field.sle_next != (elm)) {                     \
+            curr = curr->field.sle_next;                            \
+        }                                                           \
+        atomic_set(&curr->field.sle_next,                           \
+                   curr->field.sle_next->field.sle_next);           \
+    }                                                               \
+} while (/*CONSTCOND*/0)
+
+#define QSLIST_FOREACH_RCU(var, head, field)                          \
+    for ((var) = atomic_rcu_read(&(head)->slh_first);                   \
+         (var);                                                         \
+         (var) = atomic_rcu_read(&(var)->field.sle_next))
+
+#define QSLIST_FOREACH_SAFE_RCU(var, head, field, next)                \
+    for ((var) = atomic_rcu_read(&(head)->slh_first);                    \
+         (var) && ((next) = atomic_rcu_read(&(var)->field.sle_next), 1); \
+         (var) = (next))
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2f1cafed72..edcbd475aa 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -98,6 +98,7 @@ check-unit-y += tests/rcutorture$(EXESUF)
 check-unit-y += tests/test-rcu-list$(EXESUF)
 check-unit-y += tests/test-rcu-simpleq$(EXESUF)
 check-unit-y += tests/test-rcu-tailq$(EXESUF)
+check-unit-y += tests/test-rcu-slist$(EXESUF)
 check-unit-y += tests/test-qdist$(EXESUF)
 check-unit-y += tests/test-qht$(EXESUF)
 check-unit-y += tests/test-qht-par$(EXESUF)
@@ -415,6 +416,7 @@ tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
 tests/test-rcu-list$(EXESUF): tests/test-rcu-list.o $(test-util-obj-y)
 tests/test-rcu-simpleq$(EXESUF): tests/test-rcu-simpleq.o $(test-util-obj-y)
 tests/test-rcu-tailq$(EXESUF): tests/test-rcu-tailq.o $(test-util-obj-y)
+tests/test-rcu-slist$(EXESUF): tests/test-rcu-slist.o $(test-util-obj-y)
 tests/test-qdist$(EXESUF): tests/test-qdist.o $(test-util-obj-y)
 tests/test-qht$(EXESUF): tests/test-qht.o $(test-util-obj-y)
 tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(test-util-obj-y)
diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 6f076473e0..1442c0c982 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -93,6 +93,8 @@ struct list_element {
     QSIMPLEQ_ENTRY(list_element) entry;
 #elif TEST_LIST_TYPE == 3
     QTAILQ_ENTRY(list_element) entry;
+#elif TEST_LIST_TYPE == 4
+    QSLIST_ENTRY(list_element) entry;
 #else
 #error Invalid TEST_LIST_TYPE
 #endif
@@ -144,6 +146,20 @@ static QTAILQ_HEAD(, list_element) Q_list_head;
 #define TEST_LIST_INSERT_HEAD_RCU   QTAILQ_INSERT_HEAD_RCU
 #define TEST_LIST_FOREACH_RCU       QTAILQ_FOREACH_RCU
 #define TEST_LIST_FOREACH_SAFE_RCU  QTAILQ_FOREACH_SAFE_RCU
+
+#elif TEST_LIST_TYPE == 4
+static QSLIST_HEAD(, list_element) Q_list_head;
+
+#define TEST_NAME "qslist"
+#define TEST_LIST_REMOVE_RCU(el, f)                              \
+	 QSLIST_REMOVE_RCU(&Q_list_head, el, list_element, f)
+
+#define TEST_LIST_INSERT_AFTER_RCU(list_el, el, f)               \
+         QSLIST_INSERT_AFTER_RCU(&Q_list_head, list_el, el, f)
+
+#define TEST_LIST_INSERT_HEAD_RCU   QSLIST_INSERT_HEAD_RCU
+#define TEST_LIST_FOREACH_RCU       QSLIST_FOREACH_RCU
+#define TEST_LIST_FOREACH_SAFE_RCU  QSLIST_FOREACH_SAFE_RCU
 #else
 #error Invalid TEST_LIST_TYPE
 #endif
diff --git a/tests/test-rcu-slist.c b/tests/test-rcu-slist.c
new file mode 100644
index 0000000000..868e1e472e
--- /dev/null
+++ b/tests/test-rcu-slist.c
@@ -0,0 +1,2 @@
+#define TEST_LIST_TYPE 4
+#include "test-rcu-list.c"
-- 
2.21.1



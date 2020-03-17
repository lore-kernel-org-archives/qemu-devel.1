Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC24C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA22720735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBDhMn/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA22720735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEDs-0001Px-PR
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEE0k-0007Jy-J6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEE0j-0007Iv-4O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:20:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEE0i-0007GG-VO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4o/fpZ4J5wSkdfSTMpqDbpT5ksU9yz5Rq7/IoE01nw=;
 b=WBDhMn/FxIsVLVPKxB9GoTS3sRWN6zNIiEj+oDoY4/rWC1ZkA8SLAgh4hRi92sfkB0zYaJ
 8fDMOMb9ELQA83/XTO0xJpvbj3TdYEOe8bfWuiQOrgA655k8EawGIKMdIQkgKikOGo0J09
 M2bi6AwvRf6ymHU3LgXM6FO2JfSRVmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-U6WUTdWYN76zdQM-3RFm-w-1; Tue, 17 Mar 2020 11:20:02 -0400
X-MC-Unique: U6WUTdWYN76zdQM-3RFm-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9773FA1363
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:20:01 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE266E3EE;
 Tue, 17 Mar 2020 15:19:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 36/62] lockable: add lock guards
Date: Tue, 17 Mar 2020 16:19:33 +0100
Message-Id: <1584458374-29068-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584458374-29068-1-git-send-email-pbonzini@redhat.com>
References: <1584458374-29068-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

This patch introduces two lock guard macros that automatically unlock a
lock object (QemuMutex and others):

  void f(void) {
      QEMU_LOCK_GUARD(&mutex);
      if (!may_fail()) {
          return; /* automatically unlocks mutex */
      }
      ...
  }

and:

  WITH_QEMU_LOCK_GUARD(&mutex) {
      if (!may_fail()) {
          return; /* automatically unlocks mutex */
      }
  }
  /* automatically unlocks mutex here */
  ...

Convert qemu-timer.c functions that benefit from these macros as an
example.  Manual qemu_mutex_lock/unlock() callers are left unmodified in
cases where clarity would not improve by switching to the macros.

Many other QemuMutex users remain in the codebase that might benefit
from lock guards.  Over time they can be converted, if that is
desirable.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
[Use QEMU_MAKE_LOCKABLE_NONNULL. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/lockable.h | 65 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 util/qemu-timer.c       | 23 +++++++++--------
 2 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 313d4d9..90342ba 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -106,4 +106,69 @@ static inline void qemu_lockable_unlock(QemuLockable *=
x)
     x->unlock(x->object);
 }
=20
+static inline QemuLockable *qemu_lockable_auto_lock(QemuLockable *x)
+{
+    qemu_lockable_lock(x);
+    return x;
+}
+
+static inline void qemu_lockable_auto_unlock(QemuLockable *x)
+{
+    if (x) {
+        qemu_lockable_unlock(x);
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
+
+#define WITH_QEMU_LOCK_GUARD_(x, var) \
+    for (g_autoptr(QemuLockable) var =3D \
+                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); =
\
+         var; \
+         qemu_lockable_auto_unlock(var), var =3D NULL)
+
+/**
+ * WITH_QEMU_LOCK_GUARD - Lock a lock object for scope
+ *
+ * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
+ *
+ * This macro defines a lock scope such that entering the scope takes the =
lock
+ * and leaving the scope releases the lock.  Return statements are allowed
+ * within the scope and release the lock.  Break and continue statements l=
eave
+ * the scope early and release the lock.
+ *
+ *   WITH_QEMU_LOCK_GUARD(&mutex) {
+ *       ...
+ *       if (error) {
+ *           return; <-- mutex is automatically unlocked
+ *       }
+ *
+ *       if (early_exit) {
+ *           break;  <-- leave this scope early
+ *       }
+ *       ...
+ *   }
+ */
+#define WITH_QEMU_LOCK_GUARD(x) \
+    WITH_QEMU_LOCK_GUARD_((x), qemu_lockable_auto##__COUNTER__)
+
+/**
+ * QEMU_LOCK_GUARD - Lock an object until the end of the scope
+ *
+ * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
+ *
+ * This macro takes a lock until the end of the scope.  Return statements
+ * release the lock.
+ *
+ *   ... <-- mutex not locked
+ *   QEMU_LOCK_GUARD(&mutex); <-- mutex locked from here onwards
+ *   ...
+ *   if (error) {
+ *       return; <-- mutex is automatically unlocked
+ *   }
+ */
+#define QEMU_LOCK_GUARD(x) \
+    g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ =3D \
+            qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x)))
+
 #endif
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index ef52d28..d548d3c 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
+#include "qemu/lockable.h"
 #include "sysemu/replay.h"
 #include "sysemu/cpus.h"
=20
@@ -186,13 +187,12 @@ bool timerlist_expired(QEMUTimerList *timer_list)
         return false;
     }
=20
-    qemu_mutex_lock(&timer_list->active_timers_lock);
-    if (!timer_list->active_timers) {
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
-        return false;
+    WITH_QEMU_LOCK_GUARD(&timer_list->active_timers_lock) {
+        if (!timer_list->active_timers) {
+            return false;
+        }
+        expire_time =3D timer_list->active_timers->expire_time;
     }
-    expire_time =3D timer_list->active_timers->expire_time;
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
=20
     return expire_time <=3D qemu_clock_get_ns(timer_list->clock->type);
 }
@@ -225,13 +225,12 @@ int64_t timerlist_deadline_ns(QEMUTimerList *timer_li=
st)
      * value but ->notify_cb() is called when the deadline changes.  There=
fore
      * the caller should notice the change and there is no race condition.
      */
-    qemu_mutex_lock(&timer_list->active_timers_lock);
-    if (!timer_list->active_timers) {
-        qemu_mutex_unlock(&timer_list->active_timers_lock);
-        return -1;
+    WITH_QEMU_LOCK_GUARD(&timer_list->active_timers_lock) {
+        if (!timer_list->active_timers) {
+            return -1;
+        }
+        expire_time =3D timer_list->active_timers->expire_time;
     }
-    expire_time =3D timer_list->active_timers->expire_time;
-    qemu_mutex_unlock(&timer_list->active_timers_lock);
=20
     delta =3D expire_time - qemu_clock_get_ns(timer_list->clock->type);
=20
--=20
1.8.3.1




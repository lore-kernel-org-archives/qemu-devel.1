Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B42206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGV8WTin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B42206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxYK-0002uc-6x
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHz-00048l-PV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHx-0006Wx-Va
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHx-0006VJ-Py
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEPVzIMyMWMKB/q/1uEhyznN7dRLW8w5wO1zuVp/Uhk=;
 b=KGV8WTinssBFmn7NAsVTRe7Db/zliQqjElw8JupbWIlCD6s4Vjcl+NyFv5BwO+XEGz1DfJ
 OEZjQL86uNEnhQge3L34vQinTLRv4qpCbj1O2KQUuSagCv3iLCJ8LH31jzvfXy6o/vbwj2
 2BWrvhG13VWrsT0w5PRyD/H2ZH3RYK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zfjTpfouNUeThZK4NlgKWA-1; Mon, 16 Mar 2020 17:28:42 -0400
X-MC-Unique: zfjTpfouNUeThZK4NlgKWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CFF3800D53
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:42 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15FCB19C4F;
 Mon, 16 Mar 2020 21:28:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/61] lockable: add QemuRecMutex support
Date: Mon, 16 Mar 2020 22:27:03 +0100
Message-Id: <1584394048-44994-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

The polymorphic locking macros don't support QemuRecMutex yet.  Add it
so that lock guards can be used with QemuRecMutex.

Convert TCG plugins functions that benefit from these macros.  Manual
qemu_rec_mutex_lock/unlock() callers are left unmodified in cases where
clarity would not improve by switching to the macros.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/lockable.h |  2 ++
 plugins/core.c          |  7 +++----
 plugins/loader.c        | 16 ++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 2b52c7c..44b3f4b 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -50,6 +50,7 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
 #define QEMU_LOCK_FUNC(x) ((QemuLockUnlockFunc *)    \
     QEMU_GENERIC(x,                                  \
                  (QemuMutex *, qemu_mutex_lock),     \
+                 (QemuRecMutex *, qemu_rec_mutex_lock), \
                  (CoMutex *, qemu_co_mutex_lock),    \
                  (QemuSpin *, qemu_spin_lock),       \
                  unknown_lock_type))
@@ -57,6 +58,7 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
 #define QEMU_UNLOCK_FUNC(x) ((QemuLockUnlockFunc *)  \
     QEMU_GENERIC(x,                                  \
                  (QemuMutex *, qemu_mutex_unlock),   \
+                 (QemuRecMutex *, qemu_rec_mutex_unlock), \
                  (CoMutex *, qemu_co_mutex_unlock),  \
                  (QemuSpin *, qemu_spin_unlock),     \
                  unknown_lock_type))
diff --git a/plugins/core.c b/plugins/core.c
index ed86301..51bfc94 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -15,6 +15,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
+#include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/xxhash.h"
@@ -150,11 +151,11 @@ do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_=
plugin_event ev,
 {
     struct qemu_plugin_ctx *ctx;
=20
-    qemu_rec_mutex_lock(&plugin.lock);
+    QEMU_LOCK_GUARD(&plugin.lock);
     ctx =3D plugin_id_to_ctx_locked(id);
     /* if the plugin is on its way out, ignore this request */
     if (unlikely(ctx->uninstalling)) {
-        goto out_unlock;
+        return;
     }
     if (func) {
         struct qemu_plugin_cb *cb =3D ctx->callbacks[ev];
@@ -178,8 +179,6 @@ do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_pl=
ugin_event ev,
     } else {
         plugin_unregister_cb__locked(ctx, ev);
     }
- out_unlock:
-    qemu_rec_mutex_unlock(&plugin.lock);
 }
=20
 void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
diff --git a/plugins/loader.c b/plugins/loader.c
index 15fc7e5..685d334 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
+#include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/qht.h"
@@ -367,15 +368,14 @@ void plugin_reset_uninstall(qemu_plugin_id_t id,
     struct qemu_plugin_reset_data *data;
     struct qemu_plugin_ctx *ctx;
=20
-    qemu_rec_mutex_lock(&plugin.lock);
-    ctx =3D plugin_id_to_ctx_locked(id);
-    if (ctx->uninstalling || (reset && ctx->resetting)) {
-        qemu_rec_mutex_unlock(&plugin.lock);
-        return;
+    WITH_QEMU_LOCK_GUARD(&plugin.lock) {
+        ctx =3D plugin_id_to_ctx_locked(id);
+        if (ctx->uninstalling || (reset && ctx->resetting)) {
+            return;
+        }
+        ctx->resetting =3D reset;
+        ctx->uninstalling =3D !reset;
     }
-    ctx->resetting =3D reset;
-    ctx->uninstalling =3D !reset;
-    qemu_rec_mutex_unlock(&plugin.lock);
=20
     data =3D g_new(struct qemu_plugin_reset_data, 1);
     data->ctx =3D ctx;
--=20
1.8.3.1




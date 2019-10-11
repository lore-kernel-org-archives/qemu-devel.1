Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC8C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD36206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD36206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0To-0005ZH-5e
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PP-0000Aw-5o
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PL-0003ij-IM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0PL-0003iA-AK
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:16:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C5D110CC205;
 Fri, 11 Oct 2019 19:16:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D6D85D6C8;
 Fri, 11 Oct 2019 19:16:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 02/21] rcu: Add automatically released rcu_read_lock variants
Date: Fri, 11 Oct 2019 20:16:27 +0100
Message-Id: <20191011191646.226814-3-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 11 Oct 2019 19:16:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

RCU_READ_LOCK_GUARD() takes the rcu_read_lock and then uses glib's
g_auto infrastructure (and thus whatever the compiler's hooks are) to
release it on all exits of the block.

WITH_RCU_READ_LOCK_GUARD() is similar but is used as a wrapper for the
lock, i.e.:

   WITH_RCU_READ_LOCK_GUARD() {
       stuff under lock
   }

Note the 'unused' attribute is needed to work around clang bug:
  https://bugs.llvm.org/show_bug.cgi?id=3D43482

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20191007143642.301445-2-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/rcu.txt | 16 ++++++++++++++++
 include/qemu/rcu.h | 25 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/docs/devel/rcu.txt b/docs/devel/rcu.txt
index c84e7f42b2..d83fed2f79 100644
--- a/docs/devel/rcu.txt
+++ b/docs/devel/rcu.txt
@@ -187,6 +187,22 @@ The following APIs must be used before RCU is used i=
n a thread:
 Note that these APIs are relatively heavyweight, and should _not_ be
 nested.
=20
+Convenience macros
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Two macros are provided that automatically release the read lock at the
+end of the scope.
+
+      RCU_READ_LOCK_GUARD()
+
+         Takes the lock and will release it at the end of the block it's
+         used in.
+
+      WITH_RCU_READ_LOCK_GUARD()  { code }
+
+         Is used at the head of a block to protect the code within the b=
lock.
+
+Note that 'goto'ing out of the guarded block will also drop the lock.
=20
 DIFFERENCES WITH LINUX
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 22876d1428..9c82683e37 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -154,6 +154,31 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFu=
nc *func);
       }),                                                               =
 \
       (RCUCBFunc *)g_free);
=20
+typedef void RCUReadAuto;
+static inline RCUReadAuto *rcu_read_auto_lock(void)
+{
+    rcu_read_lock();
+    /* Anything non-NULL causes the cleanup function to be called */
+    return (void *)(uintptr_t)0x1;
+}
+
+static inline void rcu_read_auto_unlock(RCUReadAuto *r)
+{
+    rcu_read_unlock();
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
+
+#define WITH_RCU_READ_LOCK_GUARD() \
+    WITH_RCU_READ_LOCK_GUARD_(_rcu_read_auto##__COUNTER__)
+
+#define WITH_RCU_READ_LOCK_GUARD_(var) \
+    for (g_autoptr(RCUReadAuto) var =3D rcu_read_auto_lock(); \
+        (var); rcu_read_auto_unlock(var), (var) =3D NULL)
+
+#define RCU_READ_LOCK_GUARD() \
+    g_autoptr(RCUReadAuto) _rcu_read_auto __attribute__((unused)) =3D rc=
u_read_auto_lock()
+
 #ifdef __cplusplus
 }
 #endif
--=20
2.23.0



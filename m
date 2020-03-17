Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8BDC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7581920663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUZcyctu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7581920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEKs-0003bU-IE
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEE0c-0006xk-A9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEE0b-0006Og-0B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:19:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58685)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEE0a-0006Lf-Qd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/QNWqtHLHlLJabEV0juycrJrvzhVqK6OOT+GGxhCZY=;
 b=HUZcyctuGBKXZXOTX/kYAtdHgGnTdFIUic+oXjArX1YkQX80AntEDc0TPy2intbfD0S+VK
 G789DNm/BMHsH2I4N/mgYrH/+hlILS26nQcBGpMfvQxEqJKcMixBqTc84MGOouMBCBA8MR
 MPm/GaSipNZ9EYrXVIYjr2OciNA9kzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-xm2vl7bkMyi3MW-H7iodSw-1; Tue, 17 Mar 2020 11:19:54 -0400
X-MC-Unique: xm2vl7bkMyi3MW-H7iodSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E44128017CC
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:19:53 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D44C7E312
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:19:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 35/62] lockable: add QEMU_MAKE_LOCKABLE_NONNULL
Date: Tue, 17 Mar 2020 16:19:32 +0100
Message-Id: <1584458374-29068-2-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be needed for lock guards, because if the lock is NULL the
dummy for loop of the lock guard never runs.  This can cause confusion
and dummy warnings in the compiler, but even if it did not, aborting
with a NULL pointer dereference is a less surprising behavior.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/lockable.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 84ea794..313d4d9 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -65,7 +65,7 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
  * In C++ it would be different, but then C++ wouldn't need QemuLockable
  * either...
  */
-#define QEMU_MAKE_LOCKABLE_(x) qemu_make_lockable((x), &(QemuLockable) {  =
  \
+#define QEMU_MAKE_LOCKABLE_(x) (&(QemuLockable) {     \
         .object =3D (x),                               \
         .lock =3D QEMU_LOCK_FUNC(x),                   \
         .unlock =3D QEMU_UNLOCK_FUNC(x),               \
@@ -76,11 +76,24 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
  * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
  *
  * Returns a QemuLockable object that can be passed around
- * to a function that can operate with locks of any kind.
+ * to a function that can operate with locks of any kind, or
+ * NULL if @x is %NULL.
  */
 #define QEMU_MAKE_LOCKABLE(x)                        \
     QEMU_GENERIC(x,                                  \
                  (QemuLockable *, (x)),              \
+                 qemu_make_lockable((x), QEMU_MAKE_LOCKABLE_(x)))
+
+/* QEMU_MAKE_LOCKABLE_NONNULL - Make a polymorphic QemuLockable
+ *
+ * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
+ *
+ * Returns a QemuLockable object that can be passed around
+ * to a function that can operate with locks of any kind.
+ */
+#define QEMU_MAKE_LOCKABLE_NONNULL(x)                \
+    QEMU_GENERIC(x,                                  \
+                 (QemuLockable *, (x)),              \
                  QEMU_MAKE_LOCKABLE_(x))
=20
 static inline void qemu_lockable_lock(QemuLockable *x)
--=20
1.8.3.1




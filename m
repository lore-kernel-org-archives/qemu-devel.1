Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC838C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8837920896
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 21:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8837920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44305 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIgFT-0003Lz-PL
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 17:13:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgEC-0002UV-Ts
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIg7T-0000HY-Ax
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIg7T-0000H8-5K
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 752D83082A27
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 21:04:54 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3EA60C64;
	Mon, 22 Apr 2019 21:04:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 18:04:47 -0300
Message-Id: <20190422210448.2488-3-ehabkost@redhat.com>
In-Reply-To: <20190422210448.2488-1-ehabkost@redhat.com>
References: <20190422210448.2488-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 22 Apr 2019 21:04:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] qtest: Don't compile qtest accel on
 non-POSIX systems
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422210447.Xou9ly3VJ9dxgACOdARJmhOTIM7zCW8qflVjnK69W8U@z>

qtest_available() will always return 0 on non-POSIX systems.
It's simpler to just not compile the accelerator code on those
systems instead of relying on the AccelClass::available function.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/qtest.h | 9 ---------
 accel/qtest.c          | 1 -
 accel/Makefile.objs    | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 70aa40aa72..096ddfc20c 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -27,13 +27,4 @@ bool qtest_driver(void);
 
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
 
-static inline int qtest_available(void)
-{
-#ifdef CONFIG_POSIX
-    return 1;
-#else
-    return 0;
-#endif
-}
-
 #endif
diff --git a/accel/qtest.c b/accel/qtest.c
index a02b3c26c7..5b88f55921 100644
--- a/accel/qtest.c
+++ b/accel/qtest.c
@@ -34,7 +34,6 @@ static void qtest_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "QTest";
-    ac->available = qtest_available;
     ac->init_machine = qtest_init_accel;
     ac->allowed = &qtest_allowed;
 }
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 2a5ed46940..8b498d39d8 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SOFTMMU) += accel.o
-obj-$(CONFIG_SOFTMMU) += qtest.o
+obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
-- 
2.18.0.rc1.1.g3f1ff2140



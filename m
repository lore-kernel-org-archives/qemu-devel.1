Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E67C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49862072D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49862072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWXr-0002DR-Rs
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPA-0001Kf-6f
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP8-0005Bu-QT
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:52 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052I-Hl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 7E08530747CE; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 6A050305B7A5;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 15/26] kvm: vmi: reconnect the socket on reset
Date: Wed, 15 Apr 2020 03:59:27 +0300
Message-Id: <20200415005938.23895-16-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
References: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marian Rotariu <marian.c.rotariu@gmail.com>

The guest could be reset from various reasons and by disconnecting the
socket (which would reconnect), KVM and the introspection tool will be
notified and can clean up the introspection structures.

Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 54c56c6e13..5beec2b091 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
 #include "sysemu/kvm.h"
 #include "crypto/secret.h"
 #include "crypto/hash.h"
@@ -66,6 +67,7 @@ typedef struct VMIntrospectionClass {
     OBJECT_CLASS_CHECK(VMIntrospectionClass, (class), TYPE_VM_INTROSPECT=
ION)
=20
 static Error *vm_introspection_init(VMIntrospection *i);
+static void vm_introspection_reset(void *opaque);
=20
 static void machine_ready(Notifier *notifier, void *data)
 {
@@ -122,6 +124,8 @@ static void complete(UserCreatable *uc, Error **errp)
     }
=20
     ic->uniq =3D i;
+
+    qemu_register_reset(vm_introspection_reset, i);
 }
=20
 static void prop_set_chardev(Object *obj, const char *value, Error **err=
p)
@@ -273,6 +277,8 @@ static void instance_finalize(Object *obj)
     if (!ic->instance_counter) {
         ic->uniq =3D NULL;
     }
+
+    qemu_unregister_reset(vm_introspection_reset, i);
 }
=20
 static const TypeInfo info =3D {
@@ -534,6 +540,18 @@ static void chr_event(void *opaque, QEMUChrEvent eve=
nt)
     }
 }
=20
+static void vm_introspection_reset(void *opaque)
+{
+    VMIntrospection *i =3D opaque;
+
+    if (i->sock_fd !=3D -1) {
+        info_report("VMI: Reset detected. Closing the socket...");
+        disconnect_and_unhook_kvmi(i);
+    }
+
+    update_vm_start_time(i);
+}
+
 static bool make_cookie_hash(const char *key_id, uint8_t *cookie_hash,
                              Error **errp)
 {


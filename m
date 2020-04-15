Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818EBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8E920732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8E920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWZ5-0003Ll-Eb
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPB-0001NQ-9B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP8-0005C0-RU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:53 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052O-Jd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 D363230747D4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id BF5E1305B7A2;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 18/26] kvm: vmi: store/restore 'vm_start_time' on
 migrate/snapshot
Date: Wed, 15 Apr 2020 03:59:30 +0300
Message-Id: <20200415005938.23895-19-alazar@bitdefender.com>
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VM start time sent during handshake can be used by the introspection
tool as a session id.

We save this 'VM start time' with the snapshot in order to be sent again
to the introspection tool when the VM is restored from snapshot and the
introspection connection is reestablished.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 1f3aff3bfe..e511558f3d 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -20,6 +20,7 @@
 #include "crypto/hash.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
+#include "migration/vmstate.h"
=20
 #include "sysemu/vmi-intercept.h"
 #include "sysemu/vmi-handshake.h"
@@ -203,6 +204,16 @@ static void class_init(ObjectClass *oc, void *data)
     uc->can_be_deleted =3D introspection_can_be_deleted;
 }
=20
+static const VMStateDescription vmstate_introspection =3D {
+    .name =3D "vm_introspection",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_INT64(vm_start_time, VMIntrospection),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void instance_init(Object *obj)
 {
     VMIntrospectionClass *ic =3D VM_INTROSPECTION_CLASS(obj->class);
@@ -227,6 +238,8 @@ static void instance_init(Object *obj)
     object_property_add(obj, "unhook_timeout", "uint32",
                         prop_set_uint32, prop_get_uint32,
                         NULL, &i->unhook_timeout, NULL);
+
+    vmstate_register(NULL, 0, &vmstate_introspection, i);
 }
=20
 static void disconnect_chardev(VMIntrospection *i)


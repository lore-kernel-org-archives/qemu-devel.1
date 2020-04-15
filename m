Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01793C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67B320732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67B320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWaP-0005c8-VC
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0001Hi-2a
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP7-0005Bd-MF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP7-00050x-9E
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:49 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 2809C30747C9
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 148FB305B7A2;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 11/26] kvm: vmi: add 'handshake_timeout' property
Date: Wed, 15 Apr 2020 03:59:23 +0300
Message-Id: <20200415005938.23895-12-alazar@bitdefender.com>
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

By having a timer during handshake, the blocked connections can be
restored.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 57ded2f69c..5659663caa 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -19,6 +19,8 @@
=20
 #include "sysemu/vmi-handshake.h"
=20
+#define HANDSHAKE_TIMEOUT_SEC 10
+
 typedef struct VMIntrospection {
     Object parent_obj;
=20
@@ -32,6 +34,8 @@ typedef struct VMIntrospection {
     qemu_vmi_from_introspector hsk_in;
     uint64_t hsk_in_read_pos;
     uint64_t hsk_in_read_size;
+    GSource *hsk_timer;
+    uint32_t handshake_timeout;
=20
     int64_t vm_start_time;
=20
@@ -105,6 +109,26 @@ static void prop_set_chardev(Object *obj, const char=
 *value, Error **errp)
     i->chardevid =3D g_strdup(value);
 }
=20
+static void prop_get_uint32(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    uint32_t *value =3D opaque;
+
+    visit_type_uint32(v, name, value, errp);
+}
+
+static void prop_set_uint32(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    uint32_t *value =3D opaque;
+    Error *local_err =3D NULL;
+
+    visit_type_uint32(v, name, value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
+
 static bool chardev_is_connected(VMIntrospection *i, Error **errp)
 {
     Object *obj =3D OBJECT(i->chr);
@@ -129,6 +153,11 @@ static void instance_init(Object *obj)
     update_vm_start_time(i);
=20
     object_property_add_str(obj, "chardev", NULL, prop_set_chardev, NULL=
);
+
+    i->handshake_timeout =3D HANDSHAKE_TIMEOUT_SEC;
+    object_property_add(obj, "handshake_timeout", "uint32",
+                        prop_set_uint32, prop_get_uint32,
+                        NULL, &i->handshake_timeout, NULL);
 }
=20
 static void disconnect_chardev(VMIntrospection *i)
@@ -165,12 +194,28 @@ static void disconnect_and_unhook_kvmi(VMIntrospect=
ion *i)
     unhook_kvmi(i);
 }
=20
+static void cancel_timer(GSource *timer)
+{
+    if (timer) {
+        g_source_destroy(timer);
+        g_source_unref(timer);
+    }
+}
+
+static void cancel_handshake_timer(VMIntrospection *i)
+{
+    cancel_timer(i->hsk_timer);
+    i->hsk_timer =3D NULL;
+}
+
 static void instance_finalize(Object *obj)
 {
     VMIntrospection *i =3D VM_INTROSPECTION(obj);
=20
     g_free(i->chardevid);
=20
+    cancel_handshake_timer(i);
+
     if (i->chr) {
         shutdown_socket_fd(i);
         qemu_chr_fe_deinit(&i->sock, true);
@@ -303,7 +348,7 @@ static int chr_can_read(void *opaque)
 {
     VMIntrospection *i =3D opaque;
=20
-    if (i->sock_fd =3D=3D -1) {
+    if (i->hsk_timer =3D=3D NULL || i->sock_fd =3D=3D -1) {
         return 0;
     }
=20
@@ -356,10 +401,24 @@ static void chr_read(void *opaque, const uint8_t *b=
uf, int size)
     }
=20
     if (enough_bytes_for_handshake(i)) {
+        cancel_handshake_timer(i);
         validate_and_connect(i);
     }
 }
=20
+static gboolean chr_timeout(gpointer opaque)
+{
+    VMIntrospection *i =3D opaque;
+
+    warn_report("VMI: the handshake takes too long");
+
+    g_source_unref(i->hsk_timer);
+    i->hsk_timer =3D NULL;
+
+    disconnect_and_unhook_kvmi(i);
+    return FALSE;
+}
+
 static void chr_event_open(VMIntrospection *i)
 {
     Error *local_err =3D NULL;
@@ -378,6 +437,9 @@ static void chr_event_open(VMIntrospection *i)
     memset(&i->hsk_in, 0, sizeof(i->hsk_in));
     i->hsk_in_read_pos =3D 0;
     i->hsk_in_read_size =3D 0;
+    i->hsk_timer =3D qemu_chr_timeout_add_ms(i->chr,
+                                           i->handshake_timeout * 1000,
+                                           chr_timeout, i);
 }
=20
 static void chr_event_close(VMIntrospection *i)
@@ -386,6 +448,8 @@ static void chr_event_close(VMIntrospection *i)
         warn_report("VMI: introspection tool disconnected");
         disconnect_and_unhook_kvmi(i);
     }
+
+    cancel_handshake_timer(i);
 }
=20
 static void chr_event(void *opaque, QEMUChrEvent event)


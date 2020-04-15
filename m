Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFE720732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFE720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWae-00063D-Hq
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPA-0001Lk-Ld
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005Ce-5K
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:52 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052P-J0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:50 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 BCBB630747D3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id AC5CE305B7A0;
 Wed, 15 Apr 2020 03:59:35 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 17/26] kvm: vmi: add 'unhook_timeout' property
Date: Wed, 15 Apr 2020 03:59:29 +0300
Message-Id: <20200415005938.23895-18-alazar@bitdefender.com>
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

When the introspection tool has to remove all changes made to the
introspected VM, the guest must run because some hooks can be removed onl=
y
in certain conditions. But this shouldn't take too long even with a host
under heavy load. So, if the socket is not closed by the introspection
tool at the end of this unhook process in the time specified by the
unhook_timeout property, QEMU will shutdown the socket.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 151e27265a..1f3aff3bfe 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -25,6 +25,7 @@
 #include "sysemu/vmi-handshake.h"
=20
 #define HANDSHAKE_TIMEOUT_SEC 10
+#define UNHOOK_TIMEOUT_SEC 60
=20
 typedef struct VMIntrospection {
     Object parent_obj;
@@ -48,6 +49,8 @@ typedef struct VMIntrospection {
     uint32_t handshake_timeout;
=20
     int intercepted_action;
+    GSource *unhook_timer;
+    uint32_t unhook_timeout;
=20
     int reconnect_time;
=20
@@ -219,6 +222,11 @@ static void instance_init(Object *obj)
     object_property_add(obj, "handshake_timeout", "uint32",
                         prop_set_uint32, prop_get_uint32,
                         NULL, &i->handshake_timeout, NULL);
+
+    i->unhook_timeout =3D UNHOOK_TIMEOUT_SEC;
+    object_property_add(obj, "unhook_timeout", "uint32",
+                        prop_set_uint32, prop_get_uint32,
+                        NULL, &i->unhook_timeout, NULL);
 }
=20
 static void disconnect_chardev(VMIntrospection *i)
@@ -269,6 +277,12 @@ static void cancel_handshake_timer(VMIntrospection *=
i)
     i->hsk_timer =3D NULL;
 }
=20
+static void cancel_unhook_timer(VMIntrospection *i)
+{
+    cancel_timer(i->unhook_timer);
+    i->unhook_timer =3D NULL;
+}
+
 static void instance_finalize(Object *obj)
 {
     VMIntrospectionClass *ic =3D VM_INTROSPECTION_CLASS(obj->class);
@@ -277,6 +291,7 @@ static void instance_finalize(Object *obj)
     g_free(i->chardevid);
     g_free(i->keyid);
=20
+    cancel_unhook_timer(i);
     cancel_handshake_timer(i);
=20
     if (i->chr) {
@@ -576,6 +591,7 @@ static void chr_event_close(VMIntrospection *i)
         disconnect_and_unhook_kvmi(i);
     }
=20
+    cancel_unhook_timer(i);
     cancel_handshake_timer(i);
=20
     if (suspend_pending) {
@@ -604,6 +620,19 @@ static void chr_event(void *opaque, QEMUChrEvent eve=
nt)
     }
 }
=20
+static gboolean unhook_timeout_cbk(gpointer opaque)
+{
+    VMIntrospection *i =3D opaque;
+
+    warn_report("VMI: the introspection tool is too slow");
+
+    g_source_unref(i->unhook_timer);
+    i->unhook_timer =3D NULL;
+
+    disconnect_and_unhook_kvmi(i);
+    return FALSE;
+}
+
 static VMIntrospection *vm_introspection_object(void)
 {
     VMIntrospectionClass *ic;
@@ -663,6 +692,10 @@ static bool intercept_action(VMIntrospection *i,
         return false;
     }
=20
+    i->unhook_timer =3D qemu_chr_timeout_add_ms(i->chr,
+                                              i->unhook_timeout * 1000,
+                                              unhook_timeout_cbk, i);
+
     i->intercepted_action =3D action;
     return true;
 }


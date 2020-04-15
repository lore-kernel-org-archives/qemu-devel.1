Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6D7C38A29
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50B32076C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50B32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWdv-0004dd-Rp
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPA-0001L8-EN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005CY-3z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:52 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052b-Mg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:51 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 3AA83307483A
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 2B115305B7A1;
 Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 22/26] kvm: vmi: add 'async_unhook' property
Date: Wed, 15 Apr 2020 03:59:34 +0300
Message-Id: <20200415005938.23895-23-alazar@bitdefender.com>
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

The default method to handle the intercepted commands
(pause/suspend/migrate) might not be the simplest method. We add an
alternative method, used when async_unhook is set to false, that runs
the main loop until the introspection tool finish the unhook process
and closes the introspection socket.

Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index 01034d460e..bee9798e54 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -57,6 +57,7 @@ typedef struct VMIntrospection {
     int intercepted_action;
     GSource *unhook_timer;
     uint32_t unhook_timeout;
+    bool async_unhook;
=20
     int reconnect_time;
=20
@@ -186,6 +187,20 @@ static void prop_set_key(Object *obj, const char *va=
lue, Error **errp)
     i->keyid =3D g_strdup(value);
 }
=20
+static bool prop_get_async_unhook(Object *obj, Error **errp)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(obj);
+
+    return i->async_unhook;
+}
+
+static void prop_set_async_unhook(Object *obj, bool value, Error **errp)
+{
+    VMIntrospection *i =3D VM_INTROSPECTION(obj);
+
+    i->async_unhook =3D value;
+}
+
 static void prop_get_uint32(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -263,6 +278,11 @@ static void instance_init(Object *obj)
                         prop_set_uint32, prop_get_uint32,
                         NULL, &i->unhook_timeout, NULL);
=20
+    i->async_unhook =3D true;
+    object_property_add_bool(obj, "async_unhook",
+                             prop_get_async_unhook,
+                             prop_set_async_unhook, NULL);
+
     vmstate_register(NULL, 0, &vmstate_introspection, i);
 }
=20
@@ -739,6 +759,19 @@ static bool record_intercept_action(VMI_intercept_co=
mmand action)
     return true;
 }
=20
+static void wait_until_the_socket_is_closed(VMIntrospection *i)
+{
+    info_report("VMI: start waiting until fd=3D%d is closed", i->sock_fd=
);
+
+    while (i->sock_fd !=3D -1) {
+        main_loop_wait(false);
+    }
+
+    info_report("VMI: continue with the intercepted action fd=3D%d", i->=
sock_fd);
+
+    maybe_disable_socket_reconnect(i);
+}
+
 static bool intercept_action(VMIntrospection *i,
                              VMI_intercept_command action, Error **errp)
 {
@@ -767,6 +800,11 @@ static bool intercept_action(VMIntrospection *i,
                                               i->unhook_timeout * 1000,
                                               unhook_timeout_cbk, i);
=20
+    if (!i->async_unhook) {
+        wait_until_the_socket_is_closed(i);
+        return false;
+    }
+
     i->intercepted_action =3D action;
     return true;
 }


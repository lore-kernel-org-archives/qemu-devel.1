Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088CB20732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088CB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWcx-0002WN-5a
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWPC-0001QE-3j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWP9-0005D9-At
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:53 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWP8-00052h-Rq
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:51 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 559503074866; Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 3C8CC305B7A2;
 Wed, 15 Apr 2020 03:59:36 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 23/26] kvm: vmi: intercept shutdown
Date: Wed, 15 Apr 2020 03:59:35 +0300
Message-Id: <20200415005938.23895-24-alazar@bitdefender.com>
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
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marian Rotariu <marian.c.rotariu@gmail.com>

On shutdown, it is desirable that the introspection tool removes
its changes from the introspected VM, so that they don't reach the
hibernation file.

CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
---
 accel/kvm/vmi.c                | 31 +++++++++++++++++++++++++++----
 include/sysemu/vmi-intercept.h |  1 +
 monitor/qmp-cmds.c             |  4 ++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
index bee9798e54..2c6981a4bf 100644
--- a/accel/kvm/vmi.c
+++ b/accel/kvm/vmi.c
@@ -85,10 +85,12 @@ static const char *action_string[] =3D {
     "resume",
     "force-reset",
     "migrate",
+    "shutdown",
 };
=20
 static bool suspend_pending;
 static bool migrate_pending;
+static bool shutdown_pending;
=20
 #define TYPE_VM_INTROSPECTION "introspection"
=20
@@ -511,6 +513,17 @@ static void enable_socket_reconnect(VMIntrospection =
*i)
=20
 static void maybe_disable_socket_reconnect(VMIntrospection *i)
 {
+    if (shutdown_pending) {
+        /*
+         * We've got the shutdown notification, but the guest might not =
stop.
+         * We already caused the introspection tool to unhook
+         * because shutdown_pending was set.
+         * Let the socket connect again just in case the guest doesn't s=
top.
+         */
+        shutdown_pending =3D false;
+        return;
+    }
+
     if (i->reconnect_time =3D=3D 0) {
         info_report("VMI: disable socket reconnect");
         i->reconnect_time =3D qemu_chr_fe_reconnect_time(&i->sock, 0);
@@ -526,6 +539,9 @@ static void continue_with_the_intercepted_action(VMIn=
trospection *i)
     case VMI_INTERCEPT_MIGRATE:
         start_live_migration_thread(migrate_get_current());
         break;
+    case VMI_INTERCEPT_SHUTDOWN:
+        qemu_system_powerdown_request();
+        break;
     default:
         error_report("VMI: %s: unexpected action %d",
                      __func__, i->intercepted_action);
@@ -625,9 +641,10 @@ static void chr_event_open(VMIntrospection *i)
 {
     Error *local_err =3D NULL;
=20
-    if (suspend_pending || migrate_pending) {
-        info_report("VMI: %s: too soon (suspend=3D%d, migrate=3D%d)",
-                    __func__, suspend_pending, migrate_pending);
+    if (suspend_pending || migrate_pending || shutdown_pending) {
+        info_report("VMI: %s: too soon (suspend=3D%d, migrate=3D%d, shut=
down=3D%d)",
+                    __func__, suspend_pending, migrate_pending,
+                    shutdown_pending);
         maybe_disable_socket_reconnect(i);
         qemu_chr_fe_disconnect(&i->sock);
         return;
@@ -662,7 +679,7 @@ static void chr_event_close(VMIntrospection *i)
     cancel_unhook_timer(i);
     cancel_handshake_timer(i);
=20
-    if (suspend_pending || migrate_pending) {
+    if (suspend_pending || migrate_pending || shutdown_pending) {
         maybe_disable_socket_reconnect(i);
=20
         if (i->intercepted_action !=3D VMI_INTERCEPT_NONE) {
@@ -752,6 +769,9 @@ static bool record_intercept_action(VMI_intercept_com=
mand action)
     case VMI_INTERCEPT_MIGRATE:
         migrate_pending =3D true;
         break;
+    case VMI_INTERCEPT_SHUTDOWN:
+        shutdown_pending =3D true;
+        break;
     default:
         return false;
     }
@@ -839,6 +859,9 @@ static void vm_introspection_reset(void *opaque)
     }
=20
     update_vm_start_time(i);
+
+    /* warm reset triggered by user */
+    shutdown_pending =3D false;
 }
=20
 static bool make_cookie_hash(const char *key_id, uint8_t *cookie_hash,
diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-intercep=
t.h
index 4b93d17f2b..da086d7a04 100644
--- a/include/sysemu/vmi-intercept.h
+++ b/include/sysemu/vmi-intercept.h
@@ -16,6 +16,7 @@ typedef enum {
     VMI_INTERCEPT_RESUME,
     VMI_INTERCEPT_FORCE_RESET,
     VMI_INTERCEPT_MIGRATE,
+    VMI_INTERCEPT_SHUTDOWN,
 } VMI_intercept_command;
=20
 bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index d164635b5f..333a4a0ecc 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -107,6 +107,10 @@ void qmp_system_reset(Error **errp)
=20
 void qmp_system_powerdown(Error **errp)
 {
+    if (vm_introspection_intercept(VMI_INTERCEPT_SHUTDOWN, errp)) {
+        return;
+    }
+
     qemu_system_powerdown_request();
 }
=20


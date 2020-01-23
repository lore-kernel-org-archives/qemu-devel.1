Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1317121D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDhr1awJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1317121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuelS-0001Se-Ph
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuct0-0007bI-Ul
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucsz-0006l3-C8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucsz-0006kU-96
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPTdeRCRi0tlQK/tEkcE+Riv/JlR1YXbPbZK0rsXdY8=;
 b=bDhr1awJPimTT1n1+GEdelFPrCuUp+zddrAyRS8BXG1AB/E5bDwE3SpVqvB5XRbY38WsKA
 CbWs46+Ivya2KcRdBOpZ2ZPnHgwHu3yJieONhVNRtOrkxsZgq3kdoTibhlaF/hV7fN7MXm
 J7gvCeBBzTuXEURQdzYPC8Kha6IdGug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-tVaR__ASNOS7g1nPAed_2Q-1; Thu, 23 Jan 2020 08:51:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CADA08010DA;
 Thu, 23 Jan 2020 13:50:59 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C792A1CB;
 Thu, 23 Jan 2020 13:50:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/59] pvpanic: implement crashloaded event handling
Date: Thu, 23 Jan 2020 14:49:54 +0100
Message-Id: <1579787449-27599-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tVaR__ASNOS7g1nPAed_2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhenwei pi <pizhenwei@bytedance.com>

Handle bit 1 write, then post event to monitor.

Suggested by Paolo, declear a new event, using GUEST_PANICKED could
cause upper layers to react by shutting down or rebooting the guest.

In advance for extention, add GuestPanicInformation in event message.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20200114023102.612548-3-pizhenwei@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/specs/pvpanic.txt    | 16 ++++++++--------
 hw/misc/pvpanic.c         | 11 +++++++++--
 include/sysemu/runstate.h |  1 +
 qapi/run-state.json       | 24 ++++++++++++++++++++++--
 vl.c                      | 12 ++++++++++++
 5 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index bdea68a..a90fbca 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -19,9 +19,10 @@ Software should set only bits both itself and the device=
 recognize.
=20
 Bit Definition
 --------------
-bit 0: setting it indicates a guest panic has happened.
-bit 1: named crashloaded. setting it indicates a guest panic and run
-       kexec to handle error by guest itself.
+bit 0: a guest panic has happened and should be processed by the host
+bit 1: a guest panic has happened and will be handled by the guest;
+       the host should record it or report it, but should not affect
+       the execution of the guest.
=20
 ACPI Interface
 --------------
@@ -30,13 +31,12 @@ pvpanic device is defined with ACPI ID "QEMU0001". Cust=
om methods:
=20
 RDPT:       To determine whether guest panic notification is supported.
 Arguments:  None
-Return:     Returns a byte, bit 0 set to indicate guest panic
-            notification is supported. Other bits are reserved and
-            should be ignored.
+Return:     Returns a byte, with the same semantics as the I/O port
+            interface.
=20
 WRPT:       To send a guest panic event
-Arguments:  Arg0 is a byte, with bit 0 set to indicate guest panic has
-            happened. Other bits are reserved and should be cleared.
+Arguments:  Arg0 is a byte to be written, with the same semantics as
+            the I/O interface.
 Return:     None
=20
 The ACPI device will automatically refer to the right port in case it
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index d65ac86..4ebda78 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,11 +21,13 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
=20
-/* The bit of supported pv event */
+/* The bit of supported pv event, TODO: include uapi header and remove thi=
s */
 #define PVPANIC_F_PANICKED      0
+#define PVPANIC_F_CRASHLOADED   1
=20
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
+#define PVPANIC_CRASHLOADED     (1 << PVPANIC_F_CRASHLOADED)
=20
 #define ISA_PVPANIC_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
@@ -34,7 +36,7 @@ static void handle_event(int event)
 {
     static bool logged;
=20
-    if (event & ~PVPANIC_PANICKED && !logged) {
+    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASHLOADED) && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", ev=
ent);
         logged =3D true;
     }
@@ -43,6 +45,11 @@ static void handle_event(int event)
         qemu_system_guest_panicked(NULL);
         return;
     }
+
+    if (event & PVPANIC_CRASHLOADED) {
+        qemu_system_guest_crashloaded(NULL);
+        return;
+    }
 }
=20
 #include "hw/isa/isa.h"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0b41555..f760094 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -63,6 +63,7 @@ ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
+void qemu_system_guest_crashloaded(GuestPanicInformation *info);
=20
 #endif
=20
diff --git a/qapi/run-state.json b/qapi/run-state.json
index d7477cd..b83a436 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -357,16 +357,36 @@
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation'=
 } }
=20
 ##
+# @GUEST_CRASHLOADED:
+#
+# Emitted when guest OS crash loaded is detected
+#
+# @action: action that has been taken, currently always "run"
+#
+# @info: information about a panic
+#
+# Since: 5.0
+#
+# Example:
+#
+# <- { "event": "GUEST_CRASHLOADED",
+#      "data": { "action": "run" } }
+#
+##
+{ 'event': 'GUEST_CRASHLOADED',
+  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation'=
 } }
+
+##
 # @GuestPanicAction:
 #
 # An enumeration of the actions taken when guest OS panic is detected
 #
 # @pause: system pauses
 #
-# Since: 2.1 (poweroff since 2.8)
+# Since: 2.1 (poweroff since 2.8, run since 5.0)
 ##
 { 'enum': 'GuestPanicAction',
-  'data': [ 'pause', 'poweroff' ] }
+  'data': [ 'pause', 'poweroff', 'run' ] }
=20
 ##
 # @GuestPanicInformationType:
diff --git a/vl.c b/vl.c
index 71d3e7e..9f5f477 100644
--- a/vl.c
+++ b/vl.c
@@ -1468,6 +1468,18 @@ void qemu_system_guest_panicked(GuestPanicInformatio=
n *info)
     }
 }
=20
+void qemu_system_guest_crashloaded(GuestPanicInformation *info)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+
+    qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN,
+                                   !!info, info);
+
+    if (info) {
+        qapi_free_GuestPanicInformation(info);
+    }
+}
+
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot && reason !=3D SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
--=20
1.8.3.1




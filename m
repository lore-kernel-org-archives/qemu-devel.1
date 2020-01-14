Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35660C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F8C2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="mbpusgzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irC0d-000278-Uu
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pizhenwei@bytedance.com>) id 1irBzD-0000NQ-RN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1irBzB-0003Xt-Kn
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:31:19 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1irBzB-0003WH-ER
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:31:17 -0500
Received: by mail-pg1-x542.google.com with SMTP id x7so5637963pgl.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 18:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fshKwfwt9Dp2Wq1APH+4/EX0Jo99Mva81d26eLwAGKU=;
 b=mbpusgzsMyJviGzLEQxRIhG5CgsaAx8t/ft5X1z5SazNaYFCXZiEasmgwJ8TEoihU9
 cHWgmC1irJvovbBccQpNoHt5fYBN/SINI/eW/RDe4qTkg5DkLbo7Yq9OWOxcdefpLgis
 iBoOfuJ9d/IomJghiIXEPuBZilKp8808IXel3ky6o2N6GYo3alGEdd1uik8+qDE/FOHz
 LL/e6XpZW9IsFEYW0OFzryuNAFPekPeEFIaoBL3AFknnB4E897O1JH1dOS8DSpyXh5GX
 Rka8jheQk1p2hk8ShV02Ctq3htxSKMtcQzHaOgrWGnrlXYzja+YWos5yJ9C1RuM1diNe
 PbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fshKwfwt9Dp2Wq1APH+4/EX0Jo99Mva81d26eLwAGKU=;
 b=IK55ZSSZlo1DFNcxgL85wb7dzY6OQNmoTu94DbzSO4nWYayZ1qrWku/TutjaTpZD5P
 JyrYEpAGGJKkXd992IGks4BFh9z3aEWKwGDCPZvH6PBEnaRTFxRvTLxPYHorMfL/OpC6
 peqWhVQp9U9AftFoHfPofpzA+jW4LyVMOoCP5cijUbDjRA9X25KecA/HUh28FXhYtIyU
 LmNZlMZ9lmp/bj6IssY+kn7+beZPj5g1YblmBieVaj7UZpMgAOwuB83EYPssno+WEHVF
 oq3WJuafw34aVz9X/yRsPmdYtCCnEKSQodmyBBfpz53YxzV96VJh6e0OruvFMK4Huu4A
 GsBA==
X-Gm-Message-State: APjAAAXhBcGJyDKuSdaKmGMJGJN/L9svDp4qOUKpK98hUEz+D/Fsm7Pf
 GhL/XSPB/SFp9delVjTKzZQIpw==
X-Google-Smtp-Source: APXvYqz/rAPjfjTLludp1mPfVH0zzc8heEjvHX9a2wJqZZzSpTwL0owkyfQXeCkEgofLKB/ffHjdoA==
X-Received: by 2002:a63:6b07:: with SMTP id g7mr23798378pgc.243.1578969074943; 
 Mon, 13 Jan 2020 18:31:14 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id w5sm14693898pgb.78.2020.01.13.18.31.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 18:31:14 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com
Subject: [PATCH 2/2] pvpanic: implement crashloaded event handling
Date: Tue, 14 Jan 2020 10:31:02 +0800
Message-Id: <20200114023102.612548-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200114023102.612548-1-pizhenwei@bytedance.com>
References: <20200114023102.612548-1-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: gregkh@linuxfoundation.org, yelu@bytedance.com, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handle bit 1 write, then post event to monitor.

Suggested by Paolo, declear a new event, using GUEST_PANICKED could
cause upper layers to react by shutting down or rebooting the guest.

In advance for extention, add GuestPanicInformation in event message.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/misc/pvpanic.c         | 11 +++++++++--
 include/sysemu/runstate.h |  1 +
 qapi/run-state.json       | 22 +++++++++++++++++++++-
 vl.c                      | 12 ++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index d65ac86478..4ebda7872a 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,11 +21,13 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 
-/* The bit of supported pv event */
+/* The bit of supported pv event, TODO: include uapi header and remove this */
 #define PVPANIC_F_PANICKED      0
+#define PVPANIC_F_CRASHLOADED   1
 
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
+#define PVPANIC_CRASHLOADED     (1 << PVPANIC_F_CRASHLOADED)
 
 #define ISA_PVPANIC_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
@@ -34,7 +36,7 @@ static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~PVPANIC_PANICKED && !logged) {
+    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASHLOADED) && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
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
 
 #include "hw/isa/isa.h"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0b41555609..f760094858 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -63,6 +63,7 @@ ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
+void qemu_system_guest_crashloaded(GuestPanicInformation *info);
 
 #endif
 
diff --git a/qapi/run-state.json b/qapi/run-state.json
index d7477cd715..b7a91f3125 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -357,6 +357,26 @@
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
 ##
+# @GUEST_CRASHLOADED:
+#
+# Emitted when guest OS crash loaded is detected
+#
+# @action: action that has been taken, currently always "run"
+#
+# @info: information about a panic (since 2.9)
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
+  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
+
+##
 # @GuestPanicAction:
 #
 # An enumeration of the actions taken when guest OS panic is detected
@@ -366,7 +386,7 @@
 # Since: 2.1 (poweroff since 2.8)
 ##
 { 'enum': 'GuestPanicAction',
-  'data': [ 'pause', 'poweroff' ] }
+  'data': [ 'pause', 'poweroff', 'run' ] }
 
 ##
 # @GuestPanicInformationType:
diff --git a/vl.c b/vl.c
index 86474a55c9..5b1b2ef095 100644
--- a/vl.c
+++ b/vl.c
@@ -1468,6 +1468,18 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     }
 }
 
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
     if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
-- 
2.11.0



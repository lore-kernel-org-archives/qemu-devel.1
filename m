Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8116C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B0D2244C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiYWEZV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B0D2244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVT22-0006Xf-MT
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSuB-0003qJ-Gp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu6-0003z9-EY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qha+9NtEWPSLnz/grVGF9D4kfTA/XaaDFcqMGN+6PSY=;
 b=ZiYWEZV/4Ra2w0rCAvJTlt88ILz7A1PT+AzuCR8Av+Jr/PAD/R1WJAtaIYrIDHWMGknroO
 FmNk1lpZ4PiHWStUj2h9ohPrM29AO0nE5oU6N6K1k4xN21WzbsBPkOCR/a/kZMmfdYjqQu
 fLKpE//tBNuNs1Rbwq5xNNaxUAsLhpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-5qDq9kgGPqyV2Nrfeh2ZPw-1; Thu, 22 Oct 2020 01:12:41 -0400
X-MC-Unique: 5qDq9kgGPqyV2Nrfeh2ZPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83983835B5D
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5085A5C1C7;
 Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AF3129D10; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] spice: move add_interface() to QemuSpiceOps.
Date: Thu, 22 Oct 2020 07:12:14 +0200
Message-Id: <20201022051223.6181-6-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-6-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h | 7 +++++++
 include/ui/qemu-spice.h        | 1 -
 audio/spiceaudio.c             | 4 ++--
 chardev/spice.c                | 2 +-
 ui/spice-core.c                | 5 +++--
 ui/spice-input.c               | 6 +++---
 6 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index dbe09035dade..f93acde5743c 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -18,10 +18,17 @@
 #ifndef QEMU_SPICE_MODULE_H
 #define QEMU_SPICE_MODULE_H
 
+#ifdef CONFIG_SPICE
+#include <spice.h>
+#endif
+
 struct QemuSpiceOps {
     void (*init)(void);
     void (*display_init)(void);
     int (*migrate_info)(const char *h, int p, int t, const char *s);
+#ifdef CONFIG_SPICE
+    int (*add_interface)(SpiceBaseInstance *sin);
+#endif
 };
 
 extern int using_spice;
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index a3fd1ea5ade8..6018577c5278 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -29,7 +29,6 @@
 void qemu_spice_input_init(void);
 void qemu_spice_display_init(void);
 int qemu_spice_display_add_client(int csock, int skipauth, int tls);
-int qemu_spice_add_interface(SpiceBaseInstance *sin);
 bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_set_passwd(const char *passwd,
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index ed6dff1dcc41..8967cca12925 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -106,7 +106,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
     out->active = 0;
 
     out->sin.base.sif = &playback_sif.base;
-    qemu_spice_add_interface (&out->sin.base);
+    qemu_spice.add_interface(&out->sin.base);
 #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
     spice_server_set_playback_rate(&out->sin, settings.freq);
 #endif
@@ -215,7 +215,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     in->active = 0;
 
     in->sin.base.sif = &record_sif.base;
-    qemu_spice_add_interface (&in->sin.base);
+    qemu_spice.add_interface(&in->sin.base);
 #if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
     spice_server_set_record_rate(&in->sin, settings.freq);
 #endif
diff --git a/chardev/spice.c b/chardev/spice.c
index 7d1fb1771894..1104426e3a11 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -110,7 +110,7 @@ static void vmc_register_interface(SpiceChardev *scd)
         return;
     }
     scd->sin.base.sif = &vmc_interface.base;
-    qemu_spice_add_interface(&scd->sin.base);
+    qemu_spice.add_interface(&scd->sin.base);
     scd->active = true;
     trace_spice_vmc_register_interface(scd);
 }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 82d5dbda3e26..483d880a3362 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -800,7 +800,7 @@ static void qemu_spice_init(void)
     migration_state.notify = migration_state_notifier;
     add_migration_state_change_notifier(&migration_state);
     spice_migrate.base.sif = &migrate_interface.base;
-    qemu_spice_add_interface(&spice_migrate.base);
+    qemu_spice.add_interface(&spice_migrate.base);
 
     qemu_spice_input_init();
 
@@ -829,7 +829,7 @@ static void qemu_spice_init(void)
 #endif
 }
 
-int qemu_spice_add_interface(SpiceBaseInstance *sin)
+static int qemu_spice_add_interface(SpiceBaseInstance *sin)
 {
     if (!spice_server) {
         if (QTAILQ_FIRST(&qemu_spice_opts.head) != NULL) {
@@ -997,6 +997,7 @@ static struct QemuSpiceOps real_spice_ops = {
     .init         = qemu_spice_init,
     .display_init = qemu_spice_display_init,
     .migrate_info = qemu_spice_migrate_info,
+    .add_interface = qemu_spice_add_interface,
 };
 
 static void spice_register_config(void)
diff --git a/ui/spice-input.c b/ui/spice-input.c
index 21990fa9962b..bbd502564edf 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -231,7 +231,7 @@ static void mouse_mode_notifier(Notifier *notifier, void *data)
     }
 
     if (is_absolute) {
-        qemu_spice_add_interface(&pointer->tablet.base);
+        qemu_spice.add_interface(&pointer->tablet.base);
     } else {
         spice_server_remove_interface(&pointer->tablet.base);
     }
@@ -245,13 +245,13 @@ void qemu_spice_input_init(void)
 
     kbd = g_malloc0(sizeof(*kbd));
     kbd->sin.base.sif = &kbd_interface.base;
-    qemu_spice_add_interface(&kbd->sin.base);
+    qemu_spice.add_interface(&kbd->sin.base);
     qemu_add_led_event_handler(kbd_leds, kbd);
 
     pointer = g_malloc0(sizeof(*pointer));
     pointer->mouse.base.sif  = &mouse_interface.base;
     pointer->tablet.base.sif = &tablet_interface.base;
-    qemu_spice_add_interface(&pointer->mouse.base);
+    qemu_spice.add_interface(&pointer->mouse.base);
 
     pointer->absolute = false;
     pointer->mouse_mode.notify = mouse_mode_notifier;
-- 
2.27.0



Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26388C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6A32074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6A32074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrEf-0007Uw-76
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7h-0006YN-Fw
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:41 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:47618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7g-0004NX-MO
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:41 -0400
Received: from fwd29.aul.t-online.de (fwd29.aul.t-online.de [172.20.26.134])
 by mailout02.t-online.de (Postfix) with SMTP id 1990C41E6CEA;
 Sat, 16 May 2020 09:20:39 +0200 (CEST)
Received: from linpower.localnet
 (SaLBbkZAwhrltt+wOYB-fpP9UHHzDdPY6trQjCngInVPk9-iqKBRxMFp+wNjOqOgLp@[46.86.59.135])
 by fwd29.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7c-4FpbIu0; Sat, 16 May 2020 09:20:36 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id EA48B2006D7; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 09/11] ui/gtk: don't pass on win keys without keyboard grab
Date: Sat, 16 May 2020 09:20:12 +0200
Message-Id: <20200516072014.7766-9-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: SaLBbkZAwhrltt+wOYB-fpP9UHHzDdPY6trQjCngInVPk9-iqKBRxMFp+wNjOqOgLp
X-TOI-EXPURGATEID: 150726::1589613636-0001455D-ED96F503/0/0 CLEAN NORMAL
X-TOI-MSGID: 5ec51592-d7f4-4455-8790-64db3a7d2044
Received-SPF: none client-ip=194.25.134.17;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout02.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without keyboard grab Windows currently handles the two win keys
and the key events are also sent to the guest. This is undesir-
able. Only one program should handle key events. This patch ap-
plies commit c68f74b02e "win32: do not handle win keys when the
keyboard is not grabbed" from project spice-gtk to ui/gtk.c to
fix this problem.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 354dd90e18..1d51e14bb5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1095,10 +1095,17 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     VirtualConsole *vc = opaque;
     int qcode;
 
-#ifdef WIN32
+#ifdef G_OS_WIN32
     /* on windows, we ought to ignore the reserved key event? */
     if (key->hardware_keycode == 0xff)
         return false;
+
+    if (!vc->s->kbd_owner) {
+        if (key->hardware_keycode == VK_LWIN ||
+            key->hardware_keycode == VK_RWIN) {
+            return FALSE;
+        }
+    }
 #endif
 
     if (key->keyval == GDK_KEY_Pause
-- 
2.26.1



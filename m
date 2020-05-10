Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141BC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F0A2082E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F0A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXr1p-0001NW-Nh
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv7-00081y-Im
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:25 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:33024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv6-0005Rf-Is
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:25 -0400
Received: from fwd26.aul.t-online.de (fwd26.aul.t-online.de [172.20.26.131])
 by mailout11.t-online.de (Postfix) with SMTP id DC6B04216F8A;
 Sun, 10 May 2020 20:43:22 +0200 (CEST)
Received: from linpower.localnet
 (E69VcaZbQhpsoxeUPbOxU4e1EuBmP+jS+ihFAP5ViFXLOHk5paJH8bW764H9b-gZIv@[46.86.59.135])
 by fwd26.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jXqv4-1qwRU00; Sun, 10 May 2020 20:43:22 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A4BF4200631; Sun, 10 May 2020 20:43:04 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/10] ui/sdl2-input: use trace-events to debug key events
Date: Sun, 10 May 2020 20:43:02 +0200
Message-Id: <20200510184304.9267-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: E69VcaZbQhpsoxeUPbOxU4e1EuBmP+jS+ihFAP5ViFXLOHk5paJH8bW764H9b-gZIv
X-TOI-MSGID: 13800317-9579-487a-b8f2-4e9cf194af63
Received-SPF: none client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 14:43:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/sdl2-input.c | 3 +++
 ui/trace-events | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 1f9fe831b3..f068382209 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -27,6 +27,7 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
+#include "trace.h"
 
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
@@ -38,6 +39,8 @@ void sdl2_process_key(struct sdl2_console *scon,
         return;
     }
     qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
+    trace_sdl2_process_key(ev->keysym.scancode, qcode,
+                           ev->type == SDL_KEYDOWN ? "down" : "up");
     qkbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
 
     if (!qemu_console_is_graphic(con)) {
diff --git a/ui/trace-events b/ui/trace-events
index 0dcda393c1..5367fd3f16 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -75,6 +75,9 @@ input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value
 input_event_sync(void) ""
 input_mouse_mode(int absolute) "absolute %d"
 
+# sdl2-input.c
+sdl2_process_key(int sdl_scancode, int qcode, const char *action) "translated SDL scancode %d to QKeyCode %d (%s)"
+
 # spice-display.c
 qemu_spice_add_memslot(int qid, uint32_t slot_id, unsigned long virt_start, unsigned long virt_end, int async) "%d %u: host virt 0x%lx - 0x%lx async=%d"
 qemu_spice_del_memslot(int qid, uint32_t gid, uint32_t slot_id) "%d gid=%u sid=%u"
-- 
2.26.1



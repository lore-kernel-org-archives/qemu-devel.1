Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA09C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDD52074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDD52074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZr8z-00082O-Bn
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7k-0006dN-Bc
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:44 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:59344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7j-0004OG-IS
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:44 -0400
Received: from fwd15.aul.t-online.de (fwd15.aul.t-online.de [172.20.27.63])
 by mailout05.t-online.de (Postfix) with SMTP id 430B94256FBE;
 Sat, 16 May 2020 09:20:42 +0200 (CEST)
Received: from linpower.localnet
 (rxbYWkZJohSfXEj1YysZVWE7KVlwz6DStV+gnzxVfnzcrSOU5mBS1XsEnNrgt4PZfU@[46.86.59.135])
 by fwd15.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7Z-19h5aS0; Sat, 16 May 2020 09:20:33 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id E83582006D6; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 08/11] ui/sdl2-input: use trace-events to debug key events
Date: Sat, 16 May 2020 09:20:11 +0200
Message-Id: <20200516072014.7766-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: rxbYWkZJohSfXEj1YysZVWE7KVlwz6DStV+gnzxVfnzcrSOU5mBS1XsEnNrgt4PZfU
X-TOI-EXPURGATEID: 150726::1589613633-00012849-77775E67/0/0 CLEAN NORMAL
X-TOI-MSGID: e3487884-49c7-42f0-95e3-66ef4babfda0
Received-SPF: none client-ip=194.25.134.82;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout05.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:34
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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



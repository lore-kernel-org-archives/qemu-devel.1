Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC70C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636412074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636412074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrCk-0005iJ-LR
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7d-0006Sq-GT
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:37 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:59254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7b-0004K9-TS
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:37 -0400
Received: from fwd31.aul.t-online.de (fwd31.aul.t-online.de [172.20.26.136])
 by mailout05.t-online.de (Postfix) with SMTP id 49121422CA1B;
 Sat, 16 May 2020 09:20:34 +0200 (CEST)
Received: from linpower.localnet
 (XRhwluZb8h3xAQ65s6dKIwe8ZvUaXd3mQrHbvFuV2e+fg2uw7pVUEa1CoyddCw6QHQ@[46.86.59.135])
 by fwd31.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7W-3NNMoq0; Sat, 16 May 2020 09:20:30 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id E60372006D5; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 07/11] ui/sdl2: start in full screen with grab enabled
Date: Sat, 16 May 2020 09:20:10 +0200
Message-Id: <20200516072014.7766-7-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: XRhwluZb8h3xAQ65s6dKIwe8ZvUaXd3mQrHbvFuV2e+fg2uw7pVUEa1CoyddCw6QHQ
X-TOI-EXPURGATEID: 150726::1589613630-0000B630-61FD851A/0/0 CLEAN NORMAL
X-TOI-MSGID: de3dc480-66c3-43e3-9be4-f7d3451767b2
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

QEMU with SDL 1.2 display used to enable keyboard and mouse grab-
bing when started in full screen. The SDL 2.0 code tries to do
the same but fails to enable grabbing because sdl_grab_start(0)
returns early. To do it's work the sdl_grab_start() function
needs a pointer to a sdl2_console structure.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/sdl2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 79c1ea29d2..b23a8f0a8e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -881,17 +881,16 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         SDL_SetWindowIcon(sdl2_console[0].real_window, icon);
     }
 
-    gui_grab = 0;
-    if (gui_fullscreen) {
-        sdl_grab_start(0);
-    }
-
     mouse_mode_notifier.notify = sdl_mouse_mode_change;
     qemu_add_mouse_mode_change_notifier(&mouse_mode_notifier);
 
     sdl_cursor_hidden = SDL_CreateCursor(&data, &data, 8, 1, 0, 0);
     sdl_cursor_normal = SDL_GetCursor();
 
+    if (gui_fullscreen) {
+        sdl_grab_start(&sdl2_console[0]);
+    }
+
     atexit(sdl_cleanup);
 }
 
-- 
2.26.1



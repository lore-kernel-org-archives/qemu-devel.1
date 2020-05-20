Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FAAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904192072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb98CC6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904192072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKQx-0000Hs-Qh
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK1-0001IY-Bu
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK0-0006dW-IL
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuBuzj5GYz7RhXBC+9SUi2jwNTsF+AAg+8mDGbNWuVI=;
 b=Bb98CC6yyq+wd2SCjRdkgL5uozMWK2sarPMHZebDDA+Y/1u76HMZ4BTI/zLz6y85uOd6lq
 qyxyZUYEoyKy0lY6U5mWNJn9R2k29kelEepet+Itcuj5PKUgxyg1OECc5sUOj83UANpSxO
 gSec/Q3Jp7h4iojCeG/2Y62uvNr9xIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-v_ZQBq4WPzWZU9p2e_sY-Q-1; Wed, 20 May 2020 04:43:25 -0400
X-MC-Unique: v_ZQBq4WPzWZU9p2e_sY-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A1D8005AA;
 Wed, 20 May 2020 08:43:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBBC85C1C8;
 Wed, 20 May 2020 08:43:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C03E59D57; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] ui/sdl2-input: use trace-events to debug key events
Date: Wed, 20 May 2020 10:43:13 +0200
Message-Id: <20200520084316.22057-9-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-8-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 3 +++
 ui/trace-events | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 1f9fe831b30d..f068382209cc 100644
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
index 0dcda393c1d6..5367fd3f1668 100644
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
2.18.4



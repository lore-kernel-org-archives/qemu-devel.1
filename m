Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002C8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E05207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Df0c8kS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E05207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKNz-0001r3-1S
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK1-0001Ho-4P
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKK0-0006dT-C5
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0h9Xrn5alrncjgk60MHQt9zTPyjvKPS+4HBKjbyq7MI=;
 b=Df0c8kS6yrWh0zVShZNg5P/t322JluJucKOvrG3lWoPn+FDcYBuFgN1Xe8vXHBhrMFUc5l
 8y538J6Vwy2Y3I1i3oiDUq5V01FA1QgdkmTDvT7HPx5Rp4zoRmjoPx/YIf91uugTYZpkQD
 R49KO4WlCWhh5xjq25gKVHmvTVWDfWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-ycuPYvc7MXewFvH9HKutJA-1; Wed, 20 May 2020 04:43:25 -0400
X-MC-Unique: ycuPYvc7MXewFvH9HKutJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA68B107ACF2;
 Wed, 20 May 2020 08:43:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8E04579A5;
 Wed, 20 May 2020 08:43:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B60619D56; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] ui/sdl2: start in full screen with grab enabled
Date: Wed, 20 May 2020 10:43:12 +0200
Message-Id: <20200520084316.22057-8-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

QEMU with SDL 1.2 display used to enable keyboard and mouse grab-
bing when started in full screen. The SDL 2.0 code tries to do
the same but fails to enable grabbing because sdl_grab_start(0)
returns early. To do it's work the sdl_grab_start() function
needs a pointer to a sdl2_console structure.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-7-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 79c1ea29d223..b23a8f0a8ebf 100644
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
2.18.4



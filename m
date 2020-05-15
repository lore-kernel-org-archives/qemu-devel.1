Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F7620643
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8sV7nwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F7620643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVcH-00058A-Lp
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZVbP-0002h7-OL
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:21:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZVbO-000735-6i
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589530912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=jRMZC5OSX7ykSRfi5pqfB6bzNGtkWLXupu/WFBt08dk=;
 b=H8sV7nwRC41PeZ1d0nHy3XifVnih081DTtGQNZJuKmt4z/GyWgnWRVa2D9dehOSGiAQTir
 IMSgTgsPXBhUX+Ur2A79KdUd9k4jhS57TgUBKrf1+mFwN3XVisVnMzGzPvWN6MOYKEli2q
 PEyjPx+Jl6tp+ot1UJvPrEA4F/Rte68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-ob76ASCDNiyf0K_JKDQPCQ-1; Fri, 15 May 2020 04:21:50 -0400
X-MC-Unique: ob76ASCDNiyf0K_JKDQPCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC674EC1B0;
 Fri, 15 May 2020 08:21:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB1F25D9F3;
 Fri, 15 May 2020 08:21:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C14201750A; Fri, 15 May 2020 10:21:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] ui/sdl2: fix segment fault caused by null pointer
 dereference
Date: Fri, 15 May 2020 10:21:45 +0200
Message-Id: <20200515082145.4732-3-kraxel@redhat.com>
In-Reply-To: <20200515082145.4732-1-kraxel@redhat.com>
References: <20200515082145.4732-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Changbin Du <changbin.du@gmail.com>

I found SDL_GetWindowFromID() sometimes return NULL when I start qemu via
ssh forwarding even the window has been crated already. I am not sure
whether this is a bug of SDL, but we'd better check it carefully.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Message-id: 20200427132412.17909-1-changbin.du@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3c9424eb42c3..61c7956da334 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -332,6 +332,10 @@ static void handle_keydown(SDL_Event *ev)
     int gui_key_modifier_pressed = get_mod_state();
     int gui_keysym = 0;
 
+    if (!scon) {
+        return;
+    }
+
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
@@ -412,6 +416,10 @@ static void handle_keyup(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!scon) {
+        return;
+    }
+
     scon->ignore_hotkeys = false;
     sdl2_process_key(scon, &ev->key);
 }
@@ -421,6 +429,10 @@ static void handle_textinput(SDL_Event *ev)
     struct sdl2_console *scon = get_scon_from_window(ev->text.windowID);
     QemuConsole *con = scon ? scon->dcl.con : NULL;
 
+    if (!con) {
+        return;
+    }
+
     if (qemu_console_is_graphic(con)) {
         return;
     }
-- 
2.18.4



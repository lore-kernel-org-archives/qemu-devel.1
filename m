Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7965FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E385206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7P5BtSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E385206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2jX-0007af-AG
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jT2ie-0006uN-1s
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jT2ic-0004Af-Qs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:18:39 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <changbin.du@gmail.com>)
 id 1jT2ic-0004AL-Eu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:18:38 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mq3so7457569pjb.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IKMbtx7gBxw903nAaf6U7wWNBobOo6bMHNjcwxePbvE=;
 b=C7P5BtSrHqy0vXQWIw/iZBhULv+sAl02Wqi54GwqCm4VgWy9lVifEBelwXDnWZ9XmC
 /B6Tb84ciHkNWKCwJhDUvvpMhihIyy7NhTs6S08fyrjEiP95kbDTVS/CH2Vsh+Co/ARI
 6bsfqqsLHhhy2dRCS1CxpCcRTtjU8/dgiCG6eEP3CaVCHk7/zG2bwIf/msnnpWS9I2Uu
 o7nQM9PBJoKXShZJ3fJfLfi6uDxyxSSyETbrzIEaySMlrAOIEnOLoPdlIow90CJczdif
 PXZ9vG+0PctlGFF35wGIV2SBmTYdXHJY9BU4sP7DLBIcOOEY9+ryLSwduyOH5OiWvWNP
 Xz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IKMbtx7gBxw903nAaf6U7wWNBobOo6bMHNjcwxePbvE=;
 b=exSEMEpUzWMGw/DXT7C4B+w/PPWQSwbvQPbbb2wSxoNbG3462zzm6ESNdybXBZdWbE
 Qpd00tvlJPMXr/ybkRO0O+em57mKfACTuxLquIdv2kahmcsyZghMePh/nwwUXJu0dygj
 riyIfdHb71FmS6u7pN5frqa0eBITBv2ddbhOoiO8g6TF7aPQD+3PZTkW9bG9CCqD/eJv
 igyy1TnpXqzlfhuqkIhRdoi/UO4f67K85RJLOihDrjs9vdMidH96HbLJuLjKKRhl/hlL
 22Abe3asCaS7oNjQWLuWoTTD+ON/WhIwcclA+HIamQHGoRnJ7RuH3qGPcQMmz4GQcnRc
 gAMA==
X-Gm-Message-State: AGi0PuZ52lMYY8PyY7qAn6wm1/v3wohyrMLH8Bh9+nxnMd96U5K/BCBO
 Yw7kSNb+nky5CYRlswO5cb8=
X-Google-Smtp-Source: APiQypJF9ul5fGCZZzXzXPpTHcSDs6x9th5dNc5EPmCBImSHXOhbbbop66cZ3cKCol1KJxHlndHYUg==
X-Received: by 2002:a17:90a:fe06:: with SMTP id
 ck6mr12306679pjb.4.1587989916315; 
 Mon, 27 Apr 2020 05:18:36 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id v127sm12064720pfv.77.2020.04.27.05.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:18:35 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui/sdl2: fix segment fault caused by null pointer dereference
Date: Mon, 27 Apr 2020 20:18:23 +0800
Message-Id: <20200427121823.8094-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=changbin.du@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-devel@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found SDL_GetWindowFromID() sometimes return NULL when I start qemu via
ssh forwarding even the window has been crated already. I am not sure
whether this is a bug of SDL, but we'd better check it carefully.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 ui/sdl2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3c9424eb42..7c9c93b951 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -332,6 +332,9 @@ static void handle_keydown(SDL_Event *ev)
     int gui_key_modifier_pressed = get_mod_state();
     int gui_keysym = 0;
 
+    if (!scon)
+        return;
+
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
@@ -412,6 +415,9 @@ static void handle_keyup(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!sconf)
+        return;
+
     scon->ignore_hotkeys = false;
     sdl2_process_key(scon, &ev->key);
 }
@@ -421,6 +427,9 @@ static void handle_textinput(SDL_Event *ev)
     struct sdl2_console *scon = get_scon_from_window(ev->text.windowID);
     QemuConsole *con = scon ? scon->dcl.con : NULL;
 
+    if (!con)
+        return;
+
     if (qemu_console_is_graphic(con)) {
         return;
     }
-- 
2.20.1



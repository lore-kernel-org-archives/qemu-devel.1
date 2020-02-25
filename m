Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF99C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4831821744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwYHNnAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4831821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a8o-00021Z-B8
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0N-0003lj-4F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003cJ-Ti
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:03 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0L-0003Zc-Fz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: by mail-wr1-x433.google.com with SMTP id t3so14415742wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PoXSTHzZhLJC7qI3DvyyIZhGpE5rZzcJUPG/3Jp3XA4=;
 b=nwYHNnAqpHSLF+dgyjRYEw4WS3tS6PWd6gSG+I0IcDeCkYM4cOs+c5Mrm+4OyyTGmx
 WIrL6/LAn+l337JM33NRslFl/vMQ2UZkVvx2X1NxQYQL1ip5nfpEIfGpHyTGC8c1JRSe
 LI+0vgtRslfKjEBd/UgZxzpWp30w0rJOu0pZJUCd7sBX8zjR/cJco0p9wFPJsAa9Zg/Z
 +YLqk5Lg53eMSxKpgENmUQdzZxL1llzFgPub4N3jcGoRY2V/oNNNdNTVccr4qvZ/RVa/
 lI3RH8YJa4b1kzOF0q6yso55WjlBU6Z3L4IReYD6hHNMzrL3Y5ytXJawnK4OClXK6Jx8
 ykCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PoXSTHzZhLJC7qI3DvyyIZhGpE5rZzcJUPG/3Jp3XA4=;
 b=NXOO3O48qk8kFMMr1DDqK8OeYTs/njye1/SyYnH/cbW3jLWG3QMKkckH0/4tnTBsDc
 JJxt3Gc+yzZypLhLYciE4IOx4DZ6PdVu8h0ewjDo7LPOTuacQgb+AkhNVd2Dw2zn5WiR
 Hr994/hqxMxaSMrO0byq98+7R2j8ZNGefEr3yvi5yaEvsrGyDGlD2CIoCiPpf+ZiT2jk
 jnnV3LmVJIoEbiUiTA1iw53W3KyS4TDHJLiRcZnmJIRgi3YA1r6F2d0+aNxZdaCYC34D
 g3DoUrhSAdWRddgF6nhx3Fxh9Qv5VUB4WpnAaLl6A1y0I7RKYzwhiA0eeL4kzii7sPAQ
 yOHw==
X-Gm-Message-State: APjAAAU7XXOUkaoaqis99ny4gFgtdpHIeioO0AgemCJ84MISG732NnJL
 qQILBbTOMiNWagaPozKl1NTtU2+f
X-Google-Smtp-Source: APXvYqyc3Dqv99jff+FlknVG411oIn3b3s4RW+gAofLkFYrEz3QxkhzRqlI1eTqG6TYv0TH0MgsSHQ==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr1316886wrv.415.1582632477247; 
 Tue, 25 Feb 2020 04:07:57 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 124/136] hw/display: Let devices own the MemoryRegion they
 create
Date: Tue, 25 Feb 2020 13:07:22 +0100
Message-Id: <1582632454-16491-22-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-27-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/display/g364fb.c | 3 ++-
 hw/display/macfb.c  | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 55185c9..adcba96 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -477,7 +477,8 @@ static void g364fb_init(DeviceState *dev, G364State *s)
 
     s->con = graphic_console_init(dev, 0, &g364fb_ops, s);
 
-    memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ctrl", 0x180000);
+    memory_region_init_io(&s->mem_ctrl, OBJECT(dev), &g364fb_ctrl_ops, s,
+                          "ctrl", 0x180000);
     memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
                                s->vram_size, s->vram);
     vmstate_register_ram(&s->mem_vram, dev);
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 8bff16d..b68faff 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -362,8 +362,8 @@ static void macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "macfb-ctrl",
-                          0x1000);
+    memory_region_init_io(&s->mem_ctrl, OBJECT(dev), &macfb_ctrl_ops, s,
+                          "macfb-ctrl", 0x1000);
 
     memory_region_init_ram_nomigrate(&s->mem_vram, OBJECT(s), "macfb-vram",
                                      MACFB_VRAM_SIZE, errp);
-- 
1.8.3.1




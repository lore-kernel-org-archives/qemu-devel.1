Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D71C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AD220726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdFekw0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AD220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54555 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZbL-0002jH-OL
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0R-0003si-GT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0O-0003eN-HP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:07 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0O-0003dy-Aq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:04 -0500
Received: by mail-wm1-x32b.google.com with SMTP id t79so1238133wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z8uveG+GzablkLGqKhKJxoWtKhLXhYYzRPcHZNEZWGM=;
 b=jdFekw0PQfaAR7FgWsCFeNR6thQiHbqV8H8+ZOt8fDoGoQhkfq+goeTEY1gcn3TOAU
 CfUiCfJtUsi7RrJ6/Qw5t2ZFRPMmzC/Yu4Dikj+W4zgsYYG9LenN5kggsBFgI7IHJBeP
 +4xr6ygbOh1IWOm2awmC1ckVR6AQU8vyDC0E4ycE6vG1M0HyXtW2+iJys87j/S2tlZmm
 rD8eVJ11G5l6X/byQ926mEb+5LBD/cXqr5jN3aN8z3QWseqFjfkMA+Q53OBpKWm2mBm3
 5XLqD2VhyAqlxbfdyO0qkelC2K9HgOuaDAKaNkNkidW2c71JntnrVmJnT7Tqkrd7D88B
 jAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Z8uveG+GzablkLGqKhKJxoWtKhLXhYYzRPcHZNEZWGM=;
 b=J/SyKxe1xH/l+nOVluXIVP2k1mJUGoGNzr30AqAkgbPfLoD4homTcguVpOh8igYxk9
 G+OCv+g3WEn/RGAM8aMBypD9mjZ6Y26sD9PU108EGi3QV/YSgAJywATXRtULJtG/mrKr
 FkGqFF+fMQxOoMBVXnjZema6KzCDrcU+JLKY1nlcOESRw3kr9RUPizKZrAc8xRnBshpV
 Fvj94f9vSRd6nwOSO099wHYSdI3aa7KFFGY8HkSfK4OOnP6tTFl1+q8QxUouYY5l9yft
 s5RALKI6TbjdmWcae2GosBJZKme1CSL8gNNvFfXZeguOrPc4SV7U92Jiuftu8WZGmF8J
 qlFg==
X-Gm-Message-State: APjAAAUWhndzOsdk4OI9+ueq0TzAZ+kIH0Y3xXRzQjkUPca4U3psyj0n
 RHvaR1Lpw75AVhgii8B64n/1Evqh
X-Google-Smtp-Source: APXvYqxJZ4f8SmFyDihGaWJ9/9CHjKOy2/inGj8+wnbCJPjU25B1yaznpGc5Vr3bRyXz/mxqoJ337A==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr4966125wma.5.1582632482973; 
 Tue, 25 Feb 2020 04:08:02 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 130/136] hw/block/onenand: Let devices own the MemoryRegion
 they create
Date: Tue, 25 Feb 2020 13:07:28 +0100
Message-Id: <1582632454-16491-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

Note this change break the migration of the nSeries machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-33-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/block/onenand.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 898ac56..f49db0b 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -173,8 +173,8 @@ static int onenand_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_onenand = {
     .name = "onenand",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .pre_save = onenand_pre_save,
     .post_load = onenand_post_load,
     .fields = (VMStateField[]) {
@@ -809,9 +809,8 @@ static void onenand_realize(DeviceState *dev, Error **errp)
     }
     s->otp = memset(g_malloc((64 + 2) << PAGE_SHIFT),
                     0xff, (64 + 2) << PAGE_SHIFT);
-    memory_region_init_ram_nomigrate(&s->ram, OBJECT(s), "onenand.ram",
+    memory_region_init_ram(&s->ram, OBJECT(s), "onenand.ram",
                            0xc000 << s->shift, &error_fatal);
-    vmstate_register_ram_global(&s->ram);
     ram = memory_region_get_ram_ptr(&s->ram);
     s->boot[0] = ram + (0x0000 << s->shift);
     s->boot[1] = ram + (0x8000 << s->shift);
-- 
1.8.3.1




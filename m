Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E88CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136CA21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzUZnxk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136CA21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuwE-0004X9-LG
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHq-0003Zu-C5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHo-0001hT-3x
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHm-0001fQ-UG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id q13so7253560wmj.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZwNW00oas6mcry2/k1wb4Dsg08MtsQnh0O8QmW/x2tI=;
 b=JzUZnxk2KnZ2IeEX86dyIe0gWMAQvqB6rnrDgzV1zSck1Sep4ogcgOZu8y6J0pzjwC
 q+n1b6+UJ8um8HWLrB5vLo+/F+zhzRcPr+FnLUuT2lMAkhNhvytHFpMuK3sQdiJ6ZIdV
 TaLqYU/UzrgkNXMHUjEKAkYQwEEMxj2T3tG0iTZXDfI3w2tiHHkab1DYn8ct+rMwvxoA
 ZYW41wEl2Ad7kLPdJq9B8lqODgy/A17lHHghZPF1KCXMrdvTuLFDoTfWM2sGHB2mHRRZ
 vk4o+AC+Bdyqi8r5KHcQcViA/o1MhY8mmMEqCPs/JX5WFg0ww9W/QgC7QI0TWWFfvx6G
 ZbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwNW00oas6mcry2/k1wb4Dsg08MtsQnh0O8QmW/x2tI=;
 b=AYT431qqFQSbJLjjIPSCGj18SJqX8GU1QvjZFb3ULKJyWMV7wxvsafphRo/U/1tkNb
 XmVVAEdi97SH4mL3GZbmRZkBv7SRGHi1xyJUcKoDhbs9Ak+zaMqmGVhJpTiZngNxF6Br
 PuHifP6KReoog+PK3LfU/skdTzQ/HzhDQk1vswbrqhz50AjxPtGNPnZa4UEC5asEhB4u
 zFKPknkurDh5KzxtTZxzkZO0q0//etpn3GUKpVZ203p3/0FqKhCy3BZN7a1G2Kn53bUM
 gnCLcO99n7cpwa1wWn/3xBV8KQTn7xxCjDLfz7xoTSS4DevdWb6+sn7xNTlv00n6mNv+
 btWA==
X-Gm-Message-State: APjAAAUtNi/t20yEM/W5gQfZckEMsIgcmaL6hJAMX9rWeCP3WByQxRb4
 yhsxbRvbGsHjUMl9+bt1XCKiqDcJe3Y=
X-Google-Smtp-Source: APXvYqzSv9UPNIDfIfqTaQUTPSd65pOXNkkiTllvTpuE8attUvYF492vEIxZX+TOQaE92TD43LGymg==
X-Received: by 2002:a7b:c924:: with SMTP id h4mr3211922wml.46.1571751190844;
 Tue, 22 Oct 2019 06:33:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.33.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:33:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/41] hw/arm/digic4: Inline digic4_board_setup_ram() function
Date: Tue, 22 Oct 2019 14:31:34 +0100
Message-Id: <20191022133134.14487-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Having the RAM creation code in a separate function is not
very helpful. Move this code directly inside the board_init()
function, this will later allow the board to have the QOM
ownership of the RAM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191021190653.9511-7-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/digic_boards.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 304e4d1a294..ef3fc2b6a5f 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -53,12 +53,6 @@ typedef struct DigicBoard {
     const char *rom1_def_filename;
 } DigicBoard;
 
-static void digic4_board_setup_ram(DigicBoardState *s, hwaddr ram_size)
-{
-    memory_region_allocate_system_memory(&s->ram, NULL, "ram", ram_size);
-    memory_region_add_subregion(get_system_memory(), 0, &s->ram);
-}
-
 static void digic4_board_init(DigicBoard *board)
 {
     Error *err = NULL;
@@ -72,7 +66,8 @@ static void digic4_board_init(DigicBoard *board)
         exit(1);
     }
 
-    digic4_board_setup_ram(s, board->ram_size);
+    memory_region_allocate_system_memory(&s->ram, NULL, "ram", board->ram_size);
+    memory_region_add_subregion(get_system_memory(), 0, &s->ram);
 
     if (board->add_rom0) {
         board->add_rom0(s, DIGIC4_ROM0_BASE, board->rom0_def_filename);
-- 
2.20.1



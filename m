Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A1C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C3C20721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjhWLuq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C3C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBrI-0006ZA-SY
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVBpo-0004eU-VJ
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:26:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:33809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVBpm-0000A5-FA
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:26:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id s10so5616179plr.1
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ag+hcUiFPULNj9KU2KM3Lt10lyM2QWt6bEtScV/STh4=;
 b=jjhWLuq40I5TZiRF/aV8S/XqNArixtxvnog9toZLv4hWlUe5mBqUP9x2vIOxfidqso
 kknc/ipiuZed6hRBT2CsApMZ9iJAgWL/eFq8qfq7QbmH7lOw2fHl6maK/NT7keJ6ORAf
 VCkkG9yNvlQBSidVbJEFh2ofzSMkJqpTTmLFBCc7Mj5PR+FWACf+ditTdUqtEWSIRTUn
 gobr6bD5YAkowiXUqm/EBw0xzwNb2oWmDZ2jrWFc7B4V9hNPAcVtZ0+1wz9M24dlMZ7f
 xbTZYVcLIY45192l4MZh8UGF5IfZjgm9zxwxTgjOiKw1Mp1zdALNEU+gD9kha6c2dsi8
 1rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ag+hcUiFPULNj9KU2KM3Lt10lyM2QWt6bEtScV/STh4=;
 b=LPv6r3eMXSsJDNDNaKsFcVf+sWlIyEJ5fmkVxpPuTPSa+1gDQSu3MvI0zQycLhc43Y
 lnZG8FmgUBY7e1ko5MI2OebFaXYX4iqIgyut6TlgO1eK2MvA/oaZt8u3HEWamYis8h4Q
 7/4gajkRCZ/3uX2XgJJIKC+C3dpizz/2mkiKoyV+mFn0N1VrQJVqZvR/aNksUJ59kawf
 0pwWpvEi18fvEhAZGH8xGy1OoGL8BPgV9+PzWwbnXHF37KVZBU/tOzt3tgP8lNzE4F4h
 uTWJUZB34fy6hIfGSDyfsidfVngjVv402RLUksHgw7NQ3lhdqB+ZsRvJSvyODJ+Q7ABy
 FODw==
X-Gm-Message-State: AGi0PuZlH53qA8WBPbPREx0r8lQJG+GQDa261GRyz+9BCXa4ZEkzffJX
 okOkppMIQg7PRDEwE1VvIlY=
X-Google-Smtp-Source: APiQypKF2MOh8Uds/2OHmZ8SdWBi2HPk9YxcX1At263/FFSPYdyly2ZmDhGlqdh0IPeb+yI0we5HMQ==
X-Received: by 2002:a17:90a:4802:: with SMTP id
 a2mr11344640pjh.66.1588501612849; 
 Sun, 03 May 2020 03:26:52 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a12sm6173654pfr.28.2020.05.03.03.26.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:26:52 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V3 7/7] MAINTAINERS: Add myself as Loongson-3
 maintainer
Date: Sun,  3 May 2020 18:20:21 +0800
Message-Id: <1588501221-1205-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc3d1b0..8d5cfec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1084,6 +1084,11 @@ F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
+Loongson-3
+M: Huacai Chen <chenhc@lemote.com>
+S: Maintained
+F: hw/mips/mips_loongson3.c
+
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
-- 
2.7.0



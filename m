Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F1AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B32620706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqU/VyqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B32620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrw5-00020y-Lw
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlruP-0000F1-DT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:36:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlruL-0007rk-Ho
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592476589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1gC572k9fhdlWp9MbBYjomRgv7c+OAs7btqeZH+cLZ4=;
 b=iqU/VyqOJKYaAwu5BpC4ft1eofEqRvg0N+orDrf9xPnqL0HYfFa6lgZThXl7WmClF+ddrU
 THk281qUps8YROl2wO5P9GcZH1mAJJ615UAFuIFGlL9zt9nCaj6XTH0FhxXs3Y9ub2nKjc
 moFMklWCo96Hcz76jiVat/1amJpYZMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-d5qyOSmDPQOH5hC2mPKNqw-1; Thu, 18 Jun 2020 06:36:27 -0400
X-MC-Unique: d5qyOSmDPQOH5hC2mPKNqw-1
Received: by mail-wr1-f71.google.com with SMTP id o25so765272wro.16
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1gC572k9fhdlWp9MbBYjomRgv7c+OAs7btqeZH+cLZ4=;
 b=VKTiVtsGRapOKfjMbYFd25APs8uctUaK2m70PgPSY8lOmuXRY9dTbXeYZXVx3sB072
 3K6t6cQnrLZW2XzKBNl6uTvWgjsDRWCgvrAk0pOog2OHcJVJSSoUoQy8s4c8acKVdtdl
 DCiyPs/EpFsCAn2gKYWwrb/JUZnIsTEdNjZnSNWI0jJO+UD64y5iEnYSRfYUmTGxgplD
 YRyD4rYvwvBIm/VyCSXJPlU0nJamBVX//d+nTERxCGALdref6xplXTOrNI0TBlPSyufV
 8PrLww73dO7UwhcZEM8v93JbD2e8+BQGTGIkH62FnPIIV2IvqPb0wkvEAwBfCoKRzB/Q
 OzRQ==
X-Gm-Message-State: AOAM533WHdXuHzG3cn8oI1Kn5B+MMI9A8eU5AAEsofQ5N06fYN2fJXuJ
 1UlkIlwTeymwD0oUtbHVspFme6zQs6MqhkuotQjrFrYpSNFmHTWTbqhBv8StG+2w5JivzywFfAM
 y7wGtNjdgE9hwfxY=
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr3235630wmg.17.1592476585749; 
 Thu, 18 Jun 2020 03:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLq8NrYfomof6GNIyl7N4FnVV5wk1jrDUS6tcc1KijTO/Mnn8cRophOCKydJDC0eYRE2u0wQ==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr3235606wmg.17.1592476585475; 
 Thu, 18 Jun 2020 03:36:25 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id u13sm2881429wmm.6.2020.06.18.03.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 03:36:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/audio/gus: Fix registers 32-bit access
Date: Thu, 18 Jun 2020 12:36:23 +0200
Message-Id: <20200618103623.6031-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 qemu-stable@nongnu.org, Allan Peramaki <aperamak@pp1.inet.fi>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Allan Peramaki <aperamak@pp1.inet.fi>

Fix audio on software that accesses DRAM above 64k via register
peek/poke and some cases when more than 16 voices are used.

Cc: qemu-stable@nongnu.org
Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
Tested-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200615201757.16868-1-aperamak@pp1.inet.fi>
[PMD: Removed unrelated style changes]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Supersedes: <20200615201757.16868-1-aperamak@pp1.inet.fi>
Since v1: Removed unrelated style changes
---
 hw/audio/gusemu_hal.c   | 2 +-
 hw/audio/gusemu_mixer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index ae40ca341c..5b9a14ee21 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -32,7 +32,7 @@
 
 #define GUSregb(position) (*            (gusptr+(position)))
 #define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))
 
 /* size given in bytes */
 unsigned int gus_read(GUSEmuState * state, int port, int size)
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 00b9861b92..56300de77e 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -28,7 +28,7 @@
 
 #define GUSregb(position)  (*            (gusptr+(position)))
 #define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
 
 #define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
 
-- 
2.21.3



Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA0DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7784A208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdxxxNSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkKw-0008IC-Ks
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGi-0001UD-Sx
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGg-0007Z0-VG
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ORhV1sd4nU6DWHF34s88hmmcxuNYxVDeCG6mbf27fE=;
 b=PdxxxNSjW+X5GSf+ZRYLkeBTC+K3lufMSY7VUcnM3NA/4o65E1ESbePtGGQFeHZKgYe22A
 4WUNB/sdTbzJyR/5ceQzl+gQkBuKLpO4XUFowAzbAiybUYPvXlV4EspgrVRf2uQDj44MJu
 LP+B8STb+qqqmq0pzwHWciJlbrptI94=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Bsp1_4KzN02dOZ1cQ70xGA-1; Sat, 04 Jul 2020 11:39:51 -0400
X-MC-Unique: Bsp1_4KzN02dOZ1cQ70xGA-1
Received: by mail-wm1-f72.google.com with SMTP id t18so39726021wmj.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ORhV1sd4nU6DWHF34s88hmmcxuNYxVDeCG6mbf27fE=;
 b=nVFbYRw6KrpUpUGNpX2dsWqqNWBj1npBcqnSrp4l+WYHXGTvjzx1Ct3aE64LahMgRb
 JJ8NXWVrUi7UqkxU7wBjNTMgMPG0brGMJYbMPcKTcffiRibTDumfFhp6eOAECuhJHSYe
 MQaW4UU3Xw52nPq2sTtjVX2xxPAuJSOGRL/a5mmfwSmVjeWxvem7cv38qUXqkg0tQ9K+
 8f1e++pGnrJZq9MRKfPI875WumRjSEpOkZgVZ3BlxKJzFSKhgf1/gt3/578Bh7ZCHSqY
 5OEOnqT+rErB2c16Vaqlm/5ZAbEL9TAVxpuW6TDtTTPn8EVd/ZWW7GXBuG964KiOlBdV
 dK3Q==
X-Gm-Message-State: AOAM532KKMya/ezcj2oNS5rKfXDk71xx3rbncLw2oustVVC04cTSWSwA
 k+t9XsNRfnrFCe/cGxDXtNEWn/m/GGRjscBjd6FfUfCgqioj6LUBQqm391tWEkPmEKspR7Ieqg8
 chCxxHp/E/UZu8VY=
X-Received: by 2002:adf:e74e:: with SMTP id c14mr43648131wrn.143.1593877190109; 
 Sat, 04 Jul 2020 08:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjnfcSH3EG5UKTwABJ/4LKUdBUBcDeNizmIjl25mkK7GKnfOC2qP/XZGKJMftsfGb2dy4yLA==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr43648104wrn.143.1593877189914; 
 Sat, 04 Jul 2020 08:39:49 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f16sm16575426wmf.17.2020.07.04.08.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:39:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 07/23] hw/display/blizzard: Emit warning when old code
 is used
Date: Sat,  4 Jul 2020 17:38:52 +0200
Message-Id: <20200704153908.12118-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/blizzard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 105241577d..74557b152b 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -23,6 +23,7 @@
 #include "ui/console.h"
 #include "hw/display/blizzard.h"
 #include "ui/pixel_ops.h"
+#include "hw/qdev-deprecated.h"
 
 typedef void (*blizzard_fn_t)(uint8_t *, const uint8_t *, unsigned int);
 
@@ -1010,6 +1011,8 @@ void *s1d13745_init(qemu_irq gpio_int)
     BlizzardState *s = (BlizzardState *) g_malloc0(sizeof(*s));
     DisplaySurface *surface;
 
+    qdev_warn_deprecated_function_used();
+
     s->fb = g_malloc(0x180000);
 
     s->con = graphic_console_init(NULL, 0, &blizzard_ops, s);
-- 
2.21.3



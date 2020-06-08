Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1A12076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6LQ3rgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1A12076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKT1-0002lG-HK
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDr-0006Zk-NZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24390
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDq-0007nR-Gh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHbfMTMnP0pPoIUOMaNBIF3qcn8JPSW/pdevUa2NjDA=;
 b=h6LQ3rgftXK74UFOcbctEct2xp5FNtSv/KnVUtVSEGcvV5XNl2Y6Q6CYbdTXRookAQqCj+
 3LGLtSZgfyBntliMakhrX2I+P1b3+adr+HeRc2QF1kdYfin3lsOMczbFk6kIhqLepvCRDX
 ygEqM83SjI9i9UKYhVmzwWNid7+2SLU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-9mLKbO7oPKmiHd33ImqHBg-1; Mon, 08 Jun 2020 12:01:56 -0400
X-MC-Unique: 9mLKbO7oPKmiHd33ImqHBg-1
Received: by mail-wm1-f72.google.com with SMTP id a7so10823wmf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uHbfMTMnP0pPoIUOMaNBIF3qcn8JPSW/pdevUa2NjDA=;
 b=nLngPK9DLgWiRNGv/qJUlVld6Z3WHLShNpyWVBAu4Bohg6oZUZ7HEwmdC+id5msQFQ
 HFrT9rkBGkF61QRALiZJhvzU5f1SRngnJgukXxis+M8EpI6a08gAhODvkwickklrn4tL
 xeUSqT1qxgsVyzTmVBFr5y90Yy8TjcJwmR3YUL1KdpZMI/PmUX3slyEL7v+mXSXNj9KV
 ANO8KKM6UhpZ3DwXdidBXRPLlB/uDaXpiVL7l/TuBmkJ4zGINTXSKJZV0BmcadK0UIP5
 +znGUBYcHz3AEw25KNyhZ9yNWF30agUdqWEpWtdNSQqMg7G0qmHzR1ywSM5a34xCV6kA
 h90Q==
X-Gm-Message-State: AOAM532icxvRYcwkkkt1l766mGEhWOmbtcm1u67t65N3dHoqtO4LDdx9
 dEGqWkAa9/fJc23FbUL4Ekha6fzXHVrbWvPyFYx6wzoEjrZopIfApbYNNwk2H7rGNlhs8e6moHg
 xu0c1/7mMJssiF5E=
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr23864567wrx.215.1591632114952; 
 Mon, 08 Jun 2020 09:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjnqOGBWofUhF/g/CPg0SMkJ8njA1iKr2pcTJ7xpwajdAOHpMg7tlHe1H6wlLAySWDO/5VvQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr23864524wrx.215.1591632114766; 
 Mon, 08 Jun 2020 09:01:54 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y17sm194731wrn.12.2020.06.08.09.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/35] hw/dma/etraxfs_dma: Emit warning when old code is
 used
Date: Mon,  8 Jun 2020 18:00:21 +0200
Message-Id: <20200608160044.15531-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/dma/etraxfs_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index c4334e87bf..d2f7e7ca9d 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
-
+#include "hw/qdev-deprecated.h"
 #include "hw/cris/etraxfs_dma.h"
 
 #define D(x)
@@ -765,6 +765,8 @@ void *etraxfs_dmac_init(hwaddr base, int nr_channels)
 {
 	struct fs_dma_ctrl *ctrl = NULL;
 
+    qdev_warn_deprecated_function_used();
+
 	ctrl = g_malloc0(sizeof *ctrl);
 
         ctrl->bh = qemu_bh_new(DMA_run, ctrl);
-- 
2.21.3



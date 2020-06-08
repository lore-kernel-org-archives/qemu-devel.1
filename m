Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E678C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090982053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOYOLjUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090982053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKi4-000053-8O
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFX-0007jW-Qw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFX-0008DQ-5r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kyMhVQ9HQhJiyo6QGAHK03lmBlbuIzucxY+SHtzpks=;
 b=gOYOLjUa3SErlNwXKlU2eDT1PAPgwl56xFbNvTRv1I+orIWRKljvuZIHlyKYUO3X8I+VnW
 ZH9iIDPjakh67DKxqGNUmOotSSVu2eamUItw4Apf3m72m65Vc7w3Eq2e63AJOejSWJQH8z
 a4rRuj2/dpj4UfSpz/DQndVeQ3ze48g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-8-7jhM6WOWiutoWhKU_Kgw-1; Mon, 08 Jun 2020 12:03:43 -0400
X-MC-Unique: 8-7jhM6WOWiutoWhKU_Kgw-1
Received: by mail-wm1-f72.google.com with SMTP id b65so9510wmb.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7kyMhVQ9HQhJiyo6QGAHK03lmBlbuIzucxY+SHtzpks=;
 b=LW2XBJRAgWM/VJx+WyXtN5NUdzZ8pbASEcdE7IJZr/hh66xfMNmyXflSWGqthujGQK
 8FD2IoFL7cDEKi6hVxJdhOxjkGFtEr1mR8IYmnpEsbWPfO7oIYFTE0w9sHMOOFLRqlZ2
 pF8gcFgucfGRqU3Jz0mCBSl9upqHlo22Wq1sY2UhMhozdHLL670TyHqzQOL5BGD6CSd3
 b6IMx9QrDp+0ASmtlz4jirm3aVlFguaz4o/ZsOCXB2M/lXalDT30AnwIvKonmP5VNHfa
 IJsUjBcBMGxRK0gkj2fjd3ooX7TFee9FBwr9RkrLj17gBp4ZmOuH+ZhcDkZbfy2dPlYZ
 pUQQ==
X-Gm-Message-State: AOAM530bPxbtfOsSWg/nmnyVr7nbDXc8KZqnggpO3jDgZLu4gYhY3pBD
 LEb112N4r12hpvyu3HNOOYwSN9c8WdjJPGxvfCYMySHLujdj5tmeo6vEKwTTUa3F/xVmxpO25Gi
 Pj8i5Pb/PLuJtZyQ=
X-Received: by 2002:a5d:6087:: with SMTP id w7mr26621425wrt.158.1591632221507; 
 Mon, 08 Jun 2020 09:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEzYn7IfaprZ27/xV2VCZHXx76WBbSnolmOS6yBDnvZe3b82K5DvPVvnhVs7yLdMTrFxNPeQ==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr26621373wrt.158.1591632221329; 
 Mon, 08 Jun 2020 09:03:41 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o82sm8088wmo.40.2020.06.08.09.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:03:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 30/35] hw/ppc/virtex_ml507: Emit warning when old code is
 used
Date: Mon,  8 Jun 2020 18:00:39 +0200
Message-Id: <20200608160044.15531-31-philmd@redhat.com>
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
 hw/ppc/virtex_ml507.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 0dacfcd236..17b8036c38 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -40,7 +40,7 @@
 #include "qemu/log.h"
 #include "qemu/option.h"
 #include "exec/address-spaces.h"
-
+#include "hw/qdev-deprecated.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/qdev-properties.h"
@@ -95,6 +95,8 @@ static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
     CPUPPCState *env;
     qemu_irq *irqs;
 
+    qdev_warn_deprecated_function_used();
+
     cpu = POWERPC_CPU(cpu_create(cpu_type));
     env = &cpu->env;
 
-- 
2.21.3



Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F8F2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKIs+Ujf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F8F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKJe-0004Xb-45
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDK-0006AS-Tk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29488
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDK-0007gE-1P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJCGR9/510Qhv58TRWbd4o5i6q1ayDSJg7ikac3wKxM=;
 b=VKIs+UjfJm3kRNg9BA9niRSVHPEdIKa1+bwnKW5BjyDTboaKQ42ea+2FgNs020KzZVXf9w
 Btmz5toYaTDlsfFuIC6PqI0UF52hqtlKgeMm5e43dsG6b9cZKuO8VfsMBjSHeBY949MRb0
 +ZT1zZQ+NbCZvbv2a3d6+oX/YnYs02Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-RSy3lLSiMqG56FXJb_XKvw-1; Mon, 08 Jun 2020 12:01:22 -0400
X-MC-Unique: RSy3lLSiMqG56FXJb_XKvw-1
Received: by mail-wr1-f69.google.com with SMTP id a4so7337980wrp.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NJCGR9/510Qhv58TRWbd4o5i6q1ayDSJg7ikac3wKxM=;
 b=eoIpPl/755+305v+Jrl/2o7sy3eqL06002he4Bm4ERdvq+0RqCnx9gf7x5uB36DjdP
 +KQniuCaLkU7laHOpjeY/oD/lw6bPjP/w8i0qdiinLM7XGUSTAaarThAWOhxgpOfGkpz
 sDDnOXMVfSle6QcatzZne4xRGBTD8rQdwSuJS3QYXdGsj+fhLrbVQi4hgSx5HdG/G/tz
 ChrA8M4Mtt4ahtMiNACs6dzoMhGwds6OcQGs/J5+iRlWL5MMkpT4kayKjZFqz+kTVsWB
 xDap3Bt5ms0QcN+h7m1TzgljY1IMJ40XvsWA/bQudOMy8aIi2FY6yyUA9gSRj/cuX6s8
 OpOg==
X-Gm-Message-State: AOAM530xdZDlxZVSCc1ofhRsg0RtSOJBz+3nHwKHPoGExEAkzfRV8rDG
 sxGlFNgMapMqB/jAFr/9aIp7HNTV5pE3Geaq/9jbw3zsLEfCJQVhX01Rm2Zpf1H2GJAHuwR4Og3
 aP1Evd2V5MDJ+Vfo=
X-Received: by 2002:a1c:6884:: with SMTP id d126mr21811wmc.121.1591632081534; 
 Mon, 08 Jun 2020 09:01:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOzP/TSo/GdCDA4q3fBC5fMN7fhQwZz7nfPzYVtVlA4zhoIpThGRIoQT2iemjQz07LOwJssw==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr21765wmc.121.1591632081336; 
 Mon, 08 Jun 2020 09:01:21 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id g25sm25750wmh.18.2020.06.08.09.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 06/35] hw/timer/arm_timer: Emit warning when old code is
 used
Date: Mon,  8 Jun 2020 18:00:15 +0200
Message-Id: <20200608160044.15531-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/timer/arm_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 9607366d78..e23e6b4b31 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -16,6 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "hw/qdev-deprecated.h"
 
 /* Common timer implementation.  */
 
@@ -175,6 +176,8 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
 {
     arm_timer_state *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
     s->freq = freq;
     s->control = TIMER_CTRL_IE;
-- 
2.21.3



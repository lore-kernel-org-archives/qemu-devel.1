Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773E3206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf5ZFLPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773E3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKYj-0001bl-Mw
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKF2-0007Nv-Aa
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKF0-00088N-6V
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGDaAMWSjpprqA7Io3dm7QCtlFgafERZCyah8ISMES0=;
 b=bf5ZFLPDxjE6uiQntaPwYH/JDEJnO2OnpzJmRieVnXA5g817BBjWqKROH+Ubd6CUCgp6eC
 u3T0y4xfwQmFNhEmDf4Jf0uyNvwIgZEtAMvNzLRfBi5UDLrMJbjmSMsnHUHCdCpI+WzQ/Q
 nOeO5+ilEZkg0lXck7CJioQbHk450e4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-KrLVzbA5MzuLBYdWGxBEOg-1; Mon, 08 Jun 2020 12:03:01 -0400
X-MC-Unique: KrLVzbA5MzuLBYdWGxBEOg-1
Received: by mail-wm1-f70.google.com with SMTP id b65so8804wmb.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bGDaAMWSjpprqA7Io3dm7QCtlFgafERZCyah8ISMES0=;
 b=itrBYCdCX4TjJk8OTqHi/blsWG9wqbNEoieGT9A/Gcu5Ev0AnOzBsL1g0Q2fK/Nutr
 AQmp3EApRGFZZ5cxilCpGu9gEcfkdJLecrXyYPSIMo9JglNONAG+wB2xdQsdy5fFHyan
 qUHqKyfeNvQlCkCmagSEO/M2PxGPspFzkojxyHVU7SSgloxr3kub01dPak4J++EoC9SL
 g2LbJE+10kz0X3rkoySDSVKy4X/GDi8ZqyS9YWG67JhSkFRDY1TTbGT+0LRpHtCxusIJ
 W0Zk8vRnkfFODEJ9OtCWNVvrjzkE6vr01QpvmKzj3hUwKiGtnXKFf1ZbJVCClmttqzzw
 Dsqg==
X-Gm-Message-State: AOAM53150tBbMpVnUojbF3MLJSY1hzveDbE2uXz0P6QJu96g8AfdVKBM
 lUeXO1aae1ltuGbA4tYhBrYzksN/EPOK/MCJUOcPjDbaNVJAh6vIBHs/eBILSqH9dzOfZeuWEk5
 /krR4AwLPlg1Awlw=
X-Received: by 2002:a7b:c201:: with SMTP id x1mr78854wmi.58.1591632180062;
 Mon, 08 Jun 2020 09:03:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5+TIjMo5Pv/JZUc9oRpRqa5yr/ufMOXB39AL2QL+RAu+P6Qy6euM0Zs2QNe7FGM5NNcPJw==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr78842wmi.58.1591632179907;
 Mon, 08 Jun 2020 09:02:59 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q1sm34631wmc.12.2020.06.08.09.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 23/35] hw/misc/applesmc: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:32 +0200
Message-Id: <20200608160044.15531-24-philmd@redhat.com>
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
 hw/misc/applesmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 1c4addb201..d63f19038d 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -36,6 +36,7 @@
 #include "ui/console.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "hw/qdev-deprecated.h"
 
 /* #define DEBUG_SMC */
 
@@ -253,6 +254,8 @@ static void applesmc_add_key(AppleSMCState *s, const char *key,
 {
     struct AppleSMCData *def;
 
+    qdev_warn_deprecated_function_used();
+
     def = g_malloc0(sizeof(struct AppleSMCData));
     def->key = key;
     def->len = len;
-- 
2.21.3



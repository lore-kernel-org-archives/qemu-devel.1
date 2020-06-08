Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC61C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098472063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuLTfay+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098472063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKLa-0008Lo-67
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDM-0006BW-Oh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDK-0007gU-OI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P++PpnzVmXXtn3Xqf4XIHbmL4uqsh2R3Dd1pfn2k/GY=;
 b=KuLTfay+BjUA9tm25il0dVm1obY2X+WoFOeRz4dL/tw/N+nLrrfdHiWh0+RHp5r+xgIJIt
 zdtGAp8UaVSWVevhmHB3N3V21ASJGWIo2xTXpmmGljkthpWIra3S/Wvh34rygklxtq2hS3
 MmbgampXCMaaOT/W60SmlaHJTIwg9HY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-Ra9YO6-CPda8hilkVXDkaw-1; Mon, 08 Jun 2020 12:01:28 -0400
X-MC-Unique: Ra9YO6-CPda8hilkVXDkaw-1
Received: by mail-wr1-f72.google.com with SMTP id l18so7395750wrm.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P++PpnzVmXXtn3Xqf4XIHbmL4uqsh2R3Dd1pfn2k/GY=;
 b=IAjNr0lSOOA3hs4Ek1UKHqcaXUml7/xOmq5RYWKLJXdqRpChE+2YyIJkeJuH9OPKlr
 G/R5oxqNntJ469a9lvJ1lxJmfe97yRNfAXKbv+xE9K2DlfWyJ8ekpeuk9mGSH9mS+Mmx
 gFWsCPPYrA3FIfasoyTWoFhOlUaI/Ygm7XKstlf66IeCb22ibsfHtWnfIwzcj4MNHJNU
 wiGfDy5/FzKDv5Nj73dLpS5F74Gaq9KHG7ls4S/PKhhiofbCQfnZqb1NZ859epYtbkqn
 D1QOy2In3GVLXy36EsJ1WbfGLfkvfXAFjOTRJByGMC2snR5zuvGmAEBFXiUfurUp7reZ
 f4+Q==
X-Gm-Message-State: AOAM531as60Nj6cuPFXkW3R+pbXuWQf+8IoA1YUNYQ5U/+PTrlvA2RQC
 JRAiv/vCf62kFirXbaK5E2jdFRfDR7b2d1FQHnnUGVSYWNHM8Qd+CJP19P+KshjnF9cQx0AABhh
 BSvr+Alg01qEImYw=
X-Received: by 2002:a1c:f007:: with SMTP id a7mr27131wmb.103.1591632087257;
 Mon, 08 Jun 2020 09:01:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi6QGEqKJNT1xfJrXVN1hFb5ZVsGqmEk2sV/P9tBTDLMUlN7hRgEWpk7m+66ilMFrnYarGkA==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr27088wmb.103.1591632086930;
 Mon, 08 Jun 2020 09:01:26 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o9sm7066wmh.37.2020.06.08.09.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/35] hw/char/parallel: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:16 +0200
Message-Id: <20200608160044.15531-8-philmd@redhat.com>
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
 hw/char/parallel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8dd67d1375..0ee577d420 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -35,6 +35,7 @@
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
+#include "hw/qdev-deprecated.h"
 #include "trace.h"
 
 //#define DEBUG_PARALLEL
@@ -601,6 +602,8 @@ bool parallel_mm_init(MemoryRegion *address_space,
 {
     ParallelState *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_malloc0(sizeof(ParallelState));
     s->irq = irq;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
-- 
2.21.3



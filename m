Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336D1206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrH1ySDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336D1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKV8-0005D1-8t
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEW-00070B-2G
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEU-0007u1-Ek
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WzkinKDRWpQmIIO97X+MugaJnDZKw0ffp1ti6/ctwc=;
 b=OrH1ySDQhciBHAMMlCFm4kH3NnMfKOW6Rrsn+MN8vBqGsSCBE9D5Rkubnl8cVNVI+pYciS
 PxSH95EG9F0aP/B8p0tSKjDwShOa6YG4edWj4FIUZmvz4E+UY6QyiCmmfgXVYaLrJT9ZLo
 h/Lf5yhDu7Lgg0/6i4onVc9OIEbQVz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-sdsWZHBdMmmnuQP3QvT9IQ-1; Mon, 08 Jun 2020 12:02:37 -0400
X-MC-Unique: sdsWZHBdMmmnuQP3QvT9IQ-1
Received: by mail-wm1-f69.google.com with SMTP id s15so5329wmc.8
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3WzkinKDRWpQmIIO97X+MugaJnDZKw0ffp1ti6/ctwc=;
 b=PA0/7P3+tSaSuZuZvO0T5OfHYg8LtA2vE1NyjtuTn8n9dOoqRbwJRrCyjmYRUcflS9
 ShU2EDdY7MSoJsuBrGIyzYibF75V2cK3Ykc89mKBNfIA76EI+XwQAu6PCe/aY/uMpkIc
 dvsRHssu5pWqRQ7U6Dw9EYh7fIk7eF34vuuWOenHSn2EAnKZnpWyE2zLKd2DVGmffIma
 6dpLwLiJOWC+3PfbKK/YpCfR9LHmnQiWpyNVwBQqdNetyijOAXjRa7215e6TQKTQIyfV
 1yWq1Fbjthp/JMlW8ywDOc9p6R8LCZijB7ZPzC6gcGe+sgNq3asVr6o7i3GlF7lFcHdB
 /56g==
X-Gm-Message-State: AOAM5300/W9Dd//L39iVBMQ9LF186MTVfK82LfrPHUFPasj/6yicwmQ+
 IsaDDDpvGc6fRm/4zxq1WiH3bt7NCTQf0oRQwu2jxFrmbsSjW0+1f2u9yVg1eln8i+KaX+Q7jdU
 Gw8DZxe8+YDxYIq0=
X-Received: by 2002:a5d:6391:: with SMTP id p17mr25853422wru.118.1591632155838; 
 Mon, 08 Jun 2020 09:02:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDmwNfyaecxfbcj81e+/jUBcU6vumJ01a4QLGsVfaCgs3E8cqqhTSmTr88Achkag+c/jFzSw==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr25853379wru.118.1591632155624; 
 Mon, 08 Jun 2020 09:02:35 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o10sm183753wrj.37.2020.06.08.09.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 19/35] hw/input/tsc2005: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:28 +0200
Message-Id: <20200608160044.15531-20-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/input/tsc2005.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 55d61cc843..1f97b82379 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "hw/qdev-deprecated.h"
 
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
 
@@ -489,6 +490,8 @@ void *tsc2005_init(qemu_irq pintdav)
 {
     TSC2005State *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = (TSC2005State *)
             g_malloc0(sizeof(TSC2005State));
     s->x = 400;
-- 
2.21.3



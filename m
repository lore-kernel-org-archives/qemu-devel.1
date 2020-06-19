Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26043C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADD320DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH8YTxvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADD320DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGy5-0007ra-5y
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu3-0001wP-9g
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu1-00038C-Hq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592572672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADLGoijcriWal76g9pZL90rjMe6sgPfFLAkeGhj1ZKQ=;
 b=IH8YTxvFPFHxF+UophBmN8S4diW4frojBJAZRR/WIZurAaUdb5GQiNWoCAUI7kwOdbWGoz
 MBysd9IXjqwaNTQFs69Krr/XEZUBgyoU1bBviHd1HTvFchSv/rcPLtlVjCkLl4JcKt3vWN
 9/jGq6rm+zoUgTRJ76Rszwurc6OHy8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-anF8DNeBMF2B7yrzLYlAMQ-1; Fri, 19 Jun 2020 09:17:51 -0400
X-MC-Unique: anF8DNeBMF2B7yrzLYlAMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E134801503;
 Fri, 19 Jun 2020 13:17:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4916C60F88;
 Fri, 19 Jun 2020 13:17:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A0BEE9D95; Fri, 19 Jun 2020 15:17:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] hw/audio/gus: Fix registers 32-bit access
Date: Fri, 19 Jun 2020 15:17:41 +0200
Message-Id: <20200619131741.10857-8-kraxel@redhat.com>
In-Reply-To: <20200619131741.10857-1-kraxel@redhat.com>
References: <20200619131741.10857-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Allan Peramaki <aperamak@pp1.inet.fi>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200618103623.6031-1-philmd@redhat.com
Message-Id: <20200615201757.16868-1-aperamak@pp1.inet.fi>
[PMD: Removed unrelated style changes]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/gusemu_hal.c   | 2 +-
 hw/audio/gusemu_mixer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index ae40ca341cc4..5b9a14ee21b6 100644
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
index 00b9861b92b2..56300de77e44 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -28,7 +28,7 @@
 
 #define GUSregb(position)  (*            (gusptr+(position)))
 #define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
 
 #define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
 
-- 
2.18.4



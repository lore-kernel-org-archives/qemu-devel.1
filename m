Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A4920671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNIRnPBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A4920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbYX-0000aX-46
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRD-0004IE-So
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRA-0007w3-Bf
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ZuarwHpOQc0u30LFTFQMPNO3U8EShjSiKSnesAXqYBM=;
 b=SNIRnPBH6ZNyROMbJ/SZ5rVKHc9yqq2s8CSqG7EYD0VbKAOfyzOJnHoxWwwhEHltFd6CAJ
 fHdwnBqCV0Alc4+iyaRn09dCOk0n0UZvfFpazxmknAkt3xAlknQAv11pvwONlWjE3VgTAw
 sDVD1JRBswl02eMjrKTBBifjRzSE2WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-yLV0kjklPhe4f6tA2SOo5g-1; Fri, 15 May 2020 10:35:41 -0400
X-MC-Unique: yLV0kjklPhe4f6tA2SOo5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0E11054F8F
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A2A55C661;
 Fri, 15 May 2020 14:35:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 30F449D57; Fri, 15 May 2020 16:35:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
Date: Fri, 15 May 2020 16:35:26 +0200
Message-Id: <20200515143528.13591-12-kraxel@redhat.com>
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add deprecation message to the audio init function.

Factor out audio initialization and call that from
both audio init and realize, so setting audiodev via
-global is enough to properly initialize pcspk.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/pcspk.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index c37a3878612e..ab290e686783 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -28,6 +28,7 @@
 #include "audio/audio.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "hw/timer/i8254.h"
 #include "migration/vmstate.h"
 #include "hw/audio/pcspk.h"
@@ -112,11 +113,15 @@ static void pcspk_callback(void *opaque, int free)
     }
 }
 
-static int pcspk_audio_init(ISABus *bus)
+static int pcspk_audio_init(PCSpkState *s)
 {
-    PCSpkState *s = pcspk_state;
     struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUDIO_FORMAT_U8, 0};
 
+    if (s->voice) {
+        /* already initialized */
+        return 0;
+    }
+
     AUD_register_card(s_spk, &s->card);
 
     s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
@@ -185,6 +190,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
+    if (s->card.state) {
+        pcspk_audio_init(s);
+    }
+
     pcspk_state = s;
 }
 
@@ -236,9 +245,18 @@ static const TypeInfo pcspk_info = {
     .class_init     = pcspk_class_initfn,
 };
 
+static int pcspk_audio_init_soundhw(ISABus *bus)
+{
+    PCSpkState *s = pcspk_state;
+
+    warn_report("'-soundhw pcspk' is deprecated, "
+                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");
+    return pcspk_audio_init(s);
+}
+
 static void pcspk_register(void)
 {
     type_register_static(&pcspk_info);
-    isa_register_soundhw("pcspk", "PC speaker", pcspk_audio_init);
+    isa_register_soundhw("pcspk", "PC speaker", pcspk_audio_init_soundhw);
 }
 type_init(pcspk_register)
-- 
2.18.4



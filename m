Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FBFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47D7206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxlV7rKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47D7206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsWuy-00025w-0D
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsWoE-0005xY-F7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:29:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsWo8-0006ms-86
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594063779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=2rP3utXcE1ktExwobejkuCNOnTaRy9Co4Ot9lcNiDY0=;
 b=cxlV7rKH6nl4ZZ0I0sJ6n4ije8SBHAqmDZf3guM1GCjvzYFkDD/TUGC5LWZ8OiEouj2MKU
 CobtuhaX1cygtGNgKz71SJK2SpR3t8hn618wmX62M2fztpDYFmtMvtf1eDjXJ4ljuYYnyv
 2l8ub+vv35BostPhW3KOIGp72NQ3YGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-BvWaS0dJMwSIcxTadn70Mw-1; Mon, 06 Jul 2020 15:29:35 -0400
X-MC-Unique: BvWaS0dJMwSIcxTadn70Mw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA75ABFC3;
 Mon,  6 Jul 2020 19:29:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8287B412;
 Mon,  6 Jul 2020 19:29:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AA2D431EE5; Mon,  6 Jul 2020 21:29:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] audio: deprecate -soundhw pcspk
Date: Mon,  6 Jul 2020 21:29:18 +0200
Message-Id: <20200706192921.1154-18-kraxel@redhat.com>
In-Reply-To: <20200706192921.1154-1-kraxel@redhat.com>
References: <20200706192921.1154-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add deprecation message to the audio init function.

Factor out audio initialization and call that from
both audio init and realize, so setting the audiodev
property is enough to properly initialize pcspk.

Add a property alias to the machine type to set the
audio device, so pcspk can be initialized using:
"-machine pcspk-audiodev=<name>"

Using "-global isa-pcspk.audiodev=<name>" works too but
is not recommended.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200702132525.6849-18-kraxel@redhat.com
---
 hw/audio/pcspk.c | 24 +++++++++++++++++++++---
 hw/i386/pc.c     |  2 ++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index c37a3878612e..4c7e339ac2b5 100644
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
+                "please set a backend using '-machine pcspk-audiodev=<name>' instead");
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
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 88785f9dcc70..c45e7bfd864b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1892,6 +1892,8 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
+    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk), "audiodev");
 }
 
 static void pc_machine_reset(MachineState *machine)
-- 
2.18.4



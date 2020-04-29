Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B964C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4612C20775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ3JssG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4612C20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkfz-0003a0-GQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUy-0005C9-Tr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkU0-00044J-NX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTz-0003wm-OB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUJCupT6IYh2WAx1L3nT6pq2CVSmwuP3AoQsjaYSYSs=;
 b=jJ3JssG9tdsOLWAAtZIve64eq5a2qm7BLVVi40y/HVk4bpkmoYEokQ690OuabNzuavbk5f
 fqVNSv2gFJvBlNbkdT47QuGAf90Df6PN3+aAFjVgK23qz9onDLiU7SAMhuaCv15bWOIt65
 WW7I/PrL9QV8L6NFgB0kBbz1hHH9Q5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249--H-v5AYmNi6uwaLrclFEfA-1; Wed, 29 Apr 2020 07:02:23 -0400
X-MC-Unique: -H-v5AYmNi6uwaLrclFEfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF1DF835B41
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA17C60BF4;
 Wed, 29 Apr 2020 11:02:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 689AE9DA6; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] audio: deprecate -soundhw pcspk
Date: Wed, 29 Apr 2020 13:02:13 +0200
Message-Id: <20200429110214.29037-12-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
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
index 29dc00bf8dc7..72e7234d5f65 100644
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
=20
-static int pcspk_audio_init(ISABus *bus)
+static int pcspk_audio_init(PCSpkState *s)
 {
-    PCSpkState *s =3D pcspk_state;
     struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUDIO_FORMAT_U8, 0};
=20
+    if (s->voice) {
+        /* already initialized */
+        return 0;
+    }
+
     AUD_register_card(s_spk, &s->card);
=20
     s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback=
, &as);
@@ -185,6 +190,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **=
errp)
=20
     isa_register_ioport(isadev, &s->ioport, s->iobase);
=20
+    if (s->card.state) {
+        pcspk_audio_init(s);
+    }
+
     pcspk_state =3D s;
 }
=20
@@ -236,9 +245,18 @@ static const TypeInfo pcspk_info =3D {
     .class_init     =3D pcspk_class_initfn,
 };
=20
+static int pcspk_audio_init_soundhw(ISABus *bus)
+{
+    PCSpkState *s =3D pcspk_state;
+
+    warn_report("'-soundhw pcspk' is deprecated, "
+                "please set a backend using '-global isa-pcspk.audiodev=3D=
<name>' instead");
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
--=20
2.18.2



Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BF6C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4759620872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOj2K+21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4759620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIT1h-0003wV-Dv
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIT0J-00027y-22
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIT0H-0007cw-6D
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600245684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+FjKg8oo5cNEfttX5NKNmNNbXL3EFFNgq297qDRIYU=;
 b=KOj2K+21sxi5kusyoTe7MEn/gncKHVZx+JU2d3Jj8ve9018FoF6zvChMwl3yjMWWczD29y
 +GYlQdlfpWwkIBEo9mnCYjAJHdwF4aXiwzHQTv4aSnpdE0g2lJL9HXApAQpM0xu6A6HRHT
 wvwiQPMSxfedtlHz+hVVrtmmP+Akrz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-VUWi8bJLMtq-QlIQ-VdhyQ-1; Wed, 16 Sep 2020 04:41:22 -0400
X-MC-Unique: VUWi8bJLMtq-QlIQ-VdhyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C831D10A7AE2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:41:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7029660CCC;
 Wed, 16 Sep 2020 08:41:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94EB69D77; Wed, 16 Sep 2020 10:41:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] audio: remove qemu_spice_audio_init()
Date: Wed, 16 Sep 2020 10:41:16 +0200
Message-Id: <20200916084117.21828-2-kraxel@redhat.com>
In-Reply-To: <20200916084117.21828-1-kraxel@redhat.com>
References: <20200916084117.21828-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handle the spice special case in audio_init instead.

With the qemu_spice_audio_init() symbol dependency being
gone we can build spiceaudio as module.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/qemu-spice.h |  1 -
 audio/audio.c           | 16 ++++++++++++++++
 audio/spiceaudio.c      |  5 -----
 ui/spice-core.c         |  1 -
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 8c23dfe71797..12474d88f40e 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -29,7 +29,6 @@ extern int using_spice;
 
 void qemu_spice_init(void);
 void qemu_spice_input_init(void);
-void qemu_spice_audio_init(void);
 void qemu_spice_display_init(void);
 int qemu_spice_display_add_client(int csock, int skipauth, int tls);
 int qemu_spice_add_interface(SpiceBaseInstance *sin);
diff --git a/audio/audio.c b/audio/audio.c
index ce8c6dec5f47..76cdba0943d1 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
+#include "ui/qemu-spice.h"
 #include "trace.h"
 
 #define AUDIO_CAP "audio"
@@ -1658,6 +1659,21 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
     /* silence gcc warning about uninitialized variable */
     AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
 
+    if (using_spice) {
+        /*
+         * When using spice allow the spice audio driver being picked
+         * as default.
+         *
+         * Temporary hack.  Using audio devices without explicit
+         * audiodev= property is already deprecated.  Same goes for
+         * the -soundhw switch.  Once this support gets finally
+         * removed we can also drop the concept of a default audio
+         * backend and this can go away.
+         */
+        driver = audio_driver_lookup("spice");
+        driver->can_be_default = 1;
+    }
+
     if (dev) {
         /* -audiodev option */
         legacy_config = false;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index b6b5da4812f2..aae420cff997 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -310,11 +310,6 @@ static struct audio_driver spice_audio_driver = {
     .voice_size_in  = sizeof (SpiceVoiceIn),
 };
 
-void qemu_spice_audio_init (void)
-{
-    spice_audio_driver.can_be_default = 1;
-}
-
 static void register_audio_spice(void)
 {
     audio_driver_register(&spice_audio_driver);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ecc2ec2c55c2..10aa309f78f7 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -804,7 +804,6 @@ void qemu_spice_init(void)
     qemu_spice_add_interface(&spice_migrate.base);
 
     qemu_spice_input_init();
-    qemu_spice_audio_init();
 
     qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
     qemu_spice_display_stop();
-- 
2.27.0



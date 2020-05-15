Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08084C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D0E20671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOk3uwDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D0E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbZo-0002Vp-SY
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRH-0004Ku-Oy
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRG-0007xW-D4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=rxjEnOFl3k1y+/TCe7IeMWO6RNoYyC4cbZ8m1VLySmo=;
 b=DOk3uwDCQiwvaCWnxDYyyIGMsgvfIZksYTiw3nRjvkiJvUkRcGU+JESeYRo/IG0BNwxRn3
 bOMuudD/aBM77baRTlPAHy/Ao+H+BHlntP9xj5Zng0aJ4gOYUgBcewfJbf2jWdu6tklvLM
 vYDEV0SDrwy9XLZy4RuNSq/YiRM+/bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-ljJohTrAN4iCqug-2L2ixA-1; Fri, 15 May 2020 10:35:46 -0400
X-MC-Unique: ljJohTrAN4iCqug-2L2ixA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8BB1054FB2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F65063F8F;
 Fri, 15 May 2020 14:35:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F0F589DAE; Fri, 15 May 2020 16:35:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/13] audio: deprecate -soundhw es1370
Date: Fri, 15 May 2020 16:35:20 +0200
Message-Id: <20200515143528.13591-6-kraxel@redhat.com>
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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

Switch to deprecated_register_soundhw().  Remove the now obsolete init
function.  Add an alias so both es1370 and ES1370 are working with
-device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/es1370.c | 9 ++-------
 qdev-monitor.c    | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 89c4dabcd44f..f36ed95ac93f 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -881,12 +881,6 @@ static void es1370_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static int es1370_init (PCIBus *bus)
-{
-    pci_create_simple (bus, -1, TYPE_ES1370);
-    return 0;
-}
-
 static Property es1370_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
     DEFINE_PROP_END_OF_LIST(),
@@ -925,7 +919,8 @@ static const TypeInfo es1370_info = {
 static void es1370_register_types (void)
 {
     type_register_static (&es1370_info);
-    pci_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370", es1370_init);
+    deprecated_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370",
+                                0, TYPE_ES1370);
 }
 
 type_init (es1370_register_types)
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9c3cb89473c6..748733215004 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -55,6 +55,7 @@ typedef struct QDevAlias
 static const QDevAlias qdev_alias_table[] = {
     { "AC97", "ac97" }, /* -soundhw name */
     { "e1000", "e1000-82540em" },
+    { "ES1370", "es1370" }, /* -soundhw name */
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
     { "virtio-9p-ccw", "virtio-9p", QEMU_ARCH_S390X },
-- 
2.18.4



Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98604C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654DA206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iK3qi0K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654DA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkWR-0006r0-Dm
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUw-0005Bh-OV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTz-0003yU-AH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTx-0003sf-AF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFsuZt34R2x6tgCSKqR0BQQIlxpOlkHGdpBGsp1Inns=;
 b=iK3qi0K3hu5VXrxaBB2SRcNZ3y8JjpOsMBkPmp4CDiCxz7ovX1RW61thvA9OEfHbRE2vu0
 6QjZooFoD72FZdsvDRaRht/b/vSWbQfo6japI497HzFwGUJv3kVHBPm36GtuacWtR4Uibx
 J+/RGl3B50Qi+DBKUQX7gD4SPHRVS4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-6rNjF9UCMOmA3Cjk3QsIUA-1; Wed, 29 Apr 2020 07:02:20 -0400
X-MC-Unique: 6rNjF9UCMOmA3Cjk3QsIUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27DC835B48
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB7C999D6;
 Wed, 29 Apr 2020 11:02:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 356289D9E; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] audio: deprecate -soundhw es1370
Date: Wed, 29 Apr 2020 13:02:07 +0200
Message-Id: <20200429110214.29037-6-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
=20
-static int es1370_init (PCIBus *bus)
-{
-    pci_create_simple (bus, -1, TYPE_ES1370);
-    return 0;
-}
-
 static Property es1370_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
     DEFINE_PROP_END_OF_LIST(),
@@ -925,7 +919,8 @@ static const TypeInfo es1370_info =3D {
 static void es1370_register_types (void)
 {
     type_register_static (&es1370_info);
-    pci_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370", es1370_init)=
;
+    deprecated_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370",
+                                0, TYPE_ES1370);
 }
=20
 type_init (es1370_register_types)
diff --git a/qdev-monitor.c b/qdev-monitor.c
index ce45bcfa03f3..f841821f3aa6 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -54,6 +54,7 @@ typedef struct QDevAlias
 static const QDevAlias qdev_alias_table[] =3D {
     { "AC97", "ac97" }, /* -soundhw name */
     { "e1000", "e1000-82540em" },
+    { "ES1370", "es1370" }, /* -soundhw name */
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
     { "virtio-9p-ccw", "virtio-9p", QEMU_ARCH_S390X },
--=20
2.18.2



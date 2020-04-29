Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C69C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D827C206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8NzmU0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D827C206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkWP-0006lq-S6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUt-0005Av-2H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTv-0003mo-4T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTu-0003lp-MC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEJMnpIN0xvpBQer9GgaaNRqIx+5ROqZeKmYgXn7ais=;
 b=g8NzmU0Cf+ZlibAIyoRkloqRADBmr2s5VCxj1jCdcp8Z4D9pWkP69psm2NFF6jD6grmOll
 /BYMKCtMlpXWZtHvJ8Bh1mp9rZC2VX2D74dP+eK53R36KdmPZhNN9PolvEawbvw9mSmh7U
 LJe0NDez7oRW1bLD5Hdx/NLSr+HmhuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-u29wFlbsOEKGeyq4064imQ-1; Wed, 29 Apr 2020 07:02:19 -0400
X-MC-Unique: u29wFlbsOEKGeyq4064imQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F5AB462
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD571002396;
 Wed, 29 Apr 2020 11:02:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2B4739D9D; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] audio: deprecate -soundhw ac97
Date: Wed, 29 Apr 2020 13:02:06 +0200
Message-Id: <20200429110214.29037-5-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Switch to deprecated_register_soundhw().  Remove the now obsolete init
function.  Add an alias so both ac97 and AC97 are working with -device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/ac97.c | 9 ++-------
 qdev-monitor.c  | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 1ec87feec0cb..f32eb46f7f4d 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1395,12 +1395,6 @@ static void ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
=20
-static int ac97_init (PCIBus *bus)
-{
-    pci_create_simple(bus, -1, TYPE_AC97);
-    return 0;
-}
-
 static Property ac97_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_END_OF_LIST (),
@@ -1438,7 +1432,8 @@ static const TypeInfo ac97_info =3D {
 static void ac97_register_types (void)
 {
     type_register_static (&ac97_info);
-    pci_register_soundhw("ac97", "Intel 82801AA AC97 Audio", ac97_init);
+    deprecated_register_soundhw("ac97", "Intel 82801AA AC97 Audio",
+                                0, TYPE_AC97);
 }
=20
 type_init (ac97_register_types)
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9833b3354969..ce45bcfa03f3 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -52,6 +52,7 @@ typedef struct QDevAlias
=20
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] =3D {
+    { "AC97", "ac97" }, /* -soundhw name */
     { "e1000", "e1000-82540em" },
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
--=20
2.18.2



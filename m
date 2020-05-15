Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB69C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B8920671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsM8dQmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B8920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbWH-0005mE-14
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRE-0004IF-0n
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbR9-0007vs-QI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=SZuSiCccpxvkEMZkm3itcaBsSfjj3wvWaBlQOWBH6+k=;
 b=SsM8dQmvZ3zANQmbVm+aNlfzpvjyzOvKJFmaVnHGo5VNNeRKMSFxqdjQ2ld7Dukaa79fm0
 SSACVPxGouk795AgaYyRdXzS4W03v2WfpTPCbpxeUgsDSCcItjms9OVEyUBohQ8WYAROwu
 y/Qd2EVgea51jqbAGqTNRTREe+pwWIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-H5f9elkWMNKuM7vwbczMyA-1; Fri, 15 May 2020 10:35:41 -0400
X-MC-Unique: H5f9elkWMNKuM7vwbczMyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550A31800D4A
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 033FC2E186;
 Fri, 15 May 2020 14:35:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E68A99DAD; Fri, 15 May 2020 16:35:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/13] audio: deprecate -soundhw ac97
Date: Fri, 15 May 2020 16:35:19 +0200
Message-Id: <20200515143528.13591-5-kraxel@redhat.com>
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
function.  Add an alias so both ac97 and AC97 are working with -device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/ac97.c | 9 ++-------
 qdev-monitor.c  | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 8a9b9924c495..38522cf0ba44 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1393,12 +1393,6 @@ static void ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static int ac97_init (PCIBus *bus)
-{
-    pci_create_simple(bus, -1, TYPE_AC97);
-    return 0;
-}
-
 static Property ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_END_OF_LIST (),
@@ -1436,7 +1430,8 @@ static const TypeInfo ac97_info = {
 static void ac97_register_types (void)
 {
     type_register_static (&ac97_info);
-    pci_register_soundhw("ac97", "Intel 82801AA AC97 Audio", ac97_init);
+    deprecated_register_soundhw("ac97", "Intel 82801AA AC97 Audio",
+                                0, TYPE_AC97);
 }
 
 type_init (ac97_register_types)
diff --git a/qdev-monitor.c b/qdev-monitor.c
index a4735d3bb190..9c3cb89473c6 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -53,6 +53,7 @@ typedef struct QDevAlias
 
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
+    { "AC97", "ac97" }, /* -soundhw name */
     { "e1000", "e1000-82540em" },
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
-- 
2.18.4



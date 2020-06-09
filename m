Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7761920734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtNh7fSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7761920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihiv-0002Z1-NM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihI2-0004NX-KT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHw-0003E2-Lb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shnAdhJjmSfgzQchX5hCLAlhU/KwAp2h4j2pwnONVtE=;
 b=HtNh7fSDqp1cgkukgA93QlUp0L7/Qi2jSKd88Cd/GYiiEhLaOhM/c7mrMj1cbL3uo5QFqA
 sDnMvDHgeHKSMWbYMyCsNIVikXHyNZ0zN+jnDRtuu3O5bTEK5Cqc5CCPcwVRewKsrleEbw
 ciOS3RT8LP0diJYjFEqgLS6IV24POHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-65V3c3YpOFGQsCawsdz10Q-1; Tue, 09 Jun 2020 12:39:42 -0400
X-MC-Unique: 65V3c3YpOFGQsCawsdz10Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C4E3643B;
 Tue,  9 Jun 2020 16:39:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A130F89293;
 Tue,  9 Jun 2020 16:39:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FA23113847B; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 37/39] macio: Convert use of qdev_set_parent_bus()
Date: Tue,  9 Jun 2020 18:39:30 +0200
Message-Id: <20200609163932.1566209-38-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qdev_set_parent_bus()/realize to qdev_realize(); recent commit
"qdev: New qdev_new(), qdev_realize(), etc." explains why.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/macio/macio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index a2698e4a20..1a07ca2ca5 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -100,7 +100,6 @@ static void macio_init_child_obj(MacIOState *s, const char *childname,
 {
     object_initialize_child_with_props(OBJECT(s), childname, child, childsize,
                                        childtype, &error_abort, NULL);
-    qdev_set_parent_bus(DEVICE(child), BUS(&s->macio_bus));
 }
 
 static void macio_common_realize(PCIDevice *d, Error **errp)
@@ -109,7 +108,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     SysBusDevice *sysbus_dev;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->dbdma), true, "realized", &err);
+    qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -125,7 +124,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
-    object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
+    qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -148,7 +147,7 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma", errp);
     macio_ide_register_dma(ide);
 
-    object_property_set_bool(OBJECT(ide), true, "realized", errp);
+    qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
 }
 
 static void macio_oldworld_realize(PCIDevice *d, Error **errp)
@@ -167,7 +166,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 
     qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                          s->frequency);
-    object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -184,7 +183,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
                                                        OLDWORLD_ESCCA_IRQ));
 
-    object_property_set_bool(OBJECT(&os->nvram), true, "realized", &err);
+    qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -348,7 +347,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
                                  &error_abort);
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
-        object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+        qdev_realize(DEVICE(&ns->gpio), BUS(&s->macio_bus), &err);
 
         /* PMU */
         object_initialize_child(OBJECT(s), "pmu", &s->pmu, TYPE_VIA_PMU);
-- 
2.26.2



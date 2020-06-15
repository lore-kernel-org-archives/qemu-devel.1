Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96720C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564AE20707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5SHNavp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564AE20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwf7-0007yU-I2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkw24-000784-Od
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:48:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58721
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkw21-0001tQ-6T
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592254116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9H8JkTlAFgY86AVGuLhU140I1h4muMdtsQfrkZPGXJE=;
 b=R5SHNavp5DJ4cdDgPq/LkKuA4VVc/qo60KL6kVwu8YVAdzKn6owBPpdkysL6S0rC2QERnn
 3R4w89bxMfgH/eYZRBFZte8F1Z5926QYhNY4Rq1oDiEABd/rYY5ucZWhh1f1hye2IqQ0dq
 q4JZSXwm+zM2s1wA0ZS3HPx8wx/Ls9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384--Lgty7ITNaidfSCSgzEOjQ-1; Mon, 15 Jun 2020 16:48:34 -0400
X-MC-Unique: -Lgty7ITNaidfSCSgzEOjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D027F803318
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 20:48:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1760768DC;
 Mon, 15 Jun 2020 20:48:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F19B41132C7B; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/84] auxbus: Convert a use of qdev_set_parent_bus()
Date: Mon, 15 Jun 2020 22:39:43 +0200
Message-Id: <20200615204008.3069956-60-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:38:57
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qdev_set_parent_bus()/qdev_init_nofail() to qdev_realize();
recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
why.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-34-armbru@redhat.com>
---
 hw/display/xlnx_dp.c | 2 +-
 hw/misc/auxbus.c     | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index a714cf8a50..884d29c8ce 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1268,7 +1268,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
 
     aux_bus_realize(s->aux_bus);
 
-    qdev_init_nofail(DEVICE(s->dpcd));
+    qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
 
     qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 75b6de1c63..5c9c23a336 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -70,7 +70,6 @@ AUXBus *aux_bus_init(DeviceState *parent, const char *name)
     bus = AUX_BUS(qbus_create(TYPE_AUX_BUS, parent, name));
     auxtoi2c = object_new_with_props(TYPE_AUXTOI2C, OBJECT(bus), "i2c",
                                      &error_abort, NULL);
-    qdev_set_parent_bus(DEVICE(auxtoi2c), BUS(bus));
 
     bus->bridge = AUXTOI2C(auxtoi2c);
 
@@ -83,7 +82,7 @@ AUXBus *aux_bus_init(DeviceState *parent, const char *name)
 
 void aux_bus_realize(AUXBus *bus)
 {
-    qdev_init_nofail(DEVICE(bus->bridge));
+    qdev_realize(DEVICE(bus->bridge), BUS(bus), &error_fatal);
 }
 
 void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
@@ -280,7 +279,6 @@ DeviceState *aux_create_slave(AUXBus *bus, const char *type)
 
     dev = qdev_new(type);
     assert(dev);
-    qdev_set_parent_bus(dev, &bus->qbus);
     return dev;
 }
 
-- 
2.26.2



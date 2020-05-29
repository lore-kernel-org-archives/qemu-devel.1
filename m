Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED637C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B088E206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmucAy5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B088E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefXs-0004XK-SS
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKO-0002jc-42
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKK-00074F-8q
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqPwyZh3FK8m5bThNglYYWXU9cvhfHsRsD5rDfED8dI=;
 b=SmucAy5cU15Pe6ORcs6eJ62WzT1snOjXVD55YyQep4H/Z8f/wq5TTxMmxjpMSYW0SOom1X
 UgIb63CxpeGT8kGdkWDZd4OkFIOYrzBiag6fUHZRqv0OC89fNDWVY1BdNulv1r+/grFALH
 oSSSOcQgEnBZGj2s7jC8pTp+ELhRpkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-WKqdTrh9MyOBn32H_Xcs0g-1; Fri, 29 May 2020 09:45:32 -0400
X-MC-Unique: WKqdTrh9MyOBn32H_Xcs0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9764460
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADBF65D9D5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D3211135229; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 33/58] auxbus: Convert a use of qdev_set_parent_bus()
Date: Fri, 29 May 2020 15:44:58 +0200
Message-Id: <20200529134523.8477-34-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qdev_set_parent_bus()/qdev_init_nofail() to qdev_realize();
recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
why.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/display/xlnx_dp.c | 2 +-
 hw/misc/auxbus.c     | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 900d95fc93..e6e7f0037f 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1266,7 +1266,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
 
     aux_bus_realize(s->aux_bus);
 
-    qdev_init_nofail(DEVICE(s->dpcd));
+    qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
 
     qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 113f4278aa..e7a5d26158 100644
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
2.21.3



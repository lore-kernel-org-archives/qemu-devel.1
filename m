Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14FBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B84207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hpskyoq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B84207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3ki-0005Cr-P4
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f1-0001B2-Hf
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ez-0003V5-MK
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/22LRD+VJufGTHanGktF1ynIproRu9kuTfNaJ/fg4RM=;
 b=Hpskyoq5j8wDOSryX0NwOCgDW6NnS9dgEGN1YbnIYDEF7MgKL4uEk6coX4ePsJr9YQ8TSn
 QIBBxHtN+drRtxkUO5FHjThAKnWP8at327Qo9k6bNssbpDPyTr3R6npw0gELAKKIxkdXqY
 dLC7IpI+Fvwn02yhFc4jCCkR5/jCeaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-wbHvFdhkNfGBN0QcqI0Hsg-1; Tue, 19 May 2020 10:55:59 -0400
X-MC-Unique: wbHvFdhkNfGBN0QcqI0Hsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6242580B72E
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3166A60C84;
 Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A27411358DC; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/55] auxbus: Convert a use of qdev_set_parent_bus()
Date: Tue, 19 May 2020 16:55:27 +0200
Message-Id: <20200519145551.22836-32-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
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
index b1d90cab1d..75de65ec96 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1266,7 +1266,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
 
     aux_realize_bus(s->aux_bus);
 
-    qdev_init_nofail(DEVICE(s->dpcd));
+    qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
 
     qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 9b4ccfa39c..682c35ece8 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -70,7 +70,6 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
     bus = AUX_BUS(qbus_create(TYPE_AUX_BUS, parent, name));
     auxtoi2c = object_new_with_props(TYPE_AUXTOI2C, OBJECT(bus), "i2c",
                                      &error_abort, NULL);
-    qdev_set_parent_bus(DEVICE(auxtoi2c), BUS(bus));
 
     bus->bridge = AUXTOI2C(auxtoi2c);
 
@@ -83,7 +82,7 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
 
 void aux_realize_bus(AUXBus *bus)
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
2.21.1



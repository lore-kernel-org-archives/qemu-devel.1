Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E74DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3FF207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGDyJUUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3FF207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitNf-0006pH-Fk
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitM8-0004vL-Gg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:32:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitM7-0003oT-D9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hC4mpeJZfphtWYsBTXEUYFx6o077dtztmAdYg392xk=;
 b=UGDyJUUAvP2dzr7hwxMQA2xAV45lf9FYY91GYUToQ6hvt6iNeBgszYEtjGr+0hPYYJhnqa
 ZHYK4vRuV/fAjMrhT4iO2XdpnC9uMzGGY81oEMpJkd/fmlHHdVfkKQ984KALbTSmb4oBVl
 4+1GObe/TltijgpdoCdWVBKgZZU2ouk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Ci4WTqGONc-ISv-TIHqKJQ-1; Wed, 10 Jun 2020 01:32:53 -0400
X-MC-Unique: Ci4WTqGONc-ISv-TIHqKJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4453B107BEF5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1528F10013D0;
 Wed, 10 Jun 2020 05:32:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4EA711384A1; Wed, 10 Jun 2020 07:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 08/58] qdev: Convert to qdev_unrealize() manually
Date: Wed, 10 Jun 2020 07:31:57 +0200
Message-Id: <20200610053247.1583243-9-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h | 1 -
 hw/core/qdev.c         | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fba29308f7..be6f7c4736 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -328,7 +328,6 @@ void qdev_init_nofail(DeviceState *dev);
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 void qdev_unrealize(DeviceState *dev);
-
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b7355fbcd0..4768244f31 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -421,7 +421,7 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
+    qdev_unrealize(dev);
 }
 
 /*
@@ -1183,7 +1183,7 @@ static void device_unparent(Object *obj)
     BusState *bus;
 
     if (dev->realized) {
-        object_property_set_bool(obj, false, "realized", &error_abort);
+        qdev_unrealize(dev);
     }
     while (dev->num_child_bus) {
         bus = QLIST_FIRST(&dev->child_bus);
-- 
2.26.2



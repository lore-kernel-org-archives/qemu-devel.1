Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E630BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24C820675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+6FCgKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24C820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqMw-0006w4-Uc
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7M-0002SL-18
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq78-0006r0-DA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28Dwi9o7iLjq5FBxKd0/OTZkzYe+Uh8NWSLd3XHbGjw=;
 b=P+6FCgKUdg8TWJk5n43uFjYM1VEsHyaoGreAm+uddKFn1coiKyf3sWOzPhGJbPr4NeIuDP
 xFVW5z6sr3ujKg1SRuoRHsJiFLxNvcTQ4Wbu5z4pN8a30COhF+RtWu0rEJs2Em4Ev4YUyo
 6OBl49FW8tGHphZXFrL7Qe4EfrlyfCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-JkX_--PbM0SN_hhltaX2Jg-1; Tue, 07 Jul 2020 12:06:28 -0400
X-MC-Unique: JkX_--PbM0SN_hhltaX2Jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E13B804004;
 Tue,  7 Jul 2020 16:06:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A1755C1B2;
 Tue,  7 Jul 2020 16:06:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8DC511275F7; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 29/45] qom: Use returned bool to check for failure,
 manual part
Date: Tue,  7 Jul 2020 18:05:57 +0200
Message-Id: <20200707160613.848843-30-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit used Coccinelle to convert from checking the Error
object to checking the return value.  Convert a few more manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/core/bus.c              |  6 +-----
 hw/core/qdev.c             |  7 +------
 hw/s390x/s390-virtio-ccw.c | 13 +++++++------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 00d1d31762..6b987b6946 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -166,11 +166,7 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
 
 bool qbus_realize(BusState *bus, Error **errp)
 {
-    Error *err = NULL;
-
-    object_property_set_bool(OBJECT(bus), "realized", true, &err);
-    error_propagate(errp, err);
-    return !err;
+    return object_property_set_bool(OBJECT(bus), "realized", true, errp);
 }
 
 void qbus_unrealize(BusState *bus)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index d6416fb894..17bd8fc2ec 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -386,8 +386,6 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
  */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 {
-    Error *err = NULL;
-
     assert(!dev->realized && !dev->parent_bus);
 
     if (bus) {
@@ -396,10 +394,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
 
-    if (!object_property_set_bool(OBJECT(dev), "realized", true, &err)) {
-        error_propagate(errp, err);
-    }
-    return !err;
+    return object_property_set_bool(OBJECT(dev), "realized", true, errp);
 }
 
 /*
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 62af349c31..f7a68343ef 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -70,19 +70,20 @@ static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
 {
     S390CPU *cpu = S390_CPU(object_new(typename));
     Error *err = NULL;
+    S390CPU *ret = NULL;
 
     if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, &err)) {
         goto out;
     }
-    qdev_realize(DEVICE(cpu), NULL, &err);
+    if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
+        goto out;
+    }
+    ret = cpu;
 
 out:
     object_unref(OBJECT(cpu));
-    if (err) {
-        error_propagate(errp, err);
-        cpu = NULL;
-    }
-    return cpu;
+    error_propagate(errp, err);
+    return ret;
 }
 
 static void s390_init_cpus(MachineState *machine)
-- 
2.26.2



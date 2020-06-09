Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B669C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C2C2078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhvNq+kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C2C2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihsF-0000IG-A0
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihII-0004fP-Mo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:40:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHx-0003ES-6n
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEbUxXtlak8PlFbd1O+GsorsG1R72gpuliA8h02ZDTk=;
 b=BhvNq+kthHJaPGC4hCT03cMZWKjmfmE5a7jYb9NuYFGCmcn72EQsBv6th7BHizvHhiupkJ
 cxgB6+w6iddKYLOeYqqXJy6hS8EYamfNaroVyTgFc4Y3eeBqH0jw77Qs4xCGuUOVzwcB7E
 zUzaQwlZUW33l3QAO2IEqYYUHtVmPdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-E5G1vwlwNrKF3IsyW8XwAA-1; Tue, 09 Jun 2020 12:39:40 -0400
X-MC-Unique: E5G1vwlwNrKF3IsyW8XwAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5973100CCC0
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B749A78FC5;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 512E61138475; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/39] auxbus: Rename aux_init_bus() to aux_bus_init()
Date: Tue,  9 Jun 2020 18:39:24 +0200
Message-Id: <20200609163932.1566209-32-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/misc/auxbus.h | 4 ++--
 hw/display/xlnx_dp.c     | 2 +-
 hw/misc/auxbus.c         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index a539a98c4b..5cfd7a9284 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -84,14 +84,14 @@ struct AUXSlave {
 };
 
 /**
- * aux_init_bus: Initialize an AUX bus.
+ * aux_bus_init: Initialize an AUX bus.
  *
  * Returns the new AUX bus created.
  *
  * @parent The device where this bus is located.
  * @name The name of the bus.
  */
-AUXBus *aux_init_bus(DeviceState *parent, const char *name);
+AUXBus *aux_bus_init(DeviceState *parent, const char *name);
 
 /*
  * aux_request: Make a request on the bus.
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 6e9793584a..31d0c5a101 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1244,7 +1244,7 @@ static void xlnx_dp_init(Object *obj)
     /*
      * Initialize AUX Bus.
      */
-    s->aux_bus = aux_init_bus(DEVICE(obj), "aux");
+    s->aux_bus = aux_bus_init(DEVICE(obj), "aux");
 
     /*
      * Initialize DPCD and EDID..
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 7fb020086f..2e1c27e842 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -62,7 +62,7 @@ static void aux_bus_class_init(ObjectClass *klass, void *data)
     k->print_dev = aux_slave_dev_print;
 }
 
-AUXBus *aux_init_bus(DeviceState *parent, const char *name)
+AUXBus *aux_bus_init(DeviceState *parent, const char *name)
 {
     AUXBus *bus;
     Object *auxtoi2c;
@@ -225,7 +225,7 @@ static void aux_bridge_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     /* This device is private and is created only once for each
-     * aux-bus in aux_init_bus(..). So don't allow the user to add one.
+     * aux-bus in aux_bus_init(..). So don't allow the user to add one.
      */
     dc->user_creatable = false;
 }
-- 
2.26.2



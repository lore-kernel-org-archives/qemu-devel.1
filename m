Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B146E2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqcZoFrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiheb-0003ib-Tj
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihI0-0004Hx-63
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHw-0003DH-6Q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvtcmJhL+Fv9a9fpcc9/KYgV5i+CUCLGuiYqC0uxBX4=;
 b=eqcZoFrngzBgExC1bIB7GcVEaCPUcTOXKaDX6frYV1rIfAnQCigDlNdB8YFfPp1pnRwwJq
 +I27JS7MvacipM1Xefwi2EQRwdP2EdRRCN6gmvfuMmT5MubLW0I4OCaFuiBSqpbrhbTscP
 WgKp1UWV/PZ53YeLUzmfZ501cgYOHpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Ou4JDeexPJ25c16H6amzLw-1; Tue, 09 Jun 2020 12:39:40 -0400
X-MC-Unique: Ou4JDeexPJ25c16H6amzLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8704107ACF7
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA9435C1BD;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 589DE1138476; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 32/39] auxbus: New aux_bus_realize(),
 pairing with aux_bus_init()
Date: Tue,  9 Jun 2020 18:39:25 +0200
Message-Id: <20200609163932.1566209-33-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

aux_bus_init() encapsulates the creation of an aux-bus and its
aux-to-i2c-bridge device.

Create aux_bus_realize() to similarly encapsulate their realization.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/misc/auxbus.h | 7 +++++++
 hw/display/xlnx_dp.c     | 2 +-
 hw/misc/auxbus.c         | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 5cfd7a9284..0d849d9d89 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -93,6 +93,13 @@ struct AUXSlave {
  */
 AUXBus *aux_bus_init(DeviceState *parent, const char *name);
 
+/**
+ * aux_bus_realize: Realize an AUX bus.
+ *
+ * @bus: The AUX bus.
+ */
+void aux_bus_realize(AUXBus *bus);
+
 /*
  * aux_request: Make a request on the bus.
  *
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 31d0c5a101..a714cf8a50 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1266,7 +1266,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     DisplaySurface *surface;
     struct audsettings as;
 
-    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
+    aux_bus_realize(s->aux_bus);
 
     qdev_init_nofail(DEVICE(s->dpcd));
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 2e1c27e842..113f4278aa 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -81,6 +81,11 @@ AUXBus *aux_bus_init(DeviceState *parent, const char *name)
     return bus;
 }
 
+void aux_bus_realize(AUXBus *bus)
+{
+    qdev_init_nofail(DEVICE(bus->bridge));
+}
+
 void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
 {
     DeviceState *dev = DEVICE(aux_dev);
-- 
2.26.2



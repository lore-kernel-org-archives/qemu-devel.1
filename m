Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C768BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9762D207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFyRZUtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9762D207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3l5-00062e-MH
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f2-0001CZ-4p
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ez-0003VB-Pp
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgKZEW8AyH/LAf3WhLxqK/AeL6iRUQdmJHp1VAo6SgE=;
 b=ZFyRZUtVBKr5E1jBWqz1HsiDg8eqmI0qF3jTglPp3+vMJB7GRwHmSkBNWM60905q7F1iFO
 kctQjX+4KUVdW10INw738PU3DalzOlmGHSxUc1WxehxdRyvUbWtuidUr/fx6ThoTYsNwh7
 x/TPlsCih59VaP+S49q39ADTQ2cbQS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-enVYli_oO-yJ0Q9OaLn1_g-1; Tue, 19 May 2020 10:55:59 -0400
X-MC-Unique: enVYli_oO-yJ0Q9OaLn1_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E011855A18
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 283596E71C;
 Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 257DF11358DB; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/55] auxbus: New aux_realize_bus(),
 pairing with aux_init_bus()
Date: Tue, 19 May 2020 16:55:26 +0200
Message-Id: <20200519145551.22836-31-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

aux_init_bus() encapsulates the creation of an aux-bus and its
aux-to-i2c-bridge device.

Create aux_realize_bus() to similarly encapsulate their realization.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/misc/auxbus.h | 7 +++++++
 hw/display/xlnx_dp.c     | 2 +-
 hw/misc/auxbus.c         | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index a539a98c4b..6ab6cf5bb6 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -93,6 +93,13 @@ struct AUXSlave {
  */
 AUXBus *aux_init_bus(DeviceState *parent, const char *name);
 
+/**
+ * aux_realize_bus: Realize an AUX bus.
+ *
+ * @bus: The AUX bus.
+ */
+void aux_realize_bus(AUXBus *bus);
+
 /*
  * aux_request: Make a request on the bus.
  *
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index dd6aa172f3..b1d90cab1d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1264,7 +1264,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     DisplaySurface *surface;
     struct audsettings as;
 
-    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
+    aux_realize_bus(s->aux_bus);
 
     qdev_init_nofail(DEVICE(s->dpcd));
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 7fb020086f..9b4ccfa39c 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -81,6 +81,11 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
     return bus;
 }
 
+void aux_realize_bus(AUXBus *bus)
+{
+    qdev_init_nofail(DEVICE(bus->bridge));
+}
+
 void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
 {
     DeviceState *dev = DEVICE(aux_dev);
-- 
2.21.1



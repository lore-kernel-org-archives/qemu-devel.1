Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD117C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1CF206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL8j4W+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1CF206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefPC-0003VF-Jk
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKN-0002hj-1y
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKJ-00072h-7U
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWRSH4/N4GjugNYyAOlTmd1YdiMf79ynZ4LMx/O9gLc=;
 b=JL8j4W+9R+W2Jp89uC+pe43dY3WXS5/nYXg26Ubop272tZQ9hEtMHT9VnuAdDuVSKygnbA
 4JJgAon/p/39oS2A4+UrTXcqPjdGJHXR3lyb2EQjx5zFDiKkLPkoRoDEYmo7k6+PDHqLRB
 BS5Qphi9AUjXt4QC1IgvZl135f01spA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-6jdlBx4FM6mn2w5A5wHWEQ-1; Fri, 29 May 2020 09:45:32 -0400
X-MC-Unique: 6jdlBx4FM6mn2w5A5wHWEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF191EC1A1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1D8519C79;
 Fri, 29 May 2020 13:45:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5091A113522A; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/58] auxbus: Eliminate aux_create_slave()
Date: Fri, 29 May 2020 15:44:59 +0200
Message-Id: <20200529134523.8477-35-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

aux_create_slave() has become a trivial wrapper around qdev_new().
There's just one user.  Eliminate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/misc/auxbus.h | 7 -------
 hw/display/xlnx_dp.c     | 2 +-
 hw/misc/auxbus.c         | 9 ---------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 0d849d9d89..15a8973517 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -131,13 +131,6 @@ I2CBus *aux_get_i2c_bus(AUXBus *bus);
  */
 void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio);
 
-/* aux_create_slave: Create a new device on an AUX bus
- *
- * @bus The AUX bus for the new device.
- * @name The type of the device to be created.
- */
-DeviceState *aux_create_slave(AUXBus *bus, const char *name);
-
 /* aux_map_slave: Map the mmio for an AUX slave on the bus.
  *
  * @dev The AUX slave.
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index e6e7f0037f..d1f9dc7595 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1247,7 +1247,7 @@ static void xlnx_dp_init(Object *obj)
     /*
      * Initialize DPCD and EDID..
      */
-    s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd"));
+    s->dpcd = DPCD(qdev_new("dpcd"));
     object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
 
     s->edid = I2CDDC(qdev_new("i2c-ddc"));
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index e7a5d26158..d631266903 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -273,15 +273,6 @@ static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
                    memory_region_size(s->mmio));
 }
 
-DeviceState *aux_create_slave(AUXBus *bus, const char *type)
-{
-    DeviceState *dev;
-
-    dev = qdev_new(type);
-    assert(dev);
-    return dev;
-}
-
 void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio)
 {
     assert(!aux_slave->mmio);
-- 
2.21.3



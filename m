Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A80C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABAB2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8ZnYDhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABAB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNwq-0003RA-1f
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTz-0007hq-6k
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTw-0000VY-C6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCzdj0wP9hH9GSsYgQ/Mxpku+ddRHqP0wd810k2sVH4=;
 b=T8ZnYDhEXSqLMaMkLUG1vjzUEujjbBEe7JE5W77Mb7XYKChncP8A/LBF/p3B2vythsRi/D
 UWkttK9ux5P90YVOj02nTouSgmoyboxkNOMH6Ku5sGtiC7fwh96sol9rcHOZcBTIHjU9QE
 Msb3Yv10OdEWGoRo/Ux0KaCy5OPZrwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-H0yQgybYNsGoLDRVrG0ZZA-1; Thu, 27 Aug 2020 15:22:41 -0400
X-MC-Unique: H0yQgybYNsGoLDRVrG0ZZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A148018A4;
 Thu, 27 Aug 2020 19:22:39 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83C4B795A0;
 Thu, 27 Aug 2020 19:22:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 36/53] auxbus: Move QOM macros to header
Date: Thu, 27 Aug 2020 15:21:05 -0400
Message-Id: <20200827192122.658035-37-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-38-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/misc/auxbus.h | 3 +++
 hw/misc/auxbus.c         | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 15a8973517..041edfc9e9 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -32,7 +32,10 @@ typedef struct AUXBus AUXBus;
 typedef struct AUXSlave AUXSlave;
 typedef enum AUXCommand AUXCommand;
 typedef enum AUXReply AUXReply;
+
+#define TYPE_AUXTOI2C "aux-to-i2c-bridge"
 typedef struct AUXTOI2CState AUXTOI2CState;
+#define AUXTOI2C(obj) OBJECT_CHECK(AUXTOI2CState, (obj), TYPE_AUXTOI2C)
 
 enum AUXCommand {
     WRITE_I2C = 0,
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index da361baa32..6c099ae2a2 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -45,8 +45,6 @@
     }                                                                          \
 } while (0)
 
-#define TYPE_AUXTOI2C "aux-to-i2c-bridge"
-#define AUXTOI2C(obj) OBJECT_CHECK(AUXTOI2CState, (obj), TYPE_AUXTOI2C)
 
 static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge);
-- 
2.26.2



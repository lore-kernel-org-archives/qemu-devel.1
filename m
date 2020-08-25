Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D302071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW0zPIxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D302071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeXi-000314-EK
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVZ-0006Hq-6Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVW-000619-KL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XO8DB7emv4BcDl67hxa2wyRpaTGxlAYk6xpPzT/Q1NM=;
 b=TW0zPIxJn8YezhqBBIV+z1eusp/V9qEUq0kkRP236ZWicViGzFFjv8SQCPZBkBopjQVOZL
 d8+lVvSvAQ3/mQLGD7G1ZIfxVu6me2i7IxEDZL8bJXSXBVCHDXvP4naYOgdxC6h+ePavDW
 lMNoMJz2FXw+CT3w1JsQbLu8z94zdKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-7WBqXtngPMecdN6-DfKpxA-1; Tue, 25 Aug 2020 15:21:18 -0400
X-MC-Unique: 7WBqXtngPMecdN6-DfKpxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1DBB64087
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 19:21:17 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96C7310013C2;
 Tue, 25 Aug 2020 19:21:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/74] e1000: Rename QOM class cast macros
Date: Tue, 25 Aug 2020 15:19:57 -0400
Message-Id: <20200825192110.3528606-2-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the E1000_DEVICE_CLASS() and E1000_DEVICE_GET_CLASS()
macros to be consistent with the E1000() instance cast macro.

This will allow us to register the type cast macros using
OBJECT_DECLARE_TYPE later.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes v1 -> v2: none

---
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/net/e1000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a18f80e369..c4d896a9e6 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -151,9 +151,9 @@ typedef struct E1000BaseClass {
 #define E1000(obj) \
     OBJECT_CHECK(E1000State, (obj), TYPE_E1000_BASE)
 
-#define E1000_DEVICE_CLASS(klass) \
+#define E1000_CLASS(klass) \
      OBJECT_CLASS_CHECK(E1000BaseClass, (klass), TYPE_E1000_BASE)
-#define E1000_DEVICE_GET_CLASS(obj) \
+#define E1000_GET_CLASS(obj) \
     OBJECT_GET_CLASS(E1000BaseClass, (obj), TYPE_E1000_BASE)
 
 static void
@@ -365,7 +365,7 @@ e1000_autoneg_timer(void *opaque)
 static void e1000_reset(void *opaque)
 {
     E1000State *d = opaque;
-    E1000BaseClass *edc = E1000_DEVICE_GET_CLASS(d);
+    E1000BaseClass *edc = E1000_GET_CLASS(d);
     uint8_t *macaddr = d->conf.macaddr.a;
 
     timer_del(d->autoneg_timer);
@@ -1751,7 +1751,7 @@ static void e1000_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    E1000BaseClass *e = E1000_DEVICE_CLASS(klass);
+    E1000BaseClass *e = E1000_CLASS(klass);
     const E1000Info *info = data;
 
     k->realize = pci_e1000_realize;
-- 
2.26.2



Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B58C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D972074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwmSCJ7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D972074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAesl-0006vj-QM
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWl-0000wj-RJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWk-0006GG-5K
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKzNexuEKRGmv8jDFpbBZMTEQ7p81HwsDJ1ZruYjsio=;
 b=MwmSCJ7jZSj5uFllaP7vv6rSOZCBIMNzakt7IeFhmhOfb4IjadJP8iJdc8nWGMNNIf6lkD
 nAD1jF9pRACk/yUNinE628bPSi1TWL+14mqrO1hC9y5nP14XZoTrUx3OznGbQ6mrZREIZo
 L/4IJn8HrZZ7Q+5vUBwN6mRFnpcJ0c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-ky5-Van1OpaEGheFFNgpoQ-1; Tue, 25 Aug 2020 15:22:35 -0400
X-MC-Unique: ky5-Van1OpaEGheFFNgpoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADD001895A26;
 Tue, 25 Aug 2020 19:22:34 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BFA210013C2;
 Tue, 25 Aug 2020 19:22:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 35/74] virtio-serial-bus: Move QOM macros to header
Date: Tue, 25 Aug 2020 15:20:31 -0400
Message-Id: <20200825192110.3528606-36-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes series v1 -> v2: new patch in series v2

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/virtio/virtio-serial.h | 5 +++++
 hw/char/virtio-serial-bus.c       | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index ed3e916b68..448615a6b3 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -33,7 +33,12 @@ struct virtio_serial_conf {
      OBJECT_GET_CLASS(VirtIOSerialPortClass, (obj), TYPE_VIRTIO_SERIAL_PORT)
 
 typedef struct VirtIOSerial VirtIOSerial;
+
+#define TYPE_VIRTIO_SERIAL_BUS "virtio-serial-bus"
 typedef struct VirtIOSerialBus VirtIOSerialBus;
+#define VIRTIO_SERIAL_BUS(obj) \
+      OBJECT_CHECK(VirtIOSerialBus, (obj), TYPE_VIRTIO_SERIAL_BUS)
+
 typedef struct VirtIOSerialPort VirtIOSerialPort;
 
 typedef struct VirtIOSerialPortClass {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f9a4428bd6..cf08ef9728 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -843,10 +843,6 @@ static Property virtser_props[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-#define TYPE_VIRTIO_SERIAL_BUS "virtio-serial-bus"
-#define VIRTIO_SERIAL_BUS(obj) \
-      OBJECT_CHECK(VirtIOSerialBus, (obj), TYPE_VIRTIO_SERIAL_BUS)
-
 static void virtser_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
-- 
2.26.2



Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D17A2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZapgdCAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D17A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihet-0004CC-O9
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHx-0004CS-B8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHr-0003D4-9g
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxvAoQs0pzlxnw/VTKjCtG+APSEJUAnDcimtibXU1t4=;
 b=ZapgdCAyh8CikEkg8dRkKqpxUXpbhCz45tMAwNX+1w1cyTqZRjDnf55feLRb87A6d5N1IB
 /GyYdaAlL5lHjfF7FmcjG5nK+uIjKVvj6uoYUpVyfD0yOKKfhR0J5cq0gi0aIiGOt5d5FK
 icUFHrBx93sXyD8a7qBjLzSh9ILcc4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-UYUzbzoQMUizmnwyBa5Q9Q-1; Tue, 09 Jun 2020 12:39:40 -0400
X-MC-Unique: UYUzbzoQMUizmnwyBa5Q9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D2EF3640C;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40FD86111F;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 102AC113846D; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/39] ssi: Convert last use of ssi_create_slave_no_init()
 manually
Date: Tue,  9 Jun 2020 18:39:17 +0200
Message-Id: <20200609163932.1566209-25-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform this case is not worthwhile.

Cc: Alistair Francis <alistair@alistair23.me>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ssi/ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 54106f5ef8..58e7d904db 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -16,6 +16,7 @@
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 
 struct SSIBus {
     BusState parent_obj;
@@ -96,9 +97,9 @@ DeviceState *ssi_create_slave_no_init(SSIBus *bus, const char *name)
 
 DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
 {
-    DeviceState *dev = ssi_create_slave_no_init(bus, name);
+    DeviceState *dev = qdev_new(name);
 
-    qdev_init_nofail(dev);
+    qdev_realize_and_unref(dev, &bus->parent_obj, &error_fatal);
     return dev;
 }
 
-- 
2.26.2



Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A408F207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAhXh93o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A408F207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3mF-0000KR-PM
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f1-0001C6-VH
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ez-0003V1-HG
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziz8lWYtC1XusP9DngvPcPngR7RESQ21ICk8LiGmLz0=;
 b=LAhXh93o4FOuQHqJwje1G1HAoEN2pPhvscrnvPtmAAnPSOzdGY7ib1E5psu7rp+33jobpu
 3VJJxGsH4pg99EBFvuEACEzG/6ss+UbPI2s5y3qke6kK2+Hx4aJho07xXGp3PQp2c/dxRi
 tN06Ul83cCdZXmrkYgRj5nW9TkWyQnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-FGvZfyw1MoKy1o810av7Uw-1; Tue, 19 May 2020 10:55:58 -0400
X-MC-Unique: FGvZfyw1MoKy1o810av7Uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F197081A3FF;
 Tue, 19 May 2020 14:55:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C170C5C1C8;
 Tue, 19 May 2020 14:55:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0EC6F11358D4; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/55] ssi: Convert last use of ssi_create_slave_no_init()
 manually
Date: Tue, 19 May 2020 16:55:19 +0200
Message-Id: <20200519145551.22836-24-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: pbonzini@redhat.com, Alistair Francis <alistair@alistair23.me>,
 berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform this case is not worthwhile.

Cc: Alistair Francis <alistair@alistair23.me>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.21.1



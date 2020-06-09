Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C9720737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXkWo3dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C9720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihQB-0006zS-6u
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHo-000458-Gg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHm-0003Bi-9N
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmfV2lyXxzyriLghLZNE7LX24yAODMlBXvgUNemIP7U=;
 b=HXkWo3dp2rk/f3yXtLS+XsotxfSpUUr3mV//bL9TO+ufMQ2Su+jrDN+DQfAiBh7usZqzB9
 BUMiixIEKWCjFQY1hmmx/g41iIrpHqKK0F1v171iA6Gc/fA3g+1GYvE6TgM+BGsAAIr1ao
 b85Q5QiVPdk6iEQUVwFdlwSx4Qbrbd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-NT3sX91qNDS-rxJ7BPqLvA-1; Tue, 09 Jun 2020 12:39:34 -0400
X-MC-Unique: NT3sX91qNDS-rxJ7BPqLvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8CCF18FE863
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A97095C1BD;
 Tue,  9 Jun 2020 16:39:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3167711385C2; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/39] qdev: Rename qbus_realize() to qbus_init()
Date: Tue,  9 Jun 2020 18:38:54 +0200
Message-Id: <20200609163932.1566209-2-armbru@redhat.com>
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

qbus_realize() does not actually realize.  Rename it to qbus_init().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 50924793ac..33a4443217 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -95,7 +95,7 @@ static void bus_reset_child_foreach(Object *obj, ResettableChildCallback cb,
     }
 }
 
-static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
+static void qbus_init(BusState *bus, DeviceState *parent, const char *name)
 {
     const char *typename = object_get_typename(OBJECT(bus));
     BusClass *bc;
@@ -151,7 +151,7 @@ void qbus_create_inplace(void *bus, size_t size, const char *typename,
                          DeviceState *parent, const char *name)
 {
     object_initialize(bus, size, typename);
-    qbus_realize(bus, parent, name);
+    qbus_init(bus, parent, name);
 }
 
 BusState *qbus_create(const char *typename, DeviceState *parent, const char *name)
@@ -159,7 +159,7 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
     BusState *bus;
 
     bus = BUS(object_new(typename));
-    qbus_realize(bus, parent, name);
+    qbus_init(bus, parent, name);
 
     return bus;
 }
-- 
2.26.2



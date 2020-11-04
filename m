Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC21C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20E320759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2EWaOYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20E320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMaE-0005mF-Us
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXF-0000zM-75
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXC-0008CT-RF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/E/VfVeQ6SgwgOxmEY2GWK/9ySHK0Bx88fxijhLB0l0=;
 b=c2EWaOYVEsySGCUAo7q5WSULwR3iaKDeA7V5V/dOU4fbXc5b6YqEPnhcJodn54hbkRTr5B
 RBoKXy6cwH8TdPclRj+bV3kthoqFf6YlozpU4YYGDyviF8rWI2XfKVyTfc62MIVkYSqc8m
 B82Tkk53MkujCcWQOFwYlVaiwB6ufB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-l_nZfuNiNhqSezBQijiOiA-1; Wed, 04 Nov 2020 12:25:20 -0500
X-MC-Unique: l_nZfuNiNhqSezBQijiOiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 156FE18A6280
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 17:25:19 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A79005D98F;
 Wed,  4 Nov 2020 17:25:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] qdev: Don't register unreadable legacy properties
Date: Wed,  4 Nov 2020 12:25:08 -0500
Message-Id: <20201104172512.2381656-4-ehabkost@redhat.com>
In-Reply-To: <20201104172512.2381656-1-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The existing code at qdev_class_add_legacy_property() will
register a property if both .print and .get are NULL, which is
useless as it will register a property that can't be read or
written.

The only PropertyInfo struct in the whole tree that has both
.print and .get set to NULL is qdev_prop_link.  This means every
link property in the code had a useless "legacy-" property being
registered.

Fix this by only registering legacy properties if a .print method
exists.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5bb4ff5f46..73884a212a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -264,13 +264,13 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
     g_autofree char *name = NULL;
 
     /* Register pointer properties as legacy properties */
-    if (!prop->info->print && prop->info->get) {
+    if (!prop->info->print) {
         return;
     }
 
     name = g_strdup_printf("legacy-%s", prop->qdev_prop_name);
     object_class_property_add(OBJECT_CLASS(dc), name, "str",
-        prop->info->print ? qdev_get_legacy_property : prop->info->get,
+        qdev_get_legacy_property,
         NULL, NULL, prop);
 }
 
-- 
2.28.0



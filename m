Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C802C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56B1206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou0A0VNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56B1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxWw-00011Y-4G
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHP-0003IN-Jz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHO-0003aj-CN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHO-0003Xw-45
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xs/xoP908nTLjxtzoFLOSupK1gag++XJXC66ml7AKow=;
 b=Ou0A0VNOo+g51/ZOMWgjlZJ9H2+070KAH9IZrNiu/wD3zFM1nZWqtGY2Woj7sokTtb74bu
 QpAgd2+tSakxn+MCMdz++jncvvOElup5lWJYOwQUEop2IyYJvceMX2fqoryos9fZEQgUS0
 P2G+Hc5U1SgJwZdwNkODCdrrE5ORRak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ffQIO9LgOb207rTS0i6pqQ-1; Mon, 16 Mar 2020 17:28:05 -0400
X-MC-Unique: ffQIO9LgOb207rTS0i6pqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 776B7801E66;
 Mon, 16 Mar 2020 21:28:04 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8151A19C4F;
 Mon, 16 Mar 2020 21:28:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/61] ich9: fix getter type for sci_int property
Date: Mon, 16 Mar 2020 22:26:45 +0100
Message-Id: <1584394048-44994-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Felipe Franciosi <felipe@nutanix.com>

When QOM APIs were added to ich9 in 6f1426ab, the getter for sci_int was
written using uint32_t. However, the object property is uint8_t. This
fixes the getter for correctness.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/lpc_ich9.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index d8186f5..2471463 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -629,9 +629,7 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor *=
v, const char *name,
                                  void *opaque, Error **errp)
 {
     ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
-    uint32_t value =3D lpc->sci_gsi;
-
-    visit_type_uint32(v, name, &value, errp);
+    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
 }
=20
 static void ich9_lpc_add_properties(ICH9LPCState *lpc)
@@ -639,7 +637,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
     static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
=20
-    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint32",
+    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
                         ich9_lpc_get_sci_int,
                         NULL, NULL, NULL, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CM=
D,
--=20
1.8.3.1




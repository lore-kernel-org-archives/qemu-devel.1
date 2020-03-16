Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A5C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C672120679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrqgPnJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C672120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxQM-0006O9-VY
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHP-0003HI-3K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHN-0003Wr-ON
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHN-0003Tc-HU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOhOQTXfi9/u88BP9ZPEQTKPFP6i3gc1TE6yZVu0S7I=;
 b=TrqgPnJwuWNg7+gGe0q3cmjZG53lc9A0RLgyBjtXW3G+sKSrXZ7xEqErDeRjwRfPnHzHfN
 T//T2lAA5moZC/XUZVoYLllwDTRxspLDXz4WBIoiDjEXt6rMchkq7EhGZHmweVlCJEDwXW
 ebzN2tr05XuqULnl+RvrE2L054wfk2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-J8hMuY60PPKYJiDOEYTrfA-1; Mon, 16 Mar 2020 17:28:06 -0400
X-MC-Unique: J8hMuY60PPKYJiDOEYTrfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D27AE800D50;
 Mon, 16 Mar 2020 21:28:05 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFC4E19C4F;
 Mon, 16 Mar 2020 21:28:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/61] ich9: Simplify ich9_lpc_initfn
Date: Mon, 16 Mar 2020 22:26:46 +0100
Message-Id: <1584394048-44994-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Currently, ich9_lpc_initfn simply serves as a caller to
ich9_lpc_add_properties. This simplifies the code a bit by eliminating
ich9_lpc_add_properties altogether and executing its logic in the parent
object initialiser function.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/lpc_ich9.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 2471463..3d0f4db 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -632,12 +632,14 @@ static void ich9_lpc_get_sci_int(Object *obj, Visitor=
 *v, const char *name,
     visit_type_uint8(v, name, &lpc->sci_gsi, errp);
 }
=20
-static void ich9_lpc_add_properties(ICH9LPCState *lpc)
+static void ich9_lpc_initfn(Object *obj)
 {
+    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
+
     static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
=20
-    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
+    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
                         ich9_lpc_get_sci_int,
                         NULL, NULL, NULL, NULL);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CM=
D,
@@ -645,14 +647,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_C=
MD,
                                   &acpi_disable_cmd, OBJ_PROP_FLAG_READ, N=
ULL);
=20
-    ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
-}
-
-static void ich9_lpc_initfn(Object *obj)
-{
-    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
-
-    ich9_lpc_add_properties(lpc);
+    ich9_pm_add_properties(obj, &lpc->pm, NULL);
 }
=20
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
--=20
1.8.3.1




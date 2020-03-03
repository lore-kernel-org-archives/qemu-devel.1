Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1EDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B3B214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+lH5K/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B3B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j93ck-00025V-J8
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j93bt-0001Fr-Sg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j93bs-0003Q4-O3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:13:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38570
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j93bs-0003Pb-LM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583226783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lD8sQW93kFH95IHAUQhhA3jFVbVgxvW2GcfHIpTgy5I=;
 b=P+lH5K/TwPYR0NQr4aCZYciM1txP5hIlXIJ+kyy5SvItZR5RARzbI+2YMysPm/JPKz3TZb
 a2+9apgfuBbm3GZLp6/7VY7P9zVUuvyAmsJqqSSW3StoJoe7lc8QSejNQJfzDk9rIt0qYo
 051gGaJf5fkaFjYD2Sv6XMXuB8AsP6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-z-_7_u8-O76xxr0oCn_vKA-1; Tue, 03 Mar 2020 04:13:00 -0500
X-MC-Unique: z-_7_u8-O76xxr0oCn_vKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFDD618C35A1;
 Tue,  3 Mar 2020 09:12:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A050F5C3FA;
 Tue,  3 Mar 2020 09:12:57 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
Date: Tue,  3 Mar 2020 04:12:54 -0500
Message-Id: <20200303091254.22373-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, drjones@redhat.com,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SOC object returned by object_new() is leaked in current code.
Set SOC parent explicitly to board and then unref to SOC object
to make sure that refererence returned by object_new() is taken
care of.

The SOC object will be kept alive by its parent (machine) and
will be automatically freed when MachineState is destroyed.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/cubieboard.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 089f9a30c1..12f8ac798d 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo =3D {
=20
 static void cubieboard_init(MachineState *machine)
 {
-    AwA10State *a10 =3D AW_A10(object_new(TYPE_AW_A10));
+    AwA10State *a10;
     Error *err =3D NULL;
=20
+    a10 =3D AW_A10(object_new(TYPE_AW_A10));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
+                              &error_abort);
+    object_unref(OBJECT(a10));
+
     object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
     if (err !=3D NULL) {
         error_reportf_err(err, "Couldn't set phy address: ");
--=20
2.18.1



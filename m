Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8941A206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hY2SWZYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8941A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHT0S-0004uf-Ol
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHSzr-0004TH-TH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHSzq-00088z-VS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:56:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHSzq-00088q-S3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585230994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fxngKB3n3H/APZAzYheqOCIOrULfa5FCCSkY14DVWqg=;
 b=hY2SWZYZHqU+oA7MsOe8rANtcg6dwKPY15mG+0677/3rWPUkgocU41MS7MRioiQ+mdiMGw
 9duL2Pj5dSnBoaEhwsIBzC8fobrRE6FoABXUKmpgGmOG1dxWMGsQIg79dyNyRbCy5OLPUe
 YaP/LtE8BMU0zD+C1uIL4jI4vQpmrTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-6pl3JBfnMwij3qs-iit3RA-1; Thu, 26 Mar 2020 09:56:31 -0400
X-MC-Unique: 6pl3JBfnMwij3qs-iit3RA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 829BD189F763;
 Thu, 26 Mar 2020 13:56:30 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DFE646;
 Thu, 26 Mar 2020 13:56:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] acpi: pcihp: fix left shift undefined behavior in
 acpi_pcihp_eject_slot()
Date: Thu, 26 Mar 2020 09:56:24 -0400
Message-Id: <20200326135624.32464-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity spots subj in following guest triggered code path
  pci_write(, data =3D 0) -> acpi_pcihp_eject_slot(,slots =3D 0)
     uinst32_t slot =3D ctz32(slots)
     ...
     ... =3D ~(1U << slot)
where 'slot' value is 32 in case 'slots' bitmap is empty.
'slots' is a bitmap and empty one shouldn't  do anything
so return early doing nothing if resulted slot value is
not valid (i.e. not in 0-31 range)

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 4dcef372bf..0dc963e983 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -154,7 +154,7 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, un=
signed bsel, unsigned slo
=20
     trace_acpi_pci_eject_slot(bsel, slot);
=20
-    if (!bus) {
+    if (!bus || slot > 31) {
         return;
     }
=20
--=20
2.18.1



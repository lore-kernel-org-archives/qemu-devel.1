Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B8C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106962469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i84RxmQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106962469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MM2-0001ck-8n
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7MKE-0007Ts-Dx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7MKB-0002KW-NF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:47:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7MKB-0002Im-5A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gK9XWtkpGiOo6PEXy0HMdjFzMma8f0WDT1xymEeTLCU=;
 b=i84RxmQqO0eQfpVbe+5zKJ73f/INR8N6PPegoovAqmdEMsLlTzLbCrviYCbl1e3gP3QBa1
 uR/I0gcBaIf3pLJzRSn4ZlDj52ToyvbkCXaqrOzAm7UHakFKLpBCWOqZT2HNeC35UdU/Q7
 m2Wi0O5CohEFrx+PyKpi7n2lHDz+M0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-RT-jS_1iMsaZXY3jAPYa-w-1; Thu, 27 Feb 2020 11:47:45 -0500
X-MC-Unique: RT-jS_1iMsaZXY3jAPYa-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA99C802560;
 Thu, 27 Feb 2020 16:47:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C12FC5C54A;
 Thu, 27 Feb 2020 16:47:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/arm/smmu-common: Simplify smmu_find_smmu_pcibus()
 logic
Date: Thu, 27 Feb 2020 17:47:28 +0100
Message-Id: <20200227164728.11635-3-philmd@redhat.com>
In-Reply-To: <20200227164728.11635-1-philmd@redhat.com>
References: <20200227164728.11635-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The smmu_find_smmu_pcibus() function was introduced (in commit
cac994ef43b) in a code format that could return an incorrect
pointer, which was then fixed by the previous commit.
We could have avoided this by writing the if() statement
differently. Do it now, in case this function is re-used.
The code is easier to review (harder to miss bugs).

Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This patch is easier to review with 'git-diff -w' (--ignore-all-space)

v3: Fixed typo reported by Eric
---
 hw/arm/smmu-common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 67d7b2d0fd..e13a5f4a7c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -290,20 +290,21 @@ inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iov=
a, IOMMUAccessFlags perm,
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
 {
     SMMUPciBus *smmu_pci_bus =3D s->smmu_pcibus_by_bus_num[bus_num];
+    GHashTableIter iter;
=20
-    if (!smmu_pci_bus) {
-        GHashTableIter iter;
-
-        g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
-        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)=
) {
-            if (pci_bus_num(smmu_pci_bus->bus) =3D=3D bus_num) {
-                s->smmu_pcibus_by_bus_num[bus_num] =3D smmu_pci_bus;
-                return smmu_pci_bus;
-            }
-        }
-        smmu_pci_bus =3D NULL;
+    if (smmu_pci_bus) {
+        return smmu_pci_bus;
     }
-    return smmu_pci_bus;
+
+    g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
+    while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
+        if (pci_bus_num(smmu_pci_bus->bus) =3D=3D bus_num) {
+            s->smmu_pcibus_by_bus_num[bus_num] =3D smmu_pci_bus;
+            return smmu_pci_bus;
+        }
+    }
+
+    return NULL;
 }
=20
 static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn=
)
--=20
2.21.1



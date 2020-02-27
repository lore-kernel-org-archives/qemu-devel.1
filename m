Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09559C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8326222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwtOmtfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8326222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Dy3-0006Lp-1t
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7DxB-0004yJ-4y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7DxA-00017D-0m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:51:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7Dx9-00016a-T2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582789887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2P0tgp1thgVauAKRqlUVXznUGVa1sRv7wi8xRwauGs=;
 b=KwtOmtfPIdyCDs82OXHekPR6nax0wyb3sL01QiyN01LjssRYIAf2OTjKBs50dwKPdZHVQm
 b55fC5VMjW6+JlEfXT8Wo2w6vqXhdEiu4oub7yu9I4EtM3pwpGXAVmK+MABdL0DIViyWac
 Sop1IMuRczM3T3gHa10IblRsZ+HxjW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-eAABnmyxP6WmatAsZpE2cw-1; Thu, 27 Feb 2020 02:51:25 -0500
X-MC-Unique: eAABnmyxP6WmatAsZpE2cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6037800D48;
 Thu, 27 Feb 2020 07:51:24 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AC785DA2C;
 Thu, 27 Feb 2020 07:51:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/arm/smmu-common: Simplify smmu_find_smmu_pcibus()
 logic
Date: Thu, 27 Feb 2020 08:51:11 +0100
Message-Id: <20200227075111.15275-3-philmd@redhat.com>
In-Reply-To: <20200227075111.15275-1-philmd@redhat.com>
References: <20200227075111.15275-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The smmu_find_smmu_pcibus() function was introduced (in commit
cac994ef43b) in a code format that could return an incorrect
pointer, which was then fixed by the previous commit.
We could have avoid this by writing the if() statement differently.
Do it now, in case this function is re-used. The code is easier to
review (harder to miss bugs).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This patch is easier to review with 'git-diff -w' (--ignore-all-space)
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



Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C98C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2ECD21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBeRouH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ECD21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j732b-00071H-48
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7318-0005WY-Iv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7317-0007cO-Bf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:10:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7317-0007bi-7R
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582747848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Uswvo93AQ5s785e9k0vQrys2oFD6LB/Mb/LaJZK4Mc=;
 b=FBeRouH8Niz05UGnVz+iTaP4PMQzFb0P5F7JwbykWRnVAwVD0qXcHKbeyhUgBKb34CFURE
 eiW+iGo6ZuL34cu1IU7t3YuGs8BCUSFTylCGwUbHC9d9zQrzPH7NseiO/1Z0nYVB+I6UdY
 FBFPIhjvybhZaLn9ktDF2lt6xEEngpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Ch3FMmtaP-2mzLnYL8m_iw-1; Wed, 26 Feb 2020 15:10:47 -0500
X-MC-Unique: Ch3FMmtaP-2mzLnYL8m_iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E853DB20;
 Wed, 26 Feb 2020 20:10:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97EFF5C28D;
 Wed, 26 Feb 2020 20:10:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num()
 logic
Date: Wed, 26 Feb 2020 21:10:30 +0100
Message-Id: <20200226201030.22583-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vtd_find_as_from_bus_num() function was introduced (in commit
dbaabb25f) in a code format that could return an incorrect pointer,
which was later fixed by commit a2e1cd41ccf.
We could have avoid this by writing the if() statement differently.
Do it now, in case this function is re-used. The code is easier to
review (harder to miss bugs).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Since v2: Re-worded commit description, patch sent without -w.

This patch is easier to review with 'git-diff -w' (--ignore-all-space):

@@ -987,14 +987,17 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, ui=
nt32_t level)
 static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_nu=
m)
 {
     VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
-    if (!vtd_bus) {
+    GHashTableIter iter;
+
+    if (vtd_bus) {
+        return vtd_bus;
+    }
+
     /*
      * Iterate over the registered buses to find the one which
      * currently hold this bus number, and update the bus_num
      * lookup table:
      */
-        GHashTableIter iter;
-
     g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
     while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
         if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
@@ -1002,9 +1005,8 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUSta=
te *s, uint8_t bus_num)
             return vtd_bus;
         }
     }
-        vtd_bus =3D NULL;
-    }
-    return vtd_bus;
+
+    return NULL;
 }
---
 hw/i386/intel_iommu.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6258c58ac9..e720a8939c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -987,24 +987,26 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, ui=
nt32_t level)
 static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_nu=
m)
 {
     VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
-    if (!vtd_bus) {
-        /*
-         * Iterate over the registered buses to find the one which
-         * currently hold this bus number, and update the bus_num
-         * lookup table:
-         */
-        GHashTableIter iter;
+    GHashTableIter iter;
=20
-        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
-        while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
-            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
-                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
-                return vtd_bus;
-            }
-        }
-        vtd_bus =3D NULL;
+    if (vtd_bus) {
+        return vtd_bus;
     }
-    return vtd_bus;
+
+    /*
+     * Iterate over the registered buses to find the one which
+     * currently hold this bus number, and update the bus_num
+     * lookup table:
+     */
+    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
+    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
+        if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
+            s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
+            return vtd_bus;
+        }
+    }
+
+    return NULL;
 }
=20
 /* Given the @iova, get relevant @slptep. @slpte_level will be the last le=
vel
--=20
2.21.1



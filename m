Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F5CC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AA920656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRFpRRJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AA920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iol3E-0002fG-1Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojRB-0008QO-Dx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojR9-0000YH-CJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:38:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojR9-0000Xp-8i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvaA+Bcc2Gxeb7XmQhJgoMxxUrIKTcdYM4rBXSKaGgM=;
 b=IRFpRRJOx2UuFDJnUz+gpbX1sIQa/UcpvW3Mov1GoAhPjik3k1Dcl54iqAoyBBMtV+HieK
 SFO1k00h+LVY4UkhD+oCutwoxVLkxqogePA/BlKt1yaEFpIGgkBuhofF+n578/ox9OE8OK
 6+Ek0Rn5weEvyY1p5RTG1xeEPBfZsSI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-lwJJX_C6OtGlEUbSnBzPFA-1; Tue, 07 Jan 2020 02:37:57 -0500
Received: by mail-qk1-f199.google.com with SMTP id 11so1073650qkk.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aNLKl1oKPF+kDyM8hwhwxdKmZvFLTYfwlNBJlJeT2zg=;
 b=OAsRnBzE89EUQ8kNL64U0f2Z1vryGUsrCtA+CWGU0HTgYEVvn3b8XQQORuccUR5j+Z
 UdhLt0xf7XJxDZbhd58l4qSgc5c5hjAFIg1xz7YPVIK2kn0PRxNJmFM8YjH3qR7RHSYi
 hQAhkhkaMDyntA6C8vCL2gUx8GcCjtQOgOSzOTiOHP5HoVCSqLSA+GqzD2ZCHNWP9eVD
 qN81F8FiAudMMXM4/tJ8MwWnEmY8Vnn9Knq84WPSzqDpGI48swZ4r+75cR5s9kL/mUr2
 xXtbNxYhxRcHnpv3zrddO1ju7Xw8e4YUyts42kaceP0p0AnlnhmpSLVbYYkB+ZP/p/My
 DywQ==
X-Gm-Message-State: APjAAAX0W7hudEMHEXaahU+sVFYysssbFuHOnXe0ZZi1f+Y3VHUpkJXM
 nkZzbqGbTOcqYl5VrmY2/o7ngZBMtQADFlzCrZDzC9+ZfudqAZLsJTcv9fAUJZqhoYaiHsGAK/Q
 qXvCVm4kgxnj2dQY=
X-Received: by 2002:ac8:fae:: with SMTP id b43mr77177632qtk.122.1578382676810; 
 Mon, 06 Jan 2020 23:37:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8h5b/WEK/65xUI9oWNKNah/cUPsqlWkg/0sMJ1AESErN/KqiQA4BhfkOw10NqINfB8g2Qxw==
X-Received: by 2002:ac8:fae:: with SMTP id b43mr77177614qtk.122.1578382676608; 
 Mon, 06 Jan 2020 23:37:56 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 206sm21934715qkf.132.2020.01.06.23.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:55 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 32/32] intel_iommu: add present bit check for pasid table
 entries
Message-ID: <20200107073451.298261-33-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: lwJJX_C6OtGlEUbSnBzPFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

The present bit check for pasid entry (pe) and pasid directory
entry (pdire) were missed in previous commits as fpd bit check
doesn't require present bit as "Set". This patch adds the present
bit check for callers which wants to get a valid pe/pdire.

Cc: qemu-stable@nongnu.org
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Message-Id: <1578058086-4288-3-git-send-email-yi.l.liu@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 92 +++++++++++++++++++++++++++-------
 2 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index edcf9fc9bb..862033ebe6 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -479,6 +479,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disa=
ble */
=20
 /* PASID Granular Translation Type Mask */
+#define VTD_PASID_ENTRY_P              1ULL
 #define VTD_SM_PASID_ENTRY_PGTT        (7ULL << 6)
 #define VTD_SM_PASID_ENTRY_FLT         (1ULL << 6)
 #define VTD_SM_PASID_ENTRY_SLT         (2ULL << 6)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 609b80750a..a523ef0e65 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -686,9 +686,18 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x8=
6_iommu,
     return true;
 }
=20
-static int vtd_get_pasid_dire(dma_addr_t pasid_dir_base,
-                              uint32_t pasid,
-                              VTDPASIDDirEntry *pdire)
+static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
+{
+    return pdire->val & 1;
+}
+
+/**
+ * Caller of this function should check present bit if wants
+ * to use pdir entry for futher usage except for fpd bit check.
+ */
+static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
+                                         uint32_t pasid,
+                                         VTDPASIDDirEntry *pdire)
 {
     uint32_t index;
     dma_addr_t addr, entry_size;
@@ -703,18 +712,22 @@ static int vtd_get_pasid_dire(dma_addr_t pasid_dir_ba=
se,
     return 0;
 }
=20
-static int vtd_get_pasid_entry(IntelIOMMUState *s,
-                               uint32_t pasid,
-                               VTDPASIDDirEntry *pdire,
-                               VTDPASIDEntry *pe)
+static inline bool vtd_pe_present(VTDPASIDEntry *pe)
+{
+    return pe->val[0] & VTD_PASID_ENTRY_P;
+}
+
+static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
+                                          uint32_t pasid,
+                                          dma_addr_t addr,
+                                          VTDPASIDEntry *pe)
 {
     uint32_t index;
-    dma_addr_t addr, entry_size;
+    dma_addr_t entry_size;
     X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
=20
     index =3D VTD_PASID_TABLE_INDEX(pasid);
     entry_size =3D VTD_PASID_ENTRY_SIZE;
-    addr =3D pdire->val & VTD_PASID_TABLE_BASE_ADDR_MASK;
     addr =3D addr + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr, pe, entry_size)) {
         return -VTD_FR_PASID_TABLE_INV;
@@ -732,25 +745,54 @@ static int vtd_get_pasid_entry(IntelIOMMUState *s,
     return 0;
 }
=20
-static int vtd_get_pasid_entry_from_pasid(IntelIOMMUState *s,
-                                          dma_addr_t pasid_dir_base,
-                                          uint32_t pasid,
-                                          VTDPASIDEntry *pe)
+/**
+ * Caller of this function should check present bit if wants
+ * to use pasid entry for futher usage except for fpd bit check.
+ */
+static int vtd_get_pe_from_pdire(IntelIOMMUState *s,
+                                 uint32_t pasid,
+                                 VTDPASIDDirEntry *pdire,
+                                 VTDPASIDEntry *pe)
+{
+    dma_addr_t addr =3D pdire->val & VTD_PASID_TABLE_BASE_ADDR_MASK;
+
+    return vtd_get_pe_in_pasid_leaf_table(s, pasid, addr, pe);
+}
+
+/**
+ * This function gets a pasid entry from a specified pasid
+ * table (includes dir and leaf table) with a specified pasid.
+ * Sanity check should be done to ensure return a present
+ * pasid entry to caller.
+ */
+static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
+                                       dma_addr_t pasid_dir_base,
+                                       uint32_t pasid,
+                                       VTDPASIDEntry *pe)
 {
     int ret;
     VTDPASIDDirEntry pdire;
=20
-    ret =3D vtd_get_pasid_dire(pasid_dir_base, pasid, &pdire);
+    ret =3D vtd_get_pdire_from_pdir_table(pasid_dir_base,
+                                        pasid, &pdire);
     if (ret) {
         return ret;
     }
=20
-    ret =3D vtd_get_pasid_entry(s, pasid, &pdire, pe);
+    if (!vtd_pdire_present(&pdire)) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    ret =3D vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
     if (ret) {
         return ret;
     }
=20
-    return ret;
+    if (!vtd_pe_present(pe)) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    return 0;
 }
=20
 static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
@@ -763,7 +805,7 @@ static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *=
s,
=20
     pasid =3D VTD_CE_GET_RID2PASID(ce);
     pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(ce);
-    ret =3D vtd_get_pasid_entry_from_pasid(s, pasid_dir_base, pasid, pe);
+    ret =3D vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
=20
     return ret;
 }
@@ -781,7 +823,11 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     pasid =3D VTD_CE_GET_RID2PASID(ce);
     pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(ce);
=20
-    ret =3D vtd_get_pasid_dire(pasid_dir_base, pasid, &pdire);
+    /*
+     * No present bit check since fpd is meaningful even
+     * if the present bit is clear.
+     */
+    ret =3D vtd_get_pdire_from_pdir_table(pasid_dir_base, pasid, &pdire);
     if (ret) {
         return ret;
     }
@@ -791,7 +837,15 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
         return 0;
     }
=20
-    ret =3D vtd_get_pasid_entry(s, pasid, &pdire, &pe);
+    if (!vtd_pdire_present(&pdire)) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    /*
+     * No present bit check since fpd is meaningful even
+     * if the present bit is clear.
+     */
+    ret =3D vtd_get_pe_from_pdire(s, pasid, &pdire, &pe);
     if (ret) {
         return ret;
     }
--=20
MST



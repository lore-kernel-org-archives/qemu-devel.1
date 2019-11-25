Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51544C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D4E2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU4GzM65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D4E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZA2m-0001rQ-7H
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iZ9zI-0006Ha-5j
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iZ9zG-0004sG-Tq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iZ9zG-0004rn-Pj
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574671490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=45c5KCczi1tP3fiyHcZsacUONdbQ9bDohml2FobiC7Y=;
 b=JU4GzM659mmM/Qs96ESNgNBKwImU1dK/Vh4gtwXTYVZ6/sbOfScBWeeIyltTVbzl/rxBdk
 WiqGuPKS6mUnZp/P1Dqor6l11CkAiSjJAn2NfZIWRNqYuA2bxXBNGLQFmf4NbnQrkiovGd
 Rrj55bpFw/0WWWI8R4VgzrSg5uJjm+A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-QNAo_V4nOse9nqTRLey8zA-1; Mon, 25 Nov 2019 03:44:49 -0500
Received: by mail-qk1-f198.google.com with SMTP id e23so4912435qka.23
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 00:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1895WEugstjfjj7PAHfEW6CWz8RPn3MsU9+lve0kccY=;
 b=acHhyk1kRUqorQE/5pp4ZR2rjwWkKMVSRKCdR0HZBjqiYYeD8HCnsJS3p/UD6Kjk9b
 IhwfELks90bOteOfa6i2XuE5IKyJ47RBMMQ5wLKK/1d0bdwGHGXnfbhKPWt283UKQ7+w
 q4573lk514JGlWxx4xuaxlPOJ56/ngtRUsC+FDcD/yuIJnvIpNOKOHWylj1hSwQ64fzZ
 EYOshYi1dmpaPr6P4mug2MSO+rZKgfz0S1Ws/NZ7kNFuuzVnFcsOt2NkmD5Bl5wM1eKl
 g6qeF0BBzpnGzHufwqw4QugxbfoNzPkr7XvJW6ofWOvN8kxQTv/5KdvX9g4Clce/FXQh
 qJNQ==
X-Gm-Message-State: APjAAAV3y7duAqbp/xyNfBlU7/uE/QtqDli1iNmYe4upRLrF0XShhVJX
 6dTSgEHJluvjg5YD8vTilAu9dfBz514YoribLh5S0uSlR30/TqMH4wzLyFSKA4LahrkidBY3g0o
 IIVMxf7twi7E14t0=
X-Received: by 2002:a0c:ba9e:: with SMTP id x30mr26357879qvf.187.1574671488117; 
 Mon, 25 Nov 2019 00:44:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyktovf/NwCLn8LmNLHyCySE6hFAkyGUpbFeV2BpAth+0vxFJHXlf7TgEGZ690OGmvr5irwQA==
X-Received: by 2002:a0c:ba9e:: with SMTP id x30mr26357866qvf.187.1574671487848; 
 Mon, 25 Nov 2019 00:44:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id k7sm3031437qkf.40.2019.11.25.00.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 00:44:47 -0800 (PST)
Date: Mon, 25 Nov 2019 03:44:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] intel_iommu: TM field should not be in reserved bits
Message-ID: <20191125084403.324866-4-mst@redhat.com>
References: <20191125084403.324866-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191125084403.324866-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: QNAo_V4nOse9nqTRLey8zA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qi <qi1.zhang@intel.com>, Qi@redhat.com,
 Peter Xu <peterx@redhat.com>, Zhang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Qi, Yadong" <yadong.qi@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Qi, Yadong" <yadong.qi@intel.com>

When dt is supported, TM field should not be Reserved(0).

Refer to VT-d Spec 9.8

Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
Message-Id: <20191125003321.5669-3-yadong.qi@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c          |  9 ++++++---
 hw/i386/intel_iommu_internal.h | 13 ++++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index feb9e55f87..43c94b993b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3554,13 +3554,16 @@ static void vtd_init(IntelIOMMUState *s)
      * Rsvd field masks for spte
      */
     vtd_spte_rsvd[0] =3D ~0ULL;
-    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
+                                                  x86_iommu->dt_supported)=
;
     vtd_spte_rsvd[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
=20
-    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
+                                                         x86_iommu->dt_sup=
ported);
+    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
+                                                         x86_iommu->dt_sup=
ported);
=20
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |=3D VTD_ECAP_IR | VTD_ECAP_MHMV;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 1654f746bc..edcf9fc9bb 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -387,7 +387,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
=20
 /* Rsvd field masks for spte */
-#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
+#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
+        dt_supported ? \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
@@ -396,9 +398,13 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
=20
-#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
+#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
+        dt_supported ? \
+        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) :=
 \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
+#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
+        dt_supported ? \
+        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM))=
 : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
=20
 /* Information about page-selective IOTLB invalidate */
@@ -503,5 +509,6 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SL_W                    (1ULL << 1)
 #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(=
aw))
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
+#define VTD_SL_TM                   (1ULL << 62)
=20
 #endif
--=20
MST



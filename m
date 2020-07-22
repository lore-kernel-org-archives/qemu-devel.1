Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145C2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D272D20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXs8/TB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D272D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDdL-0004Ta-32
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZB-0006MH-A1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZ9-0006ce-Ry
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wDvsvCaBwdrJqf7RMuYB7bfyjGAb+lmSiWDQNBJSIR8=;
 b=PXs8/TB4DYsUoKV3rSPQEjWdTgx9JsyOhrl5whKfp4ffN/EOKdIEkZBu73kFxALXyeovsn
 oBCWS6NrndHySC1kc936AJ7zqf+L3be9NjXuxvsf7J00cvWHoAHsSnxNBeVvAOxCnQ+6Sa
 MZhLZR9JtIjyH6Jgn7qpbIYHjGv6pg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Y8-vRl4jPlmDiAoEUVskbQ-1; Wed, 22 Jul 2020 08:09:39 -0400
X-MC-Unique: Y8-vRl4jPlmDiAoEUVskbQ-1
Received: by mail-wm1-f71.google.com with SMTP id h205so1036631wmf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wDvsvCaBwdrJqf7RMuYB7bfyjGAb+lmSiWDQNBJSIR8=;
 b=YpAimnGkC39cF3hRBERpWMLuwvVWfd/fre0obuCeSaF3GHJPmFp1Gx9w9CjH/9YZx9
 aig3w7i/3c6MOoeede7CupMDP7ShTFqwKcopzIJmcTEc5vml6tAa+viD7Qsx4F63Rksf
 nn8l/BVUWHGhGkCcPSccIgdgaVI77lKoLD/MIKzOElGAxYO8eCRNR8Qq7byy/I6ZrEuM
 17sRwEp8OWE+fOfZTXUmJDlahY7EgopboN5Wxfzyb3LN/pf/f1pOSHEa4VhaNkv5zPAR
 6SjOlp/kzxQFPpwz9cuQ15GuQeS2HXnQhDVMhLOth2/f7mLIP4xzGmHOIUe9+hHCOD+B
 y7CQ==
X-Gm-Message-State: AOAM533UVn3UJBEx8LKp3f8g9HDLrWx2t48JCKxyl4v9TpoNlqdUMx7o
 iOv0tC3+FTrLIJ2FNGIovoZBIeFvjZKjyDDuQIeHD5q+3lIMQICBE4SgY9Qj3fS66GTEnFAUXFM
 hWz2F/IvXzzZnzJg=
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr8982783wmu.52.1595419777539; 
 Wed, 22 Jul 2020 05:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfjiv2qzEtvxdvbc0PJy56jVOUotyFmi5wj1bub3BrnKfvHXPoPxA93ToknS61/3IqpcGsvg==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr8982765wmu.52.1595419777272; 
 Wed, 22 Jul 2020 05:09:37 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 g70sm3536676wmg.24.2020.07.22.05.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:36 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] intel_iommu: Use correct shift for 256 bits qi descriptor
Message-ID: <20200722120853.9144-9-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Liu Yi L <yi.l.liu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

In chapter 10.4.23 of VT-d spec 3.0, Descriptor Width bit was introduced
in VTD_IQA_REG. Software could set this bit to tell VT-d the QI descriptor
from software would be 256 bits. Accordingly, the VTD_IQH_QH_SHIFT should
be 5 when descriptor size is 256 bits.

This patch adds the DW bit check when deciding the shift used to update
VTD_IQH_REG.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Message-Id: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 3 ++-
 hw/i386/intel_iommu.c          | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 862033ebe6..3d5487fe2c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -230,7 +230,8 @@
 #define VTD_IQA_DW_MASK             0x800
 
 /* IQH_REG */
-#define VTD_IQH_QH_SHIFT            4
+#define VTD_IQH_QH_SHIFT_4          4
+#define VTD_IQH_QH_SHIFT_5          5
 #define VTD_IQH_QH_MASK             0x7fff0ULL
 
 /* ICS_REG */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c56398e991..0c286635cf 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2549,6 +2549,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
 /* Try to fetch and process more Invalidation Descriptors */
 static void vtd_fetch_inv_desc(IntelIOMMUState *s)
 {
+    int qi_shift;
+
+    /* Refer to 10.4.23 of VT-d spec 3.0 */
+    qi_shift = s->iq_dw ? VTD_IQH_QH_SHIFT_5 : VTD_IQH_QH_SHIFT_4;
+
     trace_vtd_inv_qi_fetch();
 
     if (s->iq_tail >= s->iq_size) {
@@ -2567,7 +2572,7 @@ static void vtd_fetch_inv_desc(IntelIOMMUState *s)
         }
         /* Must update the IQH_REG in time */
         vtd_set_quad_raw(s, DMAR_IQH_REG,
-                         (((uint64_t)(s->iq_head)) << VTD_IQH_QH_SHIFT) &
+                         (((uint64_t)(s->iq_head)) << qi_shift) &
                          VTD_IQH_QH_MASK);
     }
 }
-- 
MST



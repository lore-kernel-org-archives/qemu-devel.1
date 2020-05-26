Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B7B20704
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUBgL5Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B7B20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddWv-00032I-KX
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jddUW-0007Jz-Kc
 for qemu-devel@nongnu.org; Tue, 26 May 2020 13:35:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jddUU-0004h9-R4
 for qemu-devel@nongnu.org; Tue, 26 May 2020 13:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590514548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9QY8Q51pItvQreeWIlsdA9mHg+m2078KOFR/3hd7Gxk=;
 b=fUBgL5HmNZH0e67cFGK4Z7VMzYN+THD6hTHkf8bKT6qzGEFUjwLSwvhlYzi7VQ3pYNdbY2
 aGSXbasUCU3NzSPZs6J3lp/zlYAfYLlNVWFAF5qJVlCM/yKJuEJh92kXpexARyB2QKo/dz
 V5dOLIB6FzHyi/XOQKRvARdkiA2MMyA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-K8D0JCKSMEanXusPFaAHDw-1; Tue, 26 May 2020 13:35:46 -0400
X-MC-Unique: K8D0JCKSMEanXusPFaAHDw-1
Received: by mail-ed1-f69.google.com with SMTP id e1so9315641edn.14
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 10:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9QY8Q51pItvQreeWIlsdA9mHg+m2078KOFR/3hd7Gxk=;
 b=C2h1RMUkoZoZYnkreClNCS/Cj1kHjYb0rWIrpHgOP3mcrinBzJLWJntnP9eJ2V2qUv
 TyO3CxA2pzh/n9HzYQ5A7ElfpyCaLH6E4PnK4TPch4yodq9jJAF72z3+m8REb0hndUNv
 isJnUANaztVFe+JNpEdQyymGYXskrdcVhSNWpcj5ftIsiH23o19KORW8r7YG2fS+YHbf
 aT9b3+3nblQK+w3DknHUd1+l3rU6P+SIU2FPRqfww9W1f+NqtX/wDJ7XHMaMBc853oK7
 XYimlJIYP7GsfHRRrSC130fUYzGO1g94RFpayHW4hoy1aanwlOwcRNnVzgmsMthUnSNv
 LiyA==
X-Gm-Message-State: AOAM532sM6MlgVsPdwgPeGsooQLoQeDdqPh4G743sZD0SWDrJW8Uh9eS
 HTY8shzO3Pr13m9c38Da01BilwVHhdowo7Nv9q7Uno1acv8I+cN/cPkzw132+bZpZaREURSshta
 0+ZjudRR+xNImguU=
X-Received: by 2002:a50:b082:: with SMTP id j2mr21477927edd.201.1590514545160; 
 Tue, 26 May 2020 10:35:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD9NUFhURJxo0MIsNnjB84AhHRnm4Ur+7OmlV63fV2lVITWA1Noc1XRq7z40ItBN0eODbDSg==
X-Received: by 2002:a50:b082:: with SMTP id j2mr21477904edd.201.1590514544964; 
 Tue, 26 May 2020 10:35:44 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o25sm441491edt.66.2020.05.26.10.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:35:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
Date: Tue, 26 May 2020 19:35:42 +0200
Message-Id: <20200526173542.28710-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One might want to check which IOMMU version the host kernel
provide. Add a trace event to see in which mode we opened
our container.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/vfio/common.c     | 19 ++++++++++++++-----
 hw/vfio/trace-events |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..6b69a259c1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
 static int vfio_get_iommu_type(VFIOContainer *container,
                                Error **errp)
 {
-    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
-                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
+    static const struct {
+        int type;
+        const char *name;
+    } iommu[] = {
+        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
+        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
+        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
+        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
+    };
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
-        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
-            return iommu_types[i];
+    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
+        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
+            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].name);
+            return iommu[i].type;
         }
     }
+    trace_vfio_get_iommu_type(-1, "Not available or not supported");
     error_setg(errp, "No available IOMMU models");
     return -EINVAL;
 }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33f..8166c4c50d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
 vfio_dma_unmap_overflow_workaround(void) ""
+vfio_get_iommu_type(int iommu_type, const char *iommu_name) "IOMMU type %d (%s)"
 
 # platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
-- 
2.21.3



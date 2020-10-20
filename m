Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F6C388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4889F2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caLNDZQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4889F2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvVh-0000wZ-5c
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNo-0006fI-FH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNm-0007zz-I4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPTgcsyGuNMaq1KpOvK5NDZDqqsXCSXk7ysr+MEn7o0=;
 b=caLNDZQL+VS2JPqtnqUUSmNR0TWLEwUfgl4Gk5mLmJSjR+kg02YKO+3wWehrQzpD61a0Zl
 XOZmFNLE1SlpqyqemD3QvJ57reu3rC8qLfXsLW/Ze7Fl+iKcTYL7Xpx1sDlja1XS5/pYSF
 4jSPqcGjAU88x2c7sgSp2D2pHFDb6DY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-AmDWGNjCNei632n_vBxEog-1; Tue, 20 Oct 2020 13:25:07 -0400
X-MC-Unique: AmDWGNjCNei632n_vBxEog-1
Received: by mail-wr1-f72.google.com with SMTP id n14so1082959wrp.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NPTgcsyGuNMaq1KpOvK5NDZDqqsXCSXk7ysr+MEn7o0=;
 b=GVs0ii4URPo6YZYS7wINmMJOg5Ggz92HgePdnUC+U+kGOibAvmP/w52CPMi9U+KRgl
 mvQ+CNEilGFgWr5Q8ET8RjFTjQIqyrMS/VYZoO86+fJOzMJGhw65KcI9mjmlj5+ZpB5a
 tGgS00usTxHOCVolh+RybTBlbXe1O+zg4yjTJO2g/dRkr2LDJusQsSAaxzK7mQoEXShw
 97MWtOO9ZDj5Dpo8m5DneA3k286W1WirEUjRoRKpaxRfxQAHUHJB9vq5VARKODS6Ufnc
 o7T6/aveLO0G1a5TD+VDfTQ2zDqPLQ3n2BaBFPSc6rb0gO3FcM9cJrkagzajgMa74GAe
 /6dg==
X-Gm-Message-State: AOAM531QQBOdjFj2Oel2KH3lovSG9yND6uP1wyXG7NhW2N+WV9mi+85/
 QnWp251nJ67AuqpqJUdIh9WYbvf2KjyaSARlx4dxymp3AGnigzfGNGFWZn9uo03VH3AxRr4vP15
 3/4Ho2ILy0z5nAhA=
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr4116671wmj.89.1603214706560; 
 Tue, 20 Oct 2020 10:25:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTIb+5q7yEKp72ydfo56l3zX8thjfJUADnjRhdHe2cneHegiiLrzVGYRd4QwCD8iu+XOFo4w==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr4116643wmj.89.1603214706331; 
 Tue, 20 Oct 2020 10:25:06 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g5sm3666499wmi.4.2020.10.20.10.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] util/vfio-helpers: Trace where BARs are mapped
Date: Tue, 20 Oct 2020 19:24:19 +0200
Message-Id: <20201020172428.2220726-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debugging purpose, trace where a BAR is mapped.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 2 ++
 util/trace-events   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 4204ce55445..95e010bed6d 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -167,6 +167,8 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
     p = mmap(NULL, MIN(size, s->bar_region_info[index].size - offset),
              prot, MAP_SHARED,
              s->device, s->bar_region_info[index].offset + offset);
+    trace_qemu_vfio_pci_map_bar(index, s->bar_region_info[index].offset ,
+                                size, offset, p);
     if (p == MAP_FAILED) {
         error_setg_errno(errp, errno, "Failed to map BAR region");
         p = NULL;
diff --git a/util/trace-events b/util/trace-events
index a6a541270b7..7c92f2f8c1a 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -89,3 +89,4 @@ qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size %"PRId64" cap_ofs %"PRId32
+qemu_vfio_pci_map_bar(int index, uint64_t region_ofs, uint64_t region_size, int ofs, void *host) "map region bar#%d ofs 0x%"PRIx64" size %"PRId64" ofs %d host %p"
-- 
2.26.2



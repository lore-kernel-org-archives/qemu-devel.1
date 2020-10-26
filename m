Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE3C61DD8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FB32225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYDTJ2aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FB32225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0ES-0004eK-QF
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AD-0007N6-Fy
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0A9-0008Hb-8P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xorc1cOMXgP1kep2uzooHQ3r71AwjF7u/vtY5+daI0U=;
 b=WYDTJ2aKBHact6t3hMDDeE6umBy5KUyYSw1rzH3B+DS8bTUF+rO1dORQnyLKHgdCpqwKIL
 z+6TRpuQyG4PcjgssXabh0iNWQbQ53GvgZk2b+P7ylO1dsfHdrmZU6psZxcmxOVPi18EEa
 Te5CZnqnkAu7goVuFQNL1CAm/GWlaDo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-t2PGVpDrPby1jwqTKi78_g-1; Mon, 26 Oct 2020 06:55:39 -0400
X-MC-Unique: t2PGVpDrPby1jwqTKi78_g-1
Received: by mail-wm1-f71.google.com with SMTP id b23so295010wmj.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xorc1cOMXgP1kep2uzooHQ3r71AwjF7u/vtY5+daI0U=;
 b=SumMM0Y34YAdlO4jgKi3xy/vzRybVnN/Nat+eV2oKvu1awktGjF5IjQKHDBKCYPE3c
 wTZL3IpILPi6FiS7Tr7GWQ9LhBlXI8h7bCFLU7SghExv76BrE5+ciyheZzzWEqd6o9EC
 XGsWZ9C9nY2G/2tYLc/rCjN4VggIABwL3T0L2JCE1IukfpRUZ+enmr0PjXWPKHRYe8g9
 0yVIj54qUf7tM39b7aNjKRl1uIdYGVbsxenUnJricV++EUkX3n8rFVq1vQFnCjnS8Dht
 q9xccwlSNa5cw9G7D/Mf1Txwb371rEF0Q6UwNIioe0oWyEXT2ulvkwvz/qXtVthdgBWf
 xy2w==
X-Gm-Message-State: AOAM5300upQSxK7/BAGW+q5lIibE1Nfy2ZAhU1cgXyh5kwkOHRae3bj+
 xO8Op7szzYH87Za6utRMCTgs+0eCd5CMl1SJaFBVngXmXjHG8FGyV1M1QqMRzitqk2EhxZYTTCS
 gKdlGl/LT51TLiiI=
X-Received: by 2002:adf:9793:: with SMTP id s19mr17457425wrb.139.1603709735858; 
 Mon, 26 Oct 2020 03:55:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys/aSw6t9RJAorHXht+rIzJ8mb8Gig6JGeaVHaPsoeZO6xf5jx5zSDcBZHmDslg4IPZm+3Cg==
X-Received: by 2002:adf:9793:: with SMTP id s19mr17457396wrb.139.1603709735635; 
 Mon, 26 Oct 2020 03:55:35 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b5sm21563988wrs.97.2020.10.26.03.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/19] util/vfio-helpers: Trace PCI I/O config accesses
Date: Mon, 26 Oct 2020 11:54:51 +0100
Message-Id: <20201026105504.4023620-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We sometime get kernel panic with some devices on Aarch64
hosts. Alex Williamson suggests it might be broken PCIe
root complex. Add trace event to record the latest I/O
access before crashing. In case, assert our accesses are
aligned.

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 8 ++++++++
 util/trace-events   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 14a549510fe..1d4efafcaa4 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -227,6 +227,10 @@ static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
 {
     int ret;
 
+    trace_qemu_vfio_pci_read_config(buf, ofs, size,
+                                    s->config_region_info.offset,
+                                    s->config_region_info.size);
+    assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     do {
         ret = pread(s->device, buf, size, s->config_region_info.offset + ofs);
     } while (ret == -1 && errno == EINTR);
@@ -237,6 +241,10 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
 {
     int ret;
 
+    trace_qemu_vfio_pci_write_config(buf, ofs, size,
+                                     s->config_region_info.offset,
+                                     s->config_region_info.size);
+    assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     do {
         ret = pwrite(s->device, buf, size, s->config_region_info.offset + ofs);
     } while (ret == -1 && errno == EINTR);
diff --git a/util/trace-events b/util/trace-events
index 24c31803b01..c048f85f828 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -85,3 +85,5 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
+qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
+qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
-- 
2.26.2



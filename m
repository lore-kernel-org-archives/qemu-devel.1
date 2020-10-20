Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F60C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575A821D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITdBGJeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575A821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvUv-000812-8r
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNl-0006Xr-5i
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNj-0007zY-By
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vJfrvMuiaSUgd2BJasweCjCskoP5hMk59FTWXR5TQ4=;
 b=ITdBGJeXCU8pUJJvOLqlYb2rV/e0VE1otSt4VsfbhYGgpIdgAZIs+Wcob3dUEmI118JAcz
 op0Hf5epJrTYFjqnzFL/0QFNNqJ4/ijUqKmXNn+otAHi4PZ8aUbevnidm+lVk8duVR8lCr
 B5i7ZC+ebRr5Hycqwq+y1pdPUharUck=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-E1KUOwycNfSYAJqq3vU9Lg-1; Tue, 20 Oct 2020 13:25:02 -0400
X-MC-Unique: E1KUOwycNfSYAJqq3vU9Lg-1
Received: by mail-wm1-f69.google.com with SMTP id u207so699377wmu.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1vJfrvMuiaSUgd2BJasweCjCskoP5hMk59FTWXR5TQ4=;
 b=H+VDtiSQoQqIbEZhK96CcXG5Mlv0MZymLbOktyoRHT6jF97/D4UNWKHmfXo61gQEwc
 MI98ZP8KaBmAcHcBPdLQh2Ug3yrO86FjjB2VoFSZXs8zFvxo5odBqFl6ca7qeuiX9+q6
 i09PkQkQkXxFHr1qMF0DBdMA0qLfD9s13zsFSQEy9qXdOYf6RhLm1jqLBEfpMUa7ADK5
 QB+/dRnLB7xrCOaY0fHqONwcu+HoW6IrKY3blC5vXO7MZtYuqiSdG2Vsa56RAd0QqOXU
 cYFiQmB889ZP3F4Iou+DLe9RMaGei0YNPwDxI/b8XXiA8flBzEfKwxfqWocCRcQ9icVQ
 Mjww==
X-Gm-Message-State: AOAM531Fvbh3QRCK875rCrJPf4rD9+pICNJ02RXe92P/yfudNCszc+0z
 fbMuKSZUX2Gjk3IeaCk94K0gprc5l5EgGFnCOITSPMvmP1WVK8tko8QxAWpx+2yoKSWl+sfIrXW
 KKp7nnMJP9jvz88M=
X-Received: by 2002:a5d:488e:: with SMTP id g14mr4766423wrq.203.1603214701415; 
 Tue, 20 Oct 2020 10:25:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrGZ9MDGoRqBGHFRk0ZNlxEhHddRkKL8Ap7VKPmsoVz9RPDVwRmBNME9hpiuX25IN5fb6r9w==
X-Received: by 2002:a5d:488e:: with SMTP id g14mr4766405wrq.203.1603214701185; 
 Tue, 20 Oct 2020 10:25:01 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l26sm3581031wmi.41.2020.10.20.10.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] util/vfio-helpers: Trace PCI BAR region info
Date: Tue, 20 Oct 2020 19:24:18 +0200
Message-Id: <20201020172428.2220726-7-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debug purpose, trace BAR regions info.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 8 ++++++++
 util/trace-events   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index ac9cc20ce29..4204ce55445 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -137,6 +137,7 @@ static inline void assert_bar_index_valid(QEMUVFIOState *s, int index)
 
 static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
 {
+    g_autofree char *barname = NULL;
     assert_bar_index_valid(s, index);
     s->bar_region_info[index] = (struct vfio_region_info) {
         .index = VFIO_PCI_BAR0_REGION_INDEX + index,
@@ -146,6 +147,10 @@ static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
         error_setg_errno(errp, errno, "Failed to get BAR region info");
         return -errno;
     }
+    barname = g_strdup_printf("bar[%d]", index);
+    trace_qemu_vfio_region_info(barname, s->bar_region_info[index].offset,
+                                s->bar_region_info[index].size,
+                                s->bar_region_info[index].cap_offset);
 
     return 0;
 }
@@ -440,6 +445,9 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    trace_qemu_vfio_region_info("config", s->config_region_info.offset,
+                                s->config_region_info.size,
+                                s->config_region_info.cap_offset);
 
     for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
         ret = qemu_vfio_pci_init_bar(s, i, errp);
diff --git a/util/trace-events b/util/trace-events
index b697d2d5429..a6a541270b7 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -88,3 +88,4 @@ qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
+qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size %"PRId64" cap_ofs %"PRId32
-- 
2.26.2



Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ED5C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4099D2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLfqR1jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4099D2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvSO-00058y-UO
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNe-0006FX-CY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNc-0007xK-LV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LI/wka4VE+L12Rc09SXXqxJoCU9ZXTyFpCDUD5ks9I=;
 b=VLfqR1jNJ/9JtMKM1G4C29ZQCoB8ZzAhl4gd38VzwaUAJJtd6pYrW0ydfo3PUl81bRYz59
 3l1gy0l026ZmIbKjq025DzJnkR93TebQs2cADukKyUQX9qwTxx6VOavHOAFcW7XPlrsRsU
 k4xtBpVHRz1/aLFLW+wVaA05kDm8KGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-dleu-RyHMY2FhpRBJlTWBA-1; Tue, 20 Oct 2020 13:24:57 -0400
X-MC-Unique: dleu-RyHMY2FhpRBJlTWBA-1
Received: by mail-wm1-f69.google.com with SMTP id 13so707464wmf.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2LI/wka4VE+L12Rc09SXXqxJoCU9ZXTyFpCDUD5ks9I=;
 b=ev2MUjEQmpT7oGA7WDWF1exugG27X2U9V8l60vf3fupjzqpIw5TYiQ71Hy5/FWLD77
 8osiiLtLg+XjB0tcSLddqAXhjJzop0fHahP6wxFnmPur1WAzDv8YRrkBo8WsPyDi7QST
 PyzPQoBxuNDebVyoBKXSPnLyrA+LOva1UHFQaURvA+OprwhHU3S4ROhI07+TtADm7qxq
 N55jJnSIQlB1d/pLHiyb+/54LmbbcaMFyWAmPamdg3YurBscwfxObkS5tNiRS4whMM8+
 wKHhIG+Mlwr8LHJ0edEqFxWQUffRadaOzy0BsJy8QFqkKwyM67pp4AUx9dvGd7rshWJ9
 4YOw==
X-Gm-Message-State: AOAM533P1s6Q20rXasSvn2BjvokI/fZ39EaDzEmzzE93gnNlxOpT3PQD
 0bG2UJCxbAHwvQ5am7OYvikAak+kC6zDOLnij4pFg8AHW8hZ0EXifwITo+yiL/vT+WbdTh7KWt2
 uCtJPuHvqWJ2aqGk=
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr3943800wmk.134.1603214696116; 
 Tue, 20 Oct 2020 10:24:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeIB4TYfcnfxJqfsuyXCCVmFl0lEuz5mTeZ2Scrwh2ag0Nbi1WMje8I8bII3WNJdYbqt9MuQ==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr3943783wmk.134.1603214695879; 
 Tue, 20 Oct 2020 10:24:55 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v9sm3550439wmh.23.2020.10.20.10.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:24:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] util/vfio-helpers: Trace PCI I/O config accesses
Date: Tue, 20 Oct 2020 19:24:17 +0200
Message-Id: <20201020172428.2220726-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We sometime get kernel panic with some devices on Aarch64
hosts. Alex Williamson suggests it might be broken PCIe
root complex. Add trace event to record the latest I/O
access before crashing. In case, assert our accesses are
aligned.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 8 ++++++++
 util/trace-events   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index bce2cdb2f3c..ac9cc20ce29 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -228,6 +228,10 @@ static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
 {
     int ret;
 
+    trace_qemu_vfio_pci_read_config(buf, ofs, size,
+                                    s->config_region_info.offset,
+                                    s->config_region_info.size);
+    assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     do {
         ret = pread(s->device, buf, size, s->config_region_info.offset + ofs);
     } while (ret == -1 && errno == EINTR);
@@ -238,6 +242,10 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
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
index 19f03f14a33..b697d2d5429 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -86,3 +86,5 @@ qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
+qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
+qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
-- 
2.26.2



Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FE4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D458C21527
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsYZ45NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D458C21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfRo-0008UO-Nr
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLw-0000gF-Ce
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLu-0000Z2-Pn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yU8Zjc6YZ5nx4LM/74Erv9vHPc2KWWJeVlpqQoMWffM=;
 b=QsYZ45NQkd6CPPwqVN3b+1o0xhRmofbPfU350bFebnx7MAUcKvyT/Em4yrztcPFL4KerQg
 qYAX1XcS3ZXN8eCAQdqQ6fHNqhW1ovztq4lV+jUpYfsWQmaNGtqrELOTXhyW3fMdPKdLaE
 uhNw78YcmeEYE3bxCgIALB+LfL24Dbc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325--50oK70_M5qWrC_zbkWdfg-1; Wed, 14 Oct 2020 07:53:22 -0400
X-MC-Unique: -50oK70_M5qWrC_zbkWdfg-1
Received: by mail-wr1-f69.google.com with SMTP id j15so1170379wrd.16
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yU8Zjc6YZ5nx4LM/74Erv9vHPc2KWWJeVlpqQoMWffM=;
 b=Pztye5ARmC73SPbyhZFMYly8BVwkEKNIkj2q1DCmVvrD0Vjj1ccLXF3S4pbfeAG0jN
 wEUC4i6r8wzr83b3RzXyBrvyNMWmLrUJFnj+iVHH28pu4xQhWyjJLXgAgIGWWRfV+D2b
 H94ruajgBA5+faKGxS2SkrGOnj/TdextPEzxBhBh0r8ShmxB78nl91kzAIhj3BiatUdF
 xgCJMUDbGYlXfBj1zlOeFxdm4sOWB4sJKWYhYO92UD1myHsWtdh50PTQh9H+lB4FSwhQ
 ngV0vgJE5DVP2ca+w45cFezTcK6gnQ7/ksN9rHLyXIXhYUd9GvysJsnmIsTlvo9em4PN
 dGlw==
X-Gm-Message-State: AOAM531LIe1/vJ6hL1GxFweTgayCQomkpVcTJrRx+qNo0E86NBwcSSe7
 8eiHySNKtqx2/IlKhHwri5T1/jFuJH4bEQh/Yf1FzOHuh6EB71OiNkNGdVuosKDmQkNvqRBcrGw
 ukjbw4m6UEYbkL/Q=
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr5324222wrs.9.1602676400643;
 Wed, 14 Oct 2020 04:53:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT8YsjA/gYaG7S3t36BTM7n0091rf6FNRXvH7t9hIx4Al4509z7KYzcCXX3v5BiCRG6kmvVg==
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr5324201wrs.9.1602676400476;
 Wed, 14 Oct 2020 04:53:20 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x21sm4391584wmi.3.2020.10.14.04.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] util/vfio-helpers: Improve DMA trace events
Date: Wed, 14 Oct 2020 13:52:49 +0200
Message-Id: <20201014115253.25276-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014115253.25276-1-philmd@redhat.com>
References: <20201014115253.25276-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debugging purpose, trace where DMA regions are mapped.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 3 ++-
 util/trace-events   | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 278c54902e7..c24a510df82 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -627,7 +627,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
         .vaddr = (uintptr_t)host,
         .size = size,
     };
-    trace_qemu_vfio_do_mapping(s, host, size, iova);
+    trace_qemu_vfio_do_mapping(s, host, iova, size);
 
     if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
         error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
@@ -783,6 +783,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
             }
         }
     }
+    trace_qemu_vfio_dma_mapped(s, host, iova0, size);
     if (iova) {
         *iova = iova0;
     }
diff --git a/util/trace-events b/util/trace-events
index 50652761a58..8598066acdb 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -82,8 +82,9 @@ qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p size 0x%z
 qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
 qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size 0x%zx index %d iova 0x%"PRIx64
-qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
-qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
+qemu_vfio_do_mapping(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64 " size 0x%zx"
+qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d &iova %p"
+qemu_vfio_dma_mapped(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64" size 0x%zx"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
-- 
2.26.2



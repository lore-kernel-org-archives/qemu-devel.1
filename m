Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1047FC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559252224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH0aNAQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559252224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvY8-00055o-A1
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNv-0006uO-QB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNr-00081G-Vr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MW4hs5DRcbW11wvGN5ELRGGZ1et4xeNoJny0lCvYhm8=;
 b=iH0aNAQKftPI/hhlLu0dc7sL7ZI060+DM8toYEJtUP04FGRy8v59CQD9T8REJNDueJwoCF
 lg6a6FBqDFk0uMC4QgtINZw7WNY0cL/ro3FZqh7prLxb/HvuY49nm6ud2oprdyxlQ8uJ48
 BCyI3AEHnsrZjcgFNSlK3AcllNHlWpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-xOPL4GsTN1OBMhOgI4MU8g-1; Tue, 20 Oct 2020 13:25:13 -0400
X-MC-Unique: xOPL4GsTN1OBMhOgI4MU8g-1
Received: by mail-wr1-f69.google.com with SMTP id 47so1071417wrc.19
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MW4hs5DRcbW11wvGN5ELRGGZ1et4xeNoJny0lCvYhm8=;
 b=YviIslMQkZvyILf4aquhsZP/00vO8EhDEg+sZFZG6hgco5xi/Zl+tG+UdMgQA03aEJ
 fXrtXxHgKfO/EG2Z7N66k1mQFU4/E1XyfdEed68LV8Le7ZTVwYPR5L5a/fH6lWaiO03F
 ASyUb1aX4vJrpPBhg3LHDc7/daz/c/51xU19TDkYKByYWZ07UCNInzQupuuccnKcPkO6
 Mhb3qDcWaEaVxSNIXbYrdK+5Q0PDC+rSAVp7WkD9Fn32p/wIIu8w2+Lz34km6+ru47E4
 IQGnbD4nf1z7DNdu101s55aZzk2uKZLiUDDj07a5XogMoYkG8hrwrjkkgEqEkc/T/gCp
 Wl3Q==
X-Gm-Message-State: AOAM533+kC/ifme0K5N79JAt5/vChh/a2uhLOEMPI1SDhRkNzyjXQomZ
 ZwRdcBpK4FLdtQc1eZTrSDf+hqagirMowibB20OnNN3MQIucGJtQ/tgNclEYKel0CTV/KXknfD7
 3BBOM8BwmZ3Zs30U=
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr4007541wmj.109.1603214711416; 
 Tue, 20 Oct 2020 10:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLDDgRWubUohEK8dpkfSBjn0FTFvecDCkyxLXaVOvw6pSUm1kGfCvgn9OlAOMudFPTFLYD+w==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr4007520wmj.109.1603214711246; 
 Tue, 20 Oct 2020 10:25:11 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t7sm3872736wrx.42.2020.10.20.10.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] util/vfio-helpers: Improve DMA trace events
Date: Tue, 20 Oct 2020 19:24:20 +0200
Message-Id: <20201020172428.2220726-9-philmd@redhat.com>
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

For debugging purpose, trace where DMA regions are mapped.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 3 ++-
 util/trace-events   | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 95e010bed6d..98a377a01a8 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -657,7 +657,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
         .vaddr = (uintptr_t)host,
         .size = size,
     };
-    trace_qemu_vfio_do_mapping(s, host, size, iova);
+    trace_qemu_vfio_do_mapping(s, host, iova, size);
 
     if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
         error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
@@ -813,6 +813,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
             }
         }
     }
+    trace_qemu_vfio_dma_mapped(s, host, iova0, size);
     if (iova) {
         *iova = iova0;
     }
diff --git a/util/trace-events b/util/trace-events
index 7c92f2f8c1a..c396ef4d622 100644
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
 qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
-- 
2.26.2



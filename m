Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D830BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C732224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYLoZ6UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C732224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0LC-0002ni-E0
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AP-0007ZN-Dl
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AM-0008LC-Jz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTDiCm1rGvrFJ5fByXHjKqVGr/b2mgKYh7ZyBSdCJu4=;
 b=UYLoZ6UTja/A+FbLJf6r8HusvrbyAhupsMc8usACRhlbhW4wAO6r5ASLtBh4rBZzhv3eeX
 FtrycBbRoUVVLfsvo3GhOJ0Qj4qBHJOYp80ZeUyMMCGFqyfpYf1tISPB59tMDMzMfv1lpZ
 zEsLcl5SVYzwvWBNsdEt3Bmn6CV4jzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Pk5LbRDMPQCXJdJ6ZkKIEw-1; Mon, 26 Oct 2020 06:55:51 -0400
X-MC-Unique: Pk5LbRDMPQCXJdJ6ZkKIEw-1
Received: by mail-wm1-f69.google.com with SMTP id l22so5568593wmi.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tTDiCm1rGvrFJ5fByXHjKqVGr/b2mgKYh7ZyBSdCJu4=;
 b=IOMKJoXgbxFuZ6xkx4c32I05ZShIBWpn8dVgoa00Zuc3LXYZYpm9XrY+kKeJxs5EoN
 5vHiiCRYXsk09sAExUMeQfX2Dypz1iA+Mz5v6syJzKrjhaRodCGpvNydcmkXbWmF/0qU
 DCoztpuxHWgVZ/Nelqf0n4nSnI7MMdkOWUmXxcgNk53ydf2LEmQw88QdtxO8K5yiEMzD
 WpJAxgFve7dq3N888qHoeHzPUadcziMuIKT3qxkzSOdP3b1ToaQ6AUxSyJh2xB1erloi
 WRx4ibt6HyofeQsPR2lPRqjq8aMedkdYYQrWGyLxnrQyOr+2q5XNSPi++gYgAhE5L6Wf
 VRcQ==
X-Gm-Message-State: AOAM532CGQ/H8Yxed8ByBtCllYQw7Tw7GpqK8nqYzyfEg2Y9sabwhgye
 xNKG8hQ2VvHJOlZraGFP7lC+CeRExoWN9oxgljLbPcvqDUzOvn30euKtAr9guPGS0sm5SxwQ7HO
 HAkgE6tI6yMsLpjo=
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr15097207wmc.84.1603709750345; 
 Mon, 26 Oct 2020 03:55:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyymAlvMQrr5qixfkbvEz7AL/qM/tKYWyHCGrZgKjdmFtEVSJ64vxNFaoeMP9kiqfdFHz8WZg==
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr15097191wmc.84.1603709750217; 
 Mon, 26 Oct 2020 03:55:50 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v189sm19982587wmg.14.2020.10.26.03.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/19] util/vfio-helpers: Improve DMA trace events
Date: Mon, 26 Oct 2020 11:54:54 +0100
Message-Id: <20201026105504.4023620-10-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debugging purpose, trace where DMA regions are mapped.

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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



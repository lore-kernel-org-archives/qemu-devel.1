Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8A1C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E9022243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IonP4XRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E9022243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlp3-0005ux-MS
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlk2-0002Mc-9D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlk0-0003ee-G2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoEtmrvV7SWgD7QH62cY93Xnq1kvlQkCFqVy10vUni4=;
 b=IonP4XRm1aj8hEofNTYh7PTMnSEgVrKb5s0ThsLg0wACLE0xvb1GOWReHx5jSQOxM8gLtg
 3aN0shrD6EwYseIFTuwi9slKaPXGyn5mcJi1/foqcZRJcp6RgusS2lrvqe7mo0ub1yWYYX
 /MGK0DUmx3jL0dyr6o1Mwi2XogmL9U0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-6oUQFj28Po2wJaabPhDixA-1; Mon, 02 Nov 2020 21:08:06 -0500
X-MC-Unique: 6oUQFj28Po2wJaabPhDixA-1
Received: by mail-wr1-f71.google.com with SMTP id 33so7144907wrf.22
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OoEtmrvV7SWgD7QH62cY93Xnq1kvlQkCFqVy10vUni4=;
 b=ehaG62aFCJCbq/pN4K3BWAtOTA/Agq/HqV2iu0ZfSy4Lt1k90CYEI3S+cG7tEFwHme
 xPGDoPQLkn8zoL2xrNw+NdzYr+Z2ABKsBlQkJNkTmlA6Cq0lhv74lN/b2lkGvsnMc7nl
 mmvrq5qYKD4UU25WhqnVT3pMsnn3hIBobBc9OpCR0gvs9N/kUm1vViWxRqlErS9jfmu6
 OmLfCJqgDDVU/OegthU88DoRsLwRsO1JCqVuFPd30zXBzHOFfyZWkXH7tbhqch1SyplU
 9PwwEH5PypdvTYGQcTstwtxD/E4pKmFjk+55bIyvQcIDVNFvDp+CFpXRtl3ddJqsyd8f
 6L/A==
X-Gm-Message-State: AOAM5321us83SpSZeGplDQbWXs84Owt8tY3MdY5dFBKnP/ZcHxNgRKW5
 NGckQHKoWY0h0fHIbgPbsdRhFEahiNlnNWVwjSy7ptU6XPJ44sL5nbTG1Z76j9erwxid30E0sTM
 ME6WBYjkRIoGuZ1w=
X-Received: by 2002:adf:8362:: with SMTP id 89mr24024034wrd.280.1604369284569; 
 Mon, 02 Nov 2020 18:08:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymTpCXejYt2U6jaySc9x0vzhoAjtUSCOqYEmvtMUIPDtts2HO293Y66zTLdis78OgqJvDNTQ==
X-Received: by 2002:adf:8362:: with SMTP id 89mr24024020wrd.280.1604369284446; 
 Mon, 02 Nov 2020 18:08:04 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m14sm24224588wro.43.2020.11.02.18.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:08:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 5/7] util/vfio-helpers: Improve DMA trace events
Date: Tue,  3 Nov 2020 03:07:31 +0100
Message-Id: <20201103020733.2303148-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103020733.2303148-1-philmd@redhat.com>
References: <20201103020733.2303148-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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
index 52d43cda3f3..08239941cb2 100644
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
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
-- 
2.26.2



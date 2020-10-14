Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8214C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2634420848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UINg/XuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2634420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfMd-0001KO-4I
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLF-00085N-2Z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLC-0000TZ-MT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTNC5KDCZBOSstHZx3wGQ1e/sNtfzzFYB9WbTAF5Fvs=;
 b=UINg/XuUVBP/wNAdWFPXjR/kGLMN3unMZkxkRkzH13cPsncb94v0IhCOUUVFwAurE6ByfU
 jqVpJw4rNQpbG36e+RgPewKRHyE1OIDOk/zP77E3Pudte6wx52QPmcgUXLhIcWmZYsBOWQ
 uzDJNP5clprmjWDPHdiZ3OqHKO/GgOA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-n24OZpDPPB6ravOatiq9Tg-1; Wed, 14 Oct 2020 07:53:07 -0400
X-MC-Unique: n24OZpDPPB6ravOatiq9Tg-1
Received: by mail-wm1-f70.google.com with SMTP id 73so445964wma.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gTNC5KDCZBOSstHZx3wGQ1e/sNtfzzFYB9WbTAF5Fvs=;
 b=eftrSK8+dWBD2DKO24HgIJEjJK7AS7mDEYU2ueywfm+Tzio1/6lDa85ZUy4qUPUNTL
 ApH4lH7pq63GsJMmNZTZYAvSHUU1kvTUVjSYzNmRFtiYqgoep1SyIhO66tP0M/rZUWx4
 08q/jmy+cE6zl2Ah9YE0dmc1fvOk17Eyy24DhM6kZ2P2xURpYPJjwgAEUeb1U0HNiLae
 6MxM8OKM5ZFJNs6ki4FkWtT6soy8lNawoIZf/JbIgEINwzrVtSA0z0QGbMd/Ad65YVrv
 VRKeQ2Iv8iTnDfC6MazRzms8FAZFIzD/LMHQYrddohrA8TlvzxsSjSbHjnZIfdaG4Wlw
 Kjtg==
X-Gm-Message-State: AOAM530chqPqH4cBPE+zl9wqJogbzlD08nm+sagD9SA0K/vyPgA8vI82
 u8mB6wuLcBm1u5obR6A7Ch6qyPlrTJbSh/3sIS2EWel6tZPpHFmm0Kr6U+grUB0+3MNNHXN/C3T
 oVdJwRrR+QqUUWpI=
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr5601835wrn.204.1602676385763; 
 Wed, 14 Oct 2020 04:53:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtMH37I8lZRZav7+vZdgO3zaCYTYyHCZYU182Mm+8xVjmCgVz7lIIPWGObro4DGLBVEZpmDQ==
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr5601808wrn.204.1602676385567; 
 Wed, 14 Oct 2020 04:53:05 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h1sm4545855wrx.33.2020.10.14.04.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] util/vfio-helpers: Trace PCI I/O config accesses
Date: Wed, 14 Oct 2020 13:52:46 +0200
Message-Id: <20201014115253.25276-3-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Alex Williamson <alex.williamson@redhat.com>
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



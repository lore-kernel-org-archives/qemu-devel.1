Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1883C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EC322243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZjoA41B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EC322243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlrg-00082R-9o
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljs-0001yq-9O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljo-0003a2-SY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLkkDB5g34q2sdknoBBkQrWHPPoNrf02h2DP6CTPnmU=;
 b=VZjoA41BitK2TRauqmX6Tn1f4agRlzXd+Elup3H24A6dUx3o7jBvOK9lgcyKGCIaNKg3Xz
 VxIlv/7+GIlnAs3Xvg3Dsm3CninqW8kIYaFZbxYTRMtrAfJ6QlZt4/7d/eRnO4Z+lkTwL/
 Q3a2+0FcTu9/jrsdNiNV/ekOiY8UyLA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-GnRI6k0FNfKBYlqbhX8gKw-1; Mon, 02 Nov 2020 21:07:49 -0500
X-MC-Unique: GnRI6k0FNfKBYlqbhX8gKw-1
Received: by mail-wr1-f72.google.com with SMTP id f11so7179067wro.15
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MLkkDB5g34q2sdknoBBkQrWHPPoNrf02h2DP6CTPnmU=;
 b=B0tWsCBFofLSC+B+Fj51JpSNQEEFFUweGH08xzz1Y9z+NcfwK8jLGwN0wbg007C/33
 O2ew+gsvB90XQyMPE53NjghCzUTdQV2P65GI6RZEb76EYOPhsaTaQm6Xmx0FgZha1sKW
 GrHYmNMfqoSBWWwL7HA08jQJ4I8nWLknI+f8ZtrRuo4OOKE+iprHC+XeHEr64uCLVggo
 BR0DPJZCBQebbDB0EgRNKdlFqMAsNNOAATrjLPAayAjRUHlUGLx3dKJ+BtlBMRJp7Fl2
 lqq6uIUsTmzBA6up+j2a7wkF/B/dtDLEGfp+fPwgDEkHkomjwkxma+25rVpL+qMHTqNE
 inPg==
X-Gm-Message-State: AOAM531agNuuJA+EOEh9LrrqeTDkia6cEoSLZQkHqUe8RT2gK7CRqRyF
 1lKHSAEzXzRu/30cxtd9QhaezqmGdglg+kg0A65WrRt70xI2Y3I3sw7qesXBSOQWjBxBlgBTbSF
 iw+GisLqYRCHAAUk=
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr985277wma.134.1604369267784; 
 Mon, 02 Nov 2020 18:07:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL9WAmq+sWghRddGGS1Ke1/vUvlOf9zvZqrzfrJssBSClaHI3vsFJdCkNmgkd6T7YMJlGUJQ==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr985263wma.134.1604369267628; 
 Mon, 02 Nov 2020 18:07:47 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x21sm1551217wmi.3.2020.11.02.18.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:07:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 2/7] util/vfio-helpers: Trace PCI I/O config
 accesses
Date: Tue,  3 Nov 2020 03:07:28 +0100
Message-Id: <20201103020733.2303148-3-philmd@redhat.com>
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
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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
index 24c31803b01..8d3615e717b 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -85,3 +85,5 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
+qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
+qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
-- 
2.26.2



Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9312AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0592F2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqCg/DVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0592F2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvXO-0003jn-02
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNy-0006yV-V1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNx-00085g-6g
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mi5DaGV/dUkNCqis66cfyN2SFYA8ra8zeOd97LUT8kU=;
 b=AqCg/DVe1FCJjuS4VXLl+QTTiifsPY/yU4xxdeTpYdPuu7zfErWteTl6B4KZn9aQO1F4Iu
 DVNA5bD7cltWkyjbb/9YNRXbFLdILQ6baXqgtPdfsX0jcX08OKyBvdhKPvDnjPQw7OtgJJ
 e0JV3mL9UJRCvEYek0yzkcn+7W+0/20=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-AeKxyWpEP1CdsQmUUa6dZw-1; Tue, 20 Oct 2020 13:25:18 -0400
X-MC-Unique: AeKxyWpEP1CdsQmUUa6dZw-1
Received: by mail-wr1-f70.google.com with SMTP id x16so1071088wrg.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mi5DaGV/dUkNCqis66cfyN2SFYA8ra8zeOd97LUT8kU=;
 b=I4Xtp7cVIAlfCh1NGNvZOHECb1vxCEDObNoubuDU4CTTOhAsuVWP1kHn9xFvYVw+9K
 MoB5VuBEj4QG2MFcPiTbHDSHwBec1PF2txBwsWbb64Ne+GXf9dYFOdnVbZhKk1w0D74Q
 jARlAOwP1F2cE5ncX17Aq8QGik/6y9P6CZUAqRiP0nGTBQPln/LjU6480h/hMa0ubSEx
 G4KSZmkN3LwF3XLw9bmGnp0mp6LuKl1Sm2O6wat/YiWfHllxP2Sue/blX9rAA1CjpdtB
 pRKVARNss3I/uJKHCZKH9WmdDthr95HFanj6BLoBxaN4il9Ol+H3jb1ElDBVTCU7fe5I
 GmYA==
X-Gm-Message-State: AOAM530N7CKPsg4X1Q1/T3KVDxmY07lTakj5Jg9VYwMmFJtyz5ObC4EU
 Une6p4O1ZAYyakJ2n0xetZ6CfojYyX25lG2zyb8UFS1NDWpJxZcQ5kl3d2DhfwpnqYDDlJtUEru
 p0enk3OvyJtjfzHY=
X-Received: by 2002:a5d:424e:: with SMTP id s14mr5132806wrr.149.1603214716591; 
 Tue, 20 Oct 2020 10:25:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG9hQMQCJr8oW3+wIRBf+VgqLQBPOtr895Dwm9KyVx/mzvfA40fqLkQga0OZhK2VjPwQnJZw==
X-Received: by 2002:a5d:424e:: with SMTP id s14mr5132786wrr.149.1603214716352; 
 Tue, 20 Oct 2020 10:25:16 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u15sm3424259wml.21.2020.10.20.10.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] util/vfio-helpers: Convert vfio_dump_mapping to trace
 events
Date: Tue, 20 Oct 2020 19:24:21 +0200
Message-Id: <20201020172428.2220726-10-philmd@redhat.com>
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

The QEMU_VFIO_DEBUG definition is only modifiable at build-time.
Trace events can be enabled at run-time. As we prefer the latter,
convert qemu_vfio_dump_mappings() to use trace events instead
of fprintf().

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 19 ++++---------------
 util/trace-events   |  1 +
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 98a377a01a8..6a5100f4892 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -551,23 +551,12 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
     return s;
 }
 
-static void qemu_vfio_dump_mapping(IOVAMapping *m)
-{
-    if (QEMU_VFIO_DEBUG) {
-        printf("  vfio mapping %p %" PRIx64 " to %" PRIx64 "\n", m->host,
-               (uint64_t)m->size, (uint64_t)m->iova);
-    }
-}
-
 static void qemu_vfio_dump_mappings(QEMUVFIOState *s)
 {
-    int i;
-
-    if (QEMU_VFIO_DEBUG) {
-        printf("vfio mappings\n");
-        for (i = 0; i < s->nr_mappings; ++i) {
-            qemu_vfio_dump_mapping(&s->mappings[i]);
-        }
+    for (int i = 0; i < s->nr_mappings; ++i) {
+        trace_qemu_vfio_dump_mapping(s->mappings[i].host,
+                                     s->mappings[i].iova,
+                                     s->mappings[i].size);
     }
 }
 
diff --git a/util/trace-events b/util/trace-events
index c396ef4d622..3c36def9f30 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -80,6 +80,7 @@ qemu_mutex_unlock(void *mutex, const char *file, const int line) "released mutex
 qemu_vfio_dma_reset_temporary(void *s) "s %p"
 qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
+qemu_vfio_dump_mapping(void *host, uint64_t iova, size_t size) "vfio mapping %p to iova 0x%08" PRIx64 " size 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
 qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size 0x%zx index %d iova 0x%"PRIx64
 qemu_vfio_do_mapping(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64 " size 0x%zx"
-- 
2.26.2



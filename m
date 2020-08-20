Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9636EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A26208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWbkb2We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A26208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o5h-0002yR-Lp
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8o4w-0002HC-0q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:10:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25357
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8o4u-0007jK-EW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597943411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=89jXPVPv2kkdtYzqNRsIdICSTxnn4TeU97yfa4KTTPA=;
 b=WWbkb2WeXdWjxMjijOIsd7WmcHPF6OpKhXly5cbyVoZgv9y43s9/KU0n8ncleQLmvSqt2Q
 2sutcJC/3BHm9On2MjCVCW4T91QQWM7veMegga0806JNf5R2SsS/AqEm99sEPMmZvMaQg2
 VdlTPynyExnSn6tZJrUoH/y2WZb6txw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-LtIcaIXJNP2jil9iyQCf1A-1; Thu, 20 Aug 2020 13:10:10 -0400
X-MC-Unique: LtIcaIXJNP2jil9iyQCf1A-1
Received: by mail-wm1-f69.google.com with SMTP id r14so215455wmh.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=89jXPVPv2kkdtYzqNRsIdICSTxnn4TeU97yfa4KTTPA=;
 b=ep8hu4vkiz/4Q2Xyq8X3MS5bTQVzl68GffW/JuvjSWqqBK5ZileTK5BejKu2tB+sm3
 W5CVBXga6I6ktFM3Vh9oZ9JKaWWgQ8KHUYQnwzGvg9ujUzaeU8EhD9M59kdAZRHASyRh
 ASUFHSztTFb1wFA3LW1GVNd2gXEAN9maDpRvyH//Y2b0z67UVL9tozSnX2kwtvkD+1Na
 y/Lqd9VOX15KNg0KV3WfJ7Q/7EQPaD1YdpOy3JG72POcQNLgb6xqeLJ73BULFJrkamPJ
 wXGwDJ9XAvF1tqQ80S5PnxOy45UbrDfX741qg2ViidsK0Ha9Z/YpfN/PuQi6tEFVFmce
 1jQA==
X-Gm-Message-State: AOAM533waN/Vi3nEDndUsqSKnTAk4fDplg0W0gHL6JZJ9TlWCtc+sYGT
 k6FCnqIJdyrH3KjqDNMevWRlhoOaX7wExBfA1qTWF8fqs8O902UYaCGBMxW14ERZhQtjAAw2Lu/
 hCrK/7DfvvPO6IXs=
X-Received: by 2002:a7b:c15a:: with SMTP id z26mr4322655wmi.35.1597943408663; 
 Thu, 20 Aug 2020 10:10:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6vkc/ENYEyyhE4ftbqk24JUQ0Qp4VGz2Q3SbBQ6VwkezIHv1bpIW0ANwviU60jSvBcGDRdg==
X-Received: by 2002:a7b:c15a:: with SMTP id z26mr4322630wmi.35.1597943408390; 
 Thu, 20 Aug 2020 10:10:08 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k204sm5658211wma.21.2020.08.20.10.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:10:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] util/vfio-helpers: Unify trace-events size format
Date: Thu, 20 Aug 2020 19:10:06 +0200
Message-Id: <20200820171006.1140228-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some 'qemu_vfio_*' trace events sizes are displayed using
decimal notation, other using hexadecimal notation:

  qemu_vfio_ram_block_added s 0xaaaaf2448d90 host 0xffff5bc00000 size 0x4000000
  qemu_vfio_dma_map s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 temporary 0 iova (nil)
  qemu_vfio_find_mapping s 0xaaaaf2448d90 host 0xffff5bc00000
  qemu_vfio_new_mapping s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 index 4 iova 0x114000
  qemu_vfio_do_mapping s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 iova 0x114000

As it is hard to follow, unify using hexadecimal for all sizes:

  qemu_vfio_ram_block_added s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000
  qemu_vfio_dma_map s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 temporary 0 iova (nil)
  qemu_vfio_find_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000
  qemu_vfio_new_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 index 4 iova 0x114000
  qemu_vfio_do_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 iova 0x114000

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/trace-events b/util/trace-events
index 0ce42822eba..d9a0b4f8c63 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -79,7 +79,7 @@ qemu_vfio_dma_reset_temporary(void *s) "s %p"
 qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
-qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
-qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size %zu iova 0x%"PRIx64
-qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size %zu temporary %d iova %p"
+qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size 0x%zx index %d iova 0x%"PRIx64
+qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
+qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
-- 
2.26.2



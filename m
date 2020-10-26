Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71893C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02C22224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSKqDEi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02C22224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Ik-0000QM-Kh
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AT-0007kh-Qy
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AS-0008NM-5T
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHVBY2K3BEOh3WYNJplbtMVpgw2LML5s1ozFmG/8CV0=;
 b=CSKqDEi+MvozPrO0aeOIp72Fc/yYIQRuSV+V3j/5Onzqz898ks5zRy5vGWVBtj0dwK6GnF
 baCko2vrmLy0GZ+V/cH6KuXC/LxSucZVZBGre6Z15HueWoMc+XQYntL9rHxTR6vnzhxR+g
 qkp3Pc00kwm2QoIxAZMJs2vPUcek+EQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-SwhKkUP4P22wvltBZT1Fkg-1; Mon, 26 Oct 2020 06:55:57 -0400
X-MC-Unique: SwhKkUP4P22wvltBZT1Fkg-1
Received: by mail-wr1-f71.google.com with SMTP id j15so835268wro.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oHVBY2K3BEOh3WYNJplbtMVpgw2LML5s1ozFmG/8CV0=;
 b=YpHJEuqndVmaXTVv/BnV0VmlX8yayjMniTVvYqsEZONjBvhTuegPkE5lZKGJM303ua
 GE81uSVqT/dUcnGicF4QIuVPJKPYC+P2pcuB3JcBAFULkU/FH0n9poxyuKTwmcWH4Ntf
 hBaprBXxq4yB9wljYK1lw9TK2IE5u8x5QKLw6dNGmE+yIuPWh94UB0p5K6j+MdHCbMEo
 yZB4zPNG6np2pCRHMFYX2T8aTzun+/K73Pli7jw0+X0POwLa3juQmX1CfUTNkxIoXdPp
 Rd+SGuQ82+BM0dqARteoVNMxiftg835L5ym3Yjm4/IYoES0kFBN+yXoiYOvoPvnyznO/
 Vrlg==
X-Gm-Message-State: AOAM531Xw6InFmY0kn0gATCM57OQM9N/qcGypGlKG/4wPAFoHsVKhrED
 nUVA5C+DOha2mzi8ImEvW7BVAKsPe7l3JVfPj9xymWtPlf0TNfoxCKfkke4Ut7IUoAa5a54Yfw9
 5y1ijUL+7WM9fXFo=
X-Received: by 2002:a1c:f417:: with SMTP id z23mr14729766wma.57.1603709755329; 
 Mon, 26 Oct 2020 03:55:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCwY2JOp0h6FKsVOdUTCO82Wo6A+ht+zGe4PvsjEl46DKFMTvOXPgQlVs5gWNyFd2CvfrfxQ==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr14729747wma.57.1603709755185; 
 Mon, 26 Oct 2020 03:55:55 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o4sm21504181wrv.8.2020.10.26.03.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/19] util/vfio-helpers: Convert vfio_dump_mapping to
 trace events
Date: Mon, 26 Oct 2020 11:54:55 +0100
Message-Id: <20201026105504.4023620-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 Eric Auger <eric.auger@redhat.com>,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 19 ++++---------------
 util/trace-events   |  1 +
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index c24a510df82..73f7bfa7540 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -521,23 +521,12 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
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
index 8598066acdb..7faad2a718c 100644
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



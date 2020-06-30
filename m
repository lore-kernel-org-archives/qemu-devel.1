Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75174C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D7520780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho4ecY/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D7520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDhx-0004PY-FS
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDeR-00073X-8I
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:38:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDeP-0002Iz-C6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgE+8CKv6/Z+MnfgzHWSN8+i1Bas9SZKWAfL4wzjfr8=;
 b=ho4ecY/zh7d/alrW/N2GkdozO2YhywosmXXrQPVIhME5nFJbUHZkhRMXg6CsHtUHE5rg8u
 uMvaZPLUegs2jAD1yeoPpkdco3JdaDNv1l97RzLrS+VuBgTrStXB+MWbb3Z9OIcBwz/yPU
 FNaDbv10C90sZcMk2mTAx1y6Lq31KHQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-0mQj0Sr6MNSNnRDR9ff6oQ-1; Tue, 30 Jun 2020 06:38:02 -0400
X-MC-Unique: 0mQj0Sr6MNSNnRDR9ff6oQ-1
Received: by mail-ed1-f70.google.com with SMTP id v8so9794906edj.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KgE+8CKv6/Z+MnfgzHWSN8+i1Bas9SZKWAfL4wzjfr8=;
 b=FNqL5QZGD26zNOzLTLHYPzz+TYT7dWpZ3KMsNQb05SIB6qeGi+VeAWkD5d+kUBKUSc
 5oIDuYuat1UuHNTTvCOmzmp54HjgLjS8nMeiAIDvZ/LZe7DGUhxzJ3fC3k5OEixsAAlD
 6Fvo+eegBykHyQlosnpGtmS94RiWnwMkjkvZTqDuxRvKiyM3dSlkM9BqF2jh7rk6MNvo
 zCapL8/oi/6NuNLGtAXOG9xHJWd99tRlaFTnXAcx+jE+t5abtObyMjRFkH1oDU0Ky1+S
 pt9aKWXcPQ2JDN2ZENLK4mbiXVxHb1lUFNkm70/pAvAhhOxoiDToUg7MyVOmXfshShUH
 g6sw==
X-Gm-Message-State: AOAM530bQOP+5VfqI+f5qjCDu4J8US70lFmPi3T2s6LlniXP5hKlS+eP
 TZTKFTcwYeCSNOafglPm5injIVvzlSVra5nNbr7dUnZJF1bwPQnOkzRoNq12EsgHAiysBF+5I0X
 1qexduku8ETwhDtI=
X-Received: by 2002:a05:6402:c83:: with SMTP id
 cm3mr22989140edb.307.1593513481400; 
 Tue, 30 Jun 2020 03:38:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9Gjnla44WQKSl8hAi+5QOLJIZe+8bMY69KPhOyBWZpg2+s2E51X17m/nWXutXHZi86V6A5A==
X-Received: by 2002:a05:6402:c83:: with SMTP id
 cm3mr22989134edb.307.1593513481272; 
 Tue, 30 Jun 2020 03:38:01 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id dh16sm2502594edb.3.2020.06.30.03.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:38:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/block/nvme: Align I/O BAR to 4 KiB
Date: Tue, 30 Jun 2020 12:37:39 +0200
Message-Id: <20200630103739.9715-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630103739.9715-1-philmd@redhat.com>
References: <20200630103739.9715-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the NVMe emulated device by aligning the I/O BAR to 4 KiB.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Do not include 'cmd_set_specfic' (Klaus)
---
 include/block/nvme.h | 2 ++
 hw/block/nvme.c      | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 82c384614a..4e1cea576a 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -22,6 +22,7 @@ typedef struct QEMU_PACKED NvmeBar {
     uint32_t    pmrebs;
     uint32_t    pmrswtp;
     uint64_t    pmrmsc;
+    uint8_t     reserved[484];
 } NvmeBar;
 
 enum NvmeCapShift {
@@ -879,6 +880,7 @@ enum NvmeIdNsDps {
 
 static inline void _nvme_check_size(void)
 {
+    QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 6628d0a4ba..2aa54bc20e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -55,7 +55,6 @@
 #include "nvme.h"
 
 #define NVME_MAX_IOQPAIRS 0xffff
-#define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
 #define NVME_CMB_BIR 2
 #define NVME_PMR_BIR 2
@@ -1322,7 +1321,7 @@ static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
     NvmeCtrl *n = (NvmeCtrl *)opaque;
     if (addr < sizeof(n->bar)) {
         nvme_write_bar(n, addr, data, size);
-    } else if (addr >= 0x1000) {
+    } else {
         nvme_process_db(n, addr, data);
     }
 }
@@ -1416,7 +1415,7 @@ static void nvme_init_state(NvmeCtrl *n)
 {
     n->num_namespaces = 1;
     /* add one to max_ioqpairs to account for the admin queue pair */
-    n->reg_size = pow2ceil(NVME_REG_SIZE +
+    n->reg_size = pow2ceil(sizeof(NvmeBar) +
                            2 * (n->params.max_ioqpairs + 1) * NVME_DB_SIZE);
     n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
     n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
-- 
2.21.3



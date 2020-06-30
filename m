Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C562DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F72E2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBOd9b32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F72E2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE7q-0004Mo-Sv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE4O-0007as-Sy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE4N-0006RI-BH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593515094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hZuFq5xzvZS6bLKa5uoWehD4BHAaugQmIpv0406m0o=;
 b=fBOd9b32PtI5b4NCQmApcQx+uSUx8XJfGu0DiLpJwXTL63yrGaG8Qkvq71/odCoUxQuX/f
 HFV8zLl2UIZbHL2IcHuVnfqdCfzjkZH3xh7ZH8wLfoHMOF+bmRL/Yp03JipRH7kIiT3fKM
 qzJVo51yukYILT1TX5yv3bw17lyxK1c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-bK6T768AMYqFJWpmg8q0UQ-1; Tue, 30 Jun 2020 07:04:53 -0400
X-MC-Unique: bK6T768AMYqFJWpmg8q0UQ-1
Received: by mail-ej1-f70.google.com with SMTP id q9so2350523ejr.21
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6hZuFq5xzvZS6bLKa5uoWehD4BHAaugQmIpv0406m0o=;
 b=YqSfNI5N9hIfBAkqMBeSXq6SKWdfoTrxcPDzU72BXQUHWE4wZBsNJmX3FbrFx7mmWW
 vSFvMfJl6XagFENCB5hc9AtbBqOppgchM+OMb2vmWEJUBI+iZMmjzDPp8A7VSRU3x5xg
 mfOFyvcFq56Qc+/CTSsGVIZzdYyslaCgK1xS3T/TpNyzcXvcF3eRLw4rEYe0M1JeAJ+Z
 TapZTkEwDsf6fyP8a4voddrEBV7C7lN2Bs40gbWxJ1L4T7BJcaU74azHzGkrPS6VmTLE
 OsNEJD5lfUZ6Fn2qlOjPA8ujDi/RBbg+M1rnjQpgT+eD+/Te8kzYj7SaJFmHUNe7dfCM
 YeZw==
X-Gm-Message-State: AOAM5335TWY9wRdoBHtnFcKhvOxqtiFXZBFoyq2F50znJOvhkOMU6Fxa
 0ryx3EAttRri9PwuG3gRwlZ9wJgVEHdYzzePtENm9TeFNejNSmtJQd93MV3slIGcIcmZeYLuyZ0
 e0I6Tb2fO6xZEhYI=
X-Received: by 2002:a05:6402:30b2:: with SMTP id
 df18mr22502385edb.229.1593515091613; 
 Tue, 30 Jun 2020 04:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZUkApC1FjmmylYyn2z2GZ6iWGdUJiEoqr44T2hS6r3AcnMdadaqiLSoi1HMBQkHtJGZQ9mQ==
X-Received: by 2002:a05:6402:30b2:: with SMTP id
 df18mr22502365edb.229.1593515091375; 
 Tue, 30 Jun 2020 04:04:51 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d12sm2472028edx.80.2020.06.30.04.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 04:04:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] hw/block/nvme: Align I/O BAR to 4 KiB
Date: Tue, 30 Jun 2020 13:04:29 +0200
Message-Id: <20200630110429.19972-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630110429.19972-1-philmd@redhat.com>
References: <20200630110429.19972-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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



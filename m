Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD40EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608EF206E7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KT544sAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608EF206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgk2-00028v-Dm
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghX-00075b-BR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:35 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:49880)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghT-0002Le-2P
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=kfHlVeS9NRlcIquOpE
 so70dCCBVTxtqozqqcBgk4xCI=; b=KT544sAKXymAjlr5IuOgCw6y91NvKToB2x
 9Vylr+wVmSyhXqoK0V8WgzTuhz0AFV1pLzTSbagPYXibXPVPIg4qLHOB8Nk8XYrk
 2T2iqZoW5X7PN/Dngo7zE4OP8n3KAm4CruH+oGR2mU418O+5MCvn4ZnlffvlvU9J
 /OcTwXONg=
Received: from localhost.localdomain (unknown [183.158.94.209])
 by smtp5 (Coremail) with SMTP id HdxpCgCnGRhetFdf9j7RJg--.1087S6;
 Wed, 09 Sep 2020 00:42:11 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: dmitry.fleytman@gmail.com, jasowang@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
Subject: [RFC 2/4] memory: avoid reenter the device's MMIO handler while
 processing MMIO
Date: Tue,  8 Sep 2020 09:41:55 -0700
Message-Id: <20200908164157.47108-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908164157.47108-1-liq3ea@163.com>
References: <20200908164157.47108-1-liq3ea@163.com>
X-CM-TRANSID: HdxpCgCnGRhetFdf9j7RJg--.1087S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43WF18ZrW7Gr17Zw4ruFg_yoW8Kw47pF
 yxXF9Y9rW0yFnrArySqrW3XF15C3y8GFnrG3sxCr97urn7tF15ZrnYg345Aryxtr98Xay5
 WrZ8XFW3Ww1rJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6VbkUUUUU=
X-Originating-IP: [183.158.94.209]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBZgOZbVaD53waCQAAsM
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:42:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a 'in_mmio' flag to 'DeviceState' to indicate that the
device is doing MMIO path. This can avoid the malicious guest do
DMA to MMIO and crash the qemu.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 include/hw/qdev-core.h |  1 +
 softmmu/memory.c       | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ea3f73a282..c6f4ebba9e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -177,6 +177,7 @@ struct DeviceState {
     char *canonical_path;
     bool realized;
     bool pending_deleted_event;
+    bool in_mmio;
     QemuOpts *opts;
     int hotplugged;
     bool allow_unplug_during_migration;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 2628c9d2d9..7be44f7175 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1410,8 +1410,20 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
         return MEMTX_DECODE_ERROR;
     }
 
+    if (mr->dev) {
+        if (mr->dev->in_mmio) {
+            return MEMTX_ERROR;
+        } else {
+            mr->dev->in_mmio = true;
+        }
+    }
+
     r = memory_region_dispatch_read1(mr, addr, pval, size, attrs);
     adjust_endianness(mr, pval, op);
+
+    if (mr->dev) {
+        mr->dev->in_mmio = false;
+    }
     return r;
 }
 
@@ -1448,6 +1460,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          MemTxAttrs attrs)
 {
     unsigned size = memop_size(op);
+    MemTxResult ret;
 
     if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
         unassigned_mem_write(mr, addr, data, size);
@@ -1461,20 +1474,32 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
         return MEMTX_OK;
     }
 
+    if (mr->dev) {
+        if (mr->dev->in_mmio) {
+            return MEMTX_ERROR;
+        } else {
+            mr->dev->in_mmio = true;
+        }
+    }
+
     if (mr->ops->write) {
-        return access_with_adjusted_size(addr, &data, size,
+        ret = access_with_adjusted_size(addr, &data, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_write_accessor, mr,
                                          attrs);
     } else {
-        return
-            access_with_adjusted_size(addr, &data, size,
+        ret = access_with_adjusted_size(addr, &data, size,
                                       mr->ops->impl.min_access_size,
                                       mr->ops->impl.max_access_size,
                                       memory_region_write_with_attrs_accessor,
                                       mr, attrs);
     }
+    if (mr->dev) {
+        mr->dev->in_mmio = false;
+    }
+
+    return ret;
 }
 
 void memory_region_init_io(MemoryRegion *mr,
-- 
2.17.1



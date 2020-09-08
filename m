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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A192C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C0B206E7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ev3Nk22J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C0B206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgiX-0008LA-Lg
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghW-00075L-Mt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:34 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:49856)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kFghR-0002LP-GR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=6o6Keb5oFii1iCN3xI
 h04mis0S3GAV4u9wS5ltt8Iao=; b=ev3Nk22JBi+5itTFJJn3QhYmJmo0HJvfgP
 6vgZHfY5jEV/9efBYTNu7+xuAnbyG7Y4PNm/EhgzkMlGgZmRIULFsWyWnvbF7PNn
 OqpbowiwJfbAJ6+EvHg662BqDgWxOaT2AS3oREri7e56XMzATFFRMrx1eQk9iv7+
 vzzPhJoHw=
Received: from localhost.localdomain (unknown [183.158.94.209])
 by smtp5 (Coremail) with SMTP id HdxpCgCnGRhetFdf9j7RJg--.1087S5;
 Wed, 09 Sep 2020 00:42:09 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: dmitry.fleytman@gmail.com, jasowang@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
Subject: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
Date: Tue,  8 Sep 2020 09:41:54 -0700
Message-Id: <20200908164157.47108-2-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908164157.47108-1-liq3ea@163.com>
References: <20200908164157.47108-1-liq3ea@163.com>
X-CM-TRANSID: HdxpCgCnGRhetFdf9j7RJg--.1087S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW8ZF1kur48Kr1DKw47CFg_yoW8CF1kpF
 97uF9Ygr48tF9xZF1ftF4DWFyrA3y8K3W7Cr9rZwn2krs7tF9xArWUG345AryUCrWUX3W5
 XFyUXr4fuan5J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRaYL9UUUUU=
X-Originating-IP: [183.158.94.209]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKQGZbVXlxmTITQAAsL
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

Currently the MR is not explicitly connecting with its device instead of
a opaque. In most situation this opaque is the deivce but it is not an
enforcement. This patch adds a DeviceState member of to MemoryRegion
we will use it in later patch.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 include/exec/memory.h |  9 +++++++++
 softmmu/memory.c      | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0cfe987ab4..620fb12d9b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -404,6 +404,7 @@ struct MemoryRegion {
     const char *name;
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
+    DeviceState *dev;
 };
 
 struct IOMMUMemoryRegion {
@@ -794,6 +795,14 @@ void memory_region_init_io(MemoryRegion *mr,
                            const char *name,
                            uint64_t size);
 
+void memory_region_init_io_with_dev(MemoryRegion *mr,
+                           struct Object *owner,
+                           const MemoryRegionOps *ops,
+                           void *opaque,
+                           const char *name,
+                           uint64_t size,
+                           DeviceState *dev);
+
 /**
  * memory_region_init_ram_nomigrate:  Initialize RAM memory region.  Accesses
  *                                    into the region will modify memory
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 70b93104e8..2628c9d2d9 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1490,6 +1490,21 @@ void memory_region_init_io(MemoryRegion *mr,
     mr->terminates = true;
 }
 
+void memory_region_init_io_with_dev(MemoryRegion *mr,
+                           Object *owner,
+                           const MemoryRegionOps *ops,
+                           void *opaque,
+                           const char *name,
+                           uint64_t size,
+                           DeviceState *dev)
+{
+    memory_region_init(mr, owner, name, size);
+    mr->ops = ops ? ops : &unassigned_mem_ops;
+    mr->opaque = opaque;
+    mr->terminates = true;
+    mr->dev = dev;
+}
+
 void memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
-- 
2.17.1



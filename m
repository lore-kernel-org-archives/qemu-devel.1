Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E94C5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B0A208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="UXEVDUdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B0A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgu7m-0004DS-8x
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@163.com>) id 1hgtWE-0001HI-DM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1hgtWB-0001K7-Ny
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:14:34 -0400
Received: from m12-15.163.com ([220.181.12.15]:46271)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1hgtW9-000158-Dm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=ppWxxeiGIjs9F0GUSc
 K/4xJx3wjQebGdAR/3NeqxmD4=; b=UXEVDUdx0LHQX9dTlUqcYh12v1Wc9S8u9z
 LbOzsdelj62rbTE9Ud9Q6tAbgcb7otNjmTvbHEgP3KPlvO7hpY+fTfaITFSnbkVa
 9OjznyMk/gC2eqPk1VyjSek4Jh05zwYmIcrJ9G0/ElkpQX9c+PL2Mw/GjkjkwG4Y
 2yuiJ6RQ0=
Received: from localhost.localdomain (unknown [183.159.71.39])
 by smtp11 (Coremail) with SMTP id D8CowAAXH0_SPBZd9MvBCw--.11256S2;
 Sat, 29 Jun 2019 00:14:12 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com,
	kraxel@redhat.com
Date: Fri, 28 Jun 2019 09:13:58 -0700
Message-Id: <20190628161358.10400-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAAXH0_SPBZd9MvBCw--.11256S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfuF1UKF17GF4DXw4xJFb_yoW3ArX_t3
 W2kr4kJF43JF1093yUAryfua4fZwsxGF98WFWavF9Yy348X3ZFyryxXFZ7WF129rZFkF4D
 ZayrWr4q9w1SvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjh0etUUUUU==
X-Originating-IP: [183.159.71.39]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBjhbVaD1hl18wABsd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.15
Subject: [Qemu-devel] [PATCH] virtio-gpu: check if the resource already
 exists in virtio_gpu_load()
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

While loading virtio-gpu, the data can be malicious, we
should check if the resource already exists.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/display/virtio-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2b0f66b1d6..f1ebed9959 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1002,6 +1002,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 
     resource_id = qemu_get_be32(f);
     while (resource_id != 0) {
+        res = virtio_gpu_find_resource(g, resource_id);
+        if (res) {
+            return -EINVAL;
+        }
+
         res = g_new0(struct virtio_gpu_simple_resource, 1);
         res->resource_id = resource_id;
         res->width = qemu_get_be32(f);
-- 
2.17.1




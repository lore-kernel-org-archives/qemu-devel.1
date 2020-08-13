Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B79FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A44720774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oFMe7BMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A44720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GT6-0000Ib-DS
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k6GSZ-0008Jr-6x
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:52:11 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:42688)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1k6GSU-000463-9p
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=qgOBh8DEWIr+1eiPh0
 iebBExJiaGflRdaHFUtmrAabY=; b=oFMe7BMXxW9mkqxWcRDt3Pu1K83ypmgHLr
 sL4Xh6iEQbuaz10CvEVDRuIPJ7FCbmJ7tkSLu1pCW+6pz1l611s/+ISifB8qLAEc
 Ccm1bZX4J0Y2QOyG+d4ShBapuWea8qL66F1wwK32n4Iz1iSakjHKHZyc+hS7oMOB
 MpqK9AFZE=
Received: from localhost.localdomain (unknown [115.204.177.14])
 by smtp1 (Coremail) with SMTP id GdxpCgA3xNCVbzVffgB5Ag--.40S4;
 Fri, 14 Aug 2020 00:51:56 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com
Subject: [PATCH] hw: virtio-pmem: detach the element fromt the virtqueue when
 error occurs
Date: Thu, 13 Aug 2020 09:51:25 -0700
Message-Id: <20200813165125.59928-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgA3xNCVbzVffgB5Ag--.40S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4rZry5Cw1UXw4DKFW7urg_yoW3ArX_GF
 W8CayxWw4jga4akrWjyw4rXF1fGa18W3Z8AF13tF18Ar18Jw45JF9rXFsY9F17WrW8Ka15
 ArZ5Krs8Wwn3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE7Ks7UUUUU==
X-Originating-IP: [115.204.177.14]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbitA5-bVSIiR1jTgAAsN
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 11:36:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

If error occurs while processing the virtio request we should call
'virtqueue_detach_element' to detach the element from the virtqueue
before free the elem.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/virtio/virtio-pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 1e0c137497..ddb0125901 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -77,6 +77,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
 
     if (req_data->elem.out_num < 1 || req_data->elem.in_num < 1) {
         virtio_error(vdev, "virtio-pmem request not proper");
+        virtqueue_detach_element(vq, (VirtQueueElement *)req_data, 0);
         g_free(req_data);
         return;
     }
-- 
2.17.1



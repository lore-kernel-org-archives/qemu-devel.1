Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D1C43469
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AB921D95
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c1nWKBcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AB921D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMmN-0007ts-4x
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kKMki-0006dF-03
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:25:12 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:57834)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kKMkY-0002mJ-Q5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=FvbRk/8RINymNDhtwd
 W57mJY6Rhmg7Rn2NTOL6y4uMI=; b=c1nWKBcZtkxiaplIBE7gjJpQHNj0zLKcKT
 HnB5zpV1Nzinnj5S4Q+ZDJ8GaudP72FYkK1HYnzph8gwCWhf11e8aE+1xJinUT6e
 lMdcTu33buT9npLiz9qiTEOR9bnl4G1PwDjsoWawb80WAaV9w19X9XDhoKVwXVN8
 KtdyKPfDA=
Received: from localhost.localdomain (unknown [183.159.201.198])
 by smtp5 (Coremail) with SMTP id HdxpCgAXYwunt2hfnbm_Mw--.132S4;
 Mon, 21 Sep 2020 22:24:42 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com,
	pankaj.gupta.linux@gmail.com
Subject: [PATCH REPOST] hw: virtio-pmem: detach the element fromt the
 virtqueue when error occurs
Date: Mon, 21 Sep 2020 07:24:37 -0700
Message-Id: <20200921142437.5658-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgAXYwunt2hfnbm_Mw--.132S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4rZry5Cw1UXw4DKFW7urg_yoWfArX_Gr
 WxCa4xWw4jgFyakrWUAr1rXF1fGa1UXFn0yr15tF18Ar18Jw45JF97XFsY9F17WrW0ga1U
 ArZ5Krs8Xw1fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjhvKUUUUUU==
X-Originating-IP: [183.159.201.198]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBZgqmbVaD5+t9LgAAst
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 10:24:43
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

If error occurs while processing the virtio request we should call
'virtqueue_detach_element' to detach the element from the virtqueue
before free the elem.

Fixes: 5f503cd9f3 ("virtio-pmem: add virtio device")
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
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



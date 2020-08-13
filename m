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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F2D2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H7F0IQtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GOE-0005Jr-3t
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k6GNW-0004rF-P9
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:46:59 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:39560)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1k6GNQ-0003XB-Ts
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=3RWw/EPFpusD4YS/Bx
 BHEuBEnEA7bbd7X3AiOWv7oAA=; b=H7F0IQtJjMiXPRWlKMAiH71fxO7iti6vHI
 lTHG2voWdGungVOHi2/RMtib+mCvFShTcmHuyVwOuW2fkeWUkKD0IqjsHzYv1qWR
 8NDcZn24zfxA5TVJ/VGLNVh0ro54G8ubvQbiJSYmZPsytZfpec85fv9vDbz+y3lW
 e+HFKGN4g=
Received: from localhost.localdomain (unknown [115.204.177.14])
 by smtp1 (Coremail) with SMTP id GdxpCgDXghhzbjVfVCJ4Ag--.54S4;
 Fri, 14 Aug 2020 00:46:44 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com,
	david@redhat.com
Subject: [PATCH] hw: virtio-mem: detach the element fromt the virtqueue when
 error occurs
Date: Thu, 13 Aug 2020 09:46:37 -0700
Message-Id: <20200813164637.58904-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgDXghhzbjVfVCJ4Ag--.54S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF18XrykJFWxCry8XF47Arb_yoW8Wr43pr
 48AFZ8Aa1xJFWIqF4ftF1UWry8Aws7tr12k3yxZw15GF1kAFn7JF1UZFyjqry7ArZ5ZF4x
 WFnYgr4aqas7uw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRHv3nUUUUU=
X-Originating-IP: [115.204.177.14]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBaxV-bVet1mnlsQAAs9
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
 hw/virtio/virtio-mem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7740fc613f..5ac6c3ec67 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -318,8 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
         if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < len) {
             virtio_error(vdev, "virtio-mem protocol violation: invalid request"
                          " size: %d", len);
-            g_free(elem);
-            return;
+            goto out_free;
         }
 
         if (iov_size(elem->in_sg, elem->in_num) <
@@ -327,8 +326,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
             virtio_error(vdev, "virtio-mem protocol violation: not enough space"
                          " for response: %zu",
                          iov_size(elem->in_sg, elem->in_num));
-            g_free(elem);
-            return;
+            goto out_free;
         }
 
         type = le16_to_cpu(req.type);
@@ -348,12 +346,15 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
         default:
             virtio_error(vdev, "virtio-mem protocol violation: unknown request"
                          " type: %d", type);
-            g_free(elem);
-            return;
+            goto out_free;
         }
 
         g_free(elem);
     }
+
+out_free:
+    virtqueue_detach_element(vq, elem, 0);
+    g_free(elem);
 }
 
 static void virtio_mem_get_config(VirtIODevice *vdev, uint8_t *config_data)
-- 
2.17.1



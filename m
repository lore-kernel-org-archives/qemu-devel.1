Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8C3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203742083B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mue+1f5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203742083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PMx-0003Qk-Ax
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k8PJk-0008Mq-B6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:43:56 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:51450)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k8PJb-0002yq-4P
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=czWCoDoniiCusoZIft
 v4yR5TcH9WsDlgWrCv42GCBK8=; b=Mue+1f5qVFvY7jLqb02aJDroByU9wQ2bb8
 naOF7QUJ0zq5Jxkti+x5fdmBTJDdTRX/XDrYVJ60I5gFKOqF4lJKEDrEVkywnsAl
 hBN6L+u/CxNpxim3pDDzinudtkTnDmQ+XXi2kFatonfW67KtDSYASWwCXMU4azv3
 BRvLZpk+A=
Received: from localhost.localdomain (unknown [60.177.59.214])
 by smtp5 (Coremail) with SMTP id HdxpCgC3mVSBOj1fZRtQEQ--.228S4;
 Wed, 19 Aug 2020 22:43:30 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] virtio: vdpa: omit check return of g_malloc
Date: Wed, 19 Aug 2020 07:43:09 -0700
Message-Id: <20200819144309.67579-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgC3mVSBOj1fZRtQEQ--.228S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry5Gw1fWFWkur47Jr47urg_yoWkXFc_WF
 yxAryvgF98CryjkFsFvr4SqF17ta1kX3WvkayS9ryxAwnrXw12v34xCFnrXF17u347AFy5
 urWkArZ8tw1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LF4JUUUUU==
X-Originating-IP: [60.177.59.214]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBKFbVaD7B7z6AAAsS
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:16:01
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If g_malloc fails, the application will be terminated.
No need to check the return value of g_malloc.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/virtio/vhost-vdpa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4580f3efd8..403ae3ae07 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -320,10 +320,8 @@ static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
     struct vhost_vdpa_config *config;
     int ret;
     unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
+
     config = g_malloc(size + config_size);
-    if (config == NULL) {
-        return -1;
-    }
     config->off = offset;
     config->len = size;
     memcpy(config->buf, data, size);
@@ -340,9 +338,6 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
     int ret;
 
     v_config = g_malloc(config_len + config_size);
-    if (v_config == NULL) {
-        return -1;
-    }
     v_config->len = config_len;
     v_config->off = 0;
     ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
-- 
2.17.1



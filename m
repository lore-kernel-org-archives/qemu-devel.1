Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF38C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD383208B3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ItnPucwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD383208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVY0-0004F9-33
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kDVWz-0002xs-Ot
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:41 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:43634)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1kDVWw-0002vR-I4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=wfcpJ4DDOpMy4YNA9R
 leV70ACEl8JRMmMnrNcmMTWi8=; b=ItnPucwJHNL92oKa4QjDtdjp24POVsEJwX
 tp1hFvxdm8THNoWwlVNfD5TfU1pwHncRPUnMJCTVhnGNLMdXh4RE6YVhvmG2ZFpr
 fymLLjnniQbIKe4v0rIYNJpsQmyvHhI1idXpjtkMt1ismHBGA0hBUy4fYnP1vWx3
 Kt1qBg/xo=
Received: from localhost.localdomain (unknown [183.134.168.235])
 by smtp1 (Coremail) with SMTP id GdxpCgAXbyO1xk9fAIYUAQ--.82S7;
 Thu, 03 Sep 2020 00:22:31 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com, kraxel@redhat.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, alxndr@bu.edu, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 3/3] virtio-gpu: make the IO handler reentrant
Date: Wed,  2 Sep 2020 09:22:06 -0700
Message-Id: <20200902162206.101872-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902162206.101872-1-liq3ea@163.com>
References: <20200902162206.101872-1-liq3ea@163.com>
X-CM-TRANSID: GdxpCgAXbyO1xk9fAIYUAQ--.82S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4fKryfCF4UCw17Jw1fJFb_yoW5WF17pF
 1UAFy5WF48XF17Jas5XF4xWrn8CFZ5A3ZrCrnYvFyF9wsxtF97A3WrKFy2yrW3Ar48AF45
 GFn2934jyr4qvw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeVbgUUUUU=
X-Originating-IP: [183.134.168.235]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFB2TbVaD7LNrjQABsa
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 12:22:24
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

The guest can program the virtio desc table. When the used ring
is programmed by virtio-gpu's MMIO it may cause an reentrant issue.

Following is the reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 -nographic -M pc -nodefaults -m 512M -device virtio-vga -qtest stdio
outl 0xcf8 0x80001018
outl 0xcfc 0xe0800000
outl 0xcf8 0x80001020
outl 0xcf8 0x80001004
outw 0xcfc 0x7
writeq 0xe0801024 0x10646c00776c6cff
writeq 0xe080102d 0xe0801000320000
writeq 0xe0801015 0x12b2901ba000000
write 0x10646c02 0x1 0x2c
write 0x999 0x1 0x25
write 0x8 0x1 0x78
write 0x2c7 0x1 0x32
write 0x2cb 0x1 0xff
write 0x2cc 0x1 0x7e
writeq 0xe0803000 0xf2b8f0540ff83
EOF

This patch avoid this by adding a 'in_io' in VirtIOGPU to indicate it is in IO processing.
Notice this also address the race condition between 'virtio_gpu_process_cmdq' and
'virtio_gpu_reset' as the 'virtio_gpu_process_cmdq' is run in a BH which in the main thread
and 'virtio_gpu_reset' is run in the vcpu thread and both of them access the 'g->cmdq'.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888606

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/display/virtio-gpu.c        | 10 ++++++++++
 include/hw/virtio/virtio-gpu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f0dd7c150..404b7dc174 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -809,6 +809,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
 {
     struct virtio_gpu_ctrl_command *cmd;
 
+    if (atomic_read(&g->in_io)) {
+        return;
+    }
+    atomic_set(&g->in_io, 1);
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd = QTAILQ_FIRST(&g->cmdq);
 
@@ -838,6 +842,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
             g_free(cmd);
         }
     }
+    atomic_set(&g->in_io, 0);
 }
 
 static void virtio_gpu_gl_unblock(VirtIOGPUBase *b)
@@ -1144,6 +1149,10 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
     struct virtio_gpu_simple_resource *res, *tmp;
     struct virtio_gpu_ctrl_command *cmd;
 
+    if (atomic_read(&g->in_io)) {
+        return;
+    }
+    atomic_set(&g->in_io, 1);
 #ifdef CONFIG_VIRGL
     if (g->parent_obj.use_virgl_renderer) {
         virtio_gpu_virgl_reset(g);
@@ -1179,6 +1188,7 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
 #endif
 
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
+    atomic_set(&g->in_io, 0);
 }
 
 static void
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7517438e10..aadcf0e332 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -150,6 +150,7 @@ typedef struct VirtIOGPU {
 
     bool renderer_inited;
     bool renderer_reset;
+    bool in_io;
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
 
-- 
2.17.1



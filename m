Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C238C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1821C208B3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IZAt6nDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1821C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVZ2-0005zM-8H
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kDVWx-0002wP-1x
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:39 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:43392)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1kDVWr-0002uq-TE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=WDZisVGn33WdOeureI
 +tCYgWp8IxXY0GWRUNVGO8h1s=; b=IZAt6nDwGHPV2ZFJxxs2TviyuoKQd/7CD1
 sDVUHAbpf8aIY+bEsZnoAlejTuwEbN5cf+IzwGtqB3p0Ny9F33J6v1jdwIVofqHL
 1dyiCsgLJTzUgaT2nqycAKRYbIyhr2ZiwYv/HB+cMD7Str3UCjTegsQj7qbEr/aB
 CeanYV+lI=
Received: from localhost.localdomain (unknown [183.134.168.235])
 by smtp1 (Coremail) with SMTP id GdxpCgAXbyO1xk9fAIYUAQ--.82S5;
 Thu, 03 Sep 2020 00:22:18 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com, kraxel@redhat.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, alxndr@bu.edu, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 1/3] e1000e: make the IO handler reentrant
Date: Wed,  2 Sep 2020 09:22:04 -0700
Message-Id: <20200902162206.101872-2-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902162206.101872-1-liq3ea@163.com>
References: <20200902162206.101872-1-liq3ea@163.com>
X-CM-TRANSID: GdxpCgAXbyO1xk9fAIYUAQ--.82S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1rZw4fur15CF13Ar48Crg_yoW5ZF17pF
 W8KFZ8X3WFkr17GrnrXr45JF15Xws7AasrJ39xZ3ZY9r45u3s5tF9IqrWUGrsru347CFy7
 XF4DAFW3tr4DZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQ_-QUUUUU=
X-Originating-IP: [183.134.168.235]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoRuTbVQHLbTxYQAAse
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

The guest can program the e1000e DMA address to its MMIO.
This will cause an UAF issue.

Following is the reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 -M q35,accel=qtest \
-qtest stdio -nographic -monitor none -serial none
outl 0xcf8 0x80001010
outl 0xcfc 0xe1020000
outl 0xcf8 0x80001014
outl 0xcf8 0x80001004
outw 0xcfc 0x7
outl 0xcf8 0x800010a2
write 0xe102003b 0x1 0xff
write 0xe1020103 0x1e 0xffffff055c5e5c30be4511d084ffffffffffffffffffffffffffffffffff
write 0xe1020420 0x4 0xffffffff
write 0xe1020424 0x4 0xffffffff
write 0xe102042b 0x1 0xff
write 0xe1020430 0x4 0x055c5e5c
write 0x5c041 0x1 0x04
write 0x5c042 0x1 0x02
write 0x5c043 0x1 0xe1
write 0x5c048 0x1 0x8a
write 0x5c04a 0x1 0x31
write 0x5c04b 0x1 0xff
write 0xe1020403 0x1 0xff
EOF

This patch avoid this by adding a 'in_io' in E1000EState to indicate it is in IO
processing.

Buglink: https://bugs.launchpad.net/qemu/+bug/1886362

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/net/e1000e.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index fda34518c9..eb6b34b7f3 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -77,6 +77,8 @@ typedef struct E1000EState {
 
     bool disable_vnet;
 
+    bool in_io;
+
     E1000ECore core;
 
 } E1000EState;
@@ -98,7 +100,15 @@ static uint64_t
 e1000e_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     E1000EState *s = opaque;
-    return e1000e_core_read(&s->core, addr, size);
+    uint64_t ret;
+
+    if (s->in_io) {
+        return 0;
+    }
+    s->in_io = true;
+    ret = e1000e_core_read(&s->core, addr, size);
+    s->in_io = false;
+    return ret;
 }
 
 static void
@@ -106,7 +116,13 @@ e1000e_mmio_write(void *opaque, hwaddr addr,
                    uint64_t val, unsigned size)
 {
     E1000EState *s = opaque;
+
+    if (s->in_io) {
+        return;
+    }
+    s->in_io = true;
     e1000e_core_write(&s->core, addr, val, size);
+    s->in_io = false;
 }
 
 static bool
@@ -138,19 +154,28 @@ e1000e_io_read(void *opaque, hwaddr addr, unsigned size)
     uint32_t idx = 0;
     uint64_t val;
 
+    if (s->in_io) {
+            return 0;
+    }
+    s->in_io = true;
+
     switch (addr) {
     case E1000_IOADDR:
         trace_e1000e_io_read_addr(s->ioaddr);
+        s->in_io = false;
         return s->ioaddr;
     case E1000_IODATA:
         if (e1000e_io_get_reg_index(s, &idx)) {
             val = e1000e_core_read(&s->core, idx, sizeof(val));
             trace_e1000e_io_read_data(idx, val);
+            s->in_io = false;
             return val;
         }
+        s->in_io = false;
         return 0;
     default:
         trace_e1000e_wrn_io_read_unknown(addr);
+        s->in_io = false;
         return 0;
     }
 }
@@ -162,19 +187,27 @@ e1000e_io_write(void *opaque, hwaddr addr,
     E1000EState *s = opaque;
     uint32_t idx = 0;
 
+    if (s->in_io) {
+        return;
+    }
+    s->in_io = true;
+
     switch (addr) {
     case E1000_IOADDR:
         trace_e1000e_io_write_addr(val);
         s->ioaddr = (uint32_t) val;
+        s->in_io = false;
         return;
     case E1000_IODATA:
         if (e1000e_io_get_reg_index(s, &idx)) {
             trace_e1000e_io_write_data(idx, val);
             e1000e_core_write(&s->core, idx, val, sizeof(val));
         }
+        s->in_io = false;
         return;
     default:
         trace_e1000e_wrn_io_write_unknown(addr);
+        s->in_io = false;
         return;
     }
 }
-- 
2.17.1



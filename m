Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7A920739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kh31d+3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7A920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6YR-00023p-1q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jw6XZ-0001a6-FB
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:15:21 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:38712)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jw6XP-0000Od-MC
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=K3QDI1n14KjXlsuQgz
 Q7UpUSIhhGosxngIiJe2WIvLE=; b=Kh31d+3Ar2F3hWNeGXY7POEM47oSjJh4c5
 xYfAFz7ERv14LxUPQiEJR13kyywuUc5ZO3hJsp5nKpYlMfkAOGhbLohY1ztR4sRT
 OsgOA38WfoQ0YtLkaauZb9E0NLftcYwAtJ/OakVKnZC9fu5b9HY9I2f+kdOeYi5m
 73vsZIxck=
Received: from ubuntu.localdomain (unknown [183.159.72.144])
 by smtp5 (Coremail) with SMTP id HdxpCgA357b+fBBfAHv3CA--.14459S4;
 Fri, 17 Jul 2020 00:14:55 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: dmitry.fleytman@gmail.com, jasowang@redhat.com, pbonzini@redhat.com,
 mst@redhat.com
Subject: [PATCH] e1000e: using bottom half to send packets
Date: Thu, 16 Jul 2020 09:14:53 -0700
Message-Id: <20200716161453.61295-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgA357b+fBBfAHv3CA--.14459S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1kKF4fJF4fAry7tr1DKFg_yoW5KFykpa
 ykG39xXF45Gry3Jrs7Wry5Jr15Jw48Xwn7Wr4Uu34FqFZ3C3s7Jr1kKF47Z3y3ua9FyrZY
 kr4Yyr1avrWqqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbIDcUUUUU=
X-Originating-IP: [183.159.72.144]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBawFjbVet1PLOMwAAsF
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:57:31
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

Alexander Bulekov reported a UAF bug related e1000e packets send.

-->https://bugs.launchpad.net/qemu/+bug/1886362

This is because the guest trigger a e1000e packet send and set the
data's address to e1000e's MMIO address. So when the e1000e do DMA
it will write the MMIO again and trigger re-entrancy and finally
causes this UAF.

Paolo suggested to use a bottom half whenever MMIO is doing complicate
things in here:
-->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg03342.html

Reference here:
'The easiest solution is to delay processing of descriptors to a bottom
half whenever MMIO is doing something complicated.  This is also better
for latency because it will free the vCPU thread more quickly and leave
the work to the I/O thread.'

This patch fixes this UAF.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/net/e1000e_core.c | 25 +++++++++++++++++--------
 hw/net/e1000e_core.h |  2 ++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcd186cac5..6165b04b68 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2423,32 +2423,27 @@ e1000e_set_dbal(E1000ECore *core, int index, uint32_t val)
 static void
 e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
 {
-    E1000E_TxRing txr;
     core->mac[index] = val;
 
     if (core->mac[TARC0] & E1000_TARC_ENABLE) {
-        e1000e_tx_ring_init(core, &txr, 0);
-        e1000e_start_xmit(core, &txr);
+        qemu_bh_schedule(core->tx[0].tx_bh);
     }
 
     if (core->mac[TARC1] & E1000_TARC_ENABLE) {
-        e1000e_tx_ring_init(core, &txr, 1);
-        e1000e_start_xmit(core, &txr);
+        qemu_bh_schedule(core->tx[1].tx_bh);
     }
 }
 
 static void
 e1000e_set_tdt(E1000ECore *core, int index, uint32_t val)
 {
-    E1000E_TxRing txr;
     int qidx = e1000e_mq_queue_idx(TDT, index);
     uint32_t tarc_reg = (qidx == 0) ? TARC0 : TARC1;
 
     core->mac[index] = val & 0xffff;
 
     if (core->mac[tarc_reg] & E1000_TARC_ENABLE) {
-        e1000e_tx_ring_init(core, &txr, qidx);
-        e1000e_start_xmit(core, &txr);
+        qemu_bh_schedule(core->tx[qidx].tx_bh);
     }
 }
 
@@ -3322,6 +3317,16 @@ e1000e_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
+static void e1000e_core_tx_bh(void *opaque)
+{
+    struct e1000e_tx *tx = opaque;
+    E1000ECore *core = tx->core;
+    E1000E_TxRing txr;
+
+    e1000e_tx_ring_init(core, &txr, tx - &core->tx[0]);
+    e1000e_start_xmit(core, &txr);
+}
+
 void
 e1000e_core_pci_realize(E1000ECore     *core,
                         const uint16_t *eeprom_templ,
@@ -3340,6 +3345,8 @@ e1000e_core_pci_realize(E1000ECore     *core,
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
                         E1000E_MAX_TX_FRAGS, core->has_vnet);
+        core->tx[i].core = core;
+        core->tx[i].tx_bh = qemu_bh_new(e1000e_core_tx_bh, &core->tx[i]);
     }
 
     net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
@@ -3367,6 +3374,8 @@ e1000e_core_pci_uninit(E1000ECore *core)
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_reset(core->tx[i].tx_pkt);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
+        qemu_bh_delete(core->tx[i].tx_bh);
+        core->tx[i].tx_bh = NULL;
     }
 
     net_rx_pkt_uninit(core->rx_pkt);
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index aee32f7e48..94ddc6afc2 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -77,6 +77,8 @@ struct E1000Core {
         unsigned char sum_needed;
         bool cptse;
         struct NetTxPkt *tx_pkt;
+        QEMUBH *tx_bh;
+        E1000ECore *core;
     } tx[E1000E_NUM_QUEUES];
 
     struct NetRxPkt *rx_pkt;
-- 
2.17.1



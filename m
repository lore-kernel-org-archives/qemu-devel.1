Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F8C433F1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928F7206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EpqCcXDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928F7206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYwm-0002cr-SD
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jxYvZ-0001ik-0s
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:46:09 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:43780)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1jxYvP-0007Zf-SL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=4tq8ItQDnGgjnTbwdK
 RPljKtjILylHMFZyFmgvb/pGg=; b=EpqCcXDwzZoDPf0XWD1BJe8kVvTya6zsAo
 N/ZGkvSWk+TsV8DFE7BkLHLlztIWGYXyJX/6nUFola0Rx37B/4Q0MqiF8utbylya
 gTs8tv3599JpSaDiOEVW72JQQ5GEJSE4A8FIIky1pc8VlJJxFNf3rLLZ6AL0xI9K
 AJB6OyjZo=
Received: from localhost.localdomain (unknown [115.199.195.7])
 by smtp1 (Coremail) with SMTP id GdxpCgAn4lsxyhVfP3Z_Bg--.566S4;
 Tue, 21 Jul 2020 00:45:42 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: dmitry.fleytman@gmail.com,
	jasowang@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH v2] e1000e: using bottom half to send packets
Date: Mon, 20 Jul 2020 09:45:35 -0700
Message-Id: <20200720164535.76559-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgAn4lsxyhVfP3Z_Bg--.566S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4DJr47tw1fGFy8Jr4ruFg_yoW3AF18pa
 ykGwsxXr15Gry3Ars7Wr15Jr15Jr4xJ3s7Wr4Uu34FqFZ3A34DJr18ta1UZFW3ua9FvrZ5
 CF45trya9ryDXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-18PUUUUU=
X-Originating-IP: [115.199.195.7]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBaxlnbVet1SidywABso
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 12:45:46
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
Cc: alxndr@bu.edu, Li Qiang <liq3ea@163.com>, liq3ea@gmail.com,
 qemu-devel@nongnu.org, ppandit@redhat.com
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
Change since v1:
Per Jason's review here:
-- https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05368.html
1. Cancel and schedule the tx bh when VM is stopped or resume
2. Add a tx_burst for e1000e configuration to throttle the bh execution
3. Add a tx_waiting to record whether the bh is pending or not
Don't use BQL in the tx_bh handler as when tx_bh is executed, the BQL is
acquired.

 hw/net/e1000e.c      |   6 +++
 hw/net/e1000e_core.c | 106 ++++++++++++++++++++++++++++++++++---------
 hw/net/e1000e_core.h |   8 ++++
 3 files changed, 98 insertions(+), 22 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index fda34518c9..24e35a78bf 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -77,10 +77,14 @@ typedef struct E1000EState {
 
     bool disable_vnet;
 
+    int32_t tx_burst;
+
     E1000ECore core;
 
 } E1000EState;
 
+#define TX_BURST 256
+
 #define E1000E_MMIO_IDX     0
 #define E1000E_FLASH_IDX    1
 #define E1000E_IO_IDX       2
@@ -263,6 +267,7 @@ static void e1000e_core_realize(E1000EState *s)
 {
     s->core.owner = &s->parent_obj;
     s->core.owner_nic = s->nic;
+    s->core.tx_burst = s->tx_burst;
 }
 
 static void
@@ -665,6 +670,7 @@ static Property e1000e_properties[] = {
                         e1000e_prop_subsys_ven, uint16_t),
     DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, 0,
                         e1000e_prop_subsys, uint16_t),
+    DEFINE_PROP_INT32("x-txburst", E1000EState, tx_burst, TX_BURST),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcd186cac5..0a38a50cca 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -909,19 +909,18 @@ e1000e_rx_ring_init(E1000ECore *core, E1000E_RxRing *rxr, int idx)
     rxr->i      = &i[idx];
 }
 
-static void
-e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
+static int32_t
+e1000e_start_xmit(struct e1000e_tx *q)
 {
+    E1000ECore *core = q->core;
     dma_addr_t base;
     struct e1000_tx_desc desc;
-    bool ide = false;
-    const E1000E_RingInfo *txi = txr->i;
-    uint32_t cause = E1000_ICS_TXQE;
+    const E1000E_RingInfo *txi;
+    E1000E_TxRing txr;
+    int32_t num_packets = 0;
 
-    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
-        trace_e1000e_tx_disabled();
-        return;
-    }
+    e1000e_tx_ring_init(core, &txr, q - &core->tx[0]);
+    txi = txr.i;
 
     while (!e1000e_ring_empty(core, txi)) {
         base = e1000e_ring_head_descr(core, txi);
@@ -931,15 +930,17 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
         trace_e1000e_tx_descr((void *)(intptr_t)desc.buffer_addr,
                               desc.lower.data, desc.upper.data);
 
-        e1000e_process_tx_desc(core, txr->tx, &desc, txi->idx);
-        cause |= e1000e_txdesc_writeback(core, base, &desc, &ide, txi->idx);
+        e1000e_process_tx_desc(core, txr.tx, &desc, txi->idx);
+        q->cause |= e1000e_txdesc_writeback(core, base, &desc,
+                                            &q->ide, txi->idx);
 
         e1000e_ring_advance(core, txi, 1);
+        if (++num_packets >= core->tx_burst) {
+            break;
+        }
     }
 
-    if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
-        e1000e_set_interrupt_cause(core, cause);
-    }
+    return num_packets;
 }
 
 static bool
@@ -2423,32 +2424,41 @@ e1000e_set_dbal(E1000ECore *core, int index, uint32_t val)
 static void
 e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
 {
-    E1000E_TxRing txr;
     core->mac[index] = val;
 
     if (core->mac[TARC0] & E1000_TARC_ENABLE) {
-        e1000e_tx_ring_init(core, &txr, 0);
-        e1000e_start_xmit(core, &txr);
+        if (core->tx[0].tx_waiting) {
+            return;
+        }
+        core->tx[0].tx_waiting = 1;
+        if (!core->vm_running) {
+            return;
+        }
+        qemu_bh_schedule(core->tx[0].tx_bh);
     }
 
     if (core->mac[TARC1] & E1000_TARC_ENABLE) {
-        e1000e_tx_ring_init(core, &txr, 1);
-        e1000e_start_xmit(core, &txr);
+        if (core->tx[1].tx_waiting) {
+            return;
+        }
+        core->tx[1].tx_waiting = 1;
+        if (!core->vm_running) {
+            return;
+        }
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
 
@@ -3315,10 +3325,56 @@ e1000e_vm_state_change(void *opaque, int running, RunState state)
         trace_e1000e_vm_state_running();
         e1000e_intrmgr_resume(core);
         e1000e_autoneg_resume(core);
+        core->vm_running = 1;
+
+        for (int i = 0; i < E1000E_NUM_QUEUES; i++) {
+            qemu_bh_schedule(core->tx[i].tx_bh);
+        }
+
     } else {
         trace_e1000e_vm_state_stopped();
+
+        for (int i = 0; i < E1000E_NUM_QUEUES; i++) {
+            qemu_bh_cancel(core->tx[i].tx_bh);
+        }
+
         e1000e_autoneg_pause(core);
         e1000e_intrmgr_pause(core);
+        core->vm_running = 0;
+    }
+}
+
+
+static void e1000e_core_tx_bh(void *opaque)
+{
+    struct e1000e_tx *q = opaque;
+    E1000ECore *core = q->core;
+    int32_t ret;
+
+    if (!core->vm_running) {
+        assert(q->tx_waiting);
+        return;
+    }
+
+    q->tx_waiting = 0;
+
+    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
+        trace_e1000e_tx_disabled();
+        return;
+    }
+
+    q->cause = E1000_ICS_TXQE;
+    q->ide = false;
+
+    ret = e1000e_start_xmit(q);
+    if (ret >= core->tx_burst) {
+        qemu_bh_schedule(q->tx_bh);
+        q->tx_waiting = 1;
+        return;
+    }
+
+    if (!q->ide || !e1000e_intrmgr_delay_tx_causes(core, &q->cause)) {
+        e1000e_set_interrupt_cause(core, q->cause);
     }
 }
 
@@ -3334,12 +3390,15 @@ e1000e_core_pci_realize(E1000ECore     *core,
                                        e1000e_autoneg_timer, core);
     e1000e_intrmgr_pci_realize(core);
 
+    core->vm_running = runstate_is_running();
     core->vmstate =
         qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
 
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
                         E1000E_MAX_TX_FRAGS, core->has_vnet);
+        core->tx[i].core = core;
+        core->tx[i].tx_bh = qemu_bh_new(e1000e_core_tx_bh, &core->tx[i]);
     }
 
     net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
@@ -3367,6 +3426,9 @@ e1000e_core_pci_uninit(E1000ECore *core)
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_reset(core->tx[i].tx_pkt);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
+        qemu_bh_cancel(core->tx[i].tx_bh);
+        qemu_bh_delete(core->tx[i].tx_bh);
+        core->tx[i].tx_bh = NULL;
     }
 
     net_rx_pkt_uninit(core->rx_pkt);
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index aee32f7e48..0c16dce3a6 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -77,10 +77,18 @@ struct E1000Core {
         unsigned char sum_needed;
         bool cptse;
         struct NetTxPkt *tx_pkt;
+        QEMUBH *tx_bh;
+        uint32_t tx_waiting;
+        uint32_t cause;
+        bool ide;
+        E1000ECore *core;
     } tx[E1000E_NUM_QUEUES];
 
     struct NetRxPkt *rx_pkt;
 
+    int32_t tx_burst;
+
+    bool vm_running;
     bool has_vnet;
     int max_queue_num;
 
-- 
2.17.1



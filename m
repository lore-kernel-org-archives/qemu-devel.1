Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCDFC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC8E22409
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="RbXPluNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC8E22409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKAM-0005oS-EB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK8J-0004LP-K1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:34:03 -0400
Received: from mxa2.seznam.cz ([2a02:598:2::90]:45443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK8F-0000mr-Pt
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:34:03 -0400
Received: from email.seznam.cz
 by email-smtpc9b.ng.seznam.cz (email-smtpc9b.ng.seznam.cz [10.23.14.15])
 id 16d601e5d4691ea413a4e5d1; Tue, 14 Jul 2020 14:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
 t=1594730037; bh=RZFUeAOa2leh68Lw975Km8xHo1QtI6bCglTLg5FMoFo=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=RbXPluNMx44VymEQImCqM6gTjMkWl3/cYn6XjiwrGGf4/PRxO+vkqnd2ox3nMB3Vt
 H7LHV4rkXcRHPINYJdz8JeLuZCBanGCE8cHptDB/ZLBGf4eT2zX9r+tEA+6tCvHPeK
 eoIzkBaPaBG4GUEv5jIC5HtBhVQ4cKfo0Axh/BUQ=
Received: from hathi.duckdns.org (2001:718:2:1654:e269:95ff:fec3:1c81
 [2001:718:2:1654:e269:95ff:fec3:1c81])
 by email-relay18.ng.seznam.cz (Seznam SMTPD 1.3.119) with ESMTP;
 Tue, 14 Jul 2020 14:33:52 +0200 (CEST)  
From: pisa@cmp.felk.cvut.cz
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 5/6] hw/net/can: CTU CAN FD IP open hardware core emulation.
Date: Tue, 14 Jul 2020 14:20:18 +0200
Message-Id: <4e61e618c56fdb2034f3875f8b19635d33d2efbf.1594725647.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:598:2::90;
 envelope-from=autobot.majer@seznam.cz; helo=mxa2.seznam.cz
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Charvat <charvj10@fel.cvut.cz>, Jan Kiszka <jan.kiszka@siemens.com>,
 Ondrej Ille <ondrej.ille@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

The implementation of the model of complete open-source/design/hardware
CAN FD controller. The IP core project has been started and is maintained
by Ondrej Ille at Czech Technical University in Prague.

CTU CAN FD project pages:
	https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core

CAN bus CTU FEE Projects Listing page:
	http://canbus.pages.fel.cvut.cz/

The core is mapped to PCIe card same as on one of its real hardware
adaptations. The device implementing two CTU CAN FD ip cores
is instantiated after CAN bus definition

	-object can-bus,id=canbus0-bus

by QEMU parameters

	-device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/net/can/Makefile.objs |   3 +
 hw/net/can/ctucan_core.c | 691 +++++++++++++++++++++++++++++++++++++++
 hw/net/can/ctucan_core.h | 127 +++++++
 hw/net/can/ctucan_pci.c  | 281 ++++++++++++++++
 4 files changed, 1102 insertions(+)
 create mode 100644 hw/net/can/ctucan_core.c
 create mode 100644 hw/net/can/ctucan_core.h
 create mode 100644 hw/net/can/ctucan_pci.c

diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
index 9f0c4ee332..8945576a22 100644
--- a/hw/net/can/Makefile.objs
+++ b/hw/net/can/Makefile.objs
@@ -2,3 +2,6 @@ common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
 common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
 common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
 common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
+
+common-obj-$(CONFIG_CAN_PCI) += ctucan_core.o
+common-obj-$(CONFIG_CAN_PCI) += ctucan_pci.o
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
new file mode 100644
index 0000000000..f260646777
--- /dev/null
+++ b/hw/net/can/ctucan_core.c
@@ -0,0 +1,691 @@
+/*
+ * CTU CAN FD PCI device emulation
+ * http://canbus.pages.fel.cvut.cz/
+ *
+ * Copyright (c) 2019 Jan Charvat (jancharvat.charvat@gmail.com)
+ *
+ * Based on Kvaser PCI CAN device (SJA1000 based) emulation implemented by
+ * Jin Yang and Pavel Pisa
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "chardev/char.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "net/can_emu.h"
+
+#include "ctucan_core.h"
+
+#ifndef DEBUG_CAN
+#define DEBUG_CAN 0
+#endif /*DEBUG_CAN*/
+
+#define DPRINTF(fmt, ...) \
+    do { \
+        if (DEBUG_CAN) { \
+            qemu_log("[ctucan]: " fmt , ## __VA_ARGS__); \
+        } \
+    } while (0)
+
+static void ctucan_buff2frame(const uint8_t *buff, qemu_can_frame *frame)
+{
+    frame->can_id = 0;
+    frame->can_dlc = 0;
+    frame->flags = 0;
+
+    if (buff == NULL) {
+        return;
+    }
+    {
+        union ctu_can_fd_frame_form_w frame_form_w;
+        union ctu_can_fd_identifier_w identifier_w;
+        unsigned int ide;
+
+        frame_form_w = *(union ctu_can_fd_frame_form_w *) buff;
+        frame->can_dlc = can_dlc2len(frame_form_w.s.dlc);
+
+        identifier_w = *(union ctu_can_fd_identifier_w *) (buff + 4);
+
+        ide = frame_form_w.s.ide;
+        if (ide) {
+            frame->can_id = (identifier_w.s.identifier_base << 18) |
+                            identifier_w.s.identifier_ext;
+            frame->can_id |= QEMU_CAN_EFF_FLAG;
+        } else {
+            frame->can_id = identifier_w.s.identifier_base;
+        }
+
+        if (frame_form_w.s.esi_rsv) {
+            frame->flags |= QEMU_CAN_FRMF_ESI;
+        }
+
+        if (frame_form_w.s.rtr) {
+            frame->can_id |= QEMU_CAN_RTR_FLAG;
+        }
+
+        if (frame_form_w.s.fdf) {   /*CAN FD*/
+            frame->flags |= QEMU_CAN_FRMF_TYPE_FD;
+            if (frame_form_w.s.brs) {
+                frame->flags |= QEMU_CAN_FRMF_BRS;
+            }
+        }
+    }
+
+    memcpy(frame->data, buff + 0x10, 0x40);
+}
+
+
+static int ctucan_frame2buff(const qemu_can_frame *frame, uint8_t *buff)
+{
+    unsigned int bytes_cnt = -1;
+    memset(buff, 0, CTUCAN_MSG_MAX_LEN * sizeof(*buff));
+
+    if (frame == NULL) {
+        return bytes_cnt;
+    }
+    {
+        union ctu_can_fd_frame_form_w *frame_form_w;
+        union ctu_can_fd_identifier_w *identifier_w;
+        frame_form_w = (union ctu_can_fd_frame_form_w *) buff;
+        identifier_w = (union ctu_can_fd_identifier_w *) (buff + 4);
+
+        frame_form_w->u32 = 0;
+        identifier_w->u32 = 0;
+
+        bytes_cnt = frame->can_dlc;
+        bytes_cnt = (bytes_cnt + 3) & ~3;
+        bytes_cnt += 16;
+        frame_form_w->s.rwcnt = (bytes_cnt >> 2) - 1;
+
+        frame_form_w->s.dlc = can_len2dlc(frame->can_dlc);
+
+        if (frame->can_id & QEMU_CAN_EFF_FLAG) {
+            frame_form_w->s.ide = 1;
+            identifier_w->s.identifier_base =
+                                    (frame->can_id & 0x1FFC0000) >> 18;
+            identifier_w->s.identifier_ext = frame->can_id & 0x3FFFF;
+        } else {
+            identifier_w->s.identifier_base = frame->can_id & 0x7FF;
+        }
+
+        if (frame->flags & QEMU_CAN_FRMF_ESI) {
+            frame_form_w->s.esi_rsv = 1;
+        }
+
+        if (frame->can_id & QEMU_CAN_RTR_FLAG) {
+            frame_form_w->s.rtr = 1;
+        }
+
+        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {  /*CAN FD*/
+           frame_form_w->s.fdf = 1;
+            if (frame->flags & QEMU_CAN_FRMF_BRS) {
+                frame_form_w->s.brs = 1;
+            }
+        }
+    }
+
+    memcpy(buff + 0x10, frame->data, 0x40);
+
+    return bytes_cnt;
+}
+
+static void ctucan_update_irq(CtuCanCoreState *s)
+{
+    union ctu_can_fd_int_stat int_rq;
+
+    int_rq.u32 = 0;
+
+    if (s->rx_status_rx_settings.s.rxfrc) {
+        int_rq.s.rbnei = 1;
+    }
+
+    int_rq.u32 &= ~s->int_mask.u32;
+    s->int_stat.u32 |= int_rq.u32;
+    if (s->int_stat.u32 & s->int_ena.u32) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void ctucan_update_txnf(CtuCanCoreState *s)
+{
+    int i;
+    int txnf;
+    unsigned int buff_st;
+
+    txnf = 0;
+
+    for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
+        buff_st = (s->tx_status.u32 >> (i * 4)) & 0xf;
+        if (buff_st == TXT_ETY) {
+            txnf = 1;
+        }
+    }
+    s->status.s.txnf = txnf;
+}
+
+void ctucan_hardware_reset(CtuCanCoreState *s)
+{
+    DPRINTF("Hardware reset in progress!!!\n");
+    int i;
+    unsigned int buff_st;
+    uint32_t buff_st_mask;
+
+    s->tx_status.u32 = 0;
+    for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
+        buff_st_mask = 0xf << (i * 4);
+        buff_st = TXT_ETY;
+        s->tx_status.u32 = (s->tx_status.u32 & ~buff_st_mask) |
+            (buff_st << (i * 4));
+    }
+    s->status.s.idle = 1;
+
+    ctucan_update_txnf(s);
+
+    s->rx_status_rx_settings.u32 = 0;
+    s->rx_tail_pos = 0;
+    s->rx_cnt = 0;
+    s->rx_frame_rem = 0;
+
+    /* Flush RX buffer */
+    s->rx_tail_pos = 0;
+    s->rx_cnt = 0;
+    s->rx_frame_rem = 0;
+
+    /* Set on progdokum reset value */
+    s->mode_settings.u32 = 0;
+    s->mode_settings.s.fde = 1;
+
+    s->int_stat.u32 = 0;
+    s->int_ena.u32 = 0;
+    s->int_mask.u32 = 0;
+
+    s->rx_status_rx_settings.u32 = 0;
+    s->rx_status_rx_settings.s.rxe = 0;
+
+    s->rx_fr_ctr.u32 = 0;
+    s->tx_fr_ctr.u32 = 0;
+
+    s->yolo_reg.s.yolo_val = 3735928559;
+
+    qemu_irq_lower(s->irq);
+}
+
+static void ctucan_send_ready_buffers(CtuCanCoreState *s)
+{
+    qemu_can_frame frame;
+    uint8_t *pf;
+    int buff2tx_idx;
+    uint32_t tx_prio_max;
+    unsigned int buff_st;
+    uint32_t buff_st_mask;
+
+    if (!s->mode_settings.s.ena) {
+        return;
+    }
+
+    do {
+        union ctu_can_fd_int_stat int_stat;
+        int i;
+        buff2tx_idx = -1;
+        tx_prio_max = 0;
+
+        for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
+            uint32_t prio;
+
+            buff_st_mask = 0xf << (i * 4);
+            buff_st = (s->tx_status.u32 >> (i * 4)) & 0xf;
+
+            if (buff_st != TXT_RDY) {
+                continue;
+            }
+            prio = (s->tx_priority.u32 >> (i * 4)) & 0x7;
+            if (tx_prio_max < prio) {
+                tx_prio_max = prio;
+                buff2tx_idx = i;
+            }
+        }
+        if (buff2tx_idx == -1) {
+            break;
+        }
+        buff_st_mask = 0xf << (buff2tx_idx * 4);
+        buff_st = (s->tx_status.u32 >> (buff2tx_idx * 4)) & 0xf;
+        int_stat.u32 = 0;
+        buff_st = TXT_RDY;
+        pf = s->tx_buffer[buff2tx_idx].data;
+        ctucan_buff2frame(pf, &frame);
+        s->status.s.idle = 0;
+        s->status.s.txs = 1;
+        can_bus_client_send(&s->bus_client, &frame, 1);
+        s->status.s.idle = 1;
+        s->status.s.txs = 0;
+        s->tx_fr_ctr.s.tx_fr_ctr_val++;
+        buff_st = TXT_TOK;
+        int_stat.s.txi = 1;
+        int_stat.s.txbhci = 1;
+        s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
+        s->tx_status.u32 = (s->tx_status.u32 & ~buff_st_mask) |
+                        (buff_st << (buff2tx_idx * 4));
+    } while (1);
+}
+
+#define CTUCAN_CORE_TXBUFF_SPAN \
+            (CTU_CAN_FD_TXTB2_DATA_1 - CTU_CAN_FD_TXTB1_DATA_1)
+
+void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
+                       unsigned size)
+{
+    int              i;
+
+    DPRINTF("write 0x%02llx addr 0x%02x\n",
+            (unsigned long long)val, (unsigned int)addr);
+
+    if (addr > CTUCAN_CORE_MEM_SIZE) {
+        return;
+    }
+
+    if (addr >= CTU_CAN_FD_TXTB1_DATA_1) {
+        int buff_num;
+        addr -= CTU_CAN_FD_TXTB1_DATA_1;
+        buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
+        addr %= CTUCAN_CORE_TXBUFF_SPAN;
+        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
+            *(uint32_t *)(s->tx_buffer[buff_num].data + addr) = val;
+        }
+    } else {
+        switch (addr & ~3) {
+        case CTU_CAN_FD_MODE:
+            s->mode_settings.u32 = (uint32_t)val;
+            if (s->mode_settings.s.rst) {
+                ctucan_hardware_reset(s);
+                s->mode_settings.s.rst = 0;
+            }
+            break;
+        case CTU_CAN_FD_COMMAND:
+        {
+            union ctu_can_fd_command command;
+            command.u32 = (uint32_t)val;
+            if (command.s.cdo) {
+                s->status.s.dor = 0;
+            }
+            if (command.s.rrb) {
+                s->rx_tail_pos = 0;
+                s->rx_cnt = 0;
+                s->rx_frame_rem = 0;
+                s->rx_status_rx_settings.s.rxfrc = 0;
+            }
+            if (command.s.txfcrst) {
+                s->tx_fr_ctr.s.tx_fr_ctr_val = 0;
+            }
+            if (command.s.rxfcrst) {
+                s->rx_fr_ctr.s.rx_fr_ctr_val = 0;
+            }
+            break;
+        }
+        case CTU_CAN_FD_INT_STAT:
+            s->int_stat.u32 &= ~(uint32_t)val;
+            break;
+        case CTU_CAN_FD_INT_ENA_SET:
+            s->int_ena.u32 |= (uint32_t)val;
+            break;
+        case CTU_CAN_FD_INT_ENA_CLR:
+            s->int_ena.u32 &= ~(uint32_t)val;
+            break;
+        case CTU_CAN_FD_INT_MASK_SET:
+            s->int_mask.u32 |= (uint32_t)val;
+            break;
+        case CTU_CAN_FD_INT_MASK_CLR:
+            s->int_mask.u32 &= ~(uint32_t)val;
+            break;
+        case CTU_CAN_FD_TX_COMMAND:
+            if (s->mode_settings.s.ena) {
+                union ctu_can_fd_tx_command tx_command;
+                union ctu_can_fd_tx_command mask;
+                unsigned int buff_st;
+                uint32_t buff_st_mask;
+
+                tx_command.u32 = (uint32_t)val;
+                mask.u32 = 0;
+                mask.s.txb1 = 1;
+
+                for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
+                    if (!(tx_command.u32 & (mask.u32 << i))) {
+                        continue;
+                    }
+                    buff_st_mask = 0xf << (i * 4);
+                    buff_st = (s->tx_status.u32 >> (i * 4)) & 0xf;
+                    if (tx_command.s.txca) {
+                        if (buff_st == TXT_RDY) {
+                            buff_st = TXT_ABT;
+                        }
+                    }
+                    if (tx_command.s.txcr) {
+                        if ((buff_st == TXT_TOK) || (buff_st == TXT_ERR) ||
+                            (buff_st == TXT_ABT) || (buff_st == TXT_ETY))
+                            buff_st = TXT_RDY;
+                    }
+                    if (tx_command.s.txce) {
+                        if ((buff_st == TXT_TOK) || (buff_st == TXT_ERR) ||
+                            (buff_st == TXT_ABT))
+                            buff_st = TXT_ETY;
+                    }
+                    s->tx_status.u32 = (s->tx_status.u32 & ~buff_st_mask) |
+                                        (buff_st << (i * 4));
+                }
+
+                ctucan_send_ready_buffers(s);
+                ctucan_update_txnf(s);
+            }
+            break;
+        case CTU_CAN_FD_TX_PRIORITY:
+            s->tx_priority.u32 = (uint32_t)val;
+            break;
+        }
+
+        ctucan_update_irq(s);
+    }
+
+    return;
+}
+
+uint64_t ctucan_mem_read(CtuCanCoreState *s, hwaddr addr, unsigned size)
+{
+    uint32_t val = 0;
+
+    DPRINTF("read addr 0x%02x ...\n", (unsigned int)addr);
+
+    if (addr > CTUCAN_CORE_MEM_SIZE) {
+        return 0;
+    }
+
+    switch (addr & ~3) {
+    case CTU_CAN_FD_DEVICE_ID:
+        {
+            union ctu_can_fd_device_id_version idver;
+            idver.u32 = 0;
+            idver.s.device_id = CTU_CAN_FD_ID;
+            idver.s.ver_major = 2;
+            idver.s.ver_minor = 2;
+            val = idver.u32;
+        }
+        break;
+    case CTU_CAN_FD_MODE:
+        val = s->mode_settings.u32;
+        break;
+    case CTU_CAN_FD_STATUS:
+        val = s->status.u32;
+        break;
+    case CTU_CAN_FD_INT_STAT:
+        val = s->int_stat.u32;
+        break;
+    case CTU_CAN_FD_INT_ENA_SET:
+    case CTU_CAN_FD_INT_ENA_CLR:
+        val = s->int_ena.u32;
+        break;
+    case CTU_CAN_FD_INT_MASK_SET:
+    case CTU_CAN_FD_INT_MASK_CLR:
+        val = s->int_mask.u32;
+        break;
+    case CTU_CAN_FD_RX_MEM_INFO:
+        s->rx_mem_info.u32 = 0;
+        s->rx_mem_info.s.rx_buff_size = CTUCAN_RCV_BUF_LEN >> 2;
+        s->rx_mem_info.s.rx_mem_free = (CTUCAN_RCV_BUF_LEN -
+                                        s->rx_cnt) >> 2;
+        val = s->rx_mem_info.u32;
+        break;
+    case CTU_CAN_FD_RX_POINTERS:
+    {
+        uint32_t rx_head_pos = s->rx_tail_pos + s->rx_cnt;
+        rx_head_pos %= CTUCAN_RCV_BUF_LEN;
+        s->rx_pointers.s.rx_wpp = rx_head_pos;
+        s->rx_pointers.s.rx_rpp = s->rx_tail_pos;
+        val = s->rx_pointers.u32;
+        break;
+    }
+    case CTU_CAN_FD_RX_STATUS:
+    case CTU_CAN_FD_RX_SETTINGS:
+        if (!s->rx_status_rx_settings.s.rxfrc) {
+            s->rx_status_rx_settings.s.rxe = 1;
+        } else {
+            s->rx_status_rx_settings.s.rxe = 0;
+        }
+        if (((s->rx_cnt + 3) & ~3) == CTUCAN_RCV_BUF_LEN) {
+            s->rx_status_rx_settings.s.rxf = 1;
+        } else {
+            s->rx_status_rx_settings.s.rxf = 0;
+        }
+        val = s->rx_status_rx_settings.u32;
+        break;
+    case CTU_CAN_FD_RX_DATA:
+        if (s->rx_cnt) {
+            memcpy(&val, s->rx_buff + s->rx_tail_pos, 4);
+            if (!s->rx_frame_rem) {
+                union ctu_can_fd_frame_form_w frame_form_w;
+                frame_form_w.u32 = val;
+                s->rx_frame_rem = frame_form_w.s.rwcnt * 4 + 4;
+            }
+            s->rx_cnt -= 4;
+            s->rx_frame_rem -= 4;
+            if (!s->rx_frame_rem) {
+                s->rx_status_rx_settings.s.rxfrc--;
+                if (!s->rx_status_rx_settings.s.rxfrc) {
+                    s->status.s.rxne = 0;
+                    s->status.s.idle = 1;
+                    s->status.s.rxs = 0;
+                }
+            }
+            s->rx_tail_pos = (s->rx_tail_pos + 4) % CTUCAN_RCV_BUF_LEN;
+        } else {
+            val = 0;
+        }
+        break;
+    case CTU_CAN_FD_TX_STATUS:
+        val = s->tx_status.u32;
+        break;
+    case CTU_CAN_FD_TX_PRIORITY:
+        val = s->tx_priority.u32;
+        break;
+    case CTU_CAN_FD_RX_FR_CTR:
+        val = s->rx_fr_ctr.s.rx_fr_ctr_val;
+        break;
+    case CTU_CAN_FD_TX_FR_CTR:
+        val = s->tx_fr_ctr.s.tx_fr_ctr_val;
+        break;
+    case CTU_CAN_FD_YOLO_REG:
+        val = s->yolo_reg.s.yolo_val;
+        break;
+    }
+
+    val >>= ((addr & 3) << 3);
+    if (size < 8) {
+        val &= ((uint64_t)1 << (size << 3)) - 1;
+    }
+
+    return val;
+}
+
+bool ctucan_can_receive(CanBusClientState *client)
+{
+    CtuCanCoreState *s = container_of(client, CtuCanCoreState, bus_client);
+
+    if (!s->mode_settings.s.ena) {
+        return false;
+    }
+
+    return true; /* always return true, when operation mode */
+}
+
+ssize_t ctucan_receive(CanBusClientState *client, const qemu_can_frame *frames,
+                        size_t frames_cnt)
+{
+    CtuCanCoreState *s = container_of(client, CtuCanCoreState, bus_client);
+    static uint8_t rcv[CTUCAN_MSG_MAX_LEN];
+    int i;
+    int ret = -1;
+    const qemu_can_frame *frame = frames;
+    union ctu_can_fd_int_stat int_stat;
+    int_stat.u32 = 0;
+
+    if (frames_cnt <= 0) {
+        return 0;
+    }
+
+    ret = ctucan_frame2buff(frame, rcv);
+
+    if (s->rx_cnt + ret > CTUCAN_RCV_BUF_LEN) { /* Data overrun. */
+        s->status.s.dor = 1;
+        int_stat.s.doi = 1;
+        s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
+        ctucan_update_irq(s);
+        DPRINTF("Receive FIFO overrun\n");
+        return ret;
+    }
+    s->status.s.idle = 0;
+    s->status.s.rxs = 1;
+    int_stat.s.rxi = 1;
+    if (((s->rx_cnt + 3) & ~3) == CTUCAN_RCV_BUF_LEN) {
+        int_stat.s.rxfi = 1;
+    }
+    s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
+    s->rx_fr_ctr.s.rx_fr_ctr_val++;
+    s->rx_status_rx_settings.s.rxfrc++;
+    for (i = 0; i < ret; i++) {
+        s->rx_buff[(s->rx_tail_pos + s->rx_cnt) % CTUCAN_RCV_BUF_LEN] = rcv[i];
+        s->rx_cnt++;
+    }
+    s->status.s.rxne = 1;
+
+    ctucan_update_irq(s);
+
+    return 1;
+}
+
+static CanBusClientInfo ctucan_bus_client_info = {
+    .can_receive = ctucan_can_receive,
+    .receive = ctucan_receive,
+};
+
+
+int ctucan_connect_to_bus(CtuCanCoreState *s, CanBusState *bus)
+{
+    s->bus_client.info = &ctucan_bus_client_info;
+
+    if (!bus) {
+        return -EINVAL;
+    }
+
+    if (can_bus_insert_client(bus, &s->bus_client) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+void ctucan_disconnect(CtuCanCoreState *s)
+{
+    can_bus_remove_client(&s->bus_client);
+}
+
+int ctucan_init(CtuCanCoreState *s, qemu_irq irq)
+{
+    s->irq = irq;
+
+    qemu_irq_lower(s->irq);
+
+    ctucan_hardware_reset(s);
+
+    return 0;
+}
+
+const VMStateDescription vmstate_qemu_ctucan_tx_buffer = {
+    .name = "qemu_ctucan_tx_buffer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(data, CtuCanCoreMsgBuffer, CTUCAN_CORE_MSG_MAX_LEN),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int ctucan_post_load(void *opaque, int version_id)
+{
+    CtuCanCoreState *s = opaque;
+    ctucan_update_irq(s);
+    return 0;
+}
+
+/* VMState is needed for live migration of QEMU images */
+const VMStateDescription vmstate_ctucan = {
+    .name = "ctucan",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .post_load = ctucan_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(mode_settings.u32, CtuCanCoreState),
+        VMSTATE_UINT32(status.u32, CtuCanCoreState),
+        VMSTATE_UINT32(int_stat.u32, CtuCanCoreState),
+        VMSTATE_UINT32(int_ena.u32, CtuCanCoreState),
+        VMSTATE_UINT32(int_mask.u32, CtuCanCoreState),
+        VMSTATE_UINT32(brt.u32, CtuCanCoreState),
+        VMSTATE_UINT32(brt_fd.u32, CtuCanCoreState),
+        VMSTATE_UINT32(ewl_erp_fault_state.u32, CtuCanCoreState),
+        VMSTATE_UINT32(rec_tec.u32, CtuCanCoreState),
+        VMSTATE_UINT32(err_norm_err_fd.u32, CtuCanCoreState),
+        VMSTATE_UINT32(ctr_pres.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_a_mask.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_a_val.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_b_mask.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_b_val.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_c_mask.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_c_val.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_ran_low.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_ran_high.u32, CtuCanCoreState),
+        VMSTATE_UINT32(filter_control_filter_status.u32, CtuCanCoreState),
+        VMSTATE_UINT32(rx_mem_info.u32, CtuCanCoreState),
+        VMSTATE_UINT32(rx_pointers.u32, CtuCanCoreState),
+        VMSTATE_UINT32(rx_status_rx_settings.u32, CtuCanCoreState),
+        VMSTATE_UINT32(tx_status.u32, CtuCanCoreState),
+        VMSTATE_UINT32(tx_priority.u32, CtuCanCoreState),
+        VMSTATE_UINT32(err_capt_alc.u32, CtuCanCoreState),
+        VMSTATE_UINT32(trv_delay_ssp_cfg.u32, CtuCanCoreState),
+        VMSTATE_UINT32(rx_fr_ctr.u32, CtuCanCoreState),
+        VMSTATE_UINT32(tx_fr_ctr.u32, CtuCanCoreState),
+        VMSTATE_UINT32(debug_register.u32, CtuCanCoreState),
+        VMSTATE_UINT32(yolo_reg.u32, CtuCanCoreState),
+        VMSTATE_UINT32(timestamp_low.u32, CtuCanCoreState),
+        VMSTATE_UINT32(timestamp_high.u32, CtuCanCoreState),
+
+        VMSTATE_STRUCT_ARRAY(tx_buffer, CtuCanCoreState,
+                CTUCAN_CORE_TXBUF_NUM, 0, vmstate_qemu_ctucan_tx_buffer,
+                CtuCanCoreMsgBuffer),
+
+        VMSTATE_BUFFER(rx_buff, CtuCanCoreState),
+        VMSTATE_UINT32(rx_tail_pos, CtuCanCoreState),
+        VMSTATE_UINT32(rx_cnt, CtuCanCoreState),
+        VMSTATE_UINT32(rx_frame_rem, CtuCanCoreState),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/net/can/ctucan_core.h b/hw/net/can/ctucan_core.h
new file mode 100644
index 0000000000..f21cb1c5ec
--- /dev/null
+++ b/hw/net/can/ctucan_core.h
@@ -0,0 +1,127 @@
+/*
+ * CTU CAN FD device emulation
+ * http://canbus.pages.fel.cvut.cz/
+ *
+ * Copyright (c) 2019 Jan Charvat (jancharvat.charvat@gmail.com)
+ *
+ * Based on Kvaser PCI CAN device (SJA1000 based) emulation implemented by
+ * Jin Yang and Pavel Pisa
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef HW_CAN_CTUCAN_CORE_H
+#define HW_CAN_CTUCAN_CORE_H
+
+#include "exec/hwaddr.h"
+#include "net/can_emu.h"
+
+
+#ifndef __LITTLE_ENDIAN_BITFIELD
+#define __LITTLE_ENDIAN_BITFIELD 1
+#endif
+
+#include "ctu_can_fd_frame.h"
+#include "ctu_can_fd_regs.h"
+
+#define CTUCAN_CORE_MEM_SIZE       0x500
+
+/* The max size for a message in FIFO */
+#define CTUCAN_MSG_MAX_LEN        (CTU_CAN_FD_DATA_1_4_W + 64)
+/* The receive buffer size. */
+#define CTUCAN_RCV_BUF_LEN        (1024 * 8)
+
+
+/* The max size for a message buffer */
+#define CTUCAN_CORE_MSG_MAX_LEN       0x50
+/* The receive buffer size. */
+#define CTUCAN_CORE_RCV_BUF_LEN       0x1000
+
+#define CTUCAN_CORE_TXBUF_NUM            4
+
+typedef struct CtuCanCoreMsgBuffer {
+    uint8_t data[CTUCAN_CORE_MSG_MAX_LEN];
+} CtuCanCoreMsgBuffer;
+
+typedef struct CtuCanCoreState {
+    union ctu_can_fd_mode_settings                  mode_settings;
+    union ctu_can_fd_status                         status;
+    union ctu_can_fd_int_stat                       int_stat;
+    union ctu_can_fd_int_ena_set                    int_ena;
+    union ctu_can_fd_int_mask_set                   int_mask;
+    union ctu_can_fd_btr                            brt;
+    union ctu_can_fd_btr_fd                         brt_fd;
+    union ctu_can_fd_ewl_erp_fault_state            ewl_erp_fault_state;
+    union ctu_can_fd_rec_tec                        rec_tec;
+    union ctu_can_fd_err_norm_err_fd                err_norm_err_fd;
+    union ctu_can_fd_ctr_pres                       ctr_pres;
+    union ctu_can_fd_filter_a_mask                  filter_a_mask;
+    union ctu_can_fd_filter_a_val                   filter_a_val;
+    union ctu_can_fd_filter_b_mask                  filter_b_mask;
+    union ctu_can_fd_filter_b_val                   filter_b_val;
+    union ctu_can_fd_filter_c_mask                  filter_c_mask;
+    union ctu_can_fd_filter_c_val                   filter_c_val;
+    union ctu_can_fd_filter_ran_low                 filter_ran_low;
+    union ctu_can_fd_filter_ran_high                filter_ran_high;
+    union ctu_can_fd_filter_control_filter_status   filter_control_filter_status;
+    union ctu_can_fd_rx_mem_info                    rx_mem_info;
+    union ctu_can_fd_rx_pointers                    rx_pointers;
+    union ctu_can_fd_rx_status_rx_settings          rx_status_rx_settings;
+    union ctu_can_fd_tx_status                      tx_status;
+    union ctu_can_fd_tx_priority                    tx_priority;
+    union ctu_can_fd_err_capt_alc                   err_capt_alc;
+    union ctu_can_fd_trv_delay_ssp_cfg              trv_delay_ssp_cfg;
+    union ctu_can_fd_rx_fr_ctr                      rx_fr_ctr;
+    union ctu_can_fd_tx_fr_ctr                      tx_fr_ctr;
+    union ctu_can_fd_debug_register                 debug_register;
+    union ctu_can_fd_yolo_reg                       yolo_reg;
+    union ctu_can_fd_timestamp_low                  timestamp_low;
+    union ctu_can_fd_timestamp_high                 timestamp_high;
+
+    CtuCanCoreMsgBuffer tx_buffer[CTUCAN_CORE_TXBUF_NUM];
+
+    uint8_t         rx_buff[CTUCAN_RCV_BUF_LEN];  /* 32~95 .. 64bytes Rx FIFO */
+    uint32_t        rx_tail_pos;        /* Count by bytes. */
+    uint32_t        rx_cnt;        /* Count by bytes. */
+    uint32_t        rx_frame_rem;
+
+    qemu_irq        irq;
+    CanBusClientState bus_client;
+} CtuCanCoreState;
+
+void ctucan_hardware_reset(CtuCanCoreState *s);
+
+void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
+                       unsigned size);
+
+uint64_t ctucan_mem_read(CtuCanCoreState *s, hwaddr addr, unsigned size);
+
+int ctucan_connect_to_bus(CtuCanCoreState *s, CanBusState *bus);
+
+void ctucan_disconnect(CtuCanCoreState *s);
+
+int ctucan_init(CtuCanCoreState *s, qemu_irq irq);
+
+bool ctucan_can_receive(CanBusClientState *client);
+
+ssize_t ctucan_receive(CanBusClientState *client,
+                        const qemu_can_frame *frames, size_t frames_cnt);
+
+extern const VMStateDescription vmstate_ctucan;
+
+#endif
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
new file mode 100644
index 0000000000..accc7f0fd9
--- /dev/null
+++ b/hw/net/can/ctucan_pci.c
@@ -0,0 +1,281 @@
+/*
+ * CTU CAN FD PCI device emulation
+ * http://canbus.pages.fel.cvut.cz/
+ *
+ * Copyright (c) 2019 Jan Charvat (jancharvat.charvat@gmail.com)
+ *
+ * Based on Kvaser PCI CAN device (SJA1000 based) emulation implemented by
+ * Jin Yang and Pavel Pisa
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/thread.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "hw/irq.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "net/can_emu.h"
+
+#include "ctucan_core.h"
+
+#define TYPE_CAN_PCI_DEV "ctucan_pci"
+
+#define CTUCAN_PCI_DEV(obj) \
+    OBJECT_CHECK(CtuCanPCIState, (obj), TYPE_CAN_PCI_DEV)
+
+#define CTUCAN_PCI_CORE_COUNT     2
+#define CTUCAN_PCI_CORE_RANGE     0x10000
+
+#define CTUCAN_PCI_BAR_COUNT      2
+
+#define CTUCAN_PCI_BYTES_PER_CORE 0x4000
+
+#ifndef PCI_VENDOR_ID_TEDIA
+#define PCI_VENDOR_ID_TEDIA 0x1760
+#endif
+
+#define PCI_DEVICE_ID_TEDIA_CTUCAN_VER21 0xff00
+
+#define CTUCAN_BAR0_RANGE 0x8000
+#define CTUCAN_BAR0_CTUCAN_ID 0x0000
+#define CTUCAN_BAR0_CRA_BASE  0x4000
+#define CYCLONE_IV_CRA_A2P_IE (0x0050)
+
+#define CTUCAN_WITHOUT_CTUCAN_ID  0
+#define CTUCAN_WITH_CTUCAN_ID     1
+
+typedef struct CtuCanPCIState {
+    /*< private >*/
+    PCIDevice       dev;
+    /*< public >*/
+    MemoryRegion    ctucan_io[CTUCAN_PCI_BAR_COUNT];
+
+    CtuCanCoreState ctucan_state[CTUCAN_PCI_CORE_COUNT];
+    qemu_irq        irq;
+
+    char            *model; /* The model that support, only SJA1000 now. */
+    CanBusState     *canbus[CTUCAN_PCI_CORE_COUNT];
+} CtuCanPCIState;
+
+static void ctucan_pci_reset(DeviceState *dev)
+{
+    CtuCanPCIState *d = CTUCAN_PCI_DEV(dev);
+    int i;
+
+    for (i = 0 ; i < CTUCAN_PCI_CORE_COUNT; i++) {
+        ctucan_hardware_reset(&d->ctucan_state[i]);
+    }
+}
+
+static uint64_t ctucan_pci_id_cra_io_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    if (addr >= 4) {
+        return 0;
+    }
+
+    uint64_t tmp = 0xC0000000 + CTUCAN_PCI_CORE_COUNT;
+    tmp >>= ((addr & 3) << 3);
+    if (size < 8) {
+        tmp &= ((uint64_t)1 << (size << 3)) - 1;
+    }
+    printf("addr=%lx,size=%x,tmp=%lx\n", addr, size, tmp);
+    return tmp;
+}
+
+static void ctucan_pci_id_cra_io_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+
+}
+
+static uint64_t ctucan_pci_cores_io_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    CtuCanPCIState *d = opaque;
+    CtuCanCoreState *s;
+    hwaddr core_num = addr / CTUCAN_PCI_BYTES_PER_CORE;
+
+    if (core_num >= CTUCAN_PCI_CORE_COUNT) {
+        return 0;
+    }
+
+    s = &d->ctucan_state[core_num];
+
+    return ctucan_mem_read(s, addr % CTUCAN_PCI_BYTES_PER_CORE, size);
+}
+
+static void ctucan_pci_cores_io_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    CtuCanPCIState *d = opaque;
+    CtuCanCoreState *s;
+    hwaddr core_num = addr / CTUCAN_PCI_BYTES_PER_CORE;
+
+    if (core_num >= CTUCAN_PCI_CORE_COUNT) {
+        return;
+    }
+
+    s = &d->ctucan_state[core_num];
+
+    return ctucan_mem_write(s, addr % CTUCAN_PCI_BYTES_PER_CORE, data, size);
+}
+
+static const MemoryRegionOps ctucan_pci_id_cra_io_ops = {
+    .read = ctucan_pci_id_cra_io_read,
+    .write = ctucan_pci_id_cra_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static const MemoryRegionOps ctucan_pci_cores_io_ops = {
+    .read = ctucan_pci_cores_io_read,
+    .write = ctucan_pci_cores_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void ctucan_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CtuCanPCIState *d = CTUCAN_PCI_DEV(pci_dev);
+    uint8_t *pci_conf;
+    int i;
+
+    pci_conf = pci_dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
+
+    d->irq = pci_allocate_irq(&d->dev);
+
+    for (i = 0 ; i < CTUCAN_PCI_CORE_COUNT; i++) {
+        ctucan_init(&d->ctucan_state[i], d->irq);
+    }
+
+    for (i = 0 ; i < CTUCAN_PCI_CORE_COUNT; i++) {
+        if (ctucan_connect_to_bus(&d->ctucan_state[i], d->canbus[i]) < 0) {
+            error_setg(errp, "ctucan_connect_to_bus failed");
+            return;
+        }
+    }
+
+    memory_region_init_io(&d->ctucan_io[0], OBJECT(d),
+                          &ctucan_pci_id_cra_io_ops, d,
+                          "ctucan_pci-core0", CTUCAN_BAR0_RANGE);
+    memory_region_init_io(&d->ctucan_io[1], OBJECT(d),
+                          &ctucan_pci_cores_io_ops, d,
+                          "ctucan_pci-core1", CTUCAN_PCI_CORE_RANGE);
+
+    for (i = 0 ; i < CTUCAN_PCI_BAR_COUNT; i++) {
+        pci_register_bar(&d->dev, i, PCI_BASE_ADDRESS_MEM_MASK & 0,
+                         &d->ctucan_io[i]);
+    }
+}
+
+static void ctucan_pci_exit(PCIDevice *pci_dev)
+{
+    CtuCanPCIState *d = CTUCAN_PCI_DEV(pci_dev);
+    int i;
+
+    for (i = 0 ; i < CTUCAN_PCI_CORE_COUNT; i++) {
+        ctucan_disconnect(&d->ctucan_state[i]);
+    }
+
+    qemu_free_irq(d->irq);
+}
+
+static const VMStateDescription vmstate_ctucan_pci = {
+    .name = "ctucan_pci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, CtuCanPCIState),
+        VMSTATE_STRUCT(ctucan_state[0], CtuCanPCIState, 0, vmstate_ctucan,
+                       CtuCanCoreState),
+#if CTUCAN_PCI_CORE_COUNT >= 2
+        VMSTATE_STRUCT(ctucan_state[1], CtuCanPCIState, 0, vmstate_ctucan,
+                       CtuCanCoreState),
+#endif
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ctucan_pci_instance_init(Object *obj)
+{
+    CtuCanPCIState *d = CTUCAN_PCI_DEV(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[0],
+                             qdev_prop_allow_set_link_before_realize, 0);
+#if CTUCAN_PCI_CORE_COUNT >= 2
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[1],
+                             qdev_prop_allow_set_link_before_realize, 0);
+#endif
+}
+
+static void ctucan_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = ctucan_pci_realize;
+    k->exit = ctucan_pci_exit;
+    k->vendor_id = PCI_VENDOR_ID_TEDIA;
+    k->device_id = PCI_DEVICE_ID_TEDIA_CTUCAN_VER21;
+    k->revision = 0x00;
+    k->class_id = 0x000c09;
+    k->subsystem_vendor_id = PCI_VENDOR_ID_TEDIA;
+    k->subsystem_id = PCI_DEVICE_ID_TEDIA_CTUCAN_VER21;
+    dc->desc = "CTU CAN PCI";
+    dc->vmsd = &vmstate_ctucan_pci;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->reset = ctucan_pci_reset;
+}
+
+static const TypeInfo ctucan_pci_info = {
+    .name          = TYPE_CAN_PCI_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(CtuCanPCIState),
+    .class_init    = ctucan_pci_class_init,
+    .instance_init = ctucan_pci_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void ctucan_pci_register_types(void)
+{
+    type_register_static(&ctucan_pci_info);
+}
+
+type_init(ctucan_pci_register_types)
-- 
2.20.1



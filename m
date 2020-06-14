Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E911A206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E911A206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTrP-0002SO-90
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTey-0000Sj-2D; Sun, 14 Jun 2020 10:30:56 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38484
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTev-0005Yb-46; Sun, 14 Jun 2020 10:30:55 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTem-0006Hv-95; Sun, 14 Jun 2020 15:30:50 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:37 +0100
Message-Id: <20200614142840.10245-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 19/22] mac_via: rework ADB state machine to be compatible with
 both MacOS and Linux
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The existing ADB state machine is designed to work with Linux which has a different
interpretation of the state machine detailed in "Guide to the Macintosh Family
Hardware". In particular the current Linux implementation includes an extra change
to IDLE state when switching the VIA between send and receive modes which does not
occur in MacOS, and omitting this transition causes the current mac_via ADB state
machine to fail.

Rework the ADB state machine accordingly so that it can enumerate and autopoll the
ADB under both Linux and MacOS, including the addition of the new adb_autopoll_block()
and adb_autopoll_unblock() functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c         | 363 +++++++++++++++++++++++++-------------
 hw/misc/trace-events      |   3 +
 include/hw/misc/mac_via.h |   1 +
 3 files changed, 246 insertions(+), 121 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 4779236f95..7676545474 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -599,176 +599,297 @@ static void via1_rtc_update(MacVIAState *m)
     m->cmd = REG_EMPTY;
 }
 
-static int adb_via_poll(MacVIAState *s, int state, uint8_t *data)
+static void adb_via_poll(void *opaque)
 {
-    ADBBusState *adb_bus = &s->adb_bus;
+    MacVIAState *m = opaque;
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
+    MOS6522State *s = MOS6522(v1s);
+    ADBBusState *adb_bus = &m->adb_bus;
+    uint8_t obuf[9];
+    uint8_t *data = &s->sr;
+    int olen;
+    uint16_t pending;
 
-    if (state != ADB_STATE_IDLE) {
-        return 0;
+    /*
+     * Setting vADBInt below indicates that an autopoll reply has been
+     * received, however we must block autopoll until the point where
+     * the entire reply has been read back to the host
+     */
+    if (adb_bus->autopoll_blocked) {
+        return;
+    } else {
+        adb_autopoll_block(adb_bus);
     }
 
-    if (s->adb_data_in_size < s->adb_data_in_index) {
-        return 0;
-    }
+    m->adb_data_in_index = 0;
+    m->adb_data_out_index = 0;
+    olen = adb_poll(adb_bus, obuf, adb_bus->autopoll_mask);
+
+    if (olen > 0) {
+        /* Autopoll response */
+        *data = obuf[0];
+        olen--;
+        memcpy(m->adb_data_in, &obuf[1], olen);
+        m->adb_data_in_size = olen;
+
+        s->b &= ~VIA1B_vADBInt;
+        qemu_irq_raise(m->adb_data_ready);
+    } else if (olen < 0) {
+        /* Bus timeout (device does not exist) */
+        *data = 0xff;
+        s->b |= VIA1B_vADBInt;
+        adb_autopoll_unblock(adb_bus);
+    } else {
+        pending = adb_bus->pending & ~(1 << (m->adb_autopoll_cmd >> 4));
+
+        if (pending) {
+            /*
+             * Bus timeout (device exists but another device has data). Block
+             * autopoll so the OS can read out the first EVEN and first ODD
+             * byte to determine bus timeout and SRQ status
+             */
+            *data = m->adb_autopoll_cmd;
+            s->b &= ~VIA1B_vADBInt;
 
-    if (s->adb_data_out_index != 0) {
-        return 0;
-    }
+            obuf[0] = 0xff;
+            obuf[1] = 0xff;
+            olen = 2;
 
-    s->adb_data_in_index = 0;
-    s->adb_data_out_index = 0;
-    s->adb_data_in_size = adb_poll(adb_bus, s->adb_data_in,
-                                   adb_bus->autopoll_mask);
+            memcpy(m->adb_data_in, obuf, olen);
+            m->adb_data_in_size = olen;
 
-    if (s->adb_data_in_size) {
-        *data = s->adb_data_in[s->adb_data_in_index++];
-        qemu_irq_raise(s->adb_data_ready);
+            qemu_irq_raise(m->adb_data_ready);
+        } else {
+            /* Bus timeout (device exists but no other device has data) */
+            *data = 0;
+            s->b |= VIA1B_vADBInt;
+            adb_autopoll_unblock(adb_bus);
+        }
     }
 
-    return s->adb_data_in_size;
+    trace_via1_adb_poll(*data, (s->b & VIA1B_vADBInt) ? "+" : "-",
+                        adb_bus->status, m->adb_data_in_index, olen);
 }
 
-static int adb_via_send(MacVIAState *s, int state, uint8_t data)
+static int adb_via_send_len(uint8_t data)
 {
-    switch (state) {
-    case ADB_STATE_NEW:
-        s->adb_data_out_index = 0;
-        break;
-    case ADB_STATE_EVEN:
-        if ((s->adb_data_out_index & 1) == 0) {
-            return 0;
-        }
-        break;
-    case ADB_STATE_ODD:
-        if (s->adb_data_out_index & 1) {
-            return 0;
+    /* Determine the send length from the given ADB command */
+    uint8_t cmd = data & 0xc;
+    uint8_t reg = data & 0x3;
+
+    switch (cmd) {
+    case 0x8:
+        /* Listen command */
+        switch (reg) {
+        case 2:
+            /* Register 2 is only used for the keyboard */
+            return 3;
+        case 3:
+            /*
+             * Fortunately our devices only implement writes
+             * to register 3 which is fixed at 2 bytes
+             */
+            return 3;
+        default:
+            qemu_log_mask(LOG_UNIMP, "ADB unknown length for register %d\n",
+                          reg);
+            return 1;
         }
-        break;
-    case ADB_STATE_IDLE:
-        return 0;
+    default:
+        /* Talk, BusReset */
+        return 1;
     }
-
-    assert(s->adb_data_out_index < sizeof(s->adb_data_out) - 1);
-
-    s->adb_data_out[s->adb_data_out_index++] = data;
-    qemu_irq_raise(s->adb_data_ready);
-    return 1;
 }
 
-static int adb_via_receive(MacVIAState *s, int state, uint8_t *data)
+static void adb_via_send(MacVIAState *s, int state, uint8_t data)
 {
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&s->mos6522_via1);
+    MOS6522State *ms = MOS6522(v1s);
+    ADBBusState *adb_bus = &s->adb_bus;
+    uint16_t autopoll_mask;
+
     switch (state) {
     case ADB_STATE_NEW:
-        return 0;
-
-    case ADB_STATE_EVEN:
-        if (s->adb_data_in_size <= 0) {
-            qemu_irq_raise(s->adb_data_ready);
-            return 0;
-        }
-
-        if (s->adb_data_in_index >= s->adb_data_in_size) {
-            *data = 0;
-            qemu_irq_raise(s->adb_data_ready);
-            return 1;
-        }
-
-        if ((s->adb_data_in_index & 1) == 0) {
-            return 0;
+        /*
+         * Command byte: vADBInt tells host autopoll data already present
+         * in VIA shift register and ADB transceiver
+         */
+        adb_autopoll_block(adb_bus);
+
+        if (adb_bus->status & ADB_STATUS_POLLREPLY) {
+            /* Tell the host the existing data is from autopoll */
+            ms->b &= ~VIA1B_vADBInt;
+        } else {
+            ms->b |= VIA1B_vADBInt;
+            s->adb_data_out_index = 0;
+            s->adb_data_out[s->adb_data_out_index++] = data;
         }
 
+        trace_via1_adb_send(" NEW", data, (ms->b & VIA1B_vADBInt) ? "+" : "-");
+        qemu_irq_raise(s->adb_data_ready);
         break;
 
+    case ADB_STATE_EVEN:
     case ADB_STATE_ODD:
-        if (s->adb_data_in_size <= 0) {
-            qemu_irq_raise(s->adb_data_ready);
-            return 0;
-        }
-
-        if (s->adb_data_in_index >= s->adb_data_in_size) {
-            *data = 0;
-            qemu_irq_raise(s->adb_data_ready);
-            return 1;
-        }
-
-        if (s->adb_data_in_index & 1) {
-            return 0;
-        }
+        ms->b |= VIA1B_vADBInt;
+        s->adb_data_out[s->adb_data_out_index++] = data;
 
+        trace_via1_adb_send(state == ADB_STATE_EVEN ? "EVEN" : " ODD",
+                            data, (ms->b & VIA1B_vADBInt) ? "+" : "-");
+        qemu_irq_raise(s->adb_data_ready);
         break;
 
     case ADB_STATE_IDLE:
-        if (s->adb_data_out_index == 0) {
-            return 0;
-        }
+        return;
+    }
 
-        s->adb_data_in_size = adb_request(&s->adb_bus, s->adb_data_in,
+    /* If the command is complete, execute it */
+    if (s->adb_data_out_index == adb_via_send_len(s->adb_data_out[0])) {
+        s->adb_data_in_size = adb_request(adb_bus, s->adb_data_in,
                                           s->adb_data_out,
                                           s->adb_data_out_index);
-        s->adb_data_out_index = 0;
         s->adb_data_in_index = 0;
-        if (s->adb_data_in_size < 0) {
-            *data = 0xff;
-            qemu_irq_raise(s->adb_data_ready);
-            return -1;
-        }
-
-        if (s->adb_data_in_size == 0) {
-            return 0;
-        }
-
-        break;
-    }
 
-    assert(s->adb_data_in_index < sizeof(s->adb_data_in) - 1);
+        /*
+         * If last command is TALK, store it for use by autopoll and adjust
+         * the autopoll mask accordingly
+         */
+        if ((s->adb_data_out[0] & 0xc) == 0xc) {
+            s->adb_autopoll_cmd = s->adb_data_out[0];
 
-    *data = s->adb_data_in[s->adb_data_in_index++];
-    qemu_irq_raise(s->adb_data_ready);
-    if (*data == 0xff || *data == 0) {
-        return 0;
+            autopoll_mask = 1 << (s->adb_autopoll_cmd >> 4);
+            adb_set_autopoll_mask(adb_bus, autopoll_mask);
+        }
     }
-    return 1;
 }
 
-static void via1_adb_update(MacVIAState *m)
+static void adb_via_receive(MacVIAState *s, int state, uint8_t *data)
 {
-    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
-    MOS6522State *s = MOS6522(v1s);
-    int state;
-    int ret;
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&s->mos6522_via1);
+    MOS6522State *ms = MOS6522(v1s);
+    ADBBusState *adb_bus = &s->adb_bus;
+    uint16_t pending;
 
-    state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+    switch (state) {
+    case ADB_STATE_NEW:
+        ms->b |= VIA1B_vADBInt;
+        return;
 
-    if (s->acr & VIA1ACR_vShiftOut) {
-        /* output mode */
-        ret = adb_via_send(m, state, s->sr);
-        if (ret > 0) {
-            s->b &= ~VIA1B_vADBInt;
+    case ADB_STATE_IDLE:
+        /*
+         * Since adb_request() will have already consumed the data from the
+         * device, we must detect this extra state change and re-inject the
+         * reponse as either a "fake" autopoll reply or bus timeout
+         * accordingly
+         */
+        if (s->adb_data_in_index == 0) {
+            if (adb_bus->status & ADB_STATUS_BUSTIMEOUT) {
+                *data = 0xff;
+                ms->b |= VIA1B_vADBInt;
+                s->adb_data_in[0] = 0xff;
+                s->adb_data_in[1] = 0xff;
+                s->adb_data_in_size = 2;
+                qemu_irq_raise(s->adb_data_ready);
+            } else if (s->adb_data_in_size > 0) {
+                adb_bus->status = ADB_STATUS_POLLREPLY;
+                *data = s->adb_autopoll_cmd;
+                ms->b &= ~VIA1B_vADBInt;
+                qemu_irq_raise(s->adb_data_ready);
+            }
         } else {
-            s->b |= VIA1B_vADBInt;
+            ms->b |= VIA1B_vADBInt;
+            adb_autopoll_unblock(adb_bus);
         }
-    } else {
-        /* input mode */
-        ret = adb_via_receive(m, state, &s->sr);
-        if (ret > 0 && s->sr != 0xff) {
-            s->b &= ~VIA1B_vADBInt;
-        } else {
-            s->b |= VIA1B_vADBInt;
+
+        trace_via1_adb_receive("IDLE", *data,
+                        (ms->b & VIA1B_vADBInt) ? "+" : "-", adb_bus->status,
+                        s->adb_data_in_index, s->adb_data_in_size);
+
+        break;
+
+    case ADB_STATE_EVEN:
+    case ADB_STATE_ODD:
+        switch (s->adb_data_in_index) {
+        case 0:
+            /* First EVEN byte: vADBInt indicates bus timeout */
+            trace_via1_adb_receive(state == ADB_STATE_EVEN ? "EVEN" : " ODD",
+                                   *data, (ms->b & VIA1B_vADBInt) ? "+" : "-",
+                                   adb_bus->status, s->adb_data_in_index,
+                                   s->adb_data_in_size);
+
+            *data = s->adb_data_in[s->adb_data_in_index++];
+            if (adb_bus->status & ADB_STATUS_BUSTIMEOUT) {
+                ms->b &= ~VIA1B_vADBInt;
+            } else {
+                ms->b |= VIA1B_vADBInt;
+            }
+            break;
+
+        case 1:
+            /* First ODD byte: vADBInt indicates SRQ */
+            trace_via1_adb_receive(state == ADB_STATE_EVEN ? "EVEN" : " ODD",
+                                   *data, (ms->b & VIA1B_vADBInt) ? "+" : "-",
+                                   adb_bus->status, s->adb_data_in_index,
+                                   s->adb_data_in_size);
+
+            *data = s->adb_data_in[s->adb_data_in_index++];
+            pending = adb_bus->pending & ~(1 << (s->adb_autopoll_cmd >> 4));
+            if (pending) {
+                ms->b &= ~VIA1B_vADBInt;
+            } else {
+                ms->b |= VIA1B_vADBInt;
+            }
+            break;
+
+        default:
+            /*
+             * Otherwise vADBInt indicates end of data. Note that Linux
+             * specifically checks for the sequence 0x0 0xff to confirm the
+             * end of the request, so provide these extra bytes below to keep
+             * it happy
+             */
+            trace_via1_adb_receive(state == ADB_STATE_EVEN ? "EVEN" : " ODD",
+                                   *data, (ms->b & VIA1B_vADBInt) ? "+" : "-",
+                                   adb_bus->status, s->adb_data_in_index,
+                                   s->adb_data_in_size);
+
+            if (s->adb_data_in_index < s->adb_data_in_size) {
+                *data = s->adb_data_in[s->adb_data_in_index++];
+                ms->b |= VIA1B_vADBInt;
+            } else if (s->adb_data_in_index == s->adb_data_in_size) {
+                *data = 0;
+                s->adb_data_in_index++;
+                ms->b &= ~VIA1B_vADBInt;
+            } else {
+                *data = 0xff;
+                ms->b &= ~VIA1B_vADBInt;
+                adb_bus->status = 0;
+                adb_autopoll_unblock(adb_bus);
+            }
+            break;
         }
+
+        qemu_irq_raise(s->adb_data_ready);
+        break;
     }
 }
 
-static void via_adb_poll(void *opaque)
+static void via1_adb_update(MacVIAState *m)
 {
-    MacVIAState *m = opaque;
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
     MOS6522State *s = MOS6522(v1s);
-    int state;
+    int oldstate, state;
 
-    if (s->b & VIA1B_vADBInt) {
-        state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
-        if (adb_via_poll(m, state, &s->sr)) {
-            s->b &= ~VIA1B_vADBInt;
+    oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+    state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+
+    if (state != oldstate) {
+        if (s->acr & VIA1ACR_vShiftOut) {
+            /* output mode */
+            adb_via_send(m, state, s->sr);
+        } else {
+            /* input mode */
+            adb_via_receive(m, state, &s->sr);
         }
     }
 }
@@ -913,7 +1034,7 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
-    adb_register_autopoll_callback(adb_bus, via_adb_poll, m);
+    adb_register_autopoll_callback(adb_bus, adb_via_poll, m);
     m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
                                                VIA1_IRQ_ADB_READY_BIT);
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5561746866..68a6d9f2ab 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -202,6 +202,9 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=%u value=0x%02x"
 via1_rtc_cmd_pram_write(int addr, int value) "addr=%u value=0x%02x"
 via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
 via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
+via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s data=0x%02x vADBInt=%s"
+via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
+via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 2aaf9e27bf..0be05d649b 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -112,6 +112,7 @@ typedef struct MacVIAState {
     int adb_data_out_index;
     uint8_t adb_data_in[128];
     uint8_t adb_data_out[16];
+    uint8_t adb_autopoll_cmd;
 } MacVIAState;
 
 #endif
-- 
2.20.1



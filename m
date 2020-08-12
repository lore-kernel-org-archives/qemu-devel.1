Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C4520838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="Se968BH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C4520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nK2-0006zQ-7A
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHV-00026a-45
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:49 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40886
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHS-0006kT-S2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:48 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 96F9D415C6;
 Wed, 12 Aug 2020 11:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225365; bh=btRqdaUXVRbDKjkqGiCstodc5y/Je6n9QgR65B0DETM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Se968BH6gAtXshSMnb2cmrIEKara0yfaAZe2E70KuKTp1tgV1Fna0E2bEzb8iN4+s
 ZlQI021gGsARm+ZCck+2IizIEB24rEn+YFCmfsVUksaH2Qcp8f6nkj5KnwgsNO3/hz
 fR4OpRLmKNapqoDXCd0bpdEWOFzj0N/qbKTn5YMI=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/13] hw/usb: Add U2F key passthru mode
Date: Wed, 12 Aug 2020 11:41:27 +0200
Message-Id: <20200812094135.20550-6-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the U2F key pass-through mode.

The pass-through mode consists of passing all requests made from the
guest to the physical security key connected to the host machine and
vice versa.

In addition, the dedicated pass-through allows to have a U2F security key
shared on several guests which is not possible with a simple host device
assignment pass-through.

The pass-through mode is associated with a device inheriting from
u2f-key base.

To work, it needs the path to a U2F hidraw, obtained from the Qemu
command line, and passed by the user:

    qemu -usb -device u2f-passthru,hidraw=/dev/hidrawX

Autoscan and U2F compatibility checking features are given at the end
of the patch series.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 hw/usb/u2f-passthru.c | 423 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 423 insertions(+)
 create mode 100644 hw/usb/u2f-passthru.c

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
new file mode 100644
index 0000000000..106b5abf9e
--- /dev/null
+++ b/hw/usb/u2f-passthru.c
@@ -0,0 +1,423 @@
+/*
+ * U2F USB Passthru device.
+ *
+ * Copyright (c) 2020 César Belley <cesar.belley@lse.epita.fr>
+ * Written by César Belley <cesar.belley@lse.epita.fr>
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
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/usb.h"
+#include "migration/vmstate.h"
+
+#include "u2f.h"
+
+#define NONCE_SIZE 8
+#define BROADCAST_CID 0xFFFFFFFF
+#define TRANSACTION_TIMEOUT 120000
+
+struct transaction {
+    uint32_t cid;
+    uint16_t resp_bcnt;
+    uint16_t resp_size;
+
+    /* Nonce for broadcast isolation */
+    uint8_t nonce[NONCE_SIZE];
+};
+
+typedef struct U2FPassthruState U2FPassthruState;
+
+#define CURRENT_TRANSACTIONS_NUM 4
+
+struct U2FPassthruState {
+    U2FKeyState base;
+
+    /* Host device */
+    char *hidraw;
+    int hidraw_fd;
+
+    /* Current Transactions */
+    struct transaction current_transactions[CURRENT_TRANSACTIONS_NUM];
+    uint8_t current_transactions_start;
+    uint8_t current_transactions_end;
+    uint8_t current_transactions_num;
+
+    /* Transaction time checking */
+    int64_t last_transaction_time;
+    QEMUTimer timer;
+};
+
+#define TYPE_U2F_PASSTHRU "u2f-passthru"
+#define PASSTHRU_U2F_KEY(obj) \
+    OBJECT_CHECK(U2FPassthruState, (obj), TYPE_U2F_PASSTHRU)
+
+/* Init packet sizes */
+#define PACKET_INIT_HEADER_SIZE 7
+#define PACKET_INIT_DATA_SIZE (U2FHID_PACKET_SIZE - PACKET_INIT_HEADER_SIZE)
+
+/* Cont packet sizes */
+#define PACKET_CONT_HEADER_SIZE 5
+#define PACKET_CONT_DATA_SIZE (U2FHID_PACKET_SIZE - PACKET_CONT_HEADER_SIZE)
+
+struct packet_init {
+    uint32_t cid;
+    uint8_t cmd;
+    uint8_t bcnth;
+    uint8_t bcntl;
+    uint8_t data[PACKET_INIT_DATA_SIZE];
+} QEMU_PACKED;
+
+static inline uint32_t packet_get_cid(const void *packet)
+{
+    return *((uint32_t *)packet);
+}
+
+static inline bool packet_is_init(const void *packet)
+{
+    return ((uint8_t *)packet)[4] & (1 << 7);
+}
+
+static inline uint16_t packet_init_get_bcnt(
+        const struct packet_init *packet_init)
+{
+    uint16_t bcnt = 0;
+    bcnt |= packet_init->bcnth << 8;
+    bcnt |= packet_init->bcntl;
+
+    return bcnt;
+}
+
+static void u2f_passthru_reset(U2FPassthruState *key)
+{
+    timer_del(&key->timer);
+    qemu_set_fd_handler(key->hidraw_fd, NULL, NULL, key);
+    key->last_transaction_time = 0;
+    key->current_transactions_start = 0;
+    key->current_transactions_end = 0;
+    key->current_transactions_num = 0;
+}
+
+static void u2f_timeout_check(void *opaque)
+{
+    U2FPassthruState *key = opaque;
+    int64_t time = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+
+    if (time > key->last_transaction_time + TRANSACTION_TIMEOUT) {
+        u2f_passthru_reset(key);
+    } else {
+        timer_mod(&key->timer, time + TRANSACTION_TIMEOUT / 4);
+    }
+}
+
+static int u2f_transaction_get_index(U2FPassthruState *key, uint32_t cid)
+{
+    for (int i = 0; i < key->current_transactions_num; ++i) {
+        int index = (key->current_transactions_start + i)
+            % CURRENT_TRANSACTIONS_NUM;
+        if (cid == key->current_transactions[index].cid) {
+            return index;
+        }
+    }
+    return -1;
+}
+
+static struct transaction *u2f_transaction_get(U2FPassthruState *key,
+                                               uint32_t cid)
+{
+    int index = u2f_transaction_get_index(key, cid);
+    if (index < 0) {
+        return NULL;
+    }
+    return &key->current_transactions[index];
+}
+
+static struct transaction *u2f_transaction_get_from_nonce(U2FPassthruState *key,
+                                const uint8_t nonce[NONCE_SIZE])
+{
+    for (int i = 0; i < key->current_transactions_num; ++i) {
+        int index = (key->current_transactions_start + i)
+            % CURRENT_TRANSACTIONS_NUM;
+        if (key->current_transactions[index].cid == BROADCAST_CID
+            && memcmp(nonce, key->current_transactions[index].nonce,
+                      NONCE_SIZE) == 0) {
+            return &key->current_transactions[index];
+        }
+    }
+    return NULL;
+}
+
+static void u2f_transaction_close(U2FPassthruState *key, uint32_t cid)
+{
+    int index, next_index;
+    index = u2f_transaction_get_index(key, cid);
+    if (index < 0) {
+        return;
+    }
+    next_index = (index + 1) % CURRENT_TRANSACTIONS_NUM;
+
+    /* Rearrange to ensure the oldest is at the start position */
+    while (next_index != key->current_transactions_end) {
+        memcpy(&key->current_transactions[index],
+               &key->current_transactions[next_index],
+               sizeof(struct transaction));
+
+        index = next_index;
+        next_index = (index + 1) % CURRENT_TRANSACTIONS_NUM;
+    }
+
+    key->current_transactions_end = index;
+    --key->current_transactions_num;
+
+    if (key->current_transactions_num == 0) {
+        u2f_passthru_reset(key);
+    }
+}
+
+static void u2f_transaction_add(U2FPassthruState *key, uint32_t cid,
+                                const uint8_t nonce[NONCE_SIZE])
+{
+    uint8_t index;
+    struct transaction *transaction;
+
+    if (key->current_transactions_num >= CURRENT_TRANSACTIONS_NUM) {
+        /* Close the oldest transaction */
+        index = key->current_transactions_start;
+        transaction = &key->current_transactions[index];
+        u2f_transaction_close(key, transaction->cid);
+    }
+
+    /* Index */
+    index = key->current_transactions_end;
+    key->current_transactions_end = (index + 1) % CURRENT_TRANSACTIONS_NUM;
+    ++key->current_transactions_num;
+
+    /* Transaction */
+    transaction = &key->current_transactions[index];
+    transaction->cid = cid;
+    transaction->resp_bcnt = 0;
+    transaction->resp_size = 0;
+
+    /* Nonce */
+    if (nonce != NULL) {
+        memcpy(transaction->nonce, nonce, NONCE_SIZE);
+    }
+}
+
+static void u2f_passthru_read(void *opaque);
+
+static void u2f_transaction_start(U2FPassthruState *key,
+                                  const struct packet_init *packet_init)
+{
+    int64_t time;
+
+    /* Transaction */
+    if (packet_init->cid == BROADCAST_CID) {
+        u2f_transaction_add(key, packet_init->cid, packet_init->data);
+    } else {
+        u2f_transaction_add(key, packet_init->cid, NULL);
+    }
+
+    /* Time */
+    time = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    if (key->last_transaction_time == 0) {
+        qemu_set_fd_handler(key->hidraw_fd, u2f_passthru_read, NULL, key);
+        timer_init_ms(&key->timer, QEMU_CLOCK_VIRTUAL, u2f_timeout_check, key);
+        timer_mod(&key->timer, time + TRANSACTION_TIMEOUT / 4);
+    }
+    key->last_transaction_time = time;
+}
+
+static void u2f_passthru_recv_from_host(U2FPassthruState *key,
+                                    const uint8_t packet[U2FHID_PACKET_SIZE])
+{
+    struct transaction *transaction;
+    uint32_t cid;
+
+    /* Retrieve transaction */
+    cid = packet_get_cid(packet);
+    if (cid == BROADCAST_CID) {
+        struct packet_init *packet_init;
+        if (!packet_is_init(packet)) {
+            return;
+        }
+        packet_init = (struct packet_init *)packet;
+        transaction = u2f_transaction_get_from_nonce(key, packet_init->data);
+    } else {
+        transaction = u2f_transaction_get(key, cid);
+    }
+
+    /* Ignore no started transaction */
+    if (transaction == NULL) {
+        return;
+    }
+
+    if (packet_is_init(packet)) {
+        struct packet_init *packet_init = (struct packet_init *)packet;
+        transaction->resp_bcnt = packet_init_get_bcnt(packet_init);
+        transaction->resp_size = PACKET_INIT_DATA_SIZE;
+
+        if (packet_init->cid == BROADCAST_CID) {
+            /* Nonce checking for legitimate response */
+            if (memcmp(transaction->nonce, packet_init->data, NONCE_SIZE)
+                != 0) {
+                return;
+            }
+        }
+    } else {
+        transaction->resp_size += PACKET_CONT_DATA_SIZE;
+    }
+
+    /* Transaction end check */
+    if (transaction->resp_size >= transaction->resp_bcnt) {
+        u2f_transaction_close(key, cid);
+    }
+    u2f_send_to_guest(&key->base, packet);
+}
+
+static void u2f_passthru_read(void *opaque)
+{
+    U2FPassthruState *key = opaque;
+    U2FKeyState *base = &key->base;
+    uint8_t packet[2 * U2FHID_PACKET_SIZE];
+    int ret;
+
+    /* Full size base queue check */
+    if (base->pending_in_num >= U2FHID_PENDING_IN_NUM) {
+        return;
+    }
+
+    ret = read(key->hidraw_fd, packet, sizeof(packet));
+    if (ret < 0) {
+        /* Detach */
+        if (base->dev.attached) {
+            usb_device_detach(&base->dev);
+            u2f_passthru_reset(key);
+        }
+        return;
+    }
+    if (ret != U2FHID_PACKET_SIZE) {
+        return;
+    }
+    u2f_passthru_recv_from_host(key, packet);
+}
+
+static void u2f_passthru_recv_from_guest(U2FKeyState *base,
+                                    const uint8_t packet[U2FHID_PACKET_SIZE])
+{
+    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
+    uint8_t host_packet[U2FHID_PACKET_SIZE + 1];
+    ssize_t written;
+
+    if (packet_is_init(packet)) {
+        u2f_transaction_start(key, (struct packet_init *)packet);
+    }
+
+    host_packet[0] = 0;
+    memcpy(host_packet + 1, packet, U2FHID_PACKET_SIZE);
+
+    written = write(key->hidraw_fd, host_packet, sizeof(host_packet));
+    if (written != sizeof(host_packet)) {
+        error_report("%s: Bad written size (req 0x%lx, val 0x%lx)",
+                     TYPE_U2F_PASSTHRU, sizeof(host_packet), written);
+    }
+}
+
+static void u2f_passthru_unrealize(U2FKeyState *base)
+{
+    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
+
+    u2f_passthru_reset(key);
+    qemu_close(key->hidraw_fd);
+}
+
+static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
+{
+    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
+    int fd;
+
+    if (key->hidraw == NULL) {
+        error_setg(errp, "%s: Missing hidraw", TYPE_U2F_PASSTHRU);
+        return;
+    }
+
+    fd = qemu_open(key->hidraw, O_RDWR);
+    if (fd < 0) {
+        error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
+                   key->hidraw);
+        return;
+    }
+    key->hidraw_fd = fd;
+    u2f_passthru_reset(key);
+}
+
+static int u2f_passthru_post_load(void *opaque, int version_id)
+{
+    U2FPassthruState *key = opaque;
+    u2f_passthru_reset(key);
+    return 0;
+}
+
+static const VMStateDescription u2f_passthru_vmstate = {
+    .name = "u2f-key-passthru",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = u2f_passthru_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_U2F_KEY(base, U2FPassthruState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property u2f_passthru_properties[] = {
+    DEFINE_PROP_STRING("hidraw", U2FPassthruState, hidraw),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void u2f_passthru_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    U2FKeyClass *kc = U2F_KEY_CLASS(klass);
+
+    kc->realize = u2f_passthru_realize;
+    kc->unrealize = u2f_passthru_unrealize;
+    kc->recv_from_guest = u2f_passthru_recv_from_guest;
+    dc->desc = "QEMU U2F passthrough key";
+    dc->vmsd = &u2f_passthru_vmstate;
+    device_class_set_props(dc, u2f_passthru_properties);
+}
+
+static const TypeInfo u2f_key_passthru_info = {
+    .name = TYPE_U2F_PASSTHRU,
+    .parent = TYPE_U2F_KEY,
+    .instance_size = sizeof(U2FPassthruState),
+    .class_init = u2f_passthru_class_init
+};
+
+static void u2f_key_passthru_register_types(void)
+{
+    type_register_static(&u2f_key_passthru_info);
+}
+
+type_init(u2f_key_passthru_register_types)
-- 
2.28.0



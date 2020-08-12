Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0E3206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="W0pGJgvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0E3206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nLZ-0001mg-Ko
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHV-00027R-Ki
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:49 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40892
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHT-0006ka-7J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:49 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 08404415CC;
 Wed, 12 Aug 2020 11:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225366; bh=YJhDGPHCamtSTbZXVCPZAZHaVE0kAI955YrNVx6bkSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W0pGJgvYq8E0iIrSxG3X39AK2ic++bXQ3nX0FeHrFV7M+SV3cYfrjFvGxHCU+bYRF
 nt16QJvngz+07mBB7IGkz23f2Rads/ObYQuht/ldavGPJnstOlPHve4dyun1TwB0Js
 WuDQ9jjVq4LMFMZWCpTEV0b0KyKNVYaqMW8R66tA=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/13] hw/usb: Add U2F key emulated mode
Date: Wed, 12 Aug 2020 11:41:28 +0200
Message-Id: <20200812094135.20550-7-cesar.belley@lse.epita.fr>
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

This patch adds the U2F key emulated mode.

The emulated mode consists of completely emulating the behavior of a
U2F device through software part. Libu2f-emu is used for that.

The emulated mode is associated with a device inheriting from
u2f-key base.

To work, an emulated U2F device must have differents elements which
can be given in different ways. This is detailed in docs/u2f.txt.

The Ephemeral one is the simplest way to configure, it lets the device
generate all the elements it needs for a single use of the lifetime
of the device:

    qemu -usb -device u2f-emulated

For more information about libu2f-emu see this page:
https://github.com/MattGorko/libu2f-emu.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 hw/usb/u2f-emulated.c | 405 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 405 insertions(+)
 create mode 100644 hw/usb/u2f-emulated.c

diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
new file mode 100644
index 0000000000..9e1b829f3d
--- /dev/null
+++ b/hw/usb/u2f-emulated.c
@@ -0,0 +1,405 @@
+/*
+ * U2F USB Emulated device.
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
+#include "qemu/thread.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "hw/usb.h"
+#include "hw/qdev-properties.h"
+
+#include <u2f-emu/u2f-emu.h>
+
+#include "u2f.h"
+
+/* Counter which sync with a file */
+struct synced_counter {
+    /* Emulated device counter */
+    struct u2f_emu_vdev_counter vdev_counter;
+
+    /* Private attributes */
+    uint32_t value;
+    FILE *fp;
+};
+
+static void counter_increment(struct u2f_emu_vdev_counter *vdev_counter)
+{
+    struct synced_counter *counter = (struct synced_counter *)vdev_counter;
+    ++counter->value;
+
+    /* Write back */
+    if (fseek(counter->fp, 0, SEEK_SET) == -1) {
+        return;
+    }
+    fprintf(counter->fp, "%u\n", counter->value);
+}
+
+static uint32_t counter_read(struct u2f_emu_vdev_counter *vdev_counter)
+{
+    struct synced_counter *counter = (struct synced_counter *)vdev_counter;
+    return counter->value;
+}
+
+typedef struct U2FEmulatedState U2FEmulatedState;
+
+#define PENDING_OUT_NUM 32
+
+struct U2FEmulatedState {
+    U2FKeyState base;
+
+    /* U2F virtual emulated device */
+    u2f_emu_vdev *vdev;
+    QemuMutex vdev_mutex;
+
+    /* Properties */
+    char *dir;
+    char *cert;
+    char *privkey;
+    char *entropy;
+    char *counter;
+    struct synced_counter synced_counter;
+
+    /* Pending packets received from the guest */
+    uint8_t pending_out[PENDING_OUT_NUM][U2FHID_PACKET_SIZE];
+    uint8_t pending_out_start;
+    uint8_t pending_out_end;
+    uint8_t pending_out_num;
+    QemuMutex pending_out_mutex;
+
+    /* Emulation thread and sync */
+    QemuCond key_cond;
+    QemuMutex key_mutex;
+    QemuThread key_thread;
+    bool stop_thread;
+    EventNotifier notifier;
+};
+
+#define TYPE_U2F_EMULATED "u2f-emulated"
+#define EMULATED_U2F_KEY(obj) \
+    OBJECT_CHECK(U2FEmulatedState, (obj), TYPE_U2F_EMULATED)
+
+static void u2f_emulated_reset(U2FEmulatedState *key)
+{
+    key->pending_out_start = 0;
+    key->pending_out_end = 0;
+    key->pending_out_num = 0;
+}
+
+static void u2f_pending_out_add(U2FEmulatedState *key,
+                                const uint8_t packet[U2FHID_PACKET_SIZE])
+{
+    int index;
+
+    if (key->pending_out_num >= PENDING_OUT_NUM) {
+        return;
+    }
+
+    index = key->pending_out_end;
+    key->pending_out_end = (index + 1) % PENDING_OUT_NUM;
+    ++key->pending_out_num;
+
+    memcpy(&key->pending_out[index], packet, U2FHID_PACKET_SIZE);
+}
+
+static uint8_t *u2f_pending_out_get(U2FEmulatedState *key)
+{
+    int index;
+
+    if (key->pending_out_num == 0) {
+        return NULL;
+    }
+
+    index  = key->pending_out_start;
+    key->pending_out_start = (index + 1) % PENDING_OUT_NUM;
+    --key->pending_out_num;
+
+    return key->pending_out[index];
+}
+
+static void u2f_emulated_recv_from_guest(U2FKeyState *base,
+                                    const uint8_t packet[U2FHID_PACKET_SIZE])
+{
+    U2FEmulatedState *key = EMULATED_U2F_KEY(base);
+
+    qemu_mutex_lock(&key->pending_out_mutex);
+    u2f_pending_out_add(key, packet);
+    qemu_mutex_unlock(&key->pending_out_mutex);
+
+    qemu_mutex_lock(&key->key_mutex);
+    qemu_cond_signal(&key->key_cond);
+    qemu_mutex_unlock(&key->key_mutex);
+}
+
+static void *u2f_emulated_thread(void* arg)
+{
+    U2FEmulatedState *key = arg;
+    uint8_t packet[U2FHID_PACKET_SIZE];
+    uint8_t *packet_out = NULL;
+
+
+    while (true) {
+        /* Wait signal */
+        qemu_mutex_lock(&key->key_mutex);
+        qemu_cond_wait(&key->key_cond, &key->key_mutex);
+        qemu_mutex_unlock(&key->key_mutex);
+
+        /* Exit thread check */
+        if (key->stop_thread) {
+            key->stop_thread = false;
+            break;
+        }
+
+        qemu_mutex_lock(&key->pending_out_mutex);
+        packet_out = u2f_pending_out_get(key);
+        if (packet_out == NULL) {
+            qemu_mutex_unlock(&key->pending_out_mutex);
+            continue;
+        }
+        memcpy(packet, packet_out, U2FHID_PACKET_SIZE);
+        qemu_mutex_unlock(&key->pending_out_mutex);
+
+        qemu_mutex_lock(&key->vdev_mutex);
+        u2f_emu_vdev_send(key->vdev, U2F_EMU_USB, packet,
+                          U2FHID_PACKET_SIZE);
+
+        /* Notify response */
+        if (u2f_emu_vdev_has_response(key->vdev, U2F_EMU_USB)) {
+            event_notifier_set(&key->notifier);
+        }
+        qemu_mutex_unlock(&key->vdev_mutex);
+    }
+    return NULL;
+}
+
+static ssize_t u2f_emulated_read(const char *path, char *buffer,
+                                 size_t buffer_len)
+{
+    int fd;
+    ssize_t ret;
+
+    fd = qemu_open(path, O_RDONLY);
+    if (fd < 0) {
+        return -1;
+    }
+
+    ret = read(fd, buffer, buffer_len);
+    close(fd);
+
+    return ret;
+}
+
+static bool u2f_emulated_setup_counter(const char *path,
+                                       struct synced_counter *counter)
+{
+    int fd, ret;
+    FILE *fp;
+
+    fd = qemu_open(path, O_RDWR);
+    if (fd < 0) {
+        return false;
+    }
+    fp = fdopen(fd, "r+");
+    if (fp == NULL) {
+        close(fd);
+        return false;
+    }
+    ret = fscanf(fp, "%u", &counter->value);
+    if (ret == EOF) {
+        fclose(fp);
+        return false;
+    }
+    counter->fp = fp;
+    counter->vdev_counter.counter_increment = counter_increment;
+    counter->vdev_counter.counter_read = counter_read;
+
+    return true;
+}
+
+static u2f_emu_rc u2f_emulated_setup_vdev_manualy(U2FEmulatedState *key)
+{
+    ssize_t ret;
+    char cert_pem[4096], privkey_pem[2048];
+    struct u2f_emu_vdev_setup setup_info;
+
+    /* Certificate */
+    ret = u2f_emulated_read(key->cert, cert_pem, sizeof(cert_pem));
+    if (ret < 0) {
+        return -1;
+    }
+
+    /* Private key */
+    ret = u2f_emulated_read(key->privkey, privkey_pem, sizeof(privkey_pem));
+    if (ret < 0) {
+        return -1;
+    }
+
+    /* Entropy */
+    ret = u2f_emulated_read(key->entropy, (char *)&setup_info.entropy,
+                            sizeof(setup_info.entropy));
+    if (ret < 0) {
+        return -1;
+    }
+
+    /* Counter */
+    if (!u2f_emulated_setup_counter(key->counter, &key->synced_counter)) {
+        return -1;
+    }
+
+    /* Setup */
+    setup_info.certificate = cert_pem;
+    setup_info.private_key = privkey_pem;
+    setup_info.counter = (struct u2f_emu_vdev_counter *)&key->synced_counter;
+
+    return u2f_emu_vdev_new(&key->vdev, &setup_info);
+}
+
+static void u2f_emulated_event_handler(EventNotifier *notifier)
+{
+    U2FEmulatedState *key = container_of(notifier, U2FEmulatedState, notifier);
+    size_t packet_size;
+    uint8_t *packet_in = NULL;
+
+    event_notifier_test_and_clear(&key->notifier);
+    qemu_mutex_lock(&key->vdev_mutex);
+    while (u2f_emu_vdev_has_response(key->vdev, U2F_EMU_USB)) {
+        packet_size = u2f_emu_vdev_get_response(key->vdev, U2F_EMU_USB,
+                                                &packet_in);
+        if (packet_size == U2FHID_PACKET_SIZE) {
+            u2f_send_to_guest(&key->base, packet_in);
+        }
+        u2f_emu_vdev_free_response(packet_in);
+    }
+    qemu_mutex_unlock(&key->vdev_mutex);
+}
+
+static void u2f_emulated_realize(U2FKeyState *base, Error **errp)
+{
+    U2FEmulatedState *key = EMULATED_U2F_KEY(base);
+    u2f_emu_rc rc;
+
+    if (key->cert != NULL || key->privkey != NULL || key->entropy != NULL
+        || key->counter != NULL) {
+        if (key->cert != NULL && key->privkey != NULL
+            && key->entropy != NULL && key->counter != NULL) {
+            rc = u2f_emulated_setup_vdev_manualy(key);
+        } else {
+            error_setg(errp, "%s: cert, priv, entropy and counter "
+                       "parameters must be provided to manualy configure "
+                       "the emulated device", TYPE_U2F_EMULATED);
+            return;
+        }
+    } else if (key->dir != NULL) {
+        rc = u2f_emu_vdev_new_from_dir(&key->vdev, key->dir);
+    } else {
+        rc = u2f_emu_vdev_new_ephemeral(&key->vdev);
+    }
+
+    if (rc != U2F_EMU_OK) {
+        error_setg(errp, "%s: Failed to setup the key", TYPE_U2F_EMULATED);
+        return;
+    }
+
+    if (event_notifier_init(&key->notifier, false) < 0) {
+        error_setg(errp, "%s: Failed to initialize notifier",
+                   TYPE_U2F_EMULATED);
+        return;
+    }
+    /* Notifier */
+    event_notifier_set_handler(&key->notifier, u2f_emulated_event_handler);
+
+    /* Synchronization */
+    qemu_cond_init(&key->key_cond);
+    qemu_mutex_init(&key->vdev_mutex);
+    qemu_mutex_init(&key->pending_out_mutex);
+    qemu_mutex_init(&key->key_mutex);
+    u2f_emulated_reset(key);
+
+    /* Thread */
+    key->stop_thread = false;
+    qemu_thread_create(&key->key_thread, "u2f-key", u2f_emulated_thread,
+                       key, QEMU_THREAD_JOINABLE);
+}
+
+static void u2f_emulated_unrealize(U2FKeyState *base)
+{
+    U2FEmulatedState *key = EMULATED_U2F_KEY(base);
+
+    /* Thread */
+    key->stop_thread = true;
+    qemu_cond_signal(&key->key_cond);
+    qemu_thread_join(&key->key_thread);
+
+    /* Notifier */
+    event_notifier_set_handler(&key->notifier, NULL);
+    event_notifier_cleanup(&key->notifier);
+
+    /* Synchronization */
+    qemu_cond_destroy(&key->key_cond);
+    qemu_mutex_destroy(&key->vdev_mutex);
+    qemu_mutex_destroy(&key->key_mutex);
+    qemu_mutex_destroy(&key->pending_out_mutex);
+
+    /* Vdev */
+    u2f_emu_vdev_free(key->vdev);
+    if (key->synced_counter.fp != NULL) {
+        fclose(key->synced_counter.fp);
+    }
+}
+
+static Property u2f_emulated_properties[] = {
+    DEFINE_PROP_STRING("dir", U2FEmulatedState, dir),
+    DEFINE_PROP_STRING("cert", U2FEmulatedState, cert),
+    DEFINE_PROP_STRING("privkey", U2FEmulatedState, privkey),
+    DEFINE_PROP_STRING("entropy", U2FEmulatedState, entropy),
+    DEFINE_PROP_STRING("counter", U2FEmulatedState, counter),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void u2f_emulated_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    U2FKeyClass *kc = U2F_KEY_CLASS(klass);
+
+    kc->realize = u2f_emulated_realize;
+    kc->unrealize = u2f_emulated_unrealize;
+    kc->recv_from_guest = u2f_emulated_recv_from_guest;
+    dc->desc = "QEMU U2F emulated key";
+    device_class_set_props(dc, u2f_emulated_properties);
+}
+
+static const TypeInfo u2f_key_emulated_info = {
+    .name = TYPE_U2F_EMULATED,
+    .parent = TYPE_U2F_KEY,
+    .instance_size = sizeof(U2FEmulatedState),
+    .class_init = u2f_emulated_class_init
+};
+
+static void u2f_key_emulated_register_types(void)
+{
+    type_register_static(&u2f_key_emulated_info);
+}
+
+type_init(u2f_key_emulated_register_types)
-- 
2.28.0



Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FABC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9673F206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Nx7uV4Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9673F206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5LL-00035V-IF
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kc5JT-0001j2-1M
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:26:19 -0500
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:52652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kc5JP-0004yH-P2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:26:18 -0500
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 7333C2E14E5;
 Mon,  9 Nov 2020 14:26:11 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 h8b14Qg5gS-QBwORK87; Mon, 09 Nov 2020 14:26:11 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1604921171; bh=Xfb5A+Kz6ZBwa1gKo7rtm2dQTojbChKJjc0znz4P7PE=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=Nx7uV4FfmJ2RO/ixH9XQfsWEcKI9yk4V/bZq6l0Bmritfe2i4BevTDnP0PqZbJ5Dk
 jef/NkwJmHzxsMomIeEpgrXQukcW+gaYrAVyzUYv12a42ft2P97Mgu+1zyvi6jttP5
 DUXDd6XNzKMO8GrfWOy4tXUGZMi3Tj9UD+2n9oRQ=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:605::1:0])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dhixZmtAax-PrnSumc4; Mon, 09 Nov 2020 14:26:11 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] fuzz: add virtio-blk fuzz target
Date: Mon,  9 Nov 2020 14:25:50 +0300
Message-Id: <e2405c459302ecaee2555405604975353bfa3837.1604920905.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1604920905.git.dimastep@yandex-team.ru>
References: <cover.1604920905.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1604920905.git.dimastep@yandex-team.ru>
References: <cover.1604920905.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alxndr@bu.edu, darren.kenny@oracle.com, yc-core@yandex-team.ru,
 stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-blk fuzz target sets up and fuzzes the available virtio-blk
queues. The implementation is based on two files:
  - tests/qtest/fuzz/virtio_scsi_fuzz.c
  - tests/qtest/virtio_blk_test.c

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/meson.build       |   1 +
 tests/qtest/fuzz/virtio_blk_fuzz.c | 234 +++++++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)
 create mode 100644 tests/qtest/fuzz/virtio_blk_fuzz.c

diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index 5162321..8af6848 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -5,6 +5,7 @@ specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
 specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
+specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio_blk_fuzz.c'))
 specific_fuzz_ss.add(files('generic_fuzz.c'))
 
 fork_fuzz = declare_dependency(
diff --git a/tests/qtest/fuzz/virtio_blk_fuzz.c b/tests/qtest/fuzz/virtio_blk_fuzz.c
new file mode 100644
index 0000000..623a756
--- /dev/null
+++ b/tests/qtest/fuzz/virtio_blk_fuzz.c
@@ -0,0 +1,234 @@
+/*
+ * virtio-blk Fuzzing Target
+ *
+ * Copyright Red Hat Inc., 2020
+ *
+ * Based on virtio-scsi-fuzz target.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "tests/qtest/libqos/libqtest.h"
+#include "tests/qtest/libqos/virtio-blk.h"
+#include "tests/qtest/libqos/virtio.h"
+#include "tests/qtest/libqos/virtio-pci.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_pci.h"
+#include "standard-headers/linux/virtio_blk.h"
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+
+#define TEST_IMAGE_SIZE         (64 * 1024 * 1024)
+#define PCI_SLOT                0x02
+#define PCI_FN                  0x00
+
+#define MAX_NUM_QUEUES 64
+
+/* Based on tests/qtest/virtio-blk-test.c. */
+typedef struct {
+    int num_queues;
+    QVirtQueue *vq[MAX_NUM_QUEUES + 2];
+} QVirtioBlkQueues;
+
+static QVirtioBlkQueues *qvirtio_blk_init(QVirtioDevice *dev, uint64_t mask)
+{
+    QVirtioBlkQueues *vs;
+    uint64_t features;
+
+    vs = g_new0(QVirtioBlkQueues, 1);
+
+    features = qvirtio_get_features(dev);
+    if (!mask) {
+        mask = ~((1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                (1u << VIRTIO_RING_F_EVENT_IDX) |
+                (1u << VIRTIO_BLK_F_SCSI));
+    }
+    mask |= ~QVIRTIO_F_BAD_FEATURE;
+    features &= mask;
+    qvirtio_set_features(dev, features);
+
+    vs->num_queues = 1;
+    vs->vq[0] = qvirtqueue_setup(dev, fuzz_qos_alloc, 0);
+
+    qvirtio_set_driver_ok(dev);
+
+    return vs;
+}
+
+static void virtio_blk_fuzz(QTestState *s, QVirtioBlkQueues* queues,
+        const unsigned char *Data, size_t Size)
+{
+    /*
+     * Data is a sequence of random bytes. We split them up into "actions",
+     * followed by data:
+     * [vqa][dddddddd][vqa][dddd][vqa][dddddddddddd] ...
+     * The length of the data is specified by the preceding vqa.length
+     */
+    typedef struct vq_action {
+        uint8_t queue;
+        uint8_t length;
+        uint8_t write;
+        uint8_t next;
+        uint8_t kick;
+    } vq_action;
+
+    /* Keep track of the free head for each queue we interact with */
+    bool vq_touched[MAX_NUM_QUEUES + 2] = {0};
+    uint32_t free_head[MAX_NUM_QUEUES + 2];
+
+    QGuestAllocator *t_alloc = fuzz_qos_alloc;
+
+    QVirtioBlk *blk = fuzz_qos_obj;
+    QVirtioDevice *dev = blk->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    while (Size >= sizeof(vqa)) {
+        /* Copy the action, so we can normalize length, queue and flags */
+        memcpy(&vqa, Data, sizeof(vqa));
+
+        Data += sizeof(vqa);
+        Size -= sizeof(vqa);
+
+        vqa.queue = vqa.queue % queues->num_queues;
+        /* Cap length at the number of remaining bytes in data */
+        vqa.length = vqa.length >= Size ? Size : vqa.length;
+        vqa.write = vqa.write & 1;
+        vqa.next = vqa.next & 1;
+        vqa.kick = vqa.kick & 1;
+
+        q = queues->vq[vqa.queue];
+
+        /* Copy the data into ram, and place it on the virtqueue */
+        uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr, Data, vqa.length);
+        if (vq_touched[vqa.queue] == 0) {
+            vq_touched[vqa.queue] = 1;
+            free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
+                    vqa.write, vqa.next);
+        } else {
+            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
+        }
+
+        if (vqa.kick) {
+            qvirtqueue_kick(s, dev, q, free_head[vqa.queue]);
+            free_head[vqa.queue] = 0;
+        }
+        Data += vqa.length;
+        Size -= vqa.length;
+    }
+    /* In the end, kick each queue we interacted with */
+    for (int i = 0; i < MAX_NUM_QUEUES + 2; i++) {
+        if (vq_touched[i]) {
+            qvirtqueue_kick(s, dev, queues->vq[i], free_head[i]);
+        }
+    }
+}
+
+static void virtio_blk_fork_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    QVirtioBlk *blk = fuzz_qos_obj;
+    static QVirtioBlkQueues *queues;
+    if (!queues) {
+        queues = qvirtio_blk_init(blk->vdev, 0);
+    }
+    if (fork() == 0) {
+        virtio_blk_fuzz(s, queues, Data, Size);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        flush_events(s);
+        wait(NULL);
+    }
+}
+
+static void virtio_blk_with_flag_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    QVirtioBlk *blk = fuzz_qos_obj;
+    static QVirtioBlkQueues *queues;
+
+    if (fork() == 0) {
+        if (Size >= sizeof(uint64_t)) {
+            queues = qvirtio_blk_init(blk->vdev, *(uint64_t *)Data);
+            virtio_blk_fuzz(s, queues,
+                             Data + sizeof(uint64_t), Size - sizeof(uint64_t));
+            flush_events(s);
+        }
+        _Exit(0);
+    } else {
+        flush_events(s);
+        wait(NULL);
+    }
+}
+
+static void virtio_blk_pre_fuzz(QTestState *s)
+{
+    qos_init_path(s);
+    counter_shm_init();
+}
+
+static void drive_destroy(void *path)
+{
+    unlink(path);
+    g_free(path);
+}
+
+static char *drive_create(void)
+{
+    int fd, ret;
+    char *t_path = g_strdup("/tmp/qtest.XXXXXX");
+
+    /* Create a temporary raw image */
+    fd = mkstemp(t_path);
+    g_assert_cmpint(fd, >=, 0);
+    ret = ftruncate(fd, TEST_IMAGE_SIZE);
+    g_assert_cmpint(ret, ==, 0);
+    close(fd);
+
+    g_test_queue_destroy(drive_destroy, t_path);
+    return t_path;
+}
+
+static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
+{
+    char *tmp_path = drive_create();
+
+    g_string_append_printf(cmd_line,
+                           " -drive if=none,id=drive0,file=%s,"
+                           "format=raw,auto-read-only=off ",
+                           tmp_path);
+
+    return arg;
+}
+
+static void register_virtio_blk_fuzz_targets(void)
+{
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name = "virtio-blk-fuzz",
+                .description = "Fuzz the virtio-blk virtual queues, forking "
+                                "for each fuzz run",
+                .pre_vm_init = &counter_shm_init,
+                .pre_fuzz = &virtio_blk_pre_fuzz,
+                .fuzz = virtio_blk_fork_fuzz,},
+                "virtio-blk",
+                &(QOSGraphTestOptions){.before = virtio_blk_test_setup}
+                );
+
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name = "virtio-blk-flags-fuzz",
+                .description = "Fuzz the virtio-blk virtual queues, forking "
+                "for each fuzz run (also fuzzes the virtio flags)",
+                .pre_vm_init = &counter_shm_init,
+                .pre_fuzz = &virtio_blk_pre_fuzz,
+                .fuzz = virtio_blk_with_flag_fuzz,},
+                "virtio-blk",
+                &(QOSGraphTestOptions){.before = virtio_blk_test_setup}
+                );
+}
+
+fuzz_target_init(register_virtio_blk_fuzz_targets);
-- 
2.7.4



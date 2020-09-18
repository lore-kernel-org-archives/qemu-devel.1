Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C7C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97CF2388B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST0xNiCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97CF2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIB0-0004zo-RI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJI0b-0002Ql-KB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJI0Z-0000rx-7Q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoalVdKOwt7sVgHRaOMyNa8oQ6g6ikDqLNZadE+Dcwg=;
 b=ST0xNiCwFZCLnArzdWj7tEVKf0/joy9AbEEmgeDJp+1mvShcH3zfi62sWKmcIv++oqqYMH
 2Fl8Sgx23lSoFpfg5A21A9dzrPOIy1IUUC7VaflMiEh9TdpO8UmEfPtNPShWbkl5qUa01Z
 /GOXvGQy6aJgbS5PWO3ieQSxzVa2Epg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-19koaB4UO5K_aWXRI0wlug-1; Fri, 18 Sep 2020 11:06:20 -0400
X-MC-Unique: 19koaB4UO5K_aWXRI0wlug-1
Received: by mail-wm1-f72.google.com with SMTP id s24so1560091wmh.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZoalVdKOwt7sVgHRaOMyNa8oQ6g6ikDqLNZadE+Dcwg=;
 b=QI+x8mLwZX0gFjS3pgmDGFFI9XgdJEU4rUnt3zwIfgRLEXF0R4uMUwthXZuxiwF7ub
 mpC6RN1jUp5vtd1lUB4dtGA4nnMLXHyT5szQMk0KrdJ8LC+YR68rtl9RFlGZ9x/3DnJs
 CJ3V2WxD7GQ6hTE7WcBdNrvWvuSDovn8bM1FFAa99GycTU5qKO2pKl/id9MkXt9rxTNJ
 /W0mjNLPDJfTooAGmCFuXRo7LsCXOcrx0se3U+bRIQxQJSJN8ZXnx8ppwvWy+dwnb2b/
 17/4tk/Pm6nftYSwy93LqGGT6JMXdGC9SUwh0OHTdVzuEmsl9WirZIxcHQROyfjY3TFN
 TH+g==
X-Gm-Message-State: AOAM531LYYvMUVxkGWfFnmpUaN9UtxQPctHtkb05/z3rrgUWZowUn8nR
 RyWBfo5Se2qyCsqnD4RvLHEwqD9v18Ei3iO6qrAk/Ebf1NT/Ejea3in98ZD++bIALV85ZZ/yqDd
 R2MyRiQvPFtHiwLA=
X-Received: by 2002:adf:e601:: with SMTP id p1mr41172270wrm.172.1600441578510; 
 Fri, 18 Sep 2020 08:06:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVftSVbl+5jNtMLMirXo/u8ABbbXXPjrpKBGGI3KEKNmIb2SYyfklg4McjlyH6BG2F+FZjvg==
X-Received: by 2002:adf:e601:: with SMTP id p1mr41172241wrm.172.1600441578249; 
 Fri, 18 Sep 2020 08:06:18 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id f1sm5373048wrx.75.2020.09.18.08.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:17 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] tests/qtest/vhost-user-test: add support for the
 vhost-user-blk device
Message-ID: <20200918150506.286890-11-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Dima Stepanov <dimastep@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

Add vhost_user_ops structure for the vhost-user-blk device class. Add
the test_reconnect and test_migrate tests for this device.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <960720d82815926a648a3688bf6a38887eb0bf8e.1598865610.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 138 +++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 3df5322614..91f8cfda12 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -24,6 +24,7 @@
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/virtio-pci.h"
+#include "libqos/virtio-blk.h"
 
 #include "libqos/malloc-pc.h"
 #include "hw/virtio/virtio-net.h"
@@ -31,6 +32,7 @@
 #include "standard-headers/linux/vhost_types.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_net.h"
+#include "standard-headers/linux/virtio_blk.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/vfs.h>
@@ -43,6 +45,7 @@
                         " -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce"
+#define QEMU_CMD_BLKCHR " -chardev socket,id=chdev0,path=%s%s"
 
 #define HUGETLBFS_MAGIC       0x958458f6
 
@@ -55,6 +58,7 @@
 #define VHOST_USER_PROTOCOL_F_MQ 0
 #define VHOST_USER_PROTOCOL_F_LOG_SHMFD 1
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
+#define VHOST_USER_PROTOCOL_F_CONFIG 9
 
 #define VHOST_LOG_PAGE 0x1000
 
@@ -78,6 +82,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_PROTOCOL_FEATURES = 16,
     VHOST_USER_GET_QUEUE_NUM = 17,
     VHOST_USER_SET_VRING_ENABLE = 18,
+    VHOST_USER_GET_CONFIG = 24,
+    VHOST_USER_SET_CONFIG = 25,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -99,6 +105,14 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
+#define VHOST_USER_MAX_CONFIG_SIZE 256
+typedef struct VhostUserConfig {
+    uint32_t offset;
+    uint32_t size;
+    uint32_t flags;
+    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
+} VhostUserConfig;
+
 typedef struct VhostUserMsg {
     VhostUserRequest request;
 
@@ -114,6 +128,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        VhostUserConfig config;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -137,6 +152,7 @@ enum {
 
 enum {
     VHOST_USER_NET,
+    VHOST_USER_BLK,
 };
 
 typedef struct TestServer {
@@ -166,12 +182,15 @@ struct vhost_user_ops {
     int type;
     void (*append_opts)(TestServer *s, GString *cmd_line,
             const char *chr_opts);
+    void (*driver_init)(void *obj, QGuestAllocator *alloc);
 
     /* VHOST-USER commands. */
     void (*set_features)(TestServer *s, CharBackend *chr,
             VhostUserMsg *msg);
     void (*get_protocol_features)(TestServer *s,
             CharBackend *chr, VhostUserMsg *msg);
+    void (*get_config)(TestServer *s, CharBackend *chr,
+            VhostUserMsg *msg);
 };
 
 static const char *init_hugepagefs(void);
@@ -194,6 +213,14 @@ static void append_vhost_net_opts(TestServer *s, GString *cmd_line,
                            chr_opts, s->chr_name);
 }
 
+static void append_vhost_blk_opts(TestServer *s, GString *cmd_line,
+                             const char *chr_opts)
+{
+    g_string_append_printf(cmd_line, QEMU_CMD_BLKCHR,
+                           s->socket_path,
+                           chr_opts);
+}
+
 static void append_mem_opts(TestServer *server, GString *cmd_line,
                             int size, enum test_memfd memfd)
 {
@@ -425,6 +452,12 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE + msg.size);
         break;
 
+    case VHOST_USER_GET_CONFIG:
+        if (s->vu_ops->get_config) {
+            s->vu_ops->get_config(s, chr, &msg);
+        }
+        break;
+
     default:
         break;
     }
@@ -727,6 +760,9 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
     guint8 *log;
     guint64 size;
 
+    if (s->vu_ops->driver_init) {
+        s->vu_ops->driver_init(obj, alloc);
+    }
     if (!wait_for_fds(s)) {
         return;
     }
@@ -796,6 +832,24 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
     g_string_free(dest_cmdline, true);
 }
 
+static void vu_blk_driver_init(void *obj, QGuestAllocator *alloc)
+{
+    QVirtioBlk *blk_if;
+    QVirtioDevice *dev;
+    QVirtQueue *vq;
+    uint64_t features;
+
+    blk_if = obj;
+    dev = blk_if->vdev;
+    features = qvirtio_get_features(dev);
+    qvirtio_set_features(dev, features);
+
+    vq = qvirtqueue_setup(dev, alloc, 0);
+    g_assert(vq);
+
+    qvirtio_set_driver_ok(dev);
+}
+
 static void wait_for_rings_started(TestServer *s, size_t count)
 {
     gint64 end_time;
@@ -857,12 +911,21 @@ static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *s = arg;
     GSource *src;
+    int nq;
 
+    if (s->vu_ops->driver_init) {
+        s->vu_ops->driver_init(obj, alloc);
+    }
     if (!wait_for_fds(s)) {
         return;
     }
 
-    wait_for_rings_started(s, 2);
+    nq = 1;
+    if (s->vu_ops->type == VHOST_USER_NET) {
+        /* tx and rx queues */
+        nq = 2;
+    }
+    wait_for_rings_started(s, nq);
 
     /* reconnect */
     s->fds_num = 0;
@@ -872,7 +935,7 @@ static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
     g_source_attach(src, s->context);
     g_source_unref(src);
     g_assert(wait_for_fds(s));
-    wait_for_rings_started(s, 2);
+    wait_for_rings_started(s, nq);
 }
 
 static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
@@ -960,6 +1023,55 @@ static void vu_net_get_protocol_features(TestServer *s, CharBackend *chr,
     qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
 }
 
+static void vu_blk_set_features(TestServer *s, CharBackend *chr,
+        VhostUserMsg *msg)
+{
+    if (s->test_flags == TEST_FLAGS_DISCONNECT) {
+        qemu_chr_fe_disconnect(chr);
+        s->test_flags = TEST_FLAGS_BAD;
+    }
+}
+
+static void vu_blk_get_protocol_features(TestServer *s,
+        CharBackend *chr, VhostUserMsg *msg)
+{
+    /* send back features to qemu */
+    msg->flags |= VHOST_USER_REPLY_MASK;
+    msg->size = sizeof(m.payload.u64);
+    msg->payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+    msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CONFIG;
+    if (s->queues > 1) {
+        msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
+    }
+    qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
+}
+
+static void vu_blk_get_config(TestServer *s, CharBackend *chr,
+        VhostUserMsg *msg)
+{
+    struct virtio_blk_config *blk_config;
+
+    memset(&msg->payload.config, 0, sizeof(msg->payload.config));
+    msg->payload.config.size = sizeof(*blk_config);
+
+    blk_config = (struct virtio_blk_config *)&msg->payload.config.region;
+    /*
+     * Represent 128Mb test disk, with no real backend, just
+     * to test vhost-user functionality.
+     */
+    blk_config->capacity = 262144;
+    blk_config->size_max = 0x20000;
+    blk_config->seg_max = 0x7e;
+    blk_config->blk_size = 512;
+    blk_config->min_io_size = 0x1;
+    blk_config->num_queues = 0x1;
+
+    msg->size = sizeof(msg->payload.config) -
+        sizeof(msg->payload.config.region) + msg->payload.config.size;
+    msg->flags |= VHOST_USER_REPLY_MASK;
+    qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
+}
+
 /* Each VHOST-USER device should have its ops structure defined. */
 static struct vhost_user_ops g_vu_net_ops = {
     .type = VHOST_USER_NET,
@@ -970,6 +1082,17 @@ static struct vhost_user_ops g_vu_net_ops = {
     .get_protocol_features = vu_net_get_protocol_features,
 };
 
+static struct vhost_user_ops g_vu_blk_ops = {
+    .type = VHOST_USER_BLK,
+
+    .append_opts = append_vhost_blk_opts,
+    .driver_init = vu_blk_driver_init,
+
+    .set_features = vu_blk_set_features,
+    .get_protocol_features = vu_blk_get_protocol_features,
+    .get_config = vu_blk_get_config,
+};
+
 static void register_vhost_user_test(void)
 {
     QOSGraphTestOptions opts = {
@@ -1015,5 +1138,16 @@ static void register_vhost_user_test(void)
     qos_add_test("vhost-user/multiqueue",
                  "virtio-net",
                  test_multiqueue, &opts);
+    opts.edge.extra_device_opts = NULL;
+
+    /* vhost-user-blk tests */
+    opts.arg = &g_vu_blk_ops;
+    opts.before = vhost_user_test_setup_reconnect;
+    qos_add_test("reconnect", "vhost-user-blk",
+                 test_reconnect, &opts);
+
+    opts.before = vhost_user_test_setup_memfd;
+    qos_add_test("migrate", "vhost-user-blk",
+                 test_migrate, &opts);
 }
 libqos_init(register_vhost_user_test);
-- 
MST



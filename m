Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA7C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE42123718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="TqvZ2ijj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42123718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVgP-0005HL-Tr
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <265f5d9a0fb10ce5e782455839d1baf678dbac48@lizzy.crudebyte.com>)
 id 1kMVeL-0003bd-5z
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:19:29 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <265f5d9a0fb10ce5e782455839d1baf678dbac48@lizzy.crudebyte.com>)
 id 1kMVeJ-0006o8-Dn
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=JWoDBnO+yolHB04O/0j0yUtvrSSuKrhkfcd+BHmO3/0=; b=TqvZ2
 ijjVaAt1vRlgfAVeuwU2FXL/fHor/PiL3MtR5iDZBvbtnkxmWKXm6F071mNhfOxvWoBl4GfkK/7qs
 PRgU/0YnnCqw+3KgLbn0dQQhDaVqbTdUePB34qYgq0EXwXnXs4htFapSrPd2dqrXjZNxHXYCsQAB/
 v8meCysIxYEu+fjbKn4EpLkQ1GPVTqjKOlVbnFfEq0eWlAJujJHR9ET0pcUjrC+JvqvoZrbky3yGk
 nqIC9o5P9GHABYCFkugBDqZwaJS2DIEfJH233oGR2bqSog8LvR3v/912AYmNriW+nHm+E7gv9OkDu
 6dvnnFClSjI9RIa/RzMIVlelKkOoA==;
Message-Id: <265f5d9a0fb10ce5e782455839d1baf678dbac48.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:40:34 +0200
Subject: [PATCH 08/12] tests/9pfs: refactor test names and test devices
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=265f5d9a0fb10ce5e782455839d1baf678dbac48@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Rename all 9pfs tests and devices they create for running their tests
from 'virtio*' -> 'virtio*-synth'.

In order for the tests still to work after this renaming, use the
newly added function qos_node_create_driver_named() instead of
qos_node_create_driver(). That new function allows to assign a name
to a device that differs from the actual QEMU driver it's using.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 29 ++++++++++++++-------------
 tests/qtest/virtio-9p-test.c   | 36 +++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 9f099737f9..1bda5403ff 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -62,10 +62,10 @@ static void virtio_9p_device_start_hw(QOSGraphObject *obj)
 static void *virtio_9p_get_driver(QVirtio9P *v_9p,
                                          const char *interface)
 {
-    if (!g_strcmp0(interface, "virtio-9p")) {
+    if (!g_strcmp0(interface, "virtio-9p-synth")) {
         return v_9p;
     }
-    if (!g_strcmp0(interface, "virtio")) {
+    if (!g_strcmp0(interface, "virtio-synth")) {
         return v_9p->vdev;
     }
 
@@ -159,22 +159,23 @@ static void virtio_9p_register_nodes(void)
         .before_cmd_line = "-fsdev synth,id=fsdev0",
     };
 
-    /* virtio-9p-device */
+    /* virtio-9p-device-synth */
     opts.extra_device_opts = str_simple,
-    qos_node_create_driver("virtio-9p-device", virtio_9p_device_create);
-    qos_node_consumes("virtio-9p-device", "virtio-bus", &opts);
-    qos_node_produces("virtio-9p-device", "virtio");
-    qos_node_produces("virtio-9p-device", "virtio-9p");
+    qos_node_create_driver_named("virtio-9p-device-synth", "virtio-9p-device",
+                                 virtio_9p_device_create);
+    qos_node_consumes("virtio-9p-device-synth", "virtio-bus", &opts);
+    qos_node_produces("virtio-9p-device-synth", "virtio-synth");
+    qos_node_produces("virtio-9p-device-synth", "virtio-9p-synth");
 
-    /* virtio-9p-pci */
+    /* virtio-9p-pci-synth */
     opts.extra_device_opts = str_addr;
     add_qpci_address(&opts, &addr);
-    qos_node_create_driver("virtio-9p-pci", virtio_9p_pci_create);
-    qos_node_consumes("virtio-9p-pci", "pci-bus", &opts);
-    qos_node_produces("virtio-9p-pci", "pci-device");
-    qos_node_produces("virtio-9p-pci", "virtio");
-    qos_node_produces("virtio-9p-pci", "virtio-9p");
-
+    qos_node_create_driver_named("virtio-9p-pci-synth", "virtio-9p-pci",
+                                 virtio_9p_pci_create);
+    qos_node_consumes("virtio-9p-pci-synth", "pci-bus", &opts);
+    qos_node_produces("virtio-9p-pci-synth", "pci-device");
+    qos_node_produces("virtio-9p-pci-synth", "virtio-synth");
+    qos_node_produces("virtio-9p-pci-synth", "virtio-9p-synth");
 }
 
 libqos_init(virtio_9p_register_nodes);
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f7505396f3..d46d675309 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -897,27 +897,27 @@ static void fs_readdir_split_512(void *obj, void *data,
 
 static void register_virtio_9p_test(void)
 {
-    qos_add_test("config", "virtio-9p", pci_config, NULL);
-    qos_add_test("fs/version/basic", "virtio-9p", fs_version, NULL);
-    qos_add_test("fs/attach/basic", "virtio-9p", fs_attach, NULL);
-    qos_add_test("fs/walk/basic", "virtio-9p", fs_walk, NULL);
-    qos_add_test("fs/walk/no_slash", "virtio-9p", fs_walk_no_slash,
+    /* selects the 9pfs 'synth' filesystem driver for the respective test */
+    const char *synth_driver = "virtio-9p-synth";
+
+    qos_add_test("config", synth_driver, pci_config, NULL);
+    qos_add_test("fs/version/basic", synth_driver, fs_version, NULL);
+    qos_add_test("fs/attach/basic", synth_driver, fs_attach, NULL);
+    qos_add_test("fs/walk/basic", synth_driver, fs_walk, NULL);
+    qos_add_test("fs/walk/no_slash", synth_driver, fs_walk_no_slash, NULL);
+    qos_add_test("fs/walk/dotdot_from_root", synth_driver, fs_walk_dotdot,
                  NULL);
-    qos_add_test("fs/walk/dotdot_from_root", "virtio-9p",
-                 fs_walk_dotdot, NULL);
-    qos_add_test("fs/lopen/basic", "virtio-9p", fs_lopen, NULL);
-    qos_add_test("fs/write/basic", "virtio-9p", fs_write, NULL);
-    qos_add_test("fs/flush/success", "virtio-9p", fs_flush_success,
+    qos_add_test("fs/lopen/basic", synth_driver, fs_lopen, NULL);
+    qos_add_test("fs/write/basic", synth_driver, fs_write, NULL);
+    qos_add_test("fs/flush/success", synth_driver, fs_flush_success, NULL);
+    qos_add_test("fs/flush/ignored", synth_driver, fs_flush_ignored, NULL);
+    qos_add_test("fs/readdir/basic", synth_driver, fs_readdir, NULL);
+    qos_add_test("fs/readdir/split_512", synth_driver, fs_readdir_split_512,
                  NULL);
-    qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
+    qos_add_test("fs/readdir/split_256", synth_driver, fs_readdir_split_256,
+                 NULL);
+    qos_add_test("fs/readdir/split_128", synth_driver, fs_readdir_split_128,
                  NULL);
-    qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
-    qos_add_test("fs/readdir/split_512", "virtio-9p",
-                 fs_readdir_split_512, NULL);
-    qos_add_test("fs/readdir/split_256", "virtio-9p",
-                 fs_readdir_split_256, NULL);
-    qos_add_test("fs/readdir/split_128", "virtio-9p",
-                 fs_readdir_split_128, NULL);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1



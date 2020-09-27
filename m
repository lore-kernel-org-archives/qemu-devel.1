Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58134C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58FE23718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AE/L+fKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58FE23718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVdJ-0002JU-Rr
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44025a54367bc69073295b48b9b8b21bb419ca50@lizzy.crudebyte.com>)
 id 1kMVcJ-00016A-Hc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:17:23 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44025a54367bc69073295b48b9b8b21bb419ca50@lizzy.crudebyte.com>)
 id 1kMVcH-0006fs-KM
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=snCJV9LSnmMnp5dULhDa2f2+dgymsNHca6AQx2Ncx10=; b=AE/L+
 fKHoIWqWN8Mvl6tVZW08HTy/AQbzHNQXLG2XJQdBd4i2v1Hka82W1GhYblVyVw14CEiOe+BSdwI1b
 sRNZdY+lJTi7o5wCcih3mSEXHkfXfBnqnAOQAH8AELv7lE5/YRnWHvigWQ8hOTZ8sLptkR8XNKoY1
 yAXFRGQeeLafI4SQqpKZwNTg7f1IuC7tBj5Wikq28quf3kzf55WJzogC83C0C9VlYRYyuZ7QZJXR9
 039e0PpfKR1aik8GgIxvp+LGTa884PIPIIVZ76Yl97SNqhgI6ypDbaEt796yN6ruGSJ2YyggQdJyn
 fTvlz2EVMDJYaJDKPetwNNa8gQXdQ==;
Message-Id: <44025a54367bc69073295b48b9b8b21bb419ca50.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:40:47 +0200
Subject: [PATCH 09/12] tests/9pfs: introduce local tests
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=44025a54367bc69073295b48b9b8b21bb419ca50@lizzy.crudebyte.com;
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

This patch introduces 9pfs test cases using the 9pfs 'local'
filesystem driver which reads/writes/creates/deletes real files
and directories.

In this initial version, there are only 2 local tests which actually
only check if the 9pfs 'local' device was created successfully.

Before the 9pfs 'local' tests are run, a test directory 'qtest-9p-local'
is created (with world rwx permissions) under the current working
directory. At this point that test directory is not auto deleted yet.

A different PCI address, fsdev id and mount tag is used for the 'local'
9pfs device. This is not really necessary right now, but might be useful
to avoid potential colissions in future.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 101 ++++++++++++++++++++++++++++++++-
 tests/qtest/libqos/virtio-9p.h |   1 +
 tests/qtest/virtio-9p-test.c   |  12 +++-
 3 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 1bda5403ff..400f4b0113 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -24,6 +24,61 @@
 #include "qgraph.h"
 
 static QGuestAllocator *alloc;
+static char *local_test_path;
+
+/* Concatenates the passed 2 pathes. Returned result must be freed. */
+static char *concat_path(const char* a, const char* b)
+{
+    const int len = strlen(a) + strlen("/") + strlen(b);
+    char *path = g_malloc0(len + 1);
+    snprintf(path, len + 1, "%s/%s", a, b);
+    g_assert(strlen(path) == len);
+    return path;
+}
+
+/*
+ * Lazy sprintf() implementation which auto allocates buffer. Returned result
+ * must be freed.
+ */
+static char *strpr(const char* format, ...)
+{
+    va_list argp;
+
+    va_start(argp, format);
+    const int sz = vsnprintf(NULL, 0, format, argp) + 1;
+    va_end(argp);
+
+    g_assert(sz > 0);
+    char *s = g_malloc0(sz);
+
+    va_start(argp, format);
+    const int len = vsnprintf(s, sz, format, argp);
+    va_end(argp);
+
+    g_assert(len + 1 == sz);
+    return s;
+}
+
+static void init_local_test_path(void)
+{
+    char *pwd = get_current_dir_name();
+    local_test_path = concat_path(pwd, "qtest-9p-local");
+    free(pwd);
+}
+
+/* Creates the directory for the 9pfs 'local' filesystem driver to access. */
+static void create_local_test_dir(void)
+{
+    struct stat st;
+
+    g_assert(local_test_path != NULL);
+    mkdir(local_test_path, 0777);
+
+    /* ensure test directory exists now ... */
+    g_assert(stat(local_test_path, &st) == 0);
+    /* ... and is actually a directory */
+    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
+}
 
 static void virtio_9p_cleanup(QVirtio9P *interface)
 {
@@ -62,10 +117,14 @@ static void virtio_9p_device_start_hw(QOSGraphObject *obj)
 static void *virtio_9p_get_driver(QVirtio9P *v_9p,
                                          const char *interface)
 {
-    if (!g_strcmp0(interface, "virtio-9p-synth")) {
+    if (!g_strcmp0(interface, "virtio-9p-synth") ||
+        !g_strcmp0(interface, "virtio-9p-local"))
+    {
         return v_9p;
     }
-    if (!g_strcmp0(interface, "virtio-synth")) {
+    if (!g_strcmp0(interface, "virtio-synth") ||
+        !g_strcmp0(interface, "virtio-local"))
+    {
         return v_9p->vdev;
     }
 
@@ -148,6 +207,12 @@ static void *virtio_9p_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
 
 static void virtio_9p_register_nodes(void)
 {
+    /* make sure test dir for the 'local' tests exists and is clean */
+    init_local_test_path();
+    create_local_test_dir();
+
+    /* 9pfs device using the 'synth' fs driver */
+
     const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG_SYNTH;
     const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG_SYNTH;
 
@@ -176,6 +241,38 @@ static void virtio_9p_register_nodes(void)
     qos_node_produces("virtio-9p-pci-synth", "pci-device");
     qos_node_produces("virtio-9p-pci-synth", "virtio-synth");
     qos_node_produces("virtio-9p-pci-synth", "virtio-9p-synth");
+
+
+    /* 9pfs device using the 'local' fs driver */
+
+    const char *local_str_simple = "fsdev=fsdev1,mount_tag=" MOUNT_TAG_LOCAL;
+    const char *local_str_addr = "fsdev=fsdev1,addr=04.1,mount_tag="
+                                 MOUNT_TAG_LOCAL;
+
+    addr.devfn = QPCI_DEVFN(4, 1),
+
+    opts.before_cmd_line = strpr(
+        "-fsdev local,id=fsdev1,path='%s',security_model=mapped-xattr",
+        local_test_path
+    );
+
+    /* virtio-9p-device-local */
+    opts.extra_device_opts = local_str_simple,
+    qos_node_create_driver_named("virtio-9p-device-local", "virtio-9p-device",
+                                 virtio_9p_device_create);
+    qos_node_consumes("virtio-9p-device-local", "virtio-bus", &opts);
+    qos_node_produces("virtio-9p-device-local", "virtio-local");
+    qos_node_produces("virtio-9p-device-local", "virtio-9p-local");
+
+    /* virtio-9p-pci-local */
+    opts.extra_device_opts = local_str_addr;
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver_named("virtio-9p-pci-local", "virtio-9p-pci",
+                                 virtio_9p_pci_create);
+    qos_node_consumes("virtio-9p-pci-local", "pci-bus", &opts);
+    qos_node_produces("virtio-9p-pci-local", "pci-device");
+    qos_node_produces("virtio-9p-pci-local", "virtio-local");
+    qos_node_produces("virtio-9p-pci-local", "virtio-9p-local");
 }
 
 libqos_init(virtio_9p_register_nodes);
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index d9a815083f..20d1fc6270 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -28,6 +28,7 @@ typedef struct QVirtio9PPCI QVirtio9PPCI;
 typedef struct QVirtio9PDevice QVirtio9PDevice;
 
 #define MOUNT_TAG_SYNTH "qtest-synth"
+#define MOUNT_TAG_LOCAL "qtest-local"
 
 struct QVirtio9P {
     QVirtioDevice *vdev;
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index d46d675309..88451f255f 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -26,13 +26,15 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
     char *tag;
     int i;
 
-    g_assert_cmpint(tag_len, ==, strlen(MOUNT_TAG_SYNTH));
+    g_assert(tag_len == strlen(MOUNT_TAG_SYNTH) ||
+             tag_len == strlen(MOUNT_TAG_LOCAL));
 
     tag = g_malloc(tag_len);
     for (i = 0; i < tag_len; i++) {
         tag[i] = qvirtio_config_readb(v9p->vdev, i + 2);
     }
-    g_assert_cmpmem(tag, tag_len, MOUNT_TAG_SYNTH, tag_len);
+    g_assert(strncmp(tag, MOUNT_TAG_SYNTH, tag_len) == 0 ||
+             strncmp(tag, MOUNT_TAG_LOCAL, tag_len) == 0);
     g_free(tag);
 }
 
@@ -918,6 +920,12 @@ static void register_virtio_9p_test(void)
                  NULL);
     qos_add_test("fs/readdir/split_128", synth_driver, fs_readdir_split_128,
                  NULL);
+
+
+    /* selects the 9pfs 'local' filesystem driver for the respective test */
+    const char *local_driver = "virtio-9p-local";
+
+    qos_add_test("config", local_driver, pci_config, NULL);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1



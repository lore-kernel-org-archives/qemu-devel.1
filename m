Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E24C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7319207F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7319207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JnJ-0001nS-68
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0Jli-0008Jo-Uf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:11:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4161 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0Jlg-0007oW-Le
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:11:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CB9D0ED6E4550D39A4F2;
 Tue, 28 Jul 2020 15:11:17 +0800 (CST)
Received: from localhost (10.174.149.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 15:11:10 +0800
From: Hogan Wang <hogan.wang@huawei.com>
To: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 3/3] qemu-options: introduce parse_virtfs
Date: Tue, 28 Jul 2020 15:11:04 +0800
Message-ID: <20200728071104.3835-3-hogan.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728071104.3835-1-hogan.wang@huawei.com>
References: <20200728071104.3835-1-hogan.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.56]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=hogan.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 03:11:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com, hogan.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: w00506750 <hogan.wang@huawei.com>

introduce parse_virtfs to parse virtfs options.

Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
---
 qemu-options.hx |   2 +-
 softmmu/vl.c    | 158 +++++++++++++++++++++++++-----------------------
 2 files changed, 82 insertions(+), 78 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index cf811c552e..e6320e18f2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1542,7 +1542,7 @@ DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
     "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
     "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
-    QEMU_ARCH_ALL)
+    QEMU_ARCH_ALL, parse_virtfs)
 
 SRST
 ``-virtfs local,path=path,mount_tag=mount_tag ,security_model=security_model[,writeout=writeout][,readonly] [,fmode=fmode][,dmode=dmode][,multidevs=multidevs]``
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 6a0a49c7c7..a868acd37c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1737,6 +1737,87 @@ static int parse_net_client(const QEMUOption *popt, const char* optarg)
     return 0;
 }
 
+static int parse_virtfs(const QEMUOption *popt, const char* optarg)
+{
+    QemuOptsList *olist;
+    QemuOpts *fsdev;
+    QemuOpts *device;
+    QemuOpts *opts;
+    const char *writeout, *sock_fd, *socket, *path, *security_model,
+               *multidevs;
+
+    olist = qemu_find_opts("virtfs");
+    if (!olist) {
+        error_report("virtfs support is disabled");
+        exit(1);
+    }
+    opts = qemu_opts_parse_noisily(olist, optarg, true);
+    if (!opts) {
+        exit(1);
+    }
+
+    if (qemu_opt_get(opts, "fsdriver") == NULL ||
+        qemu_opt_get(opts, "mount_tag") == NULL) {
+        error_report("Usage: -virtfs fsdriver,mount_tag=tag");
+        exit(1);
+    }
+    fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
+                             qemu_opts_id(opts) ?:
+                             qemu_opt_get(opts, "mount_tag"),
+                             1, NULL);
+    if (!fsdev) {
+        error_report("duplicate or invalid fsdev id: %s",
+                     qemu_opt_get(opts, "mount_tag"));
+        exit(1);
+    }
+
+    writeout = qemu_opt_get(opts, "writeout");
+    if (writeout) {
+#ifdef CONFIG_SYNC_FILE_RANGE
+        qemu_opt_set(fsdev, "writeout", writeout, &error_abort);
+#else
+        error_report("writeout=immediate not supported "
+                     "on this platform");
+        exit(1);
+#endif
+    }
+    qemu_opt_set(fsdev, "fsdriver",
+                 qemu_opt_get(opts, "fsdriver"), &error_abort);
+    path = qemu_opt_get(opts, "path");
+    if (path) {
+        qemu_opt_set(fsdev, "path", path, &error_abort);
+    }
+    security_model = qemu_opt_get(opts, "security_model");
+    if (security_model) {
+        qemu_opt_set(fsdev, "security_model", security_model,
+                     &error_abort);
+    }
+    socket = qemu_opt_get(opts, "socket");
+    if (socket) {
+        qemu_opt_set(fsdev, "socket", socket, &error_abort);
+    }
+    sock_fd = qemu_opt_get(opts, "sock_fd");
+    if (sock_fd) {
+        qemu_opt_set(fsdev, "sock_fd", sock_fd, &error_abort);
+    }
+
+    qemu_opt_set_bool(fsdev, "readonly",
+                      qemu_opt_get_bool(opts, "readonly", 0),
+                      &error_abort);
+    multidevs = qemu_opt_get(opts, "multidevs");
+    if (multidevs) {
+        qemu_opt_set(fsdev, "multidevs", multidevs, &error_abort);
+    }
+    device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
+                              &error_abort);
+    qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
+    qemu_opt_set(device, "fsdev",
+                 qemu_opts_id(fsdev), &error_abort);
+    qemu_opt_set(device, "mount_tag",
+                 qemu_opt_get(opts, "mount_tag"), &error_abort);
+    return 0;
+}
+
 static const QEMUOption qemu_options[] = {
     { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
 #define QEMU_OPTIONS_GENERATE_OPTIONS
@@ -3293,83 +3374,6 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_virtfs: {
-                QemuOpts *fsdev;
-                QemuOpts *device;
-                const char *writeout, *sock_fd, *socket, *path, *security_model,
-                           *multidevs;
-
-                olist = qemu_find_opts("virtfs");
-                if (!olist) {
-                    error_report("virtfs support is disabled");
-                    exit(1);
-                }
-                opts = qemu_opts_parse_noisily(olist, optarg, true);
-                if (!opts) {
-                    exit(1);
-                }
-
-                if (qemu_opt_get(opts, "fsdriver") == NULL ||
-                    qemu_opt_get(opts, "mount_tag") == NULL) {
-                    error_report("Usage: -virtfs fsdriver,mount_tag=tag");
-                    exit(1);
-                }
-                fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
-                                         qemu_opts_id(opts) ?:
-                                         qemu_opt_get(opts, "mount_tag"),
-                                         1, NULL);
-                if (!fsdev) {
-                    error_report("duplicate or invalid fsdev id: %s",
-                                 qemu_opt_get(opts, "mount_tag"));
-                    exit(1);
-                }
-
-                writeout = qemu_opt_get(opts, "writeout");
-                if (writeout) {
-#ifdef CONFIG_SYNC_FILE_RANGE
-                    qemu_opt_set(fsdev, "writeout", writeout, &error_abort);
-#else
-                    error_report("writeout=immediate not supported "
-                                 "on this platform");
-                    exit(1);
-#endif
-                }
-                qemu_opt_set(fsdev, "fsdriver",
-                             qemu_opt_get(opts, "fsdriver"), &error_abort);
-                path = qemu_opt_get(opts, "path");
-                if (path) {
-                    qemu_opt_set(fsdev, "path", path, &error_abort);
-                }
-                security_model = qemu_opt_get(opts, "security_model");
-                if (security_model) {
-                    qemu_opt_set(fsdev, "security_model", security_model,
-                                 &error_abort);
-                }
-                socket = qemu_opt_get(opts, "socket");
-                if (socket) {
-                    qemu_opt_set(fsdev, "socket", socket, &error_abort);
-                }
-                sock_fd = qemu_opt_get(opts, "sock_fd");
-                if (sock_fd) {
-                    qemu_opt_set(fsdev, "sock_fd", sock_fd, &error_abort);
-                }
-
-                qemu_opt_set_bool(fsdev, "readonly",
-                                  qemu_opt_get_bool(opts, "readonly", 0),
-                                  &error_abort);
-                multidevs = qemu_opt_get(opts, "multidevs");
-                if (multidevs) {
-                    qemu_opt_set(fsdev, "multidevs", multidevs, &error_abort);
-                }
-                device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
-                                          &error_abort);
-                qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-                qemu_opt_set(device, "fsdev",
-                             qemu_opts_id(fsdev), &error_abort);
-                qemu_opt_set(device, "mount_tag",
-                             qemu_opt_get(opts, "mount_tag"), &error_abort);
-                break;
-            }
             case QEMU_OPTION_serial:
                 add_device_config(DEV_SERIAL, optarg);
                 default_serial = 0;
-- 
2.27.0




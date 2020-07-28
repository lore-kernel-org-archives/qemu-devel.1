Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A60207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A60207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JoP-0002yb-86
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0Jlk-0008Ls-GN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:11:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4162 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1k0Jli-0007oa-Dt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:11:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CB998ADB37732AA8688D;
 Tue, 28 Jul 2020 15:11:18 +0800 (CST)
Received: from localhost (10.174.149.56) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 15:11:08 +0800
From: Hogan Wang <hogan.wang@huawei.com>
To: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/3] qemu-options: introduce parse_net_client
Date: Tue, 28 Jul 2020 15:11:03 +0800
Message-ID: <20200728071104.3835-2-hogan.wang@huawei.com>
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

introduce parse_net_client to parse netdev/nic/net clients.

Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
---
 include/net/net.h |  1 -
 net/net.c         |  9 ---------
 qemu-options.hx   |  8 +++++---
 softmmu/vl.c      | 30 ++++++++++++------------------
 4 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index e7ef42d62b..d41dad5a96 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -198,7 +198,6 @@ extern NICInfo nd_table[MAX_NICS];
 extern const char *host_net_devices[];
 
 /* from net.c */
-int net_client_parse(QemuOptsList *opts_list, const char *str);
 int net_init_clients(Error **errp);
 void net_check_clients(void);
 void net_cleanup(void);
diff --git a/net/net.c b/net/net.c
index bbaedb3c7a..7380ab0123 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1507,15 +1507,6 @@ int net_init_clients(Error **errp)
     return 0;
 }
 
-int net_client_parse(QemuOptsList *opts_list, const char *optarg)
-{
-    if (!qemu_opts_parse_noisily(opts_list, optarg, true)) {
-        return -1;
-    }
-
-    return 0;
-}
-
 /* From FreeBSD */
 /* XXX: optimize */
 uint32_t net_crc32(const uint8_t *p, int len)
diff --git a/qemu-options.hx b/qemu-options.hx
index 988fa4026b..cf811c552e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2433,7 +2433,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                configure a vhost-vdpa network,Establish a vhost-vdpa netdev\n"
 #endif
     "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
-    "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
+    "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL, \
+    parse_net_client)
 DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "-nic [tap|bridge|"
 #ifdef CONFIG_SLIRP
@@ -2456,7 +2457,7 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
     "                macaddr) and connect it to the given host network backend\n"
     "-nic none       use it alone to have zero network devices (the default is to\n"
     "                provided a 'user' network connection)\n",
-    QEMU_ARCH_ALL)
+    QEMU_ARCH_ALL, parse_net_client)
 DEF("net", HAS_ARG, QEMU_OPTION_net,
     "-net nic[,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
     "                configure or create an on-board (or machine default) NIC and\n"
@@ -2475,7 +2476,8 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
 #endif
     "socket][,option][,option][,...]\n"
     "                old way to initialize a host network interface\n"
-    "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
+    "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL, \
+    parse_net_client)
 SRST
 ``-nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
     This option is a shortcut for configuring both the on-board
diff --git a/softmmu/vl.c b/softmmu/vl.c
index edb24fd3f7..6a0a49c7c7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1725,6 +1725,18 @@ static int parse_linux_boot(const QEMUOption *popt, const char* optarg)
     return 0;
 }
 
+static int parse_net_client(const QEMUOption *popt, const char* optarg)
+{
+    QemuOptsList *opts;
+
+    default_net = 0;
+    opts = qemu_find_opts(popt->name);
+    if (!qemu_opts_parse_noisily(opts, optarg, true)) {
+        return -1;
+    }
+    return 0;
+}
+
 static const QEMUOption qemu_options[] = {
     { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
 #define QEMU_OPTIONS_GENERATE_OPTIONS
@@ -3110,24 +3122,6 @@ void qemu_init(int argc, char **argv, char **envp)
             case QEMU_OPTION_no_fd_bootchk:
                 fd_bootchk = 0;
                 break;
-            case QEMU_OPTION_netdev:
-                default_net = 0;
-                if (net_client_parse(qemu_find_opts("netdev"), optarg) == -1) {
-                    exit(1);
-                }
-                break;
-            case QEMU_OPTION_nic:
-                default_net = 0;
-                if (net_client_parse(qemu_find_opts("nic"), optarg) == -1) {
-                    exit(1);
-                }
-                break;
-            case QEMU_OPTION_net:
-                default_net = 0;
-                if (net_client_parse(qemu_find_opts("net"), optarg) == -1) {
-                    exit(1);
-                }
-                break;
 #ifdef CONFIG_LIBISCSI
             case QEMU_OPTION_iscsi:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("iscsi"),
-- 
2.27.0




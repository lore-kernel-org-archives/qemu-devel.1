Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B953C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FD7207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GOYvy4AX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h2II+FjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FD7207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl2EC-0004KJ-8D
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 23:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Br-0000Wj-HY; Mon, 15 Jun 2020 23:23:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bo-0007be-Vl; Mon, 15 Jun 2020 23:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592277788; x=1623813788;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=y/kHILzyxWYJxo2eU9AxUI9BvDDA0qKd2u2xd6QkxGo=;
 b=GOYvy4AXUP1rYIVCmG7KFsr4eGwMkwR9+2bLJSYnYNGMDW1eZJ3bqI6n
 yBBvhtee/ZJNsQRXrHmGDn6TmaNIRlZA4SGnPqZ9JoxnFFvr1uGZtcUc5
 KF2hk/KHrYO9GKs6k2ciffELjpHU6m70founW1dQ4fIl7DKi+20YH3WjF
 e+zP76qREMiKIRyKdFCKF/ne+JdydQsR0tNVnhP9zur8md8X/IZYZb8Hm
 DxrFqcHs0MNeTzzh/RtNmiHfF+xn/z6IXIplQMgAcihceVphOB1y4209c
 glPDyPLrJzFvFcgpmX6N1mcMpyLgsz+gs/yZPYAcWy2RXuyOTbl4lsCB1 A==;
IronPort-SDR: psfjA4/ldvKFUQZZHuEhdYPijnt9ssuXHL5GA9QvCKtQPaUyDGlpLWIsbJilqRuwuYvxrYbuoA
 /Za+dlaNFQboJ8Q3Y2jsLJNK4trTn+tBYFRTDocIuEHpwaBmv0aCOdXWs91/wr3ovwgmr8npsh
 gaD+m5tsGiEEhNndJ19n1tyzWRrHH+QB4Zb6YzBVFjha5kYHpym0gC6hOAshBBK3THynBEv71b
 0+bGsNHFus1YJjmUUhr98t//e4AaxFnH7eucbHvtB4J9ADS9pcKlm5GtBnbGIyE2VsK6AnKs1j
 y2A=
X-IronPort-AV: E=Sophos;i="5.73,517,1583164800"; d="scan'208";a="140088533"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 11:23:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yaab4sTuq0b0AUDZ28lXazZpiq1TCwGdYbvleaiI4rQZfZCSqu1evvs8rFKXL/rUiVGjRE9cAlSwE2s0hTqsFRtv+5WVQ3uPQq1xc2jARPizzqk0pGRQcU30WgTJcB1m20bB+p+KKw8/h56aSONGlSNYsvjQH4vX3jECEP8T1a2300xHfcKC8cVfnSs7dNAGnczBRJzmLvbXYNJY5fMaK3Ji1zszfPICujyxXZZs9vV4waOgywx5+WT62fFa2YGLHqeLo8OCA6+/1VN0mu5foOWK6VuJAxcE9AxO7dk7lDXRyS9L/TkbQGUgJPrSL89yNAw2mFdKDn8MhWsaRtL0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxSFodW3VGc14NagqnOVnr5wbkK5cBAVXCAg1VdZgI4=;
 b=diYJm79o+cnNgQEU3SeDjpnGGlY0OBn2+0wZ1sA6eqEBM2Xcywn07cPV74jvuVyGNgbHQOXYui5QOeMZhcxmXXadHwawwZCfwOJBBsjr9R14dxeUd9OWGgPnF/wiAJvZAxRj8l2OQZXywnShNxMXFT5tRhIfx5rB1SN0VIJYmKeaYmwQWxgMRAmSOVcl8JAxElvoXe/yLNHi3f4N21eKvW8wdtdRkGn58f5Cd91XjLT9JALoZOdXO7Pfn35vl4iiflTGJRD7XPns8PQFj2z/IFCHJEYsuwfMZHc9Inu1HefbPhu6qi6HyDjc13V9xQj2buKqAeX8IyXS3MGGMia4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxSFodW3VGc14NagqnOVnr5wbkK5cBAVXCAg1VdZgI4=;
 b=h2II+FjOaGxtSOtwbK3esjZJqHgLjg8y1bRSmoSeMrmLSNCTd+6nwur2xup6l/YXBLs9D/NX7seMzCVvpKlV8SNNp7dOL6ps4hfLhV5wfi/gEIFYO6MjzAnYqOfeBwic0y5RwwpIKqGnM2bTeVsZe/4tx/Jyy1aHv6wRczpuOJs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4123.namprd04.prod.outlook.com (2603:10b6:5:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 03:23:05 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:23:05 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v6 3/5] hw/riscv: Add helpers for RISC-V multi-socket NUMA
 machines
Date: Tue, 16 Jun 2020 08:52:27 +0530
Message-Id: <20200616032229.766089-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032229.766089-1-anup.patel@wdc.com>
References: <20200616032229.766089-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.201.92) by
 MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 03:23:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.171.201.92]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d990bc4e-3b15-4e50-de14-08d811a49583
X-MS-TrafficTypeDiagnostic: DM6PR04MB4123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB41232ECC563B83366F9B6E828D9D0@DM6PR04MB4123.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnCcG1Wr4nxXTzrHuEew3ztEJ5rqtq7qvIyEv82uzL+LLAveYWgkOGoInxl259YhTPjOyAnlOtevaTs1jrl1GeM83xOes6hVrdyW6/C2T4eVMNgW04mQigqwhkk49viBi5G+plJlraDlYi9WbUqEFillp2qG4DF9cyCH77RxQEThby8FoAlK/1fqHehu6dyR4dGj369yvb6KU5l+ICGyK6XXyF/dVfNSDPyW5GF2K7eG/GlGoBVryxTa0HTK0lwkgmfn2ErycKy6ekdxwdxfo8H4TBgvoNGM9+zXTRvH12qHPyg/UFrNtYzMi0GkyDh4/wftWfOwSxGTKg0JDSs1FatuT9etNUI1dB+msl/hCS+E5KKkMBqC2aeD9icnEKLR1n9wtjiHGBio25zYg4v6ow7y4jy7kz12dZ6RBq5UDMXhQjL5Gryg/gXnCPAsOUvCCnu0+I0NxYnwYFprP/UfnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66946007)(2616005)(66476007)(66556008)(8936002)(956004)(2906002)(316002)(54906003)(478600001)(6666004)(186003)(44832011)(55016002)(36756003)(7696005)(52116002)(83380400001)(26005)(8676002)(4326008)(86362001)(30864003)(16526019)(1076003)(8886007)(110136005)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ST5Tt6OLzYJIHQpQNRwQkU5MSGklXkithBF3ljPudVnbjTLoqiuJ6nXjDMqVjUJmzvpsKQ+/CSYx/v5vynWlzg5gLK8VWNCz0e+KxfSJ0jpcFAHHD6zd+A4xUA8Zi+D9NQgSRfMN1kR6OJvXav3OsQuOklCEs/oeFmJVz9aKaApEACAZar9p0u9GeRzzJBY3xrlyfbWpkcshVjNsiefwDZ/z4WfFEEVcBhhszFRzNrleOxBD95yx1bIw4n5+yt9RQRVxKqgAeJPHFJMqgBWXzzC9yjLfqkugq8VmFrykyN5g3GCsMl3KBX4n7D2ODGf7AbACmDPRiye6ZafjRF1B+keguwxu3/vGv1BMWrSoKOGtt/PAeqM7lOQH53Iw4TNcWQVWAv4mDdvbMERCjs8tpQ5/HlHJxRwbbBwcH/IvvnSzCyEoJWYVuk9JNEEnG7Vmi9uH1fuOKeCksZjR4HJUlGDHrjwdsY+W406Q66GqqN8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d990bc4e-3b15-4e50-de14-08d811a49583
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 03:23:05.6029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm9Tqd+YA7oJLww+VK4B+/FSXX2gY1kjWvcQYqhXB725Kj/LyInbQF9Y8VGkBztsZZZT0QkcgbEZQQQrHPd7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4123
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4298fe783=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 23:23:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We add common helper routines which can be shared by RISC-V
multi-socket NUMA machines.

We have two types of helpers:
1. riscv_socket_xyz() - These helper assist managing multiple
   sockets irrespective whether QEMU NUMA is enabled/disabled
2. riscv_numa_xyz() - These helpers assist in providing
   necessary QEMU machine callbacks for QEMU NUMA emulation

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 hw/riscv/Makefile.objs  |   1 +
 hw/riscv/numa.c         | 242 ++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/numa.h | 113 +++++++++++++++++++
 3 files changed, 356 insertions(+)
 create mode 100644 hw/riscv/numa.c
 create mode 100644 include/hw/riscv/numa.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index fc3c6dd7c8..4483e61879 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -1,4 +1,5 @@
 obj-y += boot.o
+obj-y += numa.o
 obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
new file mode 100644
index 0000000000..4f92307102
--- /dev/null
+++ b/hw/riscv/numa.c
@@ -0,0 +1,242 @@
+/*
+ * QEMU RISC-V NUMA Helper
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/numa.h"
+#include "sysemu/device_tree.h"
+
+static bool numa_enabled(const MachineState *ms)
+{
+    return (ms->numa_state && ms->numa_state->num_nodes) ? true : false;
+}
+
+int riscv_socket_count(const MachineState *ms)
+{
+    return (numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
+}
+
+int riscv_socket_first_hartid(const MachineState *ms, int socket_id)
+{
+    int i, first_hartid = ms->smp.cpus;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? 0 : -1;
+    }
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
+            continue;
+        }
+        if (i < first_hartid) {
+            first_hartid = i;
+        }
+    }
+
+    return (first_hartid < ms->smp.cpus) ? first_hartid : -1;
+}
+
+int riscv_socket_last_hartid(const MachineState *ms, int socket_id)
+{
+    int i, last_hartid = -1;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? ms->smp.cpus - 1 : -1;
+    }
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
+            continue;
+        }
+        if (i > last_hartid) {
+            last_hartid = i;
+        }
+    }
+
+    return (last_hartid < ms->smp.cpus) ? last_hartid : -1;
+}
+
+int riscv_socket_hart_count(const MachineState *ms, int socket_id)
+{
+    int first_hartid, last_hartid;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? ms->smp.cpus : -1;
+    }
+
+    first_hartid = riscv_socket_first_hartid(ms, socket_id);
+    if (first_hartid < 0) {
+        return -1;
+    }
+
+    last_hartid = riscv_socket_last_hartid(ms, socket_id);
+    if (last_hartid < 0) {
+        return -1;
+    }
+
+    if (first_hartid > last_hartid) {
+        return -1;
+    }
+
+    return last_hartid - first_hartid + 1;
+}
+
+bool riscv_socket_check_hartids(const MachineState *ms, int socket_id)
+{
+    int i, first_hartid, last_hartid;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? true : false;
+    }
+
+    first_hartid = riscv_socket_first_hartid(ms, socket_id);
+    if (first_hartid < 0) {
+        return false;
+    }
+
+    last_hartid = riscv_socket_last_hartid(ms, socket_id);
+    if (last_hartid < 0) {
+        return false;
+    }
+
+    for (i = first_hartid; i <= last_hartid; i++) {
+        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
+{
+    int i;
+    uint64_t mem_offset = 0;
+
+    if (!numa_enabled(ms)) {
+        return 0;
+    }
+
+    for (i = 0; i < ms->numa_state->num_nodes; i++) {
+        if (i == socket_id) {
+            break;
+        }
+        mem_offset += ms->numa_state->nodes[i].node_mem;
+    }
+
+    return (i == socket_id) ? mem_offset : 0;
+}
+
+uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
+{
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? ms->ram_size : 0;
+    }
+
+    return (socket_id < ms->numa_state->num_nodes) ?
+            ms->numa_state->nodes[socket_id].node_mem : 0;
+}
+
+void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
+                               const char *node_name, int socket_id)
+{
+    if (numa_enabled(ms)) {
+        qemu_fdt_setprop_cell(fdt, node_name, "numa-node-id", socket_id);
+    }
+}
+
+void riscv_socket_fdt_write_distance_matrix(const MachineState *ms, void *fdt)
+{
+    int i, j, idx;
+    uint32_t *dist_matrix, dist_matrix_size;
+
+    if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
+        dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
+        dist_matrix_size *= (3 * sizeof(uint32_t));
+        dist_matrix = g_malloc0(dist_matrix_size);
+
+        for (i = 0; i < riscv_socket_count(ms); i++) {
+            for (j = 0; j < riscv_socket_count(ms); j++) {
+                idx = (i * riscv_socket_count(ms) + j) * 3;
+                dist_matrix[idx + 0] = cpu_to_be32(i);
+                dist_matrix[idx + 1] = cpu_to_be32(j);
+                dist_matrix[idx + 2] =
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
+            }
+        }
+
+        qemu_fdt_add_subnode(fdt, "/distance-map");
+        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
+                                "numa-distance-map-v1");
+        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
+                         dist_matrix, dist_matrix_size);
+        g_free(dist_matrix);
+    }
+}
+
+CpuInstanceProperties
+riscv_numa_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    int64_t nidx = 0;
+
+    if (ms->numa_state->num_nodes) {
+        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
+        if (ms->numa_state->num_nodes <= nidx) {
+            nidx = ms->numa_state->num_nodes - 1;
+        }
+    }
+
+    return nidx;
+}
+
+const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms)
+{
+    int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].arch_id = n;
+        ms->possible_cpus->cpus[n].props.has_core_id = true;
+        ms->possible_cpus->cpus[n].props.core_id = n;
+    }
+
+    return ms->possible_cpus;
+}
diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
new file mode 100644
index 0000000000..fcce942cee
--- /dev/null
+++ b/include/hw/riscv/numa.h
@@ -0,0 +1,113 @@
+/*
+ * QEMU RISC-V NUMA Helper
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_NUMA_H
+#define RISCV_NUMA_H
+
+#include "hw/sysbus.h"
+#include "sysemu/numa.h"
+
+/**
+ * riscv_socket_count:
+ * @ms: pointer to machine state
+ *
+ * Returns: number of sockets for a numa system and 1 for a non-numa system
+ */
+int riscv_socket_count(const MachineState *ms);
+
+/**
+ * riscv_socket_first_hartid:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: first hartid for a valid socket and -1 for an invalid socket
+ */
+int riscv_socket_first_hartid(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_last_hartid:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: last hartid for a valid socket and -1 for an invalid socket
+ */
+int riscv_socket_last_hartid(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_hart_count:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: number of harts for a valid socket and -1 for an invalid socket
+ */
+int riscv_socket_hart_count(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_mem_offset:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: offset of ram belonging to given socket
+ */
+uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_mem_size:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: size of ram belonging to given socket
+ */
+uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_check_hartids:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: true if hardids belonging to given socket are contiguous else false
+ */
+bool riscv_socket_check_hartids(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_fdt_write_id:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Write NUMA node-id FDT property for given FDT node
+ */
+void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
+                               const char *node_name, int socket_id);
+
+/**
+ * riscv_socket_fdt_write_distance_matrix:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Write NUMA distance matrix in FDT for given machine
+ */
+void riscv_socket_fdt_write_distance_matrix(const MachineState *ms, void *fdt);
+
+CpuInstanceProperties
+riscv_numa_cpu_index_to_props(MachineState *ms, unsigned cpu_index);
+
+int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx);
+
+const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms);
+
+#endif /* RISCV_NUMA_H */
-- 
2.25.1



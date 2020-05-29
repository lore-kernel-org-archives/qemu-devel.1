Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A403C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B724F207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ldSE/Csx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dAHc8ckX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B724F207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedVd-0003yw-S6
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedU4-0002EX-Al; Fri, 29 May 2020 07:47:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedU2-0006ru-4W; Fri, 29 May 2020 07:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590752850; x=1622288850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=bSWrfP3p0heSsTsHJoGNwSHjerOBRrtPKfQDgzY6ezs=;
 b=ldSE/CsxFwLSSsmqDXQ5LIBdfY9l3owONdOaqSlp+uXeVWdp/QddEKOk
 90czAjcULSYNjPgczjBh0qVyIe/dZ796Egew7qd47dhYGJTcoln+ZqOc7
 d9wb79DCzJG1tH4Mny4sCGxuvzidp6BWL4wypM+eoxFeHQjiTt5H/LyY0
 wJxM/su+Kmb0cXD0Rhr+eoJXYyTBnAxmklwoHyp6FcEcztiTLLDY4YH19
 zZcaxZQvvH5HUP1tRHdagkX7zE08m0Fp+oF+EZkXBEBX2Yyu44T+LdS26
 tIqcmcZvyICBwH3ZkeqU7tb1AnGal2dbxmeFiEQYbL5P6YIdflpQrbetc Q==;
IronPort-SDR: f/efXZ/7xurPuBK6YabvAItnIXDxFCZRRSDUM9R1cOLWxP6Vnf8/Fza++4Y7IhL+JKaIDXyyT9
 wc6FIouxfrN+XYAnC3uf1Ca9OUwNbnC2NYlBdr2QBHXKfrv1Cz0C1dBckWBEsJB2Dx8o+B1pEA
 YBrmuHkXxHQl0K+uv3yEqr+YkeSg79MXg+NcWoXT0yjEWu6bRB1tVng6mlA8mIUXj2srIYdXlQ
 glO6SvAGLISV9IRvV6DFVm/bSR+T0xugCyXXIqvkveCMh19GhlOX0rPd2N19n8CDqiBz5+fE1F
 9Ls=
X-IronPort-AV: E=Sophos;i="5.73,448,1583164800"; d="scan'208";a="247863263"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 19:47:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpLtNjHB3MF74y/hrye2jGC34TodwkCO2KJ9QzKw4CbdKTwoKga8qPXSvkZoXjpDiQ0p7h7KYwyxAW9hes3fkDOsF31/DLw1+Vq3oMGcbvIc5qIUr4N7AlLuCzWMADmc/xas8iUo2CYzr/SjDy8dsHopMYKjGp8gqarlrLk+HxtOPTj1MVeBu7J9c0jxLcA26if6cb9p7ZIugLU/lp2k0v61rLg+BgujRuUSA44rs2QQCxZYEHGfXnJgAb7h8Mp092r63hImRy2Fvu+jdWrDxkuKwzHY2GLNJ20A0Lk5+9g+LHvA1tthB6CX4sRfijFHLITp1kInd7rb4ssc0RuQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHqKaAifzipknqEXcN8FNL0zpu7q9dCi8JQdXMLJHw4=;
 b=LE9Ubt/LtbO/c//y3Wo8cba7uvO3S6dnuweTehKuQ0IkwSBcaEEIWjBhnO3VZQcoT+LrO+rIIWJ82P9JN2DaZa+pmWshhBkz3mSpF3vwSbDWUYkKbOzvY9aPzMCVll6g1YzcbfI0FS+SYR2IN1/SeBB2k9TZyWEC4GGDTGpWzm3zB5PwAd12+x2GTTty1sS8HsVvJLEhqtngwet38pjPwpsxXu22g/cTB2uL/ynrlOZ2hrdADqiCPZTYVucW0KddVPnCA0XdnO59zCWnb9Yd0cfBTrAjnqj13U3999uUOopTBiIIfmEsdFzAt20RY6Ma2IbqMa1WK4orRFU/ExNfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHqKaAifzipknqEXcN8FNL0zpu7q9dCi8JQdXMLJHw4=;
 b=dAHc8ckXMdHZ7ULEoQc6uhNO8WbBLfs9ljty4bLb52HwTYwV6LoxfMzQzmT/Gz6ckr/zHWpoapyAz98FR+1jXnS5FVa20Moeo/u9KVFL/ATxaAJR9Jg3vvNSfEKczwLmm3w8iAGer9XlyYOPmRJOqR/Fju92vfeDBl76NM7LfzM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7019.namprd04.prod.outlook.com (2603:10b6:5:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 11:47:26 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 11:47:26 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v5 3/5] hw/riscv: Add helpers for RISC-V multi-socket NUMA
 machines
Date: Fri, 29 May 2020 17:16:39 +0530
Message-Id: <20200529114641.121332-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529114641.121332-1-anup.patel@wdc.com>
References: <20200529114641.121332-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.109.153) by
 MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 11:47:22 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.109.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb55a4c5-44d0-497a-c0bc-08d803c60f07
X-MS-TrafficTypeDiagnostic: DM6PR04MB7019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB70197455FE2CEF8A0140494E8D8F0@DM6PR04MB7019.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFu1RmVLxVrx2hTgue9e5GBxW5y/brm8tYAfF2H60GrhtPYlGs16DIHO0ItKHFQApo8tUlb+nm9kcO2oySYFOe8wuEfJk7IRcOb7cWdMVP+936h0DL4QlIUXZF5SSkmIesTmQMfNd42/5PhpHLPGaRcrpDzovaNM2Fliqqn6oQTTOLngpjZRVOGbDyX2ENierfrLfucn/syFmwUepRik+j32IovtCiagDK5va9j+qVFZKjuRPYjzQRmUlmSwmYlGdmoxQU3m9RaakJ+bV4wQrGt+gyevs5dFyGqRInNVOl/MIVqOOYwWtie/He9GgsF47vLfFLT2tvpEA18cAJHpVIr1LIkP6SIFHJVuM+ygDCmQ0ydubn+tkOVghyy/fcfIT3+5aypMgR0/UAm5GS635Itp9XIc+O8eKaWC8CJLHo2FHNhewKCQXuQMlkspSOj0OTFd/sh7BGIOVQJ2iAmmnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(8936002)(83380400001)(8886007)(2906002)(186003)(478600001)(6666004)(316002)(1006002)(36756003)(54906003)(55016002)(1076003)(110136005)(66946007)(26005)(16526019)(956004)(86362001)(2616005)(66476007)(66556008)(5660300002)(7696005)(52116002)(4326008)(55236004)(44832011)(8676002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1kJZVsdrJiTic/9HXFp3kDxba9T6SjAO/qeKC9eK/myFgIfDqcwOaJKZdIsdn/dJmT+cEtzDhyzIVtQ0EX017pA73aH0HwtxY4Wi/2d3K8zZBctgD9fCGrC6kuXYP1tPha2GWzTF+duJu5w2yh4f74YcLPiqNqTFKa+ED385SFbJ3zFxD56zilqz5yQHq9VL1gqT8MhJxZvhtWwr4EXFVMWcZMf5aDe1a5gAG6Dt1PZKYqCl7V3o3z/L3gB1JOhaRhwxL0JnQ1p4YZRxPzUet43IDWmZYKJi8z0lg0JQi3ZTxLTyls8oqL8Gaw38H5N5+DEJcZKjPjd/xCDQxq8UNEk2zW+Ibs6uc+etXiiy4Fy2fg4b0mJc7skJpbubFk1Pc5RH16BkjbvzLDxlnv7d9ezRh9B49AHE6yq6Uuxv6ms35axQ6b5SliboimafsXh5n9zj1SHQ9Irti5IWBuKt+JbOH2hZeVbEcwQyHnGX+Y8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb55a4c5-44d0-497a-c0bc-08d803c60f07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 11:47:26.5468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfzfMGldFM+q4F1qSn3jAV0921OTouTKK7XSBNlXPgcw9XjeREcf6d4kZFZ9nqv5UqGwFgUVKwxqGu8L64ezkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7019
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=411e18819=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 07:47:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
---
 hw/riscv/Makefile.objs  |   1 +
 hw/riscv/numa.c         | 242 ++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/numa.h |  51 +++++++++
 3 files changed, 294 insertions(+)
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
index 0000000000..fd9517a315
--- /dev/null
+++ b/include/hw/riscv/numa.h
@@ -0,0 +1,51 @@
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
+int riscv_socket_count(const MachineState *ms);
+
+int riscv_socket_first_hartid(const MachineState *ms, int socket_id);
+
+int riscv_socket_last_hartid(const MachineState *ms, int socket_id);
+
+int riscv_socket_hart_count(const MachineState *ms, int socket_id);
+
+uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id);
+
+uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id);
+
+bool riscv_socket_check_hartids(const MachineState *ms, int socket_id);
+
+void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
+                               const char *node_name, int socket_id);
+
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



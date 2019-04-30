Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 03:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E52E20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 03:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E52E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLJLp-00027t-4O
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 23:22:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yangchuanlong@huawei.com>) id 1hLJL5-0001pB-85
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yangchuanlong@huawei.com>) id 1hLJL4-0007iS-D4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:21:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42388 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yangchuanlong@huawei.com>)
	id 1hLJL4-0007eg-0u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:21:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id BE80D3CC4C492BA067D2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 11:16:12 +0800 (CST)
Received: from localhost.huawei.com (10.143.28.114) by
	DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server
	id 14.3.439.0; Tue, 30 Apr 2019 11:16:06 +0800
From: Yang Chuanlong <yangchuanlong@huawei.com>
To: <qemu-devel@nongnu.org>, <gengdongjiu@huawei.com>
Date: Tue, 30 Apr 2019 11:12:38 +0800
Message-ID: <20190430031238.40499-1-yangchuanlong@huawei.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.143.28.114]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] [PATCH v1] target/arm/arm-powerctl: mask the cpuid
 with affinity bits when get cpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430031238.ovp0-l4JXUEJqd7jiWB3oytN4m0XlPYxy2FNY__GQMg@z>

Currently, the cpuid passed from the device tree may still contain
non-affinity fields, which will cause arm_set_cpu_on failure.
Therefore, we mask the cpuid with affinity fields here to
improve qemu compatibility.

Signed-off-by: Yang Chuanlong <yangchuanlong@huawei.com>
---
 target/arm/arm-powerctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f77a950db6..ef9fec0b4d 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -31,7 +31,13 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
 {
     CPUState *cpu;
=20
-    DPRINTF("cpu %" PRId64 "\n", id);
+#ifdef TARGET_AARCH64
+    id &=3D ARM64_AFFINITY_MASK;
+#else
+    id &=3D ARM32_AFFINITY_MASK;
+#endif
+
+    DPRINTF("cpu %" PRId64 " after mask affinity\n", id);
=20
     CPU_FOREACH(cpu) {
         ARMCPU *armcpu =3D ARM_CPU(cpu);
--=20
2.21.0



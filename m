Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C6C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C85E2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C85E2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDodL-0000Us-Sr
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jDo7i-0005zy-R5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jDo7h-00021L-M3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:41:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3204 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jDo7h-00015R-7p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:41:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0F1E3771176EB3E7AF93;
 Mon, 16 Mar 2020 19:41:26 +0800 (CST)
Received: from huawei.com (10.133.201.158) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 19:41:19 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] accel/tcg: avoid integer overflow
Date: Mon, 16 Mar 2020 19:40:50 +0800
Message-ID: <20200316114050.3167-3-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200316114050.3167-1-jiangyifei@huawei.com>
References: <20200316114050.3167-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.201.158]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: zhang.zhanghailiang@huawei.com, limingwang@huawei.com,
 victor.zhangxiaofeng@huawei.com, Yifei Jiang <jiangyifei@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, pbonzini@redhat.com, rth@twiddle.net,
 dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes coverity issues 75235919, etc.,
    1524    /* Handle CPU specific unaligned behaviour */
CID 75235919: (OVERFLOW_BEFORE_WIDEN)
    1525. overflow_before_widen: Potentially overflowing expression "1 <<=
 a_bits" with type "int" (32 bits, signed) is evaluated using 32-bit arit=
hmetic, and then used in a context that expects an expression of type "ta=
rget_ulong" (64 bits, unsigned).
    1525    if (addr & ((1 << a_bits) - 1)) {

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Mingwang Li <limingwang@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
---
 accel/tcg/cputlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e3b5750c3b..73b5e680be 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1412,7 +1412,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,
     retaddr -=3D GETPC_ADJ;
=20
     /* Enforce guest required alignment.  */
-    if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
+    if (unlikely(a_bits > 0 && (addr & (((target_ulong)1 << a_bits) - 1)=
))) {
         /* ??? Maybe indicate atomic op to cpu_unaligned_access */
         cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
@@ -1522,7 +1522,7 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
     size_t size =3D memop_size(op);
=20
     /* Handle CPU specific unaligned behaviour */
-    if (addr & ((1 << a_bits) - 1)) {
+    if (addr & (((target_ulong)1 << a_bits) - 1)) {
         cpu_unaligned_access(env_cpu(env), addr, access_type,
                              mmu_idx, retaddr);
     }
@@ -1911,7 +1911,7 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
     size_t size =3D memop_size(op);
=20
     /* Handle CPU specific unaligned behaviour */
-    if (addr & ((1 << a_bits) - 1)) {
+    if (addr & (((target_ulong)1 << a_bits) - 1)) {
         cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
     }
--=20
2.19.1




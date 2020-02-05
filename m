Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80632C352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59710217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59710217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLUv-0000wp-J5
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1izLTm-0000Lq-Li
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1izLTl-0005GE-6x
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:16:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42386 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1izLTk-0004pd-No
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:16:33 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EFF299B72F34D230DB18;
 Wed,  5 Feb 2020 22:16:26 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Feb 2020 22:16:19 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <tony.nguyen@bt.com>
Subject: [PATCH v2] compiler.h: Don't use compile-time assert when
 __NO_INLINE__ is defined
Date: Wed, 5 Feb 2020 22:15:45 +0800
Message-ID: <20200205141545.180-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, wanghaibin.wang@huawei.com,
 qemu-devel@nongnu.org, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our robot reported the following compile-time warning while compiling
Qemu with -fno-inline cflags:

In function 'load_memop',
    inlined from 'load_helper' at /qemu/accel/tcg/cputlb.c:1578:20,
    inlined from 'full_ldub_mmu' at /qemu/accel/tcg/cputlb.c:1624:12:
/qemu/accel/tcg/cputlb.c:1502:9: error: call to 'qemu_build_not_reached' =
declared with attribute error: code path is reachable
         qemu_build_not_reached();
         ^~~~~~~~~~~~~~~~~~~~~~~~
    [...]

It looks like a false-positive because only (MO_UB ^ MO_BSWAP) will
hit the default case in load_memop() while need_swap (size > 1) has
already ensured that MO_UB is not involved.

So the thing is that compilers get confused by the -fno-inline and
just can't accurately evaluate memop_size(op) at compile time, and
then the qemu_build_not_reached() is wrongly triggered by (MO_UB ^
MO_BSWAP).  Let's carefully don't use the compile-time assert when
no functions will be inlined into their callers.

Reported-by: Euler Robot <euler.robot@huawei.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

v2 is actually written by Richard Henderson.

v1: https://lore.kernel.org/r/20200205081703.631-1-yuzenghui@huawei.com

 include/qemu/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 85c02c16d3..c76281f354 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -236,7 +236,7 @@
  * supports QEMU_ERROR, this will be reported at compile time; otherwise
  * this will be reported at link time due to the missing symbol.
  */
-#ifdef __OPTIMIZE__
+#if defined(__OPTIMIZE__) && !defined(__NO_INLINE__)
 extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
     qemu_build_not_reached(void);
 #else
--=20
2.19.1




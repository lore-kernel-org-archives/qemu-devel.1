Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B4C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB74207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dw+MndgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB74207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRDb-00073U-FR
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBK-0003ed-Ak; Thu, 10 Sep 2020 14:20:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBH-0002kZ-R0; Thu, 10 Sep 2020 14:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762023; x=1631298023;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KB3dWLk2WQBSmIbfJFgcXf3TDb7sLydLaxLIXsEB1Bo=;
 b=dw+MndgCNvEo1cB+1GmVs00HUgFyyv5kc5ijT9NHBc/WWWgediIcv/VE
 UDxE2GW65rrlantaqxP1MY17NKakbeZ6i8dDxJT8xb7ljiT6JWpKeLRC1
 zld2MFVWqhGKVXGiOn3sXmjSxi6w+x3BolZW7ssrCKPPIiJoRFh23jLkW
 aTsRGvzCkos2SfZu4T9/EsE/Ks2nHsxt9o1OZIZ2iFrOfjbrAgBtX4b1f
 xteHEK1S2/csELkt+aZqNMsOkksjug+GByulKT0O42bRsSml0Ty7RAIQe
 UTLnfJtQIsqreYQMq1Rc98wUJzYT9oc0dXt2xsNJfOFSX0z0EgmnyxZXm Q==;
IronPort-SDR: BqeGeAppZrm0Dr2Ig0RYZT6wyz4WUk4VCbdgAS6v75wDfo+ftvSWty1//OHz6TmVi5DgvCkgO7
 YNjrkeuYYcUS3zH1RV6RXnspZw2F0UU8hiCMg9xzuSk38RL49ch3nC5DCELtjXOzUeAQ34gBBA
 w92IXjDQscWoCg51X/eL2bLtOYJi5QKXXU5c+wUWUZFxTdNLICvucAK3GXo5vfeqrLIDmKfoTR
 m1EmQ5ByDG2rG9R4ebfxSN5LcKJPK9JMbwS1KLQTmMbZgnKazK0JAF5/yNjiC1J8NOO/3VUeHT
 Soo=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979204"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:14 +0800
IronPort-SDR: c0ADv9N1XqY5NRYGiQEQbjsC04XV0GwK2zMKQbLPwRdBizLjeNZk3PsBERh8JNk5cBEUaylxjK
 zTncfUcSW6uQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:31 -0700
IronPort-SDR: jpES+eWP0NDgFF7j+sACicub7+b+v1O+hfee4qgfvwLUnpAQSgfPdk+ZHXip4YsuKY/VKdJsVX
 ZTNAa4L4L8Dw==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/30] riscv: sifive_test: Allow 16-bit writes to memory region
Date: Thu, 10 Sep 2020 11:09:10 -0700
Message-Id: <20200910180938.584205-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Nathan Chancellor <natechancellor@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nathan Chancellor <natechancellor@gmail.com>

When shutting down the machine running a mainline Linux kernel, the
following error happens:

$ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
    -display none -initrd rootfs.cpio -kernel Image -m 512m \
    -nodefaults -serial mon:stdio
...
Requesting system poweroff
[    4.999630] reboot: Power down
sbi_trap_error: hart0: trap handler failed (error -2)
sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
sbi_trap_error: hart0: gp=0xffffffe000e76610 tp=0xffffffe0081b89c0
sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
sbi_trap_error: hart0: t6=0x0000000000000000

The kernel does a 16-bit write when powering off the machine, which
was allowed before commit 5d971f9e67 ("memory: Revert "memory: accept
mismatching sizes in memory_region_access_valid""). Make min_access_size
match reality so that the machine can shut down properly now.

Cc: qemu-stable@nongnu.org
Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200901055822.2721209-1-natechancellor@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 0c78fb2c93..8c70dd69df 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
     .write = sifive_test_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 2,
         .max_access_size = 4
     }
 };
-- 
2.28.0



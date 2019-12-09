Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FF7C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31832080D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HV/OyZNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31832080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO36-0003xw-6K
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbu-0000Gj-SP
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbt-00086k-Pn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:18 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbt-0007up-GJ; Mon, 09 Dec 2019 13:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915541; x=1607451541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lp4uYnFjP7u2ov5IIPsAq6hVfJSQk+rVaLtzjwCzmQI=;
 b=HV/OyZNWxG8Yqeav9WEs8mj0/wIG5+WGCh89Pd9w6RmAwEE4WL0YJ0ID
 Yq9f85FGkRAQUpBwfG89n34Nwk6xlD8lVOZmb54Uk2TYN0ffQtI/bTUJa
 R470ZSyN0amW9an+MxD/I1C6SBW+PLnwJvtS2y98xy1kImog6wQOsRGtO
 M5VQOvfzSPE6o+/IvZ9NlAecDmcp7MWwv2ifG05rTEYJTAly9bTo/xIIQ
 XEzEonwuMZ0Y97J9fJFy8gwhR+BnzSZLkbi82FwINCdDQNgTtz1KUQBhn
 GbpP4YF644lEuKRw751bZM07HwzAuRRS8XqI2zXV3Bkjkuga0ZaYuwcjO w==;
IronPort-SDR: HH44RatgDvBd8tP0YqeatVdD0kYl7SEJ27hAv/WBZs8ll4bEukK91NRIfj4pwT8Ho4XfkGBNBt
 gRB/+1SkROeDLS6d2+7vzkmDHJ86PFseAa5dI9sPk6rSqYQrY96cHPEYrHqmrliFWiuzfmMmSh
 aUnvEvbe0gQzoT6D3eMy8QvFiAFpeWSMVTC2NdK8wZ1x3NYMJzVSwwO7lKe+nPeCjcGzCNOfIp
 yBqHgStN5Fa9KzTxMZ9mB2FQDVMY8R+xuCoC2D/dKdIjDCb8IiUkkc4R2EQLy3KMdDmv7UW/Gm
 Z9A=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412055"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:18:30 +0800
IronPort-SDR: LlkR3tla18oI9FnsMBE/sNT2HzZ81I7OiTOfku7dET4NgTNT2mZ8VB1WvRiH14u0ThvnwJiM9P
 WRtPe2ExTv/+NgY9mRM5t7yGRSsMVpVx22mUq5Do5KHybkcy8NvdoA7d2JZpRuX7LYzBDT6Vyc
 cApAqkcN5cpfICWsvL3AnkTchb+gMVD6xiiAc4L/Xn1aDDoa/E1Jh6mE4ZJCaRvUFXA9FIw0F/
 29fnWv6WGWCk4yFnoKNzn4CyXx5Ljqf5DhKjPxS4dsyWgR9AoTt/h0tMyQqEiXEpWGztwUyyhO
 2XZ5+l+ogZcOiGVI5o1QSx4k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:34 -0800
IronPort-SDR: Un2UwZJVhMBZIGbp+2OBwWDc/1UDEdAGQP7QvDOrh6TlvmKsmDirViLLgPYn7MOEBKyJOfdIUe
 6NXDoqaj3L66Z7sloun19jM+RfBCw6OYsUacbkB5SytSUNCoHVOGnv3pEDvoRpiqTrg4MfSreh
 DuelsyhQgz47HU6DQlrbtU447So2XqxH86tGtBeb+D0Q9b2rq8A+Lv1AGqsgoEW/GqC+u8lLF6
 b9X28rMrcErSb3t2eEZEelcasnzzFH8SEiHOmpq5r4eVxizCI4QM7bt5yg02o41ZwInQm2wffV
 pP4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:57 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 36/36] target/riscv: Allow enabling the Hypervisor extension
Date: Mon,  9 Dec 2019 10:12:14 -0800
Message-Id: <a398f68dadf1fa1cae7dc9592b5a718568da5c3f.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 5 +++++
 target/riscv/cpu.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac8f53a49d..f087bc2c8b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -453,6 +453,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_u) {
             target_misa |= RVU;
         }
+        if (cpu->cfg.ext_h) {
+            target_misa |= RVH;
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -498,6 +501,8 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
+    /* This is experimental so mark with 'x-' */
+    DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 84a07971dc..53bc6af5f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -261,6 +261,7 @@ typedef struct RISCVCPU {
         bool ext_c;
         bool ext_s;
         bool ext_u;
+        bool ext_h;
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
-- 
2.24.0



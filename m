Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CBEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670C9206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YywRZXug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670C9206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRAw-0002g7-KK
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxP-0005Pz-6k; Thu, 28 May 2020 18:24:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxM-0008AZ-D9; Thu, 28 May 2020 18:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704696; x=1622240696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NjPOYFEQFKl1eDrJ+jkixdVdYqTQohhSFG4I212I6CI=;
 b=YywRZXug6CFMHr9qm4kDqt/GWndU7nilABGDHrwwFAAR8QJXftL7Lbt2
 Kw+rBP3HjYQUI7KG3Jz3P+jISmgIWCPvQWF62map2QKq4RfMG3vPWo2pF
 FBCtggxbVfK51fHHX77zDJDkwTMBL8xjqbT/FTgrBpR+5w0tvFN3uFjHS
 glpyCWuHlflbUVFjIjW4go7RbbNg2X24OoNU0LDC/fWjVepFJprSntKBG
 yTjvI/6q6wZy/DpiKH8KWwPeFi41xxsZLbzPxNZGNxhbIVBbGcejcHive
 5ZCVDtaA1wp3PozaxRv+zKLAT8SlXt+aY4IwGQvmP24FmD8I5CcVpt9X9 w==;
IronPort-SDR: bPYxfKRPkkpMPXTUG1rI+yaXeyGhT7ljtjZbYpgUqj9rzwCsDO9p+QLbnUUrFYOV/UGRRESrkT
 /6ToX3yZrFiRbcNN6RyHLD5xXVt0ctJlJ8/Oo6Jlb5+nfil9u+iaLmd+hkaLXb1IigdHFo27JQ
 zT9XP/YUel8yTHfh+yahe0TH7HbcuMEGSAIG4o/8ZVKWvTIwcL/Kp0kYVAP1zCPX3dUM0QKdA5
 U/Hgb+orji49GrJmr++Tawh+DuvLOlF+wWGo1WYAxH9hvxzY7GT/SOok9DcYKGqAX6xovo7lb8
 rps=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="247810980"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:24:47 +0800
IronPort-SDR: zaXfS8+J/wsCKgUssDVkomACZqbb3meWC8543DYNPopBQmD9QKy4tFheIENVEHWIPBs4xisTeG
 jXNv9vRhcgl8I5tblykQNZN425AOoMSUs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:14:02 -0700
IronPort-SDR: i/mcBkNFQq+Vq6sLjDP/u9jCsgWmVRJbfDnUCuaeun2mrJSErgBQid47Tv3JH2RLLcagcRn/P7
 QfbAw9TsnikA==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 May 2020 15:24:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 2/4] target/riscv: Remove the deprecated CPUs
Date: Thu, 28 May 2020 15:16:10 -0700
Message-Id: <0cc377a397d5e22123545e397a9bd443fadaf43f.1590704110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704110.git.alistair.francis@wdc.com>
References: <cover.1590704110.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:24:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 docs/system/deprecated.rst      | 33 ++++++++++++++++++---------------
 target/riscv/cpu.h              |  7 -------
 target/riscv/cpu.c              | 28 ----------------------------
 tests/qtest/machine-none-test.c |  4 ++--
 4 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 50927bad74..a6664bfca9 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -314,21 +314,6 @@ should be used instead of the 1.09.1 version.
 System emulator CPUS
 --------------------
 
-RISC-V ISA CPUs (since 4.1)
-'''''''''''''''''''''''''''
-
-The RISC-V cpus with the ISA version in the CPU name have been depcreated. The
-four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
-``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
-option when using the ``rv32`` or ``rv64`` CPUs.
-
-RISC-V ISA CPUs (since 4.1)
-'''''''''''''''''''''''''''
-
-The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` and
-``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
-via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
-
 ``compat`` property of server class POWER CPUs (since 5.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -486,6 +471,24 @@ The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed in 5.0
 The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
 
+System emulator CPUS
+--------------------
+
+RISC-V ISA CPUs (removed in 5.1)
+''''''''''''''''''''''''''''''''
+
+The RISC-V cpus with the ISA version in the CPU name have been removed. The
+four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
+``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
+option when using the ``rv32`` or ``rv64`` CPUs.
+
+RISC-V ISA CPUs (removed in 5.1)
+''''''''''''''''''''''''''''''''
+
+The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
+``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
+via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
+
 System emulator machines
 ------------------------
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..76b98d7a33 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -40,13 +40,6 @@
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
-/* Deprecated */
-#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
-#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")
 
 #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
 #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..112f2e3a2f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -135,16 +135,6 @@ static void riscv_base32_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
-    set_feature(env, RISCV_FEATURE_PMP);
-}
-
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -182,16 +172,6 @@ static void riscv_base64_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
-    set_feature(env, RISCV_FEATURE_PMP);
-}
-
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -621,18 +601,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
-    /* Depreacted */
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init)
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
-    /* Deprecated */
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init)
 #endif
 };
 
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 8bb54a6360..b52311ec2e 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] = {
     { "xtensa", "dc233c" },
     { "xtensaeb", "fsf" },
     { "hppa", "hppa" },
-    { "riscv64", "rv64gcsu-v1.10.0" },
-    { "riscv32", "rv32gcsu-v1.9.1" },
+    { "riscv64", "sifive-u54" },
+    { "riscv32", "sifive-u34" },
     { "rx", "rx62n" },
 };
 
-- 
2.26.2



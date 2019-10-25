Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDDCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA65721D82
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aVgDDXUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA65721D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO98E-0005IN-D8
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90w-000556-SP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90s-0004HP-32
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-0004C1-CA; Fri, 25 Oct 2019 19:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046136; x=1603582136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iPlPSnahIpXAaEeGYEZV/xK54GQvDy5AWPshxEhG2/Q=;
 b=aVgDDXUSpg2+4RZ7UQO/aXRFTS3KEPEKQGtoyaT0/IlMHh3iRSO7LLA0
 Et8UGrQOQWvDtutypvy51pyLeGc1ENoA5UkmBmV/Ao2Px7ovZz2KlPl4D
 2QaOJ3ke3CEfohYsSHMBSIFlPxip2MnfVaFrSQo7RBH7OVAJ0zpc8pbX3
 cmNI5ZmP+qL7e/BSOzgOUAa6AbaV0CPRBJ4l33YWryN08cCJA6Bt/fnHM
 E3ZHlrg8/vDUz/aKoxvIlSFtlQvFGRDev9afLxieDG6jewI5EANdZ7CEh
 WT53NSElQlkkf5Pi/mnLj6Ljvcd/qzzlju2v+d48y5e8qwBQ6EJMjx0Cn w==;
IronPort-SDR: 8/eZbgyH3ldInkeSO9cF/+atPFddqZdfFprxD44MA+E8MQMLJmTx/xaZzFAiHU7lUQDKexOgKC
 16UOwo6IelqIV847hPQja/0A+wd3OegLfVNz7Pi+cgNKljIHuzzTQd60jJQ/u5nTH39F8ZlfmT
 Fy4hHfPH1wfJ2NtIiJpdd6g1htXARYSVI/DUml9vfXfDzNO0OrEMS0Oz5CHxt738SIMHyJdE9I
 GKSTvYVbUtf9PmEUx1eOpFZy0yKZwYJllzmdEMEEgDYgOH53/jh+3Uh3BKOhPBv11uplh/pIrk
 SoE=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520400"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:34 +0800
IronPort-SDR: s7rzT46ZW+2RzgO5OOJ5iHF3mXZdTvRY/YJSHC9cNNvtsdrlrKi4mXv+i0F6i5g5fmDiRGYKU0
 jiZ2aG8Fy9cm+ZYuIqWJJtx0+okBamR/bjwtYf7OJEOa96Ve7a4KMr1nvCKO4KNob5KO1JCBcw
 6eWLG841btMPRv+1Jk5WVi4Dv1azvcAt9Md7WNr5RUQ6GToZ7CYgBepbqInKkzWzGC+Atka82D
 CFNRaZxtcijVWlBBK/EC3QQbVFJ6Lr/XaAUm8oHMf1iJJLjNdehoRSpF2lMtk0B48+K376ckc/
 mxxIry7BBNCYgb5VfRV2YCx/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:00 -0700
IronPort-SDR: uu6TRexTESW29auG6OUlU7eotQ6A0tmbRxqoz8lSZqNeYpEkCSi9n8parlxHr6PRLFeJpGGL7z
 g43GDtUGcpZdhJSOQBBsEB6nm5z+VFlEM7f1x7CcUkwWSbqXE9PVsyi+UtmmvXzmr4M1233OGv
 04xqh8681uKykhRohbYi+AOt9sAR2wR9/g9eXisvWLRpTDGB5hKsve+Mi2swzds6krcF6aoawU
 v3Oq4iGZa5mrvLaCzgo2NBRVnCyjH/sdOPCovUOZWJP1QPB9WKPLUAGNVFks7kpSXdZxv2uwET
 0jk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:28:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 09/27] target/riscv: Add Hypervisor CSR access functions
Date: Fri, 25 Oct 2019 16:23:39 -0700
Message-Id: <240cc632259f17a1f752ddcceb7e6b5902e61733.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 08956aa557..edfafca06f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -98,6 +98,20 @@ static int smode(CPURISCVState *env, int csrno)
     return -!riscv_has_ext(env, RVS);
 }
 
+static int hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS) &&
+        riscv_has_ext(env, RVH)) {
+        /* Hypervisor extension is supported */
+        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+            env->priv == PRV_M) {
+            return 0;
+        }
+    }
+
+    return -1;
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -754,6 +768,55 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Hypervisor Extensions */
+static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hstatus;
+    return 0;
+}
+
+static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hstatus = val;
+    return 0;
+}
+
+static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hedeleg;
+    return 0;
+}
+
+static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hedeleg = val;
+    return 0;
+}
+
+static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hideleg;
+    return 0;
+}
+
+static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hideleg = val;
+    return 0;
+}
+
+static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hgatp;
+    return 0;
+}
+
+static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hgatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -957,6 +1020,11 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
+    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
+    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
+    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.23.0



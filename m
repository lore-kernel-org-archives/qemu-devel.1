Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29835C3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E402072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E402072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3WVR-0000gv-3g
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 21:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3WUf-0008Mx-N3
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 21:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3WUe-0000nu-MB
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 21:50:45 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3WUe-0000n3-Fz; Sun, 16 Feb 2020 21:50:44 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 410C1747E00;
 Mon, 17 Feb 2020 03:50:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 21227747DCF; Mon, 17 Feb 2020 03:50:43 +0100 (CET)
Message-Id: <82d245d64615e337c604ea330cffffea84cbd61c.1581904461.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1581904461.git.balaton@eik.bme.hu>
References: <cover.1581904461.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 17 Feb 2020 01:14:16 +0100
Subject: [RFC PATCH 1/2] target/ppc/cpu: Add hardfloat property
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a property to allow setting a flag in cpu env that will be used to
control if hardfloat is used for floating point ops (i.e. speed is
preferred over accuracy).

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h                | 2 ++
 target/ppc/translate_init.inc.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b283042515..1b258a5db5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1033,6 +1033,7 @@ struct CPUPPCState {
     float_status vec_status;
     float_status fp_status; /* Floating point execution context */
     target_ulong fpscr;     /* Floating point status and control register */
+    bool hardfloat;         /* use hardfloat (this breaks FPSCR[FI] bit) */
 
     /* Internal devices resources */
     ppc_tb_t *tb_env;      /* Time base and decrementer */
@@ -1163,6 +1164,7 @@ struct PowerPCCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+    bool hardfloat; /* pass on property to env */
 
     /* Those resources are used only during code translation */
     /* opcode handlers */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 53995f62ea..d6e1d66bc8 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10736,6 +10736,7 @@ static void ppc_cpu_reset(CPUState *s)
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->fp_status);
+    env->hardfloat = cpu->hardfloat;
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
@@ -10868,6 +10869,7 @@ static Property ppc_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
                      false),
+    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.1



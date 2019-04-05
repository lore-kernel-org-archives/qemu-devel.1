Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BCC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7393621738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf8xXzB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7393621738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRTh-00067m-NK
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:14:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQa-00049B-AY
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQR-0001qF-Ph
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPh-0000Kd-D8
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id y7so8624416wrn.11
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pA28vCbZx6lzm3kJbSa2/z8AMN5bASGS+zrnO8I7fu0=;
	b=Gf8xXzB+QtjPvJhRtFwRMUcJAC+fO59ePj1Ro5I3XScybLf238JhuyYWdzmimv+rNn
	2EomjDcD2R5EmEHbAilLoZ/bE3t8d+4A/u7vpcSxmNMXmOTUfAW0jJge+qD+JpH/239f
	Z8bB8h2hS/eVpkkcVu7ijA9p1ZAS5xGcHld4U3Ch4frf+ovU4GxH8wVZkI4Fcqv0ghHl
	ePC/6ez5VfYnbvezwVAd+pv6HZn9BFoYUWxzc3P6nVX86GNa+kliw+B5dH5LBIlYiU8t
	Gc7OqKzBleTie5mEADZttYBTcySzaXOw/nwpn+I8FfvIDMJ5fmOdTvkjqzLAh7E3qw5E
	tYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pA28vCbZx6lzm3kJbSa2/z8AMN5bASGS+zrnO8I7fu0=;
	b=trlRK9Va0E2UVPoDqBzMNp+ghtFWAy5Fz8vDnQW5sI27yQgIQsu1kbfZE3xRjJ9V7L
	TfdWxwWnmkfFppmEwVOI96fQt+wtnWBG3Qhwn8YSG+04bt+nYk8Ol9Eqpp8j131mSMyQ
	668amNw4+8YLP/KkPIKb5P6deNvBljUNp935YQNVx+NWKO7a51u2Ft33ipt3ir3f28op
	91wiiuopkhOMbEtJN2XaupRMcktJe/6sqiIKgeo94M4viAnF7F3RQHZ8jXjSyy/k/JFY
	nYhx3nByBo8vzSMhyOn+cKSOGCuOQdAAKj8WQaHPe+O4GwLos6RplGe6I94Yq9zMsDlJ
	Ou5g==
X-Gm-Message-State: APjAAAX4cnwS9gLRaqlwl6F+fUZG5k+MDfp5T8FpEQ/tfaHKAegUSsBd
	wSf1nyeCFzy1ydYGYSABkg==
X-Google-Smtp-Source: APXvYqwY+I90hozICd1wJGoHAcIllHqDDHo+z+EbbL/il5u/gmuUawKk97EDiPOHciVvM/SF3z9cKQ==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr8856393wrr.147.1554480590982; 
	Fri, 05 Apr 2019 09:09:50 -0700 (PDT)
Received: from ninjatsu.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	z10sm2966029wmi.15.2019.04.05.09.09.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:09:50 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: amarkovic@wavecomp.com
Date: Fri,  5 Apr 2019 17:09:35 +0100
Message-Id: <20190405160938.27494-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405160938.27494-1-jbi.octave@gmail.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 1/4] target/mips: realign comments to fix
 checkpatch warnings
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
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405160935.GvpkoohiEwJMaZSl0_1aS7HOrQFxOH_W_tObVpz4Wqk@z>

Realign comments to fix warnings issued by checkpatch.pl tool
"WARNING: Block comments use a leading /* on a separate line"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a10eeb0de3..5dd71dbe21 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -37,7 +37,8 @@ union fpr_t {
 /* FPU/MSA register mapping is not tested on big-endian hosts. */
     wr_t     wr;   /* vector data */
 };
-/* define FP_ENDIAN_IDX to access the same location
+/*
+ * define FP_ENDIAN_IDX to access the same location
  * in the fpr_t union regardless of the host endianness
  */
 #if defined(HOST_WORDS_BIGENDIAN)
@@ -963,9 +964,11 @@ struct CPUMIPSState {
     /* TMASK defines different execution modes */
 #define MIPS_HFLAG_TMASK  0x1F5807FF
 #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    */
-    /* The KSU flags must be the lowest bits in hflags. The flag order
-       must be the same as defined for CP0 Status. This allows to use
-       the bits as the value of mmu_idx. */
+    /*
+     * The KSU flags must be the lowest bits in hflags. The flag order
+     * must be the same as defined for CP0 Status. This allows to use
+     * the bits as the value of mmu_idx.
+     */
 #define MIPS_HFLAG_KSU    0x00003 /* kernel/supervisor/user mode mask   */
 #define MIPS_HFLAG_UM     0x00002 /* user mode flag                     */
 #define MIPS_HFLAG_SM     0x00001 /* supervisor mode flag               */
@@ -975,18 +978,22 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_CP0    0x00010 /* CP0 enabled                        */
 #define MIPS_HFLAG_FPU    0x00020 /* FPU enabled                        */
 #define MIPS_HFLAG_F64    0x00040 /* 64-bit FPU enabled                 */
-    /* True if the MIPS IV COP1X instructions can be used.  This also
-       controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
-       and RSQRT.D.  */
+    /*
+     * True if the MIPS IV COP1X instructions can be used.  This also
+     * controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
+     * and RSQRT.D.
+     */
 #define MIPS_HFLAG_COP1X  0x00080 /* COP1X instructions enabled         */
 #define MIPS_HFLAG_RE     0x00100 /* Reversed endianness                */
 #define MIPS_HFLAG_AWRAP  0x00200 /* 32-bit compatibility address wrapping */
 #define MIPS_HFLAG_M16    0x00400 /* MIPS16 mode flag                   */
 #define MIPS_HFLAG_M16_SHIFT 10
-    /* If translation is interrupted between the branch instruction and
+    /*
+     * If translation is interrupted between the branch instruction and
      * the delay slot, record what type of branch it is so that we can
      * resume translation properly.  It might be possible to reduce
-     * this from three bits to two.  */
+     * this from three bits to two.
+     */
 #define MIPS_HFLAG_BMASK_BASE  0x803800
 #define MIPS_HFLAG_B      0x00800 /* Unconditional branch               */
 #define MIPS_HFLAG_BC     0x01000 /* Conditional branch                 */
@@ -1073,8 +1080,10 @@ void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
 extern void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
 extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 
-/* MMU modes definitions. We carefully match the indices with our
-   hflags layout. */
+/*
+ * MMU modes definitions. We carefully match the indices with our
+ * hflags layout.
+ */
 #define MMU_MODE0_SUFFIX _kernel
 #define MMU_MODE1_SUFFIX _super
 #define MMU_MODE2_SUFFIX _user
@@ -1097,7 +1106,8 @@ static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-/* Memory access type :
+/*
+ * Memory access type :
  * may be needed for precise access rights control and precise exceptions.
  */
 enum {
-- 
2.20.1



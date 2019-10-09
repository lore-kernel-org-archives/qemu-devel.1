Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF6C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4951A206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNBqThQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4951A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEvm-00054z-LY
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iI2BG-0004HW-5c
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iI2B5-0003Cv-Gi
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:58:26 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1iI2B4-000397-DV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:58:15 -0400
Received: by mail-lj1-x242.google.com with SMTP id q64so839999ljb.12
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fs5ZfaJ0qqGloFzFstXG6dDoYFOBvB1pKzX1S/tvm98=;
 b=mNBqThQcJXQEb2TTjY/VtmvlL9Bp4gHU36wgob9JYk4WPj/uGmL70Or/iWzQQsbUot
 UFWP0YlIDiO5T21VqhCg4Bh6zuHjnfl8bp+aR4+SVCnASbWwZi45K8eB62I/kL5+bkUI
 p5vq/KvHLuR5iVPVxwEAYAdOgFXVMtDwkNTg6ZXLQti0FRdi0IFdcEU3hym4uQmnTA1I
 /uPWV6dZdoCAES5UXyPyyxv3jTUYPYNtUoBTn++BiC/LnKl0gUURtly5IfwrppUrCN5n
 wWjqJ/ie/5Kpyub5OmpEJPVQWknb5KlyXkPehPFmTc/S+xk6sWaJInAcSCosA699n1mK
 iQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fs5ZfaJ0qqGloFzFstXG6dDoYFOBvB1pKzX1S/tvm98=;
 b=FJMRfsGjcRLOO6W356lKuGBUF33/3+hq2VCgpscM11bgX2PKAv6GXZBOggXnXaImx7
 OHBt5QdVRNlYPq7FCPJ+GN961o+gTf5eJgVWts7lvwVo4u6ko7D5C9pz7Fup7Ii5lv1v
 wwMCzZYM9nrYEhWmlqY+oHr7uG8NUNWDgXwjyruMbVotwyA4ndxqOEZJ++pUZbY9WhIp
 GkZw8caRSAjXD1r+W+ZvtomjMJU09+su4XIdhXo0d7olaHL63fbzLimNwjOIo6PXHGAa
 2eKXkQdw8WE7Y/D+owklFDMkKkUDskyS3fJY2+aPlIuAC8gCu/6ipmoRiwqTUVPy8W8h
 o8OQ==
X-Gm-Message-State: APjAAAXQhYdiU8QG4Wia/GwS3hvxLiiMMazPMrSPim85hYajZ1dB54zt
 EueDS2io8z8m5bBtErEtmWNsuU86
X-Google-Smtp-Source: APXvYqyYu9/6/Q8PqEPblmxI5CE4uKBam/dUPGDTJGmWfNM8NhCIyKAIGNMN0kbyvUNL55dKQ00sxg==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr800173ljg.192.1570589889986; 
 Tue, 08 Oct 2019 19:58:09 -0700 (PDT)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id y206sm136777lfc.6.2019.10.08.19.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 19:58:08 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: regenerate and re-import test_mmuhifi_c3 core
Date: Tue,  8 Oct 2019 19:57:53 -0700
Message-Id: <20191009025753.957-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Overlay part of the test_mmuhifi_c3 core has GPL3 copyright headers in
it. Fix that by regenerating test_mmuhifi_c3 core overlay and
re-importing it.

Fixes: d848ea776728 ("target/xtensa: add test_mmuhifi_c3 core")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/core-test_mmuhifi_c3.c          |    3 +-
 target/xtensa/core-test_mmuhifi_c3/core-isa.h |  116 +-
 .../core-test_mmuhifi_c3/gdb-config.inc.c     |  114 +-
 .../core-test_mmuhifi_c3/xtensa-modules.inc.c | 6384 ++++++++---------
 4 files changed, 3385 insertions(+), 3232 deletions(-)

diff --git a/target/xtensa/core-test_mmuhifi_c3.c b/target/xtensa/core-test_mmuhifi_c3.c
index 3a59fefa941e..089ed7da5d37 100644
--- a/target/xtensa/core-test_mmuhifi_c3.c
+++ b/target/xtensa/core-test_mmuhifi_c3.c
@@ -27,8 +27,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
+#include "qemu-common.h"
 #include "qemu/host-utils.h"
 
 #include "core-test_mmuhifi_c3/core-isa.h"
@@ -39,7 +39,6 @@
 
 static XtensaConfig test_mmuhifi_c3 __attribute__((unused)) = {
     .name = "test_mmuhifi_c3",
-    .options = XTENSA_OPTIONS,
     .gdb_regmap = {
         .reg = {
 #include "core-test_mmuhifi_c3/gdb-config.inc.c"
diff --git a/target/xtensa/core-test_mmuhifi_c3/core-isa.h b/target/xtensa/core-test_mmuhifi_c3/core-isa.h
index 704a31f7c89f..838b1b09dab7 100644
--- a/target/xtensa/core-test_mmuhifi_c3/core-isa.h
+++ b/target/xtensa/core-test_mmuhifi_c3/core-isa.h
@@ -1,15 +1,37 @@
 /*
- * Xtensa processor core configuration information.
+ * xtensa/config/core-isa.h -- HAL definitions that are dependent on Xtensa
+ *				processor CORE configuration
  *
- * This file is subject to the terms and conditions of version 2.1 of the GNU
- * Lesser General Public License as published by the Free Software Foundation.
- *
- * Copyright (c) 1999-2009 Tensilica Inc.
+ *  See <xtensa/config/core.h>, which includes this file, for more details.
  */
 
+/* Xtensa processor core configuration information.
+
+   Copyright (c) 1999-2019 Tensilica Inc.
+
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
+
+   The above copyright notice and this permission notice shall be included
+   in all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
+
 #ifndef XTENSA_CORE_TEST_MMUHIFI_C3_CORE_ISA_H
 #define XTENSA_CORE_TEST_MMUHIFI_C3_CORE_ISA_H
 
+
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
  ****************************************************************************/
@@ -32,6 +54,7 @@
 #define XCHAL_HAVE_DEBUG		1	/* debug option */
 #define XCHAL_HAVE_DENSITY		1	/* 16-bit instructions */
 #define XCHAL_HAVE_LOOPS		1	/* zero-overhead loops */
+#define XCHAL_LOOP_BUFFER_SIZE		0	/* zero-ov. loop instr buffer size */
 #define XCHAL_HAVE_NSA			1	/* NSA/NSAU instructions */
 #define XCHAL_HAVE_MINMAX		1	/* MIN/MAX instructions */
 #define XCHAL_HAVE_SEXT			1	/* SEXT instruction */
@@ -59,44 +82,73 @@
 #define XCHAL_HAVE_TAP_MASTER		0	/* JTAG TAP control instr's */
 #define XCHAL_HAVE_PRID			1	/* processor ID register */
 #define XCHAL_HAVE_EXTERN_REGS		1	/* WER/RER instructions */
+#define XCHAL_HAVE_MX			1	/* MX core (Tensilica internal) */
 #define XCHAL_HAVE_MP_INTERRUPTS	1	/* interrupt distributor port */
 #define XCHAL_HAVE_MP_RUNSTALL		1	/* core RunStall control port */
+#define XCHAL_HAVE_PSO			0	/* Power Shut-Off */
+#define XCHAL_HAVE_PSO_CDM		0	/* core/debug/mem pwr domains */
+#define XCHAL_HAVE_PSO_FULL_RETENTION	0	/* all regs preserved on PSO */
 #define XCHAL_HAVE_THREADPTR		1	/* THREADPTR register */
 #define XCHAL_HAVE_BOOLEANS		1	/* boolean registers */
 #define XCHAL_HAVE_CP			1	/* CPENABLE reg (coprocessor) */
 #define XCHAL_CP_MAXCFG			2	/* max allowed cp id plus one */
 #define XCHAL_HAVE_MAC16		0	/* MAC16 package */
 #define XCHAL_HAVE_VECTORFPU2005	0	/* vector floating-point pkg */
-#define XCHAL_HAVE_FP			0	/* floating point pkg */
+#define XCHAL_HAVE_FP			0	/* single prec floating point */
+#define XCHAL_HAVE_FP_DIV		0	/* FP with DIV instructions */
+#define XCHAL_HAVE_FP_RECIP		0	/* FP with RECIP instructions */
+#define XCHAL_HAVE_FP_SQRT		0	/* FP with SQRT instructions */
+#define XCHAL_HAVE_FP_RSQRT		0	/* FP with RSQRT instructions */
 #define XCHAL_HAVE_DFP			0	/* double precision FP pkg */
+#define XCHAL_HAVE_DFP_DIV		0	/* DFP with DIV instructions */
+#define XCHAL_HAVE_DFP_RECIP		0	/* DFP with RECIP instructions*/
+#define XCHAL_HAVE_DFP_SQRT		0	/* DFP with SQRT instructions */
+#define XCHAL_HAVE_DFP_RSQRT		0	/* DFP with RSQRT instructions*/
 #define XCHAL_HAVE_DFP_accel		0	/* double precision FP acceleration pkg */
 #define XCHAL_HAVE_VECTRA1		0	/* Vectra I  pkg */
 #define XCHAL_HAVE_VECTRALX		0	/* Vectra LX pkg */
 #define XCHAL_HAVE_HIFIPRO		0	/* HiFiPro Audio Engine pkg */
+#define XCHAL_HAVE_HIFI3		0	/* HiFi3 Audio Engine pkg */
 #define XCHAL_HAVE_HIFI2		1	/* HiFi2 Audio Engine pkg */
+#define XCHAL_HAVE_HIFI2EP		0	/* HiFi2EP */
+#define XCHAL_HAVE_HIFI_MINI		0	
 #define XCHAL_HAVE_CONNXD2		0	/* ConnX D2 pkg */
+#define XCHAL_HAVE_BBE16		0	/* ConnX BBE16 pkg */
+#define XCHAL_HAVE_BBE16_RSQRT		0	/* BBE16 & vector recip sqrt */
+#define XCHAL_HAVE_BBE16_VECDIV		0	/* BBE16 & vector divide */
+#define XCHAL_HAVE_BBE16_DESPREAD	0	/* BBE16 & despread */
+#define XCHAL_HAVE_BBENEP		0	/* ConnX BBENEP pkgs */
+#define XCHAL_HAVE_BSP3			0	/* ConnX BSP3 pkg */
+#define XCHAL_HAVE_BSP3_TRANSPOSE	0	/* BSP3 & transpose32x32 */
+#define XCHAL_HAVE_SSP16		0	/* ConnX SSP16 pkg */
+#define XCHAL_HAVE_SSP16_VITERBI	0	/* SSP16 & viterbi */
+#define XCHAL_HAVE_TURBO16		0	/* ConnX Turbo16 pkg */
+#define XCHAL_HAVE_BBP16		0	/* ConnX BBP16 pkg */
+#define XCHAL_HAVE_FLIX3		0	/* basic 3-way FLIX option */
 
 
 /*----------------------------------------------------------------------
 				MISC
   ----------------------------------------------------------------------*/
 
+#define XCHAL_NUM_LOADSTORE_UNITS	1	/* load/store units */
 #define XCHAL_NUM_WRITEBUFFER_ENTRIES	8	/* size of write buffer */
 #define XCHAL_INST_FETCH_WIDTH		8	/* instr-fetch width in bytes */
 #define XCHAL_DATA_WIDTH		8	/* data width in bytes */
+#define XCHAL_DATA_PIPE_DELAY		1	/* d-side pipeline delay
+						   (1 = 5-stage, 2 = 7-stage) */
 /*  In T1050, applies to selected core load and store instructions (see ISA): */
 #define XCHAL_UNALIGNED_LOAD_EXCEPTION	1	/* unaligned loads cause exc. */
 #define XCHAL_UNALIGNED_STORE_EXCEPTION	1	/* unaligned stores cause exc.*/
 #define XCHAL_UNALIGNED_LOAD_HW		0	/* unaligned loads work in hw */
 #define XCHAL_UNALIGNED_STORE_HW	0	/* unaligned stores work in hw*/
 
-#define XCHAL_SW_VERSION		800000	/* sw version of this header */
+#define XCHAL_SW_VERSION		1000006	/* sw version of this header */
 
 #define XCHAL_CORE_ID			"test_mmuhifi_c3"	/* alphanum core name
 						   (CoreID) set in the Xtensa
 						   Processor Generator */
 
-#define XCHAL_CORE_DESCRIPTION		"test_mmuhifi_c3"
 #define XCHAL_BUILD_UNIQUE_ID		0x00005A6A	/* 22-bit sw build ID */
 
 /*
@@ -136,6 +188,10 @@
 #define XCHAL_DCACHE_IS_WRITEBACK	1	/* writeback feature */
 #define XCHAL_DCACHE_IS_COHERENT	1	/* MP coherence feature */
 
+#define XCHAL_HAVE_PREFETCH		0	/* PREFCTL register */
+#define XCHAL_HAVE_PREFETCH_L1		0	/* prefetch to L1 dcache */
+#define XCHAL_PREFETCH_CASTOUT_LINES	0	/* dcache pref. castout bufsz */
+
 
 
 
@@ -172,6 +228,8 @@
 #define XCHAL_ICACHE_ACCESS_SIZE	8
 #define XCHAL_DCACHE_ACCESS_SIZE	8
 
+#define XCHAL_DCACHE_BANKS		1	/* number of banks */
+
 /*  Number of encoded cache attr bits (see <xtensa/hal.h> for decoded bits):  */
 #define XCHAL_CA_BITS			4
 
@@ -187,6 +245,8 @@
 #define XCHAL_NUM_URAM			0	/* number of core unified RAMs*/
 #define XCHAL_NUM_XLMI			0	/* number of core XLMI ports */
 
+#define XCHAL_HAVE_IMEM_LOADSTORE	1	/* can load/store to IROM/IRAM*/
+
 
 /*----------------------------------------------------------------------
 			INTERRUPTS and TIMERS
@@ -261,6 +321,7 @@
 #define XCHAL_INTTYPE_MASK_TIMER	0x00000140
 #define XCHAL_INTTYPE_MASK_NMI		0x00000000
 #define XCHAL_INTTYPE_MASK_WRITE_ERROR	0x00000000
+#define XCHAL_INTTYPE_MASK_PROFILING	0x00000000
 
 /*  Interrupt numbers assigned to specific interrupt sources:  */
 #define XCHAL_TIMER0_INTERRUPT		6	/* CCOMPARE0 */
@@ -273,7 +334,7 @@
 
 
 /*
- *  External interrupt vectors/levels.
+ *  External interrupt mapping.
  *  These macros describe how Xtensa processor interrupt numbers
  *  (as numbered internally, eg. in INTERRUPT and INTENABLE registers)
  *  map to external BInterrupt<n> pins, for those interrupts
@@ -281,7 +342,7 @@
  *  See the Xtensa processor databook for more details.
  */
 
-/*  Core interrupt numbers mapped to each EXTERNAL interrupt number:  */
+/*  Core interrupt numbers mapped to each EXTERNAL BInterrupt pin number:  */
 #define XCHAL_EXTINT0_NUM		0	/* (intlevel 1) */
 #define XCHAL_EXTINT1_NUM		1	/* (intlevel 1) */
 #define XCHAL_EXTINT2_NUM		2	/* (intlevel 1) */
@@ -291,6 +352,16 @@
 #define XCHAL_EXTINT6_NUM		9	/* (intlevel 1) */
 #define XCHAL_EXTINT7_NUM		10	/* (intlevel 1) */
 #define XCHAL_EXTINT8_NUM		11	/* (intlevel 1) */
+/*  EXTERNAL BInterrupt pin numbers mapped to each core interrupt number:  */
+#define XCHAL_INT0_EXTNUM		0	/* (intlevel 1) */
+#define XCHAL_INT1_EXTNUM		1	/* (intlevel 1) */
+#define XCHAL_INT2_EXTNUM		2	/* (intlevel 1) */
+#define XCHAL_INT3_EXTNUM		3	/* (intlevel 1) */
+#define XCHAL_INT4_EXTNUM		4	/* (intlevel 1) */
+#define XCHAL_INT5_EXTNUM		5	/* (intlevel 1) */
+#define XCHAL_INT9_EXTNUM		6	/* (intlevel 1) */
+#define XCHAL_INT10_EXTNUM		7	/* (intlevel 1) */
+#define XCHAL_INT11_EXTNUM		8	/* (intlevel 1) */
 
 
 /*----------------------------------------------------------------------
@@ -300,11 +371,13 @@
 #define XCHAL_XEA_VERSION		2	/* Xtensa Exception Architecture
 						   number: 1 == XEA1 (old)
 							   2 == XEA2 (new)
-							   0 == XEAX (extern) */
+							   0 == XEAX (extern) or TX */
 #define XCHAL_HAVE_XEA1			0	/* Exception Architecture 1 */
 #define XCHAL_HAVE_XEA2			1	/* Exception Architecture 2 */
 #define XCHAL_HAVE_XEAX			0	/* External Exception Arch. */
 #define XCHAL_HAVE_EXCEPTIONS		1	/* exception option */
+#define XCHAL_HAVE_HALT			0	/* halt architecture option */
+#define XCHAL_HAVE_BOOTLOADER		0	/* boot loader (for TX) */
 #define XCHAL_HAVE_MEM_ECC_PARITY	0	/* local memory ECC/parity */
 #define XCHAL_HAVE_VECTOR_SELECT	1	/* relocatable vectors */
 #define XCHAL_HAVE_VECBASE		1	/* relocatable vectors */
@@ -344,13 +417,30 @@
 
 
 /*----------------------------------------------------------------------
-				DEBUG
+				DEBUG MODULE
   ----------------------------------------------------------------------*/
 
+/*  Misc  */
+#define XCHAL_HAVE_DEBUG_ERI		0	/* ERI to debug module */
+#define XCHAL_HAVE_DEBUG_APB		0	/* APB to debug module */
+#define XCHAL_HAVE_DEBUG_JTAG		0	/* JTAG to debug module */
+
+/*  On-Chip Debug (OCD)  */
 #define XCHAL_HAVE_OCD			1	/* OnChipDebug option */
 #define XCHAL_NUM_IBREAK		0	/* number of IBREAKn regs */
 #define XCHAL_NUM_DBREAK		0	/* number of DBREAKn regs */
-#define XCHAL_HAVE_OCD_DIR_ARRAY	0	/* faster OCD option */
+#define XCHAL_HAVE_OCD_DIR_ARRAY	0	/* faster OCD option (to LX4) */
+#define XCHAL_HAVE_OCD_LS32DDR		0	/* L32DDR/S32DDR (faster OCD) */
+
+/*  TRAX (in core)  */
+#define XCHAL_HAVE_TRAX			0	/* TRAX in debug module */
+#define XCHAL_TRAX_MEM_SIZE		0	/* TRAX memory size in bytes */
+#define XCHAL_TRAX_MEM_SHAREABLE	0	/* start/end regs; ready sig. */
+#define XCHAL_TRAX_ATB_WIDTH		0	/* ATB width (bits), 0=no ATB */
+#define XCHAL_TRAX_TIME_WIDTH		0	/* timestamp bitwidth, 0=none */
+
+/*  Perf counters  */
+#define XCHAL_NUM_PERF_COUNTERS		0	/* performance counters */
 
 
 /*----------------------------------------------------------------------
diff --git a/target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c b/target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c
index 618d30dffa4a..0bca70b5afb9 100644
--- a/target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c
+++ b/target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c
@@ -1,23 +1,25 @@
 /* Configuration for the Xtensa architecture for GDB, the GNU debugger.
 
-   Copyright (C) 2003, 2005, 2006, 2007, 2008 Free Software Foundation, Inc.
+   Copyright (c) 2003-2019 Tensilica Inc.
 
-   This file is part of GDB.
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
 
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 3 of the License, or
-   (at your option) any later version.
+   The above copyright notice and this permission notice shall be included
+   in all copies or substantial portions of the Software.
 
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
-
-  /*    idx ofs bi sz al targno  flags cp typ group name  */
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
   XTREG(  0,  0,32, 4, 4,0x0020,0x0006,-2, 9,0x0100,pc,          0,0,0,0,0,0)
   XTREG(  1,  4,32, 4, 4,0x0100,0x0006,-2, 1,0x0002,ar0,         0,0,0,0,0,0)
   XTREG(  2,  8,32, 4, 4,0x0101,0x0006,-2, 1,0x0002,ar1,         0,0,0,0,0,0)
@@ -58,8 +60,8 @@
   XTREG( 37,148,32, 4, 4,0x0205,0x0006,-2, 2,0x1100,litbase,     0,0,0,0,0,0)
   XTREG( 38,152, 3, 4, 4,0x0248,0x0006,-2, 2,0x1002,windowbase,  0,0,0,0,0,0)
   XTREG( 39,156, 8, 4, 4,0x0249,0x0006,-2, 2,0x1002,windowstart, 0,0,0,0,0,0)
-  XTREG( 40,160,32, 4, 4,0x02b0,0x0002,-2, 2,0x1000,sr176,       0,0,0,0,0,0)
-  XTREG( 41,164,32, 4, 4,0x02d0,0x0002,-2, 2,0x1000,sr208,       0,0,0,0,0,0)
+  XTREG( 40,160,32, 4, 4,0x02b0,0x0002,-2, 2,0x1000,configid0,   0,0,0,0,0,0)
+  XTREG( 41,164,32, 4, 4,0x02d0,0x0002,-2, 2,0x1000,configid1,   0,0,0,0,0,0)
   XTREG( 42,168,19, 4, 4,0x02e6,0x0006,-2, 2,0x1100,ps,          0,0,0,0,0,0)
   XTREG( 43,172,32, 4, 4,0x03e7,0x0006,-2, 3,0x0110,threadptr,   0,0,0,0,0,0)
   XTREG( 44,176,16, 4, 4,0x0204,0x0006,-1, 2,0x1100,br,          0,0,0,0,0,0)
@@ -137,4 +139,82 @@
   XTREG(104,464,32, 4, 4,0x000d,0x0006,-2, 8,0x0100,a13,         0,0,0,0,0,0)
   XTREG(105,468,32, 4, 4,0x000e,0x0006,-2, 8,0x0100,a14,         0,0,0,0,0,0)
   XTREG(106,472,32, 4, 4,0x000f,0x0006,-2, 8,0x0100,a15,         0,0,0,0,0,0)
+  XTREG(107,476, 1, 1, 1,0x0010,0x0006,-2, 6,0x1010,b0,
+            0,0,&xtensa_mask0,0,0,0)
+  XTREG(108,477, 1, 1, 1,0x0011,0x0006,-2, 6,0x1010,b1,
+            0,0,&xtensa_mask1,0,0,0)
+  XTREG(109,478, 1, 1, 1,0x0012,0x0006,-2, 6,0x1010,b2,
+            0,0,&xtensa_mask2,0,0,0)
+  XTREG(110,479, 1, 1, 1,0x0013,0x0006,-2, 6,0x1010,b3,
+            0,0,&xtensa_mask3,0,0,0)
+  XTREG(111,480, 1, 1, 1,0x0014,0x0006,-2, 6,0x1010,b4,
+            0,0,&xtensa_mask4,0,0,0)
+  XTREG(112,481, 1, 1, 1,0x0015,0x0006,-2, 6,0x1010,b5,
+            0,0,&xtensa_mask5,0,0,0)
+  XTREG(113,482, 1, 1, 1,0x0016,0x0006,-2, 6,0x1010,b6,
+            0,0,&xtensa_mask6,0,0,0)
+  XTREG(114,483, 1, 1, 1,0x0017,0x0006,-2, 6,0x1010,b7,
+            0,0,&xtensa_mask7,0,0,0)
+  XTREG(115,484, 1, 1, 1,0x0018,0x0006,-2, 6,0x1010,b8,
+            0,0,&xtensa_mask8,0,0,0)
+  XTREG(116,485, 1, 1, 1,0x0019,0x0006,-2, 6,0x1010,b9,
+            0,0,&xtensa_mask9,0,0,0)
+  XTREG(117,486, 1, 1, 1,0x001a,0x0006,-2, 6,0x1010,b10,
+            0,0,&xtensa_mask10,0,0,0)
+  XTREG(118,487, 1, 1, 1,0x001b,0x0006,-2, 6,0x1010,b11,
+            0,0,&xtensa_mask11,0,0,0)
+  XTREG(119,488, 1, 1, 1,0x001c,0x0006,-2, 6,0x1010,b12,
+            0,0,&xtensa_mask12,0,0,0)
+  XTREG(120,489, 1, 1, 1,0x001d,0x0006,-2, 6,0x1010,b13,
+            0,0,&xtensa_mask13,0,0,0)
+  XTREG(121,490, 1, 1, 1,0x001e,0x0006,-2, 6,0x1010,b14,
+            0,0,&xtensa_mask14,0,0,0)
+  XTREG(122,491, 1, 1, 1,0x001f,0x0006,-2, 6,0x1010,b15,
+            0,0,&xtensa_mask15,0,0,0)
+  XTREG(123,492, 4, 4, 4,0x2003,0x0006,-2, 6,0x1010,psintlevel,
+            0,0,&xtensa_mask16,0,0,0)
+  XTREG(124,496, 1, 4, 4,0x2004,0x0006,-2, 6,0x1010,psum,
+            0,0,&xtensa_mask17,0,0,0)
+  XTREG(125,500, 1, 4, 4,0x2005,0x0006,-2, 6,0x1010,pswoe,
+            0,0,&xtensa_mask18,0,0,0)
+  XTREG(126,504, 2, 4, 4,0x2006,0x0006,-2, 6,0x1010,psring,
+            0,0,&xtensa_mask19,0,0,0)
+  XTREG(127,508, 1, 4, 4,0x2007,0x0006,-2, 6,0x1010,psexcm,
+            0,0,&xtensa_mask20,0,0,0)
+  XTREG(128,512, 2, 4, 4,0x2008,0x0006,-2, 6,0x1010,pscallinc,
+            0,0,&xtensa_mask21,0,0,0)
+  XTREG(129,516, 4, 4, 4,0x2009,0x0006,-2, 6,0x1010,psowb,
+            0,0,&xtensa_mask22,0,0,0)
+  XTREG(130,520,20, 4, 4,0x200a,0x0006,-2, 6,0x1010,litbaddr,
+            0,0,&xtensa_mask23,0,0,0)
+  XTREG(131,524, 1, 4, 4,0x200b,0x0006,-2, 6,0x1010,litben,
+            0,0,&xtensa_mask24,0,0,0)
+  XTREG(132,528, 4, 4, 4,0x200e,0x0006,-2, 6,0x1010,dbnum,
+            0,0,&xtensa_mask25,0,0,0)
+  XTREG(133,532, 8, 4, 4,0x200f,0x0006,-2, 6,0x1010,asid3,
+            0,0,&xtensa_mask26,0,0,0)
+  XTREG(134,536, 8, 4, 4,0x2010,0x0006,-2, 6,0x1010,asid2,
+            0,0,&xtensa_mask27,0,0,0)
+  XTREG(135,540, 8, 4, 4,0x2011,0x0006,-2, 6,0x1010,asid1,
+            0,0,&xtensa_mask28,0,0,0)
+  XTREG(136,544, 2, 4, 4,0x2012,0x0006,-2, 6,0x1010,instpgszid4,
+            0,0,&xtensa_mask29,0,0,0)
+  XTREG(137,548, 2, 4, 4,0x2013,0x0006,-2, 6,0x1010,datapgszid4,
+            0,0,&xtensa_mask30,0,0,0)
+  XTREG(138,552,10, 4, 4,0x2014,0x0006,-2, 6,0x1010,ptbase,
+            0,0,&xtensa_mask31,0,0,0)
+  XTREG(139,556, 1, 4, 4,0x201a,0x0006, 1, 5,0x1010,ae_overflow,
+            0,0,&xtensa_mask32,0,0,0)
+  XTREG(140,560, 6, 4, 4,0x201b,0x0006, 1, 5,0x1010,ae_sar,
+            0,0,&xtensa_mask33,0,0,0)
+  XTREG(141,564, 4, 4, 4,0x201c,0x0006, 1, 5,0x1010,ae_bitptr,
+            0,0,&xtensa_mask34,0,0,0)
+  XTREG(142,568, 4, 4, 4,0x201d,0x0006, 1, 5,0x1010,ae_bitsused,
+            0,0,&xtensa_mask35,0,0,0)
+  XTREG(143,572, 4, 4, 4,0x201e,0x0006, 1, 5,0x1010,ae_tablesize,
+            0,0,&xtensa_mask36,0,0,0)
+  XTREG(144,576, 4, 4, 4,0x201f,0x0006, 1, 5,0x1010,ae_first_ts,
+            0,0,&xtensa_mask37,0,0,0)
+  XTREG(145,580,27, 4, 4,0x2020,0x0006, 1, 5,0x1010,ae_nextoffset,
+            0,0,&xtensa_mask38,0,0,0)
   XTREG_END
diff --git a/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c b/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
index 687631b8fb2f..28561147fce7 100644
--- a/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
+++ b/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
@@ -1,24 +1,26 @@
 /* Xtensa configuration-specific ISA information.
-   Copyright 2003, 2004, 2005, 2007, 2008 Free Software Foundation, Inc.
 
-   This file is part of BFD, the Binary File Descriptor library.
+   Copyright (c) 2003-2019 Tensilica Inc.
 
-   This program is free software; you can redistribute it and/or
-   modify it under the terms of the GNU General Public License as
-   published by the Free Software Foundation; either version 3 of the
-   License, or (at your option) any later version.
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
 
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   General Public License for more details.
+   The above copyright notice and this permission notice shall be included
+   in all copies or substantial portions of the Software.
 
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#include "qemu/osdep.h"
 #include "xtensa-isa.h"
 #include "xtensa-isa-internal.h"
 
@@ -32,8 +34,8 @@ static xtensa_sysreg_internal sysregs[] = {
   { "BR", 4, 0 },
   { "PTEVADDR", 83, 0 },
   { "DDR", 104, 0 },
-  { "176", 176, 0 },
-  { "208", 208, 0 },
+  { "CONFIGID0", 176, 0 },
+  { "CONFIGID1", 208, 0 },
   { "INTERRUPT", 226, 0 },
   { "INTCLEAR", 227, 0 },
   { "CCOUNT", 234, 0 },
@@ -8633,6 +8635,38 @@ Field_ae_s20_Slot_inst_set (xtensa_insnbuf insn, uint32 val)
   insn[0] = (insn[0] & ~0x700) | (tie_t << 8);
 }
 
+static unsigned
+Field_ae_fld_ohba_Slot_inst_get (const xtensa_insnbuf insn)
+{
+  unsigned tie_t = 0;
+  tie_t = (tie_t << 4) | ((insn[0] << 12) >> 28);
+  return tie_t;
+}
+
+static void
+Field_ae_fld_ohba_Slot_inst_set (xtensa_insnbuf insn, uint32 val)
+{
+  uint32 tie_t;
+  tie_t = (val << 28) >> 28;
+  insn[0] = (insn[0] & ~0xf0000) | (tie_t << 16);
+}
+
+static unsigned
+Field_ae_fld_ohba2_Slot_inst_get (const xtensa_insnbuf insn)
+{
+  unsigned tie_t = 0;
+  tie_t = (tie_t << 4) | ((insn[0] << 12) >> 28);
+  return tie_t;
+}
+
+static void
+Field_ae_fld_ohba2_Slot_inst_set (xtensa_insnbuf insn, uint32 val)
+{
+  uint32 tie_t;
+  tie_t = (val << 28) >> 28;
+  insn[0] = (insn[0] & ~0xf0000) | (tie_t << 16);
+}
+
 static unsigned
 Field_ftsf12_Slot_inst_get (const xtensa_insnbuf insn)
 {
@@ -8794,6 +8828,8 @@ enum xtensa_field_id {
   FIELD_ae_r20,
   FIELD_ae_r10,
   FIELD_ae_s20,
+  FIELD_ae_fld_ohba,
+  FIELD_ae_fld_ohba2,
   FIELD_op0_s3,
   FIELD_ftsf12,
   FIELD_ftsf13,
@@ -9184,7 +9220,7 @@ enum xtensa_interface_id {
   INTERFACE_RMPINT_In
 };
 
-
+
 /* Constant tables.  */
 
 /* constant table ai4c */
@@ -9254,596 +9290,1044 @@ static const unsigned CONST_TBL_b4cu_0[] = {
 /* Instruction operands.  */
 
 static int
-Operand_soffsetx4_decode (uint32 *valp)
+OperandSem_opnd_sem_soffsetx4_decode (uint32 *valp)
 {
-  unsigned soffsetx4_0, offset_0;
-  offset_0 = *valp & 0x3ffff;
-  soffsetx4_0 = 0x4 + ((((int) offset_0 << 14) >> 14) << 2);
-  *valp = soffsetx4_0;
+  unsigned soffsetx4_out_0;
+  unsigned soffsetx4_in_0;
+  soffsetx4_in_0 = *valp & 0x3ffff;
+  soffsetx4_out_0 = 0x4 + ((((int) soffsetx4_in_0 << 14) >> 14) << 2);
+  *valp = soffsetx4_out_0;
   return 0;
 }
 
 static int
-Operand_soffsetx4_encode (uint32 *valp)
+OperandSem_opnd_sem_soffsetx4_encode (uint32 *valp)
 {
-  unsigned offset_0, soffsetx4_0;
-  soffsetx4_0 = *valp;
-  offset_0 = ((soffsetx4_0 - 0x4) >> 2) & 0x3ffff;
-  *valp = offset_0;
+  unsigned soffsetx4_in_0;
+  unsigned soffsetx4_out_0;
+  soffsetx4_out_0 = *valp;
+  soffsetx4_in_0 = ((soffsetx4_out_0 - 0x4) >> 2) & 0x3ffff;
+  *valp = soffsetx4_in_0;
   return 0;
 }
 
 static int
-Operand_soffsetx4_ator (uint32 *valp, uint32 pc)
+OperandSem_opnd_sem_uimm12x8_decode (uint32 *valp)
 {
-  *valp -= (pc & ~0x3);
+  unsigned uimm12x8_out_0;
+  unsigned uimm12x8_in_0;
+  uimm12x8_in_0 = *valp & 0xfff;
+  uimm12x8_out_0 = uimm12x8_in_0 << 3;
+  *valp = uimm12x8_out_0;
   return 0;
 }
 
 static int
-Operand_soffsetx4_rtoa (uint32 *valp, uint32 pc)
+OperandSem_opnd_sem_uimm12x8_encode (uint32 *valp)
 {
-  *valp += (pc & ~0x3);
+  unsigned uimm12x8_in_0;
+  unsigned uimm12x8_out_0;
+  uimm12x8_out_0 = *valp;
+  uimm12x8_in_0 = ((uimm12x8_out_0 >> 3) & 0xfff);
+  *valp = uimm12x8_in_0;
   return 0;
 }
 
 static int
-Operand_uimm12x8_decode (uint32 *valp)
+OperandSem_opnd_sem_simm4_decode (uint32 *valp)
 {
-  unsigned uimm12x8_0, imm12_0;
-  imm12_0 = *valp & 0xfff;
-  uimm12x8_0 = imm12_0 << 3;
-  *valp = uimm12x8_0;
+  unsigned simm4_out_0;
+  unsigned simm4_in_0;
+  simm4_in_0 = *valp & 0xf;
+  simm4_out_0 = ((int) simm4_in_0 << 28) >> 28;
+  *valp = simm4_out_0;
   return 0;
 }
 
 static int
-Operand_uimm12x8_encode (uint32 *valp)
+OperandSem_opnd_sem_simm4_encode (uint32 *valp)
 {
-  unsigned imm12_0, uimm12x8_0;
-  uimm12x8_0 = *valp;
-  imm12_0 = ((uimm12x8_0 >> 3) & 0xfff);
-  *valp = imm12_0;
+  unsigned simm4_in_0;
+  unsigned simm4_out_0;
+  simm4_out_0 = *valp;
+  simm4_in_0 = (simm4_out_0 & 0xf);
+  *valp = simm4_in_0;
   return 0;
 }
 
 static int
-Operand_simm4_decode (uint32 *valp)
+OperandSem_opnd_sem_AR_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
-  unsigned simm4_0, mn_0;
-  mn_0 = *valp & 0xf;
-  simm4_0 = ((int) mn_0 << 28) >> 28;
-  *valp = simm4_0;
   return 0;
 }
 
 static int
-Operand_simm4_encode (uint32 *valp)
+OperandSem_opnd_sem_AR_encode (uint32 *valp)
 {
-  unsigned mn_0, simm4_0;
-  simm4_0 = *valp;
-  mn_0 = (simm4_0 & 0xf);
-  *valp = mn_0;
-  return 0;
+  int error;
+  error = (*valp >= 32);
+  return error;
 }
 
 static int
-Operand_arr_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_AR_0_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
   return 0;
 }
 
 static int
-Operand_arr_encode (uint32 *valp)
+OperandSem_opnd_sem_AR_0_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0xf) != 0;
+  error = (*valp >= 32);
   return error;
 }
 
 static int
-Operand_ars_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_AR_1_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
   return 0;
 }
 
 static int
-Operand_ars_encode (uint32 *valp)
+OperandSem_opnd_sem_AR_1_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0xf) != 0;
+  error = (*valp >= 32);
   return error;
 }
 
 static int
-Operand_art_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_AR_2_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
   return 0;
 }
 
 static int
-Operand_art_encode (uint32 *valp)
+OperandSem_opnd_sem_AR_2_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0xf) != 0;
+  error = (*valp >= 32);
   return error;
 }
 
 static int
-Operand_ar0_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_AR_3_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
   return 0;
 }
 
 static int
-Operand_ar0_encode (uint32 *valp)
+OperandSem_opnd_sem_AR_3_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0x1f) != 0;
+  error = (*valp >= 32);
   return error;
 }
 
 static int
-Operand_ar4_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_AR_4_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
   return 0;
 }
 
 static int
-Operand_ar4_encode (uint32 *valp)
+OperandSem_opnd_sem_AR_4_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0x1f) != 0;
+  error = (*valp >= 32);
   return error;
 }
 
 static int
-Operand_ar8_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_immrx4_decode (uint32 *valp)
 {
+  unsigned immrx4_out_0;
+  unsigned immrx4_in_0;
+  immrx4_in_0 = *valp & 0xf;
+  immrx4_out_0 = (((0xfffffff) << 4) | immrx4_in_0) << 2;
+  *valp = immrx4_out_0;
   return 0;
 }
 
 static int
-Operand_ar8_encode (uint32 *valp)
+OperandSem_opnd_sem_immrx4_encode (uint32 *valp)
+{
+  unsigned immrx4_in_0;
+  unsigned immrx4_out_0;
+  immrx4_out_0 = *valp;
+  immrx4_in_0 = ((immrx4_out_0 >> 2) & 0xf);
+  *valp = immrx4_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_lsi4x4_decode (uint32 *valp)
+{
+  unsigned lsi4x4_out_0;
+  unsigned lsi4x4_in_0;
+  lsi4x4_in_0 = *valp & 0xf;
+  lsi4x4_out_0 = lsi4x4_in_0 << 2;
+  *valp = lsi4x4_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_lsi4x4_encode (uint32 *valp)
+{
+  unsigned lsi4x4_in_0;
+  unsigned lsi4x4_out_0;
+  lsi4x4_out_0 = *valp;
+  lsi4x4_in_0 = ((lsi4x4_out_0 >> 2) & 0xf);
+  *valp = lsi4x4_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm7_decode (uint32 *valp)
+{
+  unsigned simm7_out_0;
+  unsigned simm7_in_0;
+  simm7_in_0 = *valp & 0x7f;
+  simm7_out_0 = ((((-((((simm7_in_0 >> 6) & 1)) & (((simm7_in_0 >> 5) & 1)))) & 0x1ffffff)) << 7) | simm7_in_0;
+  *valp = simm7_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm7_encode (uint32 *valp)
+{
+  unsigned simm7_in_0;
+  unsigned simm7_out_0;
+  simm7_out_0 = *valp;
+  simm7_in_0 = (simm7_out_0 & 0x7f);
+  *valp = simm7_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm6_decode (uint32 *valp)
+{
+  unsigned uimm6_out_0;
+  unsigned uimm6_in_0;
+  uimm6_in_0 = *valp & 0x3f;
+  uimm6_out_0 = 0x4 + (((0) << 6) | uimm6_in_0);
+  *valp = uimm6_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm6_encode (uint32 *valp)
+{
+  unsigned uimm6_in_0;
+  unsigned uimm6_out_0;
+  uimm6_out_0 = *valp;
+  uimm6_in_0 = (uimm6_out_0 - 0x4) & 0x3f;
+  *valp = uimm6_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_ai4const_decode (uint32 *valp)
+{
+  unsigned ai4const_out_0;
+  unsigned ai4const_in_0;
+  ai4const_in_0 = *valp & 0xf;
+  ai4const_out_0 = CONST_TBL_ai4c_0[ai4const_in_0 & 0xf];
+  *valp = ai4const_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_ai4const_encode (uint32 *valp)
+{
+  unsigned ai4const_in_0;
+  unsigned ai4const_out_0;
+  ai4const_out_0 = *valp;
+  switch (ai4const_out_0)
+    {
+    case 0xffffffff: ai4const_in_0 = 0; break;
+    case 0x1: ai4const_in_0 = 0x1; break;
+    case 0x2: ai4const_in_0 = 0x2; break;
+    case 0x3: ai4const_in_0 = 0x3; break;
+    case 0x4: ai4const_in_0 = 0x4; break;
+    case 0x5: ai4const_in_0 = 0x5; break;
+    case 0x6: ai4const_in_0 = 0x6; break;
+    case 0x7: ai4const_in_0 = 0x7; break;
+    case 0x8: ai4const_in_0 = 0x8; break;
+    case 0x9: ai4const_in_0 = 0x9; break;
+    case 0xa: ai4const_in_0 = 0xa; break;
+    case 0xb: ai4const_in_0 = 0xb; break;
+    case 0xc: ai4const_in_0 = 0xc; break;
+    case 0xd: ai4const_in_0 = 0xd; break;
+    case 0xe: ai4const_in_0 = 0xe; break;
+    default: ai4const_in_0 = 0xf; break;
+    }
+  *valp = ai4const_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_b4const_decode (uint32 *valp)
+{
+  unsigned b4const_out_0;
+  unsigned b4const_in_0;
+  b4const_in_0 = *valp & 0xf;
+  b4const_out_0 = CONST_TBL_b4c_0[b4const_in_0 & 0xf];
+  *valp = b4const_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_b4const_encode (uint32 *valp)
+{
+  unsigned b4const_in_0;
+  unsigned b4const_out_0;
+  b4const_out_0 = *valp;
+  switch (b4const_out_0)
+    {
+    case 0xffffffff: b4const_in_0 = 0; break;
+    case 0x1: b4const_in_0 = 0x1; break;
+    case 0x2: b4const_in_0 = 0x2; break;
+    case 0x3: b4const_in_0 = 0x3; break;
+    case 0x4: b4const_in_0 = 0x4; break;
+    case 0x5: b4const_in_0 = 0x5; break;
+    case 0x6: b4const_in_0 = 0x6; break;
+    case 0x7: b4const_in_0 = 0x7; break;
+    case 0x8: b4const_in_0 = 0x8; break;
+    case 0xa: b4const_in_0 = 0x9; break;
+    case 0xc: b4const_in_0 = 0xa; break;
+    case 0x10: b4const_in_0 = 0xb; break;
+    case 0x20: b4const_in_0 = 0xc; break;
+    case 0x40: b4const_in_0 = 0xd; break;
+    case 0x80: b4const_in_0 = 0xe; break;
+    default: b4const_in_0 = 0xf; break;
+    }
+  *valp = b4const_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_b4constu_decode (uint32 *valp)
+{
+  unsigned b4constu_out_0;
+  unsigned b4constu_in_0;
+  b4constu_in_0 = *valp & 0xf;
+  b4constu_out_0 = CONST_TBL_b4cu_0[b4constu_in_0 & 0xf];
+  *valp = b4constu_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_b4constu_encode (uint32 *valp)
+{
+  unsigned b4constu_in_0;
+  unsigned b4constu_out_0;
+  b4constu_out_0 = *valp;
+  switch (b4constu_out_0)
+    {
+    case 0x8000: b4constu_in_0 = 0; break;
+    case 0x10000: b4constu_in_0 = 0x1; break;
+    case 0x2: b4constu_in_0 = 0x2; break;
+    case 0x3: b4constu_in_0 = 0x3; break;
+    case 0x4: b4constu_in_0 = 0x4; break;
+    case 0x5: b4constu_in_0 = 0x5; break;
+    case 0x6: b4constu_in_0 = 0x6; break;
+    case 0x7: b4constu_in_0 = 0x7; break;
+    case 0x8: b4constu_in_0 = 0x8; break;
+    case 0xa: b4constu_in_0 = 0x9; break;
+    case 0xc: b4constu_in_0 = 0xa; break;
+    case 0x10: b4constu_in_0 = 0xb; break;
+    case 0x20: b4constu_in_0 = 0xc; break;
+    case 0x40: b4constu_in_0 = 0xd; break;
+    case 0x80: b4constu_in_0 = 0xe; break;
+    default: b4constu_in_0 = 0xf; break;
+    }
+  *valp = b4constu_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm8_decode (uint32 *valp)
+{
+  unsigned uimm8_out_0;
+  unsigned uimm8_in_0;
+  uimm8_in_0 = *valp & 0xff;
+  uimm8_out_0 = uimm8_in_0;
+  *valp = uimm8_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm8_encode (uint32 *valp)
+{
+  unsigned uimm8_in_0;
+  unsigned uimm8_out_0;
+  uimm8_out_0 = *valp;
+  uimm8_in_0 = (uimm8_out_0 & 0xff);
+  *valp = uimm8_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm8x2_decode (uint32 *valp)
+{
+  unsigned uimm8x2_out_0;
+  unsigned uimm8x2_in_0;
+  uimm8x2_in_0 = *valp & 0xff;
+  uimm8x2_out_0 = uimm8x2_in_0 << 1;
+  *valp = uimm8x2_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm8x2_encode (uint32 *valp)
+{
+  unsigned uimm8x2_in_0;
+  unsigned uimm8x2_out_0;
+  uimm8x2_out_0 = *valp;
+  uimm8x2_in_0 = ((uimm8x2_out_0 >> 1) & 0xff);
+  *valp = uimm8x2_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm8x4_decode (uint32 *valp)
+{
+  unsigned uimm8x4_out_0;
+  unsigned uimm8x4_in_0;
+  uimm8x4_in_0 = *valp & 0xff;
+  uimm8x4_out_0 = uimm8x4_in_0 << 2;
+  *valp = uimm8x4_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm8x4_encode (uint32 *valp)
+{
+  unsigned uimm8x4_in_0;
+  unsigned uimm8x4_out_0;
+  uimm8x4_out_0 = *valp;
+  uimm8x4_in_0 = ((uimm8x4_out_0 >> 2) & 0xff);
+  *valp = uimm8x4_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm4x16_decode (uint32 *valp)
+{
+  unsigned uimm4x16_out_0;
+  unsigned uimm4x16_in_0;
+  uimm4x16_in_0 = *valp & 0xf;
+  uimm4x16_out_0 = uimm4x16_in_0 << 4;
+  *valp = uimm4x16_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm4x16_encode (uint32 *valp)
+{
+  unsigned uimm4x16_in_0;
+  unsigned uimm4x16_out_0;
+  uimm4x16_out_0 = *valp;
+  uimm4x16_in_0 = ((uimm4x16_out_0 >> 4) & 0xf);
+  *valp = uimm4x16_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm8_decode (uint32 *valp)
+{
+  unsigned simm8_out_0;
+  unsigned simm8_in_0;
+  simm8_in_0 = *valp & 0xff;
+  simm8_out_0 = ((int) simm8_in_0 << 24) >> 24;
+  *valp = simm8_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm8_encode (uint32 *valp)
+{
+  unsigned simm8_in_0;
+  unsigned simm8_out_0;
+  simm8_out_0 = *valp;
+  simm8_in_0 = (simm8_out_0 & 0xff);
+  *valp = simm8_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm8x256_decode (uint32 *valp)
+{
+  unsigned simm8x256_out_0;
+  unsigned simm8x256_in_0;
+  simm8x256_in_0 = *valp & 0xff;
+  simm8x256_out_0 = (((int) simm8x256_in_0 << 24) >> 24) << 8;
+  *valp = simm8x256_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm8x256_encode (uint32 *valp)
+{
+  unsigned simm8x256_in_0;
+  unsigned simm8x256_out_0;
+  simm8x256_out_0 = *valp;
+  simm8x256_in_0 = ((simm8x256_out_0 >> 8) & 0xff);
+  *valp = simm8x256_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm12b_decode (uint32 *valp)
+{
+  unsigned simm12b_out_0;
+  unsigned simm12b_in_0;
+  simm12b_in_0 = *valp & 0xfff;
+  simm12b_out_0 = ((int) simm12b_in_0 << 20) >> 20;
+  *valp = simm12b_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_simm12b_encode (uint32 *valp)
+{
+  unsigned simm12b_in_0;
+  unsigned simm12b_out_0;
+  simm12b_out_0 = *valp;
+  simm12b_in_0 = (simm12b_out_0 & 0xfff);
+  *valp = simm12b_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_msalp32_decode (uint32 *valp)
+{
+  unsigned msalp32_out_0;
+  unsigned msalp32_in_0;
+  msalp32_in_0 = *valp & 0x1f;
+  msalp32_out_0 = 0x20 - msalp32_in_0;
+  *valp = msalp32_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_msalp32_encode (uint32 *valp)
+{
+  unsigned msalp32_in_0;
+  unsigned msalp32_out_0;
+  msalp32_out_0 = *valp;
+  msalp32_in_0 = (0x20 - msalp32_out_0) & 0x1f;
+  *valp = msalp32_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_op2p1_decode (uint32 *valp)
+{
+  unsigned op2p1_out_0;
+  unsigned op2p1_in_0;
+  op2p1_in_0 = *valp & 0xf;
+  op2p1_out_0 = op2p1_in_0 + 0x1;
+  *valp = op2p1_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_op2p1_encode (uint32 *valp)
+{
+  unsigned op2p1_in_0;
+  unsigned op2p1_out_0;
+  op2p1_out_0 = *valp;
+  op2p1_in_0 = (op2p1_out_0 - 0x1) & 0xf;
+  *valp = op2p1_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_label8_decode (uint32 *valp)
+{
+  unsigned label8_out_0;
+  unsigned label8_in_0;
+  label8_in_0 = *valp & 0xff;
+  label8_out_0 = 0x4 + (((int) label8_in_0 << 24) >> 24);
+  *valp = label8_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_label8_encode (uint32 *valp)
+{
+  unsigned label8_in_0;
+  unsigned label8_out_0;
+  label8_out_0 = *valp;
+  label8_in_0 = (label8_out_0 - 0x4) & 0xff;
+  *valp = label8_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_ulabel8_decode (uint32 *valp)
+{
+  unsigned ulabel8_out_0;
+  unsigned ulabel8_in_0;
+  ulabel8_in_0 = *valp & 0xff;
+  ulabel8_out_0 = 0x4 + (((0) << 8) | ulabel8_in_0);
+  *valp = ulabel8_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_ulabel8_encode (uint32 *valp)
+{
+  unsigned ulabel8_in_0;
+  unsigned ulabel8_out_0;
+  ulabel8_out_0 = *valp;
+  ulabel8_in_0 = (ulabel8_out_0 - 0x4) & 0xff;
+  *valp = ulabel8_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_label12_decode (uint32 *valp)
+{
+  unsigned label12_out_0;
+  unsigned label12_in_0;
+  label12_in_0 = *valp & 0xfff;
+  label12_out_0 = 0x4 + (((int) label12_in_0 << 20) >> 20);
+  *valp = label12_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_label12_encode (uint32 *valp)
+{
+  unsigned label12_in_0;
+  unsigned label12_out_0;
+  label12_out_0 = *valp;
+  label12_in_0 = (label12_out_0 - 0x4) & 0xfff;
+  *valp = label12_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_soffset_decode (uint32 *valp)
+{
+  unsigned soffset_out_0;
+  unsigned soffset_in_0;
+  soffset_in_0 = *valp & 0x3ffff;
+  soffset_out_0 = 0x4 + (((int) soffset_in_0 << 14) >> 14);
+  *valp = soffset_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_soffset_encode (uint32 *valp)
+{
+  unsigned soffset_in_0;
+  unsigned soffset_out_0;
+  soffset_out_0 = *valp;
+  soffset_in_0 = (soffset_out_0 - 0x4) & 0x3ffff;
+  *valp = soffset_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm16x4_decode (uint32 *valp)
+{
+  unsigned uimm16x4_out_0;
+  unsigned uimm16x4_in_0;
+  uimm16x4_in_0 = *valp & 0xffff;
+  uimm16x4_out_0 = (((0xffff) << 16) | uimm16x4_in_0) << 2;
+  *valp = uimm16x4_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_uimm16x4_encode (uint32 *valp)
+{
+  unsigned uimm16x4_in_0;
+  unsigned uimm16x4_out_0;
+  uimm16x4_out_0 = *valp;
+  uimm16x4_in_0 = (uimm16x4_out_0 >> 2) & 0xffff;
+  *valp = uimm16x4_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_bbi_decode (uint32 *valp)
+{
+  unsigned bbi_out_0;
+  unsigned bbi_in_0;
+  bbi_in_0 = *valp & 0x1f;
+  bbi_out_0 = (0 << 5) | bbi_in_0;
+  *valp = bbi_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_bbi_encode (uint32 *valp)
+{
+  unsigned bbi_in_0;
+  unsigned bbi_out_0;
+  bbi_out_0 = *valp;
+  bbi_in_0 = (bbi_out_0 & 0x1f);
+  *valp = bbi_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_s_decode (uint32 *valp)
+{
+  unsigned s_out_0;
+  unsigned s_in_0;
+  s_in_0 = *valp & 0xf;
+  s_out_0 = (0 << 4) | s_in_0;
+  *valp = s_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_s_encode (uint32 *valp)
+{
+  unsigned s_in_0;
+  unsigned s_out_0;
+  s_out_0 = *valp;
+  s_in_0 = (s_out_0 & 0xf);
+  *valp = s_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_immt_decode (uint32 *valp)
+{
+  unsigned immt_out_0;
+  unsigned immt_in_0;
+  immt_in_0 = *valp & 0xf;
+  immt_out_0 = immt_in_0;
+  *valp = immt_out_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_immt_encode (uint32 *valp)
+{
+  unsigned immt_in_0;
+  unsigned immt_out_0;
+  immt_out_0 = *valp;
+  immt_in_0 = immt_out_0 & 0xf;
+  *valp = immt_in_0;
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_BR_decode (uint32 *valp ATTRIBUTE_UNUSED)
+{
+  return 0;
+}
+
+static int
+OperandSem_opnd_sem_BR_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0x1f) != 0;
+  error = (*valp >= 16);
   return error;
 }
 
 static int
-Operand_ar12_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_BR2_decode (uint32 *valp)
 {
+  *valp = *valp << 1;
   return 0;
 }
 
 static int
-Operand_ar12_encode (uint32 *valp)
+OperandSem_opnd_sem_BR2_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0x1f) != 0;
+  error = (*valp >= 16) || ((*valp & 1) != 0);
+  *valp = *valp >> 1;
   return error;
 }
 
 static int
-Operand_ars_entry_decode (uint32 *valp ATTRIBUTE_UNUSED)
+OperandSem_opnd_sem_BR4_decode (uint32 *valp)
 {
+  *valp = *valp << 2;
   return 0;
 }
 
 static int
-Operand_ars_entry_encode (uint32 *valp)
+OperandSem_opnd_sem_BR4_encode (uint32 *valp)
 {
   int error;
-  error = (*valp & ~0x1f) != 0;
+  error = (*valp >= 16) || ((*valp & 3) != 0);
+  *valp = *valp >> 2;
   return error;
 }
 
 static int
-Operand_immrx4_decode (uint32 *valp)
+OperandSem_opnd_sem_BR8_decode (uint32 *valp)
 {
-  unsigned immrx4_0, r_0;
-  r_0 = *valp & 0xf;
-  immrx4_0 = (((0xfffffff) << 4) | r_0) << 2;
-  *valp = immrx4_0;
+  *valp = *valp << 3;
   return 0;
 }
 
 static int
-Operand_immrx4_encode (uint32 *valp)
+OperandSem_opnd_sem_BR8_encode (uint32 *valp)
 {
-  unsigned r_0, immrx4_0;
-  immrx4_0 = *valp;
-  r_0 = ((immrx4_0 >> 2) & 0xf);
-  *valp = r_0;
-  return 0;
+  int error;
+  error = (*valp >= 16) || ((*valp & 7) != 0);
+  *valp = *valp >> 3;
+  return error;
 }
 
 static int
-Operand_lsi4x4_decode (uint32 *valp)
+OperandSem_opnd_sem_BR16_decode (uint32 *valp)
 {
-  unsigned lsi4x4_0, r_0;
-  r_0 = *valp & 0xf;
-  lsi4x4_0 = r_0 << 2;
-  *valp = lsi4x4_0;
+  *valp = *valp << 4;
   return 0;
 }
 
 static int
-Operand_lsi4x4_encode (uint32 *valp)
+OperandSem_opnd_sem_BR16_encode (uint32 *valp)
 {
-  unsigned r_0, lsi4x4_0;
-  lsi4x4_0 = *valp;
-  r_0 = ((lsi4x4_0 >> 2) & 0xf);
-  *valp = r_0;
-  return 0;
+  int error;
+  error = (*valp >= 16) || ((*valp & 15) != 0);
+  *valp = *valp >> 4;
+  return error;
 }
 
 static int
-Operand_simm7_decode (uint32 *valp)
+OperandSem_opnd_sem_tp7_decode (uint32 *valp)
 {
-  unsigned simm7_0, imm7_0;
-  imm7_0 = *valp & 0x7f;
-  simm7_0 = ((((-((((imm7_0 >> 6) & 1)) & (((imm7_0 >> 5) & 1)))) & 0x1ffffff)) << 7) | imm7_0;
-  *valp = simm7_0;
+  unsigned tp7_out_0;
+  unsigned tp7_in_0;
+  tp7_in_0 = *valp & 0xf;
+  tp7_out_0 = tp7_in_0 + 0x7;
+  *valp = tp7_out_0;
   return 0;
 }
 
 static int
-Operand_simm7_encode (uint32 *valp)
+OperandSem_opnd_sem_tp7_encode (uint32 *valp)
 {
-  unsigned imm7_0, simm7_0;
-  simm7_0 = *valp;
-  imm7_0 = (simm7_0 & 0x7f);
-  *valp = imm7_0;
+  unsigned tp7_in_0;
+  unsigned tp7_out_0;
+  tp7_out_0 = *valp;
+  tp7_in_0 = (tp7_out_0 - 0x7) & 0xf;
+  *valp = tp7_in_0;
   return 0;
 }
 
 static int
-Operand_uimm6_decode (uint32 *valp)
+OperandSem_opnd_sem_xt_wbr15_label_decode (uint32 *valp)
 {
-  unsigned uimm6_0, imm6_0;
-  imm6_0 = *valp & 0x3f;
-  uimm6_0 = 0x4 + (((0) << 6) | imm6_0);
-  *valp = uimm6_0;
+  unsigned xt_wbr15_label_out_0;
+  unsigned xt_wbr15_label_in_0;
+  xt_wbr15_label_in_0 = *valp & 0x7fff;
+  xt_wbr15_label_out_0 = 0x4 + (((int) xt_wbr15_label_in_0 << 17) >> 17);
+  *valp = xt_wbr15_label_out_0;
   return 0;
 }
 
 static int
-Operand_uimm6_encode (uint32 *valp)
+OperandSem_opnd_sem_xt_wbr15_label_encode (uint32 *valp)
 {
-  unsigned imm6_0, uimm6_0;
-  uimm6_0 = *valp;
-  imm6_0 = (uimm6_0 - 0x4) & 0x3f;
-  *valp = imm6_0;
+  unsigned xt_wbr15_label_in_0;
+  unsigned xt_wbr15_label_out_0;
+  xt_wbr15_label_out_0 = *valp;
+  xt_wbr15_label_in_0 = (xt_wbr15_label_out_0 - 0x4) & 0x7fff;
+  *valp = xt_wbr15_label_in_0;
   return 0;
 }
 
 static int
-Operand_uimm6_ator (uint32 *valp, uint32 pc)
+OperandSem_opnd_sem_ae_samt32_decode (uint32 *valp)
 {
-  *valp -= pc;
+  unsigned ae_samt32_out_0;
+  unsigned ae_samt32_in_0;
+  ae_samt32_in_0 = *valp & 0x1f;
+  ae_samt32_out_0 = (0 << 5) | ae_samt32_in_0;
+  *valp = ae_samt32_out_0;
   return 0;
 }
 
 static int
-Operand_uimm6_rtoa (uint32 *valp, uint32 pc)
+OperandSem_opnd_sem_ae_samt32_encode (uint32 *valp)
 {
-  *valp += pc;
+  unsigned ae_samt32_in_0;
+  unsigned ae_samt32_out_0;
+  ae_samt32_out_0 = *valp;
+  ae_samt32_in_0 = (ae_samt32_out_0 & 0x1f);
+  *valp = ae_samt32_in_0;
   return 0;
 }
 
 static int
-Operand_ai4const_decode (uint32 *valp)
+OperandSem_opnd_sem_AE_PR_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
-  unsigned ai4const_0, t_0;
-  t_0 = *valp & 0xf;
-  ai4const_0 = CONST_TBL_ai4c_0[t_0 & 0xf];
-  *valp = ai4const_0;
   return 0;
 }
 
 static int
-Operand_ai4const_encode (uint32 *valp)
+OperandSem_opnd_sem_AE_PR_encode (uint32 *valp)
 {
-  unsigned t_0, ai4const_0;
-  ai4const_0 = *valp;
-  switch (ai4const_0)
-    {
-    case 0xffffffff: t_0 = 0; break;
-    case 0x1: t_0 = 0x1; break;
-    case 0x2: t_0 = 0x2; break;
-    case 0x3: t_0 = 0x3; break;
-    case 0x4: t_0 = 0x4; break;
-    case 0x5: t_0 = 0x5; break;
-    case 0x6: t_0 = 0x6; break;
-    case 0x7: t_0 = 0x7; break;
-    case 0x8: t_0 = 0x8; break;
-    case 0x9: t_0 = 0x9; break;
-    case 0xa: t_0 = 0xa; break;
-    case 0xb: t_0 = 0xb; break;
-    case 0xc: t_0 = 0xc; break;
-    case 0xd: t_0 = 0xd; break;
-    case 0xe: t_0 = 0xe; break;
-    default: t_0 = 0xf; break;
-    }
-  *valp = t_0;
-  return 0;
-}
-
-static int
-Operand_b4const_decode (uint32 *valp)
-{
-  unsigned b4const_0, r_0;
-  r_0 = *valp & 0xf;
-  b4const_0 = CONST_TBL_b4c_0[r_0 & 0xf];
-  *valp = b4const_0;
-  return 0;
-}
-
-static int
-Operand_b4const_encode (uint32 *valp)
-{
-  unsigned r_0, b4const_0;
-  b4const_0 = *valp;
-  switch (b4const_0)
-    {
-    case 0xffffffff: r_0 = 0; break;
-    case 0x1: r_0 = 0x1; break;
-    case 0x2: r_0 = 0x2; break;
-    case 0x3: r_0 = 0x3; break;
-    case 0x4: r_0 = 0x4; break;
-    case 0x5: r_0 = 0x5; break;
-    case 0x6: r_0 = 0x6; break;
-    case 0x7: r_0 = 0x7; break;
-    case 0x8: r_0 = 0x8; break;
-    case 0xa: r_0 = 0x9; break;
-    case 0xc: r_0 = 0xa; break;
-    case 0x10: r_0 = 0xb; break;
-    case 0x20: r_0 = 0xc; break;
-    case 0x40: r_0 = 0xd; break;
-    case 0x80: r_0 = 0xe; break;
-    default: r_0 = 0xf; break;
-    }
-  *valp = r_0;
-  return 0;
-}
-
-static int
-Operand_b4constu_decode (uint32 *valp)
-{
-  unsigned b4constu_0, r_0;
-  r_0 = *valp & 0xf;
-  b4constu_0 = CONST_TBL_b4cu_0[r_0 & 0xf];
-  *valp = b4constu_0;
-  return 0;
-}
-
-static int
-Operand_b4constu_encode (uint32 *valp)
-{
-  unsigned r_0, b4constu_0;
-  b4constu_0 = *valp;
-  switch (b4constu_0)
-    {
-    case 0x8000: r_0 = 0; break;
-    case 0x10000: r_0 = 0x1; break;
-    case 0x2: r_0 = 0x2; break;
-    case 0x3: r_0 = 0x3; break;
-    case 0x4: r_0 = 0x4; break;
-    case 0x5: r_0 = 0x5; break;
-    case 0x6: r_0 = 0x6; break;
-    case 0x7: r_0 = 0x7; break;
-    case 0x8: r_0 = 0x8; break;
-    case 0xa: r_0 = 0x9; break;
-    case 0xc: r_0 = 0xa; break;
-    case 0x10: r_0 = 0xb; break;
-    case 0x20: r_0 = 0xc; break;
-    case 0x40: r_0 = 0xd; break;
-    case 0x80: r_0 = 0xe; break;
-    default: r_0 = 0xf; break;
-    }
-  *valp = r_0;
-  return 0;
-}
-
-static int
-Operand_uimm8_decode (uint32 *valp)
-{
-  unsigned uimm8_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  uimm8_0 = imm8_0;
-  *valp = uimm8_0;
-  return 0;
-}
-
-static int
-Operand_uimm8_encode (uint32 *valp)
-{
-  unsigned imm8_0, uimm8_0;
-  uimm8_0 = *valp;
-  imm8_0 = (uimm8_0 & 0xff);
-  *valp = imm8_0;
-  return 0;
-}
-
-static int
-Operand_uimm8x2_decode (uint32 *valp)
-{
-  unsigned uimm8x2_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  uimm8x2_0 = imm8_0 << 1;
-  *valp = uimm8x2_0;
-  return 0;
-}
-
-static int
-Operand_uimm8x2_encode (uint32 *valp)
-{
-  unsigned imm8_0, uimm8x2_0;
-  uimm8x2_0 = *valp;
-  imm8_0 = ((uimm8x2_0 >> 1) & 0xff);
-  *valp = imm8_0;
-  return 0;
+  int error;
+  error = (*valp >= 8);
+  return error;
 }
 
 static int
-Operand_uimm8x4_decode (uint32 *valp)
+OperandSem_opnd_sem_AE_QR_decode (uint32 *valp ATTRIBUTE_UNUSED)
 {
-  unsigned uimm8x4_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  uimm8x4_0 = imm8_0 << 2;
-  *valp = uimm8x4_0;
   return 0;
 }
 
 static int
-Operand_uimm8x4_encode (uint32 *valp)
+OperandSem_opnd_sem_AE_QR_encode (uint32 *valp)
 {
-  unsigned imm8_0, uimm8x4_0;
-  uimm8x4_0 = *valp;
-  imm8_0 = ((uimm8x4_0 >> 2) & 0xff);
-  *valp = imm8_0;
-  return 0;
+  int error;
+  error = (*valp >= 4);
+  return error;
 }
 
 static int
-Operand_uimm4x16_decode (uint32 *valp)
+OperandSem_opnd_sem_ae_lsimm16_decode (uint32 *valp)
 {
-  unsigned uimm4x16_0, op2_0;
-  op2_0 = *valp & 0xf;
-  uimm4x16_0 = op2_0 << 4;
-  *valp = uimm4x16_0;
+  unsigned ae_lsimm16_out_0;
+  unsigned ae_lsimm16_in_0;
+  ae_lsimm16_in_0 = *valp & 0xf;
+  ae_lsimm16_out_0 = (((int) ae_lsimm16_in_0 << 28) >> 28) << 1;
+  *valp = ae_lsimm16_out_0;
   return 0;
 }
 
 static int
-Operand_uimm4x16_encode (uint32 *valp)
+OperandSem_opnd_sem_ae_lsimm16_encode (uint32 *valp)
 {
-  unsigned op2_0, uimm4x16_0;
-  uimm4x16_0 = *valp;
-  op2_0 = ((uimm4x16_0 >> 4) & 0xf);
-  *valp = op2_0;
+  unsigned ae_lsimm16_in_0;
+  unsigned ae_lsimm16_out_0;
+  ae_lsimm16_out_0 = *valp;
+  ae_lsimm16_in_0 = ((ae_lsimm16_out_0 >> 1) & 0xf);
+  *valp = ae_lsimm16_in_0;
   return 0;
 }
 
 static int
-Operand_simm8_decode (uint32 *valp)
+OperandSem_opnd_sem_ae_lsimm32_decode (uint32 *valp)
 {
-  unsigned simm8_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  simm8_0 = ((int) imm8_0 << 24) >> 24;
-  *valp = simm8_0;
+  unsigned ae_lsimm32_out_0;
+  unsigned ae_lsimm32_in_0;
+  ae_lsimm32_in_0 = *valp & 0xf;
+  ae_lsimm32_out_0 = (((int) ae_lsimm32_in_0 << 28) >> 28) << 2;
+  *valp = ae_lsimm32_out_0;
   return 0;
 }
 
 static int
-Operand_simm8_encode (uint32 *valp)
+OperandSem_opnd_sem_ae_lsimm32_encode (uint32 *valp)
 {
-  unsigned imm8_0, simm8_0;
-  simm8_0 = *valp;
-  imm8_0 = (simm8_0 & 0xff);
-  *valp = imm8_0;
+  unsigned ae_lsimm32_in_0;
+  unsigned ae_lsimm32_out_0;
+  ae_lsimm32_out_0 = *valp;
+  ae_lsimm32_in_0 = ((ae_lsimm32_out_0 >> 2) & 0xf);
+  *valp = ae_lsimm32_in_0;
   return 0;
 }
 
 static int
-Operand_simm8x256_decode (uint32 *valp)
+OperandSem_opnd_sem_ae_lsimm64_decode (uint32 *valp)
 {
-  unsigned simm8x256_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  simm8x256_0 = (((int) imm8_0 << 24) >> 24) << 8;
-  *valp = simm8x256_0;
+  unsigned ae_lsimm64_out_0;
+  unsigned ae_lsimm64_in_0;
+  ae_lsimm64_in_0 = *valp & 0xf;
+  ae_lsimm64_out_0 = (((int) ae_lsimm64_in_0 << 28) >> 28) << 3;
+  *valp = ae_lsimm64_out_0;
   return 0;
 }
 
 static int
-Operand_simm8x256_encode (uint32 *valp)
+OperandSem_opnd_sem_ae_lsimm64_encode (uint32 *valp)
 {
-  unsigned imm8_0, simm8x256_0;
-  simm8x256_0 = *valp;
-  imm8_0 = ((simm8x256_0 >> 8) & 0xff);
-  *valp = imm8_0;
+  unsigned ae_lsimm64_in_0;
+  unsigned ae_lsimm64_out_0;
+  ae_lsimm64_out_0 = *valp;
+  ae_lsimm64_in_0 = ((ae_lsimm64_out_0 >> 3) & 0xf);
+  *valp = ae_lsimm64_in_0;
   return 0;
 }
 
 static int
-Operand_simm12b_decode (uint32 *valp)
+OperandSem_opnd_sem_ae_samt64_decode (uint32 *valp)
 {
-  unsigned simm12b_0, imm12b_0;
-  imm12b_0 = *valp & 0xfff;
-  simm12b_0 = ((int) imm12b_0 << 20) >> 20;
-  *valp = simm12b_0;
+  unsigned ae_samt64_out_0;
+  unsigned ae_samt64_in_0;
+  ae_samt64_in_0 = *valp & 0x3f;
+  ae_samt64_out_0 = (0 << 6) | ae_samt64_in_0;
+  *valp = ae_samt64_out_0;
   return 0;
 }
 
 static int
-Operand_simm12b_encode (uint32 *valp)
+OperandSem_opnd_sem_ae_samt64_encode (uint32 *valp)
 {
-  unsigned imm12b_0, simm12b_0;
-  simm12b_0 = *valp;
-  imm12b_0 = (simm12b_0 & 0xfff);
-  *valp = imm12b_0;
+  unsigned ae_samt64_in_0;
+  unsigned ae_samt64_out_0;
+  ae_samt64_out_0 = *valp;
+  ae_samt64_in_0 = (ae_samt64_out_0 & 0x3f);
+  *valp = ae_samt64_in_0;
   return 0;
 }
 
 static int
-Operand_msalp32_decode (uint32 *valp)
+OperandSem_opnd_sem_ae_ohba_decode (uint32 *valp)
 {
-  unsigned msalp32_0, sal_0;
-  sal_0 = *valp & 0x1f;
-  msalp32_0 = 0x20 - sal_0;
-  *valp = msalp32_0;
+  unsigned ae_ohba_out_0;
+  unsigned ae_ohba_in_0;
+  ae_ohba_in_0 = *valp & 0xf;
+  ae_ohba_out_0 = (0 << 5) | (((((ae_ohba_in_0 & 0xf))) == 0) << 4) | ((ae_ohba_in_0 & 0xf));
+  *valp = ae_ohba_out_0;
   return 0;
 }
 
 static int
-Operand_msalp32_encode (uint32 *valp)
+OperandSem_opnd_sem_ae_ohba_encode (uint32 *valp)
 {
-  unsigned sal_0, msalp32_0;
-  msalp32_0 = *valp;
-  sal_0 = (0x20 - msalp32_0) & 0x1f;
-  *valp = sal_0;
+  unsigned ae_ohba_in_0;
+  unsigned ae_ohba_out_0;
+  ae_ohba_out_0 = *valp;
+  ae_ohba_in_0 = (ae_ohba_out_0 & 0xf);
+  *valp = ae_ohba_in_0;
   return 0;
 }
 
 static int
-Operand_op2p1_decode (uint32 *valp)
+Operand_soffsetx4_ator (uint32 *valp, uint32 pc)
 {
-  unsigned op2p1_0, op2_0;
-  op2_0 = *valp & 0xf;
-  op2p1_0 = op2_0 + 0x1;
-  *valp = op2p1_0;
+  *valp -= (pc & ~0x3);
   return 0;
 }
 
 static int
-Operand_op2p1_encode (uint32 *valp)
+Operand_soffsetx4_rtoa (uint32 *valp, uint32 pc)
 {
-  unsigned op2_0, op2p1_0;
-  op2p1_0 = *valp;
-  op2_0 = (op2p1_0 - 0x1) & 0xf;
-  *valp = op2_0;
+  *valp += (pc & ~0x3);
   return 0;
 }
 
 static int
-Operand_label8_decode (uint32 *valp)
+Operand_uimm6_ator (uint32 *valp, uint32 pc)
 {
-  unsigned label8_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  label8_0 = 0x4 + (((int) imm8_0 << 24) >> 24);
-  *valp = label8_0;
+  *valp -= pc;
   return 0;
 }
 
 static int
-Operand_label8_encode (uint32 *valp)
+Operand_uimm6_rtoa (uint32 *valp, uint32 pc)
 {
-  unsigned imm8_0, label8_0;
-  label8_0 = *valp;
-  imm8_0 = (label8_0 - 0x4) & 0xff;
-  *valp = imm8_0;
+  *valp += pc;
   return 0;
 }
 
@@ -9861,26 +10345,6 @@ Operand_label8_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_ulabel8_decode (uint32 *valp)
-{
-  unsigned ulabel8_0, imm8_0;
-  imm8_0 = *valp & 0xff;
-  ulabel8_0 = 0x4 + (((0) << 8) | imm8_0);
-  *valp = ulabel8_0;
-  return 0;
-}
-
-static int
-Operand_ulabel8_encode (uint32 *valp)
-{
-  unsigned imm8_0, ulabel8_0;
-  ulabel8_0 = *valp;
-  imm8_0 = (ulabel8_0 - 0x4) & 0xff;
-  *valp = imm8_0;
-  return 0;
-}
-
 static int
 Operand_ulabel8_ator (uint32 *valp, uint32 pc)
 {
@@ -9895,26 +10359,6 @@ Operand_ulabel8_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_label12_decode (uint32 *valp)
-{
-  unsigned label12_0, imm12_0;
-  imm12_0 = *valp & 0xfff;
-  label12_0 = 0x4 + (((int) imm12_0 << 20) >> 20);
-  *valp = label12_0;
-  return 0;
-}
-
-static int
-Operand_label12_encode (uint32 *valp)
-{
-  unsigned imm12_0, label12_0;
-  label12_0 = *valp;
-  imm12_0 = (label12_0 - 0x4) & 0xfff;
-  *valp = imm12_0;
-  return 0;
-}
-
 static int
 Operand_label12_ator (uint32 *valp, uint32 pc)
 {
@@ -9929,26 +10373,6 @@ Operand_label12_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_soffset_decode (uint32 *valp)
-{
-  unsigned soffset_0, offset_0;
-  offset_0 = *valp & 0x3ffff;
-  soffset_0 = 0x4 + (((int) offset_0 << 14) >> 14);
-  *valp = soffset_0;
-  return 0;
-}
-
-static int
-Operand_soffset_encode (uint32 *valp)
-{
-  unsigned offset_0, soffset_0;
-  soffset_0 = *valp;
-  offset_0 = (soffset_0 - 0x4) & 0x3ffff;
-  *valp = offset_0;
-  return 0;
-}
-
 static int
 Operand_soffset_ator (uint32 *valp, uint32 pc)
 {
@@ -9963,26 +10387,6 @@ Operand_soffset_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_uimm16x4_decode (uint32 *valp)
-{
-  unsigned uimm16x4_0, imm16_0;
-  imm16_0 = *valp & 0xffff;
-  uimm16x4_0 = (((0xffff) << 16) | imm16_0) << 2;
-  *valp = uimm16x4_0;
-  return 0;
-}
-
-static int
-Operand_uimm16x4_encode (uint32 *valp)
-{
-  unsigned imm16_0, uimm16x4_0;
-  uimm16x4_0 = *valp;
-  imm16_0 = (uimm16x4_0 >> 2) & 0xffff;
-  *valp = imm16_0;
-  return 0;
-}
-
 static int
 Operand_uimm16x4_ator (uint32 *valp, uint32 pc)
 {
@@ -9997,336 +10401,6 @@ Operand_uimm16x4_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_immt_decode (uint32 *valp)
-{
-  unsigned immt_0, t_0;
-  t_0 = *valp & 0xf;
-  immt_0 = t_0;
-  *valp = immt_0;
-  return 0;
-}
-
-static int
-Operand_immt_encode (uint32 *valp)
-{
-  unsigned t_0, immt_0;
-  immt_0 = *valp;
-  t_0 = immt_0 & 0xf;
-  *valp = t_0;
-  return 0;
-}
-
-static int
-Operand_imms_decode (uint32 *valp)
-{
-  unsigned imms_0, s_0;
-  s_0 = *valp & 0xf;
-  imms_0 = s_0;
-  *valp = imms_0;
-  return 0;
-}
-
-static int
-Operand_imms_encode (uint32 *valp)
-{
-  unsigned s_0, imms_0;
-  imms_0 = *valp;
-  s_0 = imms_0 & 0xf;
-  *valp = s_0;
-  return 0;
-}
-
-static int
-Operand_bt_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_bt_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0xf) != 0;
-  return error;
-}
-
-static int
-Operand_bs_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_bs_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0xf) != 0;
-  return error;
-}
-
-static int
-Operand_br_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_br_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0xf) != 0;
-  return error;
-}
-
-static int
-Operand_bt2_decode (uint32 *valp)
-{
-  *valp = *valp << 1;
-  return 0;
-}
-
-static int
-Operand_bt2_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x7 << 1)) != 0;
-  *valp = *valp >> 1;
-  return error;
-}
-
-static int
-Operand_bs2_decode (uint32 *valp)
-{
-  *valp = *valp << 1;
-  return 0;
-}
-
-static int
-Operand_bs2_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x7 << 1)) != 0;
-  *valp = *valp >> 1;
-  return error;
-}
-
-static int
-Operand_br2_decode (uint32 *valp)
-{
-  *valp = *valp << 1;
-  return 0;
-}
-
-static int
-Operand_br2_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x7 << 1)) != 0;
-  *valp = *valp >> 1;
-  return error;
-}
-
-static int
-Operand_bt4_decode (uint32 *valp)
-{
-  *valp = *valp << 2;
-  return 0;
-}
-
-static int
-Operand_bt4_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x3 << 2)) != 0;
-  *valp = *valp >> 2;
-  return error;
-}
-
-static int
-Operand_bs4_decode (uint32 *valp)
-{
-  *valp = *valp << 2;
-  return 0;
-}
-
-static int
-Operand_bs4_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x3 << 2)) != 0;
-  *valp = *valp >> 2;
-  return error;
-}
-
-static int
-Operand_br4_decode (uint32 *valp)
-{
-  *valp = *valp << 2;
-  return 0;
-}
-
-static int
-Operand_br4_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x3 << 2)) != 0;
-  *valp = *valp >> 2;
-  return error;
-}
-
-static int
-Operand_bt8_decode (uint32 *valp)
-{
-  *valp = *valp << 3;
-  return 0;
-}
-
-static int
-Operand_bt8_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x1 << 3)) != 0;
-  *valp = *valp >> 3;
-  return error;
-}
-
-static int
-Operand_bs8_decode (uint32 *valp)
-{
-  *valp = *valp << 3;
-  return 0;
-}
-
-static int
-Operand_bs8_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x1 << 3)) != 0;
-  *valp = *valp >> 3;
-  return error;
-}
-
-static int
-Operand_br8_decode (uint32 *valp)
-{
-  *valp = *valp << 3;
-  return 0;
-}
-
-static int
-Operand_br8_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0x1 << 3)) != 0;
-  *valp = *valp >> 3;
-  return error;
-}
-
-static int
-Operand_bt16_decode (uint32 *valp)
-{
-  *valp = *valp << 4;
-  return 0;
-}
-
-static int
-Operand_bt16_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0 << 4)) != 0;
-  *valp = *valp >> 4;
-  return error;
-}
-
-static int
-Operand_bs16_decode (uint32 *valp)
-{
-  *valp = *valp << 4;
-  return 0;
-}
-
-static int
-Operand_bs16_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0 << 4)) != 0;
-  *valp = *valp >> 4;
-  return error;
-}
-
-static int
-Operand_br16_decode (uint32 *valp)
-{
-  *valp = *valp << 4;
-  return 0;
-}
-
-static int
-Operand_br16_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0 << 4)) != 0;
-  *valp = *valp >> 4;
-  return error;
-}
-
-static int
-Operand_brall_decode (uint32 *valp)
-{
-  *valp = *valp << 4;
-  return 0;
-}
-
-static int
-Operand_brall_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~(0 << 4)) != 0;
-  *valp = *valp >> 4;
-  return error;
-}
-
-static int
-Operand_tp7_decode (uint32 *valp)
-{
-  unsigned tp7_0, t_0;
-  t_0 = *valp & 0xf;
-  tp7_0 = t_0 + 0x7;
-  *valp = tp7_0;
-  return 0;
-}
-
-static int
-Operand_tp7_encode (uint32 *valp)
-{
-  unsigned t_0, tp7_0;
-  tp7_0 = *valp;
-  t_0 = (tp7_0 - 0x7) & 0xf;
-  *valp = t_0;
-  return 0;
-}
-
-static int
-Operand_xt_wbr15_label_decode (uint32 *valp)
-{
-  unsigned xt_wbr15_label_0, xt_wbr15_imm_0;
-  xt_wbr15_imm_0 = *valp & 0x7fff;
-  xt_wbr15_label_0 = 0x4 + (((int) xt_wbr15_imm_0 << 17) >> 17);
-  *valp = xt_wbr15_label_0;
-  return 0;
-}
-
-static int
-Operand_xt_wbr15_label_encode (uint32 *valp)
-{
-  unsigned xt_wbr15_imm_0, xt_wbr15_label_0;
-  xt_wbr15_label_0 = *valp;
-  xt_wbr15_imm_0 = (xt_wbr15_label_0 - 0x4) & 0x7fff;
-  *valp = xt_wbr15_imm_0;
-  return 0;
-}
-
 static int
 Operand_xt_wbr15_label_ator (uint32 *valp, uint32 pc)
 {
@@ -10341,26 +10415,6 @@ Operand_xt_wbr15_label_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_xt_wbr18_label_decode (uint32 *valp)
-{
-  unsigned xt_wbr18_label_0, xt_wbr18_imm_0;
-  xt_wbr18_imm_0 = *valp & 0x3ffff;
-  xt_wbr18_label_0 = 0x4 + (((int) xt_wbr18_imm_0 << 14) >> 14);
-  *valp = xt_wbr18_label_0;
-  return 0;
-}
-
-static int
-Operand_xt_wbr18_label_encode (uint32 *valp)
-{
-  unsigned xt_wbr18_imm_0, xt_wbr18_label_0;
-  xt_wbr18_label_0 = *valp;
-  xt_wbr18_imm_0 = (xt_wbr18_label_0 - 0x4) & 0x3ffff;
-  *valp = xt_wbr18_imm_0;
-  return 0;
-}
-
 static int
 Operand_xt_wbr18_label_ator (uint32 *valp, uint32 pc)
 {
@@ -10375,481 +10429,323 @@ Operand_xt_wbr18_label_rtoa (uint32 *valp, uint32 pc)
   return 0;
 }
 
-static int
-Operand_ae_samt32_decode (uint32 *valp)
-{
-  unsigned ae_samt32_0, ftsf14_0;
-  ftsf14_0 = *valp & 0x1f;
-  ae_samt32_0 = (0 << 5) | ftsf14_0;
-  *valp = ae_samt32_0;
-  return 0;
-}
-
-static int
-Operand_ae_samt32_encode (uint32 *valp)
-{
-  unsigned ftsf14_0, ae_samt32_0;
-  ae_samt32_0 = *valp;
-  ftsf14_0 = (ae_samt32_0 & 0x1f);
-  *valp = ftsf14_0;
-  return 0;
-}
-
-static int
-Operand_pr0_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_pr0_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0x7) != 0;
-  return error;
-}
-
-static int
-Operand_qr0_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_qr0_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0x3) != 0;
-  return error;
-}
-
-static int
-Operand_ae_lsimm16_decode (uint32 *valp)
-{
-  unsigned ae_lsimm16_0, t_0;
-  t_0 = *valp & 0xf;
-  ae_lsimm16_0 = (((int) t_0 << 28) >> 28) << 1;
-  *valp = ae_lsimm16_0;
-  return 0;
-}
-
-static int
-Operand_ae_lsimm16_encode (uint32 *valp)
-{
-  unsigned t_0, ae_lsimm16_0;
-  ae_lsimm16_0 = *valp;
-  t_0 = ((ae_lsimm16_0 >> 1) & 0xf);
-  *valp = t_0;
-  return 0;
-}
-
-static int
-Operand_ae_lsimm32_decode (uint32 *valp)
-{
-  unsigned ae_lsimm32_0, t_0;
-  t_0 = *valp & 0xf;
-  ae_lsimm32_0 = (((int) t_0 << 28) >> 28) << 2;
-  *valp = ae_lsimm32_0;
-  return 0;
-}
-
-static int
-Operand_ae_lsimm32_encode (uint32 *valp)
-{
-  unsigned t_0, ae_lsimm32_0;
-  ae_lsimm32_0 = *valp;
-  t_0 = ((ae_lsimm32_0 >> 2) & 0xf);
-  *valp = t_0;
-  return 0;
-}
-
-static int
-Operand_ae_lsimm64_decode (uint32 *valp)
-{
-  unsigned ae_lsimm64_0, t_0;
-  t_0 = *valp & 0xf;
-  ae_lsimm64_0 = (((int) t_0 << 28) >> 28) << 3;
-  *valp = ae_lsimm64_0;
-  return 0;
-}
-
-static int
-Operand_ae_lsimm64_encode (uint32 *valp)
-{
-  unsigned t_0, ae_lsimm64_0;
-  ae_lsimm64_0 = *valp;
-  t_0 = ((ae_lsimm64_0 >> 3) & 0xf);
-  *valp = t_0;
-  return 0;
-}
-
-static int
-Operand_ae_samt64_decode (uint32 *valp)
-{
-  unsigned ae_samt64_0, ae_samt_s_t_0;
-  ae_samt_s_t_0 = *valp & 0x3f;
-  ae_samt64_0 = (0 << 6) | ae_samt_s_t_0;
-  *valp = ae_samt64_0;
-  return 0;
-}
-
-static int
-Operand_ae_samt64_encode (uint32 *valp)
-{
-  unsigned ae_samt_s_t_0, ae_samt64_0;
-  ae_samt64_0 = *valp;
-  ae_samt_s_t_0 = (ae_samt64_0 & 0x3f);
-  *valp = ae_samt_s_t_0;
-  return 0;
-}
-
-static int
-Operand_ae_ohba_decode (uint32 *valp)
-{
-  unsigned ae_ohba_0, op1_0;
-  op1_0 = *valp & 0xf;
-  ae_ohba_0 = (0 << 5) | (((((op1_0 & 0xf))) == 0) << 4) | ((op1_0 & 0xf));
-  *valp = ae_ohba_0;
-  return 0;
-}
-
-static int
-Operand_ae_ohba_encode (uint32 *valp)
-{
-  unsigned op1_0, ae_ohba_0;
-  ae_ohba_0 = *valp;
-  op1_0 = (ae_ohba_0 & 0xf);
-  *valp = op1_0;
-  return 0;
-}
-
-static int
-Operand_pr_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_pr_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0x7) != 0;
-  return error;
-}
-
-static int
-Operand_qr0_rw_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_qr0_rw_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0x3) != 0;
-  return error;
-}
-
-static int
-Operand_qr1_w_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_qr1_w_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0x3) != 0;
-  return error;
-}
-
-static int
-Operand_ps_decode (uint32 *valp ATTRIBUTE_UNUSED)
-{
-  return 0;
-}
-
-static int
-Operand_ps_encode (uint32 *valp)
-{
-  int error;
-  error = (*valp & ~0x7) != 0;
-  return error;
-}
-
 static xtensa_operand_internal operands[] = {
   { "soffsetx4", FIELD_offset, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_soffsetx4_encode, Operand_soffsetx4_decode,
+    OperandSem_opnd_sem_soffsetx4_encode, OperandSem_opnd_sem_soffsetx4_decode,
     Operand_soffsetx4_ator, Operand_soffsetx4_rtoa },
   { "uimm12x8", FIELD_imm12, -1, 0,
     0,
-    Operand_uimm12x8_encode, Operand_uimm12x8_decode,
+    OperandSem_opnd_sem_uimm12x8_encode, OperandSem_opnd_sem_uimm12x8_decode,
     0, 0 },
   { "simm4", FIELD_mn, -1, 0,
     0,
-    Operand_simm4_encode, Operand_simm4_decode,
+    OperandSem_opnd_sem_simm4_encode, OperandSem_opnd_sem_simm4_decode,
     0, 0 },
   { "arr", FIELD_r, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_arr_encode, Operand_arr_decode,
+    OperandSem_opnd_sem_AR_encode, OperandSem_opnd_sem_AR_decode,
     0, 0 },
   { "ars", FIELD_s, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_ars_encode, Operand_ars_decode,
+    OperandSem_opnd_sem_AR_encode, OperandSem_opnd_sem_AR_decode,
     0, 0 },
   { "*ars_invisible", FIELD_s, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER | XTENSA_OPERAND_IS_INVISIBLE,
-    Operand_ars_encode, Operand_ars_decode,
+    OperandSem_opnd_sem_AR_encode, OperandSem_opnd_sem_AR_decode,
     0, 0 },
   { "art", FIELD_t, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_art_encode, Operand_art_decode,
+    OperandSem_opnd_sem_AR_encode, OperandSem_opnd_sem_AR_decode,
     0, 0 },
   { "ar0", FIELD__ar0, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER | XTENSA_OPERAND_IS_INVISIBLE,
-    Operand_ar0_encode, Operand_ar0_decode,
+    OperandSem_opnd_sem_AR_0_encode, OperandSem_opnd_sem_AR_0_decode,
     0, 0 },
   { "ar4", FIELD__ar4, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER | XTENSA_OPERAND_IS_INVISIBLE,
-    Operand_ar4_encode, Operand_ar4_decode,
+    OperandSem_opnd_sem_AR_1_encode, OperandSem_opnd_sem_AR_1_decode,
     0, 0 },
   { "ar8", FIELD__ar8, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER | XTENSA_OPERAND_IS_INVISIBLE,
-    Operand_ar8_encode, Operand_ar8_decode,
+    OperandSem_opnd_sem_AR_2_encode, OperandSem_opnd_sem_AR_2_decode,
     0, 0 },
   { "ar12", FIELD__ar12, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER | XTENSA_OPERAND_IS_INVISIBLE,
-    Operand_ar12_encode, Operand_ar12_decode,
+    OperandSem_opnd_sem_AR_3_encode, OperandSem_opnd_sem_AR_3_decode,
     0, 0 },
   { "ars_entry", FIELD_s, REGFILE_AR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_ars_entry_encode, Operand_ars_entry_decode,
+    OperandSem_opnd_sem_AR_4_encode, OperandSem_opnd_sem_AR_4_decode,
     0, 0 },
   { "immrx4", FIELD_r, -1, 0,
     0,
-    Operand_immrx4_encode, Operand_immrx4_decode,
+    OperandSem_opnd_sem_immrx4_encode, OperandSem_opnd_sem_immrx4_decode,
     0, 0 },
   { "lsi4x4", FIELD_r, -1, 0,
     0,
-    Operand_lsi4x4_encode, Operand_lsi4x4_decode,
+    OperandSem_opnd_sem_lsi4x4_encode, OperandSem_opnd_sem_lsi4x4_decode,
     0, 0 },
   { "simm7", FIELD_imm7, -1, 0,
     0,
-    Operand_simm7_encode, Operand_simm7_decode,
+    OperandSem_opnd_sem_simm7_encode, OperandSem_opnd_sem_simm7_decode,
     0, 0 },
   { "uimm6", FIELD_imm6, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_uimm6_encode, Operand_uimm6_decode,
+    OperandSem_opnd_sem_uimm6_encode, OperandSem_opnd_sem_uimm6_decode,
     Operand_uimm6_ator, Operand_uimm6_rtoa },
   { "ai4const", FIELD_t, -1, 0,
     0,
-    Operand_ai4const_encode, Operand_ai4const_decode,
+    OperandSem_opnd_sem_ai4const_encode, OperandSem_opnd_sem_ai4const_decode,
     0, 0 },
   { "b4const", FIELD_r, -1, 0,
     0,
-    Operand_b4const_encode, Operand_b4const_decode,
+    OperandSem_opnd_sem_b4const_encode, OperandSem_opnd_sem_b4const_decode,
     0, 0 },
   { "b4constu", FIELD_r, -1, 0,
     0,
-    Operand_b4constu_encode, Operand_b4constu_decode,
+    OperandSem_opnd_sem_b4constu_encode, OperandSem_opnd_sem_b4constu_decode,
     0, 0 },
   { "uimm8", FIELD_imm8, -1, 0,
     0,
-    Operand_uimm8_encode, Operand_uimm8_decode,
+    OperandSem_opnd_sem_uimm8_encode, OperandSem_opnd_sem_uimm8_decode,
     0, 0 },
   { "uimm8x2", FIELD_imm8, -1, 0,
     0,
-    Operand_uimm8x2_encode, Operand_uimm8x2_decode,
+    OperandSem_opnd_sem_uimm8x2_encode, OperandSem_opnd_sem_uimm8x2_decode,
     0, 0 },
   { "uimm8x4", FIELD_imm8, -1, 0,
     0,
-    Operand_uimm8x4_encode, Operand_uimm8x4_decode,
+    OperandSem_opnd_sem_uimm8x4_encode, OperandSem_opnd_sem_uimm8x4_decode,
     0, 0 },
   { "uimm4x16", FIELD_op2, -1, 0,
     0,
-    Operand_uimm4x16_encode, Operand_uimm4x16_decode,
+    OperandSem_opnd_sem_uimm4x16_encode, OperandSem_opnd_sem_uimm4x16_decode,
+    0, 0 },
+  { "uimmrx4", FIELD_r, -1, 0,
+    0,
+    OperandSem_opnd_sem_lsi4x4_encode, OperandSem_opnd_sem_lsi4x4_decode,
     0, 0 },
   { "simm8", FIELD_imm8, -1, 0,
     0,
-    Operand_simm8_encode, Operand_simm8_decode,
+    OperandSem_opnd_sem_simm8_encode, OperandSem_opnd_sem_simm8_decode,
     0, 0 },
   { "simm8x256", FIELD_imm8, -1, 0,
     0,
-    Operand_simm8x256_encode, Operand_simm8x256_decode,
+    OperandSem_opnd_sem_simm8x256_encode, OperandSem_opnd_sem_simm8x256_decode,
     0, 0 },
   { "simm12b", FIELD_imm12b, -1, 0,
     0,
-    Operand_simm12b_encode, Operand_simm12b_decode,
+    OperandSem_opnd_sem_simm12b_encode, OperandSem_opnd_sem_simm12b_decode,
     0, 0 },
   { "msalp32", FIELD_sal, -1, 0,
     0,
-    Operand_msalp32_encode, Operand_msalp32_decode,
+    OperandSem_opnd_sem_msalp32_encode, OperandSem_opnd_sem_msalp32_decode,
     0, 0 },
   { "op2p1", FIELD_op2, -1, 0,
     0,
-    Operand_op2p1_encode, Operand_op2p1_decode,
+    OperandSem_opnd_sem_op2p1_encode, OperandSem_opnd_sem_op2p1_decode,
     0, 0 },
   { "label8", FIELD_imm8, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_label8_encode, Operand_label8_decode,
+    OperandSem_opnd_sem_label8_encode, OperandSem_opnd_sem_label8_decode,
     Operand_label8_ator, Operand_label8_rtoa },
   { "ulabel8", FIELD_imm8, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_ulabel8_encode, Operand_ulabel8_decode,
+    OperandSem_opnd_sem_ulabel8_encode, OperandSem_opnd_sem_ulabel8_decode,
     Operand_ulabel8_ator, Operand_ulabel8_rtoa },
   { "label12", FIELD_imm12, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_label12_encode, Operand_label12_decode,
+    OperandSem_opnd_sem_label12_encode, OperandSem_opnd_sem_label12_decode,
     Operand_label12_ator, Operand_label12_rtoa },
   { "soffset", FIELD_offset, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_soffset_encode, Operand_soffset_decode,
+    OperandSem_opnd_sem_soffset_encode, OperandSem_opnd_sem_soffset_decode,
     Operand_soffset_ator, Operand_soffset_rtoa },
   { "uimm16x4", FIELD_imm16, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_uimm16x4_encode, Operand_uimm16x4_decode,
+    OperandSem_opnd_sem_uimm16x4_encode, OperandSem_opnd_sem_uimm16x4_decode,
     Operand_uimm16x4_ator, Operand_uimm16x4_rtoa },
+  { "bbi", FIELD_bbi, -1, 0,
+    0,
+    OperandSem_opnd_sem_bbi_encode, OperandSem_opnd_sem_bbi_decode,
+    0, 0 },
+  { "sae", FIELD_sae, -1, 0,
+    0,
+    OperandSem_opnd_sem_bbi_encode, OperandSem_opnd_sem_bbi_decode,
+    0, 0 },
+  { "sas", FIELD_sas, -1, 0,
+    0,
+    OperandSem_opnd_sem_bbi_encode, OperandSem_opnd_sem_bbi_decode,
+    0, 0 },
+  { "sargt", FIELD_sargt, -1, 0,
+    0,
+    OperandSem_opnd_sem_bbi_encode, OperandSem_opnd_sem_bbi_decode,
+    0, 0 },
+  { "s", FIELD_s, -1, 0,
+    0,
+    OperandSem_opnd_sem_s_encode, OperandSem_opnd_sem_s_decode,
+    0, 0 },
   { "immt", FIELD_t, -1, 0,
     0,
-    Operand_immt_encode, Operand_immt_decode,
+    OperandSem_opnd_sem_immt_encode, OperandSem_opnd_sem_immt_decode,
     0, 0 },
   { "imms", FIELD_s, -1, 0,
     0,
-    Operand_imms_encode, Operand_imms_decode,
+    OperandSem_opnd_sem_immt_encode, OperandSem_opnd_sem_immt_decode,
     0, 0 },
   { "bt", FIELD_t, REGFILE_BR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bt_encode, Operand_bt_decode,
+    OperandSem_opnd_sem_BR_encode, OperandSem_opnd_sem_BR_decode,
     0, 0 },
   { "bs", FIELD_s, REGFILE_BR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bs_encode, Operand_bs_decode,
+    OperandSem_opnd_sem_BR_encode, OperandSem_opnd_sem_BR_decode,
     0, 0 },
   { "br", FIELD_r, REGFILE_BR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_br_encode, Operand_br_decode,
+    OperandSem_opnd_sem_BR_encode, OperandSem_opnd_sem_BR_decode,
     0, 0 },
   { "bt2", FIELD_t2, REGFILE_BR, 2,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bt2_encode, Operand_bt2_decode,
+    OperandSem_opnd_sem_BR2_encode, OperandSem_opnd_sem_BR2_decode,
     0, 0 },
   { "bs2", FIELD_s2, REGFILE_BR, 2,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bs2_encode, Operand_bs2_decode,
+    OperandSem_opnd_sem_BR2_encode, OperandSem_opnd_sem_BR2_decode,
     0, 0 },
   { "br2", FIELD_r2, REGFILE_BR, 2,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_br2_encode, Operand_br2_decode,
+    OperandSem_opnd_sem_BR2_encode, OperandSem_opnd_sem_BR2_decode,
     0, 0 },
   { "bt4", FIELD_t4, REGFILE_BR, 4,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bt4_encode, Operand_bt4_decode,
+    OperandSem_opnd_sem_BR4_encode, OperandSem_opnd_sem_BR4_decode,
     0, 0 },
   { "bs4", FIELD_s4, REGFILE_BR, 4,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bs4_encode, Operand_bs4_decode,
+    OperandSem_opnd_sem_BR4_encode, OperandSem_opnd_sem_BR4_decode,
     0, 0 },
   { "br4", FIELD_r4, REGFILE_BR, 4,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_br4_encode, Operand_br4_decode,
+    OperandSem_opnd_sem_BR4_encode, OperandSem_opnd_sem_BR4_decode,
     0, 0 },
   { "bt8", FIELD_t8, REGFILE_BR, 8,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bt8_encode, Operand_bt8_decode,
+    OperandSem_opnd_sem_BR8_encode, OperandSem_opnd_sem_BR8_decode,
     0, 0 },
   { "bs8", FIELD_s8, REGFILE_BR, 8,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bs8_encode, Operand_bs8_decode,
+    OperandSem_opnd_sem_BR8_encode, OperandSem_opnd_sem_BR8_decode,
     0, 0 },
   { "br8", FIELD_r8, REGFILE_BR, 8,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_br8_encode, Operand_br8_decode,
+    OperandSem_opnd_sem_BR8_encode, OperandSem_opnd_sem_BR8_decode,
     0, 0 },
   { "bt16", FIELD__bt16, REGFILE_BR, 16,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bt16_encode, Operand_bt16_decode,
+    OperandSem_opnd_sem_BR16_encode, OperandSem_opnd_sem_BR16_decode,
     0, 0 },
   { "bs16", FIELD__bs16, REGFILE_BR, 16,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_bs16_encode, Operand_bs16_decode,
+    OperandSem_opnd_sem_BR16_encode, OperandSem_opnd_sem_BR16_decode,
     0, 0 },
   { "br16", FIELD__br16, REGFILE_BR, 16,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_br16_encode, Operand_br16_decode,
+    OperandSem_opnd_sem_BR16_encode, OperandSem_opnd_sem_BR16_decode,
     0, 0 },
   { "brall", FIELD__brall, REGFILE_BR, 16,
     XTENSA_OPERAND_IS_REGISTER | XTENSA_OPERAND_IS_INVISIBLE,
-    Operand_brall_encode, Operand_brall_decode,
+    OperandSem_opnd_sem_BR16_encode, OperandSem_opnd_sem_BR16_decode,
     0, 0 },
   { "tp7", FIELD_t, -1, 0,
     0,
-    Operand_tp7_encode, Operand_tp7_decode,
+    OperandSem_opnd_sem_tp7_encode, OperandSem_opnd_sem_tp7_decode,
     0, 0 },
   { "xt_wbr15_label", FIELD_xt_wbr15_imm, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_xt_wbr15_label_encode, Operand_xt_wbr15_label_decode,
+    OperandSem_opnd_sem_xt_wbr15_label_encode, OperandSem_opnd_sem_xt_wbr15_label_decode,
     Operand_xt_wbr15_label_ator, Operand_xt_wbr15_label_rtoa },
   { "xt_wbr18_label", FIELD_xt_wbr18_imm, -1, 0,
     XTENSA_OPERAND_IS_PCRELATIVE,
-    Operand_xt_wbr18_label_encode, Operand_xt_wbr18_label_decode,
+    OperandSem_opnd_sem_soffset_encode, OperandSem_opnd_sem_soffset_decode,
     Operand_xt_wbr18_label_ator, Operand_xt_wbr18_label_rtoa },
   { "ae_samt32", FIELD_ftsf14, -1, 0,
     0,
-    Operand_ae_samt32_encode, Operand_ae_samt32_decode,
+    OperandSem_opnd_sem_ae_samt32_encode, OperandSem_opnd_sem_ae_samt32_decode,
     0, 0 },
   { "pr0", FIELD_ftsf12, REGFILE_AE_PR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_pr0_encode, Operand_pr0_decode,
+    OperandSem_opnd_sem_AE_PR_encode, OperandSem_opnd_sem_AE_PR_decode,
     0, 0 },
   { "qr0", FIELD_ftsf13, REGFILE_AE_QR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_qr0_encode, Operand_qr0_decode,
+    OperandSem_opnd_sem_AE_QR_encode, OperandSem_opnd_sem_AE_QR_decode,
+    0, 0 },
+  { "mac_qr0", FIELD_ftsf13, REGFILE_AE_QR, 1,
+    XTENSA_OPERAND_IS_REGISTER,
+    OperandSem_opnd_sem_AE_QR_encode, OperandSem_opnd_sem_AE_QR_decode,
     0, 0 },
   { "ae_lsimm16", FIELD_t, -1, 0,
     0,
-    Operand_ae_lsimm16_encode, Operand_ae_lsimm16_decode,
+    OperandSem_opnd_sem_ae_lsimm16_encode, OperandSem_opnd_sem_ae_lsimm16_decode,
     0, 0 },
   { "ae_lsimm32", FIELD_t, -1, 0,
     0,
-    Operand_ae_lsimm32_encode, Operand_ae_lsimm32_decode,
+    OperandSem_opnd_sem_ae_lsimm32_encode, OperandSem_opnd_sem_ae_lsimm32_decode,
     0, 0 },
   { "ae_lsimm64", FIELD_t, -1, 0,
     0,
-    Operand_ae_lsimm64_encode, Operand_ae_lsimm64_decode,
+    OperandSem_opnd_sem_ae_lsimm64_encode, OperandSem_opnd_sem_ae_lsimm64_decode,
     0, 0 },
   { "ae_samt64", FIELD_ae_samt_s_t, -1, 0,
     0,
-    Operand_ae_samt64_encode, Operand_ae_samt64_decode,
+    OperandSem_opnd_sem_ae_samt64_encode, OperandSem_opnd_sem_ae_samt64_decode,
     0, 0 },
-  { "ae_ohba", FIELD_op1, -1, 0,
+  { "ae_ohba", FIELD_ae_fld_ohba, -1, 0,
     0,
-    Operand_ae_ohba_encode, Operand_ae_ohba_decode,
+    OperandSem_opnd_sem_ae_ohba_encode, OperandSem_opnd_sem_ae_ohba_decode,
+    0, 0 },
+  { "ae_ohba2", FIELD_ae_fld_ohba2, -1, 0,
+    0,
+    OperandSem_opnd_sem_ae_ohba_encode, OperandSem_opnd_sem_ae_ohba_decode,
     0, 0 },
   { "pr", FIELD_ae_r20, REGFILE_AE_PR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_pr_encode, Operand_pr_decode,
+    OperandSem_opnd_sem_AE_PR_encode, OperandSem_opnd_sem_AE_PR_decode,
+    0, 0 },
+  { "cvt_pr", FIELD_ae_r20, REGFILE_AE_PR, 1,
+    XTENSA_OPERAND_IS_REGISTER,
+    OperandSem_opnd_sem_AE_PR_encode, OperandSem_opnd_sem_AE_PR_decode,
     0, 0 },
   { "qr0_rw", FIELD_ae_r10, REGFILE_AE_QR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_qr0_rw_encode, Operand_qr0_rw_decode,
+    OperandSem_opnd_sem_AE_QR_encode, OperandSem_opnd_sem_AE_QR_decode,
+    0, 0 },
+  { "mac_qr0_rw", FIELD_ae_r10, REGFILE_AE_QR, 1,
+    XTENSA_OPERAND_IS_REGISTER,
+    OperandSem_opnd_sem_AE_QR_encode, OperandSem_opnd_sem_AE_QR_decode,
     0, 0 },
   { "qr1_w", FIELD_ae_r32, REGFILE_AE_QR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_qr1_w_encode, Operand_qr1_w_decode,
+    OperandSem_opnd_sem_AE_QR_encode, OperandSem_opnd_sem_AE_QR_decode,
+    0, 0 },
+  { "mac_qr1_w", FIELD_ae_r32, REGFILE_AE_QR, 1,
+    XTENSA_OPERAND_IS_REGISTER,
+    OperandSem_opnd_sem_AE_QR_encode, OperandSem_opnd_sem_AE_QR_decode,
     0, 0 },
   { "ps", FIELD_ae_s20, REGFILE_AE_PR, 1,
     XTENSA_OPERAND_IS_REGISTER,
-    Operand_ps_encode, Operand_ps_decode,
+    OperandSem_opnd_sem_AE_PR_encode, OperandSem_opnd_sem_AE_PR_decode,
+    0, 0 },
+  { "alupppb_ps", FIELD_ae_s20, REGFILE_AE_PR, 1,
+    XTENSA_OPERAND_IS_REGISTER,
+    OperandSem_opnd_sem_AE_PR_encode, OperandSem_opnd_sem_AE_PR_decode,
     0, 0 },
   { "t", FIELD_t, -1, 0, 0, 0, 0, 0, 0 },
   { "bbi4", FIELD_bbi4, -1, 0, 0, 0, 0, 0, 0 },
-  { "bbi", FIELD_bbi, -1, 0, 0, 0, 0, 0, 0 },
   { "imm12", FIELD_imm12, -1, 0, 0, 0, 0, 0, 0 },
   { "imm8", FIELD_imm8, -1, 0, 0, 0, 0, 0, 0 },
-  { "s", FIELD_s, -1, 0, 0, 0, 0, 0, 0 },
   { "imm12b", FIELD_imm12b, -1, 0, 0, 0, 0, 0, 0 },
   { "imm16", FIELD_imm16, -1, 0, 0, 0, 0, 0, 0 },
   { "m", FIELD_m, -1, 0, 0, 0, 0, 0, 0 },
@@ -10861,11 +10757,8 @@ static xtensa_operand_internal operands[] = {
   { "r", FIELD_r, -1, 0, 0, 0, 0, 0, 0 },
   { "sa4", FIELD_sa4, -1, 0, 0, 0, 0, 0, 0 },
   { "sae4", FIELD_sae4, -1, 0, 0, 0, 0, 0, 0 },
-  { "sae", FIELD_sae, -1, 0, 0, 0, 0, 0, 0 },
   { "sal", FIELD_sal, -1, 0, 0, 0, 0, 0, 0 },
-  { "sargt", FIELD_sargt, -1, 0, 0, 0, 0, 0, 0 },
   { "sas4", FIELD_sas4, -1, 0, 0, 0, 0, 0, 0 },
-  { "sas", FIELD_sas, -1, 0, 0, 0, 0, 0, 0 },
   { "sr", FIELD_sr, -1, 0, 0, 0, 0, 0, 0 },
   { "st", FIELD_st, -1, 0, 0, 0, 0, 0, 0 },
   { "thi3", FIELD_thi3, -1, 0, 0, 0, 0, 0, 0 },
@@ -10898,6 +10791,8 @@ static xtensa_operand_internal operands[] = {
   { "ae_r20", FIELD_ae_r20, -1, 0, 0, 0, 0, 0, 0 },
   { "ae_r10", FIELD_ae_r10, -1, 0, 0, 0, 0, 0, 0 },
   { "ae_s20", FIELD_ae_s20, -1, 0, 0, 0, 0, 0, 0 },
+  { "ae_fld_ohba", FIELD_ae_fld_ohba, -1, 0, 0, 0, 0, 0, 0 },
+  { "ae_fld_ohba2", FIELD_ae_fld_ohba2, -1, 0, 0, 0, 0, 0, 0 },
   { "op0_s3", FIELD_op0_s3, -1, 0, 0, 0, 0, 0, 0 },
   { "ftsf12", FIELD_ftsf12, -1, 0, 0, 0, 0, 0, 0 },
   { "ftsf13", FIELD_ftsf13, -1, 0, 0, 0, 0, 0, 0 },
@@ -11249,6 +11144,7 @@ enum xtensa_operand_id {
   OPERAND_uimm8x2,
   OPERAND_uimm8x4,
   OPERAND_uimm4x16,
+  OPERAND_uimmrx4,
   OPERAND_simm8,
   OPERAND_simm8x256,
   OPERAND_simm12b,
@@ -11259,6 +11155,11 @@ enum xtensa_operand_id {
   OPERAND_label12,
   OPERAND_soffset,
   OPERAND_uimm16x4,
+  OPERAND_bbi,
+  OPERAND_sae,
+  OPERAND_sas,
+  OPERAND_sargt,
+  OPERAND_s,
   OPERAND_immt,
   OPERAND_imms,
   OPERAND_bt,
@@ -11283,21 +11184,25 @@ enum xtensa_operand_id {
   OPERAND_ae_samt32,
   OPERAND_pr0,
   OPERAND_qr0,
+  OPERAND_mac_qr0,
   OPERAND_ae_lsimm16,
   OPERAND_ae_lsimm32,
   OPERAND_ae_lsimm64,
   OPERAND_ae_samt64,
   OPERAND_ae_ohba,
+  OPERAND_ae_ohba2,
   OPERAND_pr,
+  OPERAND_cvt_pr,
   OPERAND_qr0_rw,
+  OPERAND_mac_qr0_rw,
   OPERAND_qr1_w,
+  OPERAND_mac_qr1_w,
   OPERAND_ps,
+  OPERAND_alupppb_ps,
   OPERAND_t,
   OPERAND_bbi4,
-  OPERAND_bbi,
   OPERAND_imm12,
   OPERAND_imm8,
-  OPERAND_s,
   OPERAND_imm12b,
   OPERAND_imm16,
   OPERAND_m,
@@ -11309,11 +11214,8 @@ enum xtensa_operand_id {
   OPERAND_r,
   OPERAND_sa4,
   OPERAND_sae4,
-  OPERAND_sae,
   OPERAND_sal,
-  OPERAND_sargt,
   OPERAND_sas4,
-  OPERAND_sas,
   OPERAND_sr,
   OPERAND_st,
   OPERAND_thi3,
@@ -11346,6 +11248,8 @@ enum xtensa_operand_id {
   OPERAND_ae_r20,
   OPERAND_ae_r10,
   OPERAND_ae_s20,
+  OPERAND_ae_fld_ohba,
+  OPERAND_ae_fld_ohba2,
   OPERAND_op0_s3,
   OPERAND_ftsf12,
   OPERAND_ftsf13,
@@ -12316,29 +12220,29 @@ static xtensa_arg_internal Iclass_xt_iclass_xsr_litbase_stateArgs[] = {
   { { STATE_LITBEN }, 'm' }
 };
 
-static xtensa_arg_internal Iclass_xt_iclass_rsr_176_args[] = {
+static xtensa_arg_internal Iclass_xt_iclass_rsr_configid0_args[] = {
   { { OPERAND_art }, 'o' }
 };
 
-static xtensa_arg_internal Iclass_xt_iclass_rsr_176_stateArgs[] = {
+static xtensa_arg_internal Iclass_xt_iclass_rsr_configid0_stateArgs[] = {
   { { STATE_PSEXCM }, 'i' },
   { { STATE_PSRING }, 'i' }
 };
 
-static xtensa_arg_internal Iclass_xt_iclass_wsr_176_args[] = {
+static xtensa_arg_internal Iclass_xt_iclass_wsr_configid0_args[] = {
   { { OPERAND_art }, 'i' }
 };
 
-static xtensa_arg_internal Iclass_xt_iclass_wsr_176_stateArgs[] = {
+static xtensa_arg_internal Iclass_xt_iclass_wsr_configid0_stateArgs[] = {
   { { STATE_PSEXCM }, 'i' },
   { { STATE_PSRING }, 'i' }
 };
 
-static xtensa_arg_internal Iclass_xt_iclass_rsr_208_args[] = {
+static xtensa_arg_internal Iclass_xt_iclass_rsr_configid1_args[] = {
   { { OPERAND_art }, 'o' }
 };
 
-static xtensa_arg_internal Iclass_xt_iclass_rsr_208_stateArgs[] = {
+static xtensa_arg_internal Iclass_xt_iclass_rsr_configid1_stateArgs[] = {
   { { STATE_PSEXCM }, 'i' },
   { { STATE_PSRING }, 'i' }
 };
@@ -14759,7 +14663,7 @@ static xtensa_arg_internal Iclass_ae_iclass_cvtq48a32s_stateArgs[] = {
 
 static xtensa_arg_internal Iclass_ae_iclass_cvtq48p24s_l_args[] = {
   { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_pr }, 'i' }
+  { { OPERAND_cvt_pr }, 'i' }
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_cvtq48p24s_l_stateArgs[] = {
@@ -14768,7 +14672,7 @@ static xtensa_arg_internal Iclass_ae_iclass_cvtq48p24s_l_stateArgs[] = {
 
 static xtensa_arg_internal Iclass_ae_iclass_cvtq48p24s_h_args[] = {
   { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_pr }, 'i' }
+  { { OPERAND_cvt_pr }, 'i' }
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_cvtq48p24s_h_stateArgs[] = {
@@ -14918,7 +14822,7 @@ static xtensa_arg_internal Iclass_ae_iclass_minp24s_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_maxbp24s_args[] = {
-  { { OPERAND_ps }, 'o' },
+  { { OPERAND_alupppb_ps }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' },
   { { OPERAND_bt2 }, 'o' }
@@ -14929,7 +14833,7 @@ static xtensa_arg_internal Iclass_ae_iclass_maxbp24s_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_minbp24s_args[] = {
-  { { OPERAND_ps }, 'o' },
+  { { OPERAND_alupppb_ps }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' },
   { { OPERAND_bt2 }, 'o' }
@@ -15458,7 +15362,7 @@ static xtensa_arg_internal Iclass_ae_iclass_nsaq56s_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15469,7 +15373,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15479,7 +15383,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulp24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15489,7 +15393,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulp24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15500,7 +15404,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15510,7 +15414,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulp24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15520,7 +15424,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulp24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15531,7 +15435,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15541,7 +15445,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulp24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15551,7 +15455,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulp24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15562,7 +15466,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfs32p16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15572,7 +15476,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfp24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulp24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15582,7 +15486,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulp24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15593,7 +15497,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15603,7 +15507,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulap24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15613,7 +15517,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulap24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15624,7 +15528,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15634,7 +15538,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulap24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15644,7 +15548,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulap24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15655,7 +15559,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15665,7 +15569,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulap24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15675,7 +15579,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulap24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15686,7 +15590,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs32p16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15696,7 +15600,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafp24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulap24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15706,7 +15610,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulap24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15717,7 +15621,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15727,7 +15631,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15737,7 +15641,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15748,7 +15652,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15758,7 +15662,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15768,7 +15672,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15779,7 +15683,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15789,7 +15693,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15799,7 +15703,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15810,7 +15714,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs32p16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15820,7 +15724,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfp24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15830,7 +15734,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsp24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15841,7 +15745,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15852,7 +15756,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15863,7 +15767,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15874,7 +15778,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15885,7 +15789,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15896,7 +15800,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15907,7 +15811,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafs56p24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15918,7 +15822,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulas56p24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15929,7 +15833,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15940,7 +15844,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15951,7 +15855,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15962,7 +15866,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15973,7 +15877,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_hl_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15984,7 +15888,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_hl_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -15995,7 +15899,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfs56p24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16006,8 +15910,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulss56p24s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16s_l_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16016,8 +15920,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16s_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16s_h_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16026,8 +15930,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16s_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16u_l_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16036,8 +15940,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16u_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16u_h_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16046,8 +15950,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulfq32sp16u_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16s_l_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16056,8 +15960,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16s_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16s_h_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16066,8 +15970,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16s_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16u_l_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16076,8 +15980,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16u_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16u_h_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16086,8 +15990,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulq32sp16u_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16s_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16096,8 +16000,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16s_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16s_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16106,8 +16010,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16s_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16u_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16116,8 +16020,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16u_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16u_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16126,8 +16030,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulafq32sp16u_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16s_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16136,8 +16040,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16s_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16s_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16146,8 +16050,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16s_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16u_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16156,8 +16060,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16u_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16u_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16166,8 +16070,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaq32sp16u_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16s_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16176,8 +16080,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16s_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16s_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16186,8 +16090,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16s_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16u_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16196,8 +16100,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16u_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16u_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16206,8 +16110,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsfq32sp16u_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16s_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16216,8 +16120,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16s_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16s_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16226,8 +16130,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16s_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16u_l_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16236,8 +16140,8 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16u_l_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16u_h_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'm' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' }
 };
 
@@ -16246,10 +16150,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsq32sp16u_h_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16258,10 +16162,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16270,10 +16174,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16282,10 +16186,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16294,10 +16198,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16306,10 +16210,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16318,10 +16222,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16330,10 +16234,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16342,10 +16246,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16354,10 +16258,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16366,10 +16270,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16378,10 +16282,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaaq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16390,10 +16294,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16402,10 +16306,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16414,10 +16318,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16426,10 +16330,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16438,10 +16342,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16450,10 +16354,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16462,10 +16366,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16474,10 +16378,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16486,10 +16390,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16498,10 +16402,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16510,10 +16414,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16522,10 +16426,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16534,10 +16438,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16546,10 +16450,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16558,10 +16462,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16570,10 +16474,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16582,10 +16486,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16594,10 +16498,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16606,10 +16510,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16618,10 +16522,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16630,10 +16534,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16642,10 +16546,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16654,10 +16558,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16666,10 +16570,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsaq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16678,10 +16582,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16690,10 +16594,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16s_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16702,10 +16606,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16s_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16714,10 +16618,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16u_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16726,10 +16630,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16u_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16738,10 +16642,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16s_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16750,10 +16654,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16s_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16762,10 +16666,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16u_hh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16774,10 +16678,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16u_hh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16786,10 +16690,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16s_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16798,10 +16702,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16s_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16810,10 +16714,10 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16u_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
-  { { OPERAND_qr0_rw }, 'i' },
+  { { OPERAND_mac_qr1_w }, 'o' },
+  { { OPERAND_mac_qr0_rw }, 'i' },
   { { OPERAND_pr }, 'i' },
-  { { OPERAND_qr0 }, 'i' },
+  { { OPERAND_mac_qr0 }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
 
@@ -16822,7 +16726,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfq32sp16u_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16832,7 +16736,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaap24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16842,7 +16746,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaap24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaafp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16852,7 +16756,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaafp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzaap24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16862,7 +16766,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzaap24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16872,7 +16776,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16882,7 +16786,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasfp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16892,7 +16796,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasfp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzasp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16902,7 +16806,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzasp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16912,7 +16816,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsap24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16922,7 +16826,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsap24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsafp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16932,7 +16836,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsafp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzsap24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16942,7 +16846,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzsap24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16952,7 +16856,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16962,7 +16866,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssfp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16972,7 +16876,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssfp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulzssp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'o' },
+  { { OPERAND_mac_qr1_w }, 'o' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16982,7 +16886,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulzssp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaafp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -16992,7 +16896,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaafp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaap24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17002,7 +16906,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaap24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaafp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17012,7 +16916,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaafp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulaap24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17022,7 +16926,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulaap24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulasfp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17032,7 +16936,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulasfp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulasp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17042,7 +16946,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulasp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulasfp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17052,7 +16956,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulasfp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulasp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17062,7 +16966,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulasp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsafp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17072,7 +16976,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsafp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsap24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17082,7 +16986,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsap24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsafp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17092,7 +16996,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsafp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulsap24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17102,7 +17006,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulsap24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulssfp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17112,7 +17016,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulssfp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulssp24s_hh_ll_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17122,7 +17026,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulssp24s_hh_ll_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulssfp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17132,7 +17036,7 @@ static xtensa_arg_internal Iclass_ae_iclass_mulssfp24s_hl_lh_stateArgs[] = {
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_mulssp24s_hl_lh_args[] = {
-  { { OPERAND_qr1_w }, 'm' },
+  { { OPERAND_mac_qr1_w }, 'm' },
   { { OPERAND_pr }, 'i' },
   { { OPERAND_pr0 }, 'i' }
 };
@@ -17215,7 +17119,7 @@ static xtensa_arg_internal Iclass_ae_iclass_lb_stateArgs[] = {
 
 static xtensa_arg_internal Iclass_ae_iclass_lbi_args[] = {
   { { OPERAND_arr }, 'o' },
-  { { OPERAND_ae_ohba }, 'i' }
+  { { OPERAND_ae_ohba2 }, 'i' }
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_lbi_stateArgs[] = {
@@ -17239,7 +17143,7 @@ static xtensa_arg_internal Iclass_ae_iclass_lbk_stateArgs[] = {
 static xtensa_arg_internal Iclass_ae_iclass_lbki_args[] = {
   { { OPERAND_arr }, 'o' },
   { { OPERAND_ars }, 'i' },
-  { { OPERAND_ae_ohba }, 'i' }
+  { { OPERAND_ae_ohba2 }, 'i' }
 };
 
 static xtensa_arg_internal Iclass_ae_iclass_lbki_stateArgs[] = {
@@ -17349,8 +17253,6 @@ static xtensa_iclass_internal iclasses[] = {
     3, Iclass_xt_iclass_rfde_stateArgs, 0, 0 },
   { 0, 0 /* xt_iclass_syscall */,
     0, 0, 0, 0 },
-  { 0, 0 /* xt_iclass_simcall */,
-    0, 0, 0, 0 },
   { 2, Iclass_xt_iclass_call12_args,
     1, Iclass_xt_iclass_call12_stateArgs, 0, 0 },
   { 2, Iclass_xt_iclass_call8_args,
@@ -17467,6 +17369,8 @@ static xtensa_iclass_internal iclasses[] = {
     0, 0, 0, 0 },
   { 1, Iclass_xt_iclass_return_args,
     0, 0, 0, 0 },
+  { 0, 0 /* xt_iclass_simcall */,
+    0, 0, 0, 0 },
   { 3, Iclass_xt_iclass_s16i_args,
     0, 0, 0, 0 },
   { 3, Iclass_xt_iclass_s32i_args,
@@ -17529,12 +17433,12 @@ static xtensa_iclass_internal iclasses[] = {
     2, Iclass_xt_iclass_wsr_litbase_stateArgs, 0, 0 },
   { 1, Iclass_xt_iclass_xsr_litbase_args,
     2, Iclass_xt_iclass_xsr_litbase_stateArgs, 0, 0 },
-  { 1, Iclass_xt_iclass_rsr_176_args,
-    2, Iclass_xt_iclass_rsr_176_stateArgs, 0, 0 },
-  { 1, Iclass_xt_iclass_wsr_176_args,
-    2, Iclass_xt_iclass_wsr_176_stateArgs, 0, 0 },
-  { 1, Iclass_xt_iclass_rsr_208_args,
-    2, Iclass_xt_iclass_rsr_208_stateArgs, 0, 0 },
+  { 1, Iclass_xt_iclass_rsr_configid0_args,
+    2, Iclass_xt_iclass_rsr_configid0_stateArgs, 0, 0 },
+  { 1, Iclass_xt_iclass_wsr_configid0_args,
+    2, Iclass_xt_iclass_wsr_configid0_stateArgs, 0, 0 },
+  { 1, Iclass_xt_iclass_rsr_configid1_args,
+    2, Iclass_xt_iclass_rsr_configid1_stateArgs, 0, 0 },
   { 1, Iclass_xt_iclass_rsr_ps_args,
     7, Iclass_xt_iclass_rsr_ps_stateArgs, 0, 0 },
   { 1, Iclass_xt_iclass_wsr_ps_args,
@@ -18524,7 +18428,6 @@ enum xtensa_iclass_id {
   ICLASS_xt_iclass_rfe,
   ICLASS_xt_iclass_rfde,
   ICLASS_xt_iclass_syscall,
-  ICLASS_xt_iclass_simcall,
   ICLASS_xt_iclass_call12,
   ICLASS_xt_iclass_call8,
   ICLASS_xt_iclass_call4,
@@ -18583,6 +18486,7 @@ enum xtensa_iclass_id {
   ICLASS_xt_iclass_neg,
   ICLASS_xt_iclass_nop,
   ICLASS_xt_iclass_return,
+  ICLASS_xt_iclass_simcall,
   ICLASS_xt_iclass_s16i,
   ICLASS_xt_iclass_s32i,
   ICLASS_xt_iclass_s8i,
@@ -18614,9 +18518,9 @@ enum xtensa_iclass_id {
   ICLASS_xt_iclass_rsr_litbase,
   ICLASS_xt_iclass_wsr_litbase,
   ICLASS_xt_iclass_xsr_litbase,
-  ICLASS_xt_iclass_rsr_176,
-  ICLASS_xt_iclass_wsr_176,
-  ICLASS_xt_iclass_rsr_208,
+  ICLASS_xt_iclass_rsr_configid0,
+  ICLASS_xt_iclass_wsr_configid0,
+  ICLASS_xt_iclass_rsr_configid1,
   ICLASS_xt_iclass_rsr_ps,
   ICLASS_xt_iclass_wsr_ps,
   ICLASS_xt_iclass_xsr_ps,
@@ -19137,12 +19041,6 @@ Opcode_syscall_Slot_inst_encode (xtensa_insnbuf slotbuf)
   slotbuf[0] = 0x5000;
 }
 
-static void
-Opcode_simcall_Slot_inst_encode (xtensa_insnbuf slotbuf)
-{
-  slotbuf[0] = 0x5100;
-}
-
 static void
 Opcode_call12_Slot_inst_encode (xtensa_insnbuf slotbuf)
 {
@@ -20031,6 +19929,12 @@ Opcode_ret_Slot_inst_encode (xtensa_insnbuf slotbuf)
   slotbuf[0] = 0x80;
 }
 
+static void
+Opcode_simcall_Slot_inst_encode (xtensa_insnbuf slotbuf)
+{
+  slotbuf[0] = 0x5100;
+}
+
 static void
 Opcode_s16i_Slot_inst_encode (xtensa_insnbuf slotbuf)
 {
@@ -20344,19 +20248,19 @@ Opcode_xsr_litbase_Slot_inst_encode (xtensa_insnbuf slotbuf)
 }
 
 static void
-Opcode_rsr_176_Slot_inst_encode (xtensa_insnbuf slotbuf)
+Opcode_rsr_configid0_Slot_inst_encode (xtensa_insnbuf slotbuf)
 {
   slotbuf[0] = 0x3b000;
 }
 
 static void
-Opcode_wsr_176_Slot_inst_encode (xtensa_insnbuf slotbuf)
+Opcode_wsr_configid0_Slot_inst_encode (xtensa_insnbuf slotbuf)
 {
   slotbuf[0] = 0x13b000;
 }
 
 static void
-Opcode_rsr_208_Slot_inst_encode (xtensa_insnbuf slotbuf)
+Opcode_rsr_configid1_Slot_inst_encode (xtensa_insnbuf slotbuf)
 {
   slotbuf[0] = 0x3d000;
 }
@@ -24175,10 +24079,6 @@ static xtensa_opcode_encode_fn Opcode_syscall_encode_fns[] = {
   Opcode_syscall_Slot_inst_encode, 0, 0, 0, 0
 };
 
-static xtensa_opcode_encode_fn Opcode_simcall_encode_fns[] = {
-  Opcode_simcall_Slot_inst_encode, 0, 0, 0, 0
-};
-
 static xtensa_opcode_encode_fn Opcode_call12_encode_fns[] = {
   Opcode_call12_Slot_inst_encode, 0, 0, 0, 0
 };
@@ -24555,6 +24455,10 @@ static xtensa_opcode_encode_fn Opcode_ret_encode_fns[] = {
   Opcode_ret_Slot_inst_encode, 0, 0, 0, 0
 };
 
+static xtensa_opcode_encode_fn Opcode_simcall_encode_fns[] = {
+  Opcode_simcall_Slot_inst_encode, 0, 0, 0, 0
+};
+
 static xtensa_opcode_encode_fn Opcode_s16i_encode_fns[] = {
   Opcode_s16i_Slot_inst_encode, 0, 0, 0, Opcode_s16i_Slot_ae_slot0_encode
 };
@@ -24703,16 +24607,16 @@ static xtensa_opcode_encode_fn Opcode_xsr_litbase_encode_fns[] = {
   Opcode_xsr_litbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-static xtensa_opcode_encode_fn Opcode_rsr_176_encode_fns[] = {
-  Opcode_rsr_176_Slot_inst_encode, 0, 0, 0, 0
+static xtensa_opcode_encode_fn Opcode_rsr_configid0_encode_fns[] = {
+  Opcode_rsr_configid0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-static xtensa_opcode_encode_fn Opcode_wsr_176_encode_fns[] = {
-  Opcode_wsr_176_Slot_inst_encode, 0, 0, 0, 0
+static xtensa_opcode_encode_fn Opcode_wsr_configid0_encode_fns[] = {
+  Opcode_wsr_configid0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-static xtensa_opcode_encode_fn Opcode_rsr_208_encode_fns[] = {
-  Opcode_rsr_208_Slot_inst_encode, 0, 0, 0, 0
+static xtensa_opcode_encode_fn Opcode_rsr_configid1_encode_fns[] = {
+  Opcode_rsr_configid1_Slot_inst_encode, 0, 0, 0, 0
 };
 
 static xtensa_opcode_encode_fn Opcode_rsr_ps_encode_fns[] = {
@@ -26873,9 +26777,6 @@ static xtensa_opcode_internal opcodes[] = {
   { "syscall", ICLASS_xt_iclass_syscall,
     0,
     Opcode_syscall_encode_fns, 0, 0 },
-  { "simcall", ICLASS_xt_iclass_simcall,
-    0,
-    Opcode_simcall_encode_fns, 0, 0 },
   { "call12", ICLASS_xt_iclass_call12,
     XTENSA_OPCODE_IS_CALL,
     Opcode_call12_encode_fns, 0, 0 },
@@ -27158,6 +27059,9 @@ static xtensa_opcode_internal opcodes[] = {
   { "ret", ICLASS_xt_iclass_return,
     XTENSA_OPCODE_IS_JUMP,
     Opcode_ret_encode_fns, 0, 0 },
+  { "simcall", ICLASS_xt_iclass_simcall,
+    0,
+    Opcode_simcall_encode_fns, 0, 0 },
   { "s16i", ICLASS_xt_iclass_s16i,
     0,
     Opcode_s16i_encode_fns, 0, 0 },
@@ -27269,15 +27173,15 @@ static xtensa_opcode_internal opcodes[] = {
   { "xsr.litbase", ICLASS_xt_iclass_xsr_litbase,
     0,
     Opcode_xsr_litbase_encode_fns, 0, 0 },
-  { "rsr.176", ICLASS_xt_iclass_rsr_176,
+  { "rsr.configid0", ICLASS_xt_iclass_rsr_configid0,
     0,
-    Opcode_rsr_176_encode_fns, 0, 0 },
-  { "wsr.176", ICLASS_xt_iclass_wsr_176,
+    Opcode_rsr_configid0_encode_fns, 0, 0 },
+  { "wsr.configid0", ICLASS_xt_iclass_wsr_configid0,
     0,
-    Opcode_wsr_176_encode_fns, 0, 0 },
-  { "rsr.208", ICLASS_xt_iclass_rsr_208,
+    Opcode_wsr_configid0_encode_fns, 0, 0 },
+  { "rsr.configid1", ICLASS_xt_iclass_rsr_configid1,
     0,
-    Opcode_rsr_208_encode_fns, 0, 0 },
+    Opcode_rsr_configid1_encode_fns, 0, 0 },
   { "rsr.ps", ICLASS_xt_iclass_rsr_ps,
     0,
     Opcode_rsr_ps_encode_fns, 0, 0 },
@@ -28836,7 +28740,6 @@ enum xtensa_opcode_id {
   OPCODE_RFE,
   OPCODE_RFDE,
   OPCODE_SYSCALL,
-  OPCODE_SIMCALL,
   OPCODE_CALL12,
   OPCODE_CALL8,
   OPCODE_CALL4,
@@ -28931,6 +28834,7 @@ enum xtensa_opcode_id {
   OPCODE_ABS,
   OPCODE_NOP,
   OPCODE_RET,
+  OPCODE_SIMCALL,
   OPCODE_S16I,
   OPCODE_S32I,
   OPCODE_S8I,
@@ -28968,9 +28872,9 @@ enum xtensa_opcode_id {
   OPCODE_RSR_LITBASE,
   OPCODE_WSR_LITBASE,
   OPCODE_XSR_LITBASE,
-  OPCODE_RSR_176,
-  OPCODE_WSR_176,
-  OPCODE_RSR_208,
+  OPCODE_RSR_CONFIGID0,
+  OPCODE_WSR_CONFIGID0,
+  OPCODE_RSR_CONFIGID1,
   OPCODE_RSR_PS,
   OPCODE_WSR_PS,
   OPCODE_XSR_PS,
@@ -29496,1327 +29400,1252 @@ enum xtensa_opcode_id {
 static int
 Slot_inst_decode (const xtensa_insnbuf insn)
 {
-  switch (Field_op0_Slot_inst_get (insn))
+  if (Field_op0_Slot_inst_get (insn) == 0)
     {
-    case 0:
-      switch (Field_op1_Slot_inst_get (insn))
+      if (Field_op1_Slot_inst_get (insn) == 0)
 	{
-	case 0:
-	  switch (Field_op2_Slot_inst_get (insn))
+	  if (Field_op2_Slot_inst_get (insn) == 0)
 	    {
-	    case 0:
-	      switch (Field_r_Slot_inst_get (insn))
+	      if (Field_r_Slot_inst_get (insn) == 0)
 		{
-		case 0:
-		  switch (Field_m_Slot_inst_get (insn))
-		    {
-		    case 0:
-		      if (Field_s_Slot_inst_get (insn) == 0 &&
-			  Field_n_Slot_inst_get (insn) == 0)
-			return OPCODE_ILL;
-		      break;
-		    case 2:
-		      switch (Field_n_Slot_inst_get (insn))
-			{
-			case 0:
-			  return OPCODE_RET;
-			case 1:
-			  return OPCODE_RETW;
-			case 2:
-			  return OPCODE_JX;
-			}
-		      break;
-		    case 3:
-		      switch (Field_n_Slot_inst_get (insn))
-			{
-			case 0:
-			  return OPCODE_CALLX0;
-			case 1:
-			  return OPCODE_CALLX4;
-			case 2:
-			  return OPCODE_CALLX8;
-			case 3:
-			  return OPCODE_CALLX12;
-			}
-		      break;
-		    }
-		  break;
-		case 1:
-		  return OPCODE_MOVSP;
-		case 2:
-		  if (Field_s_Slot_inst_get (insn) == 0)
-		    {
-		      switch (Field_t_Slot_inst_get (insn))
-			{
-			case 0:
-			  return OPCODE_ISYNC;
-			case 1:
-			  return OPCODE_RSYNC;
-			case 2:
-			  return OPCODE_ESYNC;
-			case 3:
-			  return OPCODE_DSYNC;
-			case 8:
-			  return OPCODE_EXCW;
-			case 12:
-			  return OPCODE_MEMW;
-			case 13:
-			  return OPCODE_EXTW;
-			case 15:
-			  return OPCODE_NOP;
-			}
-		    }
-		  break;
-		case 3:
-		  switch (Field_t_Slot_inst_get (insn))
+		  if (Field_m_Slot_inst_get (insn) == 0 &&
+		      Field_s_Slot_inst_get (insn) == 0 &&
+		      Field_n_Slot_inst_get (insn) == 0)
+		    return OPCODE_ILL;
+		  if (Field_m_Slot_inst_get (insn) == 2)
 		    {
-		    case 0:
-		      switch (Field_s_Slot_inst_get (insn))
-			{
-			case 0:
-			  return OPCODE_RFE;
-			case 2:
-			  return OPCODE_RFDE;
-			case 4:
-			  return OPCODE_RFWO;
-			case 5:
-			  return OPCODE_RFWU;
-			}
-		      break;
-		    case 1:
-		      return OPCODE_RFI;
+		      if (Field_n_Slot_inst_get (insn) == 0)
+			return OPCODE_RET;
+		      if (Field_n_Slot_inst_get (insn) == 1)
+			return OPCODE_RETW;
+		      if (Field_n_Slot_inst_get (insn) == 2)
+			return OPCODE_JX;
 		    }
-		  break;
-		case 4:
-		  return OPCODE_BREAK;
-		case 5:
-		  switch (Field_s_Slot_inst_get (insn))
+		  if (Field_m_Slot_inst_get (insn) == 3)
 		    {
-		    case 0:
-		      if (Field_t_Slot_inst_get (insn) == 0)
-			return OPCODE_SYSCALL;
-		      break;
-		    case 1:
-		      if (Field_t_Slot_inst_get (insn) == 0)
-			return OPCODE_SIMCALL;
-		      break;
+		      if (Field_n_Slot_inst_get (insn) == 0)
+			return OPCODE_CALLX0;
+		      if (Field_n_Slot_inst_get (insn) == 1)
+			return OPCODE_CALLX4;
+		      if (Field_n_Slot_inst_get (insn) == 2)
+			return OPCODE_CALLX8;
+		      if (Field_n_Slot_inst_get (insn) == 3)
+			return OPCODE_CALLX12;
 		    }
-		  break;
-		case 6:
-		  return OPCODE_RSIL;
-		case 7:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_WAITI;
-		  break;
-		case 8:
-		  return OPCODE_ANY4;
-		case 9:
-		  return OPCODE_ALL4;
-		case 10:
-		  return OPCODE_ANY8;
-		case 11:
-		  return OPCODE_ALL8;
 		}
-	      break;
-	    case 1:
-	      return OPCODE_AND;
-	    case 2:
-	      return OPCODE_OR;
-	    case 3:
-	      return OPCODE_XOR;
-	    case 4:
-	      switch (Field_r_Slot_inst_get (insn))
+	      if (Field_r_Slot_inst_get (insn) == 1)
+		return OPCODE_MOVSP;
+	      if (Field_r_Slot_inst_get (insn) == 2)
 		{
-		case 0:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_SSR;
-		  break;
-		case 1:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_SSL;
-		  break;
-		case 2:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_SSA8L;
-		  break;
-		case 3:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_SSA8B;
-		  break;
-		case 4:
-		  if (Field_thi3_Slot_inst_get (insn) == 0)
-		    return OPCODE_SSAI;
-		  break;
-		case 6:
-		  return OPCODE_RER;
-		case 7:
-		  return OPCODE_WER;
-		case 8:
 		  if (Field_s_Slot_inst_get (insn) == 0)
-		    return OPCODE_ROTW;
-		  break;
-		case 14:
-		  return OPCODE_NSA;
-		case 15:
-		  return OPCODE_NSAU;
+		    {
+		      if (Field_t_Slot_inst_get (insn) == 0)
+			return OPCODE_ISYNC;
+		      if (Field_t_Slot_inst_get (insn) == 1)
+			return OPCODE_RSYNC;
+		      if (Field_t_Slot_inst_get (insn) == 2)
+			return OPCODE_ESYNC;
+		      if (Field_t_Slot_inst_get (insn) == 3)
+			return OPCODE_DSYNC;
+		      if (Field_t_Slot_inst_get (insn) == 8)
+			return OPCODE_EXCW;
+		      if (Field_t_Slot_inst_get (insn) == 12)
+			return OPCODE_MEMW;
+		      if (Field_t_Slot_inst_get (insn) == 13)
+			return OPCODE_EXTW;
+		      if (Field_t_Slot_inst_get (insn) == 15)
+			return OPCODE_NOP;
+		    }
 		}
-	      break;
-	    case 5:
-	      switch (Field_r_Slot_inst_get (insn))
+	      if (Field_r_Slot_inst_get (insn) == 3)
 		{
-		case 1:
-		  return OPCODE_HWWITLBA;
-		case 3:
-		  return OPCODE_RITLB0;
-		case 4:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_IITLB;
-		  break;
-		case 5:
-		  return OPCODE_PITLB;
-		case 6:
-		  return OPCODE_WITLB;
-		case 7:
-		  return OPCODE_RITLB1;
-		case 9:
-		  return OPCODE_HWWDTLBA;
-		case 11:
-		  return OPCODE_RDTLB0;
-		case 12:
 		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_IDTLB;
-		  break;
-		case 13:
-		  return OPCODE_PDTLB;
-		case 14:
-		  return OPCODE_WDTLB;
-		case 15:
-		  return OPCODE_RDTLB1;
-		}
-	      break;
-	    case 6:
-	      switch (Field_s_Slot_inst_get (insn))
-		{
-		case 0:
-		  return OPCODE_NEG;
-		case 1:
-		  return OPCODE_ABS;
-		}
-	      break;
-	    case 8:
-	      return OPCODE_ADD;
-	    case 9:
-	      return OPCODE_ADDX2;
-	    case 10:
-	      return OPCODE_ADDX4;
-	    case 11:
-	      return OPCODE_ADDX8;
-	    case 12:
-	      return OPCODE_SUB;
-	    case 13:
-	      return OPCODE_SUBX2;
-	    case 14:
-	      return OPCODE_SUBX4;
-	    case 15:
-	      return OPCODE_SUBX8;
-	    }
-	  break;
-	case 1:
-	  switch (Field_op2_Slot_inst_get (insn))
-	    {
-	    case 0:
-	    case 1:
-	      return OPCODE_SLLI;
-	    case 2:
-	    case 3:
-	      return OPCODE_SRAI;
-	    case 4:
-	      return OPCODE_SRLI;
-	    case 6:
-	      switch (Field_sr_Slot_inst_get (insn))
-		{
-		case 0:
-		  return OPCODE_XSR_LBEG;
-		case 1:
-		  return OPCODE_XSR_LEND;
-		case 2:
-		  return OPCODE_XSR_LCOUNT;
-		case 3:
-		  return OPCODE_XSR_SAR;
-		case 4:
-		  return OPCODE_XSR_BR;
-		case 5:
-		  return OPCODE_XSR_LITBASE;
-		case 12:
-		  return OPCODE_XSR_SCOMPARE1;
-		case 72:
-		  return OPCODE_XSR_WINDOWBASE;
-		case 73:
-		  return OPCODE_XSR_WINDOWSTART;
-		case 83:
-		  return OPCODE_XSR_PTEVADDR;
-		case 90:
-		  return OPCODE_XSR_RASID;
-		case 91:
-		  return OPCODE_XSR_ITLBCFG;
-		case 92:
-		  return OPCODE_XSR_DTLBCFG;
-		case 99:
-		  return OPCODE_XSR_ATOMCTL;
-		case 104:
-		  return OPCODE_XSR_DDR;
-		case 177:
-		  return OPCODE_XSR_EPC1;
-		case 178:
-		  return OPCODE_XSR_EPC2;
-		case 192:
-		  return OPCODE_XSR_DEPC;
-		case 194:
-		  return OPCODE_XSR_EPS2;
-		case 209:
-		  return OPCODE_XSR_EXCSAVE1;
-		case 210:
-		  return OPCODE_XSR_EXCSAVE2;
-		case 224:
-		  return OPCODE_XSR_CPENABLE;
-		case 228:
-		  return OPCODE_XSR_INTENABLE;
-		case 230:
-		  return OPCODE_XSR_PS;
-		case 231:
-		  return OPCODE_XSR_VECBASE;
-		case 232:
-		  return OPCODE_XSR_EXCCAUSE;
-		case 233:
-		  return OPCODE_XSR_DEBUGCAUSE;
-		case 234:
-		  return OPCODE_XSR_CCOUNT;
-		case 236:
-		  return OPCODE_XSR_ICOUNT;
-		case 237:
-		  return OPCODE_XSR_ICOUNTLEVEL;
-		case 238:
-		  return OPCODE_XSR_EXCVADDR;
-		case 240:
-		  return OPCODE_XSR_CCOMPARE0;
-		case 241:
-		  return OPCODE_XSR_CCOMPARE1;
-		case 244:
-		  return OPCODE_XSR_MISC0;
-		case 245:
-		  return OPCODE_XSR_MISC1;
+		    {
+		      if (Field_s_Slot_inst_get (insn) == 0)
+			return OPCODE_RFE;
+		      if (Field_s_Slot_inst_get (insn) == 2)
+			return OPCODE_RFDE;
+		      if (Field_s_Slot_inst_get (insn) == 4)
+			return OPCODE_RFWO;
+		      if (Field_s_Slot_inst_get (insn) == 5)
+			return OPCODE_RFWU;
+		    }
+		  if (Field_t_Slot_inst_get (insn) == 1)
+		    return OPCODE_RFI;
 		}
-	      break;
-	    case 8:
-	      return OPCODE_SRC;
-	    case 9:
-	      if (Field_s_Slot_inst_get (insn) == 0)
-		return OPCODE_SRL;
-	      break;
-	    case 10:
-	      if (Field_t_Slot_inst_get (insn) == 0)
-		return OPCODE_SLL;
-	      break;
-	    case 11:
-	      if (Field_s_Slot_inst_get (insn) == 0)
-		return OPCODE_SRA;
-	      break;
-	    case 12:
-	      return OPCODE_MUL16U;
-	    case 13:
-	      return OPCODE_MUL16S;
-	    case 15:
-	      switch (Field_r_Slot_inst_get (insn))
+	      if (Field_r_Slot_inst_get (insn) == 4)
+		return OPCODE_BREAK;
+	      if (Field_r_Slot_inst_get (insn) == 5)
 		{
-		case 0:
-		  return OPCODE_LICT;
-		case 1:
-		  return OPCODE_SICT;
-		case 2:
-		  return OPCODE_LICW;
-		case 3:
-		  return OPCODE_SICW;
-		case 8:
-		  return OPCODE_LDCT;
-		case 9:
-		  return OPCODE_SDCT;
-		case 14:
-		  if (Field_t_Slot_inst_get (insn) == 0)
-		    return OPCODE_RFDO;
-		  if (Field_t_Slot_inst_get (insn) == 1)
-		    return OPCODE_RFDD;
-		  break;
-		case 15:
-		  return OPCODE_LDPTE;
+		  if (Field_s_Slot_inst_get (insn) == 0 &&
+		      Field_t_Slot_inst_get (insn) == 0)
+		    return OPCODE_SYSCALL;
+		  if (Field_s_Slot_inst_get (insn) == 1 &&
+		      Field_t_Slot_inst_get (insn) == 0)
+		    return OPCODE_SIMCALL;
 		}
-	      break;
+	      if (Field_r_Slot_inst_get (insn) == 6)
+		return OPCODE_RSIL;
+	      if (Field_r_Slot_inst_get (insn) == 7 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_WAITI;
+	      if (Field_r_Slot_inst_get (insn) == 8)
+		return OPCODE_ANY4;
+	      if (Field_r_Slot_inst_get (insn) == 9)
+		return OPCODE_ALL4;
+	      if (Field_r_Slot_inst_get (insn) == 10)
+		return OPCODE_ANY8;
+	      if (Field_r_Slot_inst_get (insn) == 11)
+		return OPCODE_ALL8;
 	    }
-	  break;
-	case 2:
-	  switch (Field_op2_Slot_inst_get (insn))
+	  if (Field_op2_Slot_inst_get (insn) == 1)
+	    return OPCODE_AND;
+	  if (Field_op2_Slot_inst_get (insn) == 2)
+	    return OPCODE_OR;
+	  if (Field_op2_Slot_inst_get (insn) == 3)
+	    return OPCODE_XOR;
+	  if (Field_op2_Slot_inst_get (insn) == 4)
 	    {
-	    case 0:
-	      return OPCODE_ANDB;
-	    case 1:
-	      return OPCODE_ANDBC;
-	    case 2:
-	      return OPCODE_ORB;
-	    case 3:
-	      return OPCODE_ORBC;
-	    case 4:
-	      return OPCODE_XORB;
-	    case 8:
-	      return OPCODE_MULL;
+	      if (Field_r_Slot_inst_get (insn) == 0 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_SSR;
+	      if (Field_r_Slot_inst_get (insn) == 1 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_SSL;
+	      if (Field_r_Slot_inst_get (insn) == 2 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_SSA8L;
+	      if (Field_r_Slot_inst_get (insn) == 3 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_SSA8B;
+	      if (Field_r_Slot_inst_get (insn) == 4 &&
+		  Field_thi3_Slot_inst_get (insn) == 0)
+		return OPCODE_SSAI;
+	      if (Field_r_Slot_inst_get (insn) == 6)
+		return OPCODE_RER;
+	      if (Field_r_Slot_inst_get (insn) == 7)
+		return OPCODE_WER;
+	      if (Field_r_Slot_inst_get (insn) == 8 &&
+		  Field_s_Slot_inst_get (insn) == 0)
+		return OPCODE_ROTW;
+	      if (Field_r_Slot_inst_get (insn) == 14)
+		return OPCODE_NSA;
+	      if (Field_r_Slot_inst_get (insn) == 15)
+		return OPCODE_NSAU;
 	    }
-	  break;
-	case 3:
-	  switch (Field_op2_Slot_inst_get (insn))
+	  if (Field_op2_Slot_inst_get (insn) == 5)
 	    {
-	    case 0:
-	      switch (Field_sr_Slot_inst_get (insn))
-		{
-		case 0:
-		  return OPCODE_RSR_LBEG;
-		case 1:
-		  return OPCODE_RSR_LEND;
-		case 2:
-		  return OPCODE_RSR_LCOUNT;
-		case 3:
-		  return OPCODE_RSR_SAR;
-		case 4:
-		  return OPCODE_RSR_BR;
-		case 5:
-		  return OPCODE_RSR_LITBASE;
-		case 12:
-		  return OPCODE_RSR_SCOMPARE1;
-		case 72:
-		  return OPCODE_RSR_WINDOWBASE;
-		case 73:
-		  return OPCODE_RSR_WINDOWSTART;
-		case 83:
-		  return OPCODE_RSR_PTEVADDR;
-		case 90:
-		  return OPCODE_RSR_RASID;
-		case 91:
-		  return OPCODE_RSR_ITLBCFG;
-		case 92:
-		  return OPCODE_RSR_DTLBCFG;
-		case 99:
-		  return OPCODE_RSR_ATOMCTL;
-		case 104:
-		  return OPCODE_RSR_DDR;
-		case 176:
-		  return OPCODE_RSR_176;
-		case 177:
-		  return OPCODE_RSR_EPC1;
-		case 178:
-		  return OPCODE_RSR_EPC2;
-		case 192:
-		  return OPCODE_RSR_DEPC;
-		case 194:
-		  return OPCODE_RSR_EPS2;
-		case 208:
-		  return OPCODE_RSR_208;
-		case 209:
-		  return OPCODE_RSR_EXCSAVE1;
-		case 210:
-		  return OPCODE_RSR_EXCSAVE2;
-		case 224:
-		  return OPCODE_RSR_CPENABLE;
-		case 226:
-		  return OPCODE_RSR_INTERRUPT;
-		case 228:
-		  return OPCODE_RSR_INTENABLE;
-		case 230:
-		  return OPCODE_RSR_PS;
-		case 231:
-		  return OPCODE_RSR_VECBASE;
-		case 232:
-		  return OPCODE_RSR_EXCCAUSE;
-		case 233:
-		  return OPCODE_RSR_DEBUGCAUSE;
-		case 234:
-		  return OPCODE_RSR_CCOUNT;
-		case 235:
-		  return OPCODE_RSR_PRID;
-		case 236:
-		  return OPCODE_RSR_ICOUNT;
-		case 237:
-		  return OPCODE_RSR_ICOUNTLEVEL;
-		case 238:
-		  return OPCODE_RSR_EXCVADDR;
-		case 240:
-		  return OPCODE_RSR_CCOMPARE0;
-		case 241:
-		  return OPCODE_RSR_CCOMPARE1;
-		case 244:
-		  return OPCODE_RSR_MISC0;
-		case 245:
-		  return OPCODE_RSR_MISC1;
-		}
-	      break;
-	    case 1:
-	      switch (Field_sr_Slot_inst_get (insn))
-		{
-		case 0:
-		  return OPCODE_WSR_LBEG;
-		case 1:
-		  return OPCODE_WSR_LEND;
-		case 2:
-		  return OPCODE_WSR_LCOUNT;
-		case 3:
-		  return OPCODE_WSR_SAR;
-		case 4:
-		  return OPCODE_WSR_BR;
-		case 5:
-		  return OPCODE_WSR_LITBASE;
-		case 12:
-		  return OPCODE_WSR_SCOMPARE1;
-		case 72:
-		  return OPCODE_WSR_WINDOWBASE;
-		case 73:
-		  return OPCODE_WSR_WINDOWSTART;
-		case 83:
-		  return OPCODE_WSR_PTEVADDR;
-		case 90:
-		  return OPCODE_WSR_RASID;
-		case 91:
-		  return OPCODE_WSR_ITLBCFG;
-		case 92:
-		  return OPCODE_WSR_DTLBCFG;
-		case 99:
-		  return OPCODE_WSR_ATOMCTL;
-		case 104:
-		  return OPCODE_WSR_DDR;
-		case 176:
-		  return OPCODE_WSR_176;
-		case 177:
-		  return OPCODE_WSR_EPC1;
-		case 178:
-		  return OPCODE_WSR_EPC2;
-		case 192:
-		  return OPCODE_WSR_DEPC;
-		case 194:
-		  return OPCODE_WSR_EPS2;
-		case 209:
-		  return OPCODE_WSR_EXCSAVE1;
-		case 210:
-		  return OPCODE_WSR_EXCSAVE2;
-		case 224:
-		  return OPCODE_WSR_CPENABLE;
-		case 226:
-		  return OPCODE_WSR_INTSET;
-		case 227:
-		  return OPCODE_WSR_INTCLEAR;
-		case 228:
-		  return OPCODE_WSR_INTENABLE;
-		case 230:
-		  return OPCODE_WSR_PS;
-		case 231:
-		  return OPCODE_WSR_VECBASE;
-		case 232:
-		  return OPCODE_WSR_EXCCAUSE;
-		case 233:
-		  return OPCODE_WSR_DEBUGCAUSE;
-		case 234:
-		  return OPCODE_WSR_CCOUNT;
-		case 236:
-		  return OPCODE_WSR_ICOUNT;
-		case 237:
-		  return OPCODE_WSR_ICOUNTLEVEL;
-		case 238:
-		  return OPCODE_WSR_EXCVADDR;
-		case 240:
-		  return OPCODE_WSR_CCOMPARE0;
-		case 241:
-		  return OPCODE_WSR_CCOMPARE1;
-		case 244:
-		  return OPCODE_WSR_MISC0;
-		case 245:
-		  return OPCODE_WSR_MISC1;
-		}
-	      break;
-	    case 2:
-	      return OPCODE_SEXT;
-	    case 3:
-	      return OPCODE_CLAMPS;
-	    case 4:
-	      return OPCODE_MIN;
-	    case 5:
-	      return OPCODE_MAX;
-	    case 6:
-	      return OPCODE_MINU;
-	    case 7:
-	      return OPCODE_MAXU;
-	    case 8:
-	      return OPCODE_MOVEQZ;
-	    case 9:
-	      return OPCODE_MOVNEZ;
-	    case 10:
-	      return OPCODE_MOVLTZ;
-	    case 11:
-	      return OPCODE_MOVGEZ;
-	    case 12:
-	      return OPCODE_MOVF;
-	    case 13:
-	      return OPCODE_MOVT;
-	    case 14:
-	      switch (Field_st_Slot_inst_get (insn))
-		{
-		case 231:
-		  return OPCODE_RUR_THREADPTR;
-		case 240:
-		  return OPCODE_RUR_AE_OVF_SAR;
-		case 241:
-		  return OPCODE_RUR_AE_BITHEAD;
-		case 242:
-		  return OPCODE_RUR_AE_TS_FTS_BU_BP;
-		case 243:
-		  return OPCODE_RUR_AE_SD_NO;
-		}
-	      break;
-	    case 15:
-	      switch (Field_sr_Slot_inst_get (insn))
-		{
-		case 231:
-		  return OPCODE_WUR_THREADPTR;
-		case 240:
-		  return OPCODE_WUR_AE_OVF_SAR;
-		case 241:
-		  return OPCODE_WUR_AE_BITHEAD;
-		case 242:
-		  return OPCODE_WUR_AE_TS_FTS_BU_BP;
-		case 243:
-		  return OPCODE_WUR_AE_SD_NO;
-		}
-	      break;
+	      if (Field_r_Slot_inst_get (insn) == 1)
+		return OPCODE_HWWITLBA;
+	      if (Field_r_Slot_inst_get (insn) == 3)
+		return OPCODE_RITLB0;
+	      if (Field_r_Slot_inst_get (insn) == 4 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_IITLB;
+	      if (Field_r_Slot_inst_get (insn) == 5)
+		return OPCODE_PITLB;
+	      if (Field_r_Slot_inst_get (insn) == 6)
+		return OPCODE_WITLB;
+	      if (Field_r_Slot_inst_get (insn) == 7)
+		return OPCODE_RITLB1;
+	      if (Field_r_Slot_inst_get (insn) == 9)
+		return OPCODE_HWWDTLBA;
+	      if (Field_r_Slot_inst_get (insn) == 11)
+		return OPCODE_RDTLB0;
+	      if (Field_r_Slot_inst_get (insn) == 12 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_IDTLB;
+	      if (Field_r_Slot_inst_get (insn) == 13)
+		return OPCODE_PDTLB;
+	      if (Field_r_Slot_inst_get (insn) == 14)
+		return OPCODE_WDTLB;
+	      if (Field_r_Slot_inst_get (insn) == 15)
+		return OPCODE_RDTLB1;
 	    }
-	  break;
-	case 4:
-	case 5:
-	  return OPCODE_EXTUI;
-	case 9:
-	  switch (Field_op2_Slot_inst_get (insn))
+	  if (Field_op2_Slot_inst_get (insn) == 6)
 	    {
-	    case 0:
-	      return OPCODE_L32E;
-	    case 4:
-	      return OPCODE_S32E;
+	      if (Field_s_Slot_inst_get (insn) == 0)
+		return OPCODE_NEG;
+	      if (Field_s_Slot_inst_get (insn) == 1)
+		return OPCODE_ABS;
 	    }
-	  break;
+	  if (Field_op2_Slot_inst_get (insn) == 8)
+	    return OPCODE_ADD;
+	  if (Field_op2_Slot_inst_get (insn) == 9)
+	    return OPCODE_ADDX2;
+	  if (Field_op2_Slot_inst_get (insn) == 10)
+	    return OPCODE_ADDX4;
+	  if (Field_op2_Slot_inst_get (insn) == 11)
+	    return OPCODE_ADDX8;
+	  if (Field_op2_Slot_inst_get (insn) == 12)
+	    return OPCODE_SUB;
+	  if (Field_op2_Slot_inst_get (insn) == 13)
+	    return OPCODE_SUBX2;
+	  if (Field_op2_Slot_inst_get (insn) == 14)
+	    return OPCODE_SUBX4;
+	  if (Field_op2_Slot_inst_get (insn) == 15)
+	    return OPCODE_SUBX8;
 	}
-      break;
-    case 1:
-      return OPCODE_L32R;
-    case 2:
-      switch (Field_r_Slot_inst_get (insn))
+      if (Field_op1_Slot_inst_get (insn) == 1)
 	{
-	case 0:
-	  return OPCODE_L8UI;
-	case 1:
-	  return OPCODE_L16UI;
-	case 2:
-	  return OPCODE_L32I;
-	case 4:
-	  return OPCODE_S8I;
-	case 5:
-	  return OPCODE_S16I;
-	case 6:
-	  return OPCODE_S32I;
-	case 7:
-	  switch (Field_t_Slot_inst_get (insn))
+	  if ((Field_op2_Slot_inst_get (insn) == 0 ||
+	       Field_op2_Slot_inst_get (insn) == 1))
+	    return OPCODE_SLLI;
+	  if ((Field_op2_Slot_inst_get (insn) == 2 ||
+	       Field_op2_Slot_inst_get (insn) == 3))
+	    return OPCODE_SRAI;
+	  if (Field_op2_Slot_inst_get (insn) == 4)
+	    return OPCODE_SRLI;
+	  if (Field_op2_Slot_inst_get (insn) == 6)
 	    {
-	    case 0:
-	      return OPCODE_DPFR;
-	    case 1:
-	      return OPCODE_DPFW;
-	    case 2:
-	      return OPCODE_DPFRO;
-	    case 3:
-	      return OPCODE_DPFWO;
-	    case 4:
-	      return OPCODE_DHWB;
-	    case 5:
-	      return OPCODE_DHWBI;
-	    case 6:
-	      return OPCODE_DHI;
-	    case 7:
-	      return OPCODE_DII;
-	    case 8:
-	      switch (Field_op1_Slot_inst_get (insn))
-		{
-		case 4:
-		  return OPCODE_DIWB;
-		case 5:
-		  return OPCODE_DIWBI;
-		}
-	      break;
-	    case 12:
-	      return OPCODE_IPF;
-	    case 14:
-	      return OPCODE_IHI;
-	    case 15:
-	      return OPCODE_III;
+	      if (Field_sr_Slot_inst_get (insn) == 0)
+		return OPCODE_XSR_LBEG;
+	      if (Field_sr_Slot_inst_get (insn) == 1)
+		return OPCODE_XSR_LEND;
+	      if (Field_sr_Slot_inst_get (insn) == 2)
+		return OPCODE_XSR_LCOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 3)
+		return OPCODE_XSR_SAR;
+	      if (Field_sr_Slot_inst_get (insn) == 4)
+		return OPCODE_XSR_BR;
+	      if (Field_sr_Slot_inst_get (insn) == 5)
+		return OPCODE_XSR_LITBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 12)
+		return OPCODE_XSR_SCOMPARE1;
+	      if (Field_sr_Slot_inst_get (insn) == 72)
+		return OPCODE_XSR_WINDOWBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 73)
+		return OPCODE_XSR_WINDOWSTART;
+	      if (Field_sr_Slot_inst_get (insn) == 83)
+		return OPCODE_XSR_PTEVADDR;
+	      if (Field_sr_Slot_inst_get (insn) == 90)
+		return OPCODE_XSR_RASID;
+	      if (Field_sr_Slot_inst_get (insn) == 91)
+		return OPCODE_XSR_ITLBCFG;
+	      if (Field_sr_Slot_inst_get (insn) == 92)
+		return OPCODE_XSR_DTLBCFG;
+	      if (Field_sr_Slot_inst_get (insn) == 99)
+		return OPCODE_XSR_ATOMCTL;
+	      if (Field_sr_Slot_inst_get (insn) == 104)
+		return OPCODE_XSR_DDR;
+	      if (Field_sr_Slot_inst_get (insn) == 177)
+		return OPCODE_XSR_EPC1;
+	      if (Field_sr_Slot_inst_get (insn) == 178)
+		return OPCODE_XSR_EPC2;
+	      if (Field_sr_Slot_inst_get (insn) == 192)
+		return OPCODE_XSR_DEPC;
+	      if (Field_sr_Slot_inst_get (insn) == 194)
+		return OPCODE_XSR_EPS2;
+	      if (Field_sr_Slot_inst_get (insn) == 209)
+		return OPCODE_XSR_EXCSAVE1;
+	      if (Field_sr_Slot_inst_get (insn) == 210)
+		return OPCODE_XSR_EXCSAVE2;
+	      if (Field_sr_Slot_inst_get (insn) == 224)
+		return OPCODE_XSR_CPENABLE;
+	      if (Field_sr_Slot_inst_get (insn) == 228)
+		return OPCODE_XSR_INTENABLE;
+	      if (Field_sr_Slot_inst_get (insn) == 230)
+		return OPCODE_XSR_PS;
+	      if (Field_sr_Slot_inst_get (insn) == 231)
+		return OPCODE_XSR_VECBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 232)
+		return OPCODE_XSR_EXCCAUSE;
+	      if (Field_sr_Slot_inst_get (insn) == 233)
+		return OPCODE_XSR_DEBUGCAUSE;
+	      if (Field_sr_Slot_inst_get (insn) == 234)
+		return OPCODE_XSR_CCOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 236)
+		return OPCODE_XSR_ICOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 237)
+		return OPCODE_XSR_ICOUNTLEVEL;
+	      if (Field_sr_Slot_inst_get (insn) == 238)
+		return OPCODE_XSR_EXCVADDR;
+	      if (Field_sr_Slot_inst_get (insn) == 240)
+		return OPCODE_XSR_CCOMPARE0;
+	      if (Field_sr_Slot_inst_get (insn) == 241)
+		return OPCODE_XSR_CCOMPARE1;
+	      if (Field_sr_Slot_inst_get (insn) == 244)
+		return OPCODE_XSR_MISC0;
+	      if (Field_sr_Slot_inst_get (insn) == 245)
+		return OPCODE_XSR_MISC1;
+	    }
+	  if (Field_op2_Slot_inst_get (insn) == 8)
+	    return OPCODE_SRC;
+	  if (Field_op2_Slot_inst_get (insn) == 9 &&
+	      Field_s_Slot_inst_get (insn) == 0)
+	    return OPCODE_SRL;
+	  if (Field_op2_Slot_inst_get (insn) == 10 &&
+	      Field_t_Slot_inst_get (insn) == 0)
+	    return OPCODE_SLL;
+	  if (Field_op2_Slot_inst_get (insn) == 11 &&
+	      Field_s_Slot_inst_get (insn) == 0)
+	    return OPCODE_SRA;
+	  if (Field_op2_Slot_inst_get (insn) == 12)
+	    return OPCODE_MUL16U;
+	  if (Field_op2_Slot_inst_get (insn) == 13)
+	    return OPCODE_MUL16S;
+	  if (Field_op2_Slot_inst_get (insn) == 15)
+	    {
+	      if (Field_r_Slot_inst_get (insn) == 0)
+		return OPCODE_LICT;
+	      if (Field_r_Slot_inst_get (insn) == 1)
+		return OPCODE_SICT;
+	      if (Field_r_Slot_inst_get (insn) == 2)
+		return OPCODE_LICW;
+	      if (Field_r_Slot_inst_get (insn) == 3)
+		return OPCODE_SICW;
+	      if (Field_r_Slot_inst_get (insn) == 8)
+		return OPCODE_LDCT;
+	      if (Field_r_Slot_inst_get (insn) == 9)
+		return OPCODE_SDCT;
+	      if (Field_r_Slot_inst_get (insn) == 14 &&
+		  Field_t_Slot_inst_get (insn) == 0)
+		return OPCODE_RFDO;
+	      if (Field_r_Slot_inst_get (insn) == 14 &&
+		  Field_t_Slot_inst_get (insn) == 1)
+		return OPCODE_RFDD;
+	      if (Field_r_Slot_inst_get (insn) == 15)
+		return OPCODE_LDPTE;
 	    }
-	  break;
-	case 9:
-	  return OPCODE_L16SI;
-	case 10:
-	  return OPCODE_MOVI;
-	case 11:
-	  return OPCODE_L32AI;
-	case 12:
-	  return OPCODE_ADDI;
-	case 13:
-	  return OPCODE_ADDMI;
-	case 14:
-	  return OPCODE_S32C1I;
-	case 15:
-	  return OPCODE_S32RI;
-	}
-      break;
-    case 4:
-      switch (Field_ae_r10_Slot_inst_get (insn))
-	{
-	case 0:
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ56_I;
-	  if (Field_op1_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ56_X;
-	  break;
-	case 1:
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ32F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ32F_X;
-	  break;
-	case 2:
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ56_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ56_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_t_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_CVTQ48A32S;
-	  break;
-	case 3:
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ32F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LQ32F_XU;
-	  break;
-	}
-      switch (Field_ae_r3_Slot_inst_get (insn))
-	{
-	case 0:
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 12 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 15 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16F_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 6 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 13 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 0 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_LP24F_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24X2F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 11 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24X2F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 14 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24X2F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_LP24X2F_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16X2F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16X2F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 8 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16X2F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 11 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16X2F_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 6 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 12 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2F_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 4 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24S_L_I;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24S_L_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24S_L_X;
-	  if (Field_op1_Slot_inst_get (insn) == 13 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24S_L_XU;
-	  if (Field_ae_s3_Slot_inst_get (insn) == 0 &&
-	      Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_MOVP48;
-	  if (Field_op1_Slot_inst_get (insn) == 0 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_MOVPA24X2;
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 11 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_CVTA32P24_L;
-	  if (Field_op1_Slot_inst_get (insn) == 14 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_CVTP24A16X2_LL;
-	  if (Field_op1_Slot_inst_get (insn) == 15 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_CVTP24A16X2_HL;
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_MOVAP24S_L;
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 8 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_TRUNCA16P24S_L;
-	  break;
-	case 1:
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24_I;
-	  if (Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 12 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24_X;
-	  if (Field_op1_Slot_inst_get (insn) == 15 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 6 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16X2F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16X2F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 13 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP16X2F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 0 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_LP16X2F_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24X2_I;
-	  if (Field_op1_Slot_inst_get (insn) == 11 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24X2_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 14 &&
-	      Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LP24X2_X;
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_LP24X2_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2S_I;
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2S_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 8 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2S_X;
-	  if (Field_op1_Slot_inst_get (insn) == 11 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24X2S_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16F_L_I;
-	  if (Field_op1_Slot_inst_get (insn) == 6 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16F_L_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16F_L_X;
-	  if (Field_op1_Slot_inst_get (insn) == 12 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP16F_L_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 4 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24F_L_I;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24F_L_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24F_L_X;
-	  if (Field_op1_Slot_inst_get (insn) == 13 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_SP24F_L_XU;
-	  if (Field_op1_Slot_inst_get (insn) == 0 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_TRUNCP24A32X2;
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 11 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_CVTA32P24_H;
-	  if (Field_op1_Slot_inst_get (insn) == 14 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_CVTP24A16X2_LH;
-	  if (Field_op1_Slot_inst_get (insn) == 15 &&
-	      Field_op2_Slot_inst_get (insn) == 11)
-	    return OPCODE_AE_CVTP24A16X2_HH;
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_MOVAP24S_H;
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 8 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_TRUNCA16P24S_H;
-	  break;
-	}
-      switch (Field_ae_r32_Slot_inst_get (insn))
-	{
-	case 0:
-	  if (Field_op1_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ56S_I;
-	  if (Field_op1_Slot_inst_get (insn) == 4 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ56S_X;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_TRUNCA32Q48;
-	  break;
-	case 1:
-	  if (Field_op1_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ32F_I;
-	  if (Field_op1_Slot_inst_get (insn) == 4 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ32F_X;
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_NSAQ56S;
-	  break;
-	case 2:
-	  if (Field_op1_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ56S_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 4 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ56S_XU;
-	  break;
-	case 3:
-	  if (Field_op1_Slot_inst_get (insn) == 3 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ32F_IU;
-	  if (Field_op1_Slot_inst_get (insn) == 4 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SQ32F_XU;
-	  break;
 	}
-      switch (Field_ae_s_non_samt_Slot_inst_get (insn))
+      if (Field_op1_Slot_inst_get (insn) == 2)
 	{
-	case 0:
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SLLIQ56;
-	  break;
-	case 1:
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SRLIQ56;
-	  break;
-	case 2:
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SRAIQ56;
-	  break;
-	case 3:
-	  if (Field_op1_Slot_inst_get (insn) == 5 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SLLISQ56S;
-	  break;
+	  if (Field_op2_Slot_inst_get (insn) == 0)
+	    return OPCODE_ANDB;
+	  if (Field_op2_Slot_inst_get (insn) == 1)
+	    return OPCODE_ANDBC;
+	  if (Field_op2_Slot_inst_get (insn) == 2)
+	    return OPCODE_ORB;
+	  if (Field_op2_Slot_inst_get (insn) == 3)
+	    return OPCODE_ORBC;
+	  if (Field_op2_Slot_inst_get (insn) == 4)
+	    return OPCODE_XORB;
+	  if (Field_op2_Slot_inst_get (insn) == 8)
+	    return OPCODE_MULL;
 	}
-      switch (Field_op1_Slot_inst_get (insn))
+      if (Field_op1_Slot_inst_get (insn) == 3)
 	{
-	case 0:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_SHA32;
-	  if (Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_VLDL32T;
-	  break;
-	case 1:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_SLLAQ56;
-	  if (Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_VLDL16T;
-	  break;
-	case 2:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_SRLAQ56;
-	  if (Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_LBK;
-	  break;
-	case 3:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_SRAAQ56;
-	  if (Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_VLEL32T;
-	  break;
-	case 4:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_SLLASQ56S;
+	  if (Field_op2_Slot_inst_get (insn) == 0)
+	    {
+	      if (Field_sr_Slot_inst_get (insn) == 0)
+		return OPCODE_RSR_LBEG;
+	      if (Field_sr_Slot_inst_get (insn) == 1)
+		return OPCODE_RSR_LEND;
+	      if (Field_sr_Slot_inst_get (insn) == 2)
+		return OPCODE_RSR_LCOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 3)
+		return OPCODE_RSR_SAR;
+	      if (Field_sr_Slot_inst_get (insn) == 4)
+		return OPCODE_RSR_BR;
+	      if (Field_sr_Slot_inst_get (insn) == 5)
+		return OPCODE_RSR_LITBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 12)
+		return OPCODE_RSR_SCOMPARE1;
+	      if (Field_sr_Slot_inst_get (insn) == 72)
+		return OPCODE_RSR_WINDOWBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 73)
+		return OPCODE_RSR_WINDOWSTART;
+	      if (Field_sr_Slot_inst_get (insn) == 83)
+		return OPCODE_RSR_PTEVADDR;
+	      if (Field_sr_Slot_inst_get (insn) == 90)
+		return OPCODE_RSR_RASID;
+	      if (Field_sr_Slot_inst_get (insn) == 91)
+		return OPCODE_RSR_ITLBCFG;
+	      if (Field_sr_Slot_inst_get (insn) == 92)
+		return OPCODE_RSR_DTLBCFG;
+	      if (Field_sr_Slot_inst_get (insn) == 99)
+		return OPCODE_RSR_ATOMCTL;
+	      if (Field_sr_Slot_inst_get (insn) == 104)
+		return OPCODE_RSR_DDR;
+	      if (Field_sr_Slot_inst_get (insn) == 176)
+		return OPCODE_RSR_CONFIGID0;
+	      if (Field_sr_Slot_inst_get (insn) == 177)
+		return OPCODE_RSR_EPC1;
+	      if (Field_sr_Slot_inst_get (insn) == 178)
+		return OPCODE_RSR_EPC2;
+	      if (Field_sr_Slot_inst_get (insn) == 192)
+		return OPCODE_RSR_DEPC;
+	      if (Field_sr_Slot_inst_get (insn) == 194)
+		return OPCODE_RSR_EPS2;
+	      if (Field_sr_Slot_inst_get (insn) == 208)
+		return OPCODE_RSR_CONFIGID1;
+	      if (Field_sr_Slot_inst_get (insn) == 209)
+		return OPCODE_RSR_EXCSAVE1;
+	      if (Field_sr_Slot_inst_get (insn) == 210)
+		return OPCODE_RSR_EXCSAVE2;
+	      if (Field_sr_Slot_inst_get (insn) == 224)
+		return OPCODE_RSR_CPENABLE;
+	      if (Field_sr_Slot_inst_get (insn) == 226)
+		return OPCODE_RSR_INTERRUPT;
+	      if (Field_sr_Slot_inst_get (insn) == 228)
+		return OPCODE_RSR_INTENABLE;
+	      if (Field_sr_Slot_inst_get (insn) == 230)
+		return OPCODE_RSR_PS;
+	      if (Field_sr_Slot_inst_get (insn) == 231)
+		return OPCODE_RSR_VECBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 232)
+		return OPCODE_RSR_EXCCAUSE;
+	      if (Field_sr_Slot_inst_get (insn) == 233)
+		return OPCODE_RSR_DEBUGCAUSE;
+	      if (Field_sr_Slot_inst_get (insn) == 234)
+		return OPCODE_RSR_CCOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 235)
+		return OPCODE_RSR_PRID;
+	      if (Field_sr_Slot_inst_get (insn) == 236)
+		return OPCODE_RSR_ICOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 237)
+		return OPCODE_RSR_ICOUNTLEVEL;
+	      if (Field_sr_Slot_inst_get (insn) == 238)
+		return OPCODE_RSR_EXCVADDR;
+	      if (Field_sr_Slot_inst_get (insn) == 240)
+		return OPCODE_RSR_CCOMPARE0;
+	      if (Field_sr_Slot_inst_get (insn) == 241)
+		return OPCODE_RSR_CCOMPARE1;
+	      if (Field_sr_Slot_inst_get (insn) == 244)
+		return OPCODE_RSR_MISC0;
+	      if (Field_sr_Slot_inst_get (insn) == 245)
+		return OPCODE_RSR_MISC1;
+	    }
+	  if (Field_op2_Slot_inst_get (insn) == 1)
+	    {
+	      if (Field_sr_Slot_inst_get (insn) == 0)
+		return OPCODE_WSR_LBEG;
+	      if (Field_sr_Slot_inst_get (insn) == 1)
+		return OPCODE_WSR_LEND;
+	      if (Field_sr_Slot_inst_get (insn) == 2)
+		return OPCODE_WSR_LCOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 3)
+		return OPCODE_WSR_SAR;
+	      if (Field_sr_Slot_inst_get (insn) == 4)
+		return OPCODE_WSR_BR;
+	      if (Field_sr_Slot_inst_get (insn) == 5)
+		return OPCODE_WSR_LITBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 12)
+		return OPCODE_WSR_SCOMPARE1;
+	      if (Field_sr_Slot_inst_get (insn) == 72)
+		return OPCODE_WSR_WINDOWBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 73)
+		return OPCODE_WSR_WINDOWSTART;
+	      if (Field_sr_Slot_inst_get (insn) == 83)
+		return OPCODE_WSR_PTEVADDR;
+	      if (Field_sr_Slot_inst_get (insn) == 90)
+		return OPCODE_WSR_RASID;
+	      if (Field_sr_Slot_inst_get (insn) == 91)
+		return OPCODE_WSR_ITLBCFG;
+	      if (Field_sr_Slot_inst_get (insn) == 92)
+		return OPCODE_WSR_DTLBCFG;
+	      if (Field_sr_Slot_inst_get (insn) == 99)
+		return OPCODE_WSR_ATOMCTL;
+	      if (Field_sr_Slot_inst_get (insn) == 104)
+		return OPCODE_WSR_DDR;
+	      if (Field_sr_Slot_inst_get (insn) == 176)
+		return OPCODE_WSR_CONFIGID0;
+	      if (Field_sr_Slot_inst_get (insn) == 177)
+		return OPCODE_WSR_EPC1;
+	      if (Field_sr_Slot_inst_get (insn) == 178)
+		return OPCODE_WSR_EPC2;
+	      if (Field_sr_Slot_inst_get (insn) == 192)
+		return OPCODE_WSR_DEPC;
+	      if (Field_sr_Slot_inst_get (insn) == 194)
+		return OPCODE_WSR_EPS2;
+	      if (Field_sr_Slot_inst_get (insn) == 209)
+		return OPCODE_WSR_EXCSAVE1;
+	      if (Field_sr_Slot_inst_get (insn) == 210)
+		return OPCODE_WSR_EXCSAVE2;
+	      if (Field_sr_Slot_inst_get (insn) == 224)
+		return OPCODE_WSR_CPENABLE;
+	      if (Field_sr_Slot_inst_get (insn) == 226)
+		return OPCODE_WSR_INTSET;
+	      if (Field_sr_Slot_inst_get (insn) == 227)
+		return OPCODE_WSR_INTCLEAR;
+	      if (Field_sr_Slot_inst_get (insn) == 228)
+		return OPCODE_WSR_INTENABLE;
+	      if (Field_sr_Slot_inst_get (insn) == 230)
+		return OPCODE_WSR_PS;
+	      if (Field_sr_Slot_inst_get (insn) == 231)
+		return OPCODE_WSR_VECBASE;
+	      if (Field_sr_Slot_inst_get (insn) == 232)
+		return OPCODE_WSR_EXCCAUSE;
+	      if (Field_sr_Slot_inst_get (insn) == 233)
+		return OPCODE_WSR_DEBUGCAUSE;
+	      if (Field_sr_Slot_inst_get (insn) == 234)
+		return OPCODE_WSR_CCOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 236)
+		return OPCODE_WSR_ICOUNT;
+	      if (Field_sr_Slot_inst_get (insn) == 237)
+		return OPCODE_WSR_ICOUNTLEVEL;
+	      if (Field_sr_Slot_inst_get (insn) == 238)
+		return OPCODE_WSR_EXCVADDR;
+	      if (Field_sr_Slot_inst_get (insn) == 240)
+		return OPCODE_WSR_CCOMPARE0;
+	      if (Field_sr_Slot_inst_get (insn) == 241)
+		return OPCODE_WSR_CCOMPARE1;
+	      if (Field_sr_Slot_inst_get (insn) == 244)
+		return OPCODE_WSR_MISC0;
+	      if (Field_sr_Slot_inst_get (insn) == 245)
+		return OPCODE_WSR_MISC1;
+	    }
+	  if (Field_op2_Slot_inst_get (insn) == 2)
+	    return OPCODE_SEXT;
+	  if (Field_op2_Slot_inst_get (insn) == 3)
+	    return OPCODE_CLAMPS;
+	  if (Field_op2_Slot_inst_get (insn) == 4)
+	    return OPCODE_MIN;
+	  if (Field_op2_Slot_inst_get (insn) == 5)
+	    return OPCODE_MAX;
+	  if (Field_op2_Slot_inst_get (insn) == 6)
+	    return OPCODE_MINU;
+	  if (Field_op2_Slot_inst_get (insn) == 7)
+	    return OPCODE_MAXU;
+	  if (Field_op2_Slot_inst_get (insn) == 8)
+	    return OPCODE_MOVEQZ;
+	  if (Field_op2_Slot_inst_get (insn) == 9)
+	    return OPCODE_MOVNEZ;
 	  if (Field_op2_Slot_inst_get (insn) == 10)
-	    return OPCODE_AE_VLEL16T;
-	  break;
-	case 5:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_MOVTQ56;
-	  break;
-	case 6:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_MOVFQ56;
-	  break;
+	    return OPCODE_MOVLTZ;
+	  if (Field_op2_Slot_inst_get (insn) == 11)
+	    return OPCODE_MOVGEZ;
+	  if (Field_op2_Slot_inst_get (insn) == 12)
+	    return OPCODE_MOVF;
+	  if (Field_op2_Slot_inst_get (insn) == 13)
+	    return OPCODE_MOVT;
+	  if (Field_op2_Slot_inst_get (insn) == 14)
+	    {
+	      if (Field_st_Slot_inst_get (insn) == 231)
+		return OPCODE_RUR_THREADPTR;
+	      if (Field_st_Slot_inst_get (insn) == 240)
+		return OPCODE_RUR_AE_OVF_SAR;
+	      if (Field_st_Slot_inst_get (insn) == 241)
+		return OPCODE_RUR_AE_BITHEAD;
+	      if (Field_st_Slot_inst_get (insn) == 242)
+		return OPCODE_RUR_AE_TS_FTS_BU_BP;
+	      if (Field_st_Slot_inst_get (insn) == 243)
+		return OPCODE_RUR_AE_SD_NO;
+	    }
+	  if (Field_op2_Slot_inst_get (insn) == 15)
+	    {
+	      if (Field_sr_Slot_inst_get (insn) == 231)
+		return OPCODE_WUR_THREADPTR;
+	      if (Field_sr_Slot_inst_get (insn) == 240)
+		return OPCODE_WUR_AE_OVF_SAR;
+	      if (Field_sr_Slot_inst_get (insn) == 241)
+		return OPCODE_WUR_AE_BITHEAD;
+	      if (Field_sr_Slot_inst_get (insn) == 242)
+		return OPCODE_WUR_AE_TS_FTS_BU_BP;
+	      if (Field_sr_Slot_inst_get (insn) == 243)
+		return OPCODE_WUR_AE_SD_NO;
+	    }
 	}
-      switch (Field_r_Slot_inst_get (insn))
+      if ((Field_op1_Slot_inst_get (insn) == 4 ||
+	   Field_op1_Slot_inst_get (insn) == 5))
+	return OPCODE_EXTUI;
+      if (Field_op1_Slot_inst_get (insn) == 9)
 	{
-	case 0:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_OVERFLOW;
-	  if (Field_op2_Slot_inst_get (insn) == 15)
-	    return OPCODE_AE_SBI;
-	  break;
-	case 1:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_SAR;
-	  if (Field_op1_Slot_inst_get (insn) == 0 &&
-	      Field_op2_Slot_inst_get (insn) == 15)
-	    return OPCODE_AE_DB;
-	  if (Field_op1_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 15)
-	    return OPCODE_AE_SB;
-	  break;
-	case 2:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_BITPTR;
-	  break;
-	case 3:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_BITSUSED;
-	  break;
-	case 4:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_TABLESIZE;
-	  break;
-	case 5:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_FIRST_TS;
-	  break;
-	case 6:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_NEXTOFFSET;
-	  break;
-	case 7:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_WUR_AE_SEARCHDONE;
-	  break;
-	case 8:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 10 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_VLDSHT;
-	  break;
-	case 12:
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_VLES16C;
-	  break;
-	case 13:
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_SBF;
-	  break;
-	case 14:
-	  if (Field_op1_Slot_inst_get (insn) == 7 &&
-	      Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_VLDL16C;
-	  break;
+	  if (Field_op2_Slot_inst_get (insn) == 0)
+	    return OPCODE_L32E;
+	  if (Field_op2_Slot_inst_get (insn) == 4)
+	    return OPCODE_S32E;
 	}
-      switch (Field_s_Slot_inst_get (insn))
+    }
+  if (Field_op0_Slot_inst_get (insn) == 1)
+    return OPCODE_L32R;
+  if (Field_op0_Slot_inst_get (insn) == 2)
+    {
+      if (Field_r_Slot_inst_get (insn) == 0)
+	return OPCODE_L8UI;
+      if (Field_r_Slot_inst_get (insn) == 1)
+	return OPCODE_L16UI;
+      if (Field_r_Slot_inst_get (insn) == 2)
+	return OPCODE_L32I;
+      if (Field_r_Slot_inst_get (insn) == 4)
+	return OPCODE_S8I;
+      if (Field_r_Slot_inst_get (insn) == 5)
+	return OPCODE_S16I;
+      if (Field_r_Slot_inst_get (insn) == 6)
+	return OPCODE_S32I;
+      if (Field_r_Slot_inst_get (insn) == 7)
 	{
-	case 0:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SLLSQ56;
-	  if (Field_op1_Slot_inst_get (insn) == 6 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_LB;
-	  break;
-	case 1:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SRLSQ56;
-	  break;
-	case 2:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SRASQ56;
-	  break;
-	case 3:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_SLLSSQ56S;
-	  break;
-	case 4:
-	  if (Field_t_Slot_inst_get (insn) == 1 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_AE_MOVQ56;
-	  break;
-	case 8:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_OVERFLOW;
-	  break;
-	case 9:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_SAR;
-	  break;
-	case 10:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_BITPTR;
-	  break;
-	case 11:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_BITSUSED;
-	  break;
-	case 12:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_TABLESIZE;
-	  break;
-	case 13:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_FIRST_TS;
-	  break;
-	case 14:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_NEXTOFFSET;
-	  break;
-	case 15:
-	  if (Field_t_Slot_inst_get (insn) == 0 &&
-	      Field_op1_Slot_inst_get (insn) == 9 &&
-	      Field_op2_Slot_inst_get (insn) == 12)
-	    return OPCODE_RUR_AE_SEARCHDONE;
-	  break;
+	  if (Field_t_Slot_inst_get (insn) == 0)
+	    return OPCODE_DPFR;
+	  if (Field_t_Slot_inst_get (insn) == 1)
+	    return OPCODE_DPFW;
+	  if (Field_t_Slot_inst_get (insn) == 2)
+	    return OPCODE_DPFRO;
+	  if (Field_t_Slot_inst_get (insn) == 3)
+	    return OPCODE_DPFWO;
+	  if (Field_t_Slot_inst_get (insn) == 4)
+	    return OPCODE_DHWB;
+	  if (Field_t_Slot_inst_get (insn) == 5)
+	    return OPCODE_DHWBI;
+	  if (Field_t_Slot_inst_get (insn) == 6)
+	    return OPCODE_DHI;
+	  if (Field_t_Slot_inst_get (insn) == 7)
+	    return OPCODE_DII;
+	  if (Field_t_Slot_inst_get (insn) == 8)
+	    {
+	      if (Field_op1_Slot_inst_get (insn) == 4)
+		return OPCODE_DIWB;
+	      if (Field_op1_Slot_inst_get (insn) == 5)
+		return OPCODE_DIWBI;
+	    }
+	  if (Field_t_Slot_inst_get (insn) == 12)
+	    return OPCODE_IPF;
+	  if (Field_t_Slot_inst_get (insn) == 14)
+	    return OPCODE_IHI;
+	  if (Field_t_Slot_inst_get (insn) == 15)
+	    return OPCODE_III;
 	}
-      switch (Field_t_Slot_inst_get (insn))
+      if (Field_r_Slot_inst_get (insn) == 9)
+	return OPCODE_L16SI;
+      if (Field_r_Slot_inst_get (insn) == 10)
+	return OPCODE_MOVI;
+      if (Field_r_Slot_inst_get (insn) == 11)
+	return OPCODE_L32AI;
+      if (Field_r_Slot_inst_get (insn) == 12)
+	return OPCODE_ADDI;
+      if (Field_r_Slot_inst_get (insn) == 13)
+	return OPCODE_ADDMI;
+      if (Field_r_Slot_inst_get (insn) == 14)
+	return OPCODE_S32C1I;
+      if (Field_r_Slot_inst_get (insn) == 15)
+	return OPCODE_S32RI;
+    }
+  if (Field_op0_Slot_inst_get (insn) == 4)
+    {
+      if (Field_ae_r10_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ56_I;
+      if (Field_ae_r10_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ56_X;
+      if (Field_ae_r10_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ32F_I;
+      if (Field_ae_r10_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ32F_X;
+      if (Field_ae_r10_Slot_inst_get (insn) == 2 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ56_IU;
+      if (Field_ae_r10_Slot_inst_get (insn) == 2 &&
+	  Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ56_XU;
+      if (Field_ae_r10_Slot_inst_get (insn) == 2 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_t_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_CVTQ48A32S;
+      if (Field_ae_r10_Slot_inst_get (insn) == 3 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ32F_IU;
+      if (Field_ae_r10_Slot_inst_get (insn) == 3 &&
+	  Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LQ32F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16F_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16F_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 12 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16F_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 15 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 6 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24F_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24F_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 13 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24F_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_LP24F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24X2F_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 11 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24X2F_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 14 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24X2F_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_LP24X2F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16X2F_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16X2F_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 8 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16X2F_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 11 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16X2F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2F_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 6 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2F_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2F_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 12 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24S_L_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24S_L_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24S_L_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 13 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24S_L_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_ae_s3_Slot_inst_get (insn) == 0 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_MOVP48;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_MOVPA24X2;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 11 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_CVTA32P24_L;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 14 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_CVTP24A16X2_LL;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 15 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_CVTP24A16X2_HL;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_MOVAP24S_L;
+      if (Field_ae_r3_Slot_inst_get (insn) == 0 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 8 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_TRUNCA16P24S_L;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 12 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 15 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 6 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16X2F_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16X2F_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 13 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP16X2F_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_LP16X2F_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24X2_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 11 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24X2_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 14 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LP24X2_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_LP24X2_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2S_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2S_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 8 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2S_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 11 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24X2S_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16F_L_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 6 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16F_L_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16F_L_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 12 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP16F_L_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24F_L_I;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24F_L_IU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24F_L_X;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 13 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_SP24F_L_XU;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_TRUNCP24A32X2;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 11 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_CVTA32P24_H;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 14 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_CVTP24A16X2_LH;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 15 &&
+	  Field_op2_Slot_inst_get (insn) == 11)
+	return OPCODE_AE_CVTP24A16X2_HH;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_MOVAP24S_H;
+      if (Field_ae_r3_Slot_inst_get (insn) == 1 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 8 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_TRUNCA16P24S_H;
+      if (Field_ae_r32_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ56S_I;
+      if (Field_ae_r32_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ56S_X;
+      if (Field_ae_r32_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_TRUNCA32Q48;
+      if (Field_ae_r32_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ32F_I;
+      if (Field_ae_r32_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ32F_X;
+      if (Field_ae_r32_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_NSAQ56S;
+      if (Field_ae_r32_Slot_inst_get (insn) == 2 &&
+	  Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ56S_IU;
+      if (Field_ae_r32_Slot_inst_get (insn) == 2 &&
+	  Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ56S_XU;
+      if (Field_ae_r32_Slot_inst_get (insn) == 3 &&
+	  Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ32F_IU;
+      if (Field_ae_r32_Slot_inst_get (insn) == 3 &&
+	  Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SQ32F_XU;
+      if (Field_ae_s_non_samt_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SLLIQ56;
+      if (Field_ae_s_non_samt_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SRLIQ56;
+      if (Field_ae_s_non_samt_Slot_inst_get (insn) == 2 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SRAIQ56;
+      if (Field_ae_s_non_samt_Slot_inst_get (insn) == 3 &&
+	  Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SLLISQ56S;
+      if (Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_SHA32;
+      if (Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_VLDL32T;
+      if (Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_SLLAQ56;
+      if (Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_VLDL16T;
+      if (Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_SRLAQ56;
+      if (Field_op1_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_LBK;
+      if (Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_SRAAQ56;
+      if (Field_op1_Slot_inst_get (insn) == 3 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_VLEL32T;
+      if (Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_SLLASQ56S;
+      if (Field_op1_Slot_inst_get (insn) == 4 &&
+	  Field_op2_Slot_inst_get (insn) == 10)
+	return OPCODE_AE_VLEL16T;
+      if (Field_op1_Slot_inst_get (insn) == 5 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_MOVTQ56;
+      if (Field_op1_Slot_inst_get (insn) == 6 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_MOVFQ56;
+      if (Field_r_Slot_inst_get (insn) == 0 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_OVERFLOW;
+      if (Field_r_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 15)
+	return OPCODE_AE_SBI;
+      if (Field_r_Slot_inst_get (insn) == 1 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_SAR;
+      if (Field_r_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 15)
+	return OPCODE_AE_DB;
+      if (Field_r_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 15)
+	return OPCODE_AE_SB;
+      if (Field_r_Slot_inst_get (insn) == 2 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_BITPTR;
+      if (Field_r_Slot_inst_get (insn) == 3 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_BITSUSED;
+      if (Field_r_Slot_inst_get (insn) == 4 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_TABLESIZE;
+      if (Field_r_Slot_inst_get (insn) == 5 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_FIRST_TS;
+      if (Field_r_Slot_inst_get (insn) == 6 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_NEXTOFFSET;
+      if (Field_r_Slot_inst_get (insn) == 7 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_WUR_AE_SEARCHDONE;
+      if (Field_r_Slot_inst_get (insn) == 8 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 10 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_VLDSHT;
+      if (Field_r_Slot_inst_get (insn) == 12 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_VLES16C;
+      if (Field_r_Slot_inst_get (insn) == 13 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_SBF;
+      if (Field_r_Slot_inst_get (insn) == 14 &&
+	  Field_op1_Slot_inst_get (insn) == 7 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_VLDL16C;
+      if (Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SLLSQ56;
+      if (Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 6 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_LB;
+      if (Field_s_Slot_inst_get (insn) == 1 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SRLSQ56;
+      if (Field_s_Slot_inst_get (insn) == 2 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SRASQ56;
+      if (Field_s_Slot_inst_get (insn) == 3 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_SLLSSQ56S;
+      if (Field_s_Slot_inst_get (insn) == 4 &&
+	  Field_t_Slot_inst_get (insn) == 1 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_AE_MOVQ56;
+      if (Field_s_Slot_inst_get (insn) == 8 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_OVERFLOW;
+      if (Field_s_Slot_inst_get (insn) == 9 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_SAR;
+      if (Field_s_Slot_inst_get (insn) == 10 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_BITPTR;
+      if (Field_s_Slot_inst_get (insn) == 11 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_BITSUSED;
+      if (Field_s_Slot_inst_get (insn) == 12 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_TABLESIZE;
+      if (Field_s_Slot_inst_get (insn) == 13 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_FIRST_TS;
+      if (Field_s_Slot_inst_get (insn) == 14 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_NEXTOFFSET;
+      if (Field_s_Slot_inst_get (insn) == 15 &&
+	  Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op1_Slot_inst_get (insn) == 9 &&
+	  Field_op2_Slot_inst_get (insn) == 12)
+	return OPCODE_RUR_AE_SEARCHDONE;
+      if (Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_LBKI;
+      if (Field_t_Slot_inst_get (insn) == 0 &&
+	  Field_r_Slot_inst_get (insn) == 2 &&
+	  Field_op2_Slot_inst_get (insn) == 15)
+	return OPCODE_AE_DBI;
+      if (Field_t_Slot_inst_get (insn) == 2 &&
+	  Field_s_Slot_inst_get (insn) == 0 &&
+	  Field_op2_Slot_inst_get (insn) == 14)
+	return OPCODE_AE_LBI;
+    }
+  if (Field_op0_Slot_inst_get (insn) == 5)
+    {
+      if (Field_n_Slot_inst_get (insn) == 0)
+	return OPCODE_CALL0;
+      if (Field_n_Slot_inst_get (insn) == 1)
+	return OPCODE_CALL4;
+      if (Field_n_Slot_inst_get (insn) == 2)
+	return OPCODE_CALL8;
+      if (Field_n_Slot_inst_get (insn) == 3)
+	return OPCODE_CALL12;
+    }
+  if (Field_op0_Slot_inst_get (insn) == 6)
+    {
+      if (Field_n_Slot_inst_get (insn) == 0)
+	return OPCODE_J;
+      if (Field_n_Slot_inst_get (insn) == 1)
 	{
-	case 0:
-	  if (Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_LBKI;
-	  if (Field_r_Slot_inst_get (insn) == 2 &&
-	      Field_op2_Slot_inst_get (insn) == 15)
-	    return OPCODE_AE_DBI;
-	  break;
-	case 2:
-	  if (Field_s_Slot_inst_get (insn) == 0 &&
-	      Field_op2_Slot_inst_get (insn) == 14)
-	    return OPCODE_AE_LBI;
-	  break;
+	  if (Field_m_Slot_inst_get (insn) == 0)
+	    return OPCODE_BEQZ;
+	  if (Field_m_Slot_inst_get (insn) == 1)
+	    return OPCODE_BNEZ;
+	  if (Field_m_Slot_inst_get (insn) == 2)
+	    return OPCODE_BLTZ;
+	  if (Field_m_Slot_inst_get (insn) == 3)
+	    return OPCODE_BGEZ;
 	}
-      break;
-    case 5:
-      switch (Field_n_Slot_inst_get (insn))
+      if (Field_n_Slot_inst_get (insn) == 2)
 	{
-	case 0:
-	  return OPCODE_CALL0;
-	case 1:
-	  return OPCODE_CALL4;
-	case 2:
-	  return OPCODE_CALL8;
-	case 3:
-	  return OPCODE_CALL12;
+	  if (Field_m_Slot_inst_get (insn) == 0)
+	    return OPCODE_BEQI;
+	  if (Field_m_Slot_inst_get (insn) == 1)
+	    return OPCODE_BNEI;
+	  if (Field_m_Slot_inst_get (insn) == 2)
+	    return OPCODE_BLTI;
+	  if (Field_m_Slot_inst_get (insn) == 3)
+	    return OPCODE_BGEI;
 	}
-      break;
-    case 6:
-      switch (Field_n_Slot_inst_get (insn))
+      if (Field_n_Slot_inst_get (insn) == 3)
 	{
-	case 0:
-	  return OPCODE_J;
-	case 1:
-	  switch (Field_m_Slot_inst_get (insn))
-	    {
-	    case 0:
-	      return OPCODE_BEQZ;
-	    case 1:
-	      return OPCODE_BNEZ;
-	    case 2:
-	      return OPCODE_BLTZ;
-	    case 3:
-	      return OPCODE_BGEZ;
-	    }
-	  break;
-	case 2:
-	  switch (Field_m_Slot_inst_get (insn))
-	    {
-	    case 0:
-	      return OPCODE_BEQI;
-	    case 1:
-	      return OPCODE_BNEI;
-	    case 2:
-	      return OPCODE_BLTI;
-	    case 3:
-	      return OPCODE_BGEI;
-	    }
-	  break;
-	case 3:
-	  switch (Field_m_Slot_inst_get (insn))
+	  if (Field_m_Slot_inst_get (insn) == 0)
+	    return OPCODE_ENTRY;
+	  if (Field_m_Slot_inst_get (insn) == 1)
 	    {
-	    case 0:
-	      return OPCODE_ENTRY;
-	    case 1:
-	      switch (Field_r_Slot_inst_get (insn))
-		{
-		case 0:
-		  return OPCODE_BF;
-		case 1:
-		  return OPCODE_BT;
-		case 8:
-		  return OPCODE_LOOP;
-		case 9:
-		  return OPCODE_LOOPNEZ;
-		case 10:
-		  return OPCODE_LOOPGTZ;
-		}
-	      break;
-	    case 2:
-	      return OPCODE_BLTUI;
-	    case 3:
-	      return OPCODE_BGEUI;
+	      if (Field_r_Slot_inst_get (insn) == 0)
+		return OPCODE_BF;
+	      if (Field_r_Slot_inst_get (insn) == 1)
+		return OPCODE_BT;
+	      if (Field_r_Slot_inst_get (insn) == 8)
+		return OPCODE_LOOP;
+	      if (Field_r_Slot_inst_get (insn) == 9)
+		return OPCODE_LOOPNEZ;
+	      if (Field_r_Slot_inst_get (insn) == 10)
+		return OPCODE_LOOPGTZ;
 	    }
-	  break;
+	  if (Field_m_Slot_inst_get (insn) == 2)
+	    return OPCODE_BLTUI;
+	  if (Field_m_Slot_inst_get (insn) == 3)
+	    return OPCODE_BGEUI;
 	}
-      break;
-    case 7:
-      switch (Field_r_Slot_inst_get (insn))
-	{
-	case 0:
-	  return OPCODE_BNONE;
-	case 1:
-	  return OPCODE_BEQ;
-	case 2:
-	  return OPCODE_BLT;
-	case 3:
-	  return OPCODE_BLTU;
-	case 4:
-	  return OPCODE_BALL;
-	case 5:
-	  return OPCODE_BBC;
-	case 6:
-	case 7:
-	  return OPCODE_BBCI;
-	case 8:
-	  return OPCODE_BANY;
-	case 9:
-	  return OPCODE_BNE;
-	case 10:
-	  return OPCODE_BGE;
-	case 11:
-	  return OPCODE_BGEU;
-	case 12:
-	  return OPCODE_BNALL;
-	case 13:
-	  return OPCODE_BBS;
-	case 14:
-	case 15:
-	  return OPCODE_BBSI;
-	}
-      break;
+    }
+  if (Field_op0_Slot_inst_get (insn) == 7)
+    {
+      if (Field_r_Slot_inst_get (insn) == 0)
+	return OPCODE_BNONE;
+      if (Field_r_Slot_inst_get (insn) == 1)
+	return OPCODE_BEQ;
+      if (Field_r_Slot_inst_get (insn) == 2)
+	return OPCODE_BLT;
+      if (Field_r_Slot_inst_get (insn) == 3)
+	return OPCODE_BLTU;
+      if (Field_r_Slot_inst_get (insn) == 4)
+	return OPCODE_BALL;
+      if (Field_r_Slot_inst_get (insn) == 5)
+	return OPCODE_BBC;
+      if ((Field_r_Slot_inst_get (insn) == 6 ||
+	   Field_r_Slot_inst_get (insn) == 7))
+	return OPCODE_BBCI;
+      if (Field_r_Slot_inst_get (insn) == 8)
+	return OPCODE_BANY;
+      if (Field_r_Slot_inst_get (insn) == 9)
+	return OPCODE_BNE;
+      if (Field_r_Slot_inst_get (insn) == 10)
+	return OPCODE_BGE;
+      if (Field_r_Slot_inst_get (insn) == 11)
+	return OPCODE_BGEU;
+      if (Field_r_Slot_inst_get (insn) == 12)
+	return OPCODE_BNALL;
+      if (Field_r_Slot_inst_get (insn) == 13)
+	return OPCODE_BBS;
+      if ((Field_r_Slot_inst_get (insn) == 14 ||
+	   Field_r_Slot_inst_get (insn) == 15))
+	return OPCODE_BBSI;
     }
   return XTENSA_UNDEFINED;
 }
@@ -30824,50 +30653,37 @@ Slot_inst_decode (const xtensa_insnbuf insn)
 static int
 Slot_inst16b_decode (const xtensa_insnbuf insn)
 {
-  switch (Field_op0_Slot_inst16b_get (insn))
+  if (Field_op0_Slot_inst16b_get (insn) == 12)
     {
-    case 12:
-      switch (Field_i_Slot_inst16b_get (insn))
+      if (Field_i_Slot_inst16b_get (insn) == 0)
+	return OPCODE_MOVI_N;
+      if (Field_i_Slot_inst16b_get (insn) == 1)
 	{
-	case 0:
-	  return OPCODE_MOVI_N;
-	case 1:
-	  switch (Field_z_Slot_inst16b_get (insn))
-	    {
-	    case 0:
-	      return OPCODE_BEQZ_N;
-	    case 1:
-	      return OPCODE_BNEZ_N;
-	    }
-	  break;
+	  if (Field_z_Slot_inst16b_get (insn) == 0)
+	    return OPCODE_BEQZ_N;
+	  if (Field_z_Slot_inst16b_get (insn) == 1)
+	    return OPCODE_BNEZ_N;
 	}
-      break;
-    case 13:
-      switch (Field_r_Slot_inst16b_get (insn))
+    }
+  if (Field_op0_Slot_inst16b_get (insn) == 13)
+    {
+      if (Field_r_Slot_inst16b_get (insn) == 0)
+	return OPCODE_MOV_N;
+      if (Field_r_Slot_inst16b_get (insn) == 15)
 	{
-	case 0:
-	  return OPCODE_MOV_N;
-	case 15:
-	  switch (Field_t_Slot_inst16b_get (insn))
-	    {
-	    case 0:
-	      return OPCODE_RET_N;
-	    case 1:
-	      return OPCODE_RETW_N;
-	    case 2:
-	      return OPCODE_BREAK_N;
-	    case 3:
-	      if (Field_s_Slot_inst16b_get (insn) == 0)
-		return OPCODE_NOP_N;
-	      break;
-	    case 6:
-	      if (Field_s_Slot_inst16b_get (insn) == 0)
-		return OPCODE_ILL_N;
-	      break;
-	    }
-	  break;
+	  if (Field_t_Slot_inst16b_get (insn) == 0)
+	    return OPCODE_RET_N;
+	  if (Field_t_Slot_inst16b_get (insn) == 1)
+	    return OPCODE_RETW_N;
+	  if (Field_t_Slot_inst16b_get (insn) == 2)
+	    return OPCODE_BREAK_N;
+	  if (Field_t_Slot_inst16b_get (insn) == 3 &&
+	      Field_s_Slot_inst16b_get (insn) == 0)
+	    return OPCODE_NOP_N;
+	  if (Field_t_Slot_inst16b_get (insn) == 6 &&
+	      Field_s_Slot_inst16b_get (insn) == 0)
+	    return OPCODE_ILL_N;
 	}
-      break;
     }
   return XTENSA_UNDEFINED;
 }
@@ -30875,17 +30691,14 @@ Slot_inst16b_decode (const xtensa_insnbuf insn)
 static int
 Slot_inst16a_decode (const xtensa_insnbuf insn)
 {
-  switch (Field_op0_Slot_inst16a_get (insn))
-    {
-    case 8:
-      return OPCODE_L32I_N;
-    case 9:
-      return OPCODE_S32I_N;
-    case 10:
-      return OPCODE_ADD_N;
-    case 11:
-      return OPCODE_ADDI_N;
-    }
+  if (Field_op0_Slot_inst16a_get (insn) == 8)
+    return OPCODE_L32I_N;
+  if (Field_op0_Slot_inst16a_get (insn) == 9)
+    return OPCODE_S32I_N;
+  if (Field_op0_Slot_inst16a_get (insn) == 10)
+    return OPCODE_ADD_N;
+  if (Field_op0_Slot_inst16a_get (insn) == 11)
+    return OPCODE_ADDI_N;
   return XTENSA_UNDEFINED;
 }
 
@@ -30898,45 +30711,31 @@ Slot_ae_slot0_decode (const xtensa_insnbuf insn)
   if (Field_ftsf213ae_slot0_Slot_ae_slot0_get (insn) == 2 &&
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
     return OPCODE_EXTUI;
-  switch (Field_ftsf214ae_slot0_Slot_ae_slot0_get (insn))
-    {
-    case 6:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_BGEZ;
-      break;
-    case 7:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_BLTZ;
-      break;
-    case 8:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_BEQZ;
-      break;
-    case 9:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_BNEZ;
-      break;
-    case 10:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVI;
-      break;
-    }
-  switch (Field_ftsf215ae_slot0_Slot_ae_slot0_get (insn))
-    {
-    case 88:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SRAI;
-      break;
-    case 96:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SLLI;
-      break;
-    case 123:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
-	  Field_ftsf364ae_slot0_Slot_ae_slot0_get (insn) == 0)
-	return OPCODE_AE_MOVTQ56;
-      break;
-    }
+  if (Field_ftsf214ae_slot0_Slot_ae_slot0_get (insn) == 6 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_BGEZ;
+  if (Field_ftsf214ae_slot0_Slot_ae_slot0_get (insn) == 7 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_BLTZ;
+  if (Field_ftsf214ae_slot0_Slot_ae_slot0_get (insn) == 8 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_BEQZ;
+  if (Field_ftsf214ae_slot0_Slot_ae_slot0_get (insn) == 9 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_BNEZ;
+  if (Field_ftsf214ae_slot0_Slot_ae_slot0_get (insn) == 10 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVI;
+  if (Field_ftsf215ae_slot0_Slot_ae_slot0_get (insn) == 88 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SRAI;
+  if (Field_ftsf215ae_slot0_Slot_ae_slot0_get (insn) == 96 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SLLI;
+  if (Field_ftsf215ae_slot0_Slot_ae_slot0_get (insn) == 123 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
+      Field_ftsf364ae_slot0_Slot_ae_slot0_get (insn) == 0)
+    return OPCODE_AE_MOVTQ56;
   if (Field_ftsf216ae_slot0_Slot_ae_slot0_get (insn) == 418 &&
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
     return OPCODE_AE_CVTP24A16X2_HH;
@@ -31160,17 +30959,12 @@ Slot_ae_slot0_decode (const xtensa_insnbuf insn)
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
       Field_s_Slot_ae_slot0_get (insn) == 0)
     return OPCODE_ALL8;
-  switch (Field_ftsf293_Slot_ae_slot0_get (insn))
-    {
-    case 0:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BBCI;
-      break;
-    case 1:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BBSI;
-      break;
-    }
+  if (Field_ftsf293_Slot_ae_slot0_get (insn) == 0 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BBCI;
+  if (Field_ftsf293_Slot_ae_slot0_get (insn) == 1 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BBSI;
   if (Field_ftsf294ae_slot0_Slot_ae_slot0_get (insn) == 1915 &&
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
       Field_s_Slot_ae_slot0_get (insn) == 0)
@@ -31188,57 +30982,38 @@ Slot_ae_slot0_decode (const xtensa_insnbuf insn)
   if (Field_ftsf298ae_slot0_Slot_ae_slot0_get (insn) == 963 &&
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
     return OPCODE_AE_SQ56S_IU;
-  switch (Field_ftsf299ae_slot0_Slot_ae_slot0_get (insn))
-    {
-    case 964:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_AE_SLLIQ56;
-      break;
-    case 965:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_AE_SRAIQ56;
-      break;
-    case 966:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_AE_SRLIQ56;
-      break;
-    case 968:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_AE_SLLISQ56S;
-      break;
-    }
-  switch (Field_ftsf300ae_slot0_Slot_ae_slot0_get (insn))
-    {
-    case 3868:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ABS;
-      break;
-    case 3869:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_NEG;
-      break;
-    case 3870:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SRA;
-      break;
-    case 3871:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SRL;
-      break;
-    }
-  switch (Field_ftsf301ae_slot0_Slot_ae_slot0_get (insn))
-    {
-    case 7752:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
-	  Field_ftsf321_Slot_ae_slot0_get (insn) == 0)
-	return OPCODE_AE_MOVP48;
-      break;
-    case 7753:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
-	  Field_ftsf353_Slot_ae_slot0_get (insn) == 0)
-	return OPCODE_ANY4;
-      break;
-    }
+  if (Field_ftsf299ae_slot0_Slot_ae_slot0_get (insn) == 964 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_AE_SLLIQ56;
+  if (Field_ftsf299ae_slot0_Slot_ae_slot0_get (insn) == 965 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_AE_SRAIQ56;
+  if (Field_ftsf299ae_slot0_Slot_ae_slot0_get (insn) == 966 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_AE_SRLIQ56;
+  if (Field_ftsf299ae_slot0_Slot_ae_slot0_get (insn) == 968 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_AE_SLLISQ56S;
+  if (Field_ftsf300ae_slot0_Slot_ae_slot0_get (insn) == 3868 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ABS;
+  if (Field_ftsf300ae_slot0_Slot_ae_slot0_get (insn) == 3869 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_NEG;
+  if (Field_ftsf300ae_slot0_Slot_ae_slot0_get (insn) == 3870 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SRA;
+  if (Field_ftsf300ae_slot0_Slot_ae_slot0_get (insn) == 3871 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SRL;
+  if (Field_ftsf301ae_slot0_Slot_ae_slot0_get (insn) == 7752 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
+      Field_ftsf321_Slot_ae_slot0_get (insn) == 0)
+    return OPCODE_AE_MOVP48;
+  if (Field_ftsf301ae_slot0_Slot_ae_slot0_get (insn) == 7753 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
+      Field_ftsf353_Slot_ae_slot0_get (insn) == 0)
+    return OPCODE_ANY4;
   if (Field_ftsf302ae_slot0_Slot_ae_slot0_get (insn) == 31016 &&
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
       Field_ftsf321_Slot_ae_slot0_get (insn) == 0)
@@ -31328,239 +31103,181 @@ Slot_ae_slot0_decode (const xtensa_insnbuf insn)
       Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
       Field_ftsf362ae_slot0_Slot_ae_slot0_get (insn) == 0)
     return OPCODE_AE_SQ32F_XU;
-  switch (Field_imm8_Slot_ae_slot0_get (insn))
-    {
-    case 178:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ADD;
-      break;
-    case 179:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ADDX8;
-      break;
-    case 180:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ADDX2;
-      break;
-    case 181:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_AND;
-      break;
-    case 182:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ANDB;
-      break;
-    case 183:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ANDBC;
-      break;
-    case 184:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ADDX4;
-      break;
-    case 185:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_CLAMPS;
-      break;
-    case 186:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MAX;
-      break;
-    case 187:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MIN;
-      break;
-    case 188:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MAXU;
-      break;
-    case 189:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MINU;
-      break;
-    case 190:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVEQZ;
-      break;
-    case 191:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVF;
-      break;
-    case 194:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVGEZ;
-      break;
-    case 195:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ORB;
-      break;
-    case 196:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVLTZ;
-      break;
-    case 197:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_ORBC;
-      break;
-    case 198:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SEXT;
-      break;
-    case 199:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SRC;
-      break;
-    case 200:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVNEZ;
-      break;
-    case 201:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SRLI;
-      break;
-    case 202:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SUB;
-      break;
-    case 203:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SUBX4;
-      break;
-    case 204:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SUBX2;
-      break;
-    case 205:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_SUBX8;
-      break;
-    case 206:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_XOR;
-      break;
-    case 207:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_XORB;
-      break;
-    case 208:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_MOVT;
-      break;
-    case 224:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
-	return OPCODE_OR;
-      break;
-    case 244:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
-	  Field_ae_r32_Slot_ae_slot0_get (insn) == 0)
-	return OPCODE_AE_SQ32F_X;
-      break;
-    }
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 178 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ADD;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 179 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ADDX8;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 180 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ADDX2;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 181 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_AND;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 182 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ANDB;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 183 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ANDBC;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 184 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ADDX4;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 185 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_CLAMPS;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 186 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MAX;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 187 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MIN;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 188 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MAXU;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 189 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MINU;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 190 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVEQZ;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 191 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVF;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 194 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVGEZ;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 195 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ORB;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 196 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVLTZ;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 197 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_ORBC;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 198 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SEXT;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 199 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SRC;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 200 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVNEZ;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 201 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SRLI;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 202 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SUB;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 203 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SUBX4;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 204 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SUBX2;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 205 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_SUBX8;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 206 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_XOR;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 207 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_XORB;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 208 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_MOVT;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 224 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1)
+    return OPCODE_OR;
+  if (Field_imm8_Slot_ae_slot0_get (insn) == 244 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 1 &&
+      Field_ae_r32_Slot_ae_slot0_get (insn) == 0)
+    return OPCODE_AE_SQ32F_X;
   if (Field_op0_s4_Slot_ae_slot0_get (insn) == 5)
     return OPCODE_L32R;
-  switch (Field_r_Slot_ae_slot0_get (insn))
-    {
-    case 0:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_BNE;
-      break;
-    case 1:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_BNONE;
-      break;
-    case 2:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_L16SI;
-      break;
-    case 3:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_L8UI;
-      break;
-    case 4:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_ADDI;
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_L16UI;
-      break;
-    case 5:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BALL;
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_S16I;
-      break;
-    case 6:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BANY;
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_S32I;
-      break;
-    case 7:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BBC;
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
-	return OPCODE_S8I;
-      break;
-    case 8:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_ADDMI;
-      break;
-    case 9:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BBS;
-      break;
-    case 10:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BEQ;
-      break;
-    case 11:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BGEU;
-      break;
-    case 12:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BGE;
-      break;
-    case 13:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BLT;
-      break;
-    case 14:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BLTU;
-      break;
-    case 15:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
-	return OPCODE_BNALL;
-      break;
-    }
-  switch (Field_t_Slot_ae_slot0_get (insn))
-    {
-    case 0:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
-	return OPCODE_BEQI;
-      break;
-    case 1:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
-	return OPCODE_BGEI;
-      break;
-    case 2:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
-	return OPCODE_BGEUI;
-      break;
-    case 3:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
-	return OPCODE_BNEI;
-      break;
-    case 4:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
-	return OPCODE_BLTI;
-      break;
-    case 5:
-      if (Field_op0_s4_Slot_ae_slot0_get (insn) == 3 &&
-	  Field_r_Slot_ae_slot0_get (insn) == 0)
-	return OPCODE_BF;
-      break;
-    }
+  if (Field_r_Slot_ae_slot0_get (insn) == 0 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_BNE;
+  if (Field_r_Slot_ae_slot0_get (insn) == 1 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_BNONE;
+  if (Field_r_Slot_ae_slot0_get (insn) == 2 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_L16SI;
+  if (Field_r_Slot_ae_slot0_get (insn) == 3 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_L8UI;
+  if (Field_r_Slot_ae_slot0_get (insn) == 4 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_ADDI;
+  if (Field_r_Slot_ae_slot0_get (insn) == 4 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_L16UI;
+  if (Field_r_Slot_ae_slot0_get (insn) == 5 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BALL;
+  if (Field_r_Slot_ae_slot0_get (insn) == 5 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_S16I;
+  if (Field_r_Slot_ae_slot0_get (insn) == 6 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BANY;
+  if (Field_r_Slot_ae_slot0_get (insn) == 6 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_S32I;
+  if (Field_r_Slot_ae_slot0_get (insn) == 7 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BBC;
+  if (Field_r_Slot_ae_slot0_get (insn) == 7 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 4)
+    return OPCODE_S8I;
+  if (Field_r_Slot_ae_slot0_get (insn) == 8 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_ADDMI;
+  if (Field_r_Slot_ae_slot0_get (insn) == 9 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BBS;
+  if (Field_r_Slot_ae_slot0_get (insn) == 10 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BEQ;
+  if (Field_r_Slot_ae_slot0_get (insn) == 11 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BGEU;
+  if (Field_r_Slot_ae_slot0_get (insn) == 12 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BGE;
+  if (Field_r_Slot_ae_slot0_get (insn) == 13 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BLT;
+  if (Field_r_Slot_ae_slot0_get (insn) == 14 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BLTU;
+  if (Field_r_Slot_ae_slot0_get (insn) == 15 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 2)
+    return OPCODE_BNALL;
+  if (Field_t_Slot_ae_slot0_get (insn) == 0 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
+    return OPCODE_BEQI;
+  if (Field_t_Slot_ae_slot0_get (insn) == 1 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
+    return OPCODE_BGEI;
+  if (Field_t_Slot_ae_slot0_get (insn) == 2 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
+    return OPCODE_BGEUI;
+  if (Field_t_Slot_ae_slot0_get (insn) == 3 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
+    return OPCODE_BNEI;
+  if (Field_t_Slot_ae_slot0_get (insn) == 4 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 3)
+    return OPCODE_BLTI;
+  if (Field_t_Slot_ae_slot0_get (insn) == 5 &&
+      Field_op0_s4_Slot_ae_slot0_get (insn) == 3 &&
+      Field_r_Slot_ae_slot0_get (insn) == 0)
+    return OPCODE_BF;
   return XTENSA_UNDEFINED;
 }
 
@@ -31958,21 +31675,15 @@ Slot_ae_slot1_decode (const xtensa_insnbuf insn)
   if (Field_ftsf36ae_slot1_Slot_ae_slot1_get (insn) == 31 &&
       Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
     return OPCODE_AE_SUBP24;
-  switch (Field_ftsf37ae_slot1_Slot_ae_slot1_get (insn))
-    {
-    case 8:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
-	return OPCODE_AE_SLLIP24;
-      break;
-    case 9:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
-	return OPCODE_AE_SRAIP24;
-      break;
-    case 10:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
-	return OPCODE_AE_SRLIP24;
-      break;
-    }
+  if (Field_ftsf37ae_slot1_Slot_ae_slot1_get (insn) == 8 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
+    return OPCODE_AE_SLLIP24;
+  if (Field_ftsf37ae_slot1_Slot_ae_slot1_get (insn) == 9 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
+    return OPCODE_AE_SRAIP24;
+  if (Field_ftsf37ae_slot1_Slot_ae_slot1_get (insn) == 10 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
+    return OPCODE_AE_SRLIP24;
   if (Field_ftsf38ae_slot1_Slot_ae_slot1_get (insn) == 176 &&
       Field_op0_s3_Slot_ae_slot1_get (insn) == 1)
     return OPCODE_AE_MULAFQ32SP16S_L;
@@ -32148,137 +31859,150 @@ Slot_ae_slot1_decode (const xtensa_insnbuf insn)
       Field_op0_s3_Slot_ae_slot1_get (insn) == 1 &&
       Field_ae_r20_Slot_ae_slot1_get (insn) == 0)
     return OPCODE_AE_ABSP24;
-  switch (Field_t_Slot_ae_slot1_get (insn))
-    {
-    case 0:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAFQ32SP16S_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASFQ32SP16U_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSAQ32SP16S_LL;
-      break;
-    case 1:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAFQ32SP16S_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASFQ32SP16U_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSAQ32SP16U_HH;
-      break;
-    case 2:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAFQ32SP16S_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASQ32SP16S_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSAQ32SP16U_LH;
-      break;
-    case 3:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAFQ32SP16U_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASQ32SP16U_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSFQ32SP16S_LH;
-      break;
-    case 4:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAFQ32SP16U_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASQ32SP16S_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSAQ32SP16U_LL;
-      break;
-    case 5:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAQ32SP16S_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASQ32SP16U_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSFQ32SP16S_LL;
-      break;
-    case 6:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAQ32SP16S_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASQ32SP16U_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSFQ32SP16U_HH;
-      break;
-    case 7:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAQ32SP16S_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAFQ32SP16S_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSFQ32SP16U_LH;
-      break;
-    case 8:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAFQ32SP16U_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZASQ32SP16S_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSFQ32SP16S_HH;
-      break;
-    case 9:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAQ32SP16U_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAFQ32SP16S_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSFQ32SP16U_LL;
-      break;
-    case 10:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAQ32SP16U_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAFQ32SP16S_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSQ32SP16S_HH;
-      break;
-    case 11:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZASFQ32SP16S_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAFQ32SP16U_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSQ32SP16S_LL;
-      break;
-    case 12:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZAAQ32SP16U_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAFQ32SP16U_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSQ32SP16S_LH;
-      break;
-    case 13:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZASFQ32SP16S_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAFQ32SP16U_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSQ32SP16U_HH;
-      break;
-    case 14:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZASFQ32SP16S_LL;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAQ32SP16S_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSQ32SP16U_LH;
-      break;
-    case 15:
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
-	return OPCODE_AE_MULZASFQ32SP16U_HH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
-	return OPCODE_AE_MULZSAQ32SP16S_LH;
-      if (Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
-	return OPCODE_AE_MULZSSQ32SP16U_LL;
-      break;
-    }
+  if (Field_t_Slot_ae_slot1_get (insn) == 0 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAFQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 0 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASFQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 0 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSAQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 1 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAFQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 1 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASFQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 1 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSAQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 2 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAFQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 2 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 2 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSAQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 3 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAFQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 3 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 3 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSFQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 4 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAFQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 4 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 4 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSAQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 5 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 5 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 5 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSFQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 6 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 6 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 6 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSFQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 7 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 7 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAFQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 7 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSFQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 8 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAFQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 8 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZASQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 8 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSFQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 9 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 9 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAFQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 9 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSFQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 10 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 10 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAFQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 10 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 11 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZASFQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 11 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAFQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 11 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 12 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZAAQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 12 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAFQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 12 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 13 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZASFQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 13 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAFQ32SP16U_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 13 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 14 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZASFQ32SP16S_LL;
+  if (Field_t_Slot_ae_slot1_get (insn) == 14 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAQ32SP16S_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 14 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSQ32SP16U_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 15 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 2)
+    return OPCODE_AE_MULZASFQ32SP16U_HH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 15 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 3)
+    return OPCODE_AE_MULZSAQ32SP16S_LH;
+  if (Field_t_Slot_ae_slot1_get (insn) == 15 &&
+      Field_op0_s3_Slot_ae_slot1_get (insn) == 4)
+    return OPCODE_AE_MULZSSQ32SP16U_LL;
   return XTENSA_UNDEFINED;
 }
 
@@ -32418,6 +32142,8 @@ Slot_inst_get_field_fns[] = {
   Field_ae_r20_Slot_inst_get,
   Field_ae_r10_Slot_inst_get,
   Field_ae_s20_Slot_inst_get,
+  Field_ae_fld_ohba_Slot_inst_get,
+  Field_ae_fld_ohba2_Slot_inst_get,
   0,
   Field_ftsf12_Slot_inst_get,
   Field_ftsf13_Slot_inst_get,
@@ -32809,6 +32535,8 @@ Slot_inst_set_field_fns[] = {
   Field_ae_r20_Slot_inst_set,
   Field_ae_r10_Slot_inst_set,
   Field_ae_s20_Slot_inst_set,
+  Field_ae_fld_ohba_Slot_inst_set,
+  Field_ae_fld_ohba2_Slot_inst_set,
   0,
   Field_ftsf12_Slot_inst_set,
   Field_ftsf13_Slot_inst_set,
@@ -33525,6 +33253,8 @@ Slot_inst16a_get_field_fns[] = {
   0,
   0,
   0,
+  0,
+  0,
   Implicit_Field_ar0_get,
   Implicit_Field_ar4_get,
   Implicit_Field_ar8_get,
@@ -33916,6 +33646,8 @@ Slot_inst16a_set_field_fns[] = {
   0,
   0,
   0,
+  0,
+  0,
   Implicit_Field_set,
   Implicit_Field_set,
   Implicit_Field_set,
@@ -34307,6 +34039,8 @@ Slot_inst16b_get_field_fns[] = {
   0,
   0,
   0,
+  0,
+  0,
   Implicit_Field_ar0_get,
   Implicit_Field_ar4_get,
   Implicit_Field_ar8_get,
@@ -34698,6 +34432,8 @@ Slot_inst16b_set_field_fns[] = {
   0,
   0,
   0,
+  0,
+  0,
   Implicit_Field_set,
   Implicit_Field_set,
   Implicit_Field_set,
@@ -34764,6 +34500,8 @@ Slot_ae_slot1_get_field_fns[] = {
   Field_ae_r20_Slot_ae_slot1_get,
   Field_ae_r10_Slot_ae_slot1_get,
   Field_ae_s20_Slot_ae_slot1_get,
+  0,
+  0,
   Field_op0_s3_Slot_ae_slot1_get,
   Field_ftsf12_Slot_ae_slot1_get,
   Field_ftsf13_Slot_ae_slot1_get,
@@ -35155,6 +34893,8 @@ Slot_ae_slot1_set_field_fns[] = {
   Field_ae_r20_Slot_ae_slot1_set,
   Field_ae_r10_Slot_ae_slot1_set,
   Field_ae_s20_Slot_ae_slot1_set,
+  0,
+  0,
   Field_op0_s3_Slot_ae_slot1_set,
   Field_ftsf12_Slot_ae_slot1_set,
   Field_ftsf13_Slot_ae_slot1_set,
@@ -35745,6 +35485,8 @@ Slot_ae_slot0_get_field_fns[] = {
   0,
   0,
   0,
+  0,
+  0,
   Field_op0_s4_Slot_ae_slot0_get,
   Field_ftsf212ae_slot0_Slot_ae_slot0_get,
   Field_ftsf213ae_slot0_Slot_ae_slot0_get,
@@ -36136,6 +35878,8 @@ Slot_ae_slot0_set_field_fns[] = {
   0,
   0,
   0,
+  0,
+  0,
   Field_op0_s4_Slot_ae_slot0_set,
   Field_ftsf212ae_slot0_Slot_ae_slot0_set,
   Field_ftsf213ae_slot0_Slot_ae_slot0_set,
@@ -36356,7 +36100,247 @@ format_decoder (const xtensa_insnbuf insn)
   return -1;
 }
 
-static int length_table[16] = {
+static int length_table[256] = {
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  3,
+  2,
+  2,
+  2,
+  2,
+  2,
+  2,
+  -1,
+  8,
   3,
   3,
   3,
@@ -36378,8 +36362,8 @@ static int length_table[16] = {
 static int
 length_decoder (const unsigned char *insn)
 {
-  int op0 = insn[0] & 0xf;
-  return length_table[op0];
+  int l = insn[0];
+  return length_table[l];
 }
 
 
@@ -36390,8 +36374,8 @@ xtensa_isa_internal xtensa_modules = {
   8 /* insn_size */, 0,
   4, formats, format_decoder, length_decoder,
   5, slots,
-  387 /* num_fields */,
-  445, operands,
+  389 /* num_fields */,
+  454, operands,
   588, iclasses,
   656, opcodes, 0,
   8, regfiles,
-- 
2.20.1



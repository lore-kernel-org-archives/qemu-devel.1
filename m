Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F0C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E144B215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX89lKcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E144B215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaDar-0002Ao-0a
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 01:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iaDYJ-0001IS-NC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iaDY6-0003eD-FW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:45:22 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:44128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iaDY5-0003ZX-CM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:45:10 -0500
Received: by mail-pf1-x436.google.com with SMTP id d199so7998123pfd.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 22:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zLTPiYgJnD4SXBjsGttYQknmeZVomulZSgJFrjhLQ/c=;
 b=JX89lKcLzOycKqs/95CZZc13wJCQ6rkwRs9PwBfFyscQj7hFOxqRhCAEtH965OAPKv
 yQsVYWLHuZXhqvYYfDTGhIUBYJGGdJFmU2YjB6E63ARGqTe+VtbSdaWo3O1+faeZOhUt
 68TpCS2lrypvN1o/CLAIqJEE/qYrI98cO0780nQrWEcISJrVmJZ7BAlrVhXfddWZgL/8
 7lNWFAC9/sp+Sa2AgNs1O14xvTv0kcwIpqnXwdjoCEG3F4AnOHNjST/am3HWupaHoyvp
 Ioc2qNW0HdDk0mEdgXWdpK9g+PzBn58C3HXlFifUKwpKPMiwNF5capQbs2Xd5Qsk6OpD
 Xc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zLTPiYgJnD4SXBjsGttYQknmeZVomulZSgJFrjhLQ/c=;
 b=BW0lBzmB7XuYF85kaOC9HW/et1P0STcTObKMkeVAFR+ikzRDdHozIBNSuJe9zXqCTJ
 9NMQBxJ8YKXadNB3nNhKb7Y/AdOjxCG67zsgxWjDUlW7pK3kD14t+U2ruEEWNy1OY2Kj
 u/Y+Xn8hSdv0B+EzERbNarnNKgXCmcJvG54PNh2mhyk/CQ9zrAEYVAliDPyArh/9fgHh
 UEFy+ayhT1J5rPKfBjz0iM5PI8Bh/BPHMb5S0WxlNEeYh5D0X6jV3VCn0fl29jGivWm1
 rMF6w5hyGY2VRVBh28/hhkJvtkaTRhMLi3DTm/gNopnRcthEmfcnDLDj38MTWyY8dkES
 JqNw==
X-Gm-Message-State: APjAAAXxqf6KFvUH3d2b78kXeT7Be5cr5Z1rHhrOB6PYaBMJ1voBTdEl
 Udo0sui9LdCfzi2PfhEERyPhiPVVyUnkAw==
X-Google-Smtp-Source: APXvYqwwVZff7CPQ9BfBnWyEolPiCuzWHjImbAM/kj8fHINhs8lpyhxWJ8mibxaLQEBc5HT8BEHatQ==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr9553590pgv.55.1574923506013; 
 Wed, 27 Nov 2019 22:45:06 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:186d:af79:94fc:29ef:77e6])
 by smtp.gmail.com with ESMTPSA id
 u7sm18366891pfh.84.2019.11.27.22.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 22:45:05 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 1/1] Cleaned up Work tree. The radeon_reg.h r300_reg.h and
 r500_reg.h files are from the kernel drm tree. They contain the register
 definitions for the R300 GPU
Date: Thu, 28 Nov 2019 12:13:51 +0530
Message-Id: <20191128064350.20727-2-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
References: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/Kconfig       |    9 +-
 hw/display/Makefile.objs |    2 +
 hw/display/r100d.h       |  869 +++++++++
 hw/display/r300.c        | 1087 +++++++++++
 hw/display/r300.h        |  269 +++
 hw/display/r300_2d.c     |  190 ++
 hw/display/r300_debug.c  |  272 +++
 hw/display/r300_reg.h    | 1789 ++++++++++++++++++
 hw/display/r300d.h       |  343 ++++
 hw/display/r500_reg.h    |  801 ++++++++
 hw/display/radeon_reg.h  | 3725 ++++++++++++++++++++++++++++++++++++++
 11 files changed, 9355 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/r100d.h
 create mode 100644 hw/display/r300.c
 create mode 100644 hw/display/r300.h
 create mode 100644 hw/display/r300_2d.c
 create mode 100644 hw/display/r300_debug.c
 create mode 100644 hw/display/r300_reg.h
 create mode 100644 hw/display/r300d.h
 create mode 100644 hw/display/r500_reg.h
 create mode 100644 hw/display/radeon_reg.h

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index c500d1fc6d..64fd925d8f 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -123,7 +123,7 @@ config VHOST_USER_VGA
 
 config DPCD
     bool
-    select AUX
+
 
 config ATI_VGA
     bool
@@ -133,6 +133,13 @@ config ATI_VGA
     select BITBANG_I2C
     select DDC
 
+    config RAD_VGA
+        bool
+        default y if PCI_DEVICES
+        depends on PCI
+        select VGA
+        select DDC
+
 config MACFB
     bool
     select FRAMEBUFFER
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index f2182e3bef..1988363058 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -59,3 +59,5 @@ common-obj-$(CONFIG_DPCD) += dpcd.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
 
 common-obj-$(CONFIG_ATI_VGA) += ati.o ati_2d.o ati_dbg.o
+
+common-obj-$(CONFIG_RAD_VGA) += r300.o r300_2d.o r300_debug.o
diff --git a/hw/display/r100d.h b/hw/display/r100d.h
new file mode 100644
index 0000000000..f0f8ee69f4
--- /dev/null
+++ b/hw/display/r100d.h
@@ -0,0 +1,869 @@
+/*
+ * Copyright 2008 Advanced Micro Devices, Inc.
+ * Copyright 2008 Red Hat Inc.
+ * Copyright 2009 Jerome Glisse.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Dave Airlie
+ *          Alex Deucher
+ *          Jerome Glisse
+ */
+#ifndef __R100D_H__
+#define __R100D_H__
+
+#define CP_PACKET0			0x00000000
+#define		PACKET0_BASE_INDEX_SHIFT	0
+#define		PACKET0_BASE_INDEX_MASK		(0x1ffff << 0)
+#define		PACKET0_COUNT_SHIFT		16
+#define		PACKET0_COUNT_MASK		(0x3fff << 16)
+#define CP_PACKET1			0x40000000
+#define CP_PACKET2			0x80000000
+#define		PACKET2_PAD_SHIFT		0
+#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
+#define CP_PACKET3			0xC0000000
+#define		PACKET3_IT_OPCODE_SHIFT		8
+#define		PACKET3_IT_OPCODE_MASK		(0xff << 8)
+#define		PACKET3_COUNT_SHIFT		16
+#define		PACKET3_COUNT_MASK		(0x3fff << 16)
+/* PACKET3 op code */
+#define		PACKET3_NOP			0x10
+#define		PACKET3_3D_DRAW_VBUF		0x28
+#define		PACKET3_3D_DRAW_IMMD		0x29
+#define		PACKET3_3D_DRAW_INDX		0x2A
+#define		PACKET3_3D_LOAD_VBPNTR		0x2F
+#define		PACKET3_3D_CLEAR_ZMASK		0x32
+#define		PACKET3_INDX_BUFFER		0x33
+#define		PACKET3_3D_DRAW_VBUF_2		0x34
+#define		PACKET3_3D_DRAW_IMMD_2		0x35
+#define		PACKET3_3D_DRAW_INDX_2		0x36
+#define		PACKET3_3D_CLEAR_HIZ		0x37
+#define		PACKET3_BITBLT_MULTI		0x9B
+
+#define PACKET0(reg, n)	(CP_PACKET0 |					\
+			 REG_SET(PACKET0_BASE_INDEX, (reg) >> 2) |	\
+			 REG_SET(PACKET0_COUNT, (n)))
+#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
+#define PACKET3(op, n)	(CP_PACKET3 |					\
+			 REG_SET(PACKET3_IT_OPCODE, (op)) |		\
+			 REG_SET(PACKET3_COUNT, (n)))
+
+/* Registers */
+#define R_0000F0_RBBM_SOFT_RESET                     0x0000F0
+#define   S_0000F0_SOFT_RESET_CP(x)                    (((x) & 0x1) << 0)
+#define   G_0000F0_SOFT_RESET_CP(x)                    (((x) >> 0) & 0x1)
+#define   C_0000F0_SOFT_RESET_CP                       0xFFFFFFFE
+#define   S_0000F0_SOFT_RESET_HI(x)                    (((x) & 0x1) << 1)
+#define   G_0000F0_SOFT_RESET_HI(x)                    (((x) >> 1) & 0x1)
+#define   C_0000F0_SOFT_RESET_HI                       0xFFFFFFFD
+#define   S_0000F0_SOFT_RESET_SE(x)                    (((x) & 0x1) << 2)
+#define   G_0000F0_SOFT_RESET_SE(x)                    (((x) >> 2) & 0x1)
+#define   C_0000F0_SOFT_RESET_SE                       0xFFFFFFFB
+#define   S_0000F0_SOFT_RESET_RE(x)                    (((x) & 0x1) << 3)
+#define   G_0000F0_SOFT_RESET_RE(x)                    (((x) >> 3) & 0x1)
+#define   C_0000F0_SOFT_RESET_RE                       0xFFFFFFF7
+#define   S_0000F0_SOFT_RESET_PP(x)                    (((x) & 0x1) << 4)
+#define   G_0000F0_SOFT_RESET_PP(x)                    (((x) >> 4) & 0x1)
+#define   C_0000F0_SOFT_RESET_PP                       0xFFFFFFEF
+#define   S_0000F0_SOFT_RESET_E2(x)                    (((x) & 0x1) << 5)
+#define   G_0000F0_SOFT_RESET_E2(x)                    (((x) >> 5) & 0x1)
+#define   C_0000F0_SOFT_RESET_E2                       0xFFFFFFDF
+#define   S_0000F0_SOFT_RESET_RB(x)                    (((x) & 0x1) << 6)
+#define   G_0000F0_SOFT_RESET_RB(x)                    (((x) >> 6) & 0x1)
+#define   C_0000F0_SOFT_RESET_RB                       0xFFFFFFBF
+#define   S_0000F0_SOFT_RESET_HDP(x)                   (((x) & 0x1) << 7)
+#define   G_0000F0_SOFT_RESET_HDP(x)                   (((x) >> 7) & 0x1)
+#define   C_0000F0_SOFT_RESET_HDP                      0xFFFFFF7F
+#define   S_0000F0_SOFT_RESET_MC(x)                    (((x) & 0x1) << 8)
+#define   G_0000F0_SOFT_RESET_MC(x)                    (((x) >> 8) & 0x1)
+#define   C_0000F0_SOFT_RESET_MC                       0xFFFFFEFF
+#define   S_0000F0_SOFT_RESET_AIC(x)                   (((x) & 0x1) << 9)
+#define   G_0000F0_SOFT_RESET_AIC(x)                   (((x) >> 9) & 0x1)
+#define   C_0000F0_SOFT_RESET_AIC                      0xFFFFFDFF
+#define   S_0000F0_SOFT_RESET_VIP(x)                   (((x) & 0x1) << 10)
+#define   G_0000F0_SOFT_RESET_VIP(x)                   (((x) >> 10) & 0x1)
+#define   C_0000F0_SOFT_RESET_VIP                      0xFFFFFBFF
+#define   S_0000F0_SOFT_RESET_DISP(x)                  (((x) & 0x1) << 11)
+#define   G_0000F0_SOFT_RESET_DISP(x)                  (((x) >> 11) & 0x1)
+#define   C_0000F0_SOFT_RESET_DISP                     0xFFFFF7FF
+#define   S_0000F0_SOFT_RESET_CG(x)                    (((x) & 0x1) << 12)
+#define   G_0000F0_SOFT_RESET_CG(x)                    (((x) >> 12) & 0x1)
+#define   C_0000F0_SOFT_RESET_CG                       0xFFFFEFFF
+#define R_000030_BUS_CNTL                            0x000030
+#define   S_000030_BUS_DBL_RESYNC(x)                   (((x) & 0x1) << 0)
+#define   G_000030_BUS_DBL_RESYNC(x)                   (((x) >> 0) & 0x1)
+#define   C_000030_BUS_DBL_RESYNC                      0xFFFFFFFE
+#define   S_000030_BUS_MSTR_RESET(x)                   (((x) & 0x1) << 1)
+#define   G_000030_BUS_MSTR_RESET(x)                   (((x) >> 1) & 0x1)
+#define   C_000030_BUS_MSTR_RESET                      0xFFFFFFFD
+#define   S_000030_BUS_FLUSH_BUF(x)                    (((x) & 0x1) << 2)
+#define   G_000030_BUS_FLUSH_BUF(x)                    (((x) >> 2) & 0x1)
+#define   C_000030_BUS_FLUSH_BUF                       0xFFFFFFFB
+#define   S_000030_BUS_STOP_REQ_DIS(x)                 (((x) & 0x1) << 3)
+#define   G_000030_BUS_STOP_REQ_DIS(x)                 (((x) >> 3) & 0x1)
+#define   C_000030_BUS_STOP_REQ_DIS                    0xFFFFFFF7
+#define   S_000030_BUS_PM4_READ_COMBINE_EN(x)          (((x) & 0x1) << 4)
+#define   G_000030_BUS_PM4_READ_COMBINE_EN(x)          (((x) >> 4) & 0x1)
+#define   C_000030_BUS_PM4_READ_COMBINE_EN             0xFFFFFFEF
+#define   S_000030_BUS_WRT_COMBINE_EN(x)               (((x) & 0x1) << 5)
+#define   G_000030_BUS_WRT_COMBINE_EN(x)               (((x) >> 5) & 0x1)
+#define   C_000030_BUS_WRT_COMBINE_EN                  0xFFFFFFDF
+#define   S_000030_BUS_MASTER_DIS(x)                   (((x) & 0x1) << 6)
+#define   G_000030_BUS_MASTER_DIS(x)                   (((x) >> 6) & 0x1)
+#define   C_000030_BUS_MASTER_DIS                      0xFFFFFFBF
+#define   S_000030_BIOS_ROM_WRT_EN(x)                  (((x) & 0x1) << 7)
+#define   G_000030_BIOS_ROM_WRT_EN(x)                  (((x) >> 7) & 0x1)
+#define   C_000030_BIOS_ROM_WRT_EN                     0xFFFFFF7F
+#define   S_000030_BM_DAC_CRIPPLE(x)                   (((x) & 0x1) << 8)
+#define   G_000030_BM_DAC_CRIPPLE(x)                   (((x) >> 8) & 0x1)
+#define   C_000030_BM_DAC_CRIPPLE                      0xFFFFFEFF
+#define   S_000030_BUS_NON_PM4_READ_COMBINE_EN(x)      (((x) & 0x1) << 9)
+#define   G_000030_BUS_NON_PM4_READ_COMBINE_EN(x)      (((x) >> 9) & 0x1)
+#define   C_000030_BUS_NON_PM4_READ_COMBINE_EN         0xFFFFFDFF
+#define   S_000030_BUS_XFERD_DISCARD_EN(x)             (((x) & 0x1) << 10)
+#define   G_000030_BUS_XFERD_DISCARD_EN(x)             (((x) >> 10) & 0x1)
+#define   C_000030_BUS_XFERD_DISCARD_EN                0xFFFFFBFF
+#define   S_000030_BUS_SGL_READ_DISABLE(x)             (((x) & 0x1) << 11)
+#define   G_000030_BUS_SGL_READ_DISABLE(x)             (((x) >> 11) & 0x1)
+#define   C_000030_BUS_SGL_READ_DISABLE                0xFFFFF7FF
+#define   S_000030_BIOS_DIS_ROM(x)                     (((x) & 0x1) << 12)
+#define   G_000030_BIOS_DIS_ROM(x)                     (((x) >> 12) & 0x1)
+#define   C_000030_BIOS_DIS_ROM                        0xFFFFEFFF
+#define   S_000030_BUS_PCI_READ_RETRY_EN(x)            (((x) & 0x1) << 13)
+#define   G_000030_BUS_PCI_READ_RETRY_EN(x)            (((x) >> 13) & 0x1)
+#define   C_000030_BUS_PCI_READ_RETRY_EN               0xFFFFDFFF
+#define   S_000030_BUS_AGP_AD_STEPPING_EN(x)           (((x) & 0x1) << 14)
+#define   G_000030_BUS_AGP_AD_STEPPING_EN(x)           (((x) >> 14) & 0x1)
+#define   C_000030_BUS_AGP_AD_STEPPING_EN              0xFFFFBFFF
+#define   S_000030_BUS_PCI_WRT_RETRY_EN(x)             (((x) & 0x1) << 15)
+#define   G_000030_BUS_PCI_WRT_RETRY_EN(x)             (((x) >> 15) & 0x1)
+#define   C_000030_BUS_PCI_WRT_RETRY_EN                0xFFFF7FFF
+#define   S_000030_BUS_RETRY_WS(x)                     (((x) & 0xF) << 16)
+#define   G_000030_BUS_RETRY_WS(x)                     (((x) >> 16) & 0xF)
+#define   C_000030_BUS_RETRY_WS                        0xFFF0FFFF
+#define   S_000030_BUS_MSTR_RD_MULT(x)                 (((x) & 0x1) << 20)
+#define   G_000030_BUS_MSTR_RD_MULT(x)                 (((x) >> 20) & 0x1)
+#define   C_000030_BUS_MSTR_RD_MULT                    0xFFEFFFFF
+#define   S_000030_BUS_MSTR_RD_LINE(x)                 (((x) & 0x1) << 21)
+#define   G_000030_BUS_MSTR_RD_LINE(x)                 (((x) >> 21) & 0x1)
+#define   C_000030_BUS_MSTR_RD_LINE                    0xFFDFFFFF
+#define   S_000030_BUS_SUSPEND(x)                      (((x) & 0x1) << 22)
+#define   G_000030_BUS_SUSPEND(x)                      (((x) >> 22) & 0x1)
+#define   C_000030_BUS_SUSPEND                         0xFFBFFFFF
+#define   S_000030_LAT_16X(x)                          (((x) & 0x1) << 23)
+#define   G_000030_LAT_16X(x)                          (((x) >> 23) & 0x1)
+#define   C_000030_LAT_16X                             0xFF7FFFFF
+#define   S_000030_BUS_RD_DISCARD_EN(x)                (((x) & 0x1) << 24)
+#define   G_000030_BUS_RD_DISCARD_EN(x)                (((x) >> 24) & 0x1)
+#define   C_000030_BUS_RD_DISCARD_EN                   0xFEFFFFFF
+#define   S_000030_ENFRCWRDY(x)                        (((x) & 0x1) << 25)
+#define   G_000030_ENFRCWRDY(x)                        (((x) >> 25) & 0x1)
+#define   C_000030_ENFRCWRDY                           0xFDFFFFFF
+#define   S_000030_BUS_MSTR_WS(x)                      (((x) & 0x1) << 26)
+#define   G_000030_BUS_MSTR_WS(x)                      (((x) >> 26) & 0x1)
+#define   C_000030_BUS_MSTR_WS                         0xFBFFFFFF
+#define   S_000030_BUS_PARKING_DIS(x)                  (((x) & 0x1) << 27)
+#define   G_000030_BUS_PARKING_DIS(x)                  (((x) >> 27) & 0x1)
+#define   C_000030_BUS_PARKING_DIS                     0xF7FFFFFF
+#define   S_000030_BUS_MSTR_DISCONNECT_EN(x)           (((x) & 0x1) << 28)
+#define   G_000030_BUS_MSTR_DISCONNECT_EN(x)           (((x) >> 28) & 0x1)
+#define   C_000030_BUS_MSTR_DISCONNECT_EN              0xEFFFFFFF
+#define   S_000030_SERR_EN(x)                          (((x) & 0x1) << 29)
+#define   G_000030_SERR_EN(x)                          (((x) >> 29) & 0x1)
+#define   C_000030_SERR_EN                             0xDFFFFFFF
+#define   S_000030_BUS_READ_BURST(x)                   (((x) & 0x1) << 30)
+#define   G_000030_BUS_READ_BURST(x)                   (((x) >> 30) & 0x1)
+#define   C_000030_BUS_READ_BURST                      0xBFFFFFFF
+#define   S_000030_BUS_RDY_READ_DLY(x)                 (((x) & 0x1) << 31)
+#define   G_000030_BUS_RDY_READ_DLY(x)                 (((x) >> 31) & 0x1)
+#define   C_000030_BUS_RDY_READ_DLY                    0x7FFFFFFF
+#define R_000040_GEN_INT_CNTL                        0x000040
+#define   S_000040_CRTC_VBLANK(x)                      (((x) & 0x1) << 0)
+#define   G_000040_CRTC_VBLANK(x)                      (((x) >> 0) & 0x1)
+#define   C_000040_CRTC_VBLANK                         0xFFFFFFFE
+#define   S_000040_CRTC_VLINE(x)                       (((x) & 0x1) << 1)
+#define   G_000040_CRTC_VLINE(x)                       (((x) >> 1) & 0x1)
+#define   C_000040_CRTC_VLINE                          0xFFFFFFFD
+#define   S_000040_CRTC_VSYNC(x)                       (((x) & 0x1) << 2)
+#define   G_000040_CRTC_VSYNC(x)                       (((x) >> 2) & 0x1)
+#define   C_000040_CRTC_VSYNC                          0xFFFFFFFB
+#define   S_000040_SNAPSHOT(x)                         (((x) & 0x1) << 3)
+#define   G_000040_SNAPSHOT(x)                         (((x) >> 3) & 0x1)
+#define   C_000040_SNAPSHOT                            0xFFFFFFF7
+#define   S_000040_FP_DETECT(x)                        (((x) & 0x1) << 4)
+#define   G_000040_FP_DETECT(x)                        (((x) >> 4) & 0x1)
+#define   C_000040_FP_DETECT                           0xFFFFFFEF
+#define   S_000040_CRTC2_VLINE(x)                      (((x) & 0x1) << 5)
+#define   G_000040_CRTC2_VLINE(x)                      (((x) >> 5) & 0x1)
+#define   C_000040_CRTC2_VLINE                         0xFFFFFFDF
+#define   S_000040_DMA_VIPH0_INT_EN(x)                 (((x) & 0x1) << 12)
+#define   G_000040_DMA_VIPH0_INT_EN(x)                 (((x) >> 12) & 0x1)
+#define   C_000040_DMA_VIPH0_INT_EN                    0xFFFFEFFF
+#define   S_000040_CRTC2_VSYNC(x)                      (((x) & 0x1) << 6)
+#define   G_000040_CRTC2_VSYNC(x)                      (((x) >> 6) & 0x1)
+#define   C_000040_CRTC2_VSYNC                         0xFFFFFFBF
+#define   S_000040_SNAPSHOT2(x)                        (((x) & 0x1) << 7)
+#define   G_000040_SNAPSHOT2(x)                        (((x) >> 7) & 0x1)
+#define   C_000040_SNAPSHOT2                           0xFFFFFF7F
+#define   S_000040_CRTC2_VBLANK(x)                     (((x) & 0x1) << 9)
+#define   G_000040_CRTC2_VBLANK(x)                     (((x) >> 9) & 0x1)
+#define   C_000040_CRTC2_VBLANK                        0xFFFFFDFF
+#define   S_000040_FP2_DETECT(x)                       (((x) & 0x1) << 10)
+#define   G_000040_FP2_DETECT(x)                       (((x) >> 10) & 0x1)
+#define   C_000040_FP2_DETECT                          0xFFFFFBFF
+#define   S_000040_VSYNC_DIFF_OVER_LIMIT(x)            (((x) & 0x1) << 11)
+#define   G_000040_VSYNC_DIFF_OVER_LIMIT(x)            (((x) >> 11) & 0x1)
+#define   C_000040_VSYNC_DIFF_OVER_LIMIT               0xFFFFF7FF
+#define   S_000040_DMA_VIPH1_INT_EN(x)                 (((x) & 0x1) << 13)
+#define   G_000040_DMA_VIPH1_INT_EN(x)                 (((x) >> 13) & 0x1)
+#define   C_000040_DMA_VIPH1_INT_EN                    0xFFFFDFFF
+#define   S_000040_DMA_VIPH2_INT_EN(x)                 (((x) & 0x1) << 14)
+#define   G_000040_DMA_VIPH2_INT_EN(x)                 (((x) >> 14) & 0x1)
+#define   C_000040_DMA_VIPH2_INT_EN                    0xFFFFBFFF
+#define   S_000040_DMA_VIPH3_INT_EN(x)                 (((x) & 0x1) << 15)
+#define   G_000040_DMA_VIPH3_INT_EN(x)                 (((x) >> 15) & 0x1)
+#define   C_000040_DMA_VIPH3_INT_EN                    0xFFFF7FFF
+#define   S_000040_I2C_INT_EN(x)                       (((x) & 0x1) << 17)
+#define   G_000040_I2C_INT_EN(x)                       (((x) >> 17) & 0x1)
+#define   C_000040_I2C_INT_EN                          0xFFFDFFFF
+#define   S_000040_GUI_IDLE(x)                         (((x) & 0x1) << 19)
+#define   G_000040_GUI_IDLE(x)                         (((x) >> 19) & 0x1)
+#define   C_000040_GUI_IDLE                            0xFFF7FFFF
+#define   S_000040_VIPH_INT_EN(x)                      (((x) & 0x1) << 24)
+#define   G_000040_VIPH_INT_EN(x)                      (((x) >> 24) & 0x1)
+#define   C_000040_VIPH_INT_EN                         0xFEFFFFFF
+#define   S_000040_SW_INT_EN(x)                        (((x) & 0x1) << 25)
+#define   G_000040_SW_INT_EN(x)                        (((x) >> 25) & 0x1)
+#define   C_000040_SW_INT_EN                           0xFDFFFFFF
+#define   S_000040_GEYSERVILLE(x)                      (((x) & 0x1) << 27)
+#define   G_000040_GEYSERVILLE(x)                      (((x) >> 27) & 0x1)
+#define   C_000040_GEYSERVILLE                         0xF7FFFFFF
+#define   S_000040_HDCP_AUTHORIZED_INT(x)              (((x) & 0x1) << 28)
+#define   G_000040_HDCP_AUTHORIZED_INT(x)              (((x) >> 28) & 0x1)
+#define   C_000040_HDCP_AUTHORIZED_INT                 0xEFFFFFFF
+#define   S_000040_DVI_I2C_INT(x)                      (((x) & 0x1) << 29)
+#define   G_000040_DVI_I2C_INT(x)                      (((x) >> 29) & 0x1)
+#define   C_000040_DVI_I2C_INT                         0xDFFFFFFF
+#define   S_000040_GUIDMA(x)                           (((x) & 0x1) << 30)
+#define   G_000040_GUIDMA(x)                           (((x) >> 30) & 0x1)
+#define   C_000040_GUIDMA                              0xBFFFFFFF
+#define   S_000040_VIDDMA(x)                           (((x) & 0x1) << 31)
+#define   G_000040_VIDDMA(x)                           (((x) >> 31) & 0x1)
+#define   C_000040_VIDDMA                              0x7FFFFFFF
+#define R_000044_GEN_INT_STATUS                      0x000044
+#define   S_000044_CRTC_VBLANK_STAT(x)                 (((x) & 0x1) << 0)
+#define   G_000044_CRTC_VBLANK_STAT(x)                 (((x) >> 0) & 0x1)
+#define   C_000044_CRTC_VBLANK_STAT                    0xFFFFFFFE
+#define   S_000044_CRTC_VBLANK_STAT_AK(x)              (((x) & 0x1) << 0)
+#define   G_000044_CRTC_VBLANK_STAT_AK(x)              (((x) >> 0) & 0x1)
+#define   C_000044_CRTC_VBLANK_STAT_AK                 0xFFFFFFFE
+#define   S_000044_CRTC_VLINE_STAT(x)                  (((x) & 0x1) << 1)
+#define   G_000044_CRTC_VLINE_STAT(x)                  (((x) >> 1) & 0x1)
+#define   C_000044_CRTC_VLINE_STAT                     0xFFFFFFFD
+#define   S_000044_CRTC_VLINE_STAT_AK(x)               (((x) & 0x1) << 1)
+#define   G_000044_CRTC_VLINE_STAT_AK(x)               (((x) >> 1) & 0x1)
+#define   C_000044_CRTC_VLINE_STAT_AK                  0xFFFFFFFD
+#define   S_000044_CRTC_VSYNC_STAT(x)                  (((x) & 0x1) << 2)
+#define   G_000044_CRTC_VSYNC_STAT(x)                  (((x) >> 2) & 0x1)
+#define   C_000044_CRTC_VSYNC_STAT                     0xFFFFFFFB
+#define   S_000044_CRTC_VSYNC_STAT_AK(x)               (((x) & 0x1) << 2)
+#define   G_000044_CRTC_VSYNC_STAT_AK(x)               (((x) >> 2) & 0x1)
+#define   C_000044_CRTC_VSYNC_STAT_AK                  0xFFFFFFFB
+#define   S_000044_SNAPSHOT_STAT(x)                    (((x) & 0x1) << 3)
+#define   G_000044_SNAPSHOT_STAT(x)                    (((x) >> 3) & 0x1)
+#define   C_000044_SNAPSHOT_STAT                       0xFFFFFFF7
+#define   S_000044_SNAPSHOT_STAT_AK(x)                 (((x) & 0x1) << 3)
+#define   G_000044_SNAPSHOT_STAT_AK(x)                 (((x) >> 3) & 0x1)
+#define   C_000044_SNAPSHOT_STAT_AK                    0xFFFFFFF7
+#define   S_000044_FP_DETECT_STAT(x)                   (((x) & 0x1) << 4)
+#define   G_000044_FP_DETECT_STAT(x)                   (((x) >> 4) & 0x1)
+#define   C_000044_FP_DETECT_STAT                      0xFFFFFFEF
+#define   S_000044_FP_DETECT_STAT_AK(x)                (((x) & 0x1) << 4)
+#define   G_000044_FP_DETECT_STAT_AK(x)                (((x) >> 4) & 0x1)
+#define   C_000044_FP_DETECT_STAT_AK                   0xFFFFFFEF
+#define   S_000044_CRTC2_VLINE_STAT(x)                 (((x) & 0x1) << 5)
+#define   G_000044_CRTC2_VLINE_STAT(x)                 (((x) >> 5) & 0x1)
+#define   C_000044_CRTC2_VLINE_STAT                    0xFFFFFFDF
+#define   S_000044_CRTC2_VLINE_STAT_AK(x)              (((x) & 0x1) << 5)
+#define   G_000044_CRTC2_VLINE_STAT_AK(x)              (((x) >> 5) & 0x1)
+#define   C_000044_CRTC2_VLINE_STAT_AK                 0xFFFFFFDF
+#define   S_000044_CRTC2_VSYNC_STAT(x)                 (((x) & 0x1) << 6)
+#define   G_000044_CRTC2_VSYNC_STAT(x)                 (((x) >> 6) & 0x1)
+#define   C_000044_CRTC2_VSYNC_STAT                    0xFFFFFFBF
+#define   S_000044_CRTC2_VSYNC_STAT_AK(x)              (((x) & 0x1) << 6)
+#define   G_000044_CRTC2_VSYNC_STAT_AK(x)              (((x) >> 6) & 0x1)
+#define   C_000044_CRTC2_VSYNC_STAT_AK                 0xFFFFFFBF
+#define   S_000044_SNAPSHOT2_STAT(x)                   (((x) & 0x1) << 7)
+#define   G_000044_SNAPSHOT2_STAT(x)                   (((x) >> 7) & 0x1)
+#define   C_000044_SNAPSHOT2_STAT                      0xFFFFFF7F
+#define   S_000044_SNAPSHOT2_STAT_AK(x)                (((x) & 0x1) << 7)
+#define   G_000044_SNAPSHOT2_STAT_AK(x)                (((x) >> 7) & 0x1)
+#define   C_000044_SNAPSHOT2_STAT_AK                   0xFFFFFF7F
+#define   S_000044_CAP0_INT_ACTIVE(x)                  (((x) & 0x1) << 8)
+#define   G_000044_CAP0_INT_ACTIVE(x)                  (((x) >> 8) & 0x1)
+#define   C_000044_CAP0_INT_ACTIVE                     0xFFFFFEFF
+#define   S_000044_CRTC2_VBLANK_STAT(x)                (((x) & 0x1) << 9)
+#define   G_000044_CRTC2_VBLANK_STAT(x)                (((x) >> 9) & 0x1)
+#define   C_000044_CRTC2_VBLANK_STAT                   0xFFFFFDFF
+#define   S_000044_CRTC2_VBLANK_STAT_AK(x)             (((x) & 0x1) << 9)
+#define   G_000044_CRTC2_VBLANK_STAT_AK(x)             (((x) >> 9) & 0x1)
+#define   C_000044_CRTC2_VBLANK_STAT_AK                0xFFFFFDFF
+#define   S_000044_FP2_DETECT_STAT(x)                  (((x) & 0x1) << 10)
+#define   G_000044_FP2_DETECT_STAT(x)                  (((x) >> 10) & 0x1)
+#define   C_000044_FP2_DETECT_STAT                     0xFFFFFBFF
+#define   S_000044_FP2_DETECT_STAT_AK(x)               (((x) & 0x1) << 10)
+#define   G_000044_FP2_DETECT_STAT_AK(x)               (((x) >> 10) & 0x1)
+#define   C_000044_FP2_DETECT_STAT_AK                  0xFFFFFBFF
+#define   S_000044_VSYNC_DIFF_OVER_LIMIT_STAT(x)       (((x) & 0x1) << 11)
+#define   G_000044_VSYNC_DIFF_OVER_LIMIT_STAT(x)       (((x) >> 11) & 0x1)
+#define   C_000044_VSYNC_DIFF_OVER_LIMIT_STAT          0xFFFFF7FF
+#define   S_000044_VSYNC_DIFF_OVER_LIMIT_STAT_AK(x)    (((x) & 0x1) << 11)
+#define   G_000044_VSYNC_DIFF_OVER_LIMIT_STAT_AK(x)    (((x) >> 11) & 0x1)
+#define   C_000044_VSYNC_DIFF_OVER_LIMIT_STAT_AK       0xFFFFF7FF
+#define   S_000044_DMA_VIPH0_INT(x)                    (((x) & 0x1) << 12)
+#define   G_000044_DMA_VIPH0_INT(x)                    (((x) >> 12) & 0x1)
+#define   C_000044_DMA_VIPH0_INT                       0xFFFFEFFF
+#define   S_000044_DMA_VIPH0_INT_AK(x)                 (((x) & 0x1) << 12)
+#define   G_000044_DMA_VIPH0_INT_AK(x)                 (((x) >> 12) & 0x1)
+#define   C_000044_DMA_VIPH0_INT_AK                    0xFFFFEFFF
+#define   S_000044_DMA_VIPH1_INT(x)                    (((x) & 0x1) << 13)
+#define   G_000044_DMA_VIPH1_INT(x)                    (((x) >> 13) & 0x1)
+#define   C_000044_DMA_VIPH1_INT                       0xFFFFDFFF
+#define   S_000044_DMA_VIPH1_INT_AK(x)                 (((x) & 0x1) << 13)
+#define   G_000044_DMA_VIPH1_INT_AK(x)                 (((x) >> 13) & 0x1)
+#define   C_000044_DMA_VIPH1_INT_AK                    0xFFFFDFFF
+#define   S_000044_DMA_VIPH2_INT(x)                    (((x) & 0x1) << 14)
+#define   G_000044_DMA_VIPH2_INT(x)                    (((x) >> 14) & 0x1)
+#define   C_000044_DMA_VIPH2_INT                       0xFFFFBFFF
+#define   S_000044_DMA_VIPH2_INT_AK(x)                 (((x) & 0x1) << 14)
+#define   G_000044_DMA_VIPH2_INT_AK(x)                 (((x) >> 14) & 0x1)
+#define   C_000044_DMA_VIPH2_INT_AK                    0xFFFFBFFF
+#define   S_000044_DMA_VIPH3_INT(x)                    (((x) & 0x1) << 15)
+#define   G_000044_DMA_VIPH3_INT(x)                    (((x) >> 15) & 0x1)
+#define   C_000044_DMA_VIPH3_INT                       0xFFFF7FFF
+#define   S_000044_DMA_VIPH3_INT_AK(x)                 (((x) & 0x1) << 15)
+#define   G_000044_DMA_VIPH3_INT_AK(x)                 (((x) >> 15) & 0x1)
+#define   C_000044_DMA_VIPH3_INT_AK                    0xFFFF7FFF
+#define   S_000044_I2C_INT(x)                          (((x) & 0x1) << 17)
+#define   G_000044_I2C_INT(x)                          (((x) >> 17) & 0x1)
+#define   C_000044_I2C_INT                             0xFFFDFFFF
+#define   S_000044_I2C_INT_AK(x)                       (((x) & 0x1) << 17)
+#define   G_000044_I2C_INT_AK(x)                       (((x) >> 17) & 0x1)
+#define   C_000044_I2C_INT_AK                          0xFFFDFFFF
+#define   S_000044_GUI_IDLE_STAT(x)                    (((x) & 0x1) << 19)
+#define   G_000044_GUI_IDLE_STAT(x)                    (((x) >> 19) & 0x1)
+#define   C_000044_GUI_IDLE_STAT                       0xFFF7FFFF
+#define   S_000044_GUI_IDLE_STAT_AK(x)                 (((x) & 0x1) << 19)
+#define   G_000044_GUI_IDLE_STAT_AK(x)                 (((x) >> 19) & 0x1)
+#define   C_000044_GUI_IDLE_STAT_AK                    0xFFF7FFFF
+#define   S_000044_VIPH_INT(x)                         (((x) & 0x1) << 24)
+#define   G_000044_VIPH_INT(x)                         (((x) >> 24) & 0x1)
+#define   C_000044_VIPH_INT                            0xFEFFFFFF
+#define   S_000044_SW_INT(x)                           (((x) & 0x1) << 25)
+#define   G_000044_SW_INT(x)                           (((x) >> 25) & 0x1)
+#define   C_000044_SW_INT                              0xFDFFFFFF
+#define   S_000044_SW_INT_AK(x)                        (((x) & 0x1) << 25)
+#define   G_000044_SW_INT_AK(x)                        (((x) >> 25) & 0x1)
+#define   C_000044_SW_INT_AK                           0xFDFFFFFF
+#define   S_000044_SW_INT_SET(x)                       (((x) & 0x1) << 26)
+#define   G_000044_SW_INT_SET(x)                       (((x) >> 26) & 0x1)
+#define   C_000044_SW_INT_SET                          0xFBFFFFFF
+#define   S_000044_GEYSERVILLE_STAT(x)                 (((x) & 0x1) << 27)
+#define   G_000044_GEYSERVILLE_STAT(x)                 (((x) >> 27) & 0x1)
+#define   C_000044_GEYSERVILLE_STAT                    0xF7FFFFFF
+#define   S_000044_GEYSERVILLE_STAT_AK(x)              (((x) & 0x1) << 27)
+#define   G_000044_GEYSERVILLE_STAT_AK(x)              (((x) >> 27) & 0x1)
+#define   C_000044_GEYSERVILLE_STAT_AK                 0xF7FFFFFF
+#define   S_000044_HDCP_AUTHORIZED_INT_STAT(x)         (((x) & 0x1) << 28)
+#define   G_000044_HDCP_AUTHORIZED_INT_STAT(x)         (((x) >> 28) & 0x1)
+#define   C_000044_HDCP_AUTHORIZED_INT_STAT            0xEFFFFFFF
+#define   S_000044_HDCP_AUTHORIZED_INT_AK(x)           (((x) & 0x1) << 28)
+#define   G_000044_HDCP_AUTHORIZED_INT_AK(x)           (((x) >> 28) & 0x1)
+#define   C_000044_HDCP_AUTHORIZED_INT_AK              0xEFFFFFFF
+#define   S_000044_DVI_I2C_INT_STAT(x)                 (((x) & 0x1) << 29)
+#define   G_000044_DVI_I2C_INT_STAT(x)                 (((x) >> 29) & 0x1)
+#define   C_000044_DVI_I2C_INT_STAT                    0xDFFFFFFF
+#define   S_000044_DVI_I2C_INT_AK(x)                   (((x) & 0x1) << 29)
+#define   G_000044_DVI_I2C_INT_AK(x)                   (((x) >> 29) & 0x1)
+#define   C_000044_DVI_I2C_INT_AK                      0xDFFFFFFF
+#define   S_000044_GUIDMA_STAT(x)                      (((x) & 0x1) << 30)
+#define   G_000044_GUIDMA_STAT(x)                      (((x) >> 30) & 0x1)
+#define   C_000044_GUIDMA_STAT                         0xBFFFFFFF
+#define   S_000044_GUIDMA_AK(x)                        (((x) & 0x1) << 30)
+#define   G_000044_GUIDMA_AK(x)                        (((x) >> 30) & 0x1)
+#define   C_000044_GUIDMA_AK                           0xBFFFFFFF
+#define   S_000044_VIDDMA_STAT(x)                      (((x) & 0x1) << 31)
+#define   G_000044_VIDDMA_STAT(x)                      (((x) >> 31) & 0x1)
+#define   C_000044_VIDDMA_STAT                         0x7FFFFFFF
+#define   S_000044_VIDDMA_AK(x)                        (((x) & 0x1) << 31)
+#define   G_000044_VIDDMA_AK(x)                        (((x) >> 31) & 0x1)
+#define   C_000044_VIDDMA_AK                           0x7FFFFFFF
+#define R_000050_CRTC_GEN_CNTL                       0x000050
+#define   S_000050_CRTC_DBL_SCAN_EN(x)                 (((x) & 0x1) << 0)
+#define   G_000050_CRTC_DBL_SCAN_EN(x)                 (((x) >> 0) & 0x1)
+#define   C_000050_CRTC_DBL_SCAN_EN                    0xFFFFFFFE
+#define   S_000050_CRTC_INTERLACE_EN(x)                (((x) & 0x1) << 1)
+#define   G_000050_CRTC_INTERLACE_EN(x)                (((x) >> 1) & 0x1)
+#define   C_000050_CRTC_INTERLACE_EN                   0xFFFFFFFD
+#define   S_000050_CRTC_C_SYNC_EN(x)                   (((x) & 0x1) << 4)
+#define   G_000050_CRTC_C_SYNC_EN(x)                   (((x) >> 4) & 0x1)
+#define   C_000050_CRTC_C_SYNC_EN                      0xFFFFFFEF
+#define   S_000050_CRTC_PIX_WIDTH(x)                   (((x) & 0xF) << 8)
+#define   G_000050_CRTC_PIX_WIDTH(x)                   (((x) >> 8) & 0xF)
+#define   C_000050_CRTC_PIX_WIDTH                      0xFFFFF0FF
+#define   S_000050_CRTC_ICON_EN(x)                     (((x) & 0x1) << 15)
+#define   G_000050_CRTC_ICON_EN(x)                     (((x) >> 15) & 0x1)
+#define   C_000050_CRTC_ICON_EN                        0xFFFF7FFF
+#define   S_000050_CRTC_CUR_EN(x)                      (((x) & 0x1) << 16)
+#define   G_000050_CRTC_CUR_EN(x)                      (((x) >> 16) & 0x1)
+#define   C_000050_CRTC_CUR_EN                         0xFFFEFFFF
+#define   S_000050_CRTC_VSTAT_MODE(x)                  (((x) & 0x3) << 17)
+#define   G_000050_CRTC_VSTAT_MODE(x)                  (((x) >> 17) & 0x3)
+#define   C_000050_CRTC_VSTAT_MODE                     0xFFF9FFFF
+#define   S_000050_CRTC_CUR_MODE(x)                    (((x) & 0x7) << 20)
+#define   G_000050_CRTC_CUR_MODE(x)                    (((x) >> 20) & 0x7)
+#define   C_000050_CRTC_CUR_MODE                       0xFF8FFFFF
+#define   S_000050_CRTC_EXT_DISP_EN(x)                 (((x) & 0x1) << 24)
+#define   G_000050_CRTC_EXT_DISP_EN(x)                 (((x) >> 24) & 0x1)
+#define   C_000050_CRTC_EXT_DISP_EN                    0xFEFFFFFF
+#define   S_000050_CRTC_EN(x)                          (((x) & 0x1) << 25)
+#define   G_000050_CRTC_EN(x)                          (((x) >> 25) & 0x1)
+#define   C_000050_CRTC_EN                             0xFDFFFFFF
+#define   S_000050_CRTC_DISP_REQ_EN_B(x)               (((x) & 0x1) << 26)
+#define   G_000050_CRTC_DISP_REQ_EN_B(x)               (((x) >> 26) & 0x1)
+#define   C_000050_CRTC_DISP_REQ_EN_B                  0xFBFFFFFF
+#define R_000054_CRTC_EXT_CNTL                       0x000054
+#define   S_000054_CRTC_VGA_XOVERSCAN(x)               (((x) & 0x1) << 0)
+#define   G_000054_CRTC_VGA_XOVERSCAN(x)               (((x) >> 0) & 0x1)
+#define   C_000054_CRTC_VGA_XOVERSCAN                  0xFFFFFFFE
+#define   S_000054_VGA_BLINK_RATE(x)                   (((x) & 0x3) << 1)
+#define   G_000054_VGA_BLINK_RATE(x)                   (((x) >> 1) & 0x3)
+#define   C_000054_VGA_BLINK_RATE                      0xFFFFFFF9
+#define   S_000054_VGA_ATI_LINEAR(x)                   (((x) & 0x1) << 3)
+#define   G_000054_VGA_ATI_LINEAR(x)                   (((x) >> 3) & 0x1)
+#define   C_000054_VGA_ATI_LINEAR                      0xFFFFFFF7
+#define   S_000054_VGA_128KAP_PAGING(x)                (((x) & 0x1) << 4)
+#define   G_000054_VGA_128KAP_PAGING(x)                (((x) >> 4) & 0x1)
+#define   C_000054_VGA_128KAP_PAGING                   0xFFFFFFEF
+#define   S_000054_VGA_TEXT_132(x)                     (((x) & 0x1) << 5)
+#define   G_000054_VGA_TEXT_132(x)                     (((x) >> 5) & 0x1)
+#define   C_000054_VGA_TEXT_132                        0xFFFFFFDF
+#define   S_000054_VGA_XCRT_CNT_EN(x)                  (((x) & 0x1) << 6)
+#define   G_000054_VGA_XCRT_CNT_EN(x)                  (((x) >> 6) & 0x1)
+#define   C_000054_VGA_XCRT_CNT_EN                     0xFFFFFFBF
+#define   S_000054_CRTC_HSYNC_DIS(x)                   (((x) & 0x1) << 8)
+#define   G_000054_CRTC_HSYNC_DIS(x)                   (((x) >> 8) & 0x1)
+#define   C_000054_CRTC_HSYNC_DIS                      0xFFFFFEFF
+#define   S_000054_CRTC_VSYNC_DIS(x)                   (((x) & 0x1) << 9)
+#define   G_000054_CRTC_VSYNC_DIS(x)                   (((x) >> 9) & 0x1)
+#define   C_000054_CRTC_VSYNC_DIS                      0xFFFFFDFF
+#define   S_000054_CRTC_DISPLAY_DIS(x)                 (((x) & 0x1) << 10)
+#define   G_000054_CRTC_DISPLAY_DIS(x)                 (((x) >> 10) & 0x1)
+#define   C_000054_CRTC_DISPLAY_DIS                    0xFFFFFBFF
+#define   S_000054_CRTC_SYNC_TRISTATE(x)               (((x) & 0x1) << 11)
+#define   G_000054_CRTC_SYNC_TRISTATE(x)               (((x) >> 11) & 0x1)
+#define   C_000054_CRTC_SYNC_TRISTATE                  0xFFFFF7FF
+#define   S_000054_CRTC_HSYNC_TRISTATE(x)              (((x) & 0x1) << 12)
+#define   G_000054_CRTC_HSYNC_TRISTATE(x)              (((x) >> 12) & 0x1)
+#define   C_000054_CRTC_HSYNC_TRISTATE                 0xFFFFEFFF
+#define   S_000054_CRTC_VSYNC_TRISTATE(x)              (((x) & 0x1) << 13)
+#define   G_000054_CRTC_VSYNC_TRISTATE(x)              (((x) >> 13) & 0x1)
+#define   C_000054_CRTC_VSYNC_TRISTATE                 0xFFFFDFFF
+#define   S_000054_CRT_ON(x)                           (((x) & 0x1) << 15)
+#define   G_000054_CRT_ON(x)                           (((x) >> 15) & 0x1)
+#define   C_000054_CRT_ON                              0xFFFF7FFF
+#define   S_000054_VGA_CUR_B_TEST(x)                   (((x) & 0x1) << 17)
+#define   G_000054_VGA_CUR_B_TEST(x)                   (((x) >> 17) & 0x1)
+#define   C_000054_VGA_CUR_B_TEST                      0xFFFDFFFF
+#define   S_000054_VGA_PACK_DIS(x)                     (((x) & 0x1) << 18)
+#define   G_000054_VGA_PACK_DIS(x)                     (((x) >> 18) & 0x1)
+#define   C_000054_VGA_PACK_DIS                        0xFFFBFFFF
+#define   S_000054_VGA_MEM_PS_EN(x)                    (((x) & 0x1) << 19)
+#define   G_000054_VGA_MEM_PS_EN(x)                    (((x) >> 19) & 0x1)
+#define   C_000054_VGA_MEM_PS_EN                       0xFFF7FFFF
+#define   S_000054_VCRTC_IDX_MASTER(x)                 (((x) & 0x7F) << 24)
+#define   G_000054_VCRTC_IDX_MASTER(x)                 (((x) >> 24) & 0x7F)
+#define   C_000054_VCRTC_IDX_MASTER                    0x80FFFFFF
+#define R_000148_MC_FB_LOCATION                      0x000148
+#define   S_000148_MC_FB_START(x)                      (((x) & 0xFFFF) << 0)
+#define   G_000148_MC_FB_START(x)                      (((x) >> 0) & 0xFFFF)
+#define   C_000148_MC_FB_START                         0xFFFF0000
+#define   S_000148_MC_FB_TOP(x)                        (((x) & 0xFFFF) << 16)
+#define   G_000148_MC_FB_TOP(x)                        (((x) >> 16) & 0xFFFF)
+#define   C_000148_MC_FB_TOP                           0x0000FFFF
+#define R_00014C_MC_AGP_LOCATION                     0x00014C
+#define   S_00014C_MC_AGP_START(x)                     (((x) & 0xFFFF) << 0)
+#define   G_00014C_MC_AGP_START(x)                     (((x) >> 0) & 0xFFFF)
+#define   C_00014C_MC_AGP_START                        0xFFFF0000
+#define   S_00014C_MC_AGP_TOP(x)                       (((x) & 0xFFFF) << 16)
+#define   G_00014C_MC_AGP_TOP(x)                       (((x) >> 16) & 0xFFFF)
+#define   C_00014C_MC_AGP_TOP                          0x0000FFFF
+#define R_000170_AGP_BASE                            0x000170
+#define   S_000170_AGP_BASE_ADDR(x)                    (((x) & 0xFFFFFFFF) << 0)
+#define   G_000170_AGP_BASE_ADDR(x)                    (((x) >> 0) & 0xFFFFFFFF)
+#define   C_000170_AGP_BASE_ADDR                       0x00000000
+#define R_00023C_DISPLAY_BASE_ADDR                   0x00023C
+#define   S_00023C_DISPLAY_BASE_ADDR(x)                (((x) & 0xFFFFFFFF) << 0)
+#define   G_00023C_DISPLAY_BASE_ADDR(x)                (((x) >> 0) & 0xFFFFFFFF)
+#define   C_00023C_DISPLAY_BASE_ADDR                   0x00000000
+#define R_000260_CUR_OFFSET                          0x000260
+#define   S_000260_CUR_OFFSET(x)                       (((x) & 0x7FFFFFF) << 0)
+#define   G_000260_CUR_OFFSET(x)                       (((x) >> 0) & 0x7FFFFFF)
+#define   C_000260_CUR_OFFSET                          0xF8000000
+#define   S_000260_CUR_LOCK(x)                         (((x) & 0x1) << 31)
+#define   G_000260_CUR_LOCK(x)                         (((x) >> 31) & 0x1)
+#define   C_000260_CUR_LOCK                            0x7FFFFFFF
+#define R_00033C_CRTC2_DISPLAY_BASE_ADDR             0x00033C
+#define   S_00033C_CRTC2_DISPLAY_BASE_ADDR(x)          (((x) & 0xFFFFFFFF) << 0)
+#define   G_00033C_CRTC2_DISPLAY_BASE_ADDR(x)          (((x) >> 0) & 0xFFFFFFFF)
+#define   C_00033C_CRTC2_DISPLAY_BASE_ADDR             0x00000000
+#define R_000360_CUR2_OFFSET                         0x000360
+#define   S_000360_CUR2_OFFSET(x)                      (((x) & 0x7FFFFFF) << 0)
+#define   G_000360_CUR2_OFFSET(x)                      (((x) >> 0) & 0x7FFFFFF)
+#define   C_000360_CUR2_OFFSET                         0xF8000000
+#define   S_000360_CUR2_LOCK(x)                        (((x) & 0x1) << 31)
+#define   G_000360_CUR2_LOCK(x)                        (((x) >> 31) & 0x1)
+#define   C_000360_CUR2_LOCK                           0x7FFFFFFF
+#define R_0003C2_GENMO_WT                            0x0003C2
+#define   S_0003C2_GENMO_MONO_ADDRESS_B(x)             (((x) & 0x1) << 0)
+#define   G_0003C2_GENMO_MONO_ADDRESS_B(x)             (((x) >> 0) & 0x1)
+#define   C_0003C2_GENMO_MONO_ADDRESS_B                0xFE
+#define   S_0003C2_VGA_RAM_EN(x)                       (((x) & 0x1) << 1)
+#define   G_0003C2_VGA_RAM_EN(x)                       (((x) >> 1) & 0x1)
+#define   C_0003C2_VGA_RAM_EN                          0xFD
+#define   S_0003C2_VGA_CKSEL(x)                        (((x) & 0x3) << 2)
+#define   G_0003C2_VGA_CKSEL(x)                        (((x) >> 2) & 0x3)
+#define   C_0003C2_VGA_CKSEL                           0xF3
+#define   S_0003C2_ODD_EVEN_MD_PGSEL(x)                (((x) & 0x1) << 5)
+#define   G_0003C2_ODD_EVEN_MD_PGSEL(x)                (((x) >> 5) & 0x1)
+#define   C_0003C2_ODD_EVEN_MD_PGSEL                   0xDF
+#define   S_0003C2_VGA_HSYNC_POL(x)                    (((x) & 0x1) << 6)
+#define   G_0003C2_VGA_HSYNC_POL(x)                    (((x) >> 6) & 0x1)
+#define   C_0003C2_VGA_HSYNC_POL                       0xBF
+#define   S_0003C2_VGA_VSYNC_POL(x)                    (((x) & 0x1) << 7)
+#define   G_0003C2_VGA_VSYNC_POL(x)                    (((x) >> 7) & 0x1)
+#define   C_0003C2_VGA_VSYNC_POL                       0x7F
+#define R_0003F8_CRTC2_GEN_CNTL                      0x0003F8
+#define   S_0003F8_CRTC2_DBL_SCAN_EN(x)                (((x) & 0x1) << 0)
+#define   G_0003F8_CRTC2_DBL_SCAN_EN(x)                (((x) >> 0) & 0x1)
+#define   C_0003F8_CRTC2_DBL_SCAN_EN                   0xFFFFFFFE
+#define   S_0003F8_CRTC2_INTERLACE_EN(x)               (((x) & 0x1) << 1)
+#define   G_0003F8_CRTC2_INTERLACE_EN(x)               (((x) >> 1) & 0x1)
+#define   C_0003F8_CRTC2_INTERLACE_EN                  0xFFFFFFFD
+#define   S_0003F8_CRTC2_SYNC_TRISTATE(x)              (((x) & 0x1) << 4)
+#define   G_0003F8_CRTC2_SYNC_TRISTATE(x)              (((x) >> 4) & 0x1)
+#define   C_0003F8_CRTC2_SYNC_TRISTATE                 0xFFFFFFEF
+#define   S_0003F8_CRTC2_HSYNC_TRISTATE(x)             (((x) & 0x1) << 5)
+#define   G_0003F8_CRTC2_HSYNC_TRISTATE(x)             (((x) >> 5) & 0x1)
+#define   C_0003F8_CRTC2_HSYNC_TRISTATE                0xFFFFFFDF
+#define   S_0003F8_CRTC2_VSYNC_TRISTATE(x)             (((x) & 0x1) << 6)
+#define   G_0003F8_CRTC2_VSYNC_TRISTATE(x)             (((x) >> 6) & 0x1)
+#define   C_0003F8_CRTC2_VSYNC_TRISTATE                0xFFFFFFBF
+#define   S_0003F8_CRT2_ON(x)                          (((x) & 0x1) << 7)
+#define   G_0003F8_CRT2_ON(x)                          (((x) >> 7) & 0x1)
+#define   C_0003F8_CRT2_ON                             0xFFFFFF7F
+#define   S_0003F8_CRTC2_PIX_WIDTH(x)                  (((x) & 0xF) << 8)
+#define   G_0003F8_CRTC2_PIX_WIDTH(x)                  (((x) >> 8) & 0xF)
+#define   C_0003F8_CRTC2_PIX_WIDTH                     0xFFFFF0FF
+#define   S_0003F8_CRTC2_ICON_EN(x)                    (((x) & 0x1) << 15)
+#define   G_0003F8_CRTC2_ICON_EN(x)                    (((x) >> 15) & 0x1)
+#define   C_0003F8_CRTC2_ICON_EN                       0xFFFF7FFF
+#define   S_0003F8_CRTC2_CUR_EN(x)                     (((x) & 0x1) << 16)
+#define   G_0003F8_CRTC2_CUR_EN(x)                     (((x) >> 16) & 0x1)
+#define   C_0003F8_CRTC2_CUR_EN                        0xFFFEFFFF
+#define   S_0003F8_CRTC2_CUR_MODE(x)                   (((x) & 0x7) << 20)
+#define   G_0003F8_CRTC2_CUR_MODE(x)                   (((x) >> 20) & 0x7)
+#define   C_0003F8_CRTC2_CUR_MODE                      0xFF8FFFFF
+#define   S_0003F8_CRTC2_DISPLAY_DIS(x)                (((x) & 0x1) << 23)
+#define   G_0003F8_CRTC2_DISPLAY_DIS(x)                (((x) >> 23) & 0x1)
+#define   C_0003F8_CRTC2_DISPLAY_DIS                   0xFF7FFFFF
+#define   S_0003F8_CRTC2_EN(x)                         (((x) & 0x1) << 25)
+#define   G_0003F8_CRTC2_EN(x)                         (((x) >> 25) & 0x1)
+#define   C_0003F8_CRTC2_EN                            0xFDFFFFFF
+#define   S_0003F8_CRTC2_DISP_REQ_EN_B(x)              (((x) & 0x1) << 26)
+#define   G_0003F8_CRTC2_DISP_REQ_EN_B(x)              (((x) >> 26) & 0x1)
+#define   C_0003F8_CRTC2_DISP_REQ_EN_B                 0xFBFFFFFF
+#define   S_0003F8_CRTC2_C_SYNC_EN(x)                  (((x) & 0x1) << 27)
+#define   G_0003F8_CRTC2_C_SYNC_EN(x)                  (((x) >> 27) & 0x1)
+#define   C_0003F8_CRTC2_C_SYNC_EN                     0xF7FFFFFF
+#define   S_0003F8_CRTC2_HSYNC_DIS(x)                  (((x) & 0x1) << 28)
+#define   G_0003F8_CRTC2_HSYNC_DIS(x)                  (((x) >> 28) & 0x1)
+#define   C_0003F8_CRTC2_HSYNC_DIS                     0xEFFFFFFF
+#define   S_0003F8_CRTC2_VSYNC_DIS(x)                  (((x) & 0x1) << 29)
+#define   G_0003F8_CRTC2_VSYNC_DIS(x)                  (((x) >> 29) & 0x1)
+#define   C_0003F8_CRTC2_VSYNC_DIS                     0xDFFFFFFF
+#define R_000420_OV0_SCALE_CNTL                      0x000420
+#define   S_000420_OV0_NO_READ_BEHIND_SCAN(x)          (((x) & 0x1) << 1)
+#define   G_000420_OV0_NO_READ_BEHIND_SCAN(x)          (((x) >> 1) & 0x1)
+#define   C_000420_OV0_NO_READ_BEHIND_SCAN             0xFFFFFFFD
+#define   S_000420_OV0_HORZ_PICK_NEAREST(x)            (((x) & 0x1) << 2)
+#define   G_000420_OV0_HORZ_PICK_NEAREST(x)            (((x) >> 2) & 0x1)
+#define   C_000420_OV0_HORZ_PICK_NEAREST               0xFFFFFFFB
+#define   S_000420_OV0_VERT_PICK_NEAREST(x)            (((x) & 0x1) << 3)
+#define   G_000420_OV0_VERT_PICK_NEAREST(x)            (((x) >> 3) & 0x1)
+#define   C_000420_OV0_VERT_PICK_NEAREST               0xFFFFFFF7
+#define   S_000420_OV0_SIGNED_UV(x)                    (((x) & 0x1) << 4)
+#define   G_000420_OV0_SIGNED_UV(x)                    (((x) >> 4) & 0x1)
+#define   C_000420_OV0_SIGNED_UV                       0xFFFFFFEF
+#define   S_000420_OV0_GAMMA_SEL(x)                    (((x) & 0x7) << 5)
+#define   G_000420_OV0_GAMMA_SEL(x)                    (((x) >> 5) & 0x7)
+#define   C_000420_OV0_GAMMA_SEL                       0xFFFFFF1F
+#define   S_000420_OV0_SURFACE_FORMAT(x)               (((x) & 0xF) << 8)
+#define   G_000420_OV0_SURFACE_FORMAT(x)               (((x) >> 8) & 0xF)
+#define   C_000420_OV0_SURFACE_FORMAT                  0xFFFFF0FF
+#define   S_000420_OV0_ADAPTIVE_DEINT(x)               (((x) & 0x1) << 12)
+#define   G_000420_OV0_ADAPTIVE_DEINT(x)               (((x) >> 12) & 0x1)
+#define   C_000420_OV0_ADAPTIVE_DEINT                  0xFFFFEFFF
+#define   S_000420_OV0_CRTC_SEL(x)                     (((x) & 0x1) << 14)
+#define   G_000420_OV0_CRTC_SEL(x)                     (((x) >> 14) & 0x1)
+#define   C_000420_OV0_CRTC_SEL                        0xFFFFBFFF
+#define   S_000420_OV0_BURST_PER_PLANE(x)              (((x) & 0x7F) << 16)
+#define   G_000420_OV0_BURST_PER_PLANE(x)              (((x) >> 16) & 0x7F)
+#define   C_000420_OV0_BURST_PER_PLANE                 0xFF80FFFF
+#define   S_000420_OV0_DOUBLE_BUFFER_REGS(x)           (((x) & 0x1) << 24)
+#define   G_000420_OV0_DOUBLE_BUFFER_REGS(x)           (((x) >> 24) & 0x1)
+#define   C_000420_OV0_DOUBLE_BUFFER_REGS              0xFEFFFFFF
+#define   S_000420_OV0_BANDWIDTH(x)                    (((x) & 0x1) << 26)
+#define   G_000420_OV0_BANDWIDTH(x)                    (((x) >> 26) & 0x1)
+#define   C_000420_OV0_BANDWIDTH                       0xFBFFFFFF
+#define   S_000420_OV0_LIN_TRANS_BYPASS(x)             (((x) & 0x1) << 28)
+#define   G_000420_OV0_LIN_TRANS_BYPASS(x)             (((x) >> 28) & 0x1)
+#define   C_000420_OV0_LIN_TRANS_BYPASS                0xEFFFFFFF
+#define   S_000420_OV0_INT_EMU(x)                      (((x) & 0x1) << 29)
+#define   G_000420_OV0_INT_EMU(x)                      (((x) >> 29) & 0x1)
+#define   C_000420_OV0_INT_EMU                         0xDFFFFFFF
+#define   S_000420_OV0_OVERLAY_EN(x)                   (((x) & 0x1) << 30)
+#define   G_000420_OV0_OVERLAY_EN(x)                   (((x) >> 30) & 0x1)
+#define   C_000420_OV0_OVERLAY_EN                      0xBFFFFFFF
+#define   S_000420_OV0_SOFT_RESET(x)                   (((x) & 0x1) << 31)
+#define   G_000420_OV0_SOFT_RESET(x)                   (((x) >> 31) & 0x1)
+#define   C_000420_OV0_SOFT_RESET                      0x7FFFFFFF
+#define R_00070C_CP_RB_RPTR_ADDR                     0x00070C
+#define   S_00070C_RB_RPTR_SWAP(x)                     (((x) & 0x3) << 0)
+#define   G_00070C_RB_RPTR_SWAP(x)                     (((x) >> 0) & 0x3)
+#define   C_00070C_RB_RPTR_SWAP                        0xFFFFFFFC
+#define   S_00070C_RB_RPTR_ADDR(x)                     (((x) & 0x3FFFFFFF) << 2)
+#define   G_00070C_RB_RPTR_ADDR(x)                     (((x) >> 2) & 0x3FFFFFFF)
+#define   C_00070C_RB_RPTR_ADDR                        0x00000003
+#define R_000740_CP_CSQ_CNTL                         0x000740
+#define   S_000740_CSQ_CNT_PRIMARY(x)                  (((x) & 0xFF) << 0)
+#define   G_000740_CSQ_CNT_PRIMARY(x)                  (((x) >> 0) & 0xFF)
+#define   C_000740_CSQ_CNT_PRIMARY                     0xFFFFFF00
+#define   S_000740_CSQ_CNT_INDIRECT(x)                 (((x) & 0xFF) << 8)
+#define   G_000740_CSQ_CNT_INDIRECT(x)                 (((x) >> 8) & 0xFF)
+#define   C_000740_CSQ_CNT_INDIRECT                    0xFFFF00FF
+#define   S_000740_CSQ_MODE(x)                         (((x) & 0xF) << 28)
+#define   G_000740_CSQ_MODE(x)                         (((x) >> 28) & 0xF)
+#define   C_000740_CSQ_MODE                            0x0FFFFFFF
+#define R_000770_SCRATCH_UMSK                        0x000770
+#define   S_000770_SCRATCH_UMSK(x)                     (((x) & 0x3F) << 0)
+#define   G_000770_SCRATCH_UMSK(x)                     (((x) >> 0) & 0x3F)
+#define   C_000770_SCRATCH_UMSK                        0xFFFFFFC0
+#define   S_000770_SCRATCH_SWAP(x)                     (((x) & 0x3) << 16)
+#define   G_000770_SCRATCH_SWAP(x)                     (((x) >> 16) & 0x3)
+#define   C_000770_SCRATCH_SWAP                        0xFFFCFFFF
+#define R_000774_SCRATCH_ADDR                        0x000774
+#define   S_000774_SCRATCH_ADDR(x)                     (((x) & 0x7FFFFFF) << 5)
+#define   G_000774_SCRATCH_ADDR(x)                     (((x) >> 5) & 0x7FFFFFF)
+#define   C_000774_SCRATCH_ADDR                        0x0000001F
+#define R_0007C0_CP_STAT                             0x0007C0
+#define   S_0007C0_MRU_BUSY(x)                         (((x) & 0x1) << 0)
+#define   G_0007C0_MRU_BUSY(x)                         (((x) >> 0) & 0x1)
+#define   C_0007C0_MRU_BUSY                            0xFFFFFFFE
+#define   S_0007C0_MWU_BUSY(x)                         (((x) & 0x1) << 1)
+#define   G_0007C0_MWU_BUSY(x)                         (((x) >> 1) & 0x1)
+#define   C_0007C0_MWU_BUSY                            0xFFFFFFFD
+#define   S_0007C0_RSIU_BUSY(x)                        (((x) & 0x1) << 2)
+#define   G_0007C0_RSIU_BUSY(x)                        (((x) >> 2) & 0x1)
+#define   C_0007C0_RSIU_BUSY                           0xFFFFFFFB
+#define   S_0007C0_RCIU_BUSY(x)                        (((x) & 0x1) << 3)
+#define   G_0007C0_RCIU_BUSY(x)                        (((x) >> 3) & 0x1)
+#define   C_0007C0_RCIU_BUSY                           0xFFFFFFF7
+#define   S_0007C0_CSF_PRIMARY_BUSY(x)                 (((x) & 0x1) << 9)
+#define   G_0007C0_CSF_PRIMARY_BUSY(x)                 (((x) >> 9) & 0x1)
+#define   C_0007C0_CSF_PRIMARY_BUSY                    0xFFFFFDFF
+#define   S_0007C0_CSF_INDIRECT_BUSY(x)                (((x) & 0x1) << 10)
+#define   G_0007C0_CSF_INDIRECT_BUSY(x)                (((x) >> 10) & 0x1)
+#define   C_0007C0_CSF_INDIRECT_BUSY                   0xFFFFFBFF
+#define   S_0007C0_CSQ_PRIMARY_BUSY(x)                 (((x) & 0x1) << 11)
+#define   G_0007C0_CSQ_PRIMARY_BUSY(x)                 (((x) >> 11) & 0x1)
+#define   C_0007C0_CSQ_PRIMARY_BUSY                    0xFFFFF7FF
+#define   S_0007C0_CSQ_INDIRECT_BUSY(x)                (((x) & 0x1) << 12)
+#define   G_0007C0_CSQ_INDIRECT_BUSY(x)                (((x) >> 12) & 0x1)
+#define   C_0007C0_CSQ_INDIRECT_BUSY                   0xFFFFEFFF
+#define   S_0007C0_CSI_BUSY(x)                         (((x) & 0x1) << 13)
+#define   G_0007C0_CSI_BUSY(x)                         (((x) >> 13) & 0x1)
+#define   C_0007C0_CSI_BUSY                            0xFFFFDFFF
+#define   S_0007C0_GUIDMA_BUSY(x)                      (((x) & 0x1) << 28)
+#define   G_0007C0_GUIDMA_BUSY(x)                      (((x) >> 28) & 0x1)
+#define   C_0007C0_GUIDMA_BUSY                         0xEFFFFFFF
+#define   S_0007C0_VIDDMA_BUSY(x)                      (((x) & 0x1) << 29)
+#define   G_0007C0_VIDDMA_BUSY(x)                      (((x) >> 29) & 0x1)
+#define   C_0007C0_VIDDMA_BUSY                         0xDFFFFFFF
+#define   S_0007C0_CMDSTRM_BUSY(x)                     (((x) & 0x1) << 30)
+#define   G_0007C0_CMDSTRM_BUSY(x)                     (((x) >> 30) & 0x1)
+#define   C_0007C0_CMDSTRM_BUSY                        0xBFFFFFFF
+#define   S_0007C0_CP_BUSY(x)                          (((x) & 0x1) << 31)
+#define   G_0007C0_CP_BUSY(x)                          (((x) >> 31) & 0x1)
+#define   C_0007C0_CP_BUSY                             0x7FFFFFFF
+#define R_000E40_RBBM_STATUS                         0x000E40
+#define   S_000E40_CMDFIFO_AVAIL(x)                    (((x) & 0x7F) << 0)
+#define   G_000E40_CMDFIFO_AVAIL(x)                    (((x) >> 0) & 0x7F)
+#define   C_000E40_CMDFIFO_AVAIL                       0xFFFFFF80
+#define   S_000E40_HIRQ_ON_RBB(x)                      (((x) & 0x1) << 8)
+#define   G_000E40_HIRQ_ON_RBB(x)                      (((x) >> 8) & 0x1)
+#define   C_000E40_HIRQ_ON_RBB                         0xFFFFFEFF
+#define   S_000E40_CPRQ_ON_RBB(x)                      (((x) & 0x1) << 9)
+#define   G_000E40_CPRQ_ON_RBB(x)                      (((x) >> 9) & 0x1)
+#define   C_000E40_CPRQ_ON_RBB                         0xFFFFFDFF
+#define   S_000E40_CFRQ_ON_RBB(x)                      (((x) & 0x1) << 10)
+#define   G_000E40_CFRQ_ON_RBB(x)                      (((x) >> 10) & 0x1)
+#define   C_000E40_CFRQ_ON_RBB                         0xFFFFFBFF
+#define   S_000E40_HIRQ_IN_RTBUF(x)                    (((x) & 0x1) << 11)
+#define   G_000E40_HIRQ_IN_RTBUF(x)                    (((x) >> 11) & 0x1)
+#define   C_000E40_HIRQ_IN_RTBUF                       0xFFFFF7FF
+#define   S_000E40_CPRQ_IN_RTBUF(x)                    (((x) & 0x1) << 12)
+#define   G_000E40_CPRQ_IN_RTBUF(x)                    (((x) >> 12) & 0x1)
+#define   C_000E40_CPRQ_IN_RTBUF                       0xFFFFEFFF
+#define   S_000E40_CFRQ_IN_RTBUF(x)                    (((x) & 0x1) << 13)
+#define   G_000E40_CFRQ_IN_RTBUF(x)                    (((x) >> 13) & 0x1)
+#define   C_000E40_CFRQ_IN_RTBUF                       0xFFFFDFFF
+#define   S_000E40_CF_PIPE_BUSY(x)                     (((x) & 0x1) << 14)
+#define   G_000E40_CF_PIPE_BUSY(x)                     (((x) >> 14) & 0x1)
+#define   C_000E40_CF_PIPE_BUSY                        0xFFFFBFFF
+#define   S_000E40_ENG_EV_BUSY(x)                      (((x) & 0x1) << 15)
+#define   G_000E40_ENG_EV_BUSY(x)                      (((x) >> 15) & 0x1)
+#define   C_000E40_ENG_EV_BUSY                         0xFFFF7FFF
+#define   S_000E40_CP_CMDSTRM_BUSY(x)                  (((x) & 0x1) << 16)
+#define   G_000E40_CP_CMDSTRM_BUSY(x)                  (((x) >> 16) & 0x1)
+#define   C_000E40_CP_CMDSTRM_BUSY                     0xFFFEFFFF
+#define   S_000E40_E2_BUSY(x)                          (((x) & 0x1) << 17)
+#define   G_000E40_E2_BUSY(x)                          (((x) >> 17) & 0x1)
+#define   C_000E40_E2_BUSY                             0xFFFDFFFF
+#define   S_000E40_RB2D_BUSY(x)                        (((x) & 0x1) << 18)
+#define   G_000E40_RB2D_BUSY(x)                        (((x) >> 18) & 0x1)
+#define   C_000E40_RB2D_BUSY                           0xFFFBFFFF
+#define   S_000E40_RB3D_BUSY(x)                        (((x) & 0x1) << 19)
+#define   G_000E40_RB3D_BUSY(x)                        (((x) >> 19) & 0x1)
+#define   C_000E40_RB3D_BUSY                           0xFFF7FFFF
+#define   S_000E40_SE_BUSY(x)                          (((x) & 0x1) << 20)
+#define   G_000E40_SE_BUSY(x)                          (((x) >> 20) & 0x1)
+#define   C_000E40_SE_BUSY                             0xFFEFFFFF
+#define   S_000E40_RE_BUSY(x)                          (((x) & 0x1) << 21)
+#define   G_000E40_RE_BUSY(x)                          (((x) >> 21) & 0x1)
+#define   C_000E40_RE_BUSY                             0xFFDFFFFF
+#define   S_000E40_TAM_BUSY(x)                         (((x) & 0x1) << 22)
+#define   G_000E40_TAM_BUSY(x)                         (((x) >> 22) & 0x1)
+#define   C_000E40_TAM_BUSY                            0xFFBFFFFF
+#define   S_000E40_TDM_BUSY(x)                         (((x) & 0x1) << 23)
+#define   G_000E40_TDM_BUSY(x)                         (((x) >> 23) & 0x1)
+#define   C_000E40_TDM_BUSY                            0xFF7FFFFF
+#define   S_000E40_PB_BUSY(x)                          (((x) & 0x1) << 24)
+#define   G_000E40_PB_BUSY(x)                          (((x) >> 24) & 0x1)
+#define   C_000E40_PB_BUSY                             0xFEFFFFFF
+#define   S_000E40_GUI_ACTIVE(x)                       (((x) & 0x1) << 31)
+#define   G_000E40_GUI_ACTIVE(x)                       (((x) >> 31) & 0x1)
+#define   C_000E40_GUI_ACTIVE                          0x7FFFFFFF
+
+
+#define R_00000D_SCLK_CNTL                           0x00000D
+#define   S_00000D_SCLK_SRC_SEL(x)                     (((x) & 0x7) << 0)
+#define   G_00000D_SCLK_SRC_SEL(x)                     (((x) >> 0) & 0x7)
+#define   C_00000D_SCLK_SRC_SEL                        0xFFFFFFF8
+#define   S_00000D_TCLK_SRC_SEL(x)                     (((x) & 0x7) << 8)
+#define   G_00000D_TCLK_SRC_SEL(x)                     (((x) >> 8) & 0x7)
+#define   C_00000D_TCLK_SRC_SEL                        0xFFFFF8FF
+#define   S_00000D_FORCE_CP(x)                         (((x) & 0x1) << 16)
+#define   G_00000D_FORCE_CP(x)                         (((x) >> 16) & 0x1)
+#define   C_00000D_FORCE_CP                            0xFFFEFFFF
+#define   S_00000D_FORCE_HDP(x)                        (((x) & 0x1) << 17)
+#define   G_00000D_FORCE_HDP(x)                        (((x) >> 17) & 0x1)
+#define   C_00000D_FORCE_HDP                           0xFFFDFFFF
+#define   S_00000D_FORCE_DISP(x)                       (((x) & 0x1) << 18)
+#define   G_00000D_FORCE_DISP(x)                       (((x) >> 18) & 0x1)
+#define   C_00000D_FORCE_DISP                          0xFFFBFFFF
+#define   S_00000D_FORCE_TOP(x)                        (((x) & 0x1) << 19)
+#define   G_00000D_FORCE_TOP(x)                        (((x) >> 19) & 0x1)
+#define   C_00000D_FORCE_TOP                           0xFFF7FFFF
+#define   S_00000D_FORCE_E2(x)                         (((x) & 0x1) << 20)
+#define   G_00000D_FORCE_E2(x)                         (((x) >> 20) & 0x1)
+#define   C_00000D_FORCE_E2                            0xFFEFFFFF
+#define   S_00000D_FORCE_SE(x)                         (((x) & 0x1) << 21)
+#define   G_00000D_FORCE_SE(x)                         (((x) >> 21) & 0x1)
+#define   C_00000D_FORCE_SE                            0xFFDFFFFF
+#define   S_00000D_FORCE_IDCT(x)                       (((x) & 0x1) << 22)
+#define   G_00000D_FORCE_IDCT(x)                       (((x) >> 22) & 0x1)
+#define   C_00000D_FORCE_IDCT                          0xFFBFFFFF
+#define   S_00000D_FORCE_VIP(x)                        (((x) & 0x1) << 23)
+#define   G_00000D_FORCE_VIP(x)                        (((x) >> 23) & 0x1)
+#define   C_00000D_FORCE_VIP                           0xFF7FFFFF
+#define   S_00000D_FORCE_RE(x)                         (((x) & 0x1) << 24)
+#define   G_00000D_FORCE_RE(x)                         (((x) >> 24) & 0x1)
+#define   C_00000D_FORCE_RE                            0xFEFFFFFF
+#define   S_00000D_FORCE_PB(x)                         (((x) & 0x1) << 25)
+#define   G_00000D_FORCE_PB(x)                         (((x) >> 25) & 0x1)
+#define   C_00000D_FORCE_PB                            0xFDFFFFFF
+#define   S_00000D_FORCE_TAM(x)                        (((x) & 0x1) << 26)
+#define   G_00000D_FORCE_TAM(x)                        (((x) >> 26) & 0x1)
+#define   C_00000D_FORCE_TAM                           0xFBFFFFFF
+#define   S_00000D_FORCE_TDM(x)                        (((x) & 0x1) << 27)
+#define   G_00000D_FORCE_TDM(x)                        (((x) >> 27) & 0x1)
+#define   C_00000D_FORCE_TDM                           0xF7FFFFFF
+#define   S_00000D_FORCE_RB(x)                         (((x) & 0x1) << 28)
+#define   G_00000D_FORCE_RB(x)                         (((x) >> 28) & 0x1)
+#define   C_00000D_FORCE_RB                            0xEFFFFFFF
+
+/* PLL regs */
+#define SCLK_CNTL                                      0xd
+#define   FORCE_HDP                                    (1 << 17)
+#define CLK_PWRMGT_CNTL                                0x14
+#define   GLOBAL_PMAN_EN                               (1 << 10)
+#define   DISP_PM                                      (1 << 20)
+#define PLL_PWRMGT_CNTL                                0x15
+#define   MPLL_TURNOFF                                 (1 << 0)
+#define   SPLL_TURNOFF                                 (1 << 1)
+#define   PPLL_TURNOFF                                 (1 << 2)
+#define   P2PLL_TURNOFF                                (1 << 3)
+#define   TVPLL_TURNOFF                                (1 << 4)
+#define   MOBILE_SU                                    (1 << 16)
+#define   SU_SCLK_USE_BCLK                             (1 << 17)
+#define SCLK_CNTL2                                     0x1e
+#define   REDUCED_SPEED_SCLK_MODE                      (1 << 16)
+#define   REDUCED_SPEED_SCLK_SEL(x)                    ((x) << 17)
+#define MCLK_MISC                                      0x1f
+#define   EN_MCLK_TRISTATE_IN_SUSPEND                  (1 << 18)
+#define SCLK_MORE_CNTL                                 0x35
+#define   REDUCED_SPEED_SCLK_EN                        (1 << 16)
+#define   IO_CG_VOLTAGE_DROP                           (1 << 17)
+#define   VOLTAGE_DELAY_SEL(x)                         ((x) << 20)
+#define   VOLTAGE_DROP_SYNC                            (1 << 19)
+
+/* mmreg */
+#define DISP_PWR_MAN                                   0xd08
+#define   DISP_D3_GRPH_RST                             (1 << 18)
+#define   DISP_D3_SUBPIC_RST                           (1 << 19)
+#define   DISP_D3_OV0_RST                              (1 << 20)
+#define   DISP_D1D2_GRPH_RST                           (1 << 21)
+#define   DISP_D1D2_SUBPIC_RST                         (1 << 22)
+#define   DISP_D1D2_OV0_RST                            (1 << 23)
+#define   DISP_DVO_ENABLE_RST                          (1 << 24)
+#define   TV_ENABLE_RST                                (1 << 25)
+#define   AUTO_PWRUP_EN                                (1 << 26)
+
+#endif
diff --git a/hw/display/r300.c b/hw/display/r300.c
new file mode 100644
index 0000000000..af4d7beda7
--- /dev/null
+++ b/hw/display/r300.c
@@ -0,0 +1,1087 @@
+/*
+ * QEMU ATI R300 SVGA emulation
+ *
+ * Copyright (c) 2019 Aaron Zakhrov
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ */
+
+/*
+ * WARNING:
+ * This is very incomplete and only enough for Linux console and some
+ * unaccelerated X output at the moment.
+ * Currently it's little more than a frame buffer with minimal functions,
+ * other more advanced features of the hardware are yet to be implemented.
+ * We only aim for Rage 128 Pro (and some RV100) and 2D only at first,
+ * No 3D at all yet (maybe after 2D works, but feel free to improve it)
+ */
+
+#include "qemu/osdep.h"
+#include "r300.h"
+#include "radeon_reg.h"
+#include "r100d.h"
+#include "r300d.h"
+#include "vga-access.h"
+#include "hw/qdev-properties.h"
+#include "vga_regs.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "ui/console.h"
+#include "hw/display/i2c-ddc.h"
+#include "trace.h"
+#include "hw/i386/amd_iommu.h"
+
+#define R300_DEBUG_HW_CURSOR 0
+
+static const struct {
+    const char *name;
+    uint16_t dev_id;
+} r300_model_aliases[] = {
+    { "radeon9500", PCI_DEVICE_ID_ATI_RADEON_9500_PRO },
+    { "radeon9700", PCI_DEVICE_ID_ATI_RADEON_9700 }
+};
+enum { VGA_MODE, EXT_MODE };
+
+
+
+
+static void r300_vga_update_irq(RADVGAState *s)
+{
+    pci_set_irq(&s->dev, !!(s->regs.gen_int_status & s->regs.gen_int_cntl));
+}
+
+static void r300_vga_vblank_irq(void *opaque)
+{
+    RADVGAState *s = opaque;
+
+    timer_mod(&s->vblank_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              NANOSECONDS_PER_SECOND / 60);
+    s->regs.gen_int_status |= RADEON_CRTC_VBLANK_CUR ;
+    r300_vga_update_irq(s);
+}
+
+static inline uint64_t r300_reg_read_offs(uint32_t reg, int offs,
+                                         unsigned int size)
+{
+    if (offs == 0 && size == 4) {
+        return reg;
+    } else {
+        return extract32(reg, offs * BITS_PER_BYTE, size * BITS_PER_BYTE);
+    }
+}
+
+static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    RADVGAState *s = opaque;
+    uint64_t val = 0;
+
+    switch (addr) {
+      // case RADEON_MCLK_CNTL:
+      // val = RADEON_FORCEON_MCLKA;
+      // break;
+    case RADEON_MC_STATUS:
+        val = s->regs.mc_status;
+        break;
+
+    case RADEON_MM_INDEX:
+        val = s->regs.mm_index;
+        break;
+    case RADEON_MM_DATA:
+
+        val = s->regs.mm_data;
+        break;
+        case RADEON_BIOS_0_SCRATCH:
+        {
+          val =s->regs.bios_scratch[0];
+            break;
+        }
+        case RADEON_BIOS_1_SCRATCH:
+        {
+          val =s->regs.bios_scratch[1];
+            break;
+        }
+        case RADEON_BIOS_2_SCRATCH:
+        {
+          val =s->regs.bios_scratch[2];
+            break;
+        }
+        case RADEON_BIOS_3_SCRATCH:
+        {
+          val =s->regs.bios_scratch[3];
+            break;
+        }
+        case RADEON_BIOS_4_SCRATCH:
+        {
+          val =s->regs.bios_scratch[4];
+            break;
+        }
+        case RADEON_BIOS_5_SCRATCH:
+        {
+          val =s->regs.bios_scratch[5];
+            break;
+        }
+        case RADEON_BIOS_6_SCRATCH:
+        {
+          val =s->regs.bios_scratch[6];
+            break;
+        }
+        case RADEON_BIOS_7_SCRATCH:
+        {
+          val =s->regs.bios_scratch[7];
+            break;
+        }
+    case RADEON_GEN_INT_CNTL:
+        val = s->regs.gen_int_cntl;
+
+        break;
+    case RADEON_GEN_INT_STATUS:
+        val = s->regs.gen_int_status;
+        break;
+    case RADEON_CRTC_GEN_CNTL:
+          val = vga_ioport_read(s,addr);
+        break;
+    case RADEON_CRTC_EXT_CNTL:
+    val = vga_ioport_read(s,addr);
+    break;
+    case RADEON_GPIO_VGA_DDC:
+
+        val = s->regs.gpio_vga_ddc;
+        break;
+    case RADEON_GPIO_DVI_DDC:
+      val = s->regs.gpio_dvi_ddc;
+      break;
+    case RADEON_CONFIG_CNTL:
+        val = s->regs.config_cntl;
+        break;
+    case RADEON_CONFIG_MEMSIZE:
+        val = s->vga.vram_size;
+        qemu_log("RADEON_MEMSIZE %ld \n",val);
+        break;
+    case RADEON_CONFIG_APER_SIZE:
+        val = s->vga.vram_size;
+        break;
+
+    case RADEON_RBBM_STATUS:
+        val = 64; /* free CMDFIFO entries */
+        break;
+    case RADEON_CRTC_H_TOTAL_DISP:
+        val = s->regs.crtc_h_total_disp;
+        break;
+    case RADEON_CRTC_H_SYNC_STRT_WID:
+        val = s->regs.crtc_h_sync_strt_wid;
+        break;
+    case RADEON_CRTC_V_TOTAL_DISP:
+        val = s->regs.crtc_v_total_disp;
+        break;
+    case RADEON_CRTC_V_SYNC_STRT_WID:
+        val = s->regs.crtc_v_sync_strt_wid;
+        break;
+    case RADEON_CRTC_OFFSET:
+        val = s->regs.crtc_offset;
+        break;
+    case RADEON_CRTC_OFFSET_CNTL:
+        val = s->regs.crtc_offset_cntl;
+        break;
+    case RADEON_CRTC_PITCH:
+        val = s->regs.crtc_pitch;
+        break;
+    case RADEON_CUR_OFFSET:
+        val = s->regs.cur_offset;
+        break;
+    case RADEON_CUR_HORZ_VERT_POSN:
+        val = s->regs.cur_hv_pos;
+        val |= s->regs.cur_offset & BIT(31);
+        break;
+    case RADEON_CUR_HORZ_VERT_OFF:
+        val = s->regs.cur_hv_offs;
+        val |= s->regs.cur_offset & BIT(31);
+        break;
+    case RADEON_CUR_CLR0:
+        val = s->regs.cur_color0;
+        break;
+    case RADEON_CUR_CLR1:
+        val = s->regs.cur_color1;
+        break;
+    case RADEON_DST_OFFSET:
+        val = s->regs.dst_offset;
+        break;
+    case RADEON_DST_PITCH:
+        val = s->regs.dst_pitch;
+
+        break;
+    case RADEON_DST_WIDTH:
+        val = s->regs.dst_width;
+        break;
+    case RADEON_DST_HEIGHT:
+        val = s->regs.dst_height;
+        break;
+    case RADEON_SRC_X:
+        val = s->regs.src_x;
+        break;
+    case RADEON_SRC_Y:
+        val = s->regs.src_y;
+        break;
+    case RADEON_DST_X:
+        val = s->regs.dst_x;
+        break;
+    case RADEON_DST_Y:
+        val = s->regs.dst_y;
+        break;
+    case RADEON_DP_GUI_MASTER_CNTL:
+        val = s->regs.dp_gui_master_cntl;
+        break;
+    case RADEON_SRC_OFFSET:
+        val = s->regs.src_offset;
+        break;
+    case RADEON_SRC_PITCH:
+        val = s->regs.src_pitch;
+        break;
+    case RADEON_DP_BRUSH_BKGD_CLR:
+        val = s->regs.dp_brush_bkgd_clr;
+        break;
+    case RADEON_DP_BRUSH_FRGD_CLR:
+        val = s->regs.dp_brush_frgd_clr;
+        break;
+    case RADEON_DP_SRC_FRGD_CLR:
+        val = s->regs.dp_src_frgd_clr;
+        break;
+    case RADEON_DP_SRC_BKGD_CLR:
+        val = s->regs.dp_src_bkgd_clr;
+        break;
+    case RADEON_DP_CNTL:
+        val = s->regs.dp_cntl;
+        break;
+    case RADEON_DP_DATATYPE:
+        val = s->regs.dp_datatype;
+        break;
+    case RADEON_DP_MIX:
+        val = s->regs.dp_mix;
+        break;
+    case RADEON_DP_WRITE_MASK:
+        val = s->regs.dp_write_mask;
+        break;
+    case RADEON_DEFAULT_OFFSET:
+        val = s->regs.default_offset;
+        break;
+    case RADEON_DEFAULT_PITCH:
+        val = s->regs.default_pitch;
+        val |= s->regs.default_tile << 16;
+        break;
+    case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
+        val = s->regs.default_sc_bottom_right;
+        break;
+        case R300_GB_ENABLE:
+            val = s->regs.r300_gb_enable;
+            break;
+        case R300_GB_TILE_CONFIG:
+                val= s->regs.r300_gb_tile_config;
+                break;
+        case R300_GB_FIFO_SIZE:
+                val =s->regs.r300_gb_fifo_size ;
+                break;
+        case RADEON_ISYNC_CNTL:
+                val =s->regs.isync_cntl;
+                break;
+      case R300_DST_PIPE_CONFIG:
+                val =s->regs.r300_dst_pipe_config;
+                break;
+      case R300_RB2D_DSTCACHE_MODE:
+                val = s->regs.r300_rb2d_dstcache_mode;
+                break;
+      case RADEON_WAIT_UNTIL:
+                val = s->regs.wait_until;
+                break;
+      case R300_GB_SELECT:
+                val = s->regs.r300_gb_select;
+                break;
+      case R300_RB3D_DSTCACHE_CTLSTAT:
+                val = s->regs.r300_rb3d_dstcache_ctlstat;
+                break;
+      case R300_RB3D_ZCACHE_CTLSTAT:
+                val = s->regs.r300_rb3d_zcache_ctlstat;
+                break;
+      case R300_GB_AA_CONFIG:
+                val = s->regs.r300_gb_aa_config;
+                break;
+      case R300_RE_SCISSORS_TL:
+                val = s->regs.r300_re_scissors_tl;
+                break;
+
+      case R300_RE_SCISSORS_BR:
+                val = s->regs.r300_re_scissors_br;
+                break;
+      case RADEON_HOST_PATH_CNTL:
+                val = s->regs.host_path_cntl;
+                break;
+
+      case R300_GB_MSPOS0:
+                val = s->regs.r300_gb_mpos_0;
+                break;
+
+      case R300_GB_MSPOS1:
+                val = s->regs.r300_gb_mpos_1;
+                break;
+
+                case RADEON_SURFACE_CNTL:
+                          val = s->regs.surface_cntl;
+                          break;
+                case RADEON_SURFACE0_INFO:
+                          val = s->regs.surface0_info;
+                          break;
+                case RADEON_SURFACE1_INFO:
+                          val = s->regs.surface1_info;
+                          break;
+
+                case RADEON_SURFACE2_INFO:
+                val = s->regs.surface2_info;
+                break;
+                case RADEON_SURFACE3_INFO:
+                val = s->regs.surface3_info;
+                break;
+                case RADEON_SURFACE4_INFO:
+                val = s->regs.surface4_info;
+                break;
+                case RADEON_SURFACE5_INFO:
+                val = s->regs.surface5_info;
+                break;
+                case RADEON_SURFACE6_INFO:
+                val = s->regs.surface6_info;
+                break;
+                case RADEON_SURFACE7_INFO:
+                val = s->regs.surface7_info;
+                break;
+                case RADEON_OV0_SCALE_CNTL:
+                val = s->regs.ov0_scale_cntl;
+                break;
+                case RADEON_SUBPIC_CNTL:
+                val = s->regs.subpic_cntl;
+                break;
+                case RADEON_VIPH_CONTROL:
+                val = s->regs.viph_control;
+                break;
+                case RADEON_I2C_CNTL_1:
+                val = s->regs.i2c_cntl_1;
+                break;
+                case RADEON_DVI_I2C_CNTL_1:
+                val = s->regs.dvi_i2c_cntl_1;
+                break;
+                case RADEON_CAP0_TRIG_CNTL:
+                val = s->regs.cap0_trig_cntl;
+                break;
+                case RADEON_CAP1_TRIG_CNTL:
+                val = s->regs.cap1_trig_cntl;
+                break;
+                case RADEON_CUR2_OFFSET:
+                val = s->regs.cur2_offset;
+                break;
+                case RADEON_CRTC2_GEN_CNTL:
+                val = s->regs.crtc2_gen_cntl;
+                break;
+                case RADEON_AGP_BASE_2:
+                val = s->regs.agp_base_2;
+                break;
+                case RADEON_AGP_BASE:
+                val = s->regs.agp_base;
+                break;
+                case RADEON_MEM_ADDR_CONFIG:
+                val = s->regs.mem_addr_config;
+                break;
+                case RADEON_DISPLAY2_BASE_ADDR:
+                val = s->regs.r100_display_base_addr;
+                break;
+                case RADEON_SPLL_CNTL:
+                val = s->regs.spll_cntl;
+                break;
+                case RADEON_VCLK_ECP_CNTL:
+                val = s->regs.vclk_ecp_cntl;
+                break;
+
+
+                case RADEON_GENMO_WT:
+
+                      break;
+                case RADEON_CP_CSQ_CNTL:
+                    val = s->regs.cp_csq_cntl;
+                      break;
+                case RADEON_SCRATCH_UMSK:
+                      val = s->regs.scratch_umask;
+                      break;
+                case RADEON_SCLK_CNTL:
+                        val= s->regs.r100_sclk_cntl;
+                        qemu_log("RADEON_SCLK 0x%08lx \n",val);
+
+                        break;
+                case R_00023C_DISPLAY_BASE_ADDR:
+                        val = s->regs.r100_display_base_addr;
+                        break;
+                case RADEON_MEM_CNTL:
+                    val = R300_MEM_NUM_CHANNELS_MASK & R300_MEM_USE_CD_CH_ONLY;
+                    break;
+                case RADEON_CP_RB_CNTL:
+                    val = RADEON_RB_NO_UPDATE;
+                    break;
+
+                    case R300_CRTC_TILE_X0_Y0:
+                    val = s->regs.tile_x0_y0;
+
+                    break;
+                    case R300_MC_INIT_MISC_LAT_TIMER:
+                    val = s->regs.r300_mc_init_misc_lat_timer;
+                    break;
+
+                    case RADEON_M_SPLL_REF_FB_DIV:
+                    val = s->regs.m_spll_ref_fb_div;
+                    break;
+                    case RADEON_AIC_CNTL:
+                    val = s->regs.aic_cntl;
+                    break;
+                    case RADEON_AIC_PT_BASE:
+                    val = s->regs.aic_pt_base;
+
+                    break;
+
+                    case RADEON_PCI_GART_PAGE:
+                    qemu_log("READ GART \n");
+                    val = s->regs.pci_gart_page;
+                    qemu_log("GART REGISTER 0x%08lx CONTAINS 0x%08lx \n",addr,val);
+                    break;
+                    case RADEON_MC_AGP_LOCATION:
+                    val = s->regs.mc_agp_location;
+                    // qemu_log("READ MC_AGP \n");
+                    break;
+                    case RADEON_PCIE_INDEX:
+                    val = s->regs.pcie_index;
+                    break;
+                    case RADEON_PCIE_DATA:
+                    val = s->regs.pcie_data;
+                    break;
+                    case RADEON_AIC_LO_ADDR:
+                    val = s->regs.aic_lo_addr;
+                    break;
+                    case RADEON_AIC_HI_ADDR:
+                    val = s->regs.aic_hi_addr;
+                    break;
+                    case RADEON_FP_GEN_CNTL:
+                    val = s->regs.fp_gen_cntl;
+                    break;
+                    case RADEON_CRC_CMDFIFO_DOUT:
+
+                    break;
+                    case RADEON_DEVICE_ID:
+                    val = PCI_DEVICE_ID_ATI_RADEON_9500_PRO;
+                    break;
+                    case RADEON_DAC_CNTL:
+                    case RADEON_DAC_CNTL2:
+                    case RADEON_DAC_MACRO_CNTL:
+                    case RADEON_TV_DAC_CNTL:
+                    case RADEON_DAC_CRC_SIG:
+                    case RADEON_DAC_DATA:
+                    case RADEON_DAC_MASK:
+                    case RADEON_DAC_R_INDEX:
+                    case RADEON_DAC_W_INDEX:
+                    case RADEON_DAC_EXT_CNTL:
+                    case RADEON_GPIOPAD_MASK:
+                    case RADEON_GPIOPAD_A:
+                    case RADEON_GPIOPAD_EN:
+                    case RADEON_GPIOPAD_Y:
+                    case RADEON_MDGPIO_MASK:
+                    case RADEON_MDGPIO_A:
+                    case RADEON_MDGPIO_EN:
+                    case RADEON_MDGPIO_Y:
+                    case RADEON_DISP_OUTPUT_CNTL:
+                        val = vga_ioport_read(s,addr);
+                    break;
+
+
+
+
+
+
+
+
+
+
+
+
+    default:
+        qemu_log("READING FROM 0x%08lx \n",addr);
+        val = s->regs.emu_register_stub[addr % 1024];
+        qemu_log("REGISTER 0x%08lx CONTAINS 0x%08lx \n",addr,val);
+        break;
+    }
+    if (addr < RADEON_CUR_OFFSET || addr > RADEON_CUR_CLR1 || R300_DEBUG_HW_CURSOR) {
+        trace_ati_mm_read(size, addr, r300_reg_name(addr & ~3ULL), val);
+    }
+    // qemu_log("R300 MM_READ ADDRESS 0x%08lx DATA 0x%08lx \n",addr,val);
+    return val;
+}
+
+static inline void r300_reg_write_offs(uint32_t *reg, int offs,
+                                      uint64_t data, unsigned int size)
+{
+    if (offs == 0 && size == 4) {
+        *reg = data;
+    } else {
+        *reg = deposit32(*reg, offs * BITS_PER_BYTE, size * BITS_PER_BYTE,
+                         data);
+    }
+}
+
+static void r300_mm_write(void *opaque, hwaddr addr,
+                           uint64_t data, unsigned int size)
+{
+    RADVGAState *s = opaque;
+
+    // qemu_log("R300 MM_WRITE ADDRESS 0x%08lx DATA 0x%08lx \n",addr,data);
+
+    if (addr < RADEON_CUR_OFFSET || addr > RADEON_CUR_CLR1 || R300_DEBUG_HW_CURSOR) {
+        trace_ati_mm_write(size, addr, r300_reg_name(addr & ~3ULL), data);
+    }
+    switch (addr) {
+      case RADEON_GENMO_WT:
+
+            break;
+      case RADEON_CP_CSQ_CNTL:
+            s->regs.cp_csq_cntl = data;
+            break;
+      case RADEON_SCRATCH_UMSK:
+            s->regs.scratch_umask = data;
+            break;
+      case R_00023C_DISPLAY_BASE_ADDR:
+              s->regs.r100_display_base_addr = data;
+              break;
+
+      case RADEON_MC_STATUS:
+        qemu_log("RADEON_WRITE_MC \n");
+        s->regs.mc_status = R300_MC_IDLE;
+        s->regs.mc_status = data;
+        break;
+      case RADEON_RBBM_STATUS:
+      qemu_log("RADEON_WRITE_RBBM \n");
+        s->regs.rbbm_status = data|= RADEON_RBBM_FIFOCNT_MASK;
+        break;
+    case RADEON_MM_INDEX:
+        s->regs.mm_index = data;
+        break;
+    case RADEON_MM_DATA:
+        s->regs.mm_data = data;
+
+        break;
+    case RADEON_BIOS_0_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_0_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[0] = data;
+        break;
+    }
+    case RADEON_BIOS_1_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_1_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[1] = data;
+        break;
+    }
+    case RADEON_BIOS_2_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_2_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[2] = data;
+        break;
+    }
+    case RADEON_BIOS_3_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_3_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[3] = data;
+        break;
+    }
+    case RADEON_BIOS_4_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_4_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[4] = data;
+        break;
+    }
+    case RADEON_BIOS_5_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_5_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[5] = data;
+        break;
+    }
+    case RADEON_BIOS_6_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_6_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[6] = data;
+        break;
+    }
+    case RADEON_BIOS_7_SCRATCH:
+    {
+      // qemu_log("RADEON_WRITE_BIOS_7_SCRATCH, %lx \n",data);
+      s->regs.bios_scratch[7] = data;
+        break;
+    }
+    case RADEON_GEN_INT_CNTL:
+    // qemu_log("RADEON_WRITE_GEN_INT_CTL \n");
+        s->regs.gen_int_cntl = data;
+
+        break;
+    case RADEON_GEN_INT_STATUS:
+    // qemu_log("RADEON_WRITE_GEN_INT_STATUS \n");
+        s->regs.gen_int_status =data;
+
+        break;
+    case RADEON_CRTC_GEN_CNTL:
+    {
+      // qemu_log("RADEON_WRITE_CRTC_GEN \n");
+      s->regs.crtc_gen_cntl = data;
+      vga_ioport_write(s,addr,data);
+        break;
+    }
+    case RADEON_CRTC_EXT_CNTL:
+    {
+      vga_ioport_write(s,addr,data);
+        break;
+    }
+    case RADEON_GPIO_VGA_DDC:
+        s->regs.gpio_vga_ddc = data;
+        break;
+    case RADEON_GPIO_DVI_DDC:
+            s->regs.gpio_dvi_ddc = data;
+
+        break;
+    case RADEON_GPIO_MONID:
+
+        s->regs.gpio_monid = data;
+        break;
+    case RADEON_PALETTE_INDEX ... RADEON_PALETTE_INDEX + 3:
+
+        break;
+    case RADEON_PALETTE_DATA ... RADEON_PALETTE_DATA + 3:
+        break;
+    case RADEON_CONFIG_CNTL:
+        s->regs.config_cntl = data;
+        break;
+
+    case RADEON_CUR_OFFSET:
+
+            s->regs.cur_offset = data;
+        break;
+
+    case RADEON_DEFAULT_OFFSET:
+
+            s->regs.default_offset = data;
+
+        break;
+    case RADEON_DEFAULT_PITCH:
+        s->regs.default_pitch = data;
+
+
+        break;
+    case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
+        s->regs.default_sc_bottom_right = data;
+        break;
+    case R300_GB_ENABLE:
+        s->regs.r300_gb_enable = data;
+        break;
+    case R300_GB_TILE_CONFIG:
+            s->regs.r300_gb_tile_config = data;
+            break;
+    case R300_GB_FIFO_SIZE:
+            s->regs.r300_gb_fifo_size = data;
+            break;
+    case RADEON_ISYNC_CNTL:
+            s->regs.isync_cntl = data;
+            break;
+  case R300_DST_PIPE_CONFIG:
+            s->regs.r300_dst_pipe_config = data;
+            break;
+  case R300_RB2D_DSTCACHE_MODE:
+            s->regs.r300_rb2d_dstcache_mode = data;
+            break;
+  case RADEON_WAIT_UNTIL:
+            s->regs.wait_until = data;
+            break;
+  case R300_GB_SELECT:
+            s->regs.r300_gb_select = data;
+            break;
+  case R300_RB3D_DSTCACHE_CTLSTAT:
+            s->regs.r300_rb3d_dstcache_ctlstat = data;
+            break;
+  case R300_RB3D_ZCACHE_CTLSTAT:
+            s->regs.r300_rb3d_zcache_ctlstat = data;
+            break;
+  case R300_GB_AA_CONFIG:
+            s->regs.r300_gb_aa_config = data;
+            break;
+  case R300_RE_SCISSORS_TL:
+            s->regs.r300_re_scissors_tl = data;
+            break;
+
+  case R300_RE_SCISSORS_BR:
+            s->regs.r300_re_scissors_br = data;
+            break;
+  case RADEON_HOST_PATH_CNTL:
+            s->regs.host_path_cntl = data;
+            break;
+
+  case R300_GB_MSPOS0:
+            s->regs.r300_gb_mpos_0 = data;
+            break;
+
+  case R300_GB_MSPOS1:
+            s->regs.r300_gb_mpos_1 = data;
+            break;
+  case RADEON_SURFACE_CNTL:
+            s->regs.surface_cntl = data;
+            break;
+  case RADEON_SURFACE0_INFO:
+            s->regs.surface0_info = data;
+            break;
+  case RADEON_SURFACE1_INFO:
+            s->regs.surface1_info = data;
+            break;
+
+  case RADEON_SURFACE2_INFO:
+  s->regs.surface2_info = data;
+  break;
+  case RADEON_SURFACE3_INFO:
+  s->regs.surface3_info = data;
+  break;
+  case RADEON_SURFACE4_INFO:
+  s->regs.surface4_info = data;
+  break;
+  case RADEON_SURFACE5_INFO:
+  s->regs.surface5_info = data;
+  break;
+  case RADEON_SURFACE6_INFO:
+  s->regs.surface6_info = data;
+  break;
+  case RADEON_SURFACE7_INFO:
+  s->regs.surface7_info = data;
+  break;
+  case RADEON_OV0_SCALE_CNTL:
+  s->regs.ov0_scale_cntl = data;
+  break;
+  case RADEON_SUBPIC_CNTL:
+  s->regs.subpic_cntl = data;
+  break;
+  case RADEON_VIPH_CONTROL:
+  s->regs.viph_control = data;
+  break;
+  case RADEON_I2C_CNTL_1:
+  s->regs.i2c_cntl_1 = data;
+  break;
+  case RADEON_DVI_I2C_CNTL_1:
+  s->regs.dvi_i2c_cntl_1 = data;
+  break;
+  case RADEON_CAP0_TRIG_CNTL:
+  s->regs.cap0_trig_cntl = data;
+  break;
+  case RADEON_CAP1_TRIG_CNTL:
+  s->regs.cap1_trig_cntl = data;
+  break;
+  case RADEON_CUR2_OFFSET:
+  s->regs.cur2_offset = data;
+  break;
+  case RADEON_CRTC2_GEN_CNTL:
+  s->regs.crtc2_gen_cntl = data;
+  break;
+  // case RADEON_MEM_INTF_CNTL:
+  // s->regs.mem_intf_cntl = data;
+  // break;
+  case RADEON_AGP_BASE_2:
+  s->regs.agp_base_2 = data;
+  break;
+  case RADEON_AGP_BASE:
+  s->regs.agp_base = data;
+  break;
+  case RADEON_MEM_ADDR_CONFIG:
+  s->regs.mem_addr_config = data;
+  break;
+  case RADEON_DISPLAY2_BASE_ADDR:
+  s->regs.display2_base_addr = data;
+  break;
+  case RADEON_SPLL_CNTL:
+  s->regs.spll_cntl = data;
+  break;
+  case RADEON_VCLK_ECP_CNTL:
+  s->regs.vclk_ecp_cntl = data;
+  break;
+  case RADEON_CP_RB_CNTL:
+  s->regs.cp_rb_cntl = data;
+  break;
+  case RADEON_MEM_CNTL:
+  s->regs.mem_cntl = data;
+  break;
+  case R300_CRTC_TILE_X0_Y0:
+  s->regs.tile_x0_y0 = data;
+
+  break;
+  case R300_MC_INIT_MISC_LAT_TIMER:
+  s->regs.r300_mc_init_misc_lat_timer = 0xDEADBEEF;
+  break;
+  case RADEON_AIC_CNTL:
+  s->regs.aic_cntl = data;
+  break;
+  case RADEON_DDA_CONFIG:
+  s->regs.dda_config = data;
+  break;
+  case RADEON_M_SPLL_REF_FB_DIV:
+  s->regs.m_spll_ref_fb_div = data;
+  break;
+  case RADEON_SCLK_CNTL:
+  s->regs.r100_sclk_cntl = data &
+				    ~(RADEON_SCLK_FORCE_DISP2 |
+				      RADEON_SCLK_FORCE_CP |
+				      RADEON_SCLK_FORCE_HDP |
+				      RADEON_SCLK_FORCE_DISP1 |
+				      RADEON_SCLK_FORCE_TOP |
+				      RADEON_SCLK_FORCE_E2 | R300_SCLK_FORCE_VAP
+				      | RADEON_SCLK_FORCE_IDCT |
+				      RADEON_SCLK_FORCE_VIP | R300_SCLK_FORCE_SR
+				      | R300_SCLK_FORCE_PX | R300_SCLK_FORCE_TX
+				      | R300_SCLK_FORCE_US |
+				      RADEON_SCLK_FORCE_TV_SCLK |
+				      R300_SCLK_FORCE_SU |
+				      RADEON_SCLK_FORCE_OV0);
+  break;
+  case RADEON_PCI_GART_PAGE:
+  qemu_log("WRITE GART \n");
+  s->regs.pci_gart_page = data;
+  qemu_log("REGISTER 0x%08lx CONTAINS 0x%08lx \n",addr,data);
+  break;
+  case RADEON_AIC_PT_BASE:
+  qemu_log("R100 GART ADDR 0x%08lx GART PTR 0x%08lx \n",addr,data);
+  s->regs.aic_pt_base = data;
+
+  break;
+  case RADEON_MC_AGP_LOCATION:
+  s->regs.mc_agp_location = data;
+  qemu_log("WRITE MC_AGP  ADDR 0x%08lx DATA 0x%08lx \n",addr,data);
+  break;
+  case RADEON_PCIE_INDEX:
+  s->regs.pcie_index = data;
+  break;
+  case RADEON_PCIE_DATA:
+  s->regs.pcie_data = data;
+  break;
+  case RADEON_AIC_LO_ADDR:
+  s->regs.aic_lo_addr=data;
+  break;
+  case RADEON_AIC_HI_ADDR:
+  s->regs.aic_hi_addr=data;
+  break;
+  case RADEON_FP_GEN_CNTL:
+  s->regs.fp_gen_cntl = data;
+  break;
+  case RADEON_CRC_CMDFIFO_DOUT:
+
+  break;
+  case RADEON_DEVICE_ID:
+  break;
+  //MONITOR STUFF
+  case RADEON_DAC_CNTL:
+  case RADEON_DAC_CNTL2:
+  case RADEON_DAC_MACRO_CNTL:
+  case RADEON_TV_DAC_CNTL:
+  case RADEON_DAC_CRC_SIG:
+  case RADEON_DAC_DATA:
+  case RADEON_DAC_MASK:
+  case RADEON_DAC_R_INDEX:
+  case RADEON_DAC_W_INDEX:
+  case RADEON_DAC_EXT_CNTL:
+  case RADEON_DISP_OUTPUT_CNTL:
+    if(data > 0)
+    qemu_log("DAC/DISPLAY ADDR %lx DATA %lx \n",addr,data);
+    vga_ioport_write(s,addr,data);
+  break;
+
+  case RADEON_GPIOPAD_MASK:
+  case RADEON_GPIOPAD_A:
+  case RADEON_GPIOPAD_EN:
+  case RADEON_GPIOPAD_Y:
+  case RADEON_MDGPIO_MASK:
+  case RADEON_MDGPIO_A:
+  case RADEON_MDGPIO_EN:
+  case RADEON_MDGPIO_Y:
+
+  break;
+
+
+
+
+
+
+
+
+
+
+
+    default:
+    qemu_log("REGISTER NOT IMPLEMENTED 0x%08lx \n",addr);
+    s->regs.emu_register_stub[addr % 1024] = data;
+    // qemu_log("REGISTER NOT IMPLEMENTED INDEX 0x%08lx \n",addr % 1024);
+    qemu_log("REGISTER NOT IMPLEMENTED DATA 0x%08lx \n",data);
+
+        break;
+    }
+
+}
+static void r300_gart_write(void *opaque, hwaddr addr, uint64_t data, unsigned int size){
+  qemu_log("GART_WRITE 0x%08lx \n",addr);
+}
+static uint64_t r300_gart_read(void *opaque, hwaddr addr, unsigned int size){
+  qemu_log("GART_READ 0x%08lx \n",addr);
+  return 0;
+}
+
+static const MemoryRegionOps r300_mm_ops = {
+    .read = r300_mm_read,
+    .write = r300_mm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+static const MemoryRegionOps r300_gart_ops = {
+  .read = r300_gart_read,
+  .write = r300_gart_write,
+  .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+
+
+static void r300_vga_realize(PCIDevice *dev, Error **errp)
+{
+    RADVGAState *s = RAD_VGA(dev);
+    VGACommonState *vga = &s->vga;
+
+    // s->regs.r300_mc_init_misc_lat_timer = 0xDEADBEEF;
+
+    if (s->model) {
+        s->regs.vga_reset = 0x02;
+        s->regs.rbbm_status = 64;
+        s->regs.r100_sclk_cntl =  ~(RADEON_SCLK_FORCE_DISP2 |
+      				      RADEON_SCLK_FORCE_CP |
+      				      RADEON_SCLK_FORCE_HDP |
+      				      RADEON_SCLK_FORCE_DISP1 |
+      				      RADEON_SCLK_FORCE_TOP |
+      				      RADEON_SCLK_FORCE_E2 | R300_SCLK_FORCE_VAP
+      				      | RADEON_SCLK_FORCE_IDCT |
+      				      RADEON_SCLK_FORCE_VIP | R300_SCLK_FORCE_SR
+      				      | R300_SCLK_FORCE_PX | R300_SCLK_FORCE_TX
+      				      | R300_SCLK_FORCE_US |
+      				      RADEON_SCLK_FORCE_TV_SCLK |
+      				      R300_SCLK_FORCE_SU |
+      				      RADEON_SCLK_FORCE_OV0);
+        int i;
+        for (i = 0; i < ARRAY_SIZE(r300_model_aliases); i++) {
+            if (!strcmp(s->model, r300_model_aliases[i].name)) {
+                s->dev_id = r300_model_aliases[i].dev_id;
+                break;
+            }
+        }
+        if (i >= ARRAY_SIZE(r300_model_aliases)) {
+            warn_report("Unknown ATI VGA model name, "
+                        "using default radeon9500");
+        }
+    }
+    if (s->dev_id != PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+        error_setg(errp, "Unknown ATI VGA device id, "
+                   "only 0x4e45 is supported");
+        return;
+    }
+    pci_set_word(dev->config + PCI_DEVICE_ID, s->dev_id);
+
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO &&
+        s->vga.vram_size_mb < 128) {
+        warn_report("Too small video memory for device id");
+        s->vga.vram_size_mb = 128;
+    }
+
+    /* init vga bits */
+    vga_common_init(vga, OBJECT(s));
+    vga_init(vga, OBJECT(s), pci_address_space(dev),
+             pci_address_space_io(dev), true);
+    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops, &s->vga);
+
+    /* mmio register space */
+    memory_region_init_io(&s->mm, OBJECT(s), &r300_mm_ops, s,"ati.mmregs", RADEON_MIN_MMIO_SIZE);
+    /* io space is alias to beginning of mmregs */
+    memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
+    /* GART address space */
+    // memory_region_init_iommu(&s->gart,sizeof(&s->gart),TYPE_AMD_IOMMU_MEMORY_REGION,OBJECT(s),"ati.gart",1 * GiB);
+    // address_space_init(&s->gart_as,MEMORY_REGION(&s->gart),"ati-dma");
+    memory_region_init_io(&s->gart,OBJECT(s),&r300_gart_ops,s,"ati.gart",RADEON_MIN_MMIO_SIZE);
+    // memory_region_init_alias(&s->gart,OBJECT(s),"ati.gart",&s->mm,RADEON_PCI_GART_PAGE,RADEON_MIN_MMIO_SIZE);
+
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
+    pci_register_bar(dev,3, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->gart);
+
+
+    timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, r300_vga_vblank_irq, s);
+}
+
+static void r300_vga_reset(DeviceState *dev)
+{
+    RADVGAState *s = RAD_VGA(dev);
+    s->regs.mc_status = R300_MC_IDLE;
+
+    timer_del(&s->vblank_timer);
+    r300_vga_update_irq(s);
+
+    /* reset vga */
+    vga_common_reset(&s->vga);
+    s->mode = VGA_MODE;
+}
+
+static void r300_vga_exit(PCIDevice *dev)
+{
+    RADVGAState *s = RAD_VGA(dev);
+
+    timer_del(&s->vblank_timer);
+    graphic_console_close(s->vga.con);
+}
+
+static Property r300_vga_properties[] = {
+    DEFINE_PROP_UINT32("vgamem_mb", RADVGAState, vga.vram_size_mb, 1024),
+    DEFINE_PROP_STRING("model", RADVGAState, model),
+    DEFINE_PROP_UINT16("x-device-id", RADVGAState, dev_id,
+                       PCI_DEVICE_ID_ATI_RADEON_9500_PRO),
+    DEFINE_PROP_BOOL("guest_hwcursor", RADVGAState, cursor_guest_mode, false),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void r300_vga_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    dc->reset = r300_vga_reset;
+    dc->props = r300_vga_properties;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+
+    k->class_id = PCI_CLASS_DISPLAY_VGA;
+    k->vendor_id = PCI_VENDOR_ID_ATI;
+    k->device_id = PCI_DEVICE_ID_ATI_RADEON_9500_PRO;
+    k->romfile = "vgabios-ati.bin";
+    k->realize = r300_vga_realize;
+    k->exit = r300_vga_exit;
+}
+
+static const TypeInfo r300_vga_info = {
+    .name = TYPE_RAD_VGA,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(RADVGAState),
+    .class_init = r300_vga_class_init,
+    .interfaces = (InterfaceInfo[]) {
+          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+          { },
+    },
+};
+
+static void r300_vga_register_types(void)
+{
+    type_register_static(&r300_vga_info);
+}
+
+type_init(r300_vga_register_types)
diff --git a/hw/display/r300.h b/hw/display/r300.h
new file mode 100644
index 0000000000..521e457d5d
--- /dev/null
+++ b/hw/display/r300.h
@@ -0,0 +1,269 @@
+/*
+ * QEMU R300 SVGA emulation
+ *
+ * Copyright (c) 2019 Aaron Zakhrov
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ */
+
+
+
+#ifndef R300_H
+#define R300_H
+
+#include "qemu/timer.h"
+#include "hw/pci/pci.h"
+#include "hw/i2c/bitbang_i2c.h"
+#include "vga_int.h"
+
+/*#define DEBUG_R300*/
+
+#ifdef DEBUG_R300
+#define DPRINTF(fmt, ...) printf("%s: " fmt, __func__, ## __VA_ARGS__)
+#else
+#define DPRINTF(fmt, ...) do {} while (0)
+#endif
+
+#define PCI_VENDOR_ID_ATI 0x1002
+/* Radeon 9500 PRO */
+#define PCI_DEVICE_ID_ATI_RADEON_9500_PRO 0x4e45
+/* Radeon 9500 PRO */
+#define PCI_DEVICE_ID_ATI_RADEON_9700 0x4e44
+
+#define RADEON_MIN_MMIO_SIZE 0x10000
+
+
+#define TYPE_RAD_VGA "rad-vga"
+#define RAD_VGA(obj) OBJECT_CHECK(RADVGAState, (obj), TYPE_RAD_VGA)
+
+typedef struct RADVGARegs{
+
+  uint32_t mm_index;
+  uint32_t bios_scratch[8];
+  uint32_t gen_int_cntl;
+  uint32_t gen_int_status;
+  uint32_t crtc_gen_cntl;
+  uint32_t crtc_ext_cntl;
+  uint32_t dac_cntl;
+  uint32_t gpio_vga_ddc;
+  uint32_t gpio_dvi_ddc;
+  uint32_t gpio_monid;
+  uint32_t config_cntl;
+  uint32_t crtc_h_total_disp;
+  uint32_t crtc_h_sync_strt_wid;
+  uint32_t crtc_v_total_disp;
+  uint32_t crtc_v_sync_strt_wid;
+  uint32_t crtc_offset;
+  uint32_t crtc_offset_cntl;
+  uint32_t crtc_pitch;
+  uint32_t cur_offset;
+  uint32_t cur_hv_pos;
+  uint32_t cur_hv_offs;
+  uint32_t cur_color0;
+  uint32_t cur_color1;
+  uint32_t dst_offset;
+  uint32_t dst_pitch;
+  uint32_t dst_tile;
+  uint32_t dst_width;
+  uint32_t dst_height;
+  uint32_t src_offset;
+  uint32_t src_pitch;
+  uint32_t src_tile;
+  uint32_t src_x;
+  uint32_t src_y;
+  uint32_t dst_x;
+  uint32_t dst_y;
+  uint32_t dp_gui_master_cntl;
+  uint32_t dp_brush_bkgd_clr;
+  uint32_t dp_brush_frgd_clr;
+  uint32_t dp_src_frgd_clr;
+  uint32_t dp_src_bkgd_clr;
+  uint32_t dp_cntl;
+  uint32_t dp_datatype;
+  uint32_t dp_mix;
+  uint32_t dp_write_mask;
+  uint32_t default_offset;
+  uint32_t default_pitch;
+  uint32_t default_tile;
+  uint32_t default_sc_bottom_right;
+  uint32_t mc_status;
+  uint32_t isync_cntl;
+  uint32_t host_path_cntl;
+  uint32_t wait_until;
+  uint32_t cp_csq_cntl;
+  uint32_t scratch_umask;
+  uint32_t r100_display_base_addr;
+  uint32_t r100_sclk_cntl;
+  uint32_t pcie_index;
+  uint32_t pcie_data;
+    uint32_t aic_lo_addr;
+      uint32_t aic_hi_addr;
+      uint32_t fp_gen_cntl;
+      uint32_t mm_data;
+
+
+
+  uint8_t vga_reset;
+  uint32_t tile_x0_y0;
+  uint32_t dda_config;
+  uint32_t aic_cntl;
+
+  uint32_t cp_rb_cntl;
+  uint32_t mem_cntl;
+
+
+  uint32_t surface_cntl;
+  uint32_t surface0_info;
+  uint32_t surface1_info;
+  uint32_t surface2_info;
+  uint32_t surface3_info;
+  uint32_t surface4_info;
+  uint32_t surface5_info;
+  uint32_t surface6_info;
+  uint32_t surface7_info;
+  uint32_t ov0_scale_cntl;
+  uint32_t i2c_cntl_1;
+  uint32_t dvi_i2c_cntl_1;
+  uint32_t subpic_cntl;
+  uint32_t viph_control;
+  uint32_t cap0_trig_cntl;
+  uint32_t cap1_trig_cntl;
+  uint32_t cur2_offset;
+
+  uint32_t crtc2_gen_cntl;
+
+  uint32_t mem_intf_cntl;
+  uint32_t agp_base_2;
+  uint32_t agp_base;
+
+  uint32_t mem_addr_config;
+  uint32_t display2_base_addr;
+  uint32_t spll_cntl;
+  uint32_t vclk_ecp_cntl;
+
+  uint32_t aic_pt_base;
+  uint32_t pci_gart_page;
+  uint32_t mc_agp_location;
+
+
+
+
+
+
+  //R300 DST registers
+
+  uint32_t r300_dst_pipe_config;
+
+  //R300 GB Registers
+  uint32_t r300_gb_enable;
+  uint32_t r300_gb_tile_config;
+  uint32_t r300_gb_fifo_size;
+  uint32_t r300_gb_select;
+  uint32_t r300_gb_aa_config;
+  uint32_t r300_gb_mpos_0;
+  uint32_t r300_gb_mpos_1;
+
+  // RE registers
+  uint32_t r300_re_scissors_tl;
+  uint32_t r300_re_scissors_br;
+
+  // RB2D registers
+uint32_t r300_rb2d_dstcache_mode;
+
+// RB3D Registers
+  uint32_t r300_rb3d_aaresolve_ctl;
+  uint32_t r300_rb3d_aaresolve_offset;
+  uint32_t r300_rb3d_aaresolve_pitch;
+  uint32_t r300_rb3d_ablend;
+  uint32_t r300_rb3d_blend_color;
+  uint32_t r300_rb3d_cblend;
+  uint32_t r300_rb3d_color_mask;
+  uint32_t r300_rb3d_color_pitch[4];
+  uint32_t r300_rb3d_color_offset[4];
+  uint32_t r300_rb3d_zcache_ctlstat;
+  uint32_t r300_rb3d_dstcache_ctlstat;
+
+  uint32_t rbbm_gui_cntl;
+  uint32_t rbbm_status;
+  uint32_t rbbm_soft_reset;
+
+  uint32_t emu_register_stub[1024];
+
+  //PLL CLK REGISTERS
+uint32_t m_spll_ref_fb_div;
+
+
+
+
+// MC registers
+  uint32_t r300_mc_init_gfx_lat_timer;
+  uint32_t r300_mc_init_misc_lat_timer;
+
+//SE registers
+  uint32_t r300_se_vport_xscale;
+  uint32_t r300_se_vport_xoffset;
+  uint32_t r300_se_vport_yscale;
+  uint32_t r300_se_vport_yoffset;
+  uint32_t r300_se_vport_zscale;
+  uint32_t r300_se_vport_zoffset;
+  uint32_t r300_se_vte_cntl;
+
+//VAP registers
+
+uint32_t r300_vap_cntl;
+uint32_t r300_vap_cntl_status;
+uint32_t r300_vap_output_vtx_fmt_0;
+uint32_t r300_vap_output_vtx_fmt_1;
+uint32_t r300_vap_input_cntl_0;
+uint32_t r300_vap_input_cntl_1;
+uint32_t r300_vap_input_route_0_0;
+uint32_t r300_vap_input_route_0_1;
+uint32_t r300_vap_input_route_0_2;
+uint32_t r300_vap_input_route_0_3;
+uint32_t r300_vap_input_route_0_4;
+uint32_t r300_vap_input_route_0_5;
+uint32_t r300_vap_input_route_0_6;
+uint32_t r300_vap_input_route_0_7;
+uint32_t r300_vap_input_route_1_0;
+uint32_t r300_vap_input_route_1_1;
+uint32_t r300_vap_input_route_1_2;
+uint32_t r300_vap_input_route_1_3;
+uint32_t r300_vap_input_route_1_4;
+uint32_t r300_vap_input_route_1_5;
+uint32_t r300_vap_input_route_1_6;
+uint32_t r300_vap_input_route_1_7;
+uint32_t r300_vap_pvs_upload_address;
+uint32_t r300_vap_pvs_upload_data;
+
+
+
+
+
+}RADVGARegs;
+typedef struct RADVGAState {
+    PCIDevice dev;
+    VGACommonState vga;
+    char *model;
+    uint16_t dev_id;
+    uint8_t mode;
+    bool cursor_guest_mode;
+    uint16_t cursor_size;
+    uint32_t cursor_offset;
+    QEMUCursor *cursor;
+    QEMUTimer vblank_timer;
+    bitbang_i2c_interface bbi2c;
+    MemoryRegion io;
+    MemoryRegion mm;
+    MemoryRegion gart;
+    AddressSpace gart_as;
+    RADVGARegs regs;
+} RADVGAState;
+
+const char *r300_reg_name(int num);
+
+void r300_2d_blt(RADVGAState *s);
+
+
+
+
+#endif
diff --git a/hw/display/r300_2d.c b/hw/display/r300_2d.c
new file mode 100644
index 0000000000..4309d69326
--- /dev/null
+++ b/hw/display/r300_2d.c
@@ -0,0 +1,190 @@
+/*
+ * QEMU ATI SVGA emulation
+ * 2D engine functions
+ *
+ * Copyright (c) 2019 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ */
+
+#include "qemu/osdep.h"
+#include "r300.h"
+#include "r300_reg.h"
+#include "radeon_reg.h"
+#include "qemu/log.h"
+#include "ui/pixel_ops.h"
+
+/*
+ * NOTE:
+ * This is 2D _acceleration_ and supposed to be fast. Therefore, don't try to
+ * reinvent the wheel (unlikely to get better with a naive implementation than
+ * existing libraries) and avoid (poorly) reimplementing gfx primitives.
+ * That is unnecessary and would become a performance problem. Instead, try to
+ * map to and reuse existing optimised facilities (e.g. pixman) wherever
+ * possible.
+ */
+
+static int r300_bpp_from_datatype(RADVGAState *s)
+{
+    switch (s->regs.dp_datatype & 0xf) {
+    case 2:
+        return 8;
+    case 3:
+    case 4:
+        return 16;
+    case 5:
+        return 24;
+    case 6:
+        return 32;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unknown dst datatype %d\n",
+                      s->regs.dp_datatype & 0xf);
+        return 0;
+    }
+}
+
+#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & RADEON_GMC_DST_PITCH_OFFSET_CNTL)
+
+void r300_2d_blt(RADVGAState *s)
+{
+    /* FIXME it is probably more complex than this and may need to be */
+    /* rewritten but for now as a start just to get some output: */
+    DisplaySurface *ds = qemu_console_surface(s->vga.con);
+    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
+            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
+            surface_bits_per_pixel(ds),
+            (s->regs.dp_mix & RADEON_GMC_ROP3_MASK) >> 16);
+    int dst_x = (s->regs.dp_cntl & RADEON_DST_X_LEFT_TO_RIGHT ?
+                 s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
+    int dst_y = (s->regs.dp_cntl & RADEON_DST_Y_TOP_TO_BOTTOM ?
+                 s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+    int bpp = r300_bpp_from_datatype(s);
+    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
+    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+                        s->regs.dst_offset : s->regs.default_offset);
+
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+        dst_bits += s->regs.crtc_offset & 0x07ffffff;
+        dst_stride *= bpp;
+    }
+    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
+    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) *
+        dst_stride >= end) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
+    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
+            s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
+            s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
+            s->regs.src_x, s->regs.src_y, s->regs.dst_x, s->regs.dst_y,
+            s->regs.dst_width, s->regs.dst_height,
+            (s->regs.dp_cntl & RADEON_DST_X_LEFT_TO_RIGHT ? '>' : '<'),
+            (s->regs.dp_cntl & RADEON_DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
+    switch (s->regs.dp_mix & RADEON_GMC_ROP3_MASK) {
+    case RADEON_ROP3_S:
+    {
+        int src_x = (s->regs.dp_cntl & RADEON_DST_X_LEFT_TO_RIGHT ?
+                     s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
+        int src_y = (s->regs.dp_cntl & RADEON_DST_Y_TOP_TO_BOTTOM ?
+                     s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
+        int src_stride = DEFAULT_CNTL ?
+                         s->regs.src_pitch : s->regs.default_pitch;
+        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+                            s->regs.src_offset : s->regs.default_offset);
+
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+            src_bits += s->regs.crtc_offset & 0x07ffffff;
+            src_stride *= bpp;
+        }
+        if (src_bits >= end || src_bits + src_x +
+            (src_y + s->regs.dst_height) * src_stride >= end) {
+            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+            return;
+        }
+
+        src_stride /= sizeof(uint32_t);
+        dst_stride /= sizeof(uint32_t);
+        DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
+                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
+                src_x, src_y, dst_x, dst_y,
+                s->regs.dst_width, s->regs.dst_height);
+        if (s->regs.dp_cntl & RADEON_DST_X_LEFT_TO_RIGHT &&
+            s->regs.dp_cntl & RADEON_DST_Y_TOP_TO_BOTTOM) {
+            pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
+                       src_stride, dst_stride, bpp, bpp,
+                       src_x, src_y, dst_x, dst_y,
+                       s->regs.dst_width, s->regs.dst_height);
+        } else {
+            /* FIXME: We only really need a temporary if src and dst overlap */
+            int llb = s->regs.dst_width * (bpp / 8);
+            int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
+            uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
+                                     s->regs.dst_height);
+            pixman_blt((uint32_t *)src_bits, tmp,
+                       src_stride, tmp_stride, bpp, bpp,
+                       src_x, src_y, 0, 0,
+                       s->regs.dst_width, s->regs.dst_height);
+            pixman_blt(tmp, (uint32_t *)dst_bits,
+                       tmp_stride, dst_stride, bpp, bpp,
+                       0, 0, dst_x, dst_y,
+                       s->regs.dst_width, s->regs.dst_height);
+            g_free(tmp);
+        }
+        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
+            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
+                                    s->regs.dst_offset +
+                                    dst_y * surface_stride(ds),
+                                    s->regs.dst_height * surface_stride(ds));
+        }
+        s->regs.dst_x += s->regs.dst_width;
+        s->regs.dst_y += s->regs.dst_height;
+        break;
+    }
+    case RADEON_ROP3_P:
+    case RADEON_ROP3_ZERO:
+    case RADEON_ROP3_ONE:
+    {
+        uint32_t filler = 0;
+
+        switch (s->regs.dp_mix & RADEON_GMC_ROP3_MASK) {
+        case RADEON_ROP3_P:
+            filler = s->regs.dp_brush_frgd_clr;
+            break;
+        case RADEON_ROP3_ZERO:
+            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[0],
+                     s->vga.palette[1], s->vga.palette[2]);
+            break;
+        case RADEON_ROP3_ONE:
+            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[3],
+                     s->vga.palette[4], s->vga.palette[5]);
+            break;
+        }
+
+        dst_stride /= sizeof(uint32_t);
+        DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
+                dst_bits, dst_stride, bpp,
+                s->regs.dst_x, s->regs.dst_y,
+                s->regs.dst_width, s->regs.dst_height,
+                filler);
+        pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
+                    s->regs.dst_x, s->regs.dst_y,
+                    s->regs.dst_width, s->regs.dst_height,
+                    filler);
+        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
+            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
+                                    s->regs.dst_offset +
+                                    dst_y * surface_stride(ds),
+                                    s->regs.dst_height * surface_stride(ds));
+        }
+        s->regs.dst_y += s->regs.dst_height;
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unimplemented r300_2d blt op %x\n",
+                      (s->regs.dp_mix & RADEON_GMC_ROP3_MASK) >> 16);
+    }
+}
diff --git a/hw/display/r300_debug.c b/hw/display/r300_debug.c
new file mode 100644
index 0000000000..4b8a23504d
--- /dev/null
+++ b/hw/display/r300_debug.c
@@ -0,0 +1,272 @@
+#include "qemu/osdep.h"
+#include "r300.h"
+
+#ifdef DEBUG_R300
+struct ati_regdesc {
+    const char *name;
+    int num;
+};
+
+static struct r300_regdesc r300_reg_names[] = {
+    {"MM_INDEX", 0x0000},
+    {"MM_DATA", 0x0004},
+    {"CLOCK_CNTL_INDEX", 0x0008},
+    {"CLOCK_CNTL_DATA", 0x000c},
+    {"BIOS_0_SCRATCH", 0x0010},
+    {"BUS_CNTL", 0x0030},
+    {"BUS_CNTL1", 0x0034},
+    {"GEN_INT_CNTL", 0x0040},
+    {"GEN_INT_STATUS", 0x0044},
+    {"CRTC_GEN_CNTL", 0x0050},
+    {"CRTC_EXT_CNTL", 0x0054},
+    {"DAC_CNTL", 0x0058},
+    {"GPIO_VGA_DDC", 0x0060},
+    {"GPIO_DVI_DDC", 0x0064},
+    {"GPIO_MONID", 0x0068},
+    {"I2C_CNTL_1", 0x0094},
+    {"AMCGPIO_MASK_MIR", 0x009c},
+    {"AMCGPIO_A_MIR", 0x00a0},
+    {"AMCGPIO_Y_MIR", 0x00a4},
+    {"AMCGPIO_EN_MIR", 0x00a8},
+    {"PALETTE_INDEX", 0x00b0},
+    {"PALETTE_DATA", 0x00b4},
+    {"CNFG_CNTL", 0x00e0},
+    {"GEN_RESET_CNTL", 0x00f0},
+    {"CNFG_MEMSIZE", 0x00f8},
+    {"CONFIG_APER_0_BASE", 0x0100},
+    {"CONFIG_APER_1_BASE", 0x0104},
+    {"CONFIG_APER_SIZE", 0x0108},
+    {"CONFIG_REG_1_BASE", 0x010c},
+    {"CONFIG_REG_APER_SIZE", 0x0110},
+    {"MEM_CNTL", 0x0140},
+    {"MC_FB_LOCATION", 0x0148},
+    {"MC_AGP_LOCATION", 0x014C},
+    {"MC_STATUS", 0x0150},
+    {"MEM_POWER_MISC", 0x015c},
+    {"AGP_BASE", 0x0170},
+    {"AGP_CNTL", 0x0174},
+    {"AGP_APER_OFFSET", 0x0178},
+    {"PCI_GART_PAGE", 0x017c},
+    {"PC_NGUI_MODE", 0x0180},
+    {"PC_NGUI_CTLSTAT", 0x0184},
+    {"MPP_TB_CONFIG", 0x01C0},
+    {"MPP_GP_CONFIG", 0x01C8},
+    {"VIPH_CONTROL", 0x01D0},
+    {"CRTC_H_TOTAL_DISP", 0x0200},
+    {"CRTC_H_SYNC_STRT_WID", 0x0204},
+    {"CRTC_V_TOTAL_DISP", 0x0208},
+    {"CRTC_V_SYNC_STRT_WID", 0x020c},
+    {"CRTC_VLINE_CRNT_VLINE", 0x0210},
+    {"CRTC_CRNT_FRAME", 0x0214},
+    {"CRTC_GUI_TRIG_VLINE", 0x0218},
+    {"CRTC_OFFSET", 0x0224},
+    {"CRTC_OFFSET_CNTL", 0x0228},
+    {"CRTC_PITCH", 0x022c},
+    {"OVR_CLR", 0x0230},
+    {"OVR_WID_LEFT_RIGHT", 0x0234},
+    {"OVR_WID_TOP_BOTTOM", 0x0238},
+    {"CUR_OFFSET", 0x0260},
+    {"CUR_HORZ_VERT_POSN", 0x0264},
+    {"CUR_HORZ_VERT_OFF", 0x0268},
+    {"CUR_CLR0", 0x026c},
+    {"CUR_CLR1", 0x0270},
+    {"LVDS_GEN_CNTL", 0x02d0},
+    {"DDA_CONFIG", 0x02e0},
+    {"DDA_ON_OFF", 0x02e4},
+    {"VGA_DDA_CONFIG", 0x02e8},
+    {"VGA_DDA_ON_OFF", 0x02ec},
+    {"CRTC2_H_TOTAL_DISP", 0x0300},
+    {"CRTC2_H_SYNC_STRT_WID", 0x0304},
+    {"CRTC2_V_TOTAL_DISP", 0x0308},
+    {"CRTC2_V_SYNC_STRT_WID", 0x030c},
+    {"CRTC2_VLINE_CRNT_VLINE", 0x0310},
+    {"CRTC2_CRNT_FRAME", 0x0314},
+    {"CRTC2_GUI_TRIG_VLINE", 0x0318},
+    {"CRTC2_OFFSET", 0x0324},
+    {"CRTC2_OFFSET_CNTL", 0x0328},
+    {"CRTC2_PITCH", 0x032c},
+    {"DDA2_CONFIG", 0x03e0},
+    {"DDA2_ON_OFF", 0x03e4},
+    {"CRTC2_GEN_CNTL", 0x03f8},
+    {"CRTC2_STATUS", 0x03fc},
+    {"OV0_SCALE_CNTL", 0x0420},
+    {"SUBPIC_CNTL", 0x0540},
+    {"PM4_BUFFER_OFFSET", 0x0700},
+    {"PM4_BUFFER_CNTL", 0x0704},
+    {"PM4_BUFFER_WM_CNTL", 0x0708},
+    {"PM4_BUFFER_DL_RPTR_ADDR", 0x070c},
+    {"PM4_BUFFER_DL_RPTR", 0x0710},
+    {"PM4_BUFFER_DL_WPTR", 0x0714},
+    {"PM4_VC_FPU_SETUP", 0x071c},
+    {"PM4_FPU_CNTL", 0x0720},
+    {"PM4_VC_FORMAT", 0x0724},
+    {"PM4_VC_CNTL", 0x0728},
+    {"PM4_VC_I01", 0x072c},
+    {"PM4_VC_VLOFF", 0x0730},
+    {"PM4_VC_VLSIZE", 0x0734},
+    {"PM4_IW_INDOFF", 0x0738},
+    {"PM4_IW_INDSIZE", 0x073c},
+    {"PM4_FPU_FPX0", 0x0740},
+    {"PM4_FPU_FPY0", 0x0744},
+    {"PM4_FPU_FPX1", 0x0748},
+    {"PM4_FPU_FPY1", 0x074c},
+    {"PM4_FPU_FPX2", 0x0750},
+    {"PM4_FPU_FPY2", 0x0754},
+    {"PM4_FPU_FPY3", 0x0758},
+    {"PM4_FPU_FPY4", 0x075c},
+    {"PM4_FPU_FPY5", 0x0760},
+    {"PM4_FPU_FPY6", 0x0764},
+    {"PM4_FPU_FPR", 0x0768},
+    {"PM4_FPU_FPG", 0x076c},
+    {"PM4_FPU_FPB", 0x0770},
+    {"PM4_FPU_FPA", 0x0774},
+    {"PM4_FPU_INTXY0", 0x0780},
+    {"PM4_FPU_INTXY1", 0x0784},
+    {"PM4_FPU_INTXY2", 0x0788},
+    {"PM4_FPU_INTARGB", 0x078c},
+    {"PM4_FPU_FPTWICEAREA", 0x0790},
+    {"PM4_FPU_DMAJOR01", 0x0794},
+    {"PM4_FPU_DMAJOR12", 0x0798},
+    {"PM4_FPU_DMAJOR02", 0x079c},
+    {"PM4_FPU_STAT", 0x07a0},
+    {"PM4_STAT", 0x07b8},
+    {"PM4_TEST_CNTL", 0x07d0},
+    {"PM4_MICROCODE_ADDR", 0x07d4},
+    {"PM4_MICROCODE_RADDR", 0x07d8},
+    {"PM4_MICROCODE_DATAH", 0x07dc},
+    {"PM4_MICROCODE_DATAL", 0x07e0},
+    {"PM4_CMDFIFO_ADDR", 0x07e4},
+    {"PM4_CMDFIFO_DATAH", 0x07e8},
+    {"PM4_CMDFIFO_DATAL", 0x07ec},
+    {"PM4_BUFFER_ADDR", 0x07f0},
+    {"PM4_BUFFER_DATAH", 0x07f4},
+    {"PM4_BUFFER_DATAL", 0x07f8},
+    {"PM4_MICRO_CNTL", 0x07fc},
+    {"CAP0_TRIG_CNTL", 0x0950},
+    {"CAP1_TRIG_CNTL", 0x09c0},
+    {"RBBM_STATUS", 0x0e40},
+    {"PM4_FIFO_DATA_EVEN", 0x1000},
+    {"PM4_FIFO_DATA_ODD", 0x1004},
+    {"DST_OFFSET", 0x1404},
+    {"DST_PITCH", 0x1408},
+    {"DST_WIDTH", 0x140c},
+    {"DST_HEIGHT", 0x1410},
+    {"SRC_X", 0x1414},
+    {"SRC_Y", 0x1418},
+    {"DST_X", 0x141c},
+    {"DST_Y", 0x1420},
+    {"SRC_PITCH_OFFSET", 0x1428},
+    {"DST_PITCH_OFFSET", 0x142c},
+    {"SRC_Y_X", 0x1434},
+    {"DST_Y_X", 0x1438},
+    {"DST_HEIGHT_WIDTH", 0x143c},
+    {"DP_GUI_MASTER_CNTL", 0x146c},
+    {"BRUSH_SCALE", 0x1470},
+    {"BRUSH_Y_X", 0x1474},
+    {"DP_BRUSH_BKGD_CLR", 0x1478},
+    {"DP_BRUSH_FRGD_CLR", 0x147c},
+    {"DST_WIDTH_X", 0x1588},
+    {"DST_HEIGHT_WIDTH_8", 0x158c},
+    {"SRC_X_Y", 0x1590},
+    {"DST_X_Y", 0x1594},
+    {"DST_WIDTH_HEIGHT", 0x1598},
+    {"DST_WIDTH_X_INCY", 0x159c},
+    {"DST_HEIGHT_Y", 0x15a0},
+    {"DST_X_SUB", 0x15a4},
+    {"DST_Y_SUB", 0x15a8},
+    {"SRC_OFFSET", 0x15ac},
+    {"SRC_PITCH", 0x15b0},
+    {"DST_HEIGHT_WIDTH_BW", 0x15b4},
+    {"CLR_CMP_CNTL", 0x15c0},
+    {"CLR_CMP_CLR_SRC", 0x15c4},
+    {"CLR_CMP_CLR_DST", 0x15c8},
+    {"CLR_CMP_MASK", 0x15cc},
+    {"DP_SRC_FRGD_CLR", 0x15d8},
+    {"DP_SRC_BKGD_CLR", 0x15dc},
+    {"DST_BRES_ERR", 0x1628},
+    {"DST_BRES_INC", 0x162c},
+    {"DST_BRES_DEC", 0x1630},
+    {"DST_BRES_LNTH", 0x1634},
+    {"DST_BRES_LNTH_SUB", 0x1638},
+    {"SC_LEFT", 0x1640},
+    {"SC_RIGHT", 0x1644},
+    {"SC_TOP", 0x1648},
+    {"SC_BOTTOM", 0x164c},
+    {"SRC_SC_RIGHT", 0x1654},
+    {"SRC_SC_BOTTOM", 0x165c},
+    {"GUI_DEBUG0", 0x16a0},
+    {"GUI_DEBUG1", 0x16a4},
+    {"GUI_TIMEOUT", 0x16b0},
+    {"GUI_TIMEOUT0", 0x16b4},
+    {"GUI_TIMEOUT1", 0x16b8},
+    {"GUI_PROBE", 0x16bc},
+    {"DP_CNTL", 0x16c0},
+    {"DP_DATATYPE", 0x16c4},
+    {"DP_MIX", 0x16c8},
+    {"DP_WRITE_MASK", 0x16cc},
+    {"DP_CNTL_XDIR_YDIR_YMAJOR", 0x16d0},
+    {"DEFAULT_OFFSET", 0x16e0},
+    {"DEFAULT_PITCH", 0x16e4},
+    {"DEFAULT_SC_BOTTOM_RIGHT", 0x16e8},
+    {"SC_TOP_LEFT", 0x16ec},
+    {"SC_BOTTOM_RIGHT", 0x16f0},
+    {"SRC_SC_BOTTOM_RIGHT", 0x16f4},
+    {"DST_TILE", 0x1700},
+    {"WAIT_UNTIL", 0x1720},
+    {"CACHE_CNTL", 0x1724},
+    {"GUI_STAT", 0x1740},
+    {"PC_GUI_MODE", 0x1744},
+    {"PC_GUI_CTLSTAT", 0x1748},
+    {"PC_DEBUG_MODE", 0x1760},
+    {"BRES_DST_ERR_DEC", 0x1780},
+    {"TRAIL_BRES_T12_ERR_DEC", 0x1784},
+    {"TRAIL_BRES_T12_INC", 0x1788},
+    {"DP_T12_CNTL", 0x178c},
+    {"DST_BRES_T1_LNTH", 0x1790},
+    {"DST_BRES_T2_LNTH", 0x1794},
+    {"SCALE_SRC_HEIGHT_WIDTH", 0x1994},
+    {"SCALE_OFFSET_0", 0x1998},
+    {"SCALE_PITCH", 0x199c},
+    {"SCALE_X_INC", 0x19a0},
+    {"SCALE_Y_INC", 0x19a4},
+    {"SCALE_HACC", 0x19a8},
+    {"SCALE_VACC", 0x19ac},
+    {"SCALE_DST_X_Y", 0x19b0},
+    {"SCALE_DST_HEIGHT_WIDTH", 0x19b4},
+    {"SCALE_3D_CNTL", 0x1a00},
+    {"SCALE_3D_DATATYPE", 0x1a20},
+    {"SETUP_CNTL", 0x1bc4},
+    {"SOLID_COLOR", 0x1bc8},
+    {"WINDOW_XY_OFFSET", 0x1bcc},
+    {"DRAW_LINE_POINT", 0x1bd0},
+    {"SETUP_CNTL_PM4", 0x1bd4},
+    {"DST_PITCH_OFFSET_C", 0x1c80},
+    {"DP_GUI_MASTER_CNTL_C", 0x1c84},
+    {"SC_TOP_LEFT_C", 0x1c88},
+    {"SC_BOTTOM_RIGHT_C", 0x1c8c},
+    {"CLR_CMP_MASK_3D", 0x1A28},
+    {"MISC_3D_STATE_CNTL_REG", 0x1CA0},
+    {"MC_SRC1_CNTL", 0x19D8},
+    {"TEX_CNTL", 0x1800},
+    {"RAGE128_MPP_TB_CONFIG", 0x01c0},
+    {NULL, -1}
+};
+
+const char *r300_reg_name(int num)
+{
+    int i;
+
+    num &= ~3;
+    for (i = 0; ati_reg_names[i].name; i++) {
+        if (ati_reg_names[i].num == num) {
+            return ati_reg_names[i].name;
+        }
+    }
+    return "unknown";
+}
+#else
+const char *r300_reg_name(int num)
+{
+    return "";
+}
+#endif
diff --git a/hw/display/r300_reg.h b/hw/display/r300_reg.h
new file mode 100644
index 0000000000..00c0d2ba22
--- /dev/null
+++ b/hw/display/r300_reg.h
@@ -0,0 +1,1789 @@
+/*
+ * Copyright 2005 Nicolai Haehnle et al.
+ * Copyright 2008 Advanced Micro Devices, Inc.
+ * Copyright 2009 Jerome Glisse.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Nicolai Haehnle
+ *          Jerome Glisse
+ */
+#ifndef _R300_REG_H_
+#define _R300_REG_H_
+
+#define R300_SURF_TILE_MACRO (1<<16)
+#define R300_SURF_TILE_MICRO (2<<16)
+#define R300_SURF_TILE_BOTH (3<<16)
+
+
+#define R300_MC_INIT_MISC_LAT_TIMER	0x180
+#	define R300_MC_MISC__MC_CPR_INIT_LAT_SHIFT	0
+#	define R300_MC_MISC__MC_VF_INIT_LAT_SHIFT	4
+#	define R300_MC_MISC__MC_DISP0R_INIT_LAT_SHIFT	8
+#	define R300_MC_MISC__MC_DISP1R_INIT_LAT_SHIFT	12
+#	define R300_MC_MISC__MC_FIXED_INIT_LAT_SHIFT	16
+#	define R300_MC_MISC__MC_E2R_INIT_LAT_SHIFT	20
+#	define R300_MC_MISC__MC_SAME_PAGE_PRIO_SHIFT	24
+#	define R300_MC_MISC__MC_GLOBW_INIT_LAT_SHIFT	28
+
+#define R300_MC_INIT_GFX_LAT_TIMER	0x154
+#	define R300_MC_MISC__MC_G3D0R_INIT_LAT_SHIFT	0
+#	define R300_MC_MISC__MC_G3D1R_INIT_LAT_SHIFT	4
+#	define R300_MC_MISC__MC_G3D2R_INIT_LAT_SHIFT	8
+#	define R300_MC_MISC__MC_G3D3R_INIT_LAT_SHIFT	12
+#	define R300_MC_MISC__MC_TX0R_INIT_LAT_SHIFT	16
+#	define R300_MC_MISC__MC_TX1R_INIT_LAT_SHIFT	20
+#	define R300_MC_MISC__MC_GLOBR_INIT_LAT_SHIFT	24
+#	define R300_MC_MISC__MC_GLOBW_FULL_LAT_SHIFT	28
+
+/*
+ * This file contains registers and constants for the R300. They have been
+ * found mostly by examining command buffers captured using glxtest, as well
+ * as by extrapolating some known registers and constants from the R200.
+ * I am fairly certain that they are correct unless stated otherwise
+ * in comments.
+ */
+
+#define R300_SE_VPORT_XSCALE                0x1D98
+#define R300_SE_VPORT_XOFFSET               0x1D9C
+#define R300_SE_VPORT_YSCALE                0x1DA0
+#define R300_SE_VPORT_YOFFSET               0x1DA4
+#define R300_SE_VPORT_ZSCALE                0x1DA8
+#define R300_SE_VPORT_ZOFFSET               0x1DAC
+
+
+/*
+ * Vertex Array Processing (VAP) Control
+ * Stolen from r200 code from Christoph Brill (It's a guess!)
+ */
+#define R300_VAP_CNTL	0x2080
+
+/* This register is written directly and also starts data section
+ * in many 3d CP_PACKET3's
+ */
+#define R300_VAP_VF_CNTL	0x2084
+#	define	R300_VAP_VF_CNTL__PRIM_TYPE__SHIFT              0
+#	define  R300_VAP_VF_CNTL__PRIM_NONE                     (0<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_POINTS                   (1<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_LINES                    (2<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_LINE_STRIP               (3<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_TRIANGLES                (4<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_TRIANGLE_FAN             (5<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_TRIANGLE_STRIP           (6<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_LINE_LOOP                (12<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_QUADS                    (13<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_QUAD_STRIP               (14<<0)
+#	define  R300_VAP_VF_CNTL__PRIM_POLYGON                  (15<<0)
+
+#	define	R300_VAP_VF_CNTL__PRIM_WALK__SHIFT              4
+	/* State based - direct writes to registers trigger vertex
+           generation */
+#	define	R300_VAP_VF_CNTL__PRIM_WALK_STATE_BASED         (0<<4)
+#	define	R300_VAP_VF_CNTL__PRIM_WALK_INDICES             (1<<4)
+#	define	R300_VAP_VF_CNTL__PRIM_WALK_VERTEX_LIST         (2<<4)
+#	define	R300_VAP_VF_CNTL__PRIM_WALK_VERTEX_EMBEDDED     (3<<4)
+
+	/* I don't think I saw these three used.. */
+#	define	R300_VAP_VF_CNTL__COLOR_ORDER__SHIFT            6
+#	define	R300_VAP_VF_CNTL__TCL_OUTPUT_CTL_ENA__SHIFT     9
+#	define	R300_VAP_VF_CNTL__PROG_STREAM_ENA__SHIFT        10
+
+	/* index size - when not set the indices are assumed to be 16 bit */
+#	define	R300_VAP_VF_CNTL__INDEX_SIZE_32bit              (1<<11)
+	/* number of vertices */
+#	define	R300_VAP_VF_CNTL__NUM_VERTICES__SHIFT           16
+
+/* BEGIN: Wild guesses */
+#define R300_VAP_OUTPUT_VTX_FMT_0           0x2090
+#       define R300_VAP_OUTPUT_VTX_FMT_0__POS_PRESENT     (1<<0)
+#       define R300_VAP_OUTPUT_VTX_FMT_0__COLOR_PRESENT   (1<<1)
+#       define R300_VAP_OUTPUT_VTX_FMT_0__COLOR_1_PRESENT (1<<2)  /* GUESS */
+#       define R300_VAP_OUTPUT_VTX_FMT_0__COLOR_2_PRESENT (1<<3)  /* GUESS */
+#       define R300_VAP_OUTPUT_VTX_FMT_0__COLOR_3_PRESENT (1<<4)  /* GUESS */
+#       define R300_VAP_OUTPUT_VTX_FMT_0__PT_SIZE_PRESENT (1<<16) /* GUESS */
+
+#define R300_VAP_OUTPUT_VTX_FMT_1           0x2094
+	/* each of the following is 3 bits wide, specifies number
+	   of components */
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_0_COMP_CNT_SHIFT 0
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_1_COMP_CNT_SHIFT 3
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_2_COMP_CNT_SHIFT 6
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_3_COMP_CNT_SHIFT 9
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_4_COMP_CNT_SHIFT 12
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_5_COMP_CNT_SHIFT 15
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_6_COMP_CNT_SHIFT 18
+#       define R300_VAP_OUTPUT_VTX_FMT_1__TEX_7_COMP_CNT_SHIFT 21
+/* END: Wild guesses */
+
+#define R300_SE_VTE_CNTL                  0x20b0
+#	define     R300_VPORT_X_SCALE_ENA                0x00000001
+#	define     R300_VPORT_X_OFFSET_ENA               0x00000002
+#	define     R300_VPORT_Y_SCALE_ENA                0x00000004
+#	define     R300_VPORT_Y_OFFSET_ENA               0x00000008
+#	define     R300_VPORT_Z_SCALE_ENA                0x00000010
+#	define     R300_VPORT_Z_OFFSET_ENA               0x00000020
+#	define     R300_VTX_XY_FMT                       0x00000100
+#	define     R300_VTX_Z_FMT                        0x00000200
+#	define     R300_VTX_W0_FMT                       0x00000400
+#	define     R300_VTX_W0_NORMALIZE                 0x00000800
+#	define     R300_VTX_ST_DENORMALIZED              0x00001000
+
+/* BEGIN: Vertex data assembly - lots of uncertainties */
+
+/* gap */
+
+#define R300_VAP_CNTL_STATUS              0x2140
+#	define R300_VC_NO_SWAP                  (0 << 0)
+#	define R300_VC_16BIT_SWAP               (1 << 0)
+#	define R300_VC_32BIT_SWAP               (2 << 0)
+#	define R300_VAP_TCL_BYPASS		(1 << 8)
+
+/* gap */
+
+/* Where do we get our vertex data?
+ *
+ * Vertex data either comes either from immediate mode registers or from
+ * vertex arrays.
+ * There appears to be no mixed mode (though we can force the pitch of
+ * vertex arrays to 0, effectively reusing the same element over and over
+ * again).
+ *
+ * Immediate mode is controlled by the INPUT_CNTL registers. I am not sure
+ * if these registers influence vertex array processing.
+ *
+ * Vertex arrays are controlled via the 3D_LOAD_VBPNTR packet3.
+ *
+ * In both cases, vertex attributes are then passed through INPUT_ROUTE.
+ *
+ * Beginning with INPUT_ROUTE_0_0 is a list of WORDs that route vertex data
+ * into the vertex processor's input registers.
+ * The first word routes the first input, the second word the second, etc.
+ * The corresponding input is routed into the register with the given index.
+ * The list is ended by a word with INPUT_ROUTE_END set.
+ *
+ * Always set COMPONENTS_4 in immediate mode.
+ */
+
+#define R300_VAP_INPUT_ROUTE_0_0            0x2150
+#       define R300_INPUT_ROUTE_COMPONENTS_1     (0 << 0)
+#       define R300_INPUT_ROUTE_COMPONENTS_2     (1 << 0)
+#       define R300_INPUT_ROUTE_COMPONENTS_3     (2 << 0)
+#       define R300_INPUT_ROUTE_COMPONENTS_4     (3 << 0)
+#       define R300_INPUT_ROUTE_COMPONENTS_RGBA  (4 << 0) /* GUESS */
+#       define R300_VAP_INPUT_ROUTE_IDX_SHIFT    8
+#       define R300_VAP_INPUT_ROUTE_IDX_MASK     (31 << 8) /* GUESS */
+#       define R300_VAP_INPUT_ROUTE_END          (1 << 13)
+#       define R300_INPUT_ROUTE_IMMEDIATE_MODE   (0 << 14) /* GUESS */
+#       define R300_INPUT_ROUTE_FLOAT            (1 << 14) /* GUESS */
+#       define R300_INPUT_ROUTE_UNSIGNED_BYTE    (2 << 14) /* GUESS */
+#       define R300_INPUT_ROUTE_FLOAT_COLOR      (3 << 14) /* GUESS */
+#define R300_VAP_INPUT_ROUTE_0_1            0x2154
+#define R300_VAP_INPUT_ROUTE_0_2            0x2158
+#define R300_VAP_INPUT_ROUTE_0_3            0x215C
+#define R300_VAP_INPUT_ROUTE_0_4            0x2160
+#define R300_VAP_INPUT_ROUTE_0_5            0x2164
+#define R300_VAP_INPUT_ROUTE_0_6            0x2168
+#define R300_VAP_INPUT_ROUTE_0_7            0x216C
+
+/* gap */
+
+/* Notes:
+ *  - always set up to produce at least two attributes:
+ *    if vertex program uses only position, fglrx will set normal, too
+ *  - INPUT_CNTL_0_COLOR and INPUT_CNTL_COLOR bits are always equal.
+ */
+#define R300_VAP_INPUT_CNTL_0               0x2180
+#       define R300_INPUT_CNTL_0_COLOR           0x00000001
+#define R300_VAP_INPUT_CNTL_1               0x2184
+#       define R300_INPUT_CNTL_POS               0x00000001
+#       define R300_INPUT_CNTL_NORMAL            0x00000002
+#       define R300_INPUT_CNTL_COLOR             0x00000004
+#       define R300_INPUT_CNTL_TC0               0x00000400
+#       define R300_INPUT_CNTL_TC1               0x00000800
+#       define R300_INPUT_CNTL_TC2               0x00001000 /* GUESS */
+#       define R300_INPUT_CNTL_TC3               0x00002000 /* GUESS */
+#       define R300_INPUT_CNTL_TC4               0x00004000 /* GUESS */
+#       define R300_INPUT_CNTL_TC5               0x00008000 /* GUESS */
+#       define R300_INPUT_CNTL_TC6               0x00010000 /* GUESS */
+#       define R300_INPUT_CNTL_TC7               0x00020000 /* GUESS */
+
+/* gap */
+
+/* Words parallel to INPUT_ROUTE_0; All words that are active in INPUT_ROUTE_0
+ * are set to a swizzling bit pattern, other words are 0.
+ *
+ * In immediate mode, the pattern is always set to xyzw. In vertex array
+ * mode, the swizzling pattern is e.g. used to set zw components in texture
+ * coordinates with only tweo components.
+ */
+#define R300_VAP_INPUT_ROUTE_1_0            0x21E0
+#       define R300_INPUT_ROUTE_SELECT_X    0
+#       define R300_INPUT_ROUTE_SELECT_Y    1
+#       define R300_INPUT_ROUTE_SELECT_Z    2
+#       define R300_INPUT_ROUTE_SELECT_W    3
+#       define R300_INPUT_ROUTE_SELECT_ZERO 4
+#       define R300_INPUT_ROUTE_SELECT_ONE  5
+#       define R300_INPUT_ROUTE_SELECT_MASK 7
+#       define R300_INPUT_ROUTE_X_SHIFT     0
+#       define R300_INPUT_ROUTE_Y_SHIFT     3
+#       define R300_INPUT_ROUTE_Z_SHIFT     6
+#       define R300_INPUT_ROUTE_W_SHIFT     9
+#       define R300_INPUT_ROUTE_ENABLE      (15 << 12)
+#define R300_VAP_INPUT_ROUTE_1_1            0x21E4
+#define R300_VAP_INPUT_ROUTE_1_2            0x21E8
+#define R300_VAP_INPUT_ROUTE_1_3            0x21EC
+#define R300_VAP_INPUT_ROUTE_1_4            0x21F0
+#define R300_VAP_INPUT_ROUTE_1_5            0x21F4
+#define R300_VAP_INPUT_ROUTE_1_6            0x21F8
+#define R300_VAP_INPUT_ROUTE_1_7            0x21FC
+
+/* END: Vertex data assembly */
+
+/* gap */
+
+/* BEGIN: Upload vertex program and data */
+
+/*
+ * The programmable vertex shader unit has a memory bank of unknown size
+ * that can be written to in 16 byte units by writing the address into
+ * UPLOAD_ADDRESS, followed by data in UPLOAD_DATA (multiples of 4 DWORDs).
+ *
+ * Pointers into the memory bank are always in multiples of 16 bytes.
+ *
+ * The memory bank is divided into areas with fixed meaning.
+ *
+ * Starting at address UPLOAD_PROGRAM: Vertex program instructions.
+ * Native limits reported by drivers from ATI suggest size 256 (i.e. 4KB),
+ * whereas the difference between known addresses suggests size 512.
+ *
+ * Starting at address UPLOAD_PARAMETERS: Vertex program parameters.
+ * Native reported limits and the VPI layout suggest size 256, whereas
+ * difference between known addresses suggests size 512.
+ *
+ * At address UPLOAD_POINTSIZE is a vector (0, 0, ps, 0), where ps is the
+ * floating point pointsize. The exact purpose of this state is uncertain,
+ * as there is also the R300_RE_POINTSIZE register.
+ *
+ * Multiple vertex programs and parameter sets can be loaded at once,
+ * which could explain the size discrepancy.
+ */
+#define R300_VAP_PVS_UPLOAD_ADDRESS         0x2200
+#       define R300_PVS_UPLOAD_PROGRAM           0x00000000
+#       define R300_PVS_UPLOAD_PARAMETERS        0x00000200
+#       define R300_PVS_UPLOAD_POINTSIZE         0x00000406
+
+/* gap */
+
+#define R300_VAP_PVS_UPLOAD_DATA            0x2208
+
+/* END: Upload vertex program and data */
+
+/* gap */
+
+/* I do not know the purpose of this register. However, I do know that
+ * it is set to 221C_CLEAR for clear operations and to 221C_NORMAL
+ * for normal rendering.
+ */
+#define R300_VAP_UNKNOWN_221C               0x221C
+#       define R300_221C_NORMAL                  0x00000000
+#       define R300_221C_CLEAR                   0x0001C000
+
+/* These seem to be per-pixel and per-vertex X and Y clipping planes. The first
+ * plane is per-pixel and the second plane is per-vertex.
+ *
+ * This was determined by experimentation alone but I believe it is correct.
+ *
+ * These registers are called X_QUAD0_1_FL to X_QUAD0_4_FL by glxtest.
+ */
+#define R300_VAP_CLIP_X_0                   0x2220
+#define R300_VAP_CLIP_X_1                   0x2224
+#define R300_VAP_CLIP_Y_0                   0x2228
+#define R300_VAP_CLIP_Y_1                   0x2230
+
+/* gap */
+
+/* Sometimes, END_OF_PKT and 0x2284=0 are the only commands sent between
+ * rendering commands and overwriting vertex program parameters.
+ * Therefore, I suspect writing zero to 0x2284 synchronizes the engine and
+ * avoids bugs caused by still running shaders reading bad data from memory.
+ */
+#define R300_VAP_PVS_STATE_FLUSH_REG        0x2284
+
+/* Absolutely no clue what this register is about. */
+#define R300_VAP_UNKNOWN_2288               0x2288
+#       define R300_2288_R300                    0x00750000 /* -- nh */
+#       define R300_2288_RV350                   0x0000FFFF /* -- Vladimir */
+
+/* gap */
+
+/* Addresses are relative to the vertex program instruction area of the
+ * memory bank. PROGRAM_END points to the last instruction of the active
+ * program
+ *
+ * The meaning of the two UNKNOWN fields is obviously not known. However,
+ * experiments so far have shown that both *must* point to an instruction
+ * inside the vertex program, otherwise the GPU locks up.
+ *
+ * fglrx usually sets CNTL_3_UNKNOWN to the end of the program and
+ * R300_PVS_CNTL_1_POS_END_SHIFT points to instruction where last write to
+ * position takes place.
+ *
+ * Most likely this is used to ignore rest of the program in cases
+ * where group of verts arent visible. For some reason this "section"
+ * is sometimes accepted other instruction that have no relationship with
+ * position calculations.
+ */
+#define R300_VAP_PVS_CNTL_1                 0x22D0
+#       define R300_PVS_CNTL_1_PROGRAM_START_SHIFT   0
+#       define R300_PVS_CNTL_1_POS_END_SHIFT         10
+#       define R300_PVS_CNTL_1_PROGRAM_END_SHIFT     20
+/* Addresses are relative the the vertex program parameters area. */
+#define R300_VAP_PVS_CNTL_2                 0x22D4
+#       define R300_PVS_CNTL_2_PARAM_OFFSET_SHIFT 0
+#       define R300_PVS_CNTL_2_PARAM_COUNT_SHIFT  16
+#define R300_VAP_PVS_CNTL_3	           0x22D8
+#       define R300_PVS_CNTL_3_PROGRAM_UNKNOWN_SHIFT 10
+#       define R300_PVS_CNTL_3_PROGRAM_UNKNOWN2_SHIFT 0
+
+/* The entire range from 0x2300 to 0x2AC inclusive seems to be used for
+ * immediate vertices
+ */
+#define R300_VAP_VTX_COLOR_R                0x2464
+#define R300_VAP_VTX_COLOR_G                0x2468
+#define R300_VAP_VTX_COLOR_B                0x246C
+#define R300_VAP_VTX_POS_0_X_1              0x2490 /* used for glVertex2*() */
+#define R300_VAP_VTX_POS_0_Y_1              0x2494
+#define R300_VAP_VTX_COLOR_PKD              0x249C /* RGBA */
+#define R300_VAP_VTX_POS_0_X_2              0x24A0 /* used for glVertex3*() */
+#define R300_VAP_VTX_POS_0_Y_2              0x24A4
+#define R300_VAP_VTX_POS_0_Z_2              0x24A8
+/* write 0 to indicate end of packet? */
+#define R300_VAP_VTX_END_OF_PKT             0x24AC
+
+/* gap */
+
+/* These are values from r300_reg/r300_reg.h - they are known to be correct
+ * and are here so we can use one register file instead of several
+ * - Vladimir
+ */
+#define R300_GB_VAP_RASTER_VTX_FMT_0	0x4000
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__POS_PRESENT	(1<<0)
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__COLOR_0_PRESENT	(1<<1)
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__COLOR_1_PRESENT	(1<<2)
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__COLOR_2_PRESENT	(1<<3)
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__COLOR_3_PRESENT	(1<<4)
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__COLOR_SPACE	(0xf<<5)
+#	define R300_GB_VAP_RASTER_VTX_FMT_0__PT_SIZE_PRESENT	(0x1<<16)
+
+#define R300_GB_VAP_RASTER_VTX_FMT_1	0x4004
+	/* each of the following is 3 bits wide, specifies number
+	   of components */
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_0_COMP_CNT_SHIFT	0
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_1_COMP_CNT_SHIFT	3
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_2_COMP_CNT_SHIFT	6
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_3_COMP_CNT_SHIFT	9
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_4_COMP_CNT_SHIFT	12
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_5_COMP_CNT_SHIFT	15
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_6_COMP_CNT_SHIFT	18
+#	define R300_GB_VAP_RASTER_VTX_FMT_1__TEX_7_COMP_CNT_SHIFT	21
+
+/* UNK30 seems to enables point to quad transformation on textures
+ * (or something closely related to that).
+ * This bit is rather fatal at the time being due to lackings at pixel
+ * shader side
+ */
+#define R300_GB_ENABLE	0x4008
+#	define R300_GB_POINT_STUFF_ENABLE	(1<<0)
+#	define R300_GB_LINE_STUFF_ENABLE	(1<<1)
+#	define R300_GB_TRIANGLE_STUFF_ENABLE	(1<<2)
+#	define R300_GB_STENCIL_AUTO_ENABLE	(1<<4)
+#	define R300_GB_UNK31			(1<<31)
+	/* each of the following is 2 bits wide */
+#define R300_GB_TEX_REPLICATE	0
+#define R300_GB_TEX_ST		1
+#define R300_GB_TEX_STR		2
+#	define R300_GB_TEX0_SOURCE_SHIFT	16
+#	define R300_GB_TEX1_SOURCE_SHIFT	18
+#	define R300_GB_TEX2_SOURCE_SHIFT	20
+#	define R300_GB_TEX3_SOURCE_SHIFT	22
+#	define R300_GB_TEX4_SOURCE_SHIFT	24
+#	define R300_GB_TEX5_SOURCE_SHIFT	26
+#	define R300_GB_TEX6_SOURCE_SHIFT	28
+#	define R300_GB_TEX7_SOURCE_SHIFT	30
+
+/* MSPOS - positions for multisample antialiasing (?) */
+#define R300_GB_MSPOS0	0x4010
+	/* shifts - each of the fields is 4 bits */
+#	define R300_GB_MSPOS0__MS_X0_SHIFT	0
+#	define R300_GB_MSPOS0__MS_Y0_SHIFT	4
+#	define R300_GB_MSPOS0__MS_X1_SHIFT	8
+#	define R300_GB_MSPOS0__MS_Y1_SHIFT	12
+#	define R300_GB_MSPOS0__MS_X2_SHIFT	16
+#	define R300_GB_MSPOS0__MS_Y2_SHIFT	20
+#	define R300_GB_MSPOS0__MSBD0_Y		24
+#	define R300_GB_MSPOS0__MSBD0_X		28
+
+#define R300_GB_MSPOS1	0x4014
+#	define R300_GB_MSPOS1__MS_X3_SHIFT	0
+#	define R300_GB_MSPOS1__MS_Y3_SHIFT	4
+#	define R300_GB_MSPOS1__MS_X4_SHIFT	8
+#	define R300_GB_MSPOS1__MS_Y4_SHIFT	12
+#	define R300_GB_MSPOS1__MS_X5_SHIFT	16
+#	define R300_GB_MSPOS1__MS_Y5_SHIFT	20
+#	define R300_GB_MSPOS1__MSBD1		24
+
+
+#define R300_GB_TILE_CONFIG	0x4018
+#	define R300_GB_TILE_ENABLE	(1<<0)
+#	define R300_GB_TILE_PIPE_COUNT_RV300	0
+#	define R300_GB_TILE_PIPE_COUNT_R300	(3<<1)
+#	define R300_GB_TILE_PIPE_COUNT_R420	(7<<1)
+#	define R300_GB_TILE_PIPE_COUNT_RV410	(3<<1)
+#	define R300_GB_TILE_SIZE_8		0
+#	define R300_GB_TILE_SIZE_16		(1<<4)
+#	define R300_GB_TILE_SIZE_32		(2<<4)
+#	define R300_GB_SUPER_SIZE_1		(0<<6)
+#	define R300_GB_SUPER_SIZE_2		(1<<6)
+#	define R300_GB_SUPER_SIZE_4		(2<<6)
+#	define R300_GB_SUPER_SIZE_8		(3<<6)
+#	define R300_GB_SUPER_SIZE_16		(4<<6)
+#	define R300_GB_SUPER_SIZE_32		(5<<6)
+#	define R300_GB_SUPER_SIZE_64		(6<<6)
+#	define R300_GB_SUPER_SIZE_128		(7<<6)
+#	define R300_GB_SUPER_X_SHIFT		9	/* 3 bits wide */
+#	define R300_GB_SUPER_Y_SHIFT		12	/* 3 bits wide */
+#	define R300_GB_SUPER_TILE_A		0
+#	define R300_GB_SUPER_TILE_B		(1<<15)
+#	define R300_GB_SUBPIXEL_1_12		0
+#	define R300_GB_SUBPIXEL_1_16		(1<<16)
+
+#define R300_GB_FIFO_SIZE	0x4024
+	/* each of the following is 2 bits wide */
+#define R300_GB_FIFO_SIZE_32	0
+#define R300_GB_FIFO_SIZE_64	1
+#define R300_GB_FIFO_SIZE_128	2
+#define R300_GB_FIFO_SIZE_256	3
+#	define R300_SC_IFIFO_SIZE_SHIFT	0
+#	define R300_SC_TZFIFO_SIZE_SHIFT	2
+#	define R300_SC_BFIFO_SIZE_SHIFT	4
+
+#	define R300_US_OFIFO_SIZE_SHIFT	12
+#	define R300_US_WFIFO_SIZE_SHIFT	14
+	/* the following use the same constants as above, but meaning is
+	   is times 2 (i.e. instead of 32 words it means 64 */
+#	define R300_RS_TFIFO_SIZE_SHIFT	6
+#	define R300_RS_CFIFO_SIZE_SHIFT	8
+#	define R300_US_RAM_SIZE_SHIFT		10
+	/* watermarks, 3 bits wide */
+#	define R300_RS_HIGHWATER_COL_SHIFT	16
+#	define R300_RS_HIGHWATER_TEX_SHIFT	19
+#	define R300_OFIFO_HIGHWATER_SHIFT	22	/* two bits only */
+#	define R300_CUBE_FIFO_HIGHWATER_COL_SHIFT	24
+
+#define R300_GB_SELECT	0x401C
+#	define R300_GB_FOG_SELECT_C0A		0
+#	define R300_GB_FOG_SELECT_C1A		1
+#	define R300_GB_FOG_SELECT_C2A		2
+#	define R300_GB_FOG_SELECT_C3A		3
+#	define R300_GB_FOG_SELECT_1_1_W	4
+#	define R300_GB_FOG_SELECT_Z		5
+#	define R300_GB_DEPTH_SELECT_Z		0
+#	define R300_GB_DEPTH_SELECT_1_1_W	(1<<3)
+#	define R300_GB_W_SELECT_1_W		0
+#	define R300_GB_W_SELECT_1		(1<<4)
+
+#define R300_GB_AA_CONFIG		0x4020
+#	define R300_AA_DISABLE			0x00
+#	define R300_AA_ENABLE			0x01
+#	define R300_AA_SUBSAMPLES_2		0
+#	define R300_AA_SUBSAMPLES_3		(1<<1)
+#	define R300_AA_SUBSAMPLES_4		(2<<1)
+#	define R300_AA_SUBSAMPLES_6		(3<<1)
+
+/* gap */
+
+/* Zero to flush caches. */
+#define R300_TX_INVALTAGS                   0x4100
+#define R300_TX_FLUSH                       0x0
+
+/* The upper enable bits are guessed, based on fglrx reported limits. */
+#define R300_TX_ENABLE                      0x4104
+#       define R300_TX_ENABLE_0                  (1 << 0)
+#       define R300_TX_ENABLE_1                  (1 << 1)
+#       define R300_TX_ENABLE_2                  (1 << 2)
+#       define R300_TX_ENABLE_3                  (1 << 3)
+#       define R300_TX_ENABLE_4                  (1 << 4)
+#       define R300_TX_ENABLE_5                  (1 << 5)
+#       define R300_TX_ENABLE_6                  (1 << 6)
+#       define R300_TX_ENABLE_7                  (1 << 7)
+#       define R300_TX_ENABLE_8                  (1 << 8)
+#       define R300_TX_ENABLE_9                  (1 << 9)
+#       define R300_TX_ENABLE_10                 (1 << 10)
+#       define R300_TX_ENABLE_11                 (1 << 11)
+#       define R300_TX_ENABLE_12                 (1 << 12)
+#       define R300_TX_ENABLE_13                 (1 << 13)
+#       define R300_TX_ENABLE_14                 (1 << 14)
+#       define R300_TX_ENABLE_15                 (1 << 15)
+
+/* The pointsize is given in multiples of 6. The pointsize can be
+ * enormous: Clear() renders a single point that fills the entire
+ * framebuffer.
+ */
+#define R300_RE_POINTSIZE                   0x421C
+#       define R300_POINTSIZE_Y_SHIFT            0
+#       define R300_POINTSIZE_Y_MASK             (0xFFFF << 0) /* GUESS */
+#       define R300_POINTSIZE_X_SHIFT            16
+#       define R300_POINTSIZE_X_MASK             (0xFFFF << 16) /* GUESS */
+#       define R300_POINTSIZE_MAX             (R300_POINTSIZE_Y_MASK / 6)
+
+/* The line width is given in multiples of 6.
+ * In default mode lines are classified as vertical lines.
+ * HO: horizontal
+ * VE: vertical or horizontal
+ * HO & VE: no classification
+ */
+#define R300_RE_LINE_CNT                      0x4234
+#       define R300_LINESIZE_SHIFT            0
+#       define R300_LINESIZE_MASK             (0xFFFF << 0) /* GUESS */
+#       define R300_LINESIZE_MAX             (R300_LINESIZE_MASK / 6)
+#       define R300_LINE_CNT_HO               (1 << 16)
+#       define R300_LINE_CNT_VE               (1 << 17)
+
+/* Some sort of scale or clamp value for texcoordless textures. */
+#define R300_RE_UNK4238                       0x4238
+
+/* Something shade related */
+#define R300_RE_SHADE                         0x4274
+
+#define R300_RE_SHADE_MODEL                   0x4278
+#	define R300_RE_SHADE_MODEL_SMOOTH     0x3aaaa
+#	define R300_RE_SHADE_MODEL_FLAT       0x39595
+
+/* Dangerous */
+#define R300_RE_POLYGON_MODE                  0x4288
+#	define R300_PM_ENABLED                (1 << 0)
+#	define R300_PM_FRONT_POINT            (0 << 0)
+#	define R300_PM_BACK_POINT             (0 << 0)
+#	define R300_PM_FRONT_LINE             (1 << 4)
+#	define R300_PM_FRONT_FILL             (1 << 5)
+#	define R300_PM_BACK_LINE              (1 << 7)
+#	define R300_PM_BACK_FILL              (1 << 8)
+
+/* Fog parameters */
+#define R300_RE_FOG_SCALE                     0x4294
+#define R300_RE_FOG_START                     0x4298
+
+/* Not sure why there are duplicate of factor and constant values.
+ * My best guess so far is that there are separate zbiases for test and write.
+ * Ordering might be wrong.
+ * Some of the tests indicate that fgl has a fallback implementation of zbias
+ * via pixel shaders.
+ */
+#define R300_RE_ZBIAS_CNTL                    0x42A0 /* GUESS */
+#define R300_RE_ZBIAS_T_FACTOR                0x42A4
+#define R300_RE_ZBIAS_T_CONSTANT              0x42A8
+#define R300_RE_ZBIAS_W_FACTOR                0x42AC
+#define R300_RE_ZBIAS_W_CONSTANT              0x42B0
+
+/* This register needs to be set to (1<<1) for RV350 to correctly
+ * perform depth test (see --vb-triangles in r300_demo)
+ * Don't know about other chips. - Vladimir
+ * This is set to 3 when GL_POLYGON_OFFSET_FILL is on.
+ * My guess is that there are two bits for each zbias primitive
+ * (FILL, LINE, POINT).
+ *  One to enable depth test and one for depth write.
+ * Yet this doesn't explain why depth writes work ...
+ */
+#define R300_RE_OCCLUSION_CNTL		    0x42B4
+#	define R300_OCCLUSION_ON		(1<<1)
+
+#define R300_RE_CULL_CNTL                   0x42B8
+#       define R300_CULL_FRONT                   (1 << 0)
+#       define R300_CULL_BACK                    (1 << 1)
+#       define R300_FRONT_FACE_CCW               (0 << 2)
+#       define R300_FRONT_FACE_CW                (1 << 2)
+
+
+/* BEGIN: Rasterization / Interpolators - many guesses */
+
+/* 0_UNKNOWN_18 has always been set except for clear operations.
+ * TC_CNT is the number of incoming texture coordinate sets (i.e. it depends
+ * on the vertex program, *not* the fragment program)
+ */
+#define R300_RS_CNTL_0                      0x4300
+#       define R300_RS_CNTL_TC_CNT_SHIFT         2
+#       define R300_RS_CNTL_TC_CNT_MASK          (7 << 2)
+	/* number of color interpolators used */
+#	define R300_RS_CNTL_CI_CNT_SHIFT         7
+#       define R300_RS_CNTL_0_UNKNOWN_18         (1 << 18)
+	/* Guess: RS_CNTL_1 holds the index of the highest used RS_ROUTE_n
+	   register. */
+#define R300_RS_CNTL_1                      0x4304
+
+/* gap */
+
+/* Only used for texture coordinates.
+ * Use the source field to route texture coordinate input from the
+ * vertex program to the desired interpolator. Note that the source
+ * field is relative to the outputs the vertex program *actually*
+ * writes. If a vertex program only writes texcoord[1], this will
+ * be source index 0.
+ * Set INTERP_USED on all interpolators that produce data used by
+ * the fragment program. INTERP_USED looks like a swizzling mask,
+ * but I haven't seen it used that way.
+ *
+ * Note: The _UNKNOWN constants are always set in their respective
+ * register. I don't know if this is necessary.
+ */
+#define R300_RS_INTERP_0                    0x4310
+#define R300_RS_INTERP_1                    0x4314
+#       define R300_RS_INTERP_1_UNKNOWN          0x40
+#define R300_RS_INTERP_2                    0x4318
+#       define R300_RS_INTERP_2_UNKNOWN          0x80
+#define R300_RS_INTERP_3                    0x431C
+#       define R300_RS_INTERP_3_UNKNOWN          0xC0
+#define R300_RS_INTERP_4                    0x4320
+#define R300_RS_INTERP_5                    0x4324
+#define R300_RS_INTERP_6                    0x4328
+#define R300_RS_INTERP_7                    0x432C
+#       define R300_RS_INTERP_SRC_SHIFT          2
+#       define R300_RS_INTERP_SRC_MASK           (7 << 2)
+#       define R300_RS_INTERP_USED               0x00D10000
+
+/* These DWORDs control how vertex data is routed into fragment program
+ * registers, after interpolators.
+ */
+#define R300_RS_ROUTE_0                     0x4330
+#define R300_RS_ROUTE_1                     0x4334
+#define R300_RS_ROUTE_2                     0x4338
+#define R300_RS_ROUTE_3                     0x433C /* GUESS */
+#define R300_RS_ROUTE_4                     0x4340 /* GUESS */
+#define R300_RS_ROUTE_5                     0x4344 /* GUESS */
+#define R300_RS_ROUTE_6                     0x4348 /* GUESS */
+#define R300_RS_ROUTE_7                     0x434C /* GUESS */
+#       define R300_RS_ROUTE_SOURCE_INTERP_0     0
+#       define R300_RS_ROUTE_SOURCE_INTERP_1     1
+#       define R300_RS_ROUTE_SOURCE_INTERP_2     2
+#       define R300_RS_ROUTE_SOURCE_INTERP_3     3
+#       define R300_RS_ROUTE_SOURCE_INTERP_4     4
+#       define R300_RS_ROUTE_SOURCE_INTERP_5     5 /* GUESS */
+#       define R300_RS_ROUTE_SOURCE_INTERP_6     6 /* GUESS */
+#       define R300_RS_ROUTE_SOURCE_INTERP_7     7 /* GUESS */
+#       define R300_RS_ROUTE_ENABLE              (1 << 3) /* GUESS */
+#       define R300_RS_ROUTE_DEST_SHIFT          6
+#       define R300_RS_ROUTE_DEST_MASK           (31 << 6) /* GUESS */
+
+/* Special handling for color: When the fragment program uses color,
+ * the ROUTE_0_COLOR bit is set and ROUTE_0_COLOR_DEST contains the
+ * color register index.
+ *
+ * Apperently you may set the R300_RS_ROUTE_0_COLOR bit, but not provide any
+ * R300_RS_ROUTE_0_COLOR_DEST value; this setup is used for clearing the state.
+ * See r300_ioctl.c:r300EmitClearState. I'm not sure if this setup is strictly
+ * correct or not. - Oliver.
+ */
+#       define R300_RS_ROUTE_0_COLOR             (1 << 14)
+#       define R300_RS_ROUTE_0_COLOR_DEST_SHIFT  17
+#       define R300_RS_ROUTE_0_COLOR_DEST_MASK   (31 << 17) /* GUESS */
+/* As above, but for secondary color */
+#		define R300_RS_ROUTE_1_COLOR1            (1 << 14)
+#		define R300_RS_ROUTE_1_COLOR1_DEST_SHIFT 17
+#		define R300_RS_ROUTE_1_COLOR1_DEST_MASK  (31 << 17)
+#		define R300_RS_ROUTE_1_UNKNOWN11         (1 << 11)
+/* END: Rasterization / Interpolators - many guesses */
+
+/* Hierarchical Z Enable */
+#define R300_SC_HYPERZ                   0x43a4
+#	define R300_SC_HYPERZ_DISABLE     (0 << 0)
+#	define R300_SC_HYPERZ_ENABLE      (1 << 0)
+#	define R300_SC_HYPERZ_MIN         (0 << 1)
+#	define R300_SC_HYPERZ_MAX         (1 << 1)
+#	define R300_SC_HYPERZ_ADJ_256     (0 << 2)
+#	define R300_SC_HYPERZ_ADJ_128     (1 << 2)
+#	define R300_SC_HYPERZ_ADJ_64      (2 << 2)
+#	define R300_SC_HYPERZ_ADJ_32      (3 << 2)
+#	define R300_SC_HYPERZ_ADJ_16      (4 << 2)
+#	define R300_SC_HYPERZ_ADJ_8       (5 << 2)
+#	define R300_SC_HYPERZ_ADJ_4       (6 << 2)
+#	define R300_SC_HYPERZ_ADJ_2       (7 << 2)
+#	define R300_SC_HYPERZ_HZ_Z0MIN_NO (0 << 5)
+#	define R300_SC_HYPERZ_HZ_Z0MIN    (1 << 5)
+#	define R300_SC_HYPERZ_HZ_Z0MAX_NO (0 << 6)
+#	define R300_SC_HYPERZ_HZ_Z0MAX    (1 << 6)
+
+#define R300_SC_EDGERULE                 0x43a8
+
+/* BEGIN: Scissors and cliprects */
+
+/* There are four clipping rectangles. Their corner coordinates are inclusive.
+ * Every pixel is assigned a number from 0 and 15 by setting bits 0-3 depending
+ * on whether the pixel is inside cliprects 0-3, respectively. For example,
+ * if a pixel is inside cliprects 0 and 1, but outside 2 and 3, it is assigned
+ * the number 3 (binary 0011).
+ * Iff the bit corresponding to the pixel's number in RE_CLIPRECT_CNTL is set,
+ * the pixel is rasterized.
+ *
+ * In addition to this, there is a scissors rectangle. Only pixels inside the
+ * scissors rectangle are drawn. (coordinates are inclusive)
+ *
+ * For some reason, the top-left corner of the framebuffer is at (1440, 1440)
+ * for the purpose of clipping and scissors.
+ */
+#define R300_RE_CLIPRECT_TL_0               0x43B0
+#define R300_RE_CLIPRECT_BR_0               0x43B4
+#define R300_RE_CLIPRECT_TL_1               0x43B8
+#define R300_RE_CLIPRECT_BR_1               0x43BC
+#define R300_RE_CLIPRECT_TL_2               0x43C0
+#define R300_RE_CLIPRECT_BR_2               0x43C4
+#define R300_RE_CLIPRECT_TL_3               0x43C8
+#define R300_RE_CLIPRECT_BR_3               0x43CC
+#       define R300_CLIPRECT_OFFSET              1440
+#       define R300_CLIPRECT_MASK                0x1FFF
+#       define R300_CLIPRECT_X_SHIFT             0
+#       define R300_CLIPRECT_X_MASK              (0x1FFF << 0)
+#       define R300_CLIPRECT_Y_SHIFT             13
+#       define R300_CLIPRECT_Y_MASK              (0x1FFF << 13)
+#define R300_RE_CLIPRECT_CNTL               0x43D0
+#       define R300_CLIP_OUT                     (1 << 0)
+#       define R300_CLIP_0                       (1 << 1)
+#       define R300_CLIP_1                       (1 << 2)
+#       define R300_CLIP_10                      (1 << 3)
+#       define R300_CLIP_2                       (1 << 4)
+#       define R300_CLIP_20                      (1 << 5)
+#       define R300_CLIP_21                      (1 << 6)
+#       define R300_CLIP_210                     (1 << 7)
+#       define R300_CLIP_3                       (1 << 8)
+#       define R300_CLIP_30                      (1 << 9)
+#       define R300_CLIP_31                      (1 << 10)
+#       define R300_CLIP_310                     (1 << 11)
+#       define R300_CLIP_32                      (1 << 12)
+#       define R300_CLIP_320                     (1 << 13)
+#       define R300_CLIP_321                     (1 << 14)
+#       define R300_CLIP_3210                    (1 << 15)
+
+/* gap */
+
+#define R300_RE_SCISSORS_TL                 0x43E0
+#define R300_RE_SCISSORS_BR                 0x43E4
+#       define R300_SCISSORS_OFFSET              1440
+#       define R300_SCISSORS_X_SHIFT             0
+#       define R300_SCISSORS_X_MASK              (0x1FFF << 0)
+#       define R300_SCISSORS_Y_SHIFT             13
+#       define R300_SCISSORS_Y_MASK              (0x1FFF << 13)
+/* END: Scissors and cliprects */
+
+/* BEGIN: Texture specification */
+
+/*
+ * The texture specification dwords are grouped by meaning and not by texture
+ * unit. This means that e.g. the offset for texture image unit N is found in
+ * register TX_OFFSET_0 + (4*N)
+ */
+#define R300_TX_FILTER_0                    0x4400
+#       define R300_TX_REPEAT                    0
+#       define R300_TX_MIRRORED                  1
+#       define R300_TX_CLAMP                     4
+#       define R300_TX_CLAMP_TO_EDGE             2
+#       define R300_TX_CLAMP_TO_BORDER           6
+#       define R300_TX_WRAP_S_SHIFT              0
+#       define R300_TX_WRAP_S_MASK               (7 << 0)
+#       define R300_TX_WRAP_T_SHIFT              3
+#       define R300_TX_WRAP_T_MASK               (7 << 3)
+#       define R300_TX_WRAP_Q_SHIFT              6
+#       define R300_TX_WRAP_Q_MASK               (7 << 6)
+#       define R300_TX_MAG_FILTER_NEAREST        (1 << 9)
+#       define R300_TX_MAG_FILTER_LINEAR         (2 << 9)
+#       define R300_TX_MAG_FILTER_MASK           (3 << 9)
+#       define R300_TX_MIN_FILTER_NEAREST        (1 << 11)
+#       define R300_TX_MIN_FILTER_LINEAR         (2 << 11)
+#	define R300_TX_MIN_FILTER_NEAREST_MIP_NEAREST       (5  <<  11)
+#	define R300_TX_MIN_FILTER_NEAREST_MIP_LINEAR        (9  <<  11)
+#	define R300_TX_MIN_FILTER_LINEAR_MIP_NEAREST        (6  <<  11)
+#	define R300_TX_MIN_FILTER_LINEAR_MIP_LINEAR         (10 <<  11)
+
+/* NOTE: NEAREST doesn't seem to exist.
+ * Im not seting MAG_FILTER_MASK and (3 << 11) on for all
+ * anisotropy modes because that would void selected mag filter
+ */
+#	define R300_TX_MIN_FILTER_ANISO_NEAREST             (0 << 13)
+#	define R300_TX_MIN_FILTER_ANISO_LINEAR              (0 << 13)
+#	define R300_TX_MIN_FILTER_ANISO_NEAREST_MIP_NEAREST (1 << 13)
+#	define R300_TX_MIN_FILTER_ANISO_NEAREST_MIP_LINEAR  (2 << 13)
+#       define R300_TX_MIN_FILTER_MASK   ( (15 << 11) | (3 << 13) )
+#	define R300_TX_MAX_ANISO_1_TO_1  (0 << 21)
+#	define R300_TX_MAX_ANISO_2_TO_1  (2 << 21)
+#	define R300_TX_MAX_ANISO_4_TO_1  (4 << 21)
+#	define R300_TX_MAX_ANISO_8_TO_1  (6 << 21)
+#	define R300_TX_MAX_ANISO_16_TO_1 (8 << 21)
+#	define R300_TX_MAX_ANISO_MASK    (14 << 21)
+
+#define R300_TX_FILTER1_0                      0x4440
+#	define R300_CHROMA_KEY_MODE_DISABLE    0
+#	define R300_CHROMA_KEY_FORCE	       1
+#	define R300_CHROMA_KEY_BLEND           2
+#	define R300_MC_ROUND_NORMAL            (0<<2)
+#	define R300_MC_ROUND_MPEG4             (1<<2)
+#	define R300_LOD_BIAS_MASK	    0x1fff
+#	define R300_EDGE_ANISO_EDGE_DIAG       (0<<13)
+#	define R300_EDGE_ANISO_EDGE_ONLY       (1<<13)
+#	define R300_MC_COORD_TRUNCATE_DISABLE  (0<<14)
+#	define R300_MC_COORD_TRUNCATE_MPEG     (1<<14)
+#	define R300_TX_TRI_PERF_0_8            (0<<15)
+#	define R300_TX_TRI_PERF_1_8            (1<<15)
+#	define R300_TX_TRI_PERF_1_4            (2<<15)
+#	define R300_TX_TRI_PERF_3_8            (3<<15)
+#	define R300_ANISO_THRESHOLD_MASK       (7<<17)
+
+#define R300_TX_SIZE_0                      0x4480
+#       define R300_TX_WIDTHMASK_SHIFT           0
+#       define R300_TX_WIDTHMASK_MASK            (2047 << 0)
+#       define R300_TX_HEIGHTMASK_SHIFT          11
+#       define R300_TX_HEIGHTMASK_MASK           (2047 << 11)
+#       define R300_TX_UNK23                     (1 << 23)
+#       define R300_TX_MAX_MIP_LEVEL_SHIFT       26
+#       define R300_TX_MAX_MIP_LEVEL_MASK        (0xf << 26)
+#       define R300_TX_SIZE_PROJECTED            (1<<30)
+#       define R300_TX_SIZE_TXPITCH_EN           (1<<31)
+#define R300_TX_FORMAT_0                    0x44C0
+	/* The interpretation of the format word by Wladimir van der Laan */
+	/* The X, Y, Z and W refer to the layout of the components.
+	   They are given meanings as R, G, B and Alpha by the swizzle
+	   specification */
+#	define R300_TX_FORMAT_X8		    0x0
+#	define R300_TX_FORMAT_X16		    0x1
+#	define R300_TX_FORMAT_Y4X4		    0x2
+#	define R300_TX_FORMAT_Y8X8		    0x3
+#	define R300_TX_FORMAT_Y16X16		    0x4
+#	define R300_TX_FORMAT_Z3Y3X2		    0x5
+#	define R300_TX_FORMAT_Z5Y6X5		    0x6
+#	define R300_TX_FORMAT_Z6Y5X5		    0x7
+#	define R300_TX_FORMAT_Z11Y11X10		    0x8
+#	define R300_TX_FORMAT_Z10Y11X11		    0x9
+#	define R300_TX_FORMAT_W4Z4Y4X4		    0xA
+#	define R300_TX_FORMAT_W1Z5Y5X5		    0xB
+#	define R300_TX_FORMAT_W8Z8Y8X8		    0xC
+#	define R300_TX_FORMAT_W2Z10Y10X10	    0xD
+#	define R300_TX_FORMAT_W16Z16Y16X16	    0xE
+#	define R300_TX_FORMAT_DXT1		    0xF
+#	define R300_TX_FORMAT_DXT3		    0x10
+#	define R300_TX_FORMAT_DXT5		    0x11
+#	define R300_TX_FORMAT_D3DMFT_CxV8U8	    0x12     /* no swizzle */
+#	define R300_TX_FORMAT_A8R8G8B8		    0x13     /* no swizzle */
+#	define R300_TX_FORMAT_B8G8_B8G8		    0x14     /* no swizzle */
+#	define R300_TX_FORMAT_G8R8_G8B8		    0x15     /* no swizzle */
+	/* 0x16 - some 16 bit green format.. ?? */
+#	define R300_TX_FORMAT_UNK25		   (1 << 25) /* no swizzle */
+#	define R300_TX_FORMAT_CUBIC_MAP		   (1 << 26)
+
+	/* gap */
+	/* Floating point formats */
+	/* Note - hardware supports both 16 and 32 bit floating point */
+#	define R300_TX_FORMAT_FL_I16		    0x18
+#	define R300_TX_FORMAT_FL_I16A16		    0x19
+#	define R300_TX_FORMAT_FL_R16G16B16A16	    0x1A
+#	define R300_TX_FORMAT_FL_I32		    0x1B
+#	define R300_TX_FORMAT_FL_I32A32		    0x1C
+#	define R300_TX_FORMAT_FL_R32G32B32A32	    0x1D
+#	define R300_TX_FORMAT_ATI2N		    0x1F
+	/* alpha modes, convenience mostly */
+	/* if you have alpha, pick constant appropriate to the
+	   number of channels (1 for I8, 2 for I8A8, 4 for R8G8B8A8, etc */
+#	define R300_TX_FORMAT_ALPHA_1CH		    0x000
+#	define R300_TX_FORMAT_ALPHA_2CH		    0x200
+#	define R300_TX_FORMAT_ALPHA_4CH		    0x600
+#	define R300_TX_FORMAT_ALPHA_NONE	    0xA00
+	/* Swizzling */
+	/* constants */
+#	define R300_TX_FORMAT_X		0
+#	define R300_TX_FORMAT_Y		1
+#	define R300_TX_FORMAT_Z		2
+#	define R300_TX_FORMAT_W		3
+#	define R300_TX_FORMAT_ZERO	4
+#	define R300_TX_FORMAT_ONE	5
+	/* 2.0*Z, everything above 1.0 is set to 0.0 */
+#	define R300_TX_FORMAT_CUT_Z	6
+	/* 2.0*W, everything above 1.0 is set to 0.0 */
+#	define R300_TX_FORMAT_CUT_W	7
+
+#	define R300_TX_FORMAT_B_SHIFT	18
+#	define R300_TX_FORMAT_G_SHIFT	15
+#	define R300_TX_FORMAT_R_SHIFT	12
+#	define R300_TX_FORMAT_A_SHIFT	9
+	/* Convenience macro to take care of layout and swizzling */
+#	define R300_EASY_TX_FORMAT(B, G, R, A, FMT)	(		\
+		((R300_TX_FORMAT_##B)<<R300_TX_FORMAT_B_SHIFT)		\
+		| ((R300_TX_FORMAT_##G)<<R300_TX_FORMAT_G_SHIFT)	\
+		| ((R300_TX_FORMAT_##R)<<R300_TX_FORMAT_R_SHIFT)	\
+		| ((R300_TX_FORMAT_##A)<<R300_TX_FORMAT_A_SHIFT)	\
+		| (R300_TX_FORMAT_##FMT)				\
+		)
+	/* These can be ORed with result of R300_EASY_TX_FORMAT()
+	   We don't really know what they do. Take values from a
+           constant color ? */
+#	define R300_TX_FORMAT_CONST_X		(1<<5)
+#	define R300_TX_FORMAT_CONST_Y		(2<<5)
+#	define R300_TX_FORMAT_CONST_Z		(4<<5)
+#	define R300_TX_FORMAT_CONST_W		(8<<5)
+
+#	define R300_TX_FORMAT_YUV_MODE		0x00800000
+
+#define R300_TX_PITCH_0			    0x4500 /* obvious missing in gap */
+#define R300_TX_OFFSET_0                    0x4540
+	/* BEGIN: Guess from R200 */
+#       define R300_TXO_ENDIAN_NO_SWAP           (0 << 0)
+#       define R300_TXO_ENDIAN_BYTE_SWAP         (1 << 0)
+#       define R300_TXO_ENDIAN_WORD_SWAP         (2 << 0)
+#       define R300_TXO_ENDIAN_HALFDW_SWAP       (3 << 0)
+#       define R300_TXO_MACRO_TILE               (1 << 2)
+#       define R300_TXO_MICRO_TILE               (1 << 3)
+#       define R300_TXO_MICRO_TILE_SQUARE        (2 << 3)
+#       define R300_TXO_OFFSET_MASK              0xffffffe0
+#       define R300_TXO_OFFSET_SHIFT             5
+	/* END: Guess from R200 */
+
+/* 32 bit chroma key */
+#define R300_TX_CHROMA_KEY_0                      0x4580
+/* ff00ff00 == { 0, 1.0, 0, 1.0 } */
+#define R300_TX_BORDER_COLOR_0              0x45C0
+
+/* END: Texture specification */
+
+/* BEGIN: Fragment program instruction set */
+
+/* Fragment programs are written directly into register space.
+ * There are separate instruction streams for texture instructions and ALU
+ * instructions.
+ * In order to synchronize these streams, the program is divided into up
+ * to 4 nodes. Each node begins with a number of TEX operations, followed
+ * by a number of ALU operations.
+ * The first node can have zero TEX ops, all subsequent nodes must have at
+ * least
+ * one TEX ops.
+ * All nodes must have at least one ALU op.
+ *
+ * The index of the last node is stored in PFS_CNTL_0: A value of 0 means
+ * 1 node, a value of 3 means 4 nodes.
+ * The total amount of instructions is defined in PFS_CNTL_2. The offsets are
+ * offsets into the respective instruction streams, while *_END points to the
+ * last instruction relative to this offset.
+ */
+#define R300_PFS_CNTL_0                     0x4600
+#       define R300_PFS_CNTL_LAST_NODES_SHIFT    0
+#       define R300_PFS_CNTL_LAST_NODES_MASK     (3 << 0)
+#       define R300_PFS_CNTL_FIRST_NODE_HAS_TEX  (1 << 3)
+#define R300_PFS_CNTL_1                     0x4604
+/* There is an unshifted value here which has so far always been equal to the
+ * index of the highest used temporary register.
+ */
+#define R300_PFS_CNTL_2                     0x4608
+#       define R300_PFS_CNTL_ALU_OFFSET_SHIFT    0
+#       define R300_PFS_CNTL_ALU_OFFSET_MASK     (63 << 0)
+#       define R300_PFS_CNTL_ALU_END_SHIFT       6
+#       define R300_PFS_CNTL_ALU_END_MASK        (63 << 6)
+#       define R300_PFS_CNTL_TEX_OFFSET_SHIFT    12
+#       define R300_PFS_CNTL_TEX_OFFSET_MASK     (31 << 12) /* GUESS */
+#       define R300_PFS_CNTL_TEX_END_SHIFT       18
+#       define R300_PFS_CNTL_TEX_END_MASK        (31 << 18) /* GUESS */
+
+/* gap */
+
+/* Nodes are stored backwards. The last active node is always stored in
+ * PFS_NODE_3.
+ * Example: In a 2-node program, NODE_0 and NODE_1 are set to 0. The
+ * first node is stored in NODE_2, the second node is stored in NODE_3.
+ *
+ * Offsets are relative to the master offset from PFS_CNTL_2.
+ */
+#define R300_PFS_NODE_0                     0x4610
+#define R300_PFS_NODE_1                     0x4614
+#define R300_PFS_NODE_2                     0x4618
+#define R300_PFS_NODE_3                     0x461C
+#       define R300_PFS_NODE_ALU_OFFSET_SHIFT    0
+#       define R300_PFS_NODE_ALU_OFFSET_MASK     (63 << 0)
+#       define R300_PFS_NODE_ALU_END_SHIFT       6
+#       define R300_PFS_NODE_ALU_END_MASK        (63 << 6)
+#       define R300_PFS_NODE_TEX_OFFSET_SHIFT    12
+#       define R300_PFS_NODE_TEX_OFFSET_MASK     (31 << 12)
+#       define R300_PFS_NODE_TEX_END_SHIFT       17
+#       define R300_PFS_NODE_TEX_END_MASK        (31 << 17)
+#		define R300_PFS_NODE_OUTPUT_COLOR        (1 << 22)
+#		define R300_PFS_NODE_OUTPUT_DEPTH        (1 << 23)
+
+/* TEX
+ * As far as I can tell, texture instructions cannot write into output
+ * registers directly. A subsequent ALU instruction is always necessary,
+ * even if it's just MAD o0, r0, 1, 0
+ */
+#define R300_PFS_TEXI_0                     0x4620
+#	define R300_FPITX_SRC_SHIFT              0
+#	define R300_FPITX_SRC_MASK               (31 << 0)
+	/* GUESS */
+#	define R300_FPITX_SRC_CONST              (1 << 5)
+#	define R300_FPITX_DST_SHIFT              6
+#	define R300_FPITX_DST_MASK               (31 << 6)
+#	define R300_FPITX_IMAGE_SHIFT            11
+	/* GUESS based on layout and native limits */
+#       define R300_FPITX_IMAGE_MASK             (15 << 11)
+/* Unsure if these are opcodes, or some kind of bitfield, but this is how
+ * they were set when I checked
+ */
+#	define R300_FPITX_OPCODE_SHIFT		15
+#		define R300_FPITX_OP_TEX	1
+#		define R300_FPITX_OP_KIL	2
+#		define R300_FPITX_OP_TXP	3
+#		define R300_FPITX_OP_TXB	4
+#	define R300_FPITX_OPCODE_MASK           (7 << 15)
+
+/* ALU
+ * The ALU instructions register blocks are enumerated according to the order
+ * in which fglrx. I assume there is space for 64 instructions, since
+ * each block has space for a maximum of 64 DWORDs, and this matches reported
+ * native limits.
+ *
+ * The basic functional block seems to be one MAD for each color and alpha,
+ * and an adder that adds all components after the MUL.
+ *  - ADD, MUL, MAD etc.: use MAD with appropriate neutral operands
+ *  - DP4: Use OUTC_DP4, OUTA_DP4
+ *  - DP3: Use OUTC_DP3, OUTA_DP4, appropriate alpha operands
+ *  - DPH: Use OUTC_DP4, OUTA_DP4, appropriate alpha operands
+ *  - CMPH: If ARG2 > 0.5, return ARG0, else return ARG1
+ *  - CMP: If ARG2 < 0, return ARG1, else return ARG0
+ *  - FLR: use FRC+MAD
+ *  - XPD: use MAD+MAD
+ *  - SGE, SLT: use MAD+CMP
+ *  - RSQ: use ABS modifier for argument
+ *  - Use OUTC_REPL_ALPHA to write results of an alpha-only operation
+ *    (e.g. RCP) into color register
+ *  - apparently, there's no quick DST operation
+ *  - fglrx set FPI2_UNKNOWN_31 on a "MAD fragment.color, tmp0, tmp1, tmp2"
+ *  - fglrx set FPI2_UNKNOWN_31 on a "MAX r2, r1, c0"
+ *  - fglrx once set FPI0_UNKNOWN_31 on a "FRC r1, r1"
+ *
+ * Operand selection
+ * First stage selects three sources from the available registers and
+ * constant parameters. This is defined in INSTR1 (color) and INSTR3 (alpha).
+ * fglrx sorts the three source fields: Registers before constants,
+ * lower indices before higher indices; I do not know whether this is
+ * necessary.
+ *
+ * fglrx fills unused sources with "read constant 0"
+ * According to specs, you cannot select more than two different constants.
+ *
+ * Second stage selects the operands from the sources. This is defined in
+ * INSTR0 (color) and INSTR2 (alpha). You can also select the special constants
+ * zero and one.
+ * Swizzling and negation happens in this stage, as well.
+ *
+ * Important: Color and alpha seem to be mostly separate, i.e. their sources
+ * selection appears to be fully independent (the register storage is probably
+ * physically split into a color and an alpha section).
+ * However (because of the apparent physical split), there is some interaction
+ * WRT swizzling. If, for example, you want to load an R component into an
+ * Alpha operand, this R component is taken from a *color* source, not from
+ * an alpha source. The corresponding register doesn't even have to appear in
+ * the alpha sources list. (I hope this all makes sense to you)
+ *
+ * Destination selection
+ * The destination register index is in FPI1 (color) and FPI3 (alpha)
+ * together with enable bits.
+ * There are separate enable bits for writing into temporary registers
+ * (DSTC_REG_* /DSTA_REG) and and program output registers (DSTC_OUTPUT_*
+ * /DSTA_OUTPUT). You can write to both at once, or not write at all (the
+ * same index must be used for both).
+ *
+ * Note: There is a special form for LRP
+ *  - Argument order is the same as in ARB_fragment_program.
+ *  - Operation is MAD
+ *  - ARG1 is set to ARGC_SRC1C_LRP/ARGC_SRC1A_LRP
+ *  - Set FPI0/FPI2_SPECIAL_LRP
+ * Arbitrary LRP (including support for swizzling) requires vanilla MAD+MAD
+ */
+#define R300_PFS_INSTR1_0                   0x46C0
+#       define R300_FPI1_SRC0C_SHIFT             0
+#       define R300_FPI1_SRC0C_MASK              (31 << 0)
+#       define R300_FPI1_SRC0C_CONST             (1 << 5)
+#       define R300_FPI1_SRC1C_SHIFT             6
+#       define R300_FPI1_SRC1C_MASK              (31 << 6)
+#       define R300_FPI1_SRC1C_CONST             (1 << 11)
+#       define R300_FPI1_SRC2C_SHIFT             12
+#       define R300_FPI1_SRC2C_MASK              (31 << 12)
+#       define R300_FPI1_SRC2C_CONST             (1 << 17)
+#       define R300_FPI1_SRC_MASK                0x0003ffff
+#       define R300_FPI1_DSTC_SHIFT              18
+#       define R300_FPI1_DSTC_MASK               (31 << 18)
+#		define R300_FPI1_DSTC_REG_MASK_SHIFT     23
+#       define R300_FPI1_DSTC_REG_X              (1 << 23)
+#       define R300_FPI1_DSTC_REG_Y              (1 << 24)
+#       define R300_FPI1_DSTC_REG_Z              (1 << 25)
+#		define R300_FPI1_DSTC_OUTPUT_MASK_SHIFT  26
+#       define R300_FPI1_DSTC_OUTPUT_X           (1 << 26)
+#       define R300_FPI1_DSTC_OUTPUT_Y           (1 << 27)
+#       define R300_FPI1_DSTC_OUTPUT_Z           (1 << 28)
+
+#define R300_PFS_INSTR3_0                   0x47C0
+#       define R300_FPI3_SRC0A_SHIFT             0
+#       define R300_FPI3_SRC0A_MASK              (31 << 0)
+#       define R300_FPI3_SRC0A_CONST             (1 << 5)
+#       define R300_FPI3_SRC1A_SHIFT             6
+#       define R300_FPI3_SRC1A_MASK              (31 << 6)
+#       define R300_FPI3_SRC1A_CONST             (1 << 11)
+#       define R300_FPI3_SRC2A_SHIFT             12
+#       define R300_FPI3_SRC2A_MASK              (31 << 12)
+#       define R300_FPI3_SRC2A_CONST             (1 << 17)
+#       define R300_FPI3_SRC_MASK                0x0003ffff
+#       define R300_FPI3_DSTA_SHIFT              18
+#       define R300_FPI3_DSTA_MASK               (31 << 18)
+#       define R300_FPI3_DSTA_REG                (1 << 23)
+#       define R300_FPI3_DSTA_OUTPUT             (1 << 24)
+#		define R300_FPI3_DSTA_DEPTH              (1 << 27)
+
+#define R300_PFS_INSTR0_0                   0x48C0
+#       define R300_FPI0_ARGC_SRC0C_XYZ          0
+#       define R300_FPI0_ARGC_SRC0C_XXX          1
+#       define R300_FPI0_ARGC_SRC0C_YYY          2
+#       define R300_FPI0_ARGC_SRC0C_ZZZ          3
+#       define R300_FPI0_ARGC_SRC1C_XYZ          4
+#       define R300_FPI0_ARGC_SRC1C_XXX          5
+#       define R300_FPI0_ARGC_SRC1C_YYY          6
+#       define R300_FPI0_ARGC_SRC1C_ZZZ          7
+#       define R300_FPI0_ARGC_SRC2C_XYZ          8
+#       define R300_FPI0_ARGC_SRC2C_XXX          9
+#       define R300_FPI0_ARGC_SRC2C_YYY          10
+#       define R300_FPI0_ARGC_SRC2C_ZZZ          11
+#       define R300_FPI0_ARGC_SRC0A              12
+#       define R300_FPI0_ARGC_SRC1A              13
+#       define R300_FPI0_ARGC_SRC2A              14
+#       define R300_FPI0_ARGC_SRC1C_LRP          15
+#       define R300_FPI0_ARGC_ZERO               20
+#       define R300_FPI0_ARGC_ONE                21
+	/* GUESS */
+#       define R300_FPI0_ARGC_HALF               22
+#       define R300_FPI0_ARGC_SRC0C_YZX          23
+#       define R300_FPI0_ARGC_SRC1C_YZX          24
+#       define R300_FPI0_ARGC_SRC2C_YZX          25
+#       define R300_FPI0_ARGC_SRC0C_ZXY          26
+#       define R300_FPI0_ARGC_SRC1C_ZXY          27
+#       define R300_FPI0_ARGC_SRC2C_ZXY          28
+#       define R300_FPI0_ARGC_SRC0CA_WZY         29
+#       define R300_FPI0_ARGC_SRC1CA_WZY         30
+#       define R300_FPI0_ARGC_SRC2CA_WZY         31
+
+#       define R300_FPI0_ARG0C_SHIFT             0
+#       define R300_FPI0_ARG0C_MASK              (31 << 0)
+#       define R300_FPI0_ARG0C_NEG               (1 << 5)
+#       define R300_FPI0_ARG0C_ABS               (1 << 6)
+#       define R300_FPI0_ARG1C_SHIFT             7
+#       define R300_FPI0_ARG1C_MASK              (31 << 7)
+#       define R300_FPI0_ARG1C_NEG               (1 << 12)
+#       define R300_FPI0_ARG1C_ABS               (1 << 13)
+#       define R300_FPI0_ARG2C_SHIFT             14
+#       define R300_FPI0_ARG2C_MASK              (31 << 14)
+#       define R300_FPI0_ARG2C_NEG               (1 << 19)
+#       define R300_FPI0_ARG2C_ABS               (1 << 20)
+#       define R300_FPI0_SPECIAL_LRP             (1 << 21)
+#       define R300_FPI0_OUTC_MAD                (0 << 23)
+#       define R300_FPI0_OUTC_DP3                (1 << 23)
+#       define R300_FPI0_OUTC_DP4                (2 << 23)
+#       define R300_FPI0_OUTC_MIN                (4 << 23)
+#       define R300_FPI0_OUTC_MAX                (5 << 23)
+#       define R300_FPI0_OUTC_CMPH               (7 << 23)
+#       define R300_FPI0_OUTC_CMP                (8 << 23)
+#       define R300_FPI0_OUTC_FRC                (9 << 23)
+#       define R300_FPI0_OUTC_REPL_ALPHA         (10 << 23)
+#       define R300_FPI0_OUTC_SAT                (1 << 30)
+#       define R300_FPI0_INSERT_NOP              (1 << 31)
+
+#define R300_PFS_INSTR2_0                   0x49C0
+#       define R300_FPI2_ARGA_SRC0C_X            0
+#       define R300_FPI2_ARGA_SRC0C_Y            1
+#       define R300_FPI2_ARGA_SRC0C_Z            2
+#       define R300_FPI2_ARGA_SRC1C_X            3
+#       define R300_FPI2_ARGA_SRC1C_Y            4
+#       define R300_FPI2_ARGA_SRC1C_Z            5
+#       define R300_FPI2_ARGA_SRC2C_X            6
+#       define R300_FPI2_ARGA_SRC2C_Y            7
+#       define R300_FPI2_ARGA_SRC2C_Z            8
+#       define R300_FPI2_ARGA_SRC0A              9
+#       define R300_FPI2_ARGA_SRC1A              10
+#       define R300_FPI2_ARGA_SRC2A              11
+#       define R300_FPI2_ARGA_SRC1A_LRP          15
+#       define R300_FPI2_ARGA_ZERO               16
+#       define R300_FPI2_ARGA_ONE                17
+	/* GUESS */
+#       define R300_FPI2_ARGA_HALF               18
+#       define R300_FPI2_ARG0A_SHIFT             0
+#       define R300_FPI2_ARG0A_MASK              (31 << 0)
+#       define R300_FPI2_ARG0A_NEG               (1 << 5)
+	/* GUESS */
+#	define R300_FPI2_ARG0A_ABS		 (1 << 6)
+#       define R300_FPI2_ARG1A_SHIFT             7
+#       define R300_FPI2_ARG1A_MASK              (31 << 7)
+#       define R300_FPI2_ARG1A_NEG               (1 << 12)
+	/* GUESS */
+#	define R300_FPI2_ARG1A_ABS		 (1 << 13)
+#       define R300_FPI2_ARG2A_SHIFT             14
+#       define R300_FPI2_ARG2A_MASK              (31 << 14)
+#       define R300_FPI2_ARG2A_NEG               (1 << 19)
+	/* GUESS */
+#	define R300_FPI2_ARG2A_ABS		 (1 << 20)
+#       define R300_FPI2_SPECIAL_LRP             (1 << 21)
+#       define R300_FPI2_OUTA_MAD                (0 << 23)
+#       define R300_FPI2_OUTA_DP4                (1 << 23)
+#       define R300_FPI2_OUTA_MIN                (2 << 23)
+#       define R300_FPI2_OUTA_MAX                (3 << 23)
+#       define R300_FPI2_OUTA_CMP                (6 << 23)
+#       define R300_FPI2_OUTA_FRC                (7 << 23)
+#       define R300_FPI2_OUTA_EX2                (8 << 23)
+#       define R300_FPI2_OUTA_LG2                (9 << 23)
+#       define R300_FPI2_OUTA_RCP                (10 << 23)
+#       define R300_FPI2_OUTA_RSQ                (11 << 23)
+#       define R300_FPI2_OUTA_SAT                (1 << 30)
+#       define R300_FPI2_UNKNOWN_31              (1 << 31)
+/* END: Fragment program instruction set */
+
+/* Fog state and color */
+#define R300_RE_FOG_STATE                   0x4BC0
+#       define R300_FOG_ENABLE                   (1 << 0)
+#	define R300_FOG_MODE_LINEAR              (0 << 1)
+#	define R300_FOG_MODE_EXP                 (1 << 1)
+#	define R300_FOG_MODE_EXP2                (2 << 1)
+#	define R300_FOG_MODE_MASK                (3 << 1)
+#define R300_FOG_COLOR_R                    0x4BC8
+#define R300_FOG_COLOR_G                    0x4BCC
+#define R300_FOG_COLOR_B                    0x4BD0
+
+#define R300_PP_ALPHA_TEST                  0x4BD4
+#       define R300_REF_ALPHA_MASK               0x000000ff
+#       define R300_ALPHA_TEST_FAIL              (0 << 8)
+#       define R300_ALPHA_TEST_LESS              (1 << 8)
+#       define R300_ALPHA_TEST_LEQUAL            (3 << 8)
+#       define R300_ALPHA_TEST_EQUAL             (2 << 8)
+#       define R300_ALPHA_TEST_GEQUAL            (6 << 8)
+#       define R300_ALPHA_TEST_GREATER           (4 << 8)
+#       define R300_ALPHA_TEST_NEQUAL            (5 << 8)
+#       define R300_ALPHA_TEST_PASS              (7 << 8)
+#       define R300_ALPHA_TEST_OP_MASK           (7 << 8)
+#       define R300_ALPHA_TEST_ENABLE            (1 << 11)
+
+/* gap */
+
+/* Fragment program parameters in 7.16 floating point */
+#define R300_PFS_PARAM_0_X                  0x4C00
+#define R300_PFS_PARAM_0_Y                  0x4C04
+#define R300_PFS_PARAM_0_Z                  0x4C08
+#define R300_PFS_PARAM_0_W                  0x4C0C
+/* GUESS: PARAM_31 is last, based on native limits reported by fglrx */
+#define R300_PFS_PARAM_31_X                 0x4DF0
+#define R300_PFS_PARAM_31_Y                 0x4DF4
+#define R300_PFS_PARAM_31_Z                 0x4DF8
+#define R300_PFS_PARAM_31_W                 0x4DFC
+
+/* Notes:
+ * - AFAIK fglrx always sets BLEND_UNKNOWN when blending is used in
+ *   the application
+ * - AFAIK fglrx always sets BLEND_NO_SEPARATE when CBLEND and ABLEND
+ *    are set to the same
+ *   function (both registers are always set up completely in any case)
+ * - Most blend flags are simply copied from R200 and not tested yet
+ */
+#define R300_RB3D_CBLEND                    0x4E04
+#define R300_RB3D_ABLEND                    0x4E08
+/* the following only appear in CBLEND */
+#       define R300_BLEND_ENABLE                     (1 << 0)
+#       define R300_BLEND_UNKNOWN                    (3 << 1)
+#       define R300_BLEND_NO_SEPARATE                (1 << 3)
+/* the following are shared between CBLEND and ABLEND */
+#       define R300_FCN_MASK                         (3  << 12)
+#       define R300_COMB_FCN_ADD_CLAMP               (0  << 12)
+#       define R300_COMB_FCN_ADD_NOCLAMP             (1  << 12)
+#       define R300_COMB_FCN_SUB_CLAMP               (2  << 12)
+#       define R300_COMB_FCN_SUB_NOCLAMP             (3  << 12)
+#       define R300_COMB_FCN_MIN                     (4  << 12)
+#       define R300_COMB_FCN_MAX                     (5  << 12)
+#       define R300_COMB_FCN_RSUB_CLAMP              (6  << 12)
+#       define R300_COMB_FCN_RSUB_NOCLAMP            (7  << 12)
+#       define R300_BLEND_GL_ZERO                    (32)
+#       define R300_BLEND_GL_ONE                     (33)
+#       define R300_BLEND_GL_SRC_COLOR               (34)
+#       define R300_BLEND_GL_ONE_MINUS_SRC_COLOR     (35)
+#       define R300_BLEND_GL_DST_COLOR               (36)
+#       define R300_BLEND_GL_ONE_MINUS_DST_COLOR     (37)
+#       define R300_BLEND_GL_SRC_ALPHA               (38)
+#       define R300_BLEND_GL_ONE_MINUS_SRC_ALPHA     (39)
+#       define R300_BLEND_GL_DST_ALPHA               (40)
+#       define R300_BLEND_GL_ONE_MINUS_DST_ALPHA     (41)
+#       define R300_BLEND_GL_SRC_ALPHA_SATURATE      (42)
+#       define R300_BLEND_GL_CONST_COLOR             (43)
+#       define R300_BLEND_GL_ONE_MINUS_CONST_COLOR   (44)
+#       define R300_BLEND_GL_CONST_ALPHA             (45)
+#       define R300_BLEND_GL_ONE_MINUS_CONST_ALPHA   (46)
+#       define R300_BLEND_MASK                       (63)
+#       define R300_SRC_BLEND_SHIFT                  (16)
+#       define R300_DST_BLEND_SHIFT                  (24)
+#define R300_RB3D_BLEND_COLOR               0x4E10
+#define R300_RB3D_COLORMASK                 0x4E0C
+#       define R300_COLORMASK0_B                 (1<<0)
+#       define R300_COLORMASK0_G                 (1<<1)
+#       define R300_COLORMASK0_R                 (1<<2)
+#       define R300_COLORMASK0_A                 (1<<3)
+
+/* gap */
+
+#define R300_RB3D_COLOROFFSET0              0x4E28
+#       define R300_COLOROFFSET_MASK             0xFFFFFFF0 /* GUESS */
+#define R300_RB3D_COLOROFFSET1              0x4E2C /* GUESS */
+#define R300_RB3D_COLOROFFSET2              0x4E30 /* GUESS */
+#define R300_RB3D_COLOROFFSET3              0x4E34 /* GUESS */
+
+/* gap */
+
+/* Bit 16: Larger tiles
+ * Bit 17: 4x2 tiles
+ * Bit 18: Extremely weird tile like, but some pixels duplicated?
+ */
+#define R300_RB3D_COLORPITCH0               0x4E38
+#       define R300_COLORPITCH_MASK              0x00001FF8 /* GUESS */
+#       define R300_COLOR_TILE_ENABLE            (1 << 16) /* GUESS */
+#       define R300_COLOR_MICROTILE_ENABLE       (1 << 17) /* GUESS */
+#       define R300_COLOR_MICROTILE_SQUARE_ENABLE (2 << 17)
+#       define R300_COLOR_ENDIAN_NO_SWAP         (0 << 18) /* GUESS */
+#       define R300_COLOR_ENDIAN_WORD_SWAP       (1 << 18) /* GUESS */
+#       define R300_COLOR_ENDIAN_DWORD_SWAP      (2 << 18) /* GUESS */
+#       define R300_COLOR_FORMAT_RGB565          (2 << 22)
+#       define R300_COLOR_FORMAT_ARGB8888        (3 << 22)
+#define R300_RB3D_COLORPITCH1               0x4E3C /* GUESS */
+#define R300_RB3D_COLORPITCH2               0x4E40 /* GUESS */
+#define R300_RB3D_COLORPITCH3               0x4E44 /* GUESS */
+
+#define R300_RB3D_AARESOLVE_OFFSET          0x4E80
+#define R300_RB3D_AARESOLVE_PITCH           0x4E84
+#define R300_RB3D_AARESOLVE_CTL             0x4E88
+/* gap */
+
+/* Guess by Vladimir.
+ * Set to 0A before 3D operations, set to 02 afterwards.
+ */
+/*#define R300_RB3D_DSTCACHE_CTLSTAT          0x4E4C*/
+#       define R300_RB3D_DSTCACHE_UNKNOWN_02             0x00000002
+#       define R300_RB3D_DSTCACHE_UNKNOWN_0A             0x0000000A
+
+/* gap */
+/* There seems to be no "write only" setting, so use Z-test = ALWAYS
+ * for this.
+ * Bit (1<<8) is the "test" bit. so plain write is 6  - vd
+ */
+#define R300_ZB_CNTL                             0x4F00
+#	define R300_STENCIL_ENABLE		 (1 << 0)
+#	define R300_Z_ENABLE		         (1 << 1)
+#	define R300_Z_WRITE_ENABLE		 (1 << 2)
+#	define R300_Z_SIGNED_COMPARE		 (1 << 3)
+#	define R300_STENCIL_FRONT_BACK		 (1 << 4)
+
+#define R300_ZB_ZSTENCILCNTL                   0x4f04
+	/* functions */
+#	define R300_ZS_NEVER			0
+#	define R300_ZS_LESS			1
+#	define R300_ZS_LEQUAL			2
+#	define R300_ZS_EQUAL			3
+#	define R300_ZS_GEQUAL			4
+#	define R300_ZS_GREATER			5
+#	define R300_ZS_NOTEQUAL			6
+#	define R300_ZS_ALWAYS			7
+#       define R300_ZS_MASK                     7
+	/* operations */
+#	define R300_ZS_KEEP			0
+#	define R300_ZS_ZERO			1
+#	define R300_ZS_REPLACE			2
+#	define R300_ZS_INCR			3
+#	define R300_ZS_DECR			4
+#	define R300_ZS_INVERT			5
+#	define R300_ZS_INCR_WRAP		6
+#	define R300_ZS_DECR_WRAP		7
+#	define R300_Z_FUNC_SHIFT		0
+	/* front and back refer to operations done for front
+	   and back faces, i.e. separate stencil function support */
+#	define R300_S_FRONT_FUNC_SHIFT	        3
+#	define R300_S_FRONT_SFAIL_OP_SHIFT	6
+#	define R300_S_FRONT_ZPASS_OP_SHIFT	9
+#	define R300_S_FRONT_ZFAIL_OP_SHIFT      12
+#	define R300_S_BACK_FUNC_SHIFT           15
+#	define R300_S_BACK_SFAIL_OP_SHIFT       18
+#	define R300_S_BACK_ZPASS_OP_SHIFT       21
+#	define R300_S_BACK_ZFAIL_OP_SHIFT       24
+
+#define R300_ZB_STENCILREFMASK                        0x4f08
+#	define R300_STENCILREF_SHIFT       0
+#	define R300_STENCILREF_MASK        0x000000ff
+#	define R300_STENCILMASK_SHIFT      8
+#	define R300_STENCILMASK_MASK       0x0000ff00
+#	define R300_STENCILWRITEMASK_SHIFT 16
+#	define R300_STENCILWRITEMASK_MASK  0x00ff0000
+
+/* gap */
+
+#define R300_ZB_FORMAT                             0x4f10
+#	define R300_DEPTHFORMAT_16BIT_INT_Z   (0 << 0)
+#	define R300_DEPTHFORMAT_16BIT_13E3    (1 << 0)
+#	define R300_DEPTHFORMAT_24BIT_INT_Z_8BIT_STENCIL   (2 << 0)
+/* reserved up to (15 << 0) */
+#	define R300_INVERT_13E3_LEADING_ONES  (0 << 4)
+#	define R300_INVERT_13E3_LEADING_ZEROS (1 << 4)
+
+#define R300_ZB_ZTOP                             0x4F14
+#	define R300_ZTOP_DISABLE                 (0 << 0)
+#	define R300_ZTOP_ENABLE                  (1 << 0)
+
+/* gap */
+
+#define R300_ZB_ZCACHE_CTLSTAT            0x4f18
+#       define R300_ZB_ZCACHE_CTLSTAT_ZC_FLUSH_NO_EFFECT      (0 << 0)
+#       define R300_ZB_ZCACHE_CTLSTAT_ZC_FLUSH_FLUSH_AND_FREE (1 << 0)
+#       define R300_ZB_ZCACHE_CTLSTAT_ZC_FREE_NO_EFFECT       (0 << 1)
+#       define R300_ZB_ZCACHE_CTLSTAT_ZC_FREE_FREE            (1 << 1)
+#       define R300_ZB_ZCACHE_CTLSTAT_ZC_BUSY_IDLE            (0 << 31)
+#       define R300_ZB_ZCACHE_CTLSTAT_ZC_BUSY_BUSY            (1 << 31)
+
+#define R300_ZB_BW_CNTL                     0x4f1c
+#	define R300_HIZ_DISABLE                              (0 << 0)
+#	define R300_HIZ_ENABLE                               (1 << 0)
+#	define R300_HIZ_MIN                                  (0 << 1)
+#	define R300_HIZ_MAX                                  (1 << 1)
+#	define R300_FAST_FILL_DISABLE                        (0 << 2)
+#	define R300_FAST_FILL_ENABLE                         (1 << 2)
+#	define R300_RD_COMP_DISABLE                          (0 << 3)
+#	define R300_RD_COMP_ENABLE                           (1 << 3)
+#	define R300_WR_COMP_DISABLE                          (0 << 4)
+#	define R300_WR_COMP_ENABLE                           (1 << 4)
+#	define R300_ZB_CB_CLEAR_RMW                          (0 << 5)
+#	define R300_ZB_CB_CLEAR_CACHE_LINEAR                 (1 << 5)
+#	define R300_FORCE_COMPRESSED_STENCIL_VALUE_DISABLE   (0 << 6)
+#	define R300_FORCE_COMPRESSED_STENCIL_VALUE_ENABLE    (1 << 6)
+
+#	define R500_ZEQUAL_OPTIMIZE_ENABLE                   (0 << 7)
+#	define R500_ZEQUAL_OPTIMIZE_DISABLE                  (1 << 7)
+#	define R500_SEQUAL_OPTIMIZE_ENABLE                   (0 << 8)
+#	define R500_SEQUAL_OPTIMIZE_DISABLE                  (1 << 8)
+
+#	define R500_BMASK_ENABLE                             (0 << 10)
+#	define R500_BMASK_DISABLE                            (1 << 10)
+#	define R500_HIZ_EQUAL_REJECT_DISABLE                 (0 << 11)
+#	define R500_HIZ_EQUAL_REJECT_ENABLE                  (1 << 11)
+#	define R500_HIZ_FP_EXP_BITS_DISABLE                  (0 << 12)
+#	define R500_HIZ_FP_EXP_BITS_1                        (1 << 12)
+#	define R500_HIZ_FP_EXP_BITS_2                        (2 << 12)
+#	define R500_HIZ_FP_EXP_BITS_3                        (3 << 12)
+#	define R500_HIZ_FP_EXP_BITS_4                        (4 << 12)
+#	define R500_HIZ_FP_EXP_BITS_5                        (5 << 12)
+#	define R500_HIZ_FP_INVERT_LEADING_ONES               (0 << 15)
+#	define R500_HIZ_FP_INVERT_LEADING_ZEROS              (1 << 15)
+#	define R500_TILE_OVERWRITE_RECOMPRESSION_ENABLE      (0 << 16)
+#	define R500_TILE_OVERWRITE_RECOMPRESSION_DISABLE     (1 << 16)
+#	define R500_CONTIGUOUS_6XAA_SAMPLES_ENABLE           (0 << 17)
+#	define R500_CONTIGUOUS_6XAA_SAMPLES_DISABLE          (1 << 17)
+#	define R500_PEQ_PACKING_DISABLE                      (0 << 18)
+#	define R500_PEQ_PACKING_ENABLE                       (1 << 18)
+#	define R500_COVERED_PTR_MASKING_DISABLE              (0 << 18)
+#	define R500_COVERED_PTR_MASKING_ENABLE               (1 << 18)
+
+
+/* gap */
+
+/* Z Buffer Address Offset.
+ * Bits 31 to 5 are used for aligned Z buffer address offset for macro tiles.
+ */
+#define R300_ZB_DEPTHOFFSET               0x4f20
+
+/* Z Buffer Pitch and Endian Control */
+#define R300_ZB_DEPTHPITCH                0x4f24
+#       define R300_DEPTHPITCH_MASK              0x00003FFC
+#       define R300_DEPTHMACROTILE_DISABLE      (0 << 16)
+#       define R300_DEPTHMACROTILE_ENABLE       (1 << 16)
+#       define R300_DEPTHMICROTILE_LINEAR       (0 << 17)
+#       define R300_DEPTHMICROTILE_TILED        (1 << 17)
+#       define R300_DEPTHMICROTILE_TILED_SQUARE (2 << 17)
+#       define R300_DEPTHENDIAN_NO_SWAP         (0 << 18)
+#       define R300_DEPTHENDIAN_WORD_SWAP       (1 << 18)
+#       define R300_DEPTHENDIAN_DWORD_SWAP      (2 << 18)
+#       define R300_DEPTHENDIAN_HALF_DWORD_SWAP (3 << 18)
+
+/* Z Buffer Clear Value */
+#define R300_ZB_DEPTHCLEARVALUE                  0x4f28
+
+#define R300_ZB_ZMASK_OFFSET			 0x4f30
+#define R300_ZB_ZMASK_PITCH			 0x4f34
+#define R300_ZB_ZMASK_WRINDEX			 0x4f38
+#define R300_ZB_ZMASK_DWORD			 0x4f3c
+#define R300_ZB_ZMASK_RDINDEX			 0x4f40
+
+/* Hierarchical Z Memory Offset */
+#define R300_ZB_HIZ_OFFSET                       0x4f44
+
+/* Hierarchical Z Write Index */
+#define R300_ZB_HIZ_WRINDEX                      0x4f48
+
+/* Hierarchical Z Data */
+#define R300_ZB_HIZ_DWORD                        0x4f4c
+
+/* Hierarchical Z Read Index */
+#define R300_ZB_HIZ_RDINDEX                      0x4f50
+
+/* Hierarchical Z Pitch */
+#define R300_ZB_HIZ_PITCH                        0x4f54
+
+/* Z Buffer Z Pass Counter Data */
+#define R300_ZB_ZPASS_DATA                       0x4f58
+
+/* Z Buffer Z Pass Counter Address */
+#define R300_ZB_ZPASS_ADDR                       0x4f5c
+
+/* Depth buffer X and Y coordinate offset */
+#define R300_ZB_DEPTHXY_OFFSET                   0x4f60
+#	define R300_DEPTHX_OFFSET_SHIFT  1
+#	define R300_DEPTHX_OFFSET_MASK   0x000007FE
+#	define R300_DEPTHY_OFFSET_SHIFT  17
+#	define R300_DEPTHY_OFFSET_MASK   0x07FE0000
+
+/* Sets the fifo sizes */
+#define R500_ZB_FIFO_SIZE                        0x4fd0
+#	define R500_OP_FIFO_SIZE_FULL   (0 << 0)
+#	define R500_OP_FIFO_SIZE_HALF   (1 << 0)
+#	define R500_OP_FIFO_SIZE_QUATER (2 << 0)
+#	define R500_OP_FIFO_SIZE_EIGTHS (4 << 0)
+
+/* Stencil Reference Value and Mask for backfacing quads */
+/* R300_ZB_STENCILREFMASK handles front face */
+#define R500_ZB_STENCILREFMASK_BF                0x4fd4
+#	define R500_STENCILREF_SHIFT       0
+#	define R500_STENCILREF_MASK        0x000000ff
+#	define R500_STENCILMASK_SHIFT      8
+#	define R500_STENCILMASK_MASK       0x0000ff00
+#	define R500_STENCILWRITEMASK_SHIFT 16
+#	define R500_STENCILWRITEMASK_MASK  0x00ff0000
+
+/* BEGIN: Vertex program instruction set */
+
+/* Every instruction is four dwords long:
+ *  DWORD 0: output and opcode
+ *  DWORD 1: first argument
+ *  DWORD 2: second argument
+ *  DWORD 3: third argument
+ *
+ * Notes:
+ *  - ABS r, a is implemented as MAX r, a, -a
+ *  - MOV is implemented as ADD to zero
+ *  - XPD is implemented as MUL + MAD
+ *  - FLR is implemented as FRC + ADD
+ *  - apparently, fglrx tries to schedule instructions so that there is at
+ *    least one instruction between the write to a temporary and the first
+ *    read from said temporary; however, violations of this scheduling are
+ *    allowed
+ *  - register indices seem to be unrelated with OpenGL aliasing to
+ *    conventional state
+ *  - only one attribute and one parameter can be loaded at a time; however,
+ *    the same attribute/parameter can be used for more than one argument
+ *  - the second software argument for POW is the third hardware argument
+ *    (no idea why)
+ *  - MAD with only temporaries as input seems to use VPI_OUT_SELECT_MAD_2
+ *
+ * There is some magic surrounding LIT:
+ *   The single argument is replicated across all three inputs, but swizzled:
+ *     First argument: xyzy
+ *     Second argument: xyzx
+ *     Third argument: xyzw
+ *   Whenever the result is used later in the fragment program, fglrx forces
+ *   x and w to be 1.0 in the input selection; I don't know whether this is
+ *   strictly necessary
+ */
+#define R300_VPI_OUT_OP_DOT                     (1 << 0)
+#define R300_VPI_OUT_OP_MUL                     (2 << 0)
+#define R300_VPI_OUT_OP_ADD                     (3 << 0)
+#define R300_VPI_OUT_OP_MAD                     (4 << 0)
+#define R300_VPI_OUT_OP_DST                     (5 << 0)
+#define R300_VPI_OUT_OP_FRC                     (6 << 0)
+#define R300_VPI_OUT_OP_MAX                     (7 << 0)
+#define R300_VPI_OUT_OP_MIN                     (8 << 0)
+#define R300_VPI_OUT_OP_SGE                     (9 << 0)
+#define R300_VPI_OUT_OP_SLT                     (10 << 0)
+	/* Used in GL_POINT_DISTANCE_ATTENUATION_ARB, vector(scalar, vector) */
+#define R300_VPI_OUT_OP_UNK12                   (12 << 0)
+#define R300_VPI_OUT_OP_ARL                     (13 << 0)
+#define R300_VPI_OUT_OP_EXP                     (65 << 0)
+#define R300_VPI_OUT_OP_LOG                     (66 << 0)
+	/* Used in fog computations, scalar(scalar) */
+#define R300_VPI_OUT_OP_UNK67                   (67 << 0)
+#define R300_VPI_OUT_OP_LIT                     (68 << 0)
+#define R300_VPI_OUT_OP_POW                     (69 << 0)
+#define R300_VPI_OUT_OP_RCP                     (70 << 0)
+#define R300_VPI_OUT_OP_RSQ                     (72 << 0)
+	/* Used in GL_POINT_DISTANCE_ATTENUATION_ARB, scalar(scalar) */
+#define R300_VPI_OUT_OP_UNK73                   (73 << 0)
+#define R300_VPI_OUT_OP_EX2                     (75 << 0)
+#define R300_VPI_OUT_OP_LG2                     (76 << 0)
+#define R300_VPI_OUT_OP_MAD_2                   (128 << 0)
+	/* all temps, vector(scalar, vector, vector) */
+#define R300_VPI_OUT_OP_UNK129                  (129 << 0)
+
+#define R300_VPI_OUT_REG_CLASS_TEMPORARY        (0 << 8)
+#define R300_VPI_OUT_REG_CLASS_ADDR             (1 << 8)
+#define R300_VPI_OUT_REG_CLASS_RESULT           (2 << 8)
+#define R300_VPI_OUT_REG_CLASS_MASK             (31 << 8)
+
+#define R300_VPI_OUT_REG_INDEX_SHIFT            13
+	/* GUESS based on fglrx native limits */
+#define R300_VPI_OUT_REG_INDEX_MASK             (31 << 13)
+
+#define R300_VPI_OUT_WRITE_X                    (1 << 20)
+#define R300_VPI_OUT_WRITE_Y                    (1 << 21)
+#define R300_VPI_OUT_WRITE_Z                    (1 << 22)
+#define R300_VPI_OUT_WRITE_W                    (1 << 23)
+
+#define R300_VPI_IN_REG_CLASS_TEMPORARY         (0 << 0)
+#define R300_VPI_IN_REG_CLASS_ATTRIBUTE         (1 << 0)
+#define R300_VPI_IN_REG_CLASS_PARAMETER         (2 << 0)
+#define R300_VPI_IN_REG_CLASS_NONE              (9 << 0)
+#define R300_VPI_IN_REG_CLASS_MASK              (31 << 0)
+
+#define R300_VPI_IN_REG_INDEX_SHIFT             5
+	/* GUESS based on fglrx native limits */
+#define R300_VPI_IN_REG_INDEX_MASK              (255 << 5)
+
+/* The R300 can select components from the input register arbitrarily.
+ * Use the following constants, shifted by the component shift you
+ * want to select
+ */
+#define R300_VPI_IN_SELECT_X    0
+#define R300_VPI_IN_SELECT_Y    1
+#define R300_VPI_IN_SELECT_Z    2
+#define R300_VPI_IN_SELECT_W    3
+#define R300_VPI_IN_SELECT_ZERO 4
+#define R300_VPI_IN_SELECT_ONE  5
+#define R300_VPI_IN_SELECT_MASK 7
+
+#define R300_VPI_IN_X_SHIFT                     13
+#define R300_VPI_IN_Y_SHIFT                     16
+#define R300_VPI_IN_Z_SHIFT                     19
+#define R300_VPI_IN_W_SHIFT                     22
+
+#define R300_VPI_IN_NEG_X                       (1 << 25)
+#define R300_VPI_IN_NEG_Y                       (1 << 26)
+#define R300_VPI_IN_NEG_Z                       (1 << 27)
+#define R300_VPI_IN_NEG_W                       (1 << 28)
+/* END: Vertex program instruction set */
+
+/* BEGIN: Packet 3 commands */
+
+/* A primitive emission dword. */
+#define R300_PRIM_TYPE_NONE                     (0 << 0)
+#define R300_PRIM_TYPE_POINT                    (1 << 0)
+#define R300_PRIM_TYPE_LINE                     (2 << 0)
+#define R300_PRIM_TYPE_LINE_STRIP               (3 << 0)
+#define R300_PRIM_TYPE_TRI_LIST                 (4 << 0)
+#define R300_PRIM_TYPE_TRI_FAN                  (5 << 0)
+#define R300_PRIM_TYPE_TRI_STRIP                (6 << 0)
+#define R300_PRIM_TYPE_TRI_TYPE2                (7 << 0)
+#define R300_PRIM_TYPE_RECT_LIST                (8 << 0)
+#define R300_PRIM_TYPE_3VRT_POINT_LIST          (9 << 0)
+#define R300_PRIM_TYPE_3VRT_LINE_LIST           (10 << 0)
+	/* GUESS (based on r200) */
+#define R300_PRIM_TYPE_POINT_SPRITES            (11 << 0)
+#define R300_PRIM_TYPE_LINE_LOOP                (12 << 0)
+#define R300_PRIM_TYPE_QUADS                    (13 << 0)
+#define R300_PRIM_TYPE_QUAD_STRIP               (14 << 0)
+#define R300_PRIM_TYPE_POLYGON                  (15 << 0)
+#define R300_PRIM_TYPE_MASK                     0xF
+#define R300_PRIM_WALK_IND                      (1 << 4)
+#define R300_PRIM_WALK_LIST                     (2 << 4)
+#define R300_PRIM_WALK_RING                     (3 << 4)
+#define R300_PRIM_WALK_MASK                     (3 << 4)
+	/* GUESS (based on r200) */
+#define R300_PRIM_COLOR_ORDER_BGRA              (0 << 6)
+#define R300_PRIM_COLOR_ORDER_RGBA              (1 << 6)
+#define R300_PRIM_NUM_VERTICES_SHIFT            16
+#define R300_PRIM_NUM_VERTICES_MASK             0xffff
+
+/* Draw a primitive from vertex data in arrays loaded via 3D_LOAD_VBPNTR.
+ * Two parameter dwords:
+ * 0. The first parameter appears to be always 0
+ * 1. The second parameter is a standard primitive emission dword.
+ */
+#define R300_PACKET3_3D_DRAW_VBUF           0x00002800
+
+/* Specify the full set of vertex arrays as (address, stride).
+ * The first parameter is the number of vertex arrays specified.
+ * The rest of the command is a variable length list of blocks, where
+ * each block is three dwords long and specifies two arrays.
+ * The first dword of a block is split into two words, the lower significant
+ * word refers to the first array, the more significant word to the second
+ * array in the block.
+ * The low byte of each word contains the size of an array entry in dwords,
+ * the high byte contains the stride of the array.
+ * The second dword of a block contains the pointer to the first array,
+ * the third dword of a block contains the pointer to the second array.
+ * Note that if the total number of arrays is odd, the third dword of
+ * the last block is omitted.
+ */
+#define R300_PACKET3_3D_LOAD_VBPNTR         0x00002F00
+
+#define R300_PACKET3_INDX_BUFFER            0x00003300
+#    define R300_EB_UNK1_SHIFT                      24
+#    define R300_EB_UNK1                    (0x80<<24)
+#    define R300_EB_UNK2                        0x0810
+#define R300_PACKET3_3D_DRAW_VBUF_2         0x00003400
+#define R300_PACKET3_3D_DRAW_INDX_2         0x00003600
+
+/* END: Packet 3 commands */
+
+
+/* Color formats for 2d packets
+ */
+#define R300_CP_COLOR_FORMAT_CI8	2
+#define R300_CP_COLOR_FORMAT_ARGB1555	3
+#define R300_CP_COLOR_FORMAT_RGB565	4
+#define R300_CP_COLOR_FORMAT_ARGB8888	6
+#define R300_CP_COLOR_FORMAT_RGB332	7
+#define R300_CP_COLOR_FORMAT_RGB8	9
+#define R300_CP_COLOR_FORMAT_ARGB4444	15
+
+/*
+ * CP type-3 packets
+ */
+#define R300_CP_CMD_BITBLT_MULTI	0xC0009B00
+
+#define R500_VAP_INDEX_OFFSET		0x208c
+
+#define R500_GA_US_VECTOR_INDEX         0x4250
+#define R500_GA_US_VECTOR_DATA          0x4254
+
+#define R500_RS_IP_0                    0x4074
+#define R500_RS_INST_0                  0x4320
+
+#define R500_US_CONFIG                  0x4600
+
+#define R500_US_FC_CTRL			0x4624
+#define R500_US_CODE_ADDR		0x4630
+
+#define R500_RB3D_COLOR_CLEAR_VALUE_AR  0x46c0
+#define R500_RB3D_CONSTANT_COLOR_AR     0x4ef8
+
+#define R300_SU_REG_DEST                0x42c8
+#define RV530_FG_ZBREG_DEST             0x4be8
+#define R300_ZB_ZPASS_DATA              0x4f58
+#define R300_ZB_ZPASS_ADDR              0x4f5c
+
+#endif /* _R300_REG_H */
diff --git a/hw/display/r300d.h b/hw/display/r300d.h
new file mode 100644
index 0000000000..ff229a00d2
--- /dev/null
+++ b/hw/display/r300d.h
@@ -0,0 +1,343 @@
+/*
+ * Copyright 2008 Advanced Micro Devices, Inc.
+ * Copyright 2008 Red Hat Inc.
+ * Copyright 2009 Jerome Glisse.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Dave Airlie
+ *          Alex Deucher
+ *          Jerome Glisse
+ */
+#ifndef __R300D_H__
+#define __R300D_H__
+
+#define CP_PACKET0			0x00000000
+#define		PACKET0_BASE_INDEX_SHIFT	0
+#define		PACKET0_BASE_INDEX_MASK		(0x1ffff << 0)
+#define		PACKET0_COUNT_SHIFT		16
+#define		PACKET0_COUNT_MASK		(0x3fff << 16)
+#define CP_PACKET1			0x40000000
+#define CP_PACKET2			0x80000000
+#define		PACKET2_PAD_SHIFT		0
+#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
+#define CP_PACKET3			0xC0000000
+#define		PACKET3_IT_OPCODE_SHIFT		8
+#define		PACKET3_IT_OPCODE_MASK		(0xff << 8)
+#define		PACKET3_COUNT_SHIFT		16
+#define		PACKET3_COUNT_MASK		(0x3fff << 16)
+/* PACKET3 op code */
+#define		PACKET3_NOP			0x10
+#define		PACKET3_3D_DRAW_VBUF		0x28
+#define		PACKET3_3D_DRAW_IMMD		0x29
+#define		PACKET3_3D_DRAW_INDX		0x2A
+#define		PACKET3_3D_LOAD_VBPNTR		0x2F
+#define		PACKET3_3D_CLEAR_ZMASK		0x32
+#define		PACKET3_INDX_BUFFER		0x33
+#define		PACKET3_3D_DRAW_VBUF_2		0x34
+#define		PACKET3_3D_DRAW_IMMD_2		0x35
+#define		PACKET3_3D_DRAW_INDX_2		0x36
+#define		PACKET3_3D_CLEAR_HIZ		0x37
+#define		PACKET3_3D_CLEAR_CMASK		0x38
+#define		PACKET3_BITBLT_MULTI		0x9B
+
+#define PACKET0(reg, n)	(CP_PACKET0 |					\
+			 REG_SET(PACKET0_BASE_INDEX, (reg) >> 2) |	\
+			 REG_SET(PACKET0_COUNT, (n)))
+#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
+#define PACKET3(op, n)	(CP_PACKET3 |					\
+			 REG_SET(PACKET3_IT_OPCODE, (op)) |		\
+			 REG_SET(PACKET3_COUNT, (n)))
+
+/* Registers */
+#define R_000148_MC_FB_LOCATION                      0x000148
+#define   S_000148_MC_FB_START(x)                      (((x) & 0xFFFF) << 0)
+#define   G_000148_MC_FB_START(x)                      (((x) >> 0) & 0xFFFF)
+#define   C_000148_MC_FB_START                         0xFFFF0000
+#define   S_000148_MC_FB_TOP(x)                        (((x) & 0xFFFF) << 16)
+#define   G_000148_MC_FB_TOP(x)                        (((x) >> 16) & 0xFFFF)
+#define   C_000148_MC_FB_TOP                           0x0000FFFF
+#define R_00014C_MC_AGP_LOCATION                     0x00014C
+#define   S_00014C_MC_AGP_START(x)                     (((x) & 0xFFFF) << 0)
+#define   G_00014C_MC_AGP_START(x)                     (((x) >> 0) & 0xFFFF)
+#define   C_00014C_MC_AGP_START                        0xFFFF0000
+#define   S_00014C_MC_AGP_TOP(x)                       (((x) & 0xFFFF) << 16)
+#define   G_00014C_MC_AGP_TOP(x)                       (((x) >> 16) & 0xFFFF)
+#define   C_00014C_MC_AGP_TOP                          0x0000FFFF
+#define R_00015C_AGP_BASE_2                          0x00015C
+#define   S_00015C_AGP_BASE_ADDR_2(x)                  (((x) & 0xF) << 0)
+#define   G_00015C_AGP_BASE_ADDR_2(x)                  (((x) >> 0) & 0xF)
+#define   C_00015C_AGP_BASE_ADDR_2                     0xFFFFFFF0
+#define R_000170_AGP_BASE                            0x000170
+#define   S_000170_AGP_BASE_ADDR(x)                    (((x) & 0xFFFFFFFF) << 0)
+#define   G_000170_AGP_BASE_ADDR(x)                    (((x) >> 0) & 0xFFFFFFFF)
+#define   C_000170_AGP_BASE_ADDR                       0x00000000
+#define R_0007C0_CP_STAT                             0x0007C0
+#define   S_0007C0_MRU_BUSY(x)                         (((x) & 0x1) << 0)
+#define   G_0007C0_MRU_BUSY(x)                         (((x) >> 0) & 0x1)
+#define   C_0007C0_MRU_BUSY                            0xFFFFFFFE
+#define   S_0007C0_MWU_BUSY(x)                         (((x) & 0x1) << 1)
+#define   G_0007C0_MWU_BUSY(x)                         (((x) >> 1) & 0x1)
+#define   C_0007C0_MWU_BUSY                            0xFFFFFFFD
+#define   S_0007C0_RSIU_BUSY(x)                        (((x) & 0x1) << 2)
+#define   G_0007C0_RSIU_BUSY(x)                        (((x) >> 2) & 0x1)
+#define   C_0007C0_RSIU_BUSY                           0xFFFFFFFB
+#define   S_0007C0_RCIU_BUSY(x)                        (((x) & 0x1) << 3)
+#define   G_0007C0_RCIU_BUSY(x)                        (((x) >> 3) & 0x1)
+#define   C_0007C0_RCIU_BUSY                           0xFFFFFFF7
+#define   S_0007C0_CSF_PRIMARY_BUSY(x)                 (((x) & 0x1) << 9)
+#define   G_0007C0_CSF_PRIMARY_BUSY(x)                 (((x) >> 9) & 0x1)
+#define   C_0007C0_CSF_PRIMARY_BUSY                    0xFFFFFDFF
+#define   S_0007C0_CSF_INDIRECT_BUSY(x)                (((x) & 0x1) << 10)
+#define   G_0007C0_CSF_INDIRECT_BUSY(x)                (((x) >> 10) & 0x1)
+#define   C_0007C0_CSF_INDIRECT_BUSY                   0xFFFFFBFF
+#define   S_0007C0_CSQ_PRIMARY_BUSY(x)                 (((x) & 0x1) << 11)
+#define   G_0007C0_CSQ_PRIMARY_BUSY(x)                 (((x) >> 11) & 0x1)
+#define   C_0007C0_CSQ_PRIMARY_BUSY                    0xFFFFF7FF
+#define   S_0007C0_CSQ_INDIRECT_BUSY(x)                (((x) & 0x1) << 12)
+#define   G_0007C0_CSQ_INDIRECT_BUSY(x)                (((x) >> 12) & 0x1)
+#define   C_0007C0_CSQ_INDIRECT_BUSY                   0xFFFFEFFF
+#define   S_0007C0_CSI_BUSY(x)                         (((x) & 0x1) << 13)
+#define   G_0007C0_CSI_BUSY(x)                         (((x) >> 13) & 0x1)
+#define   C_0007C0_CSI_BUSY                            0xFFFFDFFF
+#define   S_0007C0_CSF_INDIRECT2_BUSY(x)               (((x) & 0x1) << 14)
+#define   G_0007C0_CSF_INDIRECT2_BUSY(x)               (((x) >> 14) & 0x1)
+#define   C_0007C0_CSF_INDIRECT2_BUSY                  0xFFFFBFFF
+#define   S_0007C0_CSQ_INDIRECT2_BUSY(x)               (((x) & 0x1) << 15)
+#define   G_0007C0_CSQ_INDIRECT2_BUSY(x)               (((x) >> 15) & 0x1)
+#define   C_0007C0_CSQ_INDIRECT2_BUSY                  0xFFFF7FFF
+#define   S_0007C0_GUIDMA_BUSY(x)                      (((x) & 0x1) << 28)
+#define   G_0007C0_GUIDMA_BUSY(x)                      (((x) >> 28) & 0x1)
+#define   C_0007C0_GUIDMA_BUSY                         0xEFFFFFFF
+#define   S_0007C0_VIDDMA_BUSY(x)                      (((x) & 0x1) << 29)
+#define   G_0007C0_VIDDMA_BUSY(x)                      (((x) >> 29) & 0x1)
+#define   C_0007C0_VIDDMA_BUSY                         0xDFFFFFFF
+#define   S_0007C0_CMDSTRM_BUSY(x)                     (((x) & 0x1) << 30)
+#define   G_0007C0_CMDSTRM_BUSY(x)                     (((x) >> 30) & 0x1)
+#define   C_0007C0_CMDSTRM_BUSY                        0xBFFFFFFF
+#define   S_0007C0_CP_BUSY(x)                          (((x) & 0x1) << 31)
+#define   G_0007C0_CP_BUSY(x)                          (((x) >> 31) & 0x1)
+#define   C_0007C0_CP_BUSY                             0x7FFFFFFF
+#define R_000E40_RBBM_STATUS                         0x000E40
+#define   S_000E40_CMDFIFO_AVAIL(x)                    (((x) & 0x7F) << 0)
+#define   G_000E40_CMDFIFO_AVAIL(x)                    (((x) >> 0) & 0x7F)
+#define   C_000E40_CMDFIFO_AVAIL                       0xFFFFFF80
+#define   S_000E40_HIRQ_ON_RBB(x)                      (((x) & 0x1) << 8)
+#define   G_000E40_HIRQ_ON_RBB(x)                      (((x) >> 8) & 0x1)
+#define   C_000E40_HIRQ_ON_RBB                         0xFFFFFEFF
+#define   S_000E40_CPRQ_ON_RBB(x)                      (((x) & 0x1) << 9)
+#define   G_000E40_CPRQ_ON_RBB(x)                      (((x) >> 9) & 0x1)
+#define   C_000E40_CPRQ_ON_RBB                         0xFFFFFDFF
+#define   S_000E40_CFRQ_ON_RBB(x)                      (((x) & 0x1) << 10)
+#define   G_000E40_CFRQ_ON_RBB(x)                      (((x) >> 10) & 0x1)
+#define   C_000E40_CFRQ_ON_RBB                         0xFFFFFBFF
+#define   S_000E40_HIRQ_IN_RTBUF(x)                    (((x) & 0x1) << 11)
+#define   G_000E40_HIRQ_IN_RTBUF(x)                    (((x) >> 11) & 0x1)
+#define   C_000E40_HIRQ_IN_RTBUF                       0xFFFFF7FF
+#define   S_000E40_CPRQ_IN_RTBUF(x)                    (((x) & 0x1) << 12)
+#define   G_000E40_CPRQ_IN_RTBUF(x)                    (((x) >> 12) & 0x1)
+#define   C_000E40_CPRQ_IN_RTBUF                       0xFFFFEFFF
+#define   S_000E40_CFRQ_IN_RTBUF(x)                    (((x) & 0x1) << 13)
+#define   G_000E40_CFRQ_IN_RTBUF(x)                    (((x) >> 13) & 0x1)
+#define   C_000E40_CFRQ_IN_RTBUF                       0xFFFFDFFF
+#define   S_000E40_CF_PIPE_BUSY(x)                     (((x) & 0x1) << 14)
+#define   G_000E40_CF_PIPE_BUSY(x)                     (((x) >> 14) & 0x1)
+#define   C_000E40_CF_PIPE_BUSY                        0xFFFFBFFF
+#define   S_000E40_ENG_EV_BUSY(x)                      (((x) & 0x1) << 15)
+#define   G_000E40_ENG_EV_BUSY(x)                      (((x) >> 15) & 0x1)
+#define   C_000E40_ENG_EV_BUSY                         0xFFFF7FFF
+#define   S_000E40_CP_CMDSTRM_BUSY(x)                  (((x) & 0x1) << 16)
+#define   G_000E40_CP_CMDSTRM_BUSY(x)                  (((x) >> 16) & 0x1)
+#define   C_000E40_CP_CMDSTRM_BUSY                     0xFFFEFFFF
+#define   S_000E40_E2_BUSY(x)                          (((x) & 0x1) << 17)
+#define   G_000E40_E2_BUSY(x)                          (((x) >> 17) & 0x1)
+#define   C_000E40_E2_BUSY                             0xFFFDFFFF
+#define   S_000E40_RB2D_BUSY(x)                        (((x) & 0x1) << 18)
+#define   G_000E40_RB2D_BUSY(x)                        (((x) >> 18) & 0x1)
+#define   C_000E40_RB2D_BUSY                           0xFFFBFFFF
+#define   S_000E40_RB3D_BUSY(x)                        (((x) & 0x1) << 19)
+#define   G_000E40_RB3D_BUSY(x)                        (((x) >> 19) & 0x1)
+#define   C_000E40_RB3D_BUSY                           0xFFF7FFFF
+#define   S_000E40_VAP_BUSY(x)                         (((x) & 0x1) << 20)
+#define   G_000E40_VAP_BUSY(x)                         (((x) >> 20) & 0x1)
+#define   C_000E40_VAP_BUSY                            0xFFEFFFFF
+#define   S_000E40_RE_BUSY(x)                          (((x) & 0x1) << 21)
+#define   G_000E40_RE_BUSY(x)                          (((x) >> 21) & 0x1)
+#define   C_000E40_RE_BUSY                             0xFFDFFFFF
+#define   S_000E40_TAM_BUSY(x)                         (((x) & 0x1) << 22)
+#define   G_000E40_TAM_BUSY(x)                         (((x) >> 22) & 0x1)
+#define   C_000E40_TAM_BUSY                            0xFFBFFFFF
+#define   S_000E40_TDM_BUSY(x)                         (((x) & 0x1) << 23)
+#define   G_000E40_TDM_BUSY(x)                         (((x) >> 23) & 0x1)
+#define   C_000E40_TDM_BUSY                            0xFF7FFFFF
+#define   S_000E40_PB_BUSY(x)                          (((x) & 0x1) << 24)
+#define   G_000E40_PB_BUSY(x)                          (((x) >> 24) & 0x1)
+#define   C_000E40_PB_BUSY                             0xFEFFFFFF
+#define   S_000E40_TIM_BUSY(x)                         (((x) & 0x1) << 25)
+#define   G_000E40_TIM_BUSY(x)                         (((x) >> 25) & 0x1)
+#define   C_000E40_TIM_BUSY                            0xFDFFFFFF
+#define   S_000E40_GA_BUSY(x)                          (((x) & 0x1) << 26)
+#define   G_000E40_GA_BUSY(x)                          (((x) >> 26) & 0x1)
+#define   C_000E40_GA_BUSY                             0xFBFFFFFF
+#define   S_000E40_CBA2D_BUSY(x)                       (((x) & 0x1) << 27)
+#define   G_000E40_CBA2D_BUSY(x)                       (((x) >> 27) & 0x1)
+#define   C_000E40_CBA2D_BUSY                          0xF7FFFFFF
+#define   S_000E40_GUI_ACTIVE(x)                       (((x) & 0x1) << 31)
+#define   G_000E40_GUI_ACTIVE(x)                       (((x) >> 31) & 0x1)
+#define   C_000E40_GUI_ACTIVE                          0x7FFFFFFF
+#define R_0000F0_RBBM_SOFT_RESET                     0x0000F0
+#define   S_0000F0_SOFT_RESET_CP(x)                    (((x) & 0x1) << 0)
+#define   G_0000F0_SOFT_RESET_CP(x)                    (((x) >> 0) & 0x1)
+#define   C_0000F0_SOFT_RESET_CP                       0xFFFFFFFE
+#define   S_0000F0_SOFT_RESET_HI(x)                    (((x) & 0x1) << 1)
+#define   G_0000F0_SOFT_RESET_HI(x)                    (((x) >> 1) & 0x1)
+#define   C_0000F0_SOFT_RESET_HI                       0xFFFFFFFD
+#define   S_0000F0_SOFT_RESET_VAP(x)                   (((x) & 0x1) << 2)
+#define   G_0000F0_SOFT_RESET_VAP(x)                   (((x) >> 2) & 0x1)
+#define   C_0000F0_SOFT_RESET_VAP                      0xFFFFFFFB
+#define   S_0000F0_SOFT_RESET_RE(x)                    (((x) & 0x1) << 3)
+#define   G_0000F0_SOFT_RESET_RE(x)                    (((x) >> 3) & 0x1)
+#define   C_0000F0_SOFT_RESET_RE                       0xFFFFFFF7
+#define   S_0000F0_SOFT_RESET_PP(x)                    (((x) & 0x1) << 4)
+#define   G_0000F0_SOFT_RESET_PP(x)                    (((x) >> 4) & 0x1)
+#define   C_0000F0_SOFT_RESET_PP                       0xFFFFFFEF
+#define   S_0000F0_SOFT_RESET_E2(x)                    (((x) & 0x1) << 5)
+#define   G_0000F0_SOFT_RESET_E2(x)                    (((x) >> 5) & 0x1)
+#define   C_0000F0_SOFT_RESET_E2                       0xFFFFFFDF
+#define   S_0000F0_SOFT_RESET_RB(x)                    (((x) & 0x1) << 6)
+#define   G_0000F0_SOFT_RESET_RB(x)                    (((x) >> 6) & 0x1)
+#define   C_0000F0_SOFT_RESET_RB                       0xFFFFFFBF
+#define   S_0000F0_SOFT_RESET_HDP(x)                   (((x) & 0x1) << 7)
+#define   G_0000F0_SOFT_RESET_HDP(x)                   (((x) >> 7) & 0x1)
+#define   C_0000F0_SOFT_RESET_HDP                      0xFFFFFF7F
+#define   S_0000F0_SOFT_RESET_MC(x)                    (((x) & 0x1) << 8)
+#define   G_0000F0_SOFT_RESET_MC(x)                    (((x) >> 8) & 0x1)
+#define   C_0000F0_SOFT_RESET_MC                       0xFFFFFEFF
+#define   S_0000F0_SOFT_RESET_AIC(x)                   (((x) & 0x1) << 9)
+#define   G_0000F0_SOFT_RESET_AIC(x)                   (((x) >> 9) & 0x1)
+#define   C_0000F0_SOFT_RESET_AIC                      0xFFFFFDFF
+#define   S_0000F0_SOFT_RESET_VIP(x)                   (((x) & 0x1) << 10)
+#define   G_0000F0_SOFT_RESET_VIP(x)                   (((x) >> 10) & 0x1)
+#define   C_0000F0_SOFT_RESET_VIP                      0xFFFFFBFF
+#define   S_0000F0_SOFT_RESET_DISP(x)                  (((x) & 0x1) << 11)
+#define   G_0000F0_SOFT_RESET_DISP(x)                  (((x) >> 11) & 0x1)
+#define   C_0000F0_SOFT_RESET_DISP                     0xFFFFF7FF
+#define   S_0000F0_SOFT_RESET_CG(x)                    (((x) & 0x1) << 12)
+#define   G_0000F0_SOFT_RESET_CG(x)                    (((x) >> 12) & 0x1)
+#define   C_0000F0_SOFT_RESET_CG                       0xFFFFEFFF
+#define   S_0000F0_SOFT_RESET_GA(x)                    (((x) & 0x1) << 13)
+#define   G_0000F0_SOFT_RESET_GA(x)                    (((x) >> 13) & 0x1)
+#define   C_0000F0_SOFT_RESET_GA                       0xFFFFDFFF
+#define   S_0000F0_SOFT_RESET_IDCT(x)                  (((x) & 0x1) << 14)
+#define   G_0000F0_SOFT_RESET_IDCT(x)                  (((x) >> 14) & 0x1)
+#define   C_0000F0_SOFT_RESET_IDCT                     0xFFFFBFFF
+
+#define R_00000D_SCLK_CNTL                           0x00000D
+#define   S_00000D_SCLK_SRC_SEL(x)                     (((x) & 0x7) << 0)
+#define   G_00000D_SCLK_SRC_SEL(x)                     (((x) >> 0) & 0x7)
+#define   C_00000D_SCLK_SRC_SEL                        0xFFFFFFF8
+#define   S_00000D_CP_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 3)
+#define   G_00000D_CP_MAX_DYN_STOP_LAT(x)              (((x) >> 3) & 0x1)
+#define   C_00000D_CP_MAX_DYN_STOP_LAT                 0xFFFFFFF7
+#define   S_00000D_HDP_MAX_DYN_STOP_LAT(x)             (((x) & 0x1) << 4)
+#define   G_00000D_HDP_MAX_DYN_STOP_LAT(x)             (((x) >> 4) & 0x1)
+#define   C_00000D_HDP_MAX_DYN_STOP_LAT                0xFFFFFFEF
+#define   S_00000D_TV_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 5)
+#define   G_00000D_TV_MAX_DYN_STOP_LAT(x)              (((x) >> 5) & 0x1)
+#define   C_00000D_TV_MAX_DYN_STOP_LAT                 0xFFFFFFDF
+#define   S_00000D_E2_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 6)
+#define   G_00000D_E2_MAX_DYN_STOP_LAT(x)              (((x) >> 6) & 0x1)
+#define   C_00000D_E2_MAX_DYN_STOP_LAT                 0xFFFFFFBF
+#define   S_00000D_SE_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 7)
+#define   G_00000D_SE_MAX_DYN_STOP_LAT(x)              (((x) >> 7) & 0x1)
+#define   C_00000D_SE_MAX_DYN_STOP_LAT                 0xFFFFFF7F
+#define   S_00000D_IDCT_MAX_DYN_STOP_LAT(x)            (((x) & 0x1) << 8)
+#define   G_00000D_IDCT_MAX_DYN_STOP_LAT(x)            (((x) >> 8) & 0x1)
+#define   C_00000D_IDCT_MAX_DYN_STOP_LAT               0xFFFFFEFF
+#define   S_00000D_VIP_MAX_DYN_STOP_LAT(x)             (((x) & 0x1) << 9)
+#define   G_00000D_VIP_MAX_DYN_STOP_LAT(x)             (((x) >> 9) & 0x1)
+#define   C_00000D_VIP_MAX_DYN_STOP_LAT                0xFFFFFDFF
+#define   S_00000D_RE_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 10)
+#define   G_00000D_RE_MAX_DYN_STOP_LAT(x)              (((x) >> 10) & 0x1)
+#define   C_00000D_RE_MAX_DYN_STOP_LAT                 0xFFFFFBFF
+#define   S_00000D_PB_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 11)
+#define   G_00000D_PB_MAX_DYN_STOP_LAT(x)              (((x) >> 11) & 0x1)
+#define   C_00000D_PB_MAX_DYN_STOP_LAT                 0xFFFFF7FF
+#define   S_00000D_TAM_MAX_DYN_STOP_LAT(x)             (((x) & 0x1) << 12)
+#define   G_00000D_TAM_MAX_DYN_STOP_LAT(x)             (((x) >> 12) & 0x1)
+#define   C_00000D_TAM_MAX_DYN_STOP_LAT                0xFFFFEFFF
+#define   S_00000D_TDM_MAX_DYN_STOP_LAT(x)             (((x) & 0x1) << 13)
+#define   G_00000D_TDM_MAX_DYN_STOP_LAT(x)             (((x) >> 13) & 0x1)
+#define   C_00000D_TDM_MAX_DYN_STOP_LAT                0xFFFFDFFF
+#define   S_00000D_RB_MAX_DYN_STOP_LAT(x)              (((x) & 0x1) << 14)
+#define   G_00000D_RB_MAX_DYN_STOP_LAT(x)              (((x) >> 14) & 0x1)
+#define   C_00000D_RB_MAX_DYN_STOP_LAT                 0xFFFFBFFF
+#define   S_00000D_FORCE_DISP2(x)                      (((x) & 0x1) << 15)
+#define   G_00000D_FORCE_DISP2(x)                      (((x) >> 15) & 0x1)
+#define   C_00000D_FORCE_DISP2                         0xFFFF7FFF
+#define   S_00000D_FORCE_CP(x)                         (((x) & 0x1) << 16)
+#define   G_00000D_FORCE_CP(x)                         (((x) >> 16) & 0x1)
+#define   C_00000D_FORCE_CP                            0xFFFEFFFF
+#define   S_00000D_FORCE_HDP(x)                        (((x) & 0x1) << 17)
+#define   G_00000D_FORCE_HDP(x)                        (((x) >> 17) & 0x1)
+#define   C_00000D_FORCE_HDP                           0xFFFDFFFF
+#define   S_00000D_FORCE_DISP1(x)                      (((x) & 0x1) << 18)
+#define   G_00000D_FORCE_DISP1(x)                      (((x) >> 18) & 0x1)
+#define   C_00000D_FORCE_DISP1                         0xFFFBFFFF
+#define   S_00000D_FORCE_TOP(x)                        (((x) & 0x1) << 19)
+#define   G_00000D_FORCE_TOP(x)                        (((x) >> 19) & 0x1)
+#define   C_00000D_FORCE_TOP                           0xFFF7FFFF
+#define   S_00000D_FORCE_E2(x)                         (((x) & 0x1) << 20)
+#define   G_00000D_FORCE_E2(x)                         (((x) >> 20) & 0x1)
+#define   C_00000D_FORCE_E2                            0xFFEFFFFF
+#define   S_00000D_FORCE_SE(x)                         (((x) & 0x1) << 21)
+#define   G_00000D_FORCE_SE(x)                         (((x) >> 21) & 0x1)
+#define   C_00000D_FORCE_SE                            0xFFDFFFFF
+#define   S_00000D_FORCE_IDCT(x)                       (((x) & 0x1) << 22)
+#define   G_00000D_FORCE_IDCT(x)                       (((x) >> 22) & 0x1)
+#define   C_00000D_FORCE_IDCT                          0xFFBFFFFF
+#define   S_00000D_FORCE_VIP(x)                        (((x) & 0x1) << 23)
+#define   G_00000D_FORCE_VIP(x)                        (((x) >> 23) & 0x1)
+#define   C_00000D_FORCE_VIP                           0xFF7FFFFF
+#define   S_00000D_FORCE_RE(x)                         (((x) & 0x1) << 24)
+#define   G_00000D_FORCE_RE(x)                         (((x) >> 24) & 0x1)
+#define   C_00000D_FORCE_RE                            0xFEFFFFFF
+#define   S_00000D_FORCE_PB(x)                         (((x) & 0x1) << 25)
+#define   G_00000D_FORCE_PB(x)                         (((x) >> 25) & 0x1)
+#define   C_00000D_FORCE_PB                            0xFDFFFFFF
+#define   S_00000D_FORCE_TAM(x)                        (((x) & 0x1) << 26)
+#define   G_00000D_FORCE_TAM(x)                        (((x) >> 26) & 0x1)
+#define   C_00000D_FORCE_TAM                           0xFBFFFFFF
+#define   S_00000D_FORCE_TDM(x)                        (((x) & 0x1) << 27)
+#define   G_00000D_FORCE_TDM(x)                        (((x) >> 27) & 0x1)
+#define   C_00000D_FORCE_TDM                           0xF7FFFFFF
+#define   S_00000D_FORCE_RB(x)                         (((x) & 0x1) << 28)
+#define   G_00000D_FORCE_RB(x)                         (((x) >> 28) & 0x1)
+#define   C_00000D_FORCE_RB                            0xEFFFFFFF
+#define   S_00000D_FORCE_TV_SCLK(x)                    (((x) & 0x1) << 29)
+#define   G_00000D_FORCE_TV_SCLK(x)                    (((x) >> 29) & 0x1)
+#define   C_00000D_FORCE_TV_SCLK                       0xDFFFFFFF
+#define   S_00000D_FORCE_SUBPIC(x)                     (((x) & 0x1) << 30)
+#define   G_00000D_FORCE_SUBPIC(x)                     (((x) >> 30) & 0x1)
+#define   C_00000D_FORCE_SUBPIC                        0xBFFFFFFF
+#define   S_00000D_FORCE_OV0(x)                        (((x) & 0x1) << 31)
+#define   G_00000D_FORCE_OV0(x)                        (((x) >> 31) & 0x1)
+#define   C_00000D_FORCE_OV0                           0x7FFFFFFF
+
+#endif
diff --git a/hw/display/r500_reg.h b/hw/display/r500_reg.h
new file mode 100644
index 0000000000..136b7bc7cd
--- /dev/null
+++ b/hw/display/r500_reg.h
@@ -0,0 +1,801 @@
+/*
+ * Copyright 2008 Advanced Micro Devices, Inc.
+ * Copyright 2008 Red Hat Inc.
+ * Copyright 2009 Jerome Glisse.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Dave Airlie
+ *          Alex Deucher
+ *          Jerome Glisse
+ */
+#ifndef __R500_REG_H__
+#define __R500_REG_H__
+
+/* pipe config regs */
+#define R300_GA_POLY_MODE				0x4288
+#       define R300_FRONT_PTYPE_POINT                   (0 << 4)
+#       define R300_FRONT_PTYPE_LINE                    (1 << 4)
+#       define R300_FRONT_PTYPE_TRIANGE                 (2 << 4)
+#       define R300_BACK_PTYPE_POINT                    (0 << 7)
+#       define R300_BACK_PTYPE_LINE                     (1 << 7)
+#       define R300_BACK_PTYPE_TRIANGE                  (2 << 7)
+#define R300_GA_ROUND_MODE				0x428c
+#       define R300_GEOMETRY_ROUND_TRUNC                (0 << 0)
+#       define R300_GEOMETRY_ROUND_NEAREST              (1 << 0)
+#       define R300_COLOR_ROUND_TRUNC                   (0 << 2)
+#       define R300_COLOR_ROUND_NEAREST                 (1 << 2)
+#define R300_GB_MSPOS0				        0x4010
+#       define R300_MS_X0_SHIFT                         0
+#       define R300_MS_Y0_SHIFT                         4
+#       define R300_MS_X1_SHIFT                         8
+#       define R300_MS_Y1_SHIFT                         12
+#       define R300_MS_X2_SHIFT                         16
+#       define R300_MS_Y2_SHIFT                         20
+#       define R300_MSBD0_Y_SHIFT                       24
+#       define R300_MSBD0_X_SHIFT                       28
+#define R300_GB_MSPOS1				        0x4014
+#       define R300_MS_X3_SHIFT                         0
+#       define R300_MS_Y3_SHIFT                         4
+#       define R300_MS_X4_SHIFT                         8
+#       define R300_MS_Y4_SHIFT                         12
+#       define R300_MS_X5_SHIFT                         16
+#       define R300_MS_Y5_SHIFT                         20
+#       define R300_MSBD1_SHIFT                         24
+
+#define R300_GA_ENHANCE				        0x4274
+#       define R300_GA_DEADLOCK_CNTL                    (1 << 0)
+#       define R300_GA_FASTSYNC_CNTL                    (1 << 1)
+#define R300_RB3D_DSTCACHE_CTLSTAT              0x4e4c
+#	define R300_RB3D_DC_FLUSH		(2 << 0)
+#	define R300_RB3D_DC_FREE		(2 << 2)
+#	define R300_RB3D_DC_FINISH		(1 << 4)
+#define R300_RB3D_ZCACHE_CTLSTAT			0x4f18
+#       define R300_ZC_FLUSH                            (1 << 0)
+#       define R300_ZC_FREE                             (1 << 1)
+#       define R300_ZC_FLUSH_ALL                        0x3
+#define R400_GB_PIPE_SELECT             0x402c
+#define R500_DYN_SCLK_PWMEM_PIPE        0x000d /* PLL */
+#define R500_SU_REG_DEST                0x42c8
+#define R300_GB_TILE_CONFIG             0x4018
+#       define R300_ENABLE_TILING       (1 << 0)
+#       define R300_PIPE_COUNT_RV350    (0 << 1)
+#       define R300_PIPE_COUNT_R300     (3 << 1)
+#       define R300_PIPE_COUNT_R420_3P  (6 << 1)
+#       define R300_PIPE_COUNT_R420     (7 << 1)
+#       define R300_TILE_SIZE_8         (0 << 4)
+#       define R300_TILE_SIZE_16        (1 << 4)
+#       define R300_TILE_SIZE_32        (2 << 4)
+#       define R300_SUBPIXEL_1_12       (0 << 16)
+#       define R300_SUBPIXEL_1_16       (1 << 16)
+#define R300_DST_PIPE_CONFIG            0x170c
+#       define R300_PIPE_AUTO_CONFIG    (1 << 31)
+#define R300_RB2D_DSTCACHE_MODE         0x3428
+#       define R300_DC_AUTOFLUSH_ENABLE (1 << 8)
+#       define R300_DC_DC_DISABLE_IGNORE_PE (1 << 17)
+
+#define RADEON_CP_STAT		0x7C0
+#define RADEON_RBBM_CMDFIFO_ADDR	0xE70
+#define RADEON_RBBM_CMDFIFO_DATA	0xE74
+#define RADEON_ISYNC_CNTL		0x1724
+#	define RADEON_ISYNC_ANY2D_IDLE3D	(1 << 0)
+#	define RADEON_ISYNC_ANY3D_IDLE2D	(1 << 1)
+#	define RADEON_ISYNC_TRIG2D_IDLE3D	(1 << 2)
+#	define RADEON_ISYNC_TRIG3D_IDLE2D	(1 << 3)
+#	define RADEON_ISYNC_WAIT_IDLEGUI	(1 << 4)
+#	define RADEON_ISYNC_CPSCRATCH_IDLEGUI	(1 << 5)
+
+#define RS480_NB_MC_INDEX               0x168
+#	define RS480_NB_MC_IND_WR_EN	(1 << 8)
+#define RS480_NB_MC_DATA                0x16c
+
+/*
+ * RS690
+ */
+#define RS690_MCCFG_FB_LOCATION		0x100
+#define		RS690_MC_FB_START_MASK		0x0000FFFF
+#define		RS690_MC_FB_START_SHIFT		0
+#define		RS690_MC_FB_TOP_MASK		0xFFFF0000
+#define		RS690_MC_FB_TOP_SHIFT		16
+#define RS690_MCCFG_AGP_LOCATION	0x101
+#define		RS690_MC_AGP_START_MASK		0x0000FFFF
+#define		RS690_MC_AGP_START_SHIFT	0
+#define		RS690_MC_AGP_TOP_MASK		0xFFFF0000
+#define		RS690_MC_AGP_TOP_SHIFT		16
+#define RS690_MCCFG_AGP_BASE		0x102
+#define RS690_MCCFG_AGP_BASE_2		0x103
+#define RS690_MC_INIT_MISC_LAT_TIMER            0x104
+#define RS690_HDP_FB_LOCATION		0x0134
+#define RS690_MC_INDEX				0x78
+#	define RS690_MC_INDEX_MASK		0x1ff
+#	define RS690_MC_INDEX_WR_EN		(1 << 9)
+#	define RS690_MC_INDEX_WR_ACK		0x7f
+#define RS690_MC_DATA				0x7c
+#define RS690_MC_STATUS                         0x90
+#define RS690_MC_STATUS_IDLE                    (1 << 0)
+#define RS480_AGP_BASE_2		0x0164
+#define RS480_MC_MISC_CNTL              0x18
+#	define RS480_DISABLE_GTW	(1 << 1)
+#	define RS480_GART_INDEX_REG_EN	(1 << 12)
+#	define RS690_BLOCK_GFX_D3_EN	(1 << 14)
+#define RS480_GART_FEATURE_ID           0x2b
+#	define RS480_HANG_EN	        (1 << 11)
+#	define RS480_TLB_ENABLE	        (1 << 18)
+#	define RS480_P2P_ENABLE	        (1 << 19)
+#	define RS480_GTW_LAC_EN	        (1 << 25)
+#	define RS480_2LEVEL_GART	(0 << 30)
+#	define RS480_1LEVEL_GART	(1 << 30)
+#	define RS480_PDC_EN	        (1 << 31)
+#define RS480_GART_BASE                 0x2c
+#define RS480_GART_CACHE_CNTRL          0x2e
+#	define RS480_GART_CACHE_INVALIDATE (1 << 0) /* wait for it to clear */
+#define RS480_AGP_ADDRESS_SPACE_SIZE    0x38
+#	define RS480_GART_EN	        (1 << 0)
+#	define RS480_VA_SIZE_32MB	(0 << 1)
+#	define RS480_VA_SIZE_64MB	(1 << 1)
+#	define RS480_VA_SIZE_128MB	(2 << 1)
+#	define RS480_VA_SIZE_256MB	(3 << 1)
+#	define RS480_VA_SIZE_512MB	(4 << 1)
+#	define RS480_VA_SIZE_1GB	(5 << 1)
+#	define RS480_VA_SIZE_2GB	(6 << 1)
+#define RS480_AGP_MODE_CNTL             0x39
+#	define RS480_POST_GART_Q_SIZE	(1 << 18)
+#	define RS480_NONGART_SNOOP	(1 << 19)
+#	define RS480_AGP_RD_BUF_SIZE	(1 << 20)
+#	define RS480_REQ_TYPE_SNOOP_SHIFT 22
+#	define RS480_REQ_TYPE_SNOOP_MASK  0x3
+#	define RS480_REQ_TYPE_SNOOP_DIS	(1 << 24)
+
+#define RS690_AIC_CTRL_SCRATCH		0x3A
+#	define RS690_DIS_OUT_OF_PCI_GART_ACCESS	(1 << 1)
+
+/*
+ * RS600
+ */
+#define RS600_MC_STATUS                         0x0
+#define RS600_MC_STATUS_IDLE                    (1 << 0)
+#define RS600_MC_INDEX                          0x70
+#       define RS600_MC_ADDR_MASK               0xffff
+#       define RS600_MC_IND_SEQ_RBS_0           (1 << 16)
+#       define RS600_MC_IND_SEQ_RBS_1           (1 << 17)
+#       define RS600_MC_IND_SEQ_RBS_2           (1 << 18)
+#       define RS600_MC_IND_SEQ_RBS_3           (1 << 19)
+#       define RS600_MC_IND_AIC_RBS             (1 << 20)
+#       define RS600_MC_IND_CITF_ARB0           (1 << 21)
+#       define RS600_MC_IND_CITF_ARB1           (1 << 22)
+#       define RS600_MC_IND_WR_EN               (1 << 23)
+#define RS600_MC_DATA                           0x74
+#define RS600_MC_STATUS                         0x0
+#       define RS600_MC_IDLE                    (1 << 1)
+#define RS600_MC_FB_LOCATION                    0x4
+#define		RS600_MC_FB_START_MASK		0x0000FFFF
+#define		RS600_MC_FB_START_SHIFT		0
+#define		RS600_MC_FB_TOP_MASK		0xFFFF0000
+#define		RS600_MC_FB_TOP_SHIFT		16
+#define RS600_MC_AGP_LOCATION                   0x5
+#define		RS600_MC_AGP_START_MASK		0x0000FFFF
+#define		RS600_MC_AGP_START_SHIFT	0
+#define		RS600_MC_AGP_TOP_MASK		0xFFFF0000
+#define		RS600_MC_AGP_TOP_SHIFT		16
+#define RS600_MC_AGP_BASE                          0x6
+#define RS600_MC_AGP_BASE_2                        0x7
+#define RS600_MC_CNTL1                          0x9
+#       define RS600_ENABLE_PAGE_TABLES         (1 << 26)
+#define RS600_MC_PT0_CNTL                       0x100
+#       define RS600_ENABLE_PT                  (1 << 0)
+#       define RS600_EFFECTIVE_L2_CACHE_SIZE(x) ((x) << 15)
+#       define RS600_EFFECTIVE_L2_QUEUE_SIZE(x) ((x) << 21)
+#       define RS600_INVALIDATE_ALL_L1_TLBS     (1 << 28)
+#       define RS600_INVALIDATE_L2_CACHE        (1 << 29)
+#define RS600_MC_PT0_CONTEXT0_CNTL              0x102
+#       define RS600_ENABLE_PAGE_TABLE          (1 << 0)
+#       define RS600_PAGE_TABLE_TYPE_FLAT       (0 << 1)
+#define RS600_MC_PT0_SYSTEM_APERTURE_LOW_ADDR   0x112
+#define RS600_MC_PT0_SYSTEM_APERTURE_HIGH_ADDR  0x114
+#define RS600_MC_PT0_CONTEXT0_DEFAULT_READ_ADDR 0x11c
+#define RS600_MC_PT0_CONTEXT0_FLAT_BASE_ADDR    0x12c
+#define RS600_MC_PT0_CONTEXT0_FLAT_START_ADDR   0x13c
+#define RS600_MC_PT0_CONTEXT0_FLAT_END_ADDR     0x14c
+#define RS600_MC_PT0_CLIENT0_CNTL               0x16c
+#       define RS600_ENABLE_TRANSLATION_MODE_OVERRIDE       (1 << 0)
+#       define RS600_TRANSLATION_MODE_OVERRIDE              (1 << 1)
+#       define RS600_SYSTEM_ACCESS_MODE_MASK                (3 << 8)
+#       define RS600_SYSTEM_ACCESS_MODE_PA_ONLY             (0 << 8)
+#       define RS600_SYSTEM_ACCESS_MODE_USE_SYS_MAP         (1 << 8)
+#       define RS600_SYSTEM_ACCESS_MODE_IN_SYS              (2 << 8)
+#       define RS600_SYSTEM_ACCESS_MODE_NOT_IN_SYS          (3 << 8)
+#       define RS600_SYSTEM_APERTURE_UNMAPPED_ACCESS_PASSTHROUGH        (0 << 10)
+#       define RS600_SYSTEM_APERTURE_UNMAPPED_ACCESS_DEFAULT_PAGE       (1 << 10)
+#       define RS600_EFFECTIVE_L1_CACHE_SIZE(x) ((x) << 11)
+#       define RS600_ENABLE_FRAGMENT_PROCESSING (1 << 14)
+#       define RS600_EFFECTIVE_L1_QUEUE_SIZE(x) ((x) << 15)
+#       define RS600_INVALIDATE_L1_TLB          (1 << 20)
+/* rs600/rs690/rs740 */
+#	define RS600_BUS_MASTER_DIS		(1 << 14)
+#	define RS600_MSI_REARM		        (1 << 20)
+/* see RS400_MSI_REARM in AIC_CNTL for rs480 */
+
+
+
+#define RV515_MC_FB_LOCATION		0x01
+#define		RV515_MC_FB_START_MASK		0x0000FFFF
+#define		RV515_MC_FB_START_SHIFT		0
+#define		RV515_MC_FB_TOP_MASK		0xFFFF0000
+#define		RV515_MC_FB_TOP_SHIFT		16
+#define RV515_MC_AGP_LOCATION		0x02
+#define		RV515_MC_AGP_START_MASK		0x0000FFFF
+#define		RV515_MC_AGP_START_SHIFT	0
+#define		RV515_MC_AGP_TOP_MASK		0xFFFF0000
+#define		RV515_MC_AGP_TOP_SHIFT		16
+#define RV515_MC_AGP_BASE		0x03
+#define RV515_MC_AGP_BASE_2		0x04
+
+#define R520_MC_FB_LOCATION		0x04
+#define		R520_MC_FB_START_MASK		0x0000FFFF
+#define		R520_MC_FB_START_SHIFT		0
+#define		R520_MC_FB_TOP_MASK		0xFFFF0000
+#define		R520_MC_FB_TOP_SHIFT		16
+#define R520_MC_AGP_LOCATION		0x05
+#define		R520_MC_AGP_START_MASK		0x0000FFFF
+#define		R520_MC_AGP_START_SHIFT		0
+#define		R520_MC_AGP_TOP_MASK		0xFFFF0000
+#define		R520_MC_AGP_TOP_SHIFT		16
+#define R520_MC_AGP_BASE		0x06
+#define R520_MC_AGP_BASE_2		0x07
+
+
+#define AVIVO_MC_INDEX						0x0070
+#define R520_MC_STATUS 0x00
+#define R520_MC_STATUS_IDLE (1<<1)
+#define RV515_MC_STATUS 0x08
+#define RV515_MC_STATUS_IDLE (1<<4)
+#define RV515_MC_INIT_MISC_LAT_TIMER            0x09
+#define AVIVO_MC_DATA						0x0074
+
+#define R520_MC_IND_INDEX 0x70
+#define R520_MC_IND_WR_EN (1 << 24)
+#define R520_MC_IND_DATA  0x74
+
+#define RV515_MC_CNTL          0x5
+#	define RV515_MEM_NUM_CHANNELS_MASK  0x3
+#define R520_MC_CNTL0          0x8
+#	define R520_MEM_NUM_CHANNELS_MASK  (0x3 << 24)
+#	define R520_MEM_NUM_CHANNELS_SHIFT  24
+#	define R520_MC_CHANNEL_SIZE  (1 << 23)
+
+#define AVIVO_CP_DYN_CNTL                              0x000f /* PLL */
+#       define AVIVO_CP_FORCEON                        (1 << 0)
+#define AVIVO_E2_DYN_CNTL                              0x0011 /* PLL */
+#       define AVIVO_E2_FORCEON                        (1 << 0)
+#define AVIVO_IDCT_DYN_CNTL                            0x0013 /* PLL */
+#       define AVIVO_IDCT_FORCEON                      (1 << 0)
+
+#define AVIVO_HDP_FB_LOCATION 0x134
+
+#define AVIVO_VGA_RENDER_CONTROL				0x0300
+#       define AVIVO_VGA_VSTATUS_CNTL_MASK                      (3 << 16)
+#define AVIVO_D1VGA_CONTROL					0x0330
+#       define AVIVO_DVGA_CONTROL_MODE_ENABLE (1<<0)
+#       define AVIVO_DVGA_CONTROL_TIMING_SELECT (1<<8)
+#       define AVIVO_DVGA_CONTROL_SYNC_POLARITY_SELECT (1<<9)
+#       define AVIVO_DVGA_CONTROL_OVERSCAN_TIMING_SELECT (1<<10)
+#       define AVIVO_DVGA_CONTROL_OVERSCAN_COLOR_EN (1<<16)
+#       define AVIVO_DVGA_CONTROL_ROTATE (1<<24)
+#define AVIVO_D2VGA_CONTROL					0x0338
+
+#define AVIVO_EXT1_PPLL_REF_DIV_SRC                             0x400
+#define AVIVO_EXT1_PPLL_REF_DIV                                 0x404
+#define AVIVO_EXT1_PPLL_UPDATE_LOCK                             0x408
+#define AVIVO_EXT1_PPLL_UPDATE_CNTL                             0x40c
+
+#define AVIVO_EXT2_PPLL_REF_DIV_SRC                             0x410
+#define AVIVO_EXT2_PPLL_REF_DIV                                 0x414
+#define AVIVO_EXT2_PPLL_UPDATE_LOCK                             0x418
+#define AVIVO_EXT2_PPLL_UPDATE_CNTL                             0x41c
+
+#define AVIVO_EXT1_PPLL_FB_DIV                                   0x430
+#define AVIVO_EXT2_PPLL_FB_DIV                                   0x434
+
+#define AVIVO_EXT1_PPLL_POST_DIV_SRC                                 0x438
+#define AVIVO_EXT1_PPLL_POST_DIV                                     0x43c
+
+#define AVIVO_EXT2_PPLL_POST_DIV_SRC                                 0x440
+#define AVIVO_EXT2_PPLL_POST_DIV                                     0x444
+
+#define AVIVO_EXT1_PPLL_CNTL                                    0x448
+#define AVIVO_EXT2_PPLL_CNTL                                    0x44c
+
+#define AVIVO_P1PLL_CNTL                                        0x450
+#define AVIVO_P2PLL_CNTL                                        0x454
+#define AVIVO_P1PLL_INT_SS_CNTL                                 0x458
+#define AVIVO_P2PLL_INT_SS_CNTL                                 0x45c
+#define AVIVO_P1PLL_TMDSA_CNTL                                  0x460
+#define AVIVO_P2PLL_LVTMA_CNTL                                  0x464
+
+#define AVIVO_PCLK_CRTC1_CNTL                                   0x480
+#define AVIVO_PCLK_CRTC2_CNTL                                   0x484
+
+#define AVIVO_D1CRTC_H_TOTAL					0x6000
+#define AVIVO_D1CRTC_H_BLANK_START_END                          0x6004
+#define AVIVO_D1CRTC_H_SYNC_A                                   0x6008
+#define AVIVO_D1CRTC_H_SYNC_A_CNTL                              0x600c
+#define AVIVO_D1CRTC_H_SYNC_B                                   0x6010
+#define AVIVO_D1CRTC_H_SYNC_B_CNTL                              0x6014
+
+#define AVIVO_D1CRTC_V_TOTAL					0x6020
+#define AVIVO_D1CRTC_V_BLANK_START_END                          0x6024
+#define AVIVO_D1CRTC_V_SYNC_A                                   0x6028
+#define AVIVO_D1CRTC_V_SYNC_A_CNTL                              0x602c
+#define AVIVO_D1CRTC_V_SYNC_B                                   0x6030
+#define AVIVO_D1CRTC_V_SYNC_B_CNTL                              0x6034
+
+#define AVIVO_D1CRTC_CONTROL                                    0x6080
+#       define AVIVO_CRTC_EN                                    (1 << 0)
+#       define AVIVO_CRTC_DISP_READ_REQUEST_DISABLE             (1 << 24)
+#define AVIVO_D1CRTC_BLANK_CONTROL                              0x6084
+#define AVIVO_D1CRTC_INTERLACE_CONTROL                          0x6088
+#define AVIVO_D1CRTC_INTERLACE_STATUS                           0x608c
+#define AVIVO_D1CRTC_STATUS                                     0x609c
+#       define AVIVO_D1CRTC_V_BLANK                             (1 << 0)
+#define AVIVO_D1CRTC_STATUS_POSITION                            0x60a0
+#define AVIVO_D1CRTC_FRAME_COUNT                                0x60a4
+#define AVIVO_D1CRTC_STATUS_HV_COUNT                            0x60ac
+#define AVIVO_D1CRTC_STEREO_CONTROL                             0x60c4
+
+#define AVIVO_D1MODE_MASTER_UPDATE_LOCK                         0x60e0
+#define AVIVO_D1MODE_MASTER_UPDATE_MODE                         0x60e4
+#define AVIVO_D1CRTC_UPDATE_LOCK                                0x60e8
+
+/* master controls */
+#define AVIVO_DC_CRTC_MASTER_EN                                 0x60f8
+#define AVIVO_DC_CRTC_TV_CONTROL                                0x60fc
+
+#define AVIVO_D1GRPH_ENABLE                                     0x6100
+#define AVIVO_D1GRPH_CONTROL                                    0x6104
+#       define AVIVO_D1GRPH_CONTROL_DEPTH_8BPP                  (0 << 0)
+#       define AVIVO_D1GRPH_CONTROL_DEPTH_16BPP                 (1 << 0)
+#       define AVIVO_D1GRPH_CONTROL_DEPTH_32BPP                 (2 << 0)
+#       define AVIVO_D1GRPH_CONTROL_DEPTH_64BPP                 (3 << 0)
+
+#       define AVIVO_D1GRPH_CONTROL_8BPP_INDEXED                (0 << 8)
+
+#       define AVIVO_D1GRPH_CONTROL_16BPP_ARGB1555              (0 << 8)
+#       define AVIVO_D1GRPH_CONTROL_16BPP_RGB565                (1 << 8)
+#       define AVIVO_D1GRPH_CONTROL_16BPP_ARGB4444              (2 << 8)
+#       define AVIVO_D1GRPH_CONTROL_16BPP_AI88                  (3 << 8)
+#       define AVIVO_D1GRPH_CONTROL_16BPP_MONO16                (4 << 8)
+
+#       define AVIVO_D1GRPH_CONTROL_32BPP_ARGB8888              (0 << 8)
+#       define AVIVO_D1GRPH_CONTROL_32BPP_ARGB2101010           (1 << 8)
+#       define AVIVO_D1GRPH_CONTROL_32BPP_DIGITAL               (2 << 8)
+#       define AVIVO_D1GRPH_CONTROL_32BPP_8B_ARGB2101010        (3 << 8)
+
+
+#       define AVIVO_D1GRPH_CONTROL_64BPP_ARGB16161616          (0 << 8)
+
+#       define AVIVO_D1GRPH_SWAP_RB                             (1 << 16)
+#       define AVIVO_D1GRPH_TILED                               (1 << 20)
+#       define AVIVO_D1GRPH_MACRO_ADDRESS_MODE                  (1 << 21)
+
+#       define R600_D1GRPH_ARRAY_MODE_LINEAR_GENERAL            (0 << 20)
+#       define R600_D1GRPH_ARRAY_MODE_LINEAR_ALIGNED            (1 << 20)
+#       define R600_D1GRPH_ARRAY_MODE_1D_TILED_THIN1            (2 << 20)
+#       define R600_D1GRPH_ARRAY_MODE_2D_TILED_THIN1            (4 << 20)
+
+/* The R7xx *_HIGH surface regs are backwards; the D1 regs are in the D2
+ * block and vice versa.  This applies to GRPH, CUR, etc.
+ */
+#define AVIVO_D1GRPH_LUT_SEL                                    0x6108
+#       define AVIVO_LUT_10BIT_BYPASS_EN                        (1 << 8)
+#define AVIVO_D1GRPH_PRIMARY_SURFACE_ADDRESS                    0x6110
+#define R700_D1GRPH_PRIMARY_SURFACE_ADDRESS_HIGH                0x6914
+#define R700_D2GRPH_PRIMARY_SURFACE_ADDRESS_HIGH                0x6114
+#define AVIVO_D1GRPH_SECONDARY_SURFACE_ADDRESS                  0x6118
+#define R700_D1GRPH_SECONDARY_SURFACE_ADDRESS_HIGH              0x691c
+#define R700_D2GRPH_SECONDARY_SURFACE_ADDRESS_HIGH              0x611c
+#define AVIVO_D1GRPH_PITCH                                      0x6120
+#define AVIVO_D1GRPH_SURFACE_OFFSET_X                           0x6124
+#define AVIVO_D1GRPH_SURFACE_OFFSET_Y                           0x6128
+#define AVIVO_D1GRPH_X_START                                    0x612c
+#define AVIVO_D1GRPH_Y_START                                    0x6130
+#define AVIVO_D1GRPH_X_END                                      0x6134
+#define AVIVO_D1GRPH_Y_END                                      0x6138
+#define AVIVO_D1GRPH_UPDATE                                     0x6144
+#       define AVIVO_D1GRPH_SURFACE_UPDATE_PENDING              (1 << 2)
+#       define AVIVO_D1GRPH_UPDATE_LOCK                         (1 << 16)
+#define AVIVO_D1GRPH_FLIP_CONTROL                               0x6148
+#       define AVIVO_D1GRPH_SURFACE_UPDATE_H_RETRACE_EN         (1 << 0)
+
+#define AVIVO_D1CUR_CONTROL                     0x6400
+#       define AVIVO_D1CURSOR_EN                (1 << 0)
+#       define AVIVO_D1CURSOR_MODE_SHIFT        8
+#       define AVIVO_D1CURSOR_MODE_MASK         (3 << 8)
+#       define AVIVO_D1CURSOR_MODE_24BPP        2
+#define AVIVO_D1CUR_SURFACE_ADDRESS             0x6408
+#define R700_D1CUR_SURFACE_ADDRESS_HIGH         0x6c0c
+#define R700_D2CUR_SURFACE_ADDRESS_HIGH         0x640c
+#define AVIVO_D1CUR_SIZE                        0x6410
+#define AVIVO_D1CUR_POSITION                    0x6414
+#define AVIVO_D1CUR_HOT_SPOT                    0x6418
+#define AVIVO_D1CUR_UPDATE                      0x6424
+#       define AVIVO_D1CURSOR_UPDATE_LOCK       (1 << 16)
+
+#define AVIVO_DC_LUT_RW_SELECT                  0x6480
+#define AVIVO_DC_LUT_RW_MODE                    0x6484
+#define AVIVO_DC_LUT_RW_INDEX                   0x6488
+#define AVIVO_DC_LUT_SEQ_COLOR                  0x648c
+#define AVIVO_DC_LUT_PWL_DATA                   0x6490
+#define AVIVO_DC_LUT_30_COLOR                   0x6494
+#define AVIVO_DC_LUT_READ_PIPE_SELECT           0x6498
+#define AVIVO_DC_LUT_WRITE_EN_MASK              0x649c
+#define AVIVO_DC_LUT_AUTOFILL                   0x64a0
+
+#define AVIVO_DC_LUTA_CONTROL                   0x64c0
+#define AVIVO_DC_LUTA_BLACK_OFFSET_BLUE         0x64c4
+#define AVIVO_DC_LUTA_BLACK_OFFSET_GREEN        0x64c8
+#define AVIVO_DC_LUTA_BLACK_OFFSET_RED          0x64cc
+#define AVIVO_DC_LUTA_WHITE_OFFSET_BLUE         0x64d0
+#define AVIVO_DC_LUTA_WHITE_OFFSET_GREEN        0x64d4
+#define AVIVO_DC_LUTA_WHITE_OFFSET_RED          0x64d8
+
+#define AVIVO_DC_LB_MEMORY_SPLIT                0x6520
+#       define AVIVO_DC_LB_MEMORY_SPLIT_MASK    0x3
+#       define AVIVO_DC_LB_MEMORY_SPLIT_SHIFT   0
+#       define AVIVO_DC_LB_MEMORY_SPLIT_D1HALF_D2HALF  0
+#       define AVIVO_DC_LB_MEMORY_SPLIT_D1_3Q_D2_1Q    1
+#       define AVIVO_DC_LB_MEMORY_SPLIT_D1_ONLY        2
+#       define AVIVO_DC_LB_MEMORY_SPLIT_D1_1Q_D2_3Q    3
+#       define AVIVO_DC_LB_MEMORY_SPLIT_SHIFT_MODE (1 << 2)
+#       define AVIVO_DC_LB_DISP1_END_ADR_SHIFT  4
+#       define AVIVO_DC_LB_DISP1_END_ADR_MASK   0x7ff
+
+#define AVIVO_D1MODE_DATA_FORMAT                0x6528
+#       define AVIVO_D1MODE_INTERLEAVE_EN       (1 << 0)
+#define AVIVO_D1MODE_DESKTOP_HEIGHT             0x652C
+#define AVIVO_D1MODE_VBLANK_STATUS              0x6534
+#       define AVIVO_VBLANK_ACK                 (1 << 4)
+#define AVIVO_D1MODE_VLINE_START_END            0x6538
+#define AVIVO_D1MODE_VLINE_STATUS               0x653c
+#       define AVIVO_D1MODE_VLINE_STAT          (1 << 12)
+#define AVIVO_DxMODE_INT_MASK                   0x6540
+#       define AVIVO_D1MODE_INT_MASK            (1 << 0)
+#       define AVIVO_D2MODE_INT_MASK            (1 << 8)
+#define AVIVO_D1MODE_VIEWPORT_START             0x6580
+#define AVIVO_D1MODE_VIEWPORT_SIZE              0x6584
+#define AVIVO_D1MODE_EXT_OVERSCAN_LEFT_RIGHT    0x6588
+#define AVIVO_D1MODE_EXT_OVERSCAN_TOP_BOTTOM    0x658c
+
+#define AVIVO_D1SCL_SCALER_ENABLE               0x6590
+#define AVIVO_D1SCL_SCALER_TAP_CONTROL		0x6594
+#define AVIVO_D1SCL_UPDATE                      0x65cc
+#       define AVIVO_D1SCL_UPDATE_LOCK          (1 << 16)
+
+/* second crtc */
+#define AVIVO_D2CRTC_H_TOTAL					0x6800
+#define AVIVO_D2CRTC_H_BLANK_START_END                          0x6804
+#define AVIVO_D2CRTC_H_SYNC_A                                   0x6808
+#define AVIVO_D2CRTC_H_SYNC_A_CNTL                              0x680c
+#define AVIVO_D2CRTC_H_SYNC_B                                   0x6810
+#define AVIVO_D2CRTC_H_SYNC_B_CNTL                              0x6814
+
+#define AVIVO_D2CRTC_V_TOTAL					0x6820
+#define AVIVO_D2CRTC_V_BLANK_START_END                          0x6824
+#define AVIVO_D2CRTC_V_SYNC_A                                   0x6828
+#define AVIVO_D2CRTC_V_SYNC_A_CNTL                              0x682c
+#define AVIVO_D2CRTC_V_SYNC_B                                   0x6830
+#define AVIVO_D2CRTC_V_SYNC_B_CNTL                              0x6834
+
+#define AVIVO_D2CRTC_CONTROL                                    0x6880
+#define AVIVO_D2CRTC_BLANK_CONTROL                              0x6884
+#define AVIVO_D2CRTC_INTERLACE_CONTROL                          0x6888
+#define AVIVO_D2CRTC_INTERLACE_STATUS                           0x688c
+#define AVIVO_D2CRTC_STATUS_POSITION                            0x68a0
+#define AVIVO_D2CRTC_FRAME_COUNT                                0x68a4
+#define AVIVO_D2CRTC_STEREO_CONTROL                             0x68c4
+
+#define AVIVO_D2GRPH_ENABLE                                     0x6900
+#define AVIVO_D2GRPH_CONTROL                                    0x6904
+#define AVIVO_D2GRPH_LUT_SEL                                    0x6908
+#define AVIVO_D2GRPH_PRIMARY_SURFACE_ADDRESS                    0x6910
+#define AVIVO_D2GRPH_SECONDARY_SURFACE_ADDRESS                  0x6918
+#define AVIVO_D2GRPH_PITCH                                      0x6920
+#define AVIVO_D2GRPH_SURFACE_OFFSET_X                           0x6924
+#define AVIVO_D2GRPH_SURFACE_OFFSET_Y                           0x6928
+#define AVIVO_D2GRPH_X_START                                    0x692c
+#define AVIVO_D2GRPH_Y_START                                    0x6930
+#define AVIVO_D2GRPH_X_END                                      0x6934
+#define AVIVO_D2GRPH_Y_END                                      0x6938
+#define AVIVO_D2GRPH_UPDATE                                     0x6944
+#define AVIVO_D2GRPH_FLIP_CONTROL                               0x6948
+
+#define AVIVO_D2CUR_CONTROL                     0x6c00
+#define AVIVO_D2CUR_SURFACE_ADDRESS             0x6c08
+#define AVIVO_D2CUR_SIZE                        0x6c10
+#define AVIVO_D2CUR_POSITION                    0x6c14
+
+#define AVIVO_D2MODE_VBLANK_STATUS              0x6d34
+#define AVIVO_D2MODE_VLINE_START_END            0x6d38
+#define AVIVO_D2MODE_VLINE_STATUS               0x6d3c
+#define AVIVO_D2MODE_VIEWPORT_START             0x6d80
+#define AVIVO_D2MODE_VIEWPORT_SIZE              0x6d84
+#define AVIVO_D2MODE_EXT_OVERSCAN_LEFT_RIGHT    0x6d88
+#define AVIVO_D2MODE_EXT_OVERSCAN_TOP_BOTTOM    0x6d8c
+
+#define AVIVO_D2SCL_SCALER_ENABLE               0x6d90
+#define AVIVO_D2SCL_SCALER_TAP_CONTROL		0x6d94
+
+#define AVIVO_DDIA_BIT_DEPTH_CONTROL				0x7214
+
+#define AVIVO_DACA_ENABLE					0x7800
+#	define AVIVO_DAC_ENABLE				(1 << 0)
+#define AVIVO_DACA_SOURCE_SELECT				0x7804
+#       define AVIVO_DAC_SOURCE_CRTC1                   (0 << 0)
+#       define AVIVO_DAC_SOURCE_CRTC2                   (1 << 0)
+#       define AVIVO_DAC_SOURCE_TV                      (2 << 0)
+
+#define AVIVO_DACA_FORCE_OUTPUT_CNTL				0x783c
+# define AVIVO_DACA_FORCE_OUTPUT_CNTL_FORCE_DATA_EN             (1 << 0)
+# define AVIVO_DACA_FORCE_OUTPUT_CNTL_DATA_SEL_SHIFT            (8)
+# define AVIVO_DACA_FORCE_OUTPUT_CNTL_DATA_SEL_BLUE             (1 << 0)
+# define AVIVO_DACA_FORCE_OUTPUT_CNTL_DATA_SEL_GREEN            (1 << 1)
+# define AVIVO_DACA_FORCE_OUTPUT_CNTL_DATA_SEL_RED              (1 << 2)
+# define AVIVO_DACA_FORCE_OUTPUT_CNTL_DATA_ON_BLANKB_ONLY       (1 << 24)
+#define AVIVO_DACA_POWERDOWN					0x7850
+# define AVIVO_DACA_POWERDOWN_POWERDOWN                         (1 << 0)
+# define AVIVO_DACA_POWERDOWN_BLUE                              (1 << 8)
+# define AVIVO_DACA_POWERDOWN_GREEN                             (1 << 16)
+# define AVIVO_DACA_POWERDOWN_RED                               (1 << 24)
+
+#define AVIVO_DACB_ENABLE					0x7a00
+#define AVIVO_DACB_SOURCE_SELECT				0x7a04
+#define AVIVO_DACB_FORCE_OUTPUT_CNTL				0x7a3c
+# define AVIVO_DACB_FORCE_OUTPUT_CNTL_FORCE_DATA_EN             (1 << 0)
+# define AVIVO_DACB_FORCE_OUTPUT_CNTL_DATA_SEL_SHIFT            (8)
+# define AVIVO_DACB_FORCE_OUTPUT_CNTL_DATA_SEL_BLUE             (1 << 0)
+# define AVIVO_DACB_FORCE_OUTPUT_CNTL_DATA_SEL_GREEN            (1 << 1)
+# define AVIVO_DACB_FORCE_OUTPUT_CNTL_DATA_SEL_RED              (1 << 2)
+# define AVIVO_DACB_FORCE_OUTPUT_CNTL_DATA_ON_BLANKB_ONLY       (1 << 24)
+#define AVIVO_DACB_POWERDOWN					0x7a50
+# define AVIVO_DACB_POWERDOWN_POWERDOWN                         (1 << 0)
+# define AVIVO_DACB_POWERDOWN_BLUE                              (1 << 8)
+# define AVIVO_DACB_POWERDOWN_GREEN                             (1 << 16)
+# define AVIVO_DACB_POWERDOWN_RED
+
+#define AVIVO_TMDSA_CNTL                    0x7880
+#   define AVIVO_TMDSA_CNTL_ENABLE               (1 << 0)
+#   define AVIVO_TMDSA_CNTL_HDMI_EN              (1 << 2)
+#   define AVIVO_TMDSA_CNTL_HPD_MASK             (1 << 4)
+#   define AVIVO_TMDSA_CNTL_HPD_SELECT           (1 << 8)
+#   define AVIVO_TMDSA_CNTL_SYNC_PHASE           (1 << 12)
+#   define AVIVO_TMDSA_CNTL_PIXEL_ENCODING       (1 << 16)
+#   define AVIVO_TMDSA_CNTL_DUAL_LINK_ENABLE     (1 << 24)
+#   define AVIVO_TMDSA_CNTL_SWAP                 (1 << 28)
+#define AVIVO_TMDSA_SOURCE_SELECT				0x7884
+/* 78a8 appears to be some kind of (reasonably tolerant) clock?
+ * 78d0 definitely hits the transmitter, definitely clock. */
+/* MYSTERY1 This appears to control dithering? */
+#define AVIVO_TMDSA_BIT_DEPTH_CONTROL		0x7894
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_TRUNCATE_EN           (1 << 0)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_TRUNCATE_DEPTH        (1 << 4)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_SPATIAL_DITHER_EN     (1 << 8)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_SPATIAL_DITHER_DEPTH  (1 << 12)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_TEMPORAL_DITHER_EN    (1 << 16)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_TEMPORAL_DITHER_DEPTH (1 << 20)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_TEMPORAL_LEVEL        (1 << 24)
+#   define AVIVO_TMDS_BIT_DEPTH_CONTROL_TEMPORAL_DITHER_RESET (1 << 26)
+#define AVIVO_TMDSA_DCBALANCER_CONTROL                  0x78d0
+#   define AVIVO_TMDSA_DCBALANCER_CONTROL_EN                  (1 << 0)
+#   define AVIVO_TMDSA_DCBALANCER_CONTROL_TEST_EN             (1 << 8)
+#   define AVIVO_TMDSA_DCBALANCER_CONTROL_TEST_IN_SHIFT       (16)
+#   define AVIVO_TMDSA_DCBALANCER_CONTROL_FORCE               (1 << 24)
+#define AVIVO_TMDSA_DATA_SYNCHRONIZATION                0x78d8
+#   define AVIVO_TMDSA_DATA_SYNCHRONIZATION_DSYNSEL           (1 << 0)
+#   define AVIVO_TMDSA_DATA_SYNCHRONIZATION_PFREQCHG          (1 << 8)
+#define AVIVO_TMDSA_CLOCK_ENABLE            0x7900
+#define AVIVO_TMDSA_TRANSMITTER_ENABLE              0x7904
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_TX0_ENABLE          (1 << 0)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKC0EN             (1 << 1)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKD00EN            (1 << 2)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKD01EN            (1 << 3)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKD02EN            (1 << 4)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_TX1_ENABLE          (1 << 8)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKD10EN            (1 << 10)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKD11EN            (1 << 11)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKD12EN            (1 << 12)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_TX_ENABLE_HPD_MASK  (1 << 16)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKCEN_HPD_MASK     (1 << 17)
+#   define AVIVO_TMDSA_TRANSMITTER_ENABLE_LNKDEN_HPD_MASK     (1 << 18)
+
+#define AVIVO_TMDSA_TRANSMITTER_CONTROL				0x7910
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_PLL_ENABLE	(1 << 0)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_PLL_RESET	(1 << 1)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_PLL_HPD_MASK_SHIFT	(2)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_IDSCKSEL	        (1 << 4)
+#       define AVIVO_TMDSA_TRANSMITTER_CONTROL_BGSLEEP          (1 << 5)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_PLL_PWRUP_SEQ_EN	(1 << 6)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_TMCLK	        (1 << 8)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_TMCLK_FROM_PADS	(1 << 13)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_TDCLK	        (1 << 14)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_TDCLK_FROM_PADS	(1 << 15)
+#       define AVIVO_TMDSA_TRANSMITTER_CONTROL_CLK_PATTERN_SHIFT (16)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_BYPASS_PLL	(1 << 28)
+#       define AVIVO_TMDSA_TRANSMITTER_CONTROL_USE_CLK_DATA     (1 << 29)
+#	define AVIVO_TMDSA_TRANSMITTER_CONTROL_INPUT_TEST_CLK_SEL	(1 << 31)
+
+#define AVIVO_LVTMA_CNTL					0x7a80
+#   define AVIVO_LVTMA_CNTL_ENABLE               (1 << 0)
+#   define AVIVO_LVTMA_CNTL_HDMI_EN              (1 << 2)
+#   define AVIVO_LVTMA_CNTL_HPD_MASK             (1 << 4)
+#   define AVIVO_LVTMA_CNTL_HPD_SELECT           (1 << 8)
+#   define AVIVO_LVTMA_CNTL_SYNC_PHASE           (1 << 12)
+#   define AVIVO_LVTMA_CNTL_PIXEL_ENCODING       (1 << 16)
+#   define AVIVO_LVTMA_CNTL_DUAL_LINK_ENABLE     (1 << 24)
+#   define AVIVO_LVTMA_CNTL_SWAP                 (1 << 28)
+#define AVIVO_LVTMA_SOURCE_SELECT                               0x7a84
+#define AVIVO_LVTMA_COLOR_FORMAT                                0x7a88
+#define AVIVO_LVTMA_BIT_DEPTH_CONTROL                           0x7a94
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_TRUNCATE_EN           (1 << 0)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_TRUNCATE_DEPTH        (1 << 4)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_SPATIAL_DITHER_EN     (1 << 8)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_SPATIAL_DITHER_DEPTH  (1 << 12)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_TEMPORAL_DITHER_EN    (1 << 16)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_TEMPORAL_DITHER_DEPTH (1 << 20)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_TEMPORAL_LEVEL        (1 << 24)
+#   define AVIVO_LVTMA_BIT_DEPTH_CONTROL_TEMPORAL_DITHER_RESET (1 << 26)
+
+
+
+#define AVIVO_LVTMA_DCBALANCER_CONTROL                  0x7ad0
+#   define AVIVO_LVTMA_DCBALANCER_CONTROL_EN                  (1 << 0)
+#   define AVIVO_LVTMA_DCBALANCER_CONTROL_TEST_EN             (1 << 8)
+#   define AVIVO_LVTMA_DCBALANCER_CONTROL_TEST_IN_SHIFT       (16)
+#   define AVIVO_LVTMA_DCBALANCER_CONTROL_FORCE               (1 << 24)
+
+#define AVIVO_LVTMA_DATA_SYNCHRONIZATION                0x78d8
+#   define AVIVO_LVTMA_DATA_SYNCHRONIZATION_DSYNSEL           (1 << 0)
+#   define AVIVO_LVTMA_DATA_SYNCHRONIZATION_PFREQCHG          (1 << 8)
+#define R500_LVTMA_CLOCK_ENABLE			0x7b00
+#define R600_LVTMA_CLOCK_ENABLE			0x7b04
+
+#define R500_LVTMA_TRANSMITTER_ENABLE              0x7b04
+#define R600_LVTMA_TRANSMITTER_ENABLE              0x7b08
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKC0EN             (1 << 1)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD00EN            (1 << 2)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD01EN            (1 << 3)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD02EN            (1 << 4)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD03EN            (1 << 5)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKC1EN             (1 << 9)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD10EN            (1 << 10)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD11EN            (1 << 11)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKD12EN            (1 << 12)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKCEN_HPD_MASK     (1 << 17)
+#   define AVIVO_LVTMA_TRANSMITTER_ENABLE_LNKDEN_HPD_MASK     (1 << 18)
+
+#define R500_LVTMA_TRANSMITTER_CONTROL			        0x7b10
+#define R600_LVTMA_TRANSMITTER_CONTROL			        0x7b14
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_PLL_ENABLE	  (1 << 0)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_PLL_RESET	  (1 << 1)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_PLL_HPD_MASK_SHIFT (2)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_IDSCKSEL	          (1 << 4)
+#       define AVIVO_LVTMA_TRANSMITTER_CONTROL_BGSLEEP            (1 << 5)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_PLL_PWRUP_SEQ_EN	  (1 << 6)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_TMCLK	          (1 << 8)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_TMCLK_FROM_PADS	  (1 << 13)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_TDCLK	          (1 << 14)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_TDCLK_FROM_PADS	  (1 << 15)
+#       define AVIVO_LVTMA_TRANSMITTER_CONTROL_CLK_PATTERN_SHIFT  (16)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_BYPASS_PLL	  (1 << 28)
+#       define AVIVO_LVTMA_TRANSMITTER_CONTROL_USE_CLK_DATA       (1 << 29)
+#	define AVIVO_LVTMA_TRANSMITTER_CONTROL_INPUT_TEST_CLK_SEL (1 << 31)
+
+#define R500_LVTMA_PWRSEQ_CNTL						0x7af0
+#define R600_LVTMA_PWRSEQ_CNTL						0x7af4
+#	define AVIVO_LVTMA_PWRSEQ_EN					    (1 << 0)
+#	define AVIVO_LVTMA_PWRSEQ_PLL_ENABLE_MASK			    (1 << 2)
+#	define AVIVO_LVTMA_PWRSEQ_PLL_RESET_MASK			    (1 << 3)
+#	define AVIVO_LVTMA_PWRSEQ_TARGET_STATE				    (1 << 4)
+#	define AVIVO_LVTMA_SYNCEN					    (1 << 8)
+#	define AVIVO_LVTMA_SYNCEN_OVRD					    (1 << 9)
+#	define AVIVO_LVTMA_SYNCEN_POL					    (1 << 10)
+#	define AVIVO_LVTMA_DIGON					    (1 << 16)
+#	define AVIVO_LVTMA_DIGON_OVRD					    (1 << 17)
+#	define AVIVO_LVTMA_DIGON_POL					    (1 << 18)
+#	define AVIVO_LVTMA_BLON						    (1 << 24)
+#	define AVIVO_LVTMA_BLON_OVRD					    (1 << 25)
+#	define AVIVO_LVTMA_BLON_POL					    (1 << 26)
+
+#define R500_LVTMA_PWRSEQ_STATE                        0x7af4
+#define R600_LVTMA_PWRSEQ_STATE                        0x7af8
+#       define AVIVO_LVTMA_PWRSEQ_STATE_TARGET_STATE_R          (1 << 0)
+#       define AVIVO_LVTMA_PWRSEQ_STATE_DIGON                   (1 << 1)
+#       define AVIVO_LVTMA_PWRSEQ_STATE_SYNCEN                  (1 << 2)
+#       define AVIVO_LVTMA_PWRSEQ_STATE_BLON                    (1 << 3)
+#       define AVIVO_LVTMA_PWRSEQ_STATE_DONE                    (1 << 4)
+#       define AVIVO_LVTMA_PWRSEQ_STATE_STATUS_SHIFT            (8)
+
+#define AVIVO_LVDS_BACKLIGHT_CNTL			0x7af8
+#	define AVIVO_LVDS_BACKLIGHT_CNTL_EN			(1 << 0)
+#	define AVIVO_LVDS_BACKLIGHT_LEVEL_MASK		0x0000ff00
+#	define AVIVO_LVDS_BACKLIGHT_LEVEL_SHIFT		8
+
+#define AVIVO_DVOA_BIT_DEPTH_CONTROL			0x7988
+
+#define AVIVO_DC_GPIO_HPD_A                 0x7e94
+#define AVIVO_DC_GPIO_HPD_Y                 0x7e9c
+
+#define AVIVO_DC_I2C_STATUS1				0x7d30
+#	define AVIVO_DC_I2C_DONE			(1 << 0)
+#	define AVIVO_DC_I2C_NACK			(1 << 1)
+#	define AVIVO_DC_I2C_HALT			(1 << 2)
+#	define AVIVO_DC_I2C_GO			        (1 << 3)
+#define AVIVO_DC_I2C_RESET 				0x7d34
+#	define AVIVO_DC_I2C_SOFT_RESET			(1 << 0)
+#	define AVIVO_DC_I2C_ABORT			(1 << 8)
+#define AVIVO_DC_I2C_CONTROL1 				0x7d38
+#	define AVIVO_DC_I2C_START			(1 << 0)
+#	define AVIVO_DC_I2C_STOP			(1 << 1)
+#	define AVIVO_DC_I2C_RECEIVE			(1 << 2)
+#	define AVIVO_DC_I2C_EN			        (1 << 8)
+#	define AVIVO_DC_I2C_PIN_SELECT(x)		((x) << 16)
+#	define AVIVO_SEL_DDC1			        0
+#	define AVIVO_SEL_DDC2			        1
+#	define AVIVO_SEL_DDC3			        2
+#define AVIVO_DC_I2C_CONTROL2 				0x7d3c
+#	define AVIVO_DC_I2C_ADDR_COUNT(x)		((x) << 0)
+#	define AVIVO_DC_I2C_DATA_COUNT(x)		((x) << 8)
+#define AVIVO_DC_I2C_CONTROL3 				0x7d40
+#	define AVIVO_DC_I2C_DATA_DRIVE_EN		(1 << 0)
+#	define AVIVO_DC_I2C_DATA_DRIVE_SEL		(1 << 1)
+#	define AVIVO_DC_I2C_CLK_DRIVE_EN		(1 << 7)
+#	define AVIVO_DC_I2C_RD_INTRA_BYTE_DELAY(x)      ((x) << 8)
+#	define AVIVO_DC_I2C_WR_INTRA_BYTE_DELAY(x)	((x) << 16)
+#	define AVIVO_DC_I2C_TIME_LIMIT(x)		((x) << 24)
+#define AVIVO_DC_I2C_DATA 				0x7d44
+#define AVIVO_DC_I2C_INTERRUPT_CONTROL 			0x7d48
+#	define AVIVO_DC_I2C_INTERRUPT_STATUS		(1 << 0)
+#	define AVIVO_DC_I2C_INTERRUPT_AK		(1 << 8)
+#	define AVIVO_DC_I2C_INTERRUPT_ENABLE		(1 << 16)
+#define AVIVO_DC_I2C_ARBITRATION 			0x7d50
+#	define AVIVO_DC_I2C_SW_WANTS_TO_USE_I2C		(1 << 0)
+#	define AVIVO_DC_I2C_SW_CAN_USE_I2C		(1 << 1)
+#	define AVIVO_DC_I2C_SW_DONE_USING_I2C		(1 << 8)
+#	define AVIVO_DC_I2C_HW_NEEDS_I2C		(1 << 9)
+#	define AVIVO_DC_I2C_ABORT_HDCP_I2C		(1 << 16)
+#	define AVIVO_DC_I2C_HW_USING_I2C		(1 << 17)
+
+#define AVIVO_DC_GPIO_DDC1_MASK 		        0x7e40
+#define AVIVO_DC_GPIO_DDC1_A 		                0x7e44
+#define AVIVO_DC_GPIO_DDC1_EN 		                0x7e48
+#define AVIVO_DC_GPIO_DDC1_Y 		                0x7e4c
+
+#define AVIVO_DC_GPIO_DDC2_MASK 		        0x7e50
+#define AVIVO_DC_GPIO_DDC2_A 		                0x7e54
+#define AVIVO_DC_GPIO_DDC2_EN 		                0x7e58
+#define AVIVO_DC_GPIO_DDC2_Y 		                0x7e5c
+
+#define AVIVO_DC_GPIO_DDC3_MASK 		        0x7e60
+#define AVIVO_DC_GPIO_DDC3_A 		                0x7e64
+#define AVIVO_DC_GPIO_DDC3_EN 		                0x7e68
+#define AVIVO_DC_GPIO_DDC3_Y 		                0x7e6c
+
+#define AVIVO_DISP_INTERRUPT_STATUS                             0x7edc
+#       define AVIVO_D1_VBLANK_INTERRUPT                        (1 << 4)
+#       define AVIVO_D2_VBLANK_INTERRUPT                        (1 << 5)
+
+#endif
diff --git a/hw/display/radeon_reg.h b/hw/display/radeon_reg.h
new file mode 100644
index 0000000000..c5531d4435
--- /dev/null
+++ b/hw/display/radeon_reg.h
@@ -0,0 +1,3725 @@
+/*
+ * Copyright 2000 ATI Technologies Inc., Markham, Ontario, and
+ *                VA Linux Systems Inc., Fremont, California.
+ *
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation on the rights to use, copy, modify, merge,
+ * publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so,
+ * subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial
+ * portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NON-INFRINGEMENT.  IN NO EVENT SHALL ATI, VA LINUX SYSTEMS AND/OR
+ * THEIR SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * Authors:
+ *   Kevin E. Martin <martin@xfree86.org>
+ *   Rickard E. Faith <faith@valinux.com>
+ *   Alan Hourihane <alanh@fairlite.demon.co.uk>
+ *
+ * References:
+ *
+ * !!!! FIXME !!!!
+ *   RAGE 128 VR/ RAGE 128 GL Register Reference Manual (Technical
+ *   Reference Manual P/N RRG-G04100-C Rev. 0.04), ATI Technologies: April
+ *   1999.
+ *
+ * !!!! FIXME !!!!
+ *   RAGE 128 Software Development Manual (Technical Reference Manual P/N
+ *   SDK-G04000 Rev. 0.01), ATI Technologies: June 1999.
+ *
+ */
+
+/* !!!! FIXME !!!!  NOTE: THIS FILE HAS BEEN CONVERTED FROM r128_reg.h
+ * AND CONTAINS REGISTERS AND REGISTER DEFINITIONS THAT ARE NOT CORRECT
+ * ON THE RADEON.  A FULL AUDIT OF THIS CODE IS NEEDED!  */
+#ifndef _RADEON_REG_H_
+#define _RADEON_REG_H_
+
+#include "r300_reg.h"
+#include "r500_reg.h"
+// #include "r600_reg.h"
+// #include "evergreen_reg.h"
+// #include "ni_reg.h"
+// #include "si_reg.h"
+// #include "cik_reg.h"
+
+#define RADEON_MC_AGP_LOCATION		0x014c
+#define		RADEON_MC_AGP_START_MASK	0x0000FFFF
+#define		RADEON_MC_AGP_START_SHIFT	0
+#define		RADEON_MC_AGP_TOP_MASK		0xFFFF0000
+#define		RADEON_MC_AGP_TOP_SHIFT		16
+#define RADEON_MC_FB_LOCATION		0x0148
+#define		RADEON_MC_FB_START_MASK		0x0000FFFF
+#define		RADEON_MC_FB_START_SHIFT	0
+#define		RADEON_MC_FB_TOP_MASK		0xFFFF0000
+#define		RADEON_MC_FB_TOP_SHIFT		16
+#define RADEON_AGP_BASE_2		0x015c /* r200+ only */
+#define RADEON_AGP_BASE			0x0170
+
+#define ATI_DATATYPE_VQ				0
+#define ATI_DATATYPE_CI4			1
+#define ATI_DATATYPE_CI8			2
+#define ATI_DATATYPE_ARGB1555			3
+#define ATI_DATATYPE_RGB565			4
+#define ATI_DATATYPE_RGB888			5
+#define ATI_DATATYPE_ARGB8888			6
+#define ATI_DATATYPE_RGB332			7
+#define ATI_DATATYPE_Y8				8
+#define ATI_DATATYPE_RGB8			9
+#define ATI_DATATYPE_CI16			10
+#define ATI_DATATYPE_VYUY_422			11
+#define ATI_DATATYPE_YVYU_422			12
+#define ATI_DATATYPE_AYUV_444			14
+#define ATI_DATATYPE_ARGB4444			15
+
+				/* Registers for 2D/Video/Overlay */
+#define RADEON_ADAPTER_ID                   0x0f2c /* PCI */
+#define RADEON_AGP_BASE                     0x0170
+#define RADEON_AGP_CNTL                     0x0174
+#       define RADEON_AGP_APER_SIZE_256MB   (0x00 << 0)
+#       define RADEON_AGP_APER_SIZE_128MB   (0x20 << 0)
+#       define RADEON_AGP_APER_SIZE_64MB    (0x30 << 0)
+#       define RADEON_AGP_APER_SIZE_32MB    (0x38 << 0)
+#       define RADEON_AGP_APER_SIZE_16MB    (0x3c << 0)
+#       define RADEON_AGP_APER_SIZE_8MB     (0x3e << 0)
+#       define RADEON_AGP_APER_SIZE_4MB     (0x3f << 0)
+#       define RADEON_AGP_APER_SIZE_MASK    (0x3f << 0)
+#define RADEON_STATUS_PCI_CONFIG            0x06
+#       define RADEON_CAP_LIST              0x100000
+#define RADEON_CAPABILITIES_PTR_PCI_CONFIG  0x34 /* offset in PCI config*/
+#       define RADEON_CAP_PTR_MASK          0xfc /* mask off reserved bits of CAP_PTR */
+#       define RADEON_CAP_ID_NULL           0x00 /* End of capability list */
+#       define RADEON_CAP_ID_AGP            0x02 /* AGP capability ID */
+#       define RADEON_CAP_ID_EXP            0x10 /* PCI Express */
+#define RADEON_AGP_COMMAND                  0x0f60 /* PCI */
+#define RADEON_AGP_COMMAND_PCI_CONFIG       0x0060 /* offset in PCI config*/
+#       define RADEON_AGP_ENABLE            (1<<8)
+#define RADEON_AGP_PLL_CNTL                 0x000b /* PLL */
+#define RADEON_AGP_STATUS                   0x0f5c /* PCI */
+#       define RADEON_AGP_1X_MODE           0x01
+#       define RADEON_AGP_2X_MODE           0x02
+#       define RADEON_AGP_4X_MODE           0x04
+#       define RADEON_AGP_FW_MODE           0x10
+#       define RADEON_AGP_MODE_MASK         0x17
+#       define RADEON_AGPv3_MODE            0x08
+#       define RADEON_AGPv3_4X_MODE         0x01
+#       define RADEON_AGPv3_8X_MODE         0x02
+#define RADEON_ATTRDR                       0x03c1 /* VGA */
+#define RADEON_ATTRDW                       0x03c0 /* VGA */
+#define RADEON_ATTRX                        0x03c0 /* VGA */
+#define RADEON_AUX_SC_CNTL                  0x1660
+#       define RADEON_AUX1_SC_EN            (1 << 0)
+#       define RADEON_AUX1_SC_MODE_OR       (0 << 1)
+#       define RADEON_AUX1_SC_MODE_NAND     (1 << 1)
+#       define RADEON_AUX2_SC_EN            (1 << 2)
+#       define RADEON_AUX2_SC_MODE_OR       (0 << 3)
+#       define RADEON_AUX2_SC_MODE_NAND     (1 << 3)
+#       define RADEON_AUX3_SC_EN            (1 << 4)
+#       define RADEON_AUX3_SC_MODE_OR       (0 << 5)
+#       define RADEON_AUX3_SC_MODE_NAND     (1 << 5)
+#define RADEON_AUX1_SC_BOTTOM               0x1670
+#define RADEON_AUX1_SC_LEFT                 0x1664
+#define RADEON_AUX1_SC_RIGHT                0x1668
+#define RADEON_AUX1_SC_TOP                  0x166c
+#define RADEON_AUX2_SC_BOTTOM               0x1680
+#define RADEON_AUX2_SC_LEFT                 0x1674
+#define RADEON_AUX2_SC_RIGHT                0x1678
+#define RADEON_AUX2_SC_TOP                  0x167c
+#define RADEON_AUX3_SC_BOTTOM               0x1690
+#define RADEON_AUX3_SC_LEFT                 0x1684
+#define RADEON_AUX3_SC_RIGHT                0x1688
+#define RADEON_AUX3_SC_TOP                  0x168c
+#define RADEON_AUX_WINDOW_HORZ_CNTL         0x02d8
+#define RADEON_AUX_WINDOW_VERT_CNTL         0x02dc
+
+#define RADEON_BASE_CODE                    0x0f0b
+#define RADEON_BIOS_0_SCRATCH               0x0010
+#       define RADEON_FP_PANEL_SCALABLE     (1 << 16)
+#       define RADEON_FP_PANEL_SCALE_EN     (1 << 17)
+#       define RADEON_FP_CHIP_SCALE_EN      (1 << 18)
+#       define RADEON_DRIVER_BRIGHTNESS_EN  (1 << 26)
+#       define RADEON_DISPLAY_ROT_MASK      (3 << 28)
+#       define RADEON_DISPLAY_ROT_00        (0 << 28)
+#       define RADEON_DISPLAY_ROT_90        (1 << 28)
+#       define RADEON_DISPLAY_ROT_180       (2 << 28)
+#       define RADEON_DISPLAY_ROT_270       (3 << 28)
+#define RADEON_BIOS_1_SCRATCH               0x0014
+#define RADEON_BIOS_2_SCRATCH               0x0018
+#define RADEON_BIOS_3_SCRATCH               0x001c
+#define RADEON_BIOS_4_SCRATCH               0x0020
+#       define RADEON_CRT1_ATTACHED_MASK    (3 << 0)
+#       define RADEON_CRT1_ATTACHED_MONO    (1 << 0)
+#       define RADEON_CRT1_ATTACHED_COLOR   (2 << 0)
+#       define RADEON_LCD1_ATTACHED         (1 << 2)
+#       define RADEON_DFP1_ATTACHED         (1 << 3)
+#       define RADEON_TV1_ATTACHED_MASK     (3 << 4)
+#       define RADEON_TV1_ATTACHED_COMP     (1 << 4)
+#       define RADEON_TV1_ATTACHED_SVIDEO   (2 << 4)
+#       define RADEON_CRT2_ATTACHED_MASK    (3 << 8)
+#       define RADEON_CRT2_ATTACHED_MONO    (1 << 8)
+#       define RADEON_CRT2_ATTACHED_COLOR   (2 << 8)
+#       define RADEON_DFP2_ATTACHED         (1 << 11)
+#define RADEON_BIOS_5_SCRATCH               0x0024
+#       define RADEON_LCD1_ON               (1 << 0)
+#       define RADEON_CRT1_ON               (1 << 1)
+#       define RADEON_TV1_ON                (1 << 2)
+#       define RADEON_DFP1_ON               (1 << 3)
+#       define RADEON_CRT2_ON               (1 << 5)
+#       define RADEON_CV1_ON                (1 << 6)
+#       define RADEON_DFP2_ON               (1 << 7)
+#       define RADEON_LCD1_CRTC_MASK        (1 << 8)
+#       define RADEON_LCD1_CRTC_SHIFT       8
+#       define RADEON_CRT1_CRTC_MASK        (1 << 9)
+#       define RADEON_CRT1_CRTC_SHIFT       9
+#       define RADEON_TV1_CRTC_MASK         (1 << 10)
+#       define RADEON_TV1_CRTC_SHIFT        10
+#       define RADEON_DFP1_CRTC_MASK        (1 << 11)
+#       define RADEON_DFP1_CRTC_SHIFT       11
+#       define RADEON_CRT2_CRTC_MASK        (1 << 12)
+#       define RADEON_CRT2_CRTC_SHIFT       12
+#       define RADEON_CV1_CRTC_MASK         (1 << 13)
+#       define RADEON_CV1_CRTC_SHIFT        13
+#       define RADEON_DFP2_CRTC_MASK        (1 << 14)
+#       define RADEON_DFP2_CRTC_SHIFT       14
+#       define RADEON_ACC_REQ_LCD1          (1 << 16)
+#       define RADEON_ACC_REQ_CRT1          (1 << 17)
+#       define RADEON_ACC_REQ_TV1           (1 << 18)
+#       define RADEON_ACC_REQ_DFP1          (1 << 19)
+#       define RADEON_ACC_REQ_CRT2          (1 << 21)
+#       define RADEON_ACC_REQ_TV2           (1 << 22)
+#       define RADEON_ACC_REQ_DFP2          (1 << 23)
+#define RADEON_BIOS_6_SCRATCH               0x0028
+#       define RADEON_ACC_MODE_CHANGE       (1 << 2)
+#       define RADEON_EXT_DESKTOP_MODE      (1 << 3)
+#       define RADEON_LCD_DPMS_ON           (1 << 20)
+#       define RADEON_CRT_DPMS_ON           (1 << 21)
+#       define RADEON_TV_DPMS_ON            (1 << 22)
+#       define RADEON_DFP_DPMS_ON           (1 << 23)
+#       define RADEON_DPMS_MASK             (3 << 24)
+#       define RADEON_DPMS_ON               (0 << 24)
+#       define RADEON_DPMS_STANDBY          (1 << 24)
+#       define RADEON_DPMS_SUSPEND          (2 << 24)
+#       define RADEON_DPMS_OFF              (3 << 24)
+#       define RADEON_SCREEN_BLANKING       (1 << 26)
+#       define RADEON_DRIVER_CRITICAL       (1 << 27)
+#       define RADEON_DISPLAY_SWITCHING_DIS (1 << 30)
+#define RADEON_BIOS_7_SCRATCH               0x002c
+#       define RADEON_SYS_HOTKEY            (1 << 10)
+#       define RADEON_DRV_LOADED            (1 << 12)
+#define RADEON_BIOS_ROM                     0x0f30 /* PCI */
+#define RADEON_BIST                         0x0f0f /* PCI */
+#define RADEON_BRUSH_DATA0                  0x1480
+#define RADEON_BRUSH_DATA1                  0x1484
+#define RADEON_BRUSH_DATA10                 0x14a8
+#define RADEON_BRUSH_DATA11                 0x14ac
+#define RADEON_BRUSH_DATA12                 0x14b0
+#define RADEON_BRUSH_DATA13                 0x14b4
+#define RADEON_BRUSH_DATA14                 0x14b8
+#define RADEON_BRUSH_DATA15                 0x14bc
+#define RADEON_BRUSH_DATA16                 0x14c0
+#define RADEON_BRUSH_DATA17                 0x14c4
+#define RADEON_BRUSH_DATA18                 0x14c8
+#define RADEON_BRUSH_DATA19                 0x14cc
+#define RADEON_BRUSH_DATA2                  0x1488
+#define RADEON_BRUSH_DATA20                 0x14d0
+#define RADEON_BRUSH_DATA21                 0x14d4
+#define RADEON_BRUSH_DATA22                 0x14d8
+#define RADEON_BRUSH_DATA23                 0x14dc
+#define RADEON_BRUSH_DATA24                 0x14e0
+#define RADEON_BRUSH_DATA25                 0x14e4
+#define RADEON_BRUSH_DATA26                 0x14e8
+#define RADEON_BRUSH_DATA27                 0x14ec
+#define RADEON_BRUSH_DATA28                 0x14f0
+#define RADEON_BRUSH_DATA29                 0x14f4
+#define RADEON_BRUSH_DATA3                  0x148c
+#define RADEON_BRUSH_DATA30                 0x14f8
+#define RADEON_BRUSH_DATA31                 0x14fc
+#define RADEON_BRUSH_DATA32                 0x1500
+#define RADEON_BRUSH_DATA33                 0x1504
+#define RADEON_BRUSH_DATA34                 0x1508
+#define RADEON_BRUSH_DATA35                 0x150c
+#define RADEON_BRUSH_DATA36                 0x1510
+#define RADEON_BRUSH_DATA37                 0x1514
+#define RADEON_BRUSH_DATA38                 0x1518
+#define RADEON_BRUSH_DATA39                 0x151c
+#define RADEON_BRUSH_DATA4                  0x1490
+#define RADEON_BRUSH_DATA40                 0x1520
+#define RADEON_BRUSH_DATA41                 0x1524
+#define RADEON_BRUSH_DATA42                 0x1528
+#define RADEON_BRUSH_DATA43                 0x152c
+#define RADEON_BRUSH_DATA44                 0x1530
+#define RADEON_BRUSH_DATA45                 0x1534
+#define RADEON_BRUSH_DATA46                 0x1538
+#define RADEON_BRUSH_DATA47                 0x153c
+#define RADEON_BRUSH_DATA48                 0x1540
+#define RADEON_BRUSH_DATA49                 0x1544
+#define RADEON_BRUSH_DATA5                  0x1494
+#define RADEON_BRUSH_DATA50                 0x1548
+#define RADEON_BRUSH_DATA51                 0x154c
+#define RADEON_BRUSH_DATA52                 0x1550
+#define RADEON_BRUSH_DATA53                 0x1554
+#define RADEON_BRUSH_DATA54                 0x1558
+#define RADEON_BRUSH_DATA55                 0x155c
+#define RADEON_BRUSH_DATA56                 0x1560
+#define RADEON_BRUSH_DATA57                 0x1564
+#define RADEON_BRUSH_DATA58                 0x1568
+#define RADEON_BRUSH_DATA59                 0x156c
+#define RADEON_BRUSH_DATA6                  0x1498
+#define RADEON_BRUSH_DATA60                 0x1570
+#define RADEON_BRUSH_DATA61                 0x1574
+#define RADEON_BRUSH_DATA62                 0x1578
+#define RADEON_BRUSH_DATA63                 0x157c
+#define RADEON_BRUSH_DATA7                  0x149c
+#define RADEON_BRUSH_DATA8                  0x14a0
+#define RADEON_BRUSH_DATA9                  0x14a4
+#define RADEON_BRUSH_SCALE                  0x1470
+#define RADEON_BRUSH_Y_X                    0x1474
+#define RADEON_BUS_CNTL                     0x0030
+#       define RADEON_BUS_MASTER_DIS         (1 << 6)
+#       define RADEON_BUS_BIOS_DIS_ROM       (1 << 12)
+#	define RS600_BUS_MASTER_DIS	     (1 << 14)
+#	define RS600_MSI_REARM		     (1 << 20) /* rs600/rs690/rs740 */
+#       define RADEON_BUS_RD_DISCARD_EN      (1 << 24)
+#       define RADEON_BUS_RD_ABORT_EN        (1 << 25)
+#       define RADEON_BUS_MSTR_DISCONNECT_EN (1 << 28)
+#       define RADEON_BUS_WRT_BURST          (1 << 29)
+#       define RADEON_BUS_READ_BURST         (1 << 30)
+#define RADEON_BUS_CNTL1                    0x0034
+#       define RADEON_BUS_WAIT_ON_LOCK_EN    (1 << 4)
+#define RV370_BUS_CNTL                      0x004c
+#       define RV370_BUS_BIOS_DIS_ROM        (1 << 2)
+/* rv370/rv380, rv410, r423/r430/r480, r5xx */
+#define RADEON_MSI_REARM_EN		    0x0160
+#	define RV370_MSI_REARM_EN	     (1 << 0)
+
+/* #define RADEON_PCIE_INDEX                   0x0030 */
+/* #define RADEON_PCIE_DATA                    0x0034 */
+#define RADEON_PCIE_LC_LINK_WIDTH_CNTL             0xa2 /* PCIE */
+#       define RADEON_PCIE_LC_LINK_WIDTH_SHIFT     0
+#       define RADEON_PCIE_LC_LINK_WIDTH_MASK      0x7
+#       define RADEON_PCIE_LC_LINK_WIDTH_X0        0
+#       define RADEON_PCIE_LC_LINK_WIDTH_X1        1
+#       define RADEON_PCIE_LC_LINK_WIDTH_X2        2
+#       define RADEON_PCIE_LC_LINK_WIDTH_X4        3
+#       define RADEON_PCIE_LC_LINK_WIDTH_X8        4
+#       define RADEON_PCIE_LC_LINK_WIDTH_X12       5
+#       define RADEON_PCIE_LC_LINK_WIDTH_X16       6
+#       define RADEON_PCIE_LC_LINK_WIDTH_RD_SHIFT  4
+#       define RADEON_PCIE_LC_LINK_WIDTH_RD_MASK   0x70
+#       define RADEON_PCIE_LC_RECONFIG_NOW         (1 << 8)
+#       define RADEON_PCIE_LC_RECONFIG_LATER       (1 << 9)
+#       define RADEON_PCIE_LC_SHORT_RECONFIG_EN    (1 << 10)
+#       define R600_PCIE_LC_RECONFIG_ARC_MISSING_ESCAPE   (1 << 7)
+#       define R600_PCIE_LC_RENEGOTIATION_SUPPORT  (1 << 9)
+#       define R600_PCIE_LC_RENEGOTIATE_EN         (1 << 10)
+#       define R600_PCIE_LC_SHORT_RECONFIG_EN      (1 << 11)
+#       define R600_PCIE_LC_UPCONFIGURE_SUPPORT    (1 << 12)
+#       define R600_PCIE_LC_UPCONFIGURE_DIS        (1 << 13)
+
+#define R600_TARGET_AND_CURRENT_PROFILE_INDEX      0x70c
+#define R700_TARGET_AND_CURRENT_PROFILE_INDEX      0x66c
+
+#define RADEON_CACHE_CNTL                   0x1724
+#define RADEON_CACHE_LINE                   0x0f0c /* PCI */
+#define RADEON_CAPABILITIES_ID              0x0f50 /* PCI */
+#define RADEON_CAPABILITIES_PTR             0x0f34 /* PCI */
+#define RADEON_CLK_PIN_CNTL                 0x0001 /* PLL */
+#       define RADEON_DONT_USE_XTALIN       (1 << 4)
+#       define RADEON_SCLK_DYN_START_CNTL   (1 << 15)
+#define RADEON_CLOCK_CNTL_DATA              0x000c
+#define RADEON_CLOCK_CNTL_INDEX             0x0008
+#       define RADEON_PLL_WR_EN             (1 << 7)
+#       define RADEON_PLL_DIV_SEL           (3 << 8)
+#       define RADEON_PLL2_DIV_SEL_MASK     (~(3 << 8))
+#define RADEON_CLK_PWRMGT_CNTL              0x0014
+#       define RADEON_ENGIN_DYNCLK_MODE     (1 << 12)
+#       define RADEON_ACTIVE_HILO_LAT_MASK  (3 << 13)
+#       define RADEON_ACTIVE_HILO_LAT_SHIFT 13
+#       define RADEON_DISP_DYN_STOP_LAT_MASK (1 << 12)
+#       define RADEON_MC_BUSY               (1 << 16)
+#       define RADEON_DLL_READY             (1 << 19)
+#       define RADEON_CG_NO1_DEBUG_0        (1 << 24)
+#       define RADEON_CG_NO1_DEBUG_MASK     (0x1f << 24)
+#       define RADEON_DYN_STOP_MODE_MASK    (7 << 21)
+#       define RADEON_TVPLL_PWRMGT_OFF      (1 << 30)
+#       define RADEON_TVCLK_TURNOFF         (1 << 31)
+#define RADEON_PLL_PWRMGT_CNTL              0x0015 /* PLL */
+#	define RADEON_PM_MODE_SEL           (1 << 13)
+#       define RADEON_TCL_BYPASS_DISABLE    (1 << 20)
+#define RADEON_CLR_CMP_CLR_3D               0x1a24
+#define RADEON_CLR_CMP_CLR_DST              0x15c8
+#define RADEON_CLR_CMP_CLR_SRC              0x15c4
+#define RADEON_CLR_CMP_CNTL                 0x15c0
+#       define RADEON_SRC_CMP_EQ_COLOR      (4 <<  0)
+#       define RADEON_SRC_CMP_NEQ_COLOR     (5 <<  0)
+#       define RADEON_CLR_CMP_SRC_SOURCE    (1 << 24)
+#define RADEON_CLR_CMP_MASK                 0x15cc
+#       define RADEON_CLR_CMP_MSK           0xffffffff
+#define RADEON_CLR_CMP_MASK_3D              0x1A28
+#define RADEON_COMMAND                      0x0f04 /* PCI */
+#define RADEON_COMPOSITE_SHADOW_ID          0x1a0c
+#define RADEON_CONFIG_APER_0_BASE           0x0100
+#define RADEON_CONFIG_APER_1_BASE           0x0104
+#define RADEON_CONFIG_APER_SIZE             0x0108
+#define RADEON_CONFIG_BONDS                 0x00e8
+#define RADEON_CONFIG_CNTL                  0x00e0
+#       define RADEON_CFG_VGA_RAM_EN        (1 << 8)
+#       define RADEON_CFG_VGA_IO_DIS        (1 << 9)
+#       define RADEON_CFG_ATI_REV_A11       (0   << 16)
+#       define RADEON_CFG_ATI_REV_A12       (1   << 16)
+#       define RADEON_CFG_ATI_REV_A13       (2   << 16)
+#       define RADEON_CFG_ATI_REV_ID_MASK   (0xf << 16)
+#define RADEON_CONFIG_MEMSIZE               0x00f8
+#define RADEON_CONFIG_MEMSIZE_EMBEDDED      0x0114
+#define RADEON_CONFIG_REG_1_BASE            0x010c
+#define RADEON_CONFIG_REG_APER_SIZE         0x0110
+#define RADEON_CONFIG_XSTRAP                0x00e4
+#define RADEON_CONSTANT_COLOR_C             0x1d34
+#       define RADEON_CONSTANT_COLOR_MASK   0x00ffffff
+#       define RADEON_CONSTANT_COLOR_ONE    0x00ffffff
+#       define RADEON_CONSTANT_COLOR_ZERO   0x00000000
+#define RADEON_CRC_CMDFIFO_ADDR             0x0740
+#define RADEON_CRC_CMDFIFO_DOUT             0x0744
+#define RADEON_GRPH_BUFFER_CNTL             0x02f0
+#       define RADEON_GRPH_START_REQ_MASK          (0x7f)
+#       define RADEON_GRPH_START_REQ_SHIFT         0
+#       define RADEON_GRPH_STOP_REQ_MASK           (0x7f<<8)
+#       define RADEON_GRPH_STOP_REQ_SHIFT          8
+#       define RADEON_GRPH_CRITICAL_POINT_MASK     (0x7f<<16)
+#       define RADEON_GRPH_CRITICAL_POINT_SHIFT    16
+#       define RADEON_GRPH_CRITICAL_CNTL           (1<<28)
+#       define RADEON_GRPH_BUFFER_SIZE             (1<<29)
+#       define RADEON_GRPH_CRITICAL_AT_SOF         (1<<30)
+#       define RADEON_GRPH_STOP_CNTL               (1<<31)
+#define RADEON_GRPH2_BUFFER_CNTL            0x03f0
+#       define RADEON_GRPH2_START_REQ_MASK         (0x7f)
+#       define RADEON_GRPH2_START_REQ_SHIFT         0
+#       define RADEON_GRPH2_STOP_REQ_MASK          (0x7f<<8)
+#       define RADEON_GRPH2_STOP_REQ_SHIFT         8
+#       define RADEON_GRPH2_CRITICAL_POINT_MASK    (0x7f<<16)
+#       define RADEON_GRPH2_CRITICAL_POINT_SHIFT   16
+#       define RADEON_GRPH2_CRITICAL_CNTL          (1<<28)
+#       define RADEON_GRPH2_BUFFER_SIZE            (1<<29)
+#       define RADEON_GRPH2_CRITICAL_AT_SOF        (1<<30)
+#       define RADEON_GRPH2_STOP_CNTL              (1<<31)
+#define RADEON_CRTC_CRNT_FRAME              0x0214
+#define RADEON_CRTC_EXT_CNTL                0x0054
+#       define RADEON_CRTC_VGA_XOVERSCAN    (1 <<  0)
+#       define RADEON_VGA_ATI_LINEAR        (1 <<  3)
+#       define RADEON_XCRT_CNT_EN           (1 <<  6)
+#       define RADEON_CRTC_HSYNC_DIS        (1 <<  8)
+#       define RADEON_CRTC_VSYNC_DIS        (1 <<  9)
+#       define RADEON_CRTC_DISPLAY_DIS      (1 << 10)
+#       define RADEON_CRTC_SYNC_TRISTAT     (1 << 11)
+#       define RADEON_CRTC_CRT_ON           (1 << 15)
+#define RADEON_CRTC_EXT_CNTL_DPMS_BYTE      0x0055
+#       define RADEON_CRTC_HSYNC_DIS_BYTE   (1 <<  0)
+#       define RADEON_CRTC_VSYNC_DIS_BYTE   (1 <<  1)
+#       define RADEON_CRTC_DISPLAY_DIS_BYTE (1 <<  2)
+#define RADEON_CRTC_GEN_CNTL                0x0050
+#       define RADEON_CRTC_DBL_SCAN_EN      (1 <<  0)
+#       define RADEON_CRTC_INTERLACE_EN     (1 <<  1)
+#       define RADEON_CRTC_CSYNC_EN         (1 <<  4)
+#       define RADEON_CRTC_ICON_EN          (1 << 15)
+#       define RADEON_CRTC_CUR_EN           (1 << 16)
+#       define RADEON_CRTC_VSTAT_MODE_MASK  (3 << 17)
+#       define RADEON_CRTC_CUR_MODE_MASK    (7 << 20)
+#       define RADEON_CRTC_CUR_MODE_SHIFT   20
+#       define RADEON_CRTC_CUR_MODE_MONO    0
+#       define RADEON_CRTC_CUR_MODE_24BPP   2
+#       define RADEON_CRTC_EXT_DISP_EN      (1 << 24)
+#       define RADEON_CRTC_EN               (1 << 25)
+#       define RADEON_CRTC_DISP_REQ_EN_B    (1 << 26)
+#define RADEON_CRTC2_GEN_CNTL               0x03f8
+#       define RADEON_CRTC2_DBL_SCAN_EN     (1 <<  0)
+#       define RADEON_CRTC2_INTERLACE_EN    (1 <<  1)
+#       define RADEON_CRTC2_SYNC_TRISTAT    (1 <<  4)
+#       define RADEON_CRTC2_HSYNC_TRISTAT   (1 <<  5)
+#       define RADEON_CRTC2_VSYNC_TRISTAT   (1 <<  6)
+#       define RADEON_CRTC2_CRT2_ON         (1 <<  7)
+#       define RADEON_CRTC2_PIX_WIDTH_SHIFT 8
+#       define RADEON_CRTC2_PIX_WIDTH_MASK  (0xf << 8)
+#       define RADEON_CRTC2_ICON_EN         (1 << 15)
+#       define RADEON_CRTC2_CUR_EN          (1 << 16)
+#       define RADEON_CRTC2_CUR_MODE_MASK   (7 << 20)
+#       define RADEON_CRTC2_DISP_DIS        (1 << 23)
+#       define RADEON_CRTC2_EN              (1 << 25)
+#       define RADEON_CRTC2_DISP_REQ_EN_B   (1 << 26)
+#       define RADEON_CRTC2_CSYNC_EN        (1 << 27)
+#       define RADEON_CRTC2_HSYNC_DIS       (1 << 28)
+#       define RADEON_CRTC2_VSYNC_DIS       (1 << 29)
+#define RADEON_CRTC_MORE_CNTL               0x27c
+#       define RADEON_CRTC_AUTO_HORZ_CENTER_EN (1<<2)
+#       define RADEON_CRTC_AUTO_VERT_CENTER_EN (1<<3)
+#       define RADEON_CRTC_H_CUTOFF_ACTIVE_EN (1<<4)
+#       define RADEON_CRTC_V_CUTOFF_ACTIVE_EN (1<<5)
+#define RADEON_CRTC_GUI_TRIG_VLINE          0x0218
+#define RADEON_CRTC_H_SYNC_STRT_WID         0x0204
+#       define RADEON_CRTC_H_SYNC_STRT_PIX        (0x07  <<  0)
+#       define RADEON_CRTC_H_SYNC_STRT_CHAR       (0x3ff <<  3)
+#       define RADEON_CRTC_H_SYNC_STRT_CHAR_SHIFT 3
+#       define RADEON_CRTC_H_SYNC_WID             (0x3f  << 16)
+#       define RADEON_CRTC_H_SYNC_WID_SHIFT       16
+#       define RADEON_CRTC_H_SYNC_POL             (1     << 23)
+#define RADEON_CRTC2_H_SYNC_STRT_WID        0x0304
+#       define RADEON_CRTC2_H_SYNC_STRT_PIX        (0x07  <<  0)
+#       define RADEON_CRTC2_H_SYNC_STRT_CHAR       (0x3ff <<  3)
+#       define RADEON_CRTC2_H_SYNC_STRT_CHAR_SHIFT 3
+#       define RADEON_CRTC2_H_SYNC_WID             (0x3f  << 16)
+#       define RADEON_CRTC2_H_SYNC_WID_SHIFT       16
+#       define RADEON_CRTC2_H_SYNC_POL             (1     << 23)
+#define RADEON_CRTC_H_TOTAL_DISP            0x0200
+#       define RADEON_CRTC_H_TOTAL          (0x03ff << 0)
+#       define RADEON_CRTC_H_TOTAL_SHIFT    0
+#       define RADEON_CRTC_H_DISP           (0x01ff << 16)
+#       define RADEON_CRTC_H_DISP_SHIFT     16
+#define RADEON_CRTC2_H_TOTAL_DISP           0x0300
+#       define RADEON_CRTC2_H_TOTAL         (0x03ff << 0)
+#       define RADEON_CRTC2_H_TOTAL_SHIFT   0
+#       define RADEON_CRTC2_H_DISP          (0x01ff << 16)
+#       define RADEON_CRTC2_H_DISP_SHIFT    16
+
+#define RADEON_CRTC_OFFSET_RIGHT	    0x0220
+#define RADEON_CRTC_OFFSET                  0x0224
+#	define RADEON_CRTC_OFFSET__GUI_TRIG_OFFSET (1<<30)
+#	define RADEON_CRTC_OFFSET__OFFSET_LOCK	   (1<<31)
+
+#define RADEON_CRTC2_OFFSET                 0x0324
+#	define RADEON_CRTC2_OFFSET__GUI_TRIG_OFFSET (1<<30)
+#	define RADEON_CRTC2_OFFSET__OFFSET_LOCK	    (1<<31)
+#define RADEON_CRTC_OFFSET_CNTL             0x0228
+#       define RADEON_CRTC_TILE_LINE_SHIFT              0
+#       define RADEON_CRTC_TILE_LINE_RIGHT_SHIFT        4
+#	define R300_CRTC_X_Y_MODE_EN_RIGHT		(1 << 6)
+#	define R300_CRTC_MICRO_TILE_BUFFER_RIGHT_MASK   (3 << 7)
+#	define R300_CRTC_MICRO_TILE_BUFFER_RIGHT_AUTO   (0 << 7)
+#	define R300_CRTC_MICRO_TILE_BUFFER_RIGHT_SINGLE (1 << 7)
+#	define R300_CRTC_MICRO_TILE_BUFFER_RIGHT_DOUBLE (2 << 7)
+#	define R300_CRTC_MICRO_TILE_BUFFER_RIGHT_DIS    (3 << 7)
+#	define R300_CRTC_X_Y_MODE_EN			(1 << 9)
+#	define R300_CRTC_MICRO_TILE_BUFFER_MASK		(3 << 10)
+#	define R300_CRTC_MICRO_TILE_BUFFER_AUTO		(0 << 10)
+#	define R300_CRTC_MICRO_TILE_BUFFER_SINGLE	(1 << 10)
+#	define R300_CRTC_MICRO_TILE_BUFFER_DOUBLE	(2 << 10)
+#	define R300_CRTC_MICRO_TILE_BUFFER_DIS		(3 << 10)
+#	define R300_CRTC_MICRO_TILE_EN_RIGHT		(1 << 12)
+#	define R300_CRTC_MICRO_TILE_EN			(1 << 13)
+#	define R300_CRTC_MACRO_TILE_EN_RIGHT		(1 << 14)
+#       define R300_CRTC_MACRO_TILE_EN                  (1 << 15)
+#       define RADEON_CRTC_TILE_EN_RIGHT                (1 << 14)
+#       define RADEON_CRTC_TILE_EN                      (1 << 15)
+#       define RADEON_CRTC_OFFSET_FLIP_CNTL             (1 << 16)
+#       define RADEON_CRTC_STEREO_OFFSET_EN             (1 << 17)
+#       define RADEON_CRTC_GUI_TRIG_OFFSET_LEFT_EN      (1 << 28)
+#       define RADEON_CRTC_GUI_TRIG_OFFSET_RIGHT_EN     (1 << 29)
+
+#define R300_CRTC_TILE_X0_Y0	            0x0350
+#define R300_CRTC2_TILE_X0_Y0	            0x0358
+
+#define RADEON_CRTC2_OFFSET_CNTL            0x0328
+#       define RADEON_CRTC2_OFFSET_FLIP_CNTL (1 << 16)
+#       define RADEON_CRTC2_TILE_EN         (1 << 15)
+#define RADEON_CRTC_PITCH                   0x022c
+#	define RADEON_CRTC_PITCH__SHIFT		 0
+#	define RADEON_CRTC_PITCH__RIGHT_SHIFT	16
+
+#define RADEON_CRTC2_PITCH                  0x032c
+#define RADEON_CRTC_STATUS                  0x005c
+#       define RADEON_CRTC_VBLANK_CUR       (1 <<  0)
+#       define RADEON_CRTC_VBLANK_SAVE      (1 <<  1)
+#       define RADEON_CRTC_VBLANK_SAVE_CLEAR  (1 <<  1)
+#define RADEON_CRTC2_STATUS                  0x03fc
+#       define RADEON_CRTC2_VBLANK_CUR       (1 <<  0)
+#       define RADEON_CRTC2_VBLANK_SAVE      (1 <<  1)
+#       define RADEON_CRTC2_VBLANK_SAVE_CLEAR  (1 <<  1)
+#define RADEON_CRTC_V_SYNC_STRT_WID         0x020c
+#       define RADEON_CRTC_V_SYNC_STRT        (0x7ff <<  0)
+#       define RADEON_CRTC_V_SYNC_STRT_SHIFT  0
+#       define RADEON_CRTC_V_SYNC_WID         (0x1f  << 16)
+#       define RADEON_CRTC_V_SYNC_WID_SHIFT   16
+#       define RADEON_CRTC_V_SYNC_POL         (1     << 23)
+#define RADEON_CRTC2_V_SYNC_STRT_WID        0x030c
+#       define RADEON_CRTC2_V_SYNC_STRT       (0x7ff <<  0)
+#       define RADEON_CRTC2_V_SYNC_STRT_SHIFT 0
+#       define RADEON_CRTC2_V_SYNC_WID        (0x1f  << 16)
+#       define RADEON_CRTC2_V_SYNC_WID_SHIFT  16
+#       define RADEON_CRTC2_V_SYNC_POL        (1     << 23)
+#define RADEON_CRTC_V_TOTAL_DISP            0x0208
+#       define RADEON_CRTC_V_TOTAL          (0x07ff << 0)
+#       define RADEON_CRTC_V_TOTAL_SHIFT    0
+#       define RADEON_CRTC_V_DISP           (0x07ff << 16)
+#       define RADEON_CRTC_V_DISP_SHIFT     16
+#define RADEON_CRTC2_V_TOTAL_DISP           0x0308
+#       define RADEON_CRTC2_V_TOTAL         (0x07ff << 0)
+#       define RADEON_CRTC2_V_TOTAL_SHIFT   0
+#       define RADEON_CRTC2_V_DISP          (0x07ff << 16)
+#       define RADEON_CRTC2_V_DISP_SHIFT    16
+#define RADEON_CRTC_VLINE_CRNT_VLINE        0x0210
+#       define RADEON_CRTC_CRNT_VLINE_MASK  (0x7ff << 16)
+#define RADEON_CRTC2_CRNT_FRAME             0x0314
+#define RADEON_CRTC2_GUI_TRIG_VLINE         0x0318
+#define RADEON_CRTC2_VLINE_CRNT_VLINE       0x0310
+#define RADEON_CRTC8_DATA                   0x03d5 /* VGA, 0x3b5 */
+#define RADEON_CRTC8_IDX                    0x03d4 /* VGA, 0x3b4 */
+#define RADEON_CUR_CLR0                     0x026c
+#define RADEON_CUR_CLR1                     0x0270
+#define RADEON_CUR_HORZ_VERT_OFF            0x0268
+#define RADEON_CUR_HORZ_VERT_POSN           0x0264
+#define RADEON_CUR_OFFSET                   0x0260
+#       define RADEON_CUR_LOCK              (1 << 31)
+#define RADEON_CUR2_CLR0                    0x036c
+#define RADEON_CUR2_CLR1                    0x0370
+#define RADEON_CUR2_HORZ_VERT_OFF           0x0368
+#define RADEON_CUR2_HORZ_VERT_POSN          0x0364
+#define RADEON_CUR2_OFFSET                  0x0360
+#       define RADEON_CUR2_LOCK             (1 << 31)
+
+#define RADEON_DAC_CNTL                     0x0058
+#       define RADEON_DAC_RANGE_CNTL        (3 <<  0)
+#       define RADEON_DAC_RANGE_CNTL_PS2    (2 <<  0)
+#       define RADEON_DAC_RANGE_CNTL_MASK   0x03
+#       define RADEON_DAC_BLANKING          (1 <<  2)
+#       define RADEON_DAC_CMP_EN            (1 <<  3)
+#       define RADEON_DAC_CMP_OUTPUT        (1 <<  7)
+#       define RADEON_DAC_8BIT_EN           (1 <<  8)
+#       define RADEON_DAC_TVO_EN            (1 << 10)
+#       define RADEON_DAC_VGA_ADR_EN        (1 << 13)
+#       define RADEON_DAC_PDWN              (1 << 15)
+#       define RADEON_DAC_MASK_ALL          (0xff << 24)
+#define RADEON_DAC_CNTL2                    0x007c
+#       define RADEON_DAC2_TV_CLK_SEL       (0 <<  1)
+#       define RADEON_DAC2_DAC_CLK_SEL      (1 <<  0)
+#       define RADEON_DAC2_DAC2_CLK_SEL     (1 <<  1)
+#       define RADEON_DAC2_PALETTE_ACC_CTL  (1 <<  5)
+#       define RADEON_DAC2_CMP_EN           (1 <<  7)
+#       define RADEON_DAC2_CMP_OUT_R        (1 <<  8)
+#       define RADEON_DAC2_CMP_OUT_G        (1 <<  9)
+#       define RADEON_DAC2_CMP_OUT_B        (1 << 10)
+#       define RADEON_DAC2_CMP_OUTPUT       (1 << 11)
+#define RADEON_DAC_EXT_CNTL                 0x0280
+#       define RADEON_DAC2_FORCE_BLANK_OFF_EN (1 << 0)
+#       define RADEON_DAC2_FORCE_DATA_EN      (1 << 1)
+#       define RADEON_DAC_FORCE_BLANK_OFF_EN  (1 << 4)
+#       define RADEON_DAC_FORCE_DATA_EN       (1 << 5)
+#       define RADEON_DAC_FORCE_DATA_SEL_MASK (3 << 6)
+#       define RADEON_DAC_FORCE_DATA_SEL_R    (0 << 6)
+#       define RADEON_DAC_FORCE_DATA_SEL_G    (1 << 6)
+#       define RADEON_DAC_FORCE_DATA_SEL_B    (2 << 6)
+#       define RADEON_DAC_FORCE_DATA_SEL_RGB  (3 << 6)
+#       define RADEON_DAC_FORCE_DATA_MASK   0x0003ff00
+#       define RADEON_DAC_FORCE_DATA_SHIFT  8
+#define RADEON_DAC_MACRO_CNTL               0x0d04
+#       define RADEON_DAC_PDWN_R            (1 << 16)
+#       define RADEON_DAC_PDWN_G            (1 << 17)
+#       define RADEON_DAC_PDWN_B            (1 << 18)
+#define RADEON_DISP_PWR_MAN                 0x0d08
+#       define RADEON_DISP_PWR_MAN_D3_CRTC_EN      (1 << 0)
+#       define RADEON_DISP_PWR_MAN_D3_CRTC2_EN     (1 << 4)
+#       define RADEON_DISP_PWR_MAN_DPMS_ON  (0 << 8)
+#       define RADEON_DISP_PWR_MAN_DPMS_STANDBY    (1 << 8)
+#       define RADEON_DISP_PWR_MAN_DPMS_SUSPEND    (2 << 8)
+#       define RADEON_DISP_PWR_MAN_DPMS_OFF (3 << 8)
+#       define RADEON_DISP_D3_RST           (1 << 16)
+#       define RADEON_DISP_D3_REG_RST       (1 << 17)
+#       define RADEON_DISP_D3_GRPH_RST      (1 << 18)
+#       define RADEON_DISP_D3_SUBPIC_RST    (1 << 19)
+#       define RADEON_DISP_D3_OV0_RST       (1 << 20)
+#       define RADEON_DISP_D1D2_GRPH_RST    (1 << 21)
+#       define RADEON_DISP_D1D2_SUBPIC_RST  (1 << 22)
+#       define RADEON_DISP_D1D2_OV0_RST     (1 << 23)
+#       define RADEON_DIG_TMDS_ENABLE_RST   (1 << 24)
+#       define RADEON_TV_ENABLE_RST         (1 << 25)
+#       define RADEON_AUTO_PWRUP_EN         (1 << 26)
+#define RADEON_TV_DAC_CNTL                  0x088c
+#       define RADEON_TV_DAC_NBLANK         (1 << 0)
+#       define RADEON_TV_DAC_NHOLD          (1 << 1)
+#       define RADEON_TV_DAC_PEDESTAL       (1 <<  2)
+#       define RADEON_TV_MONITOR_DETECT_EN  (1 <<  4)
+#       define RADEON_TV_DAC_CMPOUT         (1 <<  5)
+#       define RADEON_TV_DAC_STD_MASK       (3 <<  8)
+#       define RADEON_TV_DAC_STD_PAL        (0 <<  8)
+#       define RADEON_TV_DAC_STD_NTSC       (1 <<  8)
+#       define RADEON_TV_DAC_STD_PS2        (2 <<  8)
+#       define RADEON_TV_DAC_STD_RS343      (3 <<  8)
+#       define RADEON_TV_DAC_BGSLEEP        (1 <<  6)
+#       define RADEON_TV_DAC_BGADJ_MASK     (0xf <<  16)
+#       define RADEON_TV_DAC_BGADJ_SHIFT    16
+#       define RADEON_TV_DAC_DACADJ_MASK    (0xf <<  20)
+#       define RADEON_TV_DAC_DACADJ_SHIFT   20
+#       define RADEON_TV_DAC_RDACPD         (1 <<  24)
+#       define RADEON_TV_DAC_GDACPD         (1 <<  25)
+#       define RADEON_TV_DAC_BDACPD         (1 <<  26)
+#       define RADEON_TV_DAC_RDACDET        (1 << 29)
+#       define RADEON_TV_DAC_GDACDET        (1 << 30)
+#       define RADEON_TV_DAC_BDACDET        (1 << 31)
+#       define R420_TV_DAC_DACADJ_MASK      (0x1f <<  20)
+#       define R420_TV_DAC_RDACPD           (1 <<  25)
+#       define R420_TV_DAC_GDACPD           (1 <<  26)
+#       define R420_TV_DAC_BDACPD           (1 <<  27)
+#       define R420_TV_DAC_TVENABLE         (1 <<  28)
+#define RADEON_DISP_HW_DEBUG                0x0d14
+#       define RADEON_CRT2_DISP1_SEL        (1 <<  5)
+#define RADEON_DISP_OUTPUT_CNTL             0x0d64
+#       define RADEON_DISP_DAC_SOURCE_MASK  0x03
+#       define RADEON_DISP_DAC2_SOURCE_MASK  0x0c
+#       define RADEON_DISP_DAC_SOURCE_CRTC2 0x01
+#       define RADEON_DISP_DAC_SOURCE_RMX   0x02
+#       define RADEON_DISP_DAC_SOURCE_LTU   0x03
+#       define RADEON_DISP_DAC2_SOURCE_CRTC2 0x04
+#       define RADEON_DISP_TVDAC_SOURCE_MASK  (0x03 << 2)
+#       define RADEON_DISP_TVDAC_SOURCE_CRTC  0x0
+#       define RADEON_DISP_TVDAC_SOURCE_CRTC2 (0x01 << 2)
+#       define RADEON_DISP_TVDAC_SOURCE_RMX   (0x02 << 2)
+#       define RADEON_DISP_TVDAC_SOURCE_LTU   (0x03 << 2)
+#       define RADEON_DISP_TRANS_MATRIX_MASK  (0x03 << 4)
+#       define RADEON_DISP_TRANS_MATRIX_ALPHA_MSB (0x00 << 4)
+#       define RADEON_DISP_TRANS_MATRIX_GRAPHICS  (0x01 << 4)
+#       define RADEON_DISP_TRANS_MATRIX_VIDEO     (0x02 << 4)
+#       define RADEON_DISP_TV_SOURCE_CRTC   (1 << 16) /* crtc1 or crtc2 */
+#       define RADEON_DISP_TV_SOURCE_LTU    (0 << 16) /* linear transform unit */
+#define RADEON_DISP_TV_OUT_CNTL             0x0d6c
+#       define RADEON_DISP_TV_PATH_SRC_CRTC2 (1 << 16)
+#       define RADEON_DISP_TV_PATH_SRC_CRTC1 (0 << 16)
+#define RADEON_DAC_CRC_SIG                  0x02cc
+#define RADEON_DAC_DATA                     0x03c9 /* VGA */
+#define RADEON_DAC_MASK                     0x03c6 /* VGA */
+#define RADEON_DAC_R_INDEX                  0x03c7 /* VGA */
+#define RADEON_DAC_W_INDEX                  0x03c8 /* VGA */
+#define RADEON_DDA_CONFIG                   0x02e0
+#define RADEON_DDA_ON_OFF                   0x02e4
+#define RADEON_DEFAULT_OFFSET               0x16e0
+#define RADEON_DEFAULT_PITCH                0x16e4
+#define RADEON_DEFAULT_SC_BOTTOM_RIGHT      0x16e8
+#       define RADEON_DEFAULT_SC_RIGHT_MAX  (0x1fff <<  0)
+#       define RADEON_DEFAULT_SC_BOTTOM_MAX (0x1fff << 16)
+#define RADEON_DESTINATION_3D_CLR_CMP_VAL   0x1820
+#define RADEON_DESTINATION_3D_CLR_CMP_MSK   0x1824
+#define RADEON_DEVICE_ID                    0x0f02 /* PCI */
+#define RADEON_DISP_MISC_CNTL               0x0d00
+#       define RADEON_SOFT_RESET_GRPH_PP    (1 << 0)
+#define RADEON_DISP_MERGE_CNTL		  0x0d60
+#       define RADEON_DISP_ALPHA_MODE_MASK  0x03
+#       define RADEON_DISP_ALPHA_MODE_KEY   0
+#       define RADEON_DISP_ALPHA_MODE_PER_PIXEL 1
+#       define RADEON_DISP_ALPHA_MODE_GLOBAL 2
+#       define RADEON_DISP_RGB_OFFSET_EN    (1 << 8)
+#       define RADEON_DISP_GRPH_ALPHA_MASK  (0xff << 16)
+#       define RADEON_DISP_OV0_ALPHA_MASK   (0xff << 24)
+#	define RADEON_DISP_LIN_TRANS_BYPASS (0x01 << 9)
+#define RADEON_DISP2_MERGE_CNTL		    0x0d68
+#       define RADEON_DISP2_RGB_OFFSET_EN   (1 << 8)
+#define RADEON_DISP_LIN_TRANS_GRPH_A        0x0d80
+#define RADEON_DISP_LIN_TRANS_GRPH_B        0x0d84
+#define RADEON_DISP_LIN_TRANS_GRPH_C        0x0d88
+#define RADEON_DISP_LIN_TRANS_GRPH_D        0x0d8c
+#define RADEON_DISP_LIN_TRANS_GRPH_E        0x0d90
+#define RADEON_DISP_LIN_TRANS_GRPH_F        0x0d98
+#define RADEON_DP_BRUSH_BKGD_CLR            0x1478
+#define RADEON_DP_BRUSH_FRGD_CLR            0x147c
+#define RADEON_DP_CNTL                      0x16c0
+#       define RADEON_DST_X_LEFT_TO_RIGHT   (1 <<  0)
+#       define RADEON_DST_Y_TOP_TO_BOTTOM   (1 <<  1)
+#       define RADEON_DP_DST_TILE_LINEAR    (0 <<  3)
+#       define RADEON_DP_DST_TILE_MACRO     (1 <<  3)
+#       define RADEON_DP_DST_TILE_MICRO     (2 <<  3)
+#       define RADEON_DP_DST_TILE_BOTH      (3 <<  3)
+#define RADEON_DP_CNTL_XDIR_YDIR_YMAJOR     0x16d0
+#       define RADEON_DST_Y_MAJOR             (1 <<  2)
+#       define RADEON_DST_Y_DIR_TOP_TO_BOTTOM (1 << 15)
+#       define RADEON_DST_X_DIR_LEFT_TO_RIGHT (1 << 31)
+#define RADEON_DP_DATATYPE                  0x16c4
+#       define RADEON_HOST_BIG_ENDIAN_EN    (1 << 29)
+#define RADEON_DP_GUI_MASTER_CNTL           0x146c
+#       define RADEON_GMC_SRC_PITCH_OFFSET_CNTL   (1    <<  0)
+#       define RADEON_GMC_DST_PITCH_OFFSET_CNTL   (1    <<  1)
+#       define RADEON_GMC_SRC_CLIPPING            (1    <<  2)
+#       define RADEON_GMC_DST_CLIPPING            (1    <<  3)
+#       define RADEON_GMC_BRUSH_DATATYPE_MASK     (0x0f <<  4)
+#       define RADEON_GMC_BRUSH_8X8_MONO_FG_BG    (0    <<  4)
+#       define RADEON_GMC_BRUSH_8X8_MONO_FG_LA    (1    <<  4)
+#       define RADEON_GMC_BRUSH_1X8_MONO_FG_BG    (4    <<  4)
+#       define RADEON_GMC_BRUSH_1X8_MONO_FG_LA    (5    <<  4)
+#       define RADEON_GMC_BRUSH_32x1_MONO_FG_BG   (6    <<  4)
+#       define RADEON_GMC_BRUSH_32x1_MONO_FG_LA   (7    <<  4)
+#       define RADEON_GMC_BRUSH_32x32_MONO_FG_BG  (8    <<  4)
+#       define RADEON_GMC_BRUSH_32x32_MONO_FG_LA  (9    <<  4)
+#       define RADEON_GMC_BRUSH_8x8_COLOR         (10   <<  4)
+#       define RADEON_GMC_BRUSH_1X8_COLOR         (12   <<  4)
+#       define RADEON_GMC_BRUSH_SOLID_COLOR       (13   <<  4)
+#       define RADEON_GMC_BRUSH_NONE              (15   <<  4)
+#       define RADEON_GMC_DST_8BPP_CI             (2    <<  8)
+#       define RADEON_GMC_DST_15BPP               (3    <<  8)
+#       define RADEON_GMC_DST_16BPP               (4    <<  8)
+#       define RADEON_GMC_DST_24BPP               (5    <<  8)
+#       define RADEON_GMC_DST_32BPP               (6    <<  8)
+#       define RADEON_GMC_DST_8BPP_RGB            (7    <<  8)
+#       define RADEON_GMC_DST_Y8                  (8    <<  8)
+#       define RADEON_GMC_DST_RGB8                (9    <<  8)
+#       define RADEON_GMC_DST_VYUY                (11   <<  8)
+#       define RADEON_GMC_DST_YVYU                (12   <<  8)
+#       define RADEON_GMC_DST_AYUV444             (14   <<  8)
+#       define RADEON_GMC_DST_ARGB4444            (15   <<  8)
+#       define RADEON_GMC_DST_DATATYPE_MASK       (0x0f <<  8)
+#       define RADEON_GMC_DST_DATATYPE_SHIFT      8
+#       define RADEON_GMC_SRC_DATATYPE_MASK       (3    << 12)
+#       define RADEON_GMC_SRC_DATATYPE_MONO_FG_BG (0    << 12)
+#       define RADEON_GMC_SRC_DATATYPE_MONO_FG_LA (1    << 12)
+#       define RADEON_GMC_SRC_DATATYPE_COLOR      (3    << 12)
+#       define RADEON_GMC_BYTE_PIX_ORDER          (1    << 14)
+#       define RADEON_GMC_BYTE_MSB_TO_LSB         (0    << 14)
+#       define RADEON_GMC_BYTE_LSB_TO_MSB         (1    << 14)
+#       define RADEON_GMC_CONVERSION_TEMP         (1    << 15)
+#       define RADEON_GMC_CONVERSION_TEMP_6500    (0    << 15)
+#       define RADEON_GMC_CONVERSION_TEMP_9300    (1    << 15)
+#       define RADEON_GMC_ROP3_MASK               (0xff << 16)
+#       define RADEON_DP_SRC_SOURCE_MASK          (7    << 24)
+#       define RADEON_DP_SRC_SOURCE_MEMORY        (2    << 24)
+#       define RADEON_DP_SRC_SOURCE_HOST_DATA     (3    << 24)
+#       define RADEON_GMC_3D_FCN_EN               (1    << 27)
+#       define RADEON_GMC_CLR_CMP_CNTL_DIS        (1    << 28)
+#       define RADEON_GMC_AUX_CLIP_DIS            (1    << 29)
+#       define RADEON_GMC_WR_MSK_DIS              (1    << 30)
+#       define RADEON_GMC_LD_BRUSH_Y_X            (1    << 31)
+#       define RADEON_ROP3_ZERO             0x00000000
+#       define RADEON_ROP3_DSa              0x00880000
+#       define RADEON_ROP3_SDna             0x00440000
+#       define RADEON_ROP3_S                0x00cc0000
+#       define RADEON_ROP3_DSna             0x00220000
+#       define RADEON_ROP3_D                0x00aa0000
+#       define RADEON_ROP3_DSx              0x00660000
+#       define RADEON_ROP3_DSo              0x00ee0000
+#       define RADEON_ROP3_DSon             0x00110000
+#       define RADEON_ROP3_DSxn             0x00990000
+#       define RADEON_ROP3_Dn               0x00550000
+#       define RADEON_ROP3_SDno             0x00dd0000
+#       define RADEON_ROP3_Sn               0x00330000
+#       define RADEON_ROP3_DSno             0x00bb0000
+#       define RADEON_ROP3_DSan             0x00770000
+#       define RADEON_ROP3_ONE              0x00ff0000
+#       define RADEON_ROP3_DPa              0x00a00000
+#       define RADEON_ROP3_PDna             0x00500000
+#       define RADEON_ROP3_P                0x00f00000
+#       define RADEON_ROP3_DPna             0x000a0000
+#       define RADEON_ROP3_D                0x00aa0000
+#       define RADEON_ROP3_DPx              0x005a0000
+#       define RADEON_ROP3_DPo              0x00fa0000
+#       define RADEON_ROP3_DPon             0x00050000
+#       define RADEON_ROP3_PDxn             0x00a50000
+#       define RADEON_ROP3_PDno             0x00f50000
+#       define RADEON_ROP3_Pn               0x000f0000
+#       define RADEON_ROP3_DPno             0x00af0000
+#       define RADEON_ROP3_DPan             0x005f0000
+#define RADEON_DP_GUI_MASTER_CNTL_C         0x1c84
+#define RADEON_DP_MIX                       0x16c8
+#define RADEON_DP_SRC_BKGD_CLR              0x15dc
+#define RADEON_DP_SRC_FRGD_CLR              0x15d8
+#define RADEON_DP_WRITE_MASK                0x16cc
+#define RADEON_DST_BRES_DEC                 0x1630
+#define RADEON_DST_BRES_ERR                 0x1628
+#define RADEON_DST_BRES_INC                 0x162c
+#define RADEON_DST_BRES_LNTH                0x1634
+#define RADEON_DST_BRES_LNTH_SUB            0x1638
+#define RADEON_DST_HEIGHT                   0x1410
+#define RADEON_DST_HEIGHT_WIDTH             0x143c
+#define RADEON_DST_HEIGHT_WIDTH_8           0x158c
+#define RADEON_DST_HEIGHT_WIDTH_BW          0x15b4
+#define RADEON_DST_HEIGHT_Y                 0x15a0
+#define RADEON_DST_LINE_START               0x1600
+#define RADEON_DST_LINE_END                 0x1604
+#define RADEON_DST_LINE_PATCOUNT            0x1608
+#       define RADEON_BRES_CNTL_SHIFT       8
+#define RADEON_DST_OFFSET                   0x1404
+#define RADEON_DST_PITCH                    0x1408
+#define RADEON_DST_PITCH_OFFSET             0x142c
+#define RADEON_DST_PITCH_OFFSET_C           0x1c80
+#       define RADEON_PITCH_SHIFT           21
+#       define RADEON_DST_TILE_LINEAR       (0 << 30)
+#       define RADEON_DST_TILE_MACRO        (1 << 30)
+#       define RADEON_DST_TILE_MICRO        (2 << 30)
+#       define RADEON_DST_TILE_BOTH         (3 << 30)
+#define RADEON_DST_WIDTH                    0x140c
+#define RADEON_DST_WIDTH_HEIGHT             0x1598
+#define RADEON_DST_WIDTH_X                  0x1588
+#define RADEON_DST_WIDTH_X_INCY             0x159c
+#define RADEON_DST_X                        0x141c
+#define RADEON_DST_X_SUB                    0x15a4
+#define RADEON_DST_X_Y                      0x1594
+#define RADEON_DST_Y                        0x1420
+#define RADEON_DST_Y_SUB                    0x15a8
+#define RADEON_DST_Y_X                      0x1438
+
+#define RADEON_FCP_CNTL                     0x0910
+#      define RADEON_FCP0_SRC_PCICLK             0
+#      define RADEON_FCP0_SRC_PCLK               1
+#      define RADEON_FCP0_SRC_PCLKb              2
+#      define RADEON_FCP0_SRC_HREF               3
+#      define RADEON_FCP0_SRC_GND                4
+#      define RADEON_FCP0_SRC_HREFb              5
+#define RADEON_FLUSH_1                      0x1704
+#define RADEON_FLUSH_2                      0x1708
+#define RADEON_FLUSH_3                      0x170c
+#define RADEON_FLUSH_4                      0x1710
+#define RADEON_FLUSH_5                      0x1714
+#define RADEON_FLUSH_6                      0x1718
+#define RADEON_FLUSH_7                      0x171c
+#define RADEON_FOG_3D_TABLE_START           0x1810
+#define RADEON_FOG_3D_TABLE_END             0x1814
+#define RADEON_FOG_3D_TABLE_DENSITY         0x181c
+#define RADEON_FOG_TABLE_INDEX              0x1a14
+#define RADEON_FOG_TABLE_DATA               0x1a18
+#define RADEON_FP_CRTC_H_TOTAL_DISP         0x0250
+#define RADEON_FP_CRTC_V_TOTAL_DISP         0x0254
+#       define RADEON_FP_CRTC_H_TOTAL_MASK      0x000003ff
+#       define RADEON_FP_CRTC_H_DISP_MASK       0x01ff0000
+#       define RADEON_FP_CRTC_V_TOTAL_MASK      0x00000fff
+#       define RADEON_FP_CRTC_V_DISP_MASK       0x0fff0000
+#       define RADEON_FP_H_SYNC_STRT_CHAR_MASK  0x00001ff8
+#       define RADEON_FP_H_SYNC_WID_MASK        0x003f0000
+#       define RADEON_FP_V_SYNC_STRT_MASK       0x00000fff
+#       define RADEON_FP_V_SYNC_WID_MASK        0x001f0000
+#       define RADEON_FP_CRTC_H_TOTAL_SHIFT     0x00000000
+#       define RADEON_FP_CRTC_H_DISP_SHIFT      0x00000010
+#       define RADEON_FP_CRTC_V_TOTAL_SHIFT     0x00000000
+#       define RADEON_FP_CRTC_V_DISP_SHIFT      0x00000010
+#       define RADEON_FP_H_SYNC_STRT_CHAR_SHIFT 0x00000003
+#       define RADEON_FP_H_SYNC_WID_SHIFT       0x00000010
+#       define RADEON_FP_V_SYNC_STRT_SHIFT      0x00000000
+#       define RADEON_FP_V_SYNC_WID_SHIFT       0x00000010
+#define RADEON_FP_GEN_CNTL                  0x0284
+#       define RADEON_FP_FPON                  (1 <<  0)
+#       define RADEON_FP_BLANK_EN              (1 <<  1)
+#       define RADEON_FP_TMDS_EN               (1 <<  2)
+#       define RADEON_FP_PANEL_FORMAT          (1 <<  3)
+#       define RADEON_FP_EN_TMDS               (1 <<  7)
+#       define RADEON_FP_DETECT_SENSE          (1 <<  8)
+#       define RADEON_FP_DETECT_INT_POL        (1 <<  9)
+#       define R200_FP_SOURCE_SEL_MASK         (3 <<  10)
+#       define R200_FP_SOURCE_SEL_CRTC1        (0 <<  10)
+#       define R200_FP_SOURCE_SEL_CRTC2        (1 <<  10)
+#       define R200_FP_SOURCE_SEL_RMX          (2 <<  10)
+#       define R200_FP_SOURCE_SEL_TRANS        (3 <<  10)
+#       define RADEON_FP_SEL_CRTC1             (0 << 13)
+#       define RADEON_FP_SEL_CRTC2             (1 << 13)
+#       define R300_HPD_SEL(x)                 ((x) << 13)
+#       define RADEON_FP_CRTC_DONT_SHADOW_HPAR (1 << 15)
+#       define RADEON_FP_CRTC_DONT_SHADOW_VPAR (1 << 16)
+#       define RADEON_FP_CRTC_DONT_SHADOW_HEND (1 << 17)
+#       define RADEON_FP_CRTC_USE_SHADOW_VEND  (1 << 18)
+#       define RADEON_FP_RMX_HVSYNC_CONTROL_EN (1 << 20)
+#       define RADEON_FP_DFP_SYNC_SEL          (1 << 21)
+#       define RADEON_FP_CRTC_LOCK_8DOT        (1 << 22)
+#       define RADEON_FP_CRT_SYNC_SEL          (1 << 23)
+#       define RADEON_FP_USE_SHADOW_EN         (1 << 24)
+#       define RADEON_FP_CRT_SYNC_ALT          (1 << 26)
+#define RADEON_FP2_GEN_CNTL                 0x0288
+#       define RADEON_FP2_BLANK_EN             (1 <<  1)
+#       define RADEON_FP2_ON                   (1 <<  2)
+#       define RADEON_FP2_PANEL_FORMAT         (1 <<  3)
+#       define RADEON_FP2_DETECT_SENSE         (1 <<  8)
+#       define RADEON_FP2_DETECT_INT_POL       (1 <<  9)
+#       define R200_FP2_SOURCE_SEL_MASK        (3 << 10)
+#       define R200_FP2_SOURCE_SEL_CRTC1       (0 << 10)
+#       define R200_FP2_SOURCE_SEL_CRTC2       (1 << 10)
+#       define R200_FP2_SOURCE_SEL_RMX         (2 << 10)
+#       define R200_FP2_SOURCE_SEL_TRANS_UNIT  (3 << 10)
+#       define RADEON_FP2_SRC_SEL_MASK         (3 << 13)
+#       define RADEON_FP2_SRC_SEL_CRTC2        (1 << 13)
+#       define RADEON_FP2_FP_POL               (1 << 16)
+#       define RADEON_FP2_LP_POL               (1 << 17)
+#       define RADEON_FP2_SCK_POL              (1 << 18)
+#       define RADEON_FP2_LCD_CNTL_MASK        (7 << 19)
+#       define RADEON_FP2_PAD_FLOP_EN          (1 << 22)
+#       define RADEON_FP2_CRC_EN               (1 << 23)
+#       define RADEON_FP2_CRC_READ_EN          (1 << 24)
+#       define RADEON_FP2_DVO_EN               (1 << 25)
+#       define RADEON_FP2_DVO_RATE_SEL_SDR     (1 << 26)
+#       define R200_FP2_DVO_RATE_SEL_SDR       (1 << 27)
+#       define R300_FP2_DVO_CLOCK_MODE_SINGLE  (1 << 28)
+#       define R300_FP2_DVO_DUAL_CHANNEL_EN    (1 << 29)
+#define RADEON_FP_H_SYNC_STRT_WID           0x02c4
+#define RADEON_FP_H2_SYNC_STRT_WID          0x03c4
+#define RADEON_FP_HORZ_STRETCH              0x028c
+#define RADEON_FP_HORZ2_STRETCH             0x038c
+#       define RADEON_HORZ_STRETCH_RATIO_MASK 0xffff
+#       define RADEON_HORZ_STRETCH_RATIO_MAX  4096
+#       define RADEON_HORZ_PANEL_SIZE         (0x1ff   << 16)
+#       define RADEON_HORZ_PANEL_SHIFT        16
+#       define RADEON_HORZ_STRETCH_PIXREP     (0      << 25)
+#       define RADEON_HORZ_STRETCH_BLEND      (1      << 26)
+#       define RADEON_HORZ_STRETCH_ENABLE     (1      << 25)
+#       define RADEON_HORZ_AUTO_RATIO         (1      << 27)
+#       define RADEON_HORZ_FP_LOOP_STRETCH    (0x7    << 28)
+#       define RADEON_HORZ_AUTO_RATIO_INC     (1      << 31)
+#define RADEON_FP_HORZ_VERT_ACTIVE          0x0278
+#define RADEON_FP_V_SYNC_STRT_WID           0x02c8
+#define RADEON_FP_VERT_STRETCH              0x0290
+#define RADEON_FP_V2_SYNC_STRT_WID          0x03c8
+#define RADEON_FP_VERT2_STRETCH             0x0390
+#       define RADEON_VERT_PANEL_SIZE          (0xfff << 12)
+#       define RADEON_VERT_PANEL_SHIFT         12
+#       define RADEON_VERT_STRETCH_RATIO_MASK  0xfff
+#       define RADEON_VERT_STRETCH_RATIO_SHIFT 0
+#       define RADEON_VERT_STRETCH_RATIO_MAX   4096
+#       define RADEON_VERT_STRETCH_ENABLE      (1     << 25)
+#       define RADEON_VERT_STRETCH_LINEREP     (0     << 26)
+#       define RADEON_VERT_STRETCH_BLEND       (1     << 26)
+#       define RADEON_VERT_AUTO_RATIO_EN       (1     << 27)
+#	define RADEON_VERT_AUTO_RATIO_INC      (1     << 31)
+#       define RADEON_VERT_STRETCH_RESERVED    0x71000000
+#define RS400_FP_2ND_GEN_CNTL               0x0384
+#       define RS400_FP_2ND_ON              (1 << 0)
+#       define RS400_FP_2ND_BLANK_EN        (1 << 1)
+#       define RS400_TMDS_2ND_EN            (1 << 2)
+#       define RS400_PANEL_FORMAT_2ND       (1 << 3)
+#       define RS400_FP_2ND_EN_TMDS         (1 << 7)
+#       define RS400_FP_2ND_DETECT_SENSE    (1 << 8)
+#       define RS400_FP_2ND_SOURCE_SEL_MASK        (3 << 10)
+#       define RS400_FP_2ND_SOURCE_SEL_CRTC1       (0 << 10)
+#       define RS400_FP_2ND_SOURCE_SEL_CRTC2       (1 << 10)
+#       define RS400_FP_2ND_SOURCE_SEL_RMX         (2 << 10)
+#       define RS400_FP_2ND_DETECT_EN       (1 << 12)
+#       define RS400_HPD_2ND_SEL            (1 << 13)
+#define RS400_FP2_2_GEN_CNTL                0x0388
+#       define RS400_FP2_2_BLANK_EN         (1 << 1)
+#       define RS400_FP2_2_ON               (1 << 2)
+#       define RS400_FP2_2_PANEL_FORMAT     (1 << 3)
+#       define RS400_FP2_2_DETECT_SENSE     (1 << 8)
+#       define RS400_FP2_2_SOURCE_SEL_MASK        (3 << 10)
+#       define RS400_FP2_2_SOURCE_SEL_CRTC1       (0 << 10)
+#       define RS400_FP2_2_SOURCE_SEL_CRTC2       (1 << 10)
+#       define RS400_FP2_2_SOURCE_SEL_RMX         (2 << 10)
+#       define RS400_FP2_2_DVO2_EN          (1 << 25)
+#define RS400_TMDS2_CNTL                    0x0394
+#define RS400_TMDS2_TRANSMITTER_CNTL        0x03a4
+#       define RS400_TMDS2_PLLEN            (1 << 0)
+#       define RS400_TMDS2_PLLRST           (1 << 1)
+
+#define RADEON_GEN_INT_CNTL                 0x0040
+#	define RADEON_CRTC_VBLANK_MASK		(1 << 0)
+#	define RADEON_FP_DETECT_MASK		(1 << 4)
+#	define RADEON_CRTC2_VBLANK_MASK		(1 << 9)
+#	define RADEON_FP2_DETECT_MASK		(1 << 10)
+#	define RADEON_GUI_IDLE_MASK		(1 << 19)
+#	define RADEON_SW_INT_ENABLE		(1 << 25)
+#define RADEON_GEN_INT_STATUS               0x0044
+#	define AVIVO_DISPLAY_INT_STATUS		(1 << 0)
+#	define RADEON_CRTC_VBLANK_STAT		(1 << 0)
+#	define RADEON_CRTC_VBLANK_STAT_ACK	(1 << 0)
+#	define RADEON_FP_DETECT_STAT		(1 << 4)
+#	define RADEON_FP_DETECT_STAT_ACK	(1 << 4)
+#	define RADEON_CRTC2_VBLANK_STAT		(1 << 9)
+#	define RADEON_CRTC2_VBLANK_STAT_ACK	(1 << 9)
+#	define RADEON_FP2_DETECT_STAT		(1 << 10)
+#	define RADEON_FP2_DETECT_STAT_ACK	(1 << 10)
+#	define RADEON_GUI_IDLE_STAT		(1 << 19)
+#	define RADEON_GUI_IDLE_STAT_ACK		(1 << 19)
+#	define RADEON_SW_INT_FIRE		(1 << 26)
+#	define RADEON_SW_INT_TEST		(1 << 25)
+#	define RADEON_SW_INT_TEST_ACK		(1 << 25)
+#define RADEON_GENENB                       0x03c3 /* VGA */
+#define RADEON_GENFC_RD                     0x03ca /* VGA */
+#define RADEON_GENFC_WT                     0x03da /* VGA, 0x03ba */
+#define RADEON_GENMO_RD                     0x03cc /* VGA */
+#define RADEON_GENMO_WT                     0x03c2 /* VGA */
+#define RADEON_GENS0                        0x03c2 /* VGA */
+#define RADEON_GENS1                        0x03da /* VGA, 0x03ba */
+#define RADEON_GPIO_MONID                   0x0068 /* DDC interface via I2C */ /* DDC3 */
+#define RADEON_GPIO_MONIDB                  0x006c
+#define RADEON_GPIO_CRT2_DDC                0x006c
+#define RADEON_GPIO_DVI_DDC                 0x0064 /* DDC2 */
+#define RADEON_GPIO_VGA_DDC                 0x0060 /* DDC1 */
+#       define RADEON_GPIO_A_0              (1 <<  0)
+#       define RADEON_GPIO_A_1              (1 <<  1)
+#       define RADEON_GPIO_Y_0              (1 <<  8)
+#       define RADEON_GPIO_Y_1              (1 <<  9)
+#       define RADEON_GPIO_Y_SHIFT_0        8
+#       define RADEON_GPIO_Y_SHIFT_1        9
+#       define RADEON_GPIO_EN_0             (1 << 16)
+#       define RADEON_GPIO_EN_1             (1 << 17)
+#       define RADEON_GPIO_MASK_0           (1 << 24) /*??*/
+#       define RADEON_GPIO_MASK_1           (1 << 25) /*??*/
+#define RADEON_GRPH8_DATA                   0x03cf /* VGA */
+#define RADEON_GRPH8_IDX                    0x03ce /* VGA */
+#define RADEON_GUI_SCRATCH_REG0             0x15e0
+#define RADEON_GUI_SCRATCH_REG1             0x15e4
+#define RADEON_GUI_SCRATCH_REG2             0x15e8
+#define RADEON_GUI_SCRATCH_REG3             0x15ec
+#define RADEON_GUI_SCRATCH_REG4             0x15f0
+#define RADEON_GUI_SCRATCH_REG5             0x15f4
+
+#define RADEON_HEADER                       0x0f0e /* PCI */
+#define RADEON_HOST_DATA0                   0x17c0
+#define RADEON_HOST_DATA1                   0x17c4
+#define RADEON_HOST_DATA2                   0x17c8
+#define RADEON_HOST_DATA3                   0x17cc
+#define RADEON_HOST_DATA4                   0x17d0
+#define RADEON_HOST_DATA5                   0x17d4
+#define RADEON_HOST_DATA6                   0x17d8
+#define RADEON_HOST_DATA7                   0x17dc
+#define RADEON_HOST_DATA_LAST               0x17e0
+#define RADEON_HOST_PATH_CNTL               0x0130
+#	define RADEON_HP_LIN_RD_CACHE_DIS   (1 << 24)
+#	define RADEON_HDP_READ_BUFFER_INVALIDATE   (1 << 27)
+#       define RADEON_HDP_SOFT_RESET        (1 << 26)
+#       define RADEON_HDP_APER_CNTL         (1 << 23)
+#define RADEON_HTOTAL_CNTL                  0x0009 /* PLL */
+#       define RADEON_HTOT_CNTL_VGA_EN      (1 << 28)
+#define RADEON_HTOTAL2_CNTL                 0x002e /* PLL */
+
+       /* Multimedia I2C bus */
+#define RADEON_I2C_CNTL_0		    0x0090
+#       define RADEON_I2C_DONE              (1 << 0)
+#       define RADEON_I2C_NACK              (1 << 1)
+#       define RADEON_I2C_HALT              (1 << 2)
+#       define RADEON_I2C_SOFT_RST          (1 << 5)
+#       define RADEON_I2C_DRIVE_EN          (1 << 6)
+#       define RADEON_I2C_DRIVE_SEL         (1 << 7)
+#       define RADEON_I2C_START             (1 << 8)
+#       define RADEON_I2C_STOP              (1 << 9)
+#       define RADEON_I2C_RECEIVE           (1 << 10)
+#       define RADEON_I2C_ABORT             (1 << 11)
+#       define RADEON_I2C_GO                (1 << 12)
+#       define RADEON_I2C_PRESCALE_SHIFT    16
+#define RADEON_I2C_CNTL_1                   0x0094
+#       define RADEON_I2C_DATA_COUNT_SHIFT  0
+#       define RADEON_I2C_ADDR_COUNT_SHIFT  4
+#       define RADEON_I2C_INTRA_BYTE_DELAY_SHIFT   8
+#       define RADEON_I2C_SEL               (1 << 16)
+#       define RADEON_I2C_EN                (1 << 17)
+#       define RADEON_I2C_TIME_LIMIT_SHIFT  24
+#define RADEON_I2C_DATA			    0x0098
+
+#define RADEON_DVI_I2C_CNTL_0		    0x02e0
+#       define R200_DVI_I2C_PIN_SEL(x)      ((x) << 3)
+#       define R200_SEL_DDC1                0 /* depends on asic */
+#       define R200_SEL_DDC2                1 /* depends on asic */
+#       define R200_SEL_DDC3                2 /* depends on asic */
+#	define RADEON_SW_WANTS_TO_USE_DVI_I2C (1 << 13)
+#	define RADEON_SW_CAN_USE_DVI_I2C      (1 << 13)
+#	define RADEON_SW_DONE_USING_DVI_I2C   (1 << 14)
+#	define RADEON_HW_NEEDS_DVI_I2C        (1 << 14)
+#	define RADEON_ABORT_HW_DVI_I2C        (1 << 15)
+#	define RADEON_HW_USING_DVI_I2C        (1 << 15)
+#define RADEON_DVI_I2C_CNTL_1               0x02e4
+#define RADEON_DVI_I2C_DATA		    0x02e8
+
+#define RADEON_INTERRUPT_LINE               0x0f3c /* PCI */
+#define RADEON_INTERRUPT_PIN                0x0f3d /* PCI */
+#define RADEON_IO_BASE                      0x0f14 /* PCI */
+
+#define RADEON_LATENCY                      0x0f0d /* PCI */
+#define RADEON_LEAD_BRES_DEC                0x1608
+#define RADEON_LEAD_BRES_LNTH               0x161c
+#define RADEON_LEAD_BRES_LNTH_SUB           0x1624
+#define RADEON_LVDS_GEN_CNTL                0x02d0
+#       define RADEON_LVDS_ON               (1   <<  0)
+#       define RADEON_LVDS_DISPLAY_DIS      (1   <<  1)
+#       define RADEON_LVDS_PANEL_TYPE       (1   <<  2)
+#       define RADEON_LVDS_PANEL_FORMAT     (1   <<  3)
+#       define RADEON_LVDS_NO_FM            (0   <<  4)
+#       define RADEON_LVDS_2_GREY           (1   <<  4)
+#       define RADEON_LVDS_4_GREY           (2   <<  4)
+#       define RADEON_LVDS_RST_FM           (1   <<  6)
+#       define RADEON_LVDS_EN               (1   <<  7)
+#       define RADEON_LVDS_BL_MOD_LEVEL_SHIFT 8
+#       define RADEON_LVDS_BL_MOD_LEVEL_MASK (0xff << 8)
+#       define RADEON_LVDS_BL_MOD_EN        (1   << 16)
+#       define RADEON_LVDS_BL_CLK_SEL       (1   << 17)
+#       define RADEON_LVDS_DIGON            (1   << 18)
+#       define RADEON_LVDS_BLON             (1   << 19)
+#       define RADEON_LVDS_FP_POL_LOW       (1   << 20)
+#       define RADEON_LVDS_LP_POL_LOW       (1   << 21)
+#       define RADEON_LVDS_DTM_POL_LOW      (1   << 22)
+#       define RADEON_LVDS_SEL_CRTC2        (1   << 23)
+#       define RADEON_LVDS_FPDI_EN          (1   << 27)
+#       define RADEON_LVDS_HSYNC_DELAY_SHIFT        28
+#define RADEON_LVDS_PLL_CNTL                0x02d4
+#       define RADEON_HSYNC_DELAY_SHIFT     28
+#       define RADEON_HSYNC_DELAY_MASK      (0xf << 28)
+#       define RADEON_LVDS_PLL_EN           (1   << 16)
+#       define RADEON_LVDS_PLL_RESET        (1   << 17)
+#       define R300_LVDS_SRC_SEL_MASK       (3   << 18)
+#       define R300_LVDS_SRC_SEL_CRTC1      (0   << 18)
+#       define R300_LVDS_SRC_SEL_CRTC2      (1   << 18)
+#       define R300_LVDS_SRC_SEL_RMX        (2   << 18)
+#define RADEON_LVDS_SS_GEN_CNTL             0x02ec
+#       define RADEON_LVDS_PWRSEQ_DELAY1_SHIFT     16
+#       define RADEON_LVDS_PWRSEQ_DELAY2_SHIFT     20
+
+#define RADEON_MAX_LATENCY                  0x0f3f /* PCI */
+#define RADEON_DISPLAY_BASE_ADDR            0x23c
+#define RADEON_DISPLAY2_BASE_ADDR           0x33c
+#define RADEON_OV0_BASE_ADDR                0x43c
+#define RADEON_NB_TOM                       0x15c
+#define R300_MC_INIT_MISC_LAT_TIMER         0x180
+#       define R300_MC_DISP0R_INIT_LAT_SHIFT 8
+#       define R300_MC_DISP0R_INIT_LAT_MASK  0xf
+#       define R300_MC_DISP1R_INIT_LAT_SHIFT 12
+#       define R300_MC_DISP1R_INIT_LAT_MASK  0xf
+#define RADEON_MCLK_CNTL                    0x0012 /* PLL */
+#       define RADEON_MCLKA_SRC_SEL_MASK    0x7
+#       define RADEON_FORCEON_MCLKA         (1 << 16)
+#       define RADEON_FORCEON_MCLKB         (1 << 17)
+#       define RADEON_FORCEON_YCLKA         (1 << 18)
+#       define RADEON_FORCEON_YCLKB         (1 << 19)
+#       define RADEON_FORCEON_MC            (1 << 20)
+#       define RADEON_FORCEON_AIC           (1 << 21)
+#       define R300_DISABLE_MC_MCLKA        (1 << 21)
+#       define R300_DISABLE_MC_MCLKB        (1 << 21)
+#define RADEON_MCLK_MISC                    0x001f /* PLL */
+#       define RADEON_MC_MCLK_MAX_DYN_STOP_LAT (1 << 12)
+#       define RADEON_IO_MCLK_MAX_DYN_STOP_LAT (1 << 13)
+#       define RADEON_MC_MCLK_DYN_ENABLE    (1 << 14)
+#       define RADEON_IO_MCLK_DYN_ENABLE    (1 << 15)
+
+#define RADEON_GPIOPAD_MASK                 0x0198
+#define RADEON_GPIOPAD_A		    0x019c
+#define RADEON_GPIOPAD_EN                   0x01a0
+#define RADEON_GPIOPAD_Y                    0x01a4
+#define RADEON_MDGPIO_MASK                  0x01a8
+#define RADEON_MDGPIO_A                     0x01ac
+#define RADEON_MDGPIO_EN                    0x01b0
+#define RADEON_MDGPIO_Y                     0x01b4
+
+#define RADEON_MEM_ADDR_CONFIG              0x0148
+#define RADEON_MEM_BASE                     0x0f10 /* PCI */
+#define RADEON_MEM_CNTL                     0x0140
+#       define RADEON_MEM_NUM_CHANNELS_MASK 0x01
+#       define RADEON_MEM_USE_B_CH_ONLY     (1 <<  1)
+#       define RV100_HALF_MODE              (1 <<  3)
+#       define R300_MEM_NUM_CHANNELS_MASK   0x03
+#       define R300_MEM_USE_CD_CH_ONLY      (1 <<  2)
+#define RADEON_MEM_TIMING_CNTL              0x0144 /* EXT_MEM_CNTL */
+#define RADEON_MEM_INIT_LAT_TIMER           0x0154
+#define RADEON_MEM_INTF_CNTL                0x014c
+#define RADEON_MEM_SDRAM_MODE_REG           0x0158
+#       define RADEON_SDRAM_MODE_MASK       0xffff0000
+#       define RADEON_B3MEM_RESET_MASK      0x6fffffff
+#       define RADEON_MEM_CFG_TYPE_DDR      (1 << 30)
+#define RADEON_MEM_STR_CNTL                 0x0150
+#       define RADEON_MEM_PWRUP_COMPL_A     (1 <<  0)
+#       define RADEON_MEM_PWRUP_COMPL_B     (1 <<  1)
+#       define R300_MEM_PWRUP_COMPL_C       (1 <<  2)
+#       define R300_MEM_PWRUP_COMPL_D       (1 <<  3)
+#       define RADEON_MEM_PWRUP_COMPLETE    0x03
+#       define R300_MEM_PWRUP_COMPLETE      0x0f
+#define RADEON_MC_STATUS                    0x0150
+#       define RADEON_MC_IDLE               (1 << 2)
+#       define R300_MC_IDLE                 (1 << 4)
+#define RADEON_MEM_VGA_RP_SEL               0x003c
+#define RADEON_MEM_VGA_WP_SEL               0x0038
+#define RADEON_MIN_GRANT                    0x0f3e /* PCI */
+#define RADEON_MM_DATA                      0x0004
+#define RADEON_MM_INDEX                     0x0000
+#	define RADEON_MM_APER		(1 << 31)
+#define RADEON_MPLL_CNTL                    0x000e /* PLL */
+#define RADEON_MPP_TB_CONFIG                0x01c0 /* ? */
+#define RADEON_MPP_GP_CONFIG                0x01c8 /* ? */
+#define RADEON_SEPROM_CNTL1                 0x01c0
+#       define RADEON_SCK_PRESCALE_SHIFT    24
+#       define RADEON_SCK_PRESCALE_MASK     (0xff << 24)
+#define R300_MC_IND_INDEX                   0x01f8
+#       define R300_MC_IND_ADDR_MASK        0x3f
+#       define R300_MC_IND_WR_EN            (1 << 8)
+#define R300_MC_IND_DATA                    0x01fc
+#define R300_MC_READ_CNTL_AB                0x017c
+#       define R300_MEM_RBS_POSITION_A_MASK 0x03
+#define R300_MC_READ_CNTL_CD_mcind	    0x24
+#       define R300_MEM_RBS_POSITION_C_MASK 0x03
+
+#define RADEON_N_VIF_COUNT                  0x0248
+
+#define RADEON_OV0_AUTO_FLIP_CNTL           0x0470
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_SOFT_BUF_NUM        0x00000007
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_SOFT_REPEAT_FIELD   0x00000008
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_SOFT_BUF_ODD        0x00000010
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_IGNORE_REPEAT_FIELD 0x00000020
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_SOFT_EOF_TOGGLE     0x00000040
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_VID_PORT_SELECT     0x00000300
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_P1_FIRST_LINE_EVEN  0x00010000
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_SHIFT_EVEN_DOWN     0x00040000
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_SHIFT_ODD_DOWN      0x00080000
+#       define  RADEON_OV0_AUTO_FLIP_CNTL_FIELD_POL_SOURCE    0x00800000
+
+#define RADEON_OV0_COLOUR_CNTL              0x04E0
+#define RADEON_OV0_DEINTERLACE_PATTERN      0x0474
+#define RADEON_OV0_EXCLUSIVE_HORZ           0x0408
+#       define  RADEON_EXCL_HORZ_START_MASK        0x000000ff
+#       define  RADEON_EXCL_HORZ_END_MASK          0x0000ff00
+#       define  RADEON_EXCL_HORZ_BACK_PORCH_MASK   0x00ff0000
+#       define  RADEON_EXCL_HORZ_EXCLUSIVE_EN      0x80000000
+#define RADEON_OV0_EXCLUSIVE_VERT           0x040C
+#       define  RADEON_EXCL_VERT_START_MASK        0x000003ff
+#       define  RADEON_EXCL_VERT_END_MASK          0x03ff0000
+#define RADEON_OV0_FILTER_CNTL              0x04A0
+#       define RADEON_FILTER_PROGRAMMABLE_COEF            0x0
+#       define RADEON_FILTER_HC_COEF_HORZ_Y               0x1
+#       define RADEON_FILTER_HC_COEF_HORZ_UV              0x2
+#       define RADEON_FILTER_HC_COEF_VERT_Y               0x4
+#       define RADEON_FILTER_HC_COEF_VERT_UV              0x8
+#       define RADEON_FILTER_HARDCODED_COEF               0xf
+#       define RADEON_FILTER_COEF_MASK                    0xf
+
+#define RADEON_OV0_FOUR_TAP_COEF_0          0x04B0
+#define RADEON_OV0_FOUR_TAP_COEF_1          0x04B4
+#define RADEON_OV0_FOUR_TAP_COEF_2          0x04B8
+#define RADEON_OV0_FOUR_TAP_COEF_3          0x04BC
+#define RADEON_OV0_FOUR_TAP_COEF_4          0x04C0
+#define RADEON_OV0_FLAG_CNTL                0x04DC
+#define RADEON_OV0_GAMMA_000_00F            0x0d40
+#define RADEON_OV0_GAMMA_010_01F            0x0d44
+#define RADEON_OV0_GAMMA_020_03F            0x0d48
+#define RADEON_OV0_GAMMA_040_07F            0x0d4c
+#define RADEON_OV0_GAMMA_080_0BF            0x0e00
+#define RADEON_OV0_GAMMA_0C0_0FF            0x0e04
+#define RADEON_OV0_GAMMA_100_13F            0x0e08
+#define RADEON_OV0_GAMMA_140_17F            0x0e0c
+#define RADEON_OV0_GAMMA_180_1BF            0x0e10
+#define RADEON_OV0_GAMMA_1C0_1FF            0x0e14
+#define RADEON_OV0_GAMMA_200_23F            0x0e18
+#define RADEON_OV0_GAMMA_240_27F            0x0e1c
+#define RADEON_OV0_GAMMA_280_2BF            0x0e20
+#define RADEON_OV0_GAMMA_2C0_2FF            0x0e24
+#define RADEON_OV0_GAMMA_300_33F            0x0e28
+#define RADEON_OV0_GAMMA_340_37F            0x0e2c
+#define RADEON_OV0_GAMMA_380_3BF            0x0d50
+#define RADEON_OV0_GAMMA_3C0_3FF            0x0d54
+#define RADEON_OV0_GRAPHICS_KEY_CLR_LOW     0x04EC
+#define RADEON_OV0_GRAPHICS_KEY_CLR_HIGH    0x04F0
+#define RADEON_OV0_H_INC                    0x0480
+#define RADEON_OV0_KEY_CNTL                 0x04F4
+#       define  RADEON_VIDEO_KEY_FN_MASK    0x00000003L
+#       define  RADEON_VIDEO_KEY_FN_FALSE   0x00000000L
+#       define  RADEON_VIDEO_KEY_FN_TRUE    0x00000001L
+#       define  RADEON_VIDEO_KEY_FN_EQ      0x00000002L
+#       define  RADEON_VIDEO_KEY_FN_NE      0x00000003L
+#       define  RADEON_GRAPHIC_KEY_FN_MASK  0x00000030L
+#       define  RADEON_GRAPHIC_KEY_FN_FALSE 0x00000000L
+#       define  RADEON_GRAPHIC_KEY_FN_TRUE  0x00000010L
+#       define  RADEON_GRAPHIC_KEY_FN_EQ    0x00000020L
+#       define  RADEON_GRAPHIC_KEY_FN_NE    0x00000030L
+#       define  RADEON_CMP_MIX_MASK         0x00000100L
+#       define  RADEON_CMP_MIX_OR           0x00000000L
+#       define  RADEON_CMP_MIX_AND          0x00000100L
+#define RADEON_OV0_LIN_TRANS_A              0x0d20
+#define RADEON_OV0_LIN_TRANS_B              0x0d24
+#define RADEON_OV0_LIN_TRANS_C              0x0d28
+#define RADEON_OV0_LIN_TRANS_D              0x0d2c
+#define RADEON_OV0_LIN_TRANS_E              0x0d30
+#define RADEON_OV0_LIN_TRANS_F              0x0d34
+#define RADEON_OV0_P1_BLANK_LINES_AT_TOP    0x0430
+#       define  RADEON_P1_BLNK_LN_AT_TOP_M1_MASK   0x00000fffL
+#       define  RADEON_P1_ACTIVE_LINES_M1          0x0fff0000L
+#define RADEON_OV0_P1_H_ACCUM_INIT          0x0488
+#define RADEON_OV0_P1_V_ACCUM_INIT          0x0428
+#       define  RADEON_OV0_P1_MAX_LN_IN_PER_LN_OUT 0x00000003L
+#       define  RADEON_OV0_P1_V_ACCUM_INIT_MASK    0x01ff8000L
+#define RADEON_OV0_P1_X_START_END           0x0494
+#define RADEON_OV0_P2_X_START_END           0x0498
+#define RADEON_OV0_P23_BLANK_LINES_AT_TOP   0x0434
+#       define  RADEON_P23_BLNK_LN_AT_TOP_M1_MASK  0x000007ffL
+#       define  RADEON_P23_ACTIVE_LINES_M1         0x07ff0000L
+#define RADEON_OV0_P23_H_ACCUM_INIT         0x048C
+#define RADEON_OV0_P23_V_ACCUM_INIT         0x042C
+#define RADEON_OV0_P3_X_START_END           0x049C
+#define RADEON_OV0_REG_LOAD_CNTL            0x0410
+#       define  RADEON_REG_LD_CTL_LOCK                 0x00000001L
+#       define  RADEON_REG_LD_CTL_VBLANK_DURING_LOCK   0x00000002L
+#       define  RADEON_REG_LD_CTL_STALL_GUI_UNTIL_FLIP 0x00000004L
+#       define  RADEON_REG_LD_CTL_LOCK_READBACK        0x00000008L
+#       define  RADEON_REG_LD_CTL_FLIP_READBACK        0x00000010L
+#define RADEON_OV0_SCALE_CNTL               0x0420
+#       define  RADEON_SCALER_HORZ_PICK_NEAREST    0x00000004L
+#       define  RADEON_SCALER_VERT_PICK_NEAREST    0x00000008L
+#       define  RADEON_SCALER_SIGNED_UV            0x00000010L
+#       define  RADEON_SCALER_GAMMA_SEL_MASK       0x00000060L
+#       define  RADEON_SCALER_GAMMA_SEL_BRIGHT     0x00000000L
+#       define  RADEON_SCALER_GAMMA_SEL_G22        0x00000020L
+#       define  RADEON_SCALER_GAMMA_SEL_G18        0x00000040L
+#       define  RADEON_SCALER_GAMMA_SEL_G14        0x00000060L
+#       define  RADEON_SCALER_COMCORE_SHIFT_UP_ONE 0x00000080L
+#       define  RADEON_SCALER_SURFAC_FORMAT        0x00000f00L
+#       define  RADEON_SCALER_SOURCE_15BPP         0x00000300L
+#       define  RADEON_SCALER_SOURCE_16BPP         0x00000400L
+#       define  RADEON_SCALER_SOURCE_32BPP         0x00000600L
+#       define  RADEON_SCALER_SOURCE_YUV9          0x00000900L
+#       define  RADEON_SCALER_SOURCE_YUV12         0x00000A00L
+#       define  RADEON_SCALER_SOURCE_VYUY422       0x00000B00L
+#       define  RADEON_SCALER_SOURCE_YVYU422       0x00000C00L
+#       define  RADEON_SCALER_ADAPTIVE_DEINT       0x00001000L
+#       define  RADEON_SCALER_TEMPORAL_DEINT       0x00002000L
+#       define  RADEON_SCALER_CRTC_SEL             0x00004000L
+#       define  RADEON_SCALER_SMART_SWITCH         0x00008000L
+#       define  RADEON_SCALER_BURST_PER_PLANE      0x007F0000L
+#       define  RADEON_SCALER_DOUBLE_BUFFER        0x01000000L
+#       define  RADEON_SCALER_DIS_LIMIT            0x08000000L
+#       define  RADEON_SCALER_LIN_TRANS_BYPASS     0x10000000L
+#       define  RADEON_SCALER_INT_EMU              0x20000000L
+#       define  RADEON_SCALER_ENABLE               0x40000000L
+#       define  RADEON_SCALER_SOFT_RESET           0x80000000L
+#define RADEON_OV0_STEP_BY                  0x0484
+#define RADEON_OV0_TEST                     0x04F8
+#define RADEON_OV0_V_INC                    0x0424
+#define RADEON_OV0_VID_BUF_PITCH0_VALUE     0x0460
+#define RADEON_OV0_VID_BUF_PITCH1_VALUE     0x0464
+#define RADEON_OV0_VID_BUF0_BASE_ADRS       0x0440
+#       define  RADEON_VIF_BUF0_PITCH_SEL          0x00000001L
+#       define  RADEON_VIF_BUF0_TILE_ADRS          0x00000002L
+#       define  RADEON_VIF_BUF0_BASE_ADRS_MASK     0x03fffff0L
+#       define  RADEON_VIF_BUF0_1ST_LINE_LSBS_MASK 0x48000000L
+#define RADEON_OV0_VID_BUF1_BASE_ADRS       0x0444
+#       define  RADEON_VIF_BUF1_PITCH_SEL          0x00000001L
+#       define  RADEON_VIF_BUF1_TILE_ADRS          0x00000002L
+#       define  RADEON_VIF_BUF1_BASE_ADRS_MASK     0x03fffff0L
+#       define  RADEON_VIF_BUF1_1ST_LINE_LSBS_MASK 0x48000000L
+#define RADEON_OV0_VID_BUF2_BASE_ADRS       0x0448
+#       define  RADEON_VIF_BUF2_PITCH_SEL          0x00000001L
+#       define  RADEON_VIF_BUF2_TILE_ADRS          0x00000002L
+#       define  RADEON_VIF_BUF2_BASE_ADRS_MASK     0x03fffff0L
+#       define  RADEON_VIF_BUF2_1ST_LINE_LSBS_MASK 0x48000000L
+#define RADEON_OV0_VID_BUF3_BASE_ADRS       0x044C
+#define RADEON_OV0_VID_BUF4_BASE_ADRS       0x0450
+#define RADEON_OV0_VID_BUF5_BASE_ADRS       0x0454
+#define RADEON_OV0_VIDEO_KEY_CLR_HIGH       0x04E8
+#define RADEON_OV0_VIDEO_KEY_CLR_LOW        0x04E4
+#define RADEON_OV0_Y_X_START                0x0400
+#define RADEON_OV0_Y_X_END                  0x0404
+#define RADEON_OV1_Y_X_START                0x0600
+#define RADEON_OV1_Y_X_END                  0x0604
+#define RADEON_OVR_CLR                      0x0230
+#define RADEON_OVR_WID_LEFT_RIGHT           0x0234
+#define RADEON_OVR_WID_TOP_BOTTOM           0x0238
+#define RADEON_OVR2_CLR                     0x0330
+#define RADEON_OVR2_WID_LEFT_RIGHT          0x0334
+#define RADEON_OVR2_WID_TOP_BOTTOM          0x0338
+
+/* first capture unit */
+
+#define RADEON_CAP0_BUF0_OFFSET           0x0920
+#define RADEON_CAP0_BUF1_OFFSET           0x0924
+#define RADEON_CAP0_BUF0_EVEN_OFFSET      0x0928
+#define RADEON_CAP0_BUF1_EVEN_OFFSET      0x092C
+
+#define RADEON_CAP0_BUF_PITCH             0x0930
+#define RADEON_CAP0_V_WINDOW              0x0934
+#define RADEON_CAP0_H_WINDOW              0x0938
+#define RADEON_CAP0_VBI0_OFFSET           0x093C
+#define RADEON_CAP0_VBI1_OFFSET           0x0940
+#define RADEON_CAP0_VBI_V_WINDOW          0x0944
+#define RADEON_CAP0_VBI_H_WINDOW          0x0948
+#define RADEON_CAP0_PORT_MODE_CNTL        0x094C
+#define RADEON_CAP0_TRIG_CNTL             0x0950
+#define RADEON_CAP0_DEBUG                 0x0954
+#define RADEON_CAP0_CONFIG                0x0958
+#       define RADEON_CAP0_CONFIG_CONTINUOS          0x00000001
+#       define RADEON_CAP0_CONFIG_START_FIELD_EVEN   0x00000002
+#       define RADEON_CAP0_CONFIG_START_BUF_GET      0x00000004
+#       define RADEON_CAP0_CONFIG_START_BUF_SET      0x00000008
+#       define RADEON_CAP0_CONFIG_BUF_TYPE_ALT       0x00000010
+#       define RADEON_CAP0_CONFIG_BUF_TYPE_FRAME     0x00000020
+#       define RADEON_CAP0_CONFIG_ONESHOT_MODE_FRAME 0x00000040
+#       define RADEON_CAP0_CONFIG_BUF_MODE_DOUBLE    0x00000080
+#       define RADEON_CAP0_CONFIG_BUF_MODE_TRIPLE    0x00000100
+#       define RADEON_CAP0_CONFIG_MIRROR_EN          0x00000200
+#       define RADEON_CAP0_CONFIG_ONESHOT_MIRROR_EN  0x00000400
+#       define RADEON_CAP0_CONFIG_VIDEO_SIGNED_UV    0x00000800
+#       define RADEON_CAP0_CONFIG_ANC_DECODE_EN      0x00001000
+#       define RADEON_CAP0_CONFIG_VBI_EN             0x00002000
+#       define RADEON_CAP0_CONFIG_SOFT_PULL_DOWN_EN  0x00004000
+#       define RADEON_CAP0_CONFIG_VIP_EXTEND_FLAG_EN 0x00008000
+#       define RADEON_CAP0_CONFIG_FAKE_FIELD_EN      0x00010000
+#       define RADEON_CAP0_CONFIG_ODD_ONE_MORE_LINE  0x00020000
+#       define RADEON_CAP0_CONFIG_EVEN_ONE_MORE_LINE 0x00040000
+#       define RADEON_CAP0_CONFIG_HORZ_DIVIDE_2      0x00080000
+#       define RADEON_CAP0_CONFIG_HORZ_DIVIDE_4      0x00100000
+#       define RADEON_CAP0_CONFIG_VERT_DIVIDE_2      0x00200000
+#       define RADEON_CAP0_CONFIG_VERT_DIVIDE_4      0x00400000
+#       define RADEON_CAP0_CONFIG_FORMAT_BROOKTREE   0x00000000
+#       define RADEON_CAP0_CONFIG_FORMAT_CCIR656     0x00800000
+#       define RADEON_CAP0_CONFIG_FORMAT_ZV          0x01000000
+#       define RADEON_CAP0_CONFIG_FORMAT_VIP         0x01800000
+#       define RADEON_CAP0_CONFIG_FORMAT_TRANSPORT   0x02000000
+#       define RADEON_CAP0_CONFIG_HORZ_DECIMATOR     0x04000000
+#       define RADEON_CAP0_CONFIG_VIDEO_IN_YVYU422   0x00000000
+#       define RADEON_CAP0_CONFIG_VIDEO_IN_VYUY422   0x20000000
+#       define RADEON_CAP0_CONFIG_VBI_DIVIDE_2       0x40000000
+#       define RADEON_CAP0_CONFIG_VBI_DIVIDE_4       0x80000000
+#define RADEON_CAP0_ANC_ODD_OFFSET        0x095C
+#define RADEON_CAP0_ANC_EVEN_OFFSET       0x0960
+#define RADEON_CAP0_ANC_H_WINDOW          0x0964
+#define RADEON_CAP0_VIDEO_SYNC_TEST       0x0968
+#define RADEON_CAP0_ONESHOT_BUF_OFFSET    0x096C
+#define RADEON_CAP0_BUF_STATUS            0x0970
+/* #define RADEON_CAP0_DWNSC_XRATIO       0x0978 */
+/* #define RADEON_CAP0_XSHARPNESS                 0x097C */
+#define RADEON_CAP0_VBI2_OFFSET           0x0980
+#define RADEON_CAP0_VBI3_OFFSET           0x0984
+#define RADEON_CAP0_ANC2_OFFSET           0x0988
+#define RADEON_CAP0_ANC3_OFFSET           0x098C
+#define RADEON_VID_BUFFER_CONTROL         0x0900
+
+/* second capture unit */
+
+#define RADEON_CAP1_BUF0_OFFSET           0x0990
+#define RADEON_CAP1_BUF1_OFFSET           0x0994
+#define RADEON_CAP1_BUF0_EVEN_OFFSET      0x0998
+#define RADEON_CAP1_BUF1_EVEN_OFFSET      0x099C
+
+#define RADEON_CAP1_BUF_PITCH             0x09A0
+#define RADEON_CAP1_V_WINDOW              0x09A4
+#define RADEON_CAP1_H_WINDOW              0x09A8
+#define RADEON_CAP1_VBI_ODD_OFFSET        0x09AC
+#define RADEON_CAP1_VBI_EVEN_OFFSET       0x09B0
+#define RADEON_CAP1_VBI_V_WINDOW                  0x09B4
+#define RADEON_CAP1_VBI_H_WINDOW                  0x09B8
+#define RADEON_CAP1_PORT_MODE_CNTL        0x09BC
+#define RADEON_CAP1_TRIG_CNTL             0x09C0
+#define RADEON_CAP1_DEBUG                         0x09C4
+#define RADEON_CAP1_CONFIG                0x09C8
+#define RADEON_CAP1_ANC_ODD_OFFSET        0x09CC
+#define RADEON_CAP1_ANC_EVEN_OFFSET       0x09D0
+#define RADEON_CAP1_ANC_H_WINDOW                  0x09D4
+#define RADEON_CAP1_VIDEO_SYNC_TEST       0x09D8
+#define RADEON_CAP1_ONESHOT_BUF_OFFSET    0x09DC
+#define RADEON_CAP1_BUF_STATUS            0x09E0
+#define RADEON_CAP1_DWNSC_XRATIO                  0x09E8
+#define RADEON_CAP1_XSHARPNESS            0x09EC
+
+/* misc multimedia registers */
+
+#define RADEON_IDCT_RUNS                  0x1F80
+#define RADEON_IDCT_LEVELS                0x1F84
+#define RADEON_IDCT_CONTROL               0x1FBC
+#define RADEON_IDCT_AUTH_CONTROL          0x1F88
+#define RADEON_IDCT_AUTH                  0x1F8C
+
+#define RADEON_P2PLL_CNTL                   0x002a /* P2PLL */
+#       define RADEON_P2PLL_RESET                (1 <<  0)
+#       define RADEON_P2PLL_SLEEP                (1 <<  1)
+#       define RADEON_P2PLL_PVG_MASK             (7 << 11)
+#       define RADEON_P2PLL_PVG_SHIFT            11
+#       define RADEON_P2PLL_ATOMIC_UPDATE_EN     (1 << 16)
+#       define RADEON_P2PLL_VGA_ATOMIC_UPDATE_EN (1 << 17)
+#       define RADEON_P2PLL_ATOMIC_UPDATE_VSYNC  (1 << 18)
+#define RADEON_P2PLL_DIV_0                  0x002c
+#       define RADEON_P2PLL_FB0_DIV_MASK    0x07ff
+#       define RADEON_P2PLL_POST0_DIV_MASK  0x00070000
+#define RADEON_P2PLL_REF_DIV                0x002B /* PLL */
+#       define RADEON_P2PLL_REF_DIV_MASK    0x03ff
+#       define RADEON_P2PLL_ATOMIC_UPDATE_R (1 << 15) /* same as _W */
+#       define RADEON_P2PLL_ATOMIC_UPDATE_W (1 << 15) /* same as _R */
+#       define R300_PPLL_REF_DIV_ACC_MASK   (0x3ff << 18)
+#       define R300_PPLL_REF_DIV_ACC_SHIFT  18
+#define RADEON_PALETTE_DATA                 0x00b4
+#define RADEON_PALETTE_30_DATA              0x00b8
+#define RADEON_PALETTE_INDEX                0x00b0
+#define RADEON_PCI_GART_PAGE                0x017c
+#define RADEON_PIXCLKS_CNTL                 0x002d
+#       define RADEON_PIX2CLK_SRC_SEL_MASK     0x03
+#       define RADEON_PIX2CLK_SRC_SEL_CPUCLK   0x00
+#       define RADEON_PIX2CLK_SRC_SEL_PSCANCLK 0x01
+#       define RADEON_PIX2CLK_SRC_SEL_BYTECLK  0x02
+#       define RADEON_PIX2CLK_SRC_SEL_P2PLLCLK 0x03
+#       define RADEON_PIX2CLK_ALWAYS_ONb       (1<<6)
+#       define RADEON_PIX2CLK_DAC_ALWAYS_ONb   (1<<7)
+#       define RADEON_PIXCLK_TV_SRC_SEL        (1 << 8)
+#       define RADEON_DISP_TVOUT_PIXCLK_TV_ALWAYS_ONb (1 << 9)
+#       define R300_DVOCLK_ALWAYS_ONb          (1 << 10)
+#       define RADEON_PIXCLK_BLEND_ALWAYS_ONb  (1 << 11)
+#       define RADEON_PIXCLK_GV_ALWAYS_ONb     (1 << 12)
+#       define RADEON_PIXCLK_DIG_TMDS_ALWAYS_ONb (1 << 13)
+#       define R300_PIXCLK_DVO_ALWAYS_ONb      (1 << 13)
+#       define RADEON_PIXCLK_LVDS_ALWAYS_ONb   (1 << 14)
+#       define RADEON_PIXCLK_TMDS_ALWAYS_ONb   (1 << 15)
+#       define R300_PIXCLK_TRANS_ALWAYS_ONb    (1 << 16)
+#       define R300_PIXCLK_TVO_ALWAYS_ONb      (1 << 17)
+#       define R300_P2G2CLK_ALWAYS_ONb         (1 << 18)
+#       define R300_P2G2CLK_DAC_ALWAYS_ONb     (1 << 19)
+#       define R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF (1 << 23)
+#define RADEON_PLANE_3D_MASK_C              0x1d44
+#define RADEON_PLL_TEST_CNTL                0x0013 /* PLL */
+#       define RADEON_PLL_MASK_READ_B          (1 << 9)
+#define RADEON_PMI_CAP_ID                   0x0f5c /* PCI */
+#define RADEON_PMI_DATA                     0x0f63 /* PCI */
+#define RADEON_PMI_NXT_CAP_PTR              0x0f5d /* PCI */
+#define RADEON_PMI_PMC_REG                  0x0f5e /* PCI */
+#define RADEON_PMI_PMCSR_REG                0x0f60 /* PCI */
+#define RADEON_PMI_REGISTER                 0x0f5c /* PCI */
+#define RADEON_PPLL_CNTL                    0x0002 /* PLL */
+#       define RADEON_PPLL_RESET                (1 <<  0)
+#       define RADEON_PPLL_SLEEP                (1 <<  1)
+#       define RADEON_PPLL_PVG_MASK             (7 << 11)
+#       define RADEON_PPLL_PVG_SHIFT            11
+#       define RADEON_PPLL_ATOMIC_UPDATE_EN     (1 << 16)
+#       define RADEON_PPLL_VGA_ATOMIC_UPDATE_EN (1 << 17)
+#       define RADEON_PPLL_ATOMIC_UPDATE_VSYNC  (1 << 18)
+#define RADEON_PPLL_DIV_0                   0x0004 /* PLL */
+#define RADEON_PPLL_DIV_1                   0x0005 /* PLL */
+#define RADEON_PPLL_DIV_2                   0x0006 /* PLL */
+#define RADEON_PPLL_DIV_3                   0x0007 /* PLL */
+#       define RADEON_PPLL_FB3_DIV_MASK     0x07ff
+#       define RADEON_PPLL_POST3_DIV_MASK   0x00070000
+#define RADEON_PPLL_REF_DIV                 0x0003 /* PLL */
+#       define RADEON_PPLL_REF_DIV_MASK     0x03ff
+#       define RADEON_PPLL_ATOMIC_UPDATE_R  (1 << 15) /* same as _W */
+#       define RADEON_PPLL_ATOMIC_UPDATE_W  (1 << 15) /* same as _R */
+#define RADEON_PWR_MNGMT_CNTL_STATUS        0x0f60 /* PCI */
+
+#define RADEON_RBBM_GUICNTL                 0x172c
+#       define RADEON_HOST_DATA_SWAP_NONE   (0 << 0)
+#       define RADEON_HOST_DATA_SWAP_16BIT  (1 << 0)
+#       define RADEON_HOST_DATA_SWAP_32BIT  (2 << 0)
+#       define RADEON_HOST_DATA_SWAP_HDW    (3 << 0)
+#define RADEON_RBBM_SOFT_RESET              0x00f0
+#       define RADEON_SOFT_RESET_CP         (1 <<  0)
+#       define RADEON_SOFT_RESET_HI         (1 <<  1)
+#       define RADEON_SOFT_RESET_SE         (1 <<  2)
+#       define RADEON_SOFT_RESET_RE         (1 <<  3)
+#       define RADEON_SOFT_RESET_PP         (1 <<  4)
+#       define RADEON_SOFT_RESET_E2         (1 <<  5)
+#       define RADEON_SOFT_RESET_RB         (1 <<  6)
+#       define RADEON_SOFT_RESET_HDP        (1 <<  7)
+#define RADEON_RBBM_STATUS                  0x0e40
+#       define RADEON_RBBM_FIFOCNT_MASK     0x007f
+#       define RADEON_RBBM_ACTIVE           (1 << 31)
+#define RADEON_RB2D_DSTCACHE_CTLSTAT        0x342c
+#       define RADEON_RB2D_DC_FLUSH         (3 << 0)
+#       define RADEON_RB2D_DC_FREE          (3 << 2)
+#       define RADEON_RB2D_DC_FLUSH_ALL     0xf
+#       define RADEON_RB2D_DC_BUSY          (1 << 31)
+#define RADEON_RB2D_DSTCACHE_MODE           0x3428
+#define RADEON_DSTCACHE_CTLSTAT             0x1714
+
+#define RADEON_RB3D_ZCACHE_MODE             0x3250
+#define RADEON_RB3D_ZCACHE_CTLSTAT          0x3254
+#       define RADEON_RB3D_ZC_FLUSH_ALL     0x5
+#define RADEON_RB3D_DSTCACHE_MODE           0x3258
+# define RADEON_RB3D_DC_CACHE_ENABLE            (0)
+# define RADEON_RB3D_DC_2D_CACHE_DISABLE        (1)
+# define RADEON_RB3D_DC_3D_CACHE_DISABLE        (2)
+# define RADEON_RB3D_DC_CACHE_DISABLE           (3)
+# define RADEON_RB3D_DC_2D_CACHE_LINESIZE_128   (1 << 2)
+# define RADEON_RB3D_DC_3D_CACHE_LINESIZE_128   (2 << 2)
+# define RADEON_RB3D_DC_2D_CACHE_AUTOFLUSH      (1 << 8)
+# define RADEON_RB3D_DC_3D_CACHE_AUTOFLUSH      (2 << 8)
+# define R200_RB3D_DC_2D_CACHE_AUTOFREE         (1 << 10)
+# define R200_RB3D_DC_3D_CACHE_AUTOFREE         (2 << 10)
+# define RADEON_RB3D_DC_FORCE_RMW               (1 << 16)
+# define RADEON_RB3D_DC_DISABLE_RI_FILL         (1 << 24)
+# define RADEON_RB3D_DC_DISABLE_RI_READ         (1 << 25)
+
+#define RADEON_RB3D_DSTCACHE_CTLSTAT            0x325C
+# define RADEON_RB3D_DC_FLUSH                   (3 << 0)
+# define RADEON_RB3D_DC_FREE                    (3 << 2)
+# define RADEON_RB3D_DC_FLUSH_ALL               0xf
+# define RADEON_RB3D_DC_BUSY                    (1 << 31)
+
+#define RADEON_REG_BASE                     0x0f18 /* PCI */
+#define RADEON_REGPROG_INF                  0x0f09 /* PCI */
+#define RADEON_REVISION_ID                  0x0f08 /* PCI */
+
+#define RADEON_SC_BOTTOM                    0x164c
+#define RADEON_SC_BOTTOM_RIGHT              0x16f0
+#define RADEON_SC_BOTTOM_RIGHT_C            0x1c8c
+#define RADEON_SC_LEFT                      0x1640
+#define RADEON_SC_RIGHT                     0x1644
+#define RADEON_SC_TOP                       0x1648
+#define RADEON_SC_TOP_LEFT                  0x16ec
+#define RADEON_SC_TOP_LEFT_C                0x1c88
+#       define RADEON_SC_SIGN_MASK_LO       0x8000
+#       define RADEON_SC_SIGN_MASK_HI       0x80000000
+#define RADEON_M_SPLL_REF_FB_DIV            0x000a /* PLL */
+#	define RADEON_M_SPLL_REF_DIV_SHIFT  0
+#	define RADEON_M_SPLL_REF_DIV_MASK   0xff
+#	define RADEON_MPLL_FB_DIV_SHIFT     8
+#	define RADEON_MPLL_FB_DIV_MASK      0xff
+#	define RADEON_SPLL_FB_DIV_SHIFT     16
+#	define RADEON_SPLL_FB_DIV_MASK      0xff
+#define RADEON_SPLL_CNTL                    0x000c /* PLL */
+#       define RADEON_SPLL_SLEEP            (1 << 0)
+#       define RADEON_SPLL_RESET            (1 << 1)
+#       define RADEON_SPLL_PCP_MASK         0x7
+#       define RADEON_SPLL_PCP_SHIFT        8
+#       define RADEON_SPLL_PVG_MASK         0x7
+#       define RADEON_SPLL_PVG_SHIFT        11
+#       define RADEON_SPLL_PDC_MASK         0x3
+#       define RADEON_SPLL_PDC_SHIFT        14
+#define RADEON_SCLK_CNTL                    0x000d /* PLL */
+#       define RADEON_SCLK_SRC_SEL_MASK     0x0007
+#       define RADEON_DYN_STOP_LAT_MASK     0x00007ff8
+#       define RADEON_CP_MAX_DYN_STOP_LAT   0x0008
+#       define RADEON_SCLK_FORCEON_MASK     0xffff8000
+#       define RADEON_SCLK_FORCE_DISP2      (1<<15)
+#       define RADEON_SCLK_FORCE_CP         (1<<16)
+#       define RADEON_SCLK_FORCE_HDP        (1<<17)
+#       define RADEON_SCLK_FORCE_DISP1      (1<<18)
+#       define RADEON_SCLK_FORCE_TOP        (1<<19)
+#       define RADEON_SCLK_FORCE_E2         (1<<20)
+#       define RADEON_SCLK_FORCE_SE         (1<<21)
+#       define RADEON_SCLK_FORCE_IDCT       (1<<22)
+#       define RADEON_SCLK_FORCE_VIP        (1<<23)
+#       define RADEON_SCLK_FORCE_RE         (1<<24)
+#       define RADEON_SCLK_FORCE_PB         (1<<25)
+#       define RADEON_SCLK_FORCE_TAM        (1<<26)
+#       define RADEON_SCLK_FORCE_TDM        (1<<27)
+#       define RADEON_SCLK_FORCE_RB         (1<<28)
+#       define RADEON_SCLK_FORCE_TV_SCLK    (1<<29)
+#       define RADEON_SCLK_FORCE_SUBPIC     (1<<30)
+#       define RADEON_SCLK_FORCE_OV0        (1<<31)
+#       define R300_SCLK_FORCE_VAP          (1<<21)
+#       define R300_SCLK_FORCE_SR           (1<<25)
+#       define R300_SCLK_FORCE_PX           (1<<26)
+#       define R300_SCLK_FORCE_TX           (1<<27)
+#       define R300_SCLK_FORCE_US           (1<<28)
+#       define R300_SCLK_FORCE_SU           (1<<30)
+#define R300_SCLK_CNTL2                     0x1e   /* PLL */
+#       define R300_SCLK_TCL_MAX_DYN_STOP_LAT (1<<10)
+#       define R300_SCLK_GA_MAX_DYN_STOP_LAT  (1<<11)
+#       define R300_SCLK_CBA_MAX_DYN_STOP_LAT (1<<12)
+#       define R300_SCLK_FORCE_TCL          (1<<13)
+#       define R300_SCLK_FORCE_CBA          (1<<14)
+#       define R300_SCLK_FORCE_GA           (1<<15)
+#define RADEON_SCLK_MORE_CNTL               0x0035 /* PLL */
+#       define RADEON_SCLK_MORE_MAX_DYN_STOP_LAT 0x0007
+#       define RADEON_SCLK_MORE_FORCEON     0x0700
+#define RADEON_SDRAM_MODE_REG               0x0158
+#define RADEON_SEQ8_DATA                    0x03c5 /* VGA */
+#define RADEON_SEQ8_IDX                     0x03c4 /* VGA */
+#define RADEON_SNAPSHOT_F_COUNT             0x0244
+#define RADEON_SNAPSHOT_VH_COUNTS           0x0240
+#define RADEON_SNAPSHOT_VIF_COUNT           0x024c
+#define RADEON_SRC_OFFSET                   0x15ac
+#define RADEON_SRC_PITCH                    0x15b0
+#define RADEON_SRC_PITCH_OFFSET             0x1428
+#define RADEON_SRC_SC_BOTTOM                0x165c
+#define RADEON_SRC_SC_BOTTOM_RIGHT          0x16f4
+#define RADEON_SRC_SC_RIGHT                 0x1654
+#define RADEON_SRC_X                        0x1414
+#define RADEON_SRC_X_Y                      0x1590
+#define RADEON_SRC_Y                        0x1418
+#define RADEON_SRC_Y_X                      0x1434
+#define RADEON_STATUS                       0x0f06 /* PCI */
+#define RADEON_SUBPIC_CNTL                  0x0540 /* ? */
+#define RADEON_SUB_CLASS                    0x0f0a /* PCI */
+#define RADEON_SURFACE_CNTL                 0x0b00
+#       define RADEON_SURF_TRANSLATION_DIS  (1 << 8)
+#       define RADEON_NONSURF_AP0_SWP_16BPP (1 << 20)
+#       define RADEON_NONSURF_AP0_SWP_32BPP (1 << 21)
+#       define RADEON_NONSURF_AP1_SWP_16BPP (1 << 22)
+#       define RADEON_NONSURF_AP1_SWP_32BPP (1 << 23)
+#define RADEON_SURFACE0_INFO                0x0b0c
+#       define RADEON_SURF_TILE_COLOR_MACRO (0 << 16)
+#       define RADEON_SURF_TILE_COLOR_BOTH  (1 << 16)
+#       define RADEON_SURF_TILE_DEPTH_32BPP (2 << 16)
+#       define RADEON_SURF_TILE_DEPTH_16BPP (3 << 16)
+#       define R200_SURF_TILE_NONE          (0 << 16)
+#       define R200_SURF_TILE_COLOR_MACRO   (1 << 16)
+#       define R200_SURF_TILE_COLOR_MICRO   (2 << 16)
+#       define R200_SURF_TILE_COLOR_BOTH    (3 << 16)
+#       define R200_SURF_TILE_DEPTH_32BPP   (4 << 16)
+#       define R200_SURF_TILE_DEPTH_16BPP   (5 << 16)
+#       define R300_SURF_TILE_NONE          (0 << 16)
+#       define R300_SURF_TILE_COLOR_MACRO   (1 << 16)
+#       define R300_SURF_TILE_DEPTH_32BPP   (2 << 16)
+#       define RADEON_SURF_AP0_SWP_16BPP    (1 << 20)
+#       define RADEON_SURF_AP0_SWP_32BPP    (1 << 21)
+#       define RADEON_SURF_AP1_SWP_16BPP    (1 << 22)
+#       define RADEON_SURF_AP1_SWP_32BPP    (1 << 23)
+#define RADEON_SURFACE0_LOWER_BOUND         0x0b04
+#define RADEON_SURFACE0_UPPER_BOUND         0x0b08
+#define RADEON_SURFACE1_INFO                0x0b1c
+#define RADEON_SURFACE1_LOWER_BOUND         0x0b14
+#define RADEON_SURFACE1_UPPER_BOUND         0x0b18
+#define RADEON_SURFACE2_INFO                0x0b2c
+#define RADEON_SURFACE2_LOWER_BOUND         0x0b24
+#define RADEON_SURFACE2_UPPER_BOUND         0x0b28
+#define RADEON_SURFACE3_INFO                0x0b3c
+#define RADEON_SURFACE3_LOWER_BOUND         0x0b34
+#define RADEON_SURFACE3_UPPER_BOUND         0x0b38
+#define RADEON_SURFACE4_INFO                0x0b4c
+#define RADEON_SURFACE4_LOWER_BOUND         0x0b44
+#define RADEON_SURFACE4_UPPER_BOUND         0x0b48
+#define RADEON_SURFACE5_INFO                0x0b5c
+#define RADEON_SURFACE5_LOWER_BOUND         0x0b54
+#define RADEON_SURFACE5_UPPER_BOUND         0x0b58
+#define RADEON_SURFACE6_INFO                0x0b6c
+#define RADEON_SURFACE6_LOWER_BOUND         0x0b64
+#define RADEON_SURFACE6_UPPER_BOUND         0x0b68
+#define RADEON_SURFACE7_INFO                0x0b7c
+#define RADEON_SURFACE7_LOWER_BOUND         0x0b74
+#define RADEON_SURFACE7_UPPER_BOUND         0x0b78
+#define RADEON_SW_SEMAPHORE                 0x013c
+
+#define RADEON_TEST_DEBUG_CNTL              0x0120
+#define RADEON_TEST_DEBUG_CNTL__TEST_DEBUG_OUT_EN 0x00000001
+
+#define RADEON_TEST_DEBUG_MUX               0x0124
+#define RADEON_TEST_DEBUG_OUT               0x012c
+#define RADEON_TMDS_PLL_CNTL                0x02a8
+#define RADEON_TMDS_TRANSMITTER_CNTL        0x02a4
+#       define RADEON_TMDS_TRANSMITTER_PLLEN  1
+#       define RADEON_TMDS_TRANSMITTER_PLLRST 2
+#define RADEON_TRAIL_BRES_DEC               0x1614
+#define RADEON_TRAIL_BRES_ERR               0x160c
+#define RADEON_TRAIL_BRES_INC               0x1610
+#define RADEON_TRAIL_X                      0x1618
+#define RADEON_TRAIL_X_SUB                  0x1620
+
+#define RADEON_VCLK_ECP_CNTL                0x0008 /* PLL */
+#       define RADEON_VCLK_SRC_SEL_MASK     0x03
+#       define RADEON_VCLK_SRC_SEL_CPUCLK   0x00
+#       define RADEON_VCLK_SRC_SEL_PSCANCLK 0x01
+#       define RADEON_VCLK_SRC_SEL_BYTECLK  0x02
+#       define RADEON_VCLK_SRC_SEL_PPLLCLK  0x03
+#       define RADEON_PIXCLK_ALWAYS_ONb     (1<<6)
+#       define RADEON_PIXCLK_DAC_ALWAYS_ONb (1<<7)
+#       define R300_DISP_DAC_PIXCLK_DAC_BLANK_OFF (1<<23)
+
+#define RADEON_VENDOR_ID                    0x0f00 /* PCI */
+#define RADEON_VGA_DDA_CONFIG               0x02e8
+#define RADEON_VGA_DDA_ON_OFF               0x02ec
+#define RADEON_VID_BUFFER_CONTROL           0x0900
+#define RADEON_VIDEOMUX_CNTL                0x0190
+
+/* VIP bus */
+#define RADEON_VIPH_CH0_DATA                0x0c00
+#define RADEON_VIPH_CH1_DATA                0x0c04
+#define RADEON_VIPH_CH2_DATA                0x0c08
+#define RADEON_VIPH_CH3_DATA                0x0c0c
+#define RADEON_VIPH_CH0_ADDR                0x0c10
+#define RADEON_VIPH_CH1_ADDR                0x0c14
+#define RADEON_VIPH_CH2_ADDR                0x0c18
+#define RADEON_VIPH_CH3_ADDR                0x0c1c
+#define RADEON_VIPH_CH0_SBCNT               0x0c20
+#define RADEON_VIPH_CH1_SBCNT               0x0c24
+#define RADEON_VIPH_CH2_SBCNT               0x0c28
+#define RADEON_VIPH_CH3_SBCNT               0x0c2c
+#define RADEON_VIPH_CH0_ABCNT               0x0c30
+#define RADEON_VIPH_CH1_ABCNT               0x0c34
+#define RADEON_VIPH_CH2_ABCNT               0x0c38
+#define RADEON_VIPH_CH3_ABCNT               0x0c3c
+#define RADEON_VIPH_CONTROL                 0x0c40
+#       define RADEON_VIP_BUSY 0
+#       define RADEON_VIP_IDLE 1
+#       define RADEON_VIP_RESET 2
+#       define RADEON_VIPH_EN               (1 << 21)
+#define RADEON_VIPH_DV_LAT                  0x0c44
+#define RADEON_VIPH_BM_CHUNK                0x0c48
+#define RADEON_VIPH_DV_INT                  0x0c4c
+#define RADEON_VIPH_TIMEOUT_STAT            0x0c50
+#define RADEON_VIPH_TIMEOUT_STAT__VIPH_REG_STAT 0x00000010
+#define RADEON_VIPH_TIMEOUT_STAT__VIPH_REG_AK   0x00000010
+#define RADEON_VIPH_TIMEOUT_STAT__VIPH_REGR_DIS 0x01000000
+
+#define RADEON_VIPH_REG_DATA                0x0084
+#define RADEON_VIPH_REG_ADDR                0x0080
+
+
+#define RADEON_WAIT_UNTIL                   0x1720
+#       define RADEON_WAIT_CRTC_PFLIP       (1 << 0)
+#       define RADEON_WAIT_RE_CRTC_VLINE    (1 << 1)
+#       define RADEON_WAIT_FE_CRTC_VLINE    (1 << 2)
+#       define RADEON_WAIT_CRTC_VLINE       (1 << 3)
+#       define RADEON_WAIT_DMA_VID_IDLE     (1 << 8)
+#       define RADEON_WAIT_DMA_GUI_IDLE     (1 << 9)
+#       define RADEON_WAIT_CMDFIFO          (1 << 10) /* wait for CMDFIFO_ENTRIES */
+#       define RADEON_WAIT_OV0_FLIP         (1 << 11)
+#       define RADEON_WAIT_AGP_FLUSH        (1 << 13)
+#       define RADEON_WAIT_2D_IDLE          (1 << 14)
+#       define RADEON_WAIT_3D_IDLE          (1 << 15)
+#       define RADEON_WAIT_2D_IDLECLEAN     (1 << 16)
+#       define RADEON_WAIT_3D_IDLECLEAN     (1 << 17)
+#       define RADEON_WAIT_HOST_IDLECLEAN   (1 << 18)
+#       define RADEON_CMDFIFO_ENTRIES_SHIFT 10
+#       define RADEON_CMDFIFO_ENTRIES_MASK  0x7f
+#       define RADEON_WAIT_VAP_IDLE         (1 << 28)
+#       define RADEON_WAIT_BOTH_CRTC_PFLIP  (1 << 30)
+#       define RADEON_ENG_DISPLAY_SELECT_CRTC0    (0 << 31)
+#       define RADEON_ENG_DISPLAY_SELECT_CRTC1    (1 << 31)
+
+#define RADEON_X_MPLL_REF_FB_DIV            0x000a /* PLL */
+#define RADEON_XCLK_CNTL                    0x000d /* PLL */
+#define RADEON_XDLL_CNTL                    0x000c /* PLL */
+#define RADEON_XPLL_CNTL                    0x000b /* PLL */
+
+
+
+				/* Registers for 3D/TCL */
+#define RADEON_PP_BORDER_COLOR_0            0x1d40
+#define RADEON_PP_BORDER_COLOR_1            0x1d44
+#define RADEON_PP_BORDER_COLOR_2            0x1d48
+#define RADEON_PP_CNTL                      0x1c38
+#       define RADEON_STIPPLE_ENABLE        (1 <<  0)
+#       define RADEON_SCISSOR_ENABLE        (1 <<  1)
+#       define RADEON_PATTERN_ENABLE        (1 <<  2)
+#       define RADEON_SHADOW_ENABLE         (1 <<  3)
+#       define RADEON_TEX_ENABLE_MASK       (0xf << 4)
+#       define RADEON_TEX_0_ENABLE          (1 <<  4)
+#       define RADEON_TEX_1_ENABLE          (1 <<  5)
+#       define RADEON_TEX_2_ENABLE          (1 <<  6)
+#       define RADEON_TEX_3_ENABLE          (1 <<  7)
+#       define RADEON_TEX_BLEND_ENABLE_MASK (0xf << 12)
+#       define RADEON_TEX_BLEND_0_ENABLE    (1 << 12)
+#       define RADEON_TEX_BLEND_1_ENABLE    (1 << 13)
+#       define RADEON_TEX_BLEND_2_ENABLE    (1 << 14)
+#       define RADEON_TEX_BLEND_3_ENABLE    (1 << 15)
+#       define RADEON_PLANAR_YUV_ENABLE     (1 << 20)
+#       define RADEON_SPECULAR_ENABLE       (1 << 21)
+#       define RADEON_FOG_ENABLE            (1 << 22)
+#       define RADEON_ALPHA_TEST_ENABLE     (1 << 23)
+#       define RADEON_ANTI_ALIAS_NONE       (0 << 24)
+#       define RADEON_ANTI_ALIAS_LINE       (1 << 24)
+#       define RADEON_ANTI_ALIAS_POLY       (2 << 24)
+#       define RADEON_ANTI_ALIAS_LINE_POLY  (3 << 24)
+#       define RADEON_BUMP_MAP_ENABLE       (1 << 26)
+#       define RADEON_BUMPED_MAP_T0         (0 << 27)
+#       define RADEON_BUMPED_MAP_T1         (1 << 27)
+#       define RADEON_BUMPED_MAP_T2         (2 << 27)
+#       define RADEON_TEX_3D_ENABLE_0       (1 << 29)
+#       define RADEON_TEX_3D_ENABLE_1       (1 << 30)
+#       define RADEON_MC_ENABLE             (1 << 31)
+#define RADEON_PP_FOG_COLOR                 0x1c18
+#       define RADEON_FOG_COLOR_MASK        0x00ffffff
+#       define RADEON_FOG_VERTEX            (0 << 24)
+#       define RADEON_FOG_TABLE             (1 << 24)
+#       define RADEON_FOG_USE_DEPTH         (0 << 25)
+#       define RADEON_FOG_USE_DIFFUSE_ALPHA (2 << 25)
+#       define RADEON_FOG_USE_SPEC_ALPHA    (3 << 25)
+#define RADEON_PP_LUM_MATRIX                0x1d00
+#define RADEON_PP_MISC                      0x1c14
+#       define RADEON_REF_ALPHA_MASK        0x000000ff
+#       define RADEON_ALPHA_TEST_FAIL       (0 << 8)
+#       define RADEON_ALPHA_TEST_LESS       (1 << 8)
+#       define RADEON_ALPHA_TEST_LEQUAL     (2 << 8)
+#       define RADEON_ALPHA_TEST_EQUAL      (3 << 8)
+#       define RADEON_ALPHA_TEST_GEQUAL     (4 << 8)
+#       define RADEON_ALPHA_TEST_GREATER    (5 << 8)
+#       define RADEON_ALPHA_TEST_NEQUAL     (6 << 8)
+#       define RADEON_ALPHA_TEST_PASS       (7 << 8)
+#       define RADEON_ALPHA_TEST_OP_MASK    (7 << 8)
+#       define RADEON_CHROMA_FUNC_FAIL      (0 << 16)
+#       define RADEON_CHROMA_FUNC_PASS      (1 << 16)
+#       define RADEON_CHROMA_FUNC_NEQUAL    (2 << 16)
+#       define RADEON_CHROMA_FUNC_EQUAL     (3 << 16)
+#       define RADEON_CHROMA_KEY_NEAREST    (0 << 18)
+#       define RADEON_CHROMA_KEY_ZERO       (1 << 18)
+#       define RADEON_SHADOW_ID_AUTO_INC    (1 << 20)
+#       define RADEON_SHADOW_FUNC_EQUAL     (0 << 21)
+#       define RADEON_SHADOW_FUNC_NEQUAL    (1 << 21)
+#       define RADEON_SHADOW_PASS_1         (0 << 22)
+#       define RADEON_SHADOW_PASS_2         (1 << 22)
+#       define RADEON_RIGHT_HAND_CUBE_D3D   (0 << 24)
+#       define RADEON_RIGHT_HAND_CUBE_OGL   (1 << 24)
+#define RADEON_PP_ROT_MATRIX_0              0x1d58
+#define RADEON_PP_ROT_MATRIX_1              0x1d5c
+#define RADEON_PP_TXFILTER_0                0x1c54
+#define RADEON_PP_TXFILTER_1                0x1c6c
+#define RADEON_PP_TXFILTER_2                0x1c84
+#       define RADEON_MAG_FILTER_NEAREST                   (0  <<  0)
+#       define RADEON_MAG_FILTER_LINEAR                    (1  <<  0)
+#       define RADEON_MAG_FILTER_MASK                      (1  <<  0)
+#       define RADEON_MIN_FILTER_NEAREST                   (0  <<  1)
+#       define RADEON_MIN_FILTER_LINEAR                    (1  <<  1)
+#       define RADEON_MIN_FILTER_NEAREST_MIP_NEAREST       (2  <<  1)
+#       define RADEON_MIN_FILTER_NEAREST_MIP_LINEAR        (3  <<  1)
+#       define RADEON_MIN_FILTER_LINEAR_MIP_NEAREST        (6  <<  1)
+#       define RADEON_MIN_FILTER_LINEAR_MIP_LINEAR         (7  <<  1)
+#       define RADEON_MIN_FILTER_ANISO_NEAREST             (8  <<  1)
+#       define RADEON_MIN_FILTER_ANISO_LINEAR              (9  <<  1)
+#       define RADEON_MIN_FILTER_ANISO_NEAREST_MIP_NEAREST (10 <<  1)
+#       define RADEON_MIN_FILTER_ANISO_NEAREST_MIP_LINEAR  (11 <<  1)
+#       define RADEON_MIN_FILTER_MASK                      (15 <<  1)
+#       define RADEON_MAX_ANISO_1_TO_1                     (0  <<  5)
+#       define RADEON_MAX_ANISO_2_TO_1                     (1  <<  5)
+#       define RADEON_MAX_ANISO_4_TO_1                     (2  <<  5)
+#       define RADEON_MAX_ANISO_8_TO_1                     (3  <<  5)
+#       define RADEON_MAX_ANISO_16_TO_1                    (4  <<  5)
+#       define RADEON_MAX_ANISO_MASK                       (7  <<  5)
+#       define RADEON_LOD_BIAS_MASK                        (0xff <<  8)
+#       define RADEON_LOD_BIAS_SHIFT                       8
+#       define RADEON_MAX_MIP_LEVEL_MASK                   (0x0f << 16)
+#       define RADEON_MAX_MIP_LEVEL_SHIFT                  16
+#       define RADEON_YUV_TO_RGB                           (1  << 20)
+#       define RADEON_YUV_TEMPERATURE_COOL                 (0  << 21)
+#       define RADEON_YUV_TEMPERATURE_HOT                  (1  << 21)
+#       define RADEON_YUV_TEMPERATURE_MASK                 (1  << 21)
+#       define RADEON_WRAPEN_S                             (1  << 22)
+#       define RADEON_CLAMP_S_WRAP                         (0  << 23)
+#       define RADEON_CLAMP_S_MIRROR                       (1  << 23)
+#       define RADEON_CLAMP_S_CLAMP_LAST                   (2  << 23)
+#       define RADEON_CLAMP_S_MIRROR_CLAMP_LAST            (3  << 23)
+#       define RADEON_CLAMP_S_CLAMP_BORDER                 (4  << 23)
+#       define RADEON_CLAMP_S_MIRROR_CLAMP_BORDER          (5  << 23)
+#       define RADEON_CLAMP_S_CLAMP_GL                     (6  << 23)
+#       define RADEON_CLAMP_S_MIRROR_CLAMP_GL              (7  << 23)
+#       define RADEON_CLAMP_S_MASK                         (7  << 23)
+#       define RADEON_WRAPEN_T                             (1  << 26)
+#       define RADEON_CLAMP_T_WRAP                         (0  << 27)
+#       define RADEON_CLAMP_T_MIRROR                       (1  << 27)
+#       define RADEON_CLAMP_T_CLAMP_LAST                   (2  << 27)
+#       define RADEON_CLAMP_T_MIRROR_CLAMP_LAST            (3  << 27)
+#       define RADEON_CLAMP_T_CLAMP_BORDER                 (4  << 27)
+#       define RADEON_CLAMP_T_MIRROR_CLAMP_BORDER          (5  << 27)
+#       define RADEON_CLAMP_T_CLAMP_GL                     (6  << 27)
+#       define RADEON_CLAMP_T_MIRROR_CLAMP_GL              (7  << 27)
+#       define RADEON_CLAMP_T_MASK                         (7  << 27)
+#       define RADEON_BORDER_MODE_OGL                      (0  << 31)
+#       define RADEON_BORDER_MODE_D3D                      (1  << 31)
+#define RADEON_PP_TXFORMAT_0                0x1c58
+#define RADEON_PP_TXFORMAT_1                0x1c70
+#define RADEON_PP_TXFORMAT_2                0x1c88
+#       define RADEON_TXFORMAT_I8                 (0  <<  0)
+#       define RADEON_TXFORMAT_AI88               (1  <<  0)
+#       define RADEON_TXFORMAT_RGB332             (2  <<  0)
+#       define RADEON_TXFORMAT_ARGB1555           (3  <<  0)
+#       define RADEON_TXFORMAT_RGB565             (4  <<  0)
+#       define RADEON_TXFORMAT_ARGB4444           (5  <<  0)
+#       define RADEON_TXFORMAT_ARGB8888           (6  <<  0)
+#       define RADEON_TXFORMAT_RGBA8888           (7  <<  0)
+#       define RADEON_TXFORMAT_Y8                 (8  <<  0)
+#       define RADEON_TXFORMAT_VYUY422            (10 <<  0)
+#       define RADEON_TXFORMAT_YVYU422            (11 <<  0)
+#       define RADEON_TXFORMAT_DXT1               (12 <<  0)
+#       define RADEON_TXFORMAT_DXT23              (14 <<  0)
+#       define RADEON_TXFORMAT_DXT45              (15 <<  0)
+#	define RADEON_TXFORMAT_SHADOW16           (16 <<  0)
+#	define RADEON_TXFORMAT_SHADOW32           (17 <<  0)
+#       define RADEON_TXFORMAT_DUDV88             (18 <<  0)
+#       define RADEON_TXFORMAT_LDUDV655           (19 <<  0)
+#       define RADEON_TXFORMAT_LDUDUV8888         (20 <<  0)
+#       define RADEON_TXFORMAT_FORMAT_MASK        (31 <<  0)
+#       define RADEON_TXFORMAT_FORMAT_SHIFT       0
+#       define RADEON_TXFORMAT_APPLE_YUV_MODE     (1  <<  5)
+#       define RADEON_TXFORMAT_ALPHA_IN_MAP       (1  <<  6)
+#       define RADEON_TXFORMAT_NON_POWER2         (1  <<  7)
+#       define RADEON_TXFORMAT_WIDTH_MASK         (15 <<  8)
+#       define RADEON_TXFORMAT_WIDTH_SHIFT        8
+#       define RADEON_TXFORMAT_HEIGHT_MASK        (15 << 12)
+#       define RADEON_TXFORMAT_HEIGHT_SHIFT       12
+#       define RADEON_TXFORMAT_F5_WIDTH_MASK      (15 << 16)
+#       define RADEON_TXFORMAT_F5_WIDTH_SHIFT     16
+#       define RADEON_TXFORMAT_F5_HEIGHT_MASK     (15 << 20)
+#       define RADEON_TXFORMAT_F5_HEIGHT_SHIFT    20
+#       define RADEON_TXFORMAT_ST_ROUTE_STQ0      (0  << 24)
+#       define RADEON_TXFORMAT_ST_ROUTE_MASK      (3  << 24)
+#       define RADEON_TXFORMAT_ST_ROUTE_STQ1      (1  << 24)
+#       define RADEON_TXFORMAT_ST_ROUTE_STQ2      (2  << 24)
+#       define RADEON_TXFORMAT_ENDIAN_NO_SWAP     (0  << 26)
+#       define RADEON_TXFORMAT_ENDIAN_16BPP_SWAP  (1  << 26)
+#       define RADEON_TXFORMAT_ENDIAN_32BPP_SWAP  (2  << 26)
+#       define RADEON_TXFORMAT_ENDIAN_HALFDW_SWAP (3  << 26)
+#       define RADEON_TXFORMAT_ALPHA_MASK_ENABLE  (1  << 28)
+#       define RADEON_TXFORMAT_CHROMA_KEY_ENABLE  (1  << 29)
+#       define RADEON_TXFORMAT_CUBIC_MAP_ENABLE   (1  << 30)
+#       define RADEON_TXFORMAT_PERSPECTIVE_ENABLE (1  << 31)
+#define RADEON_PP_CUBIC_FACES_0             0x1d24
+#define RADEON_PP_CUBIC_FACES_1             0x1d28
+#define RADEON_PP_CUBIC_FACES_2             0x1d2c
+#       define RADEON_FACE_WIDTH_1_SHIFT          0
+#       define RADEON_FACE_HEIGHT_1_SHIFT         4
+#       define RADEON_FACE_WIDTH_1_MASK           (0xf << 0)
+#       define RADEON_FACE_HEIGHT_1_MASK          (0xf << 4)
+#       define RADEON_FACE_WIDTH_2_SHIFT          8
+#       define RADEON_FACE_HEIGHT_2_SHIFT         12
+#       define RADEON_FACE_WIDTH_2_MASK           (0xf << 8)
+#       define RADEON_FACE_HEIGHT_2_MASK          (0xf << 12)
+#       define RADEON_FACE_WIDTH_3_SHIFT          16
+#       define RADEON_FACE_HEIGHT_3_SHIFT         20
+#       define RADEON_FACE_WIDTH_3_MASK           (0xf << 16)
+#       define RADEON_FACE_HEIGHT_3_MASK          (0xf << 20)
+#       define RADEON_FACE_WIDTH_4_SHIFT          24
+#       define RADEON_FACE_HEIGHT_4_SHIFT         28
+#       define RADEON_FACE_WIDTH_4_MASK           (0xf << 24)
+#       define RADEON_FACE_HEIGHT_4_MASK          (0xf << 28)
+
+#define RADEON_PP_TXOFFSET_0                0x1c5c
+#define RADEON_PP_TXOFFSET_1                0x1c74
+#define RADEON_PP_TXOFFSET_2                0x1c8c
+#       define RADEON_TXO_ENDIAN_NO_SWAP     (0 << 0)
+#       define RADEON_TXO_ENDIAN_BYTE_SWAP   (1 << 0)
+#       define RADEON_TXO_ENDIAN_WORD_SWAP   (2 << 0)
+#       define RADEON_TXO_ENDIAN_HALFDW_SWAP (3 << 0)
+#       define RADEON_TXO_MACRO_LINEAR       (0 << 2)
+#       define RADEON_TXO_MACRO_TILE         (1 << 2)
+#       define RADEON_TXO_MICRO_LINEAR       (0 << 3)
+#       define RADEON_TXO_MICRO_TILE_X2      (1 << 3)
+#       define RADEON_TXO_MICRO_TILE_OPT     (2 << 3)
+#       define RADEON_TXO_OFFSET_MASK        0xffffffe0
+#       define RADEON_TXO_OFFSET_SHIFT       5
+
+#define RADEON_PP_CUBIC_OFFSET_T0_0         0x1dd0  /* bits [31:5] */
+#define RADEON_PP_CUBIC_OFFSET_T0_1         0x1dd4
+#define RADEON_PP_CUBIC_OFFSET_T0_2         0x1dd8
+#define RADEON_PP_CUBIC_OFFSET_T0_3         0x1ddc
+#define RADEON_PP_CUBIC_OFFSET_T0_4         0x1de0
+#define RADEON_PP_CUBIC_OFFSET_T1_0         0x1e00
+#define RADEON_PP_CUBIC_OFFSET_T1_1         0x1e04
+#define RADEON_PP_CUBIC_OFFSET_T1_2         0x1e08
+#define RADEON_PP_CUBIC_OFFSET_T1_3         0x1e0c
+#define RADEON_PP_CUBIC_OFFSET_T1_4         0x1e10
+#define RADEON_PP_CUBIC_OFFSET_T2_0         0x1e14
+#define RADEON_PP_CUBIC_OFFSET_T2_1         0x1e18
+#define RADEON_PP_CUBIC_OFFSET_T2_2         0x1e1c
+#define RADEON_PP_CUBIC_OFFSET_T2_3         0x1e20
+#define RADEON_PP_CUBIC_OFFSET_T2_4         0x1e24
+
+#define RADEON_PP_TEX_SIZE_0                0x1d04  /* NPOT */
+#define RADEON_PP_TEX_SIZE_1                0x1d0c
+#define RADEON_PP_TEX_SIZE_2                0x1d14
+#       define RADEON_TEX_USIZE_MASK        (0x7ff << 0)
+#       define RADEON_TEX_USIZE_SHIFT       0
+#       define RADEON_TEX_VSIZE_MASK        (0x7ff << 16)
+#       define RADEON_TEX_VSIZE_SHIFT       16
+#       define RADEON_SIGNED_RGB_MASK       (1 << 30)
+#       define RADEON_SIGNED_RGB_SHIFT      30
+#       define RADEON_SIGNED_ALPHA_MASK     (1 << 31)
+#       define RADEON_SIGNED_ALPHA_SHIFT    31
+#define RADEON_PP_TEX_PITCH_0               0x1d08  /* NPOT */
+#define RADEON_PP_TEX_PITCH_1               0x1d10  /* NPOT */
+#define RADEON_PP_TEX_PITCH_2               0x1d18  /* NPOT */
+/* note: bits 13-5: 32 byte aligned stride of texture map */
+
+#define RADEON_PP_TXCBLEND_0                0x1c60
+#define RADEON_PP_TXCBLEND_1                0x1c78
+#define RADEON_PP_TXCBLEND_2                0x1c90
+#       define RADEON_COLOR_ARG_A_SHIFT          0
+#       define RADEON_COLOR_ARG_A_MASK           (0x1f << 0)
+#       define RADEON_COLOR_ARG_A_ZERO           (0    << 0)
+#       define RADEON_COLOR_ARG_A_CURRENT_COLOR  (2    << 0)
+#       define RADEON_COLOR_ARG_A_CURRENT_ALPHA  (3    << 0)
+#       define RADEON_COLOR_ARG_A_DIFFUSE_COLOR  (4    << 0)
+#       define RADEON_COLOR_ARG_A_DIFFUSE_ALPHA  (5    << 0)
+#       define RADEON_COLOR_ARG_A_SPECULAR_COLOR (6    << 0)
+#       define RADEON_COLOR_ARG_A_SPECULAR_ALPHA (7    << 0)
+#       define RADEON_COLOR_ARG_A_TFACTOR_COLOR  (8    << 0)
+#       define RADEON_COLOR_ARG_A_TFACTOR_ALPHA  (9    << 0)
+#       define RADEON_COLOR_ARG_A_T0_COLOR       (10   << 0)
+#       define RADEON_COLOR_ARG_A_T0_ALPHA       (11   << 0)
+#       define RADEON_COLOR_ARG_A_T1_COLOR       (12   << 0)
+#       define RADEON_COLOR_ARG_A_T1_ALPHA       (13   << 0)
+#       define RADEON_COLOR_ARG_A_T2_COLOR       (14   << 0)
+#       define RADEON_COLOR_ARG_A_T2_ALPHA       (15   << 0)
+#       define RADEON_COLOR_ARG_A_T3_COLOR       (16   << 0)
+#       define RADEON_COLOR_ARG_A_T3_ALPHA       (17   << 0)
+#       define RADEON_COLOR_ARG_B_SHIFT          5
+#       define RADEON_COLOR_ARG_B_MASK           (0x1f << 5)
+#       define RADEON_COLOR_ARG_B_ZERO           (0    << 5)
+#       define RADEON_COLOR_ARG_B_CURRENT_COLOR  (2    << 5)
+#       define RADEON_COLOR_ARG_B_CURRENT_ALPHA  (3    << 5)
+#       define RADEON_COLOR_ARG_B_DIFFUSE_COLOR  (4    << 5)
+#       define RADEON_COLOR_ARG_B_DIFFUSE_ALPHA  (5    << 5)
+#       define RADEON_COLOR_ARG_B_SPECULAR_COLOR (6    << 5)
+#       define RADEON_COLOR_ARG_B_SPECULAR_ALPHA (7    << 5)
+#       define RADEON_COLOR_ARG_B_TFACTOR_COLOR  (8    << 5)
+#       define RADEON_COLOR_ARG_B_TFACTOR_ALPHA  (9    << 5)
+#       define RADEON_COLOR_ARG_B_T0_COLOR       (10   << 5)
+#       define RADEON_COLOR_ARG_B_T0_ALPHA       (11   << 5)
+#       define RADEON_COLOR_ARG_B_T1_COLOR       (12   << 5)
+#       define RADEON_COLOR_ARG_B_T1_ALPHA       (13   << 5)
+#       define RADEON_COLOR_ARG_B_T2_COLOR       (14   << 5)
+#       define RADEON_COLOR_ARG_B_T2_ALPHA       (15   << 5)
+#       define RADEON_COLOR_ARG_B_T3_COLOR       (16   << 5)
+#       define RADEON_COLOR_ARG_B_T3_ALPHA       (17   << 5)
+#       define RADEON_COLOR_ARG_C_SHIFT          10
+#       define RADEON_COLOR_ARG_C_MASK           (0x1f << 10)
+#       define RADEON_COLOR_ARG_C_ZERO           (0    << 10)
+#       define RADEON_COLOR_ARG_C_CURRENT_COLOR  (2    << 10)
+#       define RADEON_COLOR_ARG_C_CURRENT_ALPHA  (3    << 10)
+#       define RADEON_COLOR_ARG_C_DIFFUSE_COLOR  (4    << 10)
+#       define RADEON_COLOR_ARG_C_DIFFUSE_ALPHA  (5    << 10)
+#       define RADEON_COLOR_ARG_C_SPECULAR_COLOR (6    << 10)
+#       define RADEON_COLOR_ARG_C_SPECULAR_ALPHA (7    << 10)
+#       define RADEON_COLOR_ARG_C_TFACTOR_COLOR  (8    << 10)
+#       define RADEON_COLOR_ARG_C_TFACTOR_ALPHA  (9    << 10)
+#       define RADEON_COLOR_ARG_C_T0_COLOR       (10   << 10)
+#       define RADEON_COLOR_ARG_C_T0_ALPHA       (11   << 10)
+#       define RADEON_COLOR_ARG_C_T1_COLOR       (12   << 10)
+#       define RADEON_COLOR_ARG_C_T1_ALPHA       (13   << 10)
+#       define RADEON_COLOR_ARG_C_T2_COLOR       (14   << 10)
+#       define RADEON_COLOR_ARG_C_T2_ALPHA       (15   << 10)
+#       define RADEON_COLOR_ARG_C_T3_COLOR       (16   << 10)
+#       define RADEON_COLOR_ARG_C_T3_ALPHA       (17   << 10)
+#       define RADEON_COMP_ARG_A                 (1 << 15)
+#       define RADEON_COMP_ARG_A_SHIFT           15
+#       define RADEON_COMP_ARG_B                 (1 << 16)
+#       define RADEON_COMP_ARG_B_SHIFT           16
+#       define RADEON_COMP_ARG_C                 (1 << 17)
+#       define RADEON_COMP_ARG_C_SHIFT           17
+#       define RADEON_BLEND_CTL_MASK             (7 << 18)
+#       define RADEON_BLEND_CTL_ADD              (0 << 18)
+#       define RADEON_BLEND_CTL_SUBTRACT         (1 << 18)
+#       define RADEON_BLEND_CTL_ADDSIGNED        (2 << 18)
+#       define RADEON_BLEND_CTL_BLEND            (3 << 18)
+#       define RADEON_BLEND_CTL_DOT3             (4 << 18)
+#       define RADEON_SCALE_SHIFT                21
+#       define RADEON_SCALE_MASK                 (3 << 21)
+#       define RADEON_SCALE_1X                   (0 << 21)
+#       define RADEON_SCALE_2X                   (1 << 21)
+#       define RADEON_SCALE_4X                   (2 << 21)
+#       define RADEON_CLAMP_TX                   (1 << 23)
+#       define RADEON_T0_EQ_TCUR                 (1 << 24)
+#       define RADEON_T1_EQ_TCUR                 (1 << 25)
+#       define RADEON_T2_EQ_TCUR                 (1 << 26)
+#       define RADEON_T3_EQ_TCUR                 (1 << 27)
+#       define RADEON_COLOR_ARG_MASK             0x1f
+#       define RADEON_COMP_ARG_SHIFT             15
+#define RADEON_PP_TXABLEND_0                0x1c64
+#define RADEON_PP_TXABLEND_1                0x1c7c
+#define RADEON_PP_TXABLEND_2                0x1c94
+#       define RADEON_ALPHA_ARG_A_SHIFT          0
+#       define RADEON_ALPHA_ARG_A_MASK           (0xf << 0)
+#       define RADEON_ALPHA_ARG_A_ZERO           (0   << 0)
+#       define RADEON_ALPHA_ARG_A_CURRENT_ALPHA  (1   << 0)
+#       define RADEON_ALPHA_ARG_A_DIFFUSE_ALPHA  (2   << 0)
+#       define RADEON_ALPHA_ARG_A_SPECULAR_ALPHA (3   << 0)
+#       define RADEON_ALPHA_ARG_A_TFACTOR_ALPHA  (4   << 0)
+#       define RADEON_ALPHA_ARG_A_T0_ALPHA       (5   << 0)
+#       define RADEON_ALPHA_ARG_A_T1_ALPHA       (6   << 0)
+#       define RADEON_ALPHA_ARG_A_T2_ALPHA       (7   << 0)
+#       define RADEON_ALPHA_ARG_A_T3_ALPHA       (8   << 0)
+#       define RADEON_ALPHA_ARG_B_SHIFT          4
+#       define RADEON_ALPHA_ARG_B_MASK           (0xf << 4)
+#       define RADEON_ALPHA_ARG_B_ZERO           (0   << 4)
+#       define RADEON_ALPHA_ARG_B_CURRENT_ALPHA  (1   << 4)
+#       define RADEON_ALPHA_ARG_B_DIFFUSE_ALPHA  (2   << 4)
+#       define RADEON_ALPHA_ARG_B_SPECULAR_ALPHA (3   << 4)
+#       define RADEON_ALPHA_ARG_B_TFACTOR_ALPHA  (4   << 4)
+#       define RADEON_ALPHA_ARG_B_T0_ALPHA       (5   << 4)
+#       define RADEON_ALPHA_ARG_B_T1_ALPHA       (6   << 4)
+#       define RADEON_ALPHA_ARG_B_T2_ALPHA       (7   << 4)
+#       define RADEON_ALPHA_ARG_B_T3_ALPHA       (8   << 4)
+#       define RADEON_ALPHA_ARG_C_SHIFT          8
+#       define RADEON_ALPHA_ARG_C_MASK           (0xf << 8)
+#       define RADEON_ALPHA_ARG_C_ZERO           (0   << 8)
+#       define RADEON_ALPHA_ARG_C_CURRENT_ALPHA  (1   << 8)
+#       define RADEON_ALPHA_ARG_C_DIFFUSE_ALPHA  (2   << 8)
+#       define RADEON_ALPHA_ARG_C_SPECULAR_ALPHA (3   << 8)
+#       define RADEON_ALPHA_ARG_C_TFACTOR_ALPHA  (4   << 8)
+#       define RADEON_ALPHA_ARG_C_T0_ALPHA       (5   << 8)
+#       define RADEON_ALPHA_ARG_C_T1_ALPHA       (6   << 8)
+#       define RADEON_ALPHA_ARG_C_T2_ALPHA       (7   << 8)
+#       define RADEON_ALPHA_ARG_C_T3_ALPHA       (8   << 8)
+#       define RADEON_DOT_ALPHA_DONT_REPLICATE   (1   << 9)
+#       define RADEON_ALPHA_ARG_MASK             0xf
+
+#define RADEON_PP_TFACTOR_0                 0x1c68
+#define RADEON_PP_TFACTOR_1                 0x1c80
+#define RADEON_PP_TFACTOR_2                 0x1c98
+
+#define RADEON_RB3D_BLENDCNTL               0x1c20
+#       define RADEON_COMB_FCN_MASK                    (3  << 12)
+#       define RADEON_COMB_FCN_ADD_CLAMP               (0  << 12)
+#       define RADEON_COMB_FCN_ADD_NOCLAMP             (1  << 12)
+#       define RADEON_COMB_FCN_SUB_CLAMP               (2  << 12)
+#       define RADEON_COMB_FCN_SUB_NOCLAMP             (3  << 12)
+#       define RADEON_SRC_BLEND_GL_ZERO                (32 << 16)
+#       define RADEON_SRC_BLEND_GL_ONE                 (33 << 16)
+#       define RADEON_SRC_BLEND_GL_SRC_COLOR           (34 << 16)
+#       define RADEON_SRC_BLEND_GL_ONE_MINUS_SRC_COLOR (35 << 16)
+#       define RADEON_SRC_BLEND_GL_DST_COLOR           (36 << 16)
+#       define RADEON_SRC_BLEND_GL_ONE_MINUS_DST_COLOR (37 << 16)
+#       define RADEON_SRC_BLEND_GL_SRC_ALPHA           (38 << 16)
+#       define RADEON_SRC_BLEND_GL_ONE_MINUS_SRC_ALPHA (39 << 16)
+#       define RADEON_SRC_BLEND_GL_DST_ALPHA           (40 << 16)
+#       define RADEON_SRC_BLEND_GL_ONE_MINUS_DST_ALPHA (41 << 16)
+#       define RADEON_SRC_BLEND_GL_SRC_ALPHA_SATURATE  (42 << 16)
+#       define RADEON_SRC_BLEND_MASK                   (63 << 16)
+#       define RADEON_DST_BLEND_GL_ZERO                (32 << 24)
+#       define RADEON_DST_BLEND_GL_ONE                 (33 << 24)
+#       define RADEON_DST_BLEND_GL_SRC_COLOR           (34 << 24)
+#       define RADEON_DST_BLEND_GL_ONE_MINUS_SRC_COLOR (35 << 24)
+#       define RADEON_DST_BLEND_GL_DST_COLOR           (36 << 24)
+#       define RADEON_DST_BLEND_GL_ONE_MINUS_DST_COLOR (37 << 24)
+#       define RADEON_DST_BLEND_GL_SRC_ALPHA           (38 << 24)
+#       define RADEON_DST_BLEND_GL_ONE_MINUS_SRC_ALPHA (39 << 24)
+#       define RADEON_DST_BLEND_GL_DST_ALPHA           (40 << 24)
+#       define RADEON_DST_BLEND_GL_ONE_MINUS_DST_ALPHA (41 << 24)
+#       define RADEON_DST_BLEND_MASK                   (63 << 24)
+#define RADEON_RB3D_CNTL                    0x1c3c
+#       define RADEON_ALPHA_BLEND_ENABLE       (1  <<  0)
+#       define RADEON_PLANE_MASK_ENABLE        (1  <<  1)
+#       define RADEON_DITHER_ENABLE            (1  <<  2)
+#       define RADEON_ROUND_ENABLE             (1  <<  3)
+#       define RADEON_SCALE_DITHER_ENABLE      (1  <<  4)
+#       define RADEON_DITHER_INIT              (1  <<  5)
+#       define RADEON_ROP_ENABLE               (1  <<  6)
+#       define RADEON_STENCIL_ENABLE           (1  <<  7)
+#       define RADEON_Z_ENABLE                 (1  <<  8)
+#       define RADEON_DEPTHXY_OFFSET_ENABLE    (1  <<  9)
+#       define RADEON_RB3D_COLOR_FORMAT_SHIFT  10
+
+#       define RADEON_COLOR_FORMAT_ARGB1555    3
+#       define RADEON_COLOR_FORMAT_RGB565      4
+#       define RADEON_COLOR_FORMAT_ARGB8888    6
+#       define RADEON_COLOR_FORMAT_RGB332      7
+#       define RADEON_COLOR_FORMAT_Y8          8
+#       define RADEON_COLOR_FORMAT_RGB8        9
+#       define RADEON_COLOR_FORMAT_YUV422_VYUY 11
+#       define RADEON_COLOR_FORMAT_YUV422_YVYU 12
+#       define RADEON_COLOR_FORMAT_aYUV444     14
+#       define RADEON_COLOR_FORMAT_ARGB4444    15
+
+#       define RADEON_CLRCMP_FLIP_ENABLE       (1  << 14)
+#define RADEON_RB3D_COLOROFFSET             0x1c40
+#       define RADEON_COLOROFFSET_MASK      0xfffffff0
+#define RADEON_RB3D_COLORPITCH              0x1c48
+#       define RADEON_COLORPITCH_MASK         0x000001ff8
+#       define RADEON_COLOR_TILE_ENABLE       (1 << 16)
+#       define RADEON_COLOR_MICROTILE_ENABLE  (1 << 17)
+#       define RADEON_COLOR_ENDIAN_NO_SWAP    (0 << 18)
+#       define RADEON_COLOR_ENDIAN_WORD_SWAP  (1 << 18)
+#       define RADEON_COLOR_ENDIAN_DWORD_SWAP (2 << 18)
+#define RADEON_RB3D_DEPTHOFFSET             0x1c24
+#define RADEON_RB3D_DEPTHPITCH              0x1c28
+#       define RADEON_DEPTHPITCH_MASK         0x00001ff8
+#       define RADEON_DEPTH_ENDIAN_NO_SWAP    (0 << 18)
+#       define RADEON_DEPTH_ENDIAN_WORD_SWAP  (1 << 18)
+#       define RADEON_DEPTH_ENDIAN_DWORD_SWAP (2 << 18)
+#define RADEON_RB3D_PLANEMASK               0x1d84
+#define RADEON_RB3D_ROPCNTL                 0x1d80
+#       define RADEON_ROP_MASK              (15 << 8)
+#       define RADEON_ROP_CLEAR             (0  << 8)
+#       define RADEON_ROP_NOR               (1  << 8)
+#       define RADEON_ROP_AND_INVERTED      (2  << 8)
+#       define RADEON_ROP_COPY_INVERTED     (3  << 8)
+#       define RADEON_ROP_AND_REVERSE       (4  << 8)
+#       define RADEON_ROP_INVERT            (5  << 8)
+#       define RADEON_ROP_XOR               (6  << 8)
+#       define RADEON_ROP_NAND              (7  << 8)
+#       define RADEON_ROP_AND               (8  << 8)
+#       define RADEON_ROP_EQUIV             (9  << 8)
+#       define RADEON_ROP_NOOP              (10 << 8)
+#       define RADEON_ROP_OR_INVERTED       (11 << 8)
+#       define RADEON_ROP_COPY              (12 << 8)
+#       define RADEON_ROP_OR_REVERSE        (13 << 8)
+#       define RADEON_ROP_OR                (14 << 8)
+#       define RADEON_ROP_SET               (15 << 8)
+#define RADEON_RB3D_STENCILREFMASK          0x1d7c
+#       define RADEON_STENCIL_REF_SHIFT       0
+#       define RADEON_STENCIL_REF_MASK        (0xff << 0)
+#       define RADEON_STENCIL_MASK_SHIFT      16
+#       define RADEON_STENCIL_VALUE_MASK      (0xff << 16)
+#       define RADEON_STENCIL_WRITEMASK_SHIFT 24
+#       define RADEON_STENCIL_WRITE_MASK      (0xff << 24)
+#define RADEON_RB3D_ZSTENCILCNTL            0x1c2c
+#       define RADEON_DEPTH_FORMAT_MASK          (0xf << 0)
+#       define RADEON_DEPTH_FORMAT_16BIT_INT_Z   (0  <<  0)
+#       define RADEON_DEPTH_FORMAT_24BIT_INT_Z   (2  <<  0)
+#       define RADEON_DEPTH_FORMAT_24BIT_FLOAT_Z (3  <<  0)
+#       define RADEON_DEPTH_FORMAT_32BIT_INT_Z   (4  <<  0)
+#       define RADEON_DEPTH_FORMAT_32BIT_FLOAT_Z (5  <<  0)
+#       define RADEON_DEPTH_FORMAT_16BIT_FLOAT_W (7  <<  0)
+#       define RADEON_DEPTH_FORMAT_24BIT_FLOAT_W (9  <<  0)
+#       define RADEON_DEPTH_FORMAT_32BIT_FLOAT_W (11 <<  0)
+#       define RADEON_Z_TEST_NEVER               (0  <<  4)
+#       define RADEON_Z_TEST_LESS                (1  <<  4)
+#       define RADEON_Z_TEST_LEQUAL              (2  <<  4)
+#       define RADEON_Z_TEST_EQUAL               (3  <<  4)
+#       define RADEON_Z_TEST_GEQUAL              (4  <<  4)
+#       define RADEON_Z_TEST_GREATER             (5  <<  4)
+#       define RADEON_Z_TEST_NEQUAL              (6  <<  4)
+#       define RADEON_Z_TEST_ALWAYS              (7  <<  4)
+#       define RADEON_Z_TEST_MASK                (7  <<  4)
+#       define RADEON_STENCIL_TEST_NEVER         (0  << 12)
+#       define RADEON_STENCIL_TEST_LESS          (1  << 12)
+#       define RADEON_STENCIL_TEST_LEQUAL        (2  << 12)
+#       define RADEON_STENCIL_TEST_EQUAL         (3  << 12)
+#       define RADEON_STENCIL_TEST_GEQUAL        (4  << 12)
+#       define RADEON_STENCIL_TEST_GREATER       (5  << 12)
+#       define RADEON_STENCIL_TEST_NEQUAL        (6  << 12)
+#       define RADEON_STENCIL_TEST_ALWAYS        (7  << 12)
+#       define RADEON_STENCIL_TEST_MASK          (0x7 << 12)
+#       define RADEON_STENCIL_FAIL_KEEP          (0  << 16)
+#       define RADEON_STENCIL_FAIL_ZERO          (1  << 16)
+#       define RADEON_STENCIL_FAIL_REPLACE       (2  << 16)
+#       define RADEON_STENCIL_FAIL_INC           (3  << 16)
+#       define RADEON_STENCIL_FAIL_DEC           (4  << 16)
+#       define RADEON_STENCIL_FAIL_INVERT        (5  << 16)
+#       define RADEON_STENCIL_FAIL_MASK          (0x7 << 16)
+#       define RADEON_STENCIL_ZPASS_KEEP         (0  << 20)
+#       define RADEON_STENCIL_ZPASS_ZERO         (1  << 20)
+#       define RADEON_STENCIL_ZPASS_REPLACE      (2  << 20)
+#       define RADEON_STENCIL_ZPASS_INC          (3  << 20)
+#       define RADEON_STENCIL_ZPASS_DEC          (4  << 20)
+#       define RADEON_STENCIL_ZPASS_INVERT       (5  << 20)
+#       define RADEON_STENCIL_ZPASS_MASK         (0x7 << 20)
+#       define RADEON_STENCIL_ZFAIL_KEEP         (0  << 24)
+#       define RADEON_STENCIL_ZFAIL_ZERO         (1  << 24)
+#       define RADEON_STENCIL_ZFAIL_REPLACE      (2  << 24)
+#       define RADEON_STENCIL_ZFAIL_INC          (3  << 24)
+#       define RADEON_STENCIL_ZFAIL_DEC          (4  << 24)
+#       define RADEON_STENCIL_ZFAIL_INVERT       (5  << 24)
+#       define RADEON_STENCIL_ZFAIL_MASK         (0x7 << 24)
+#       define RADEON_Z_COMPRESSION_ENABLE       (1  << 28)
+#       define RADEON_FORCE_Z_DIRTY              (1  << 29)
+#       define RADEON_Z_WRITE_ENABLE             (1  << 30)
+#define RADEON_RE_LINE_PATTERN              0x1cd0
+#       define RADEON_LINE_PATTERN_MASK             0x0000ffff
+#       define RADEON_LINE_REPEAT_COUNT_SHIFT       16
+#       define RADEON_LINE_PATTERN_START_SHIFT      24
+#       define RADEON_LINE_PATTERN_LITTLE_BIT_ORDER (0 << 28)
+#       define RADEON_LINE_PATTERN_BIG_BIT_ORDER    (1 << 28)
+#       define RADEON_LINE_PATTERN_AUTO_RESET       (1 << 29)
+#define RADEON_RE_LINE_STATE                0x1cd4
+#       define RADEON_LINE_CURRENT_PTR_SHIFT   0
+#       define RADEON_LINE_CURRENT_COUNT_SHIFT 8
+#define RADEON_RE_MISC                      0x26c4
+#       define RADEON_STIPPLE_COORD_MASK       0x1f
+#       define RADEON_STIPPLE_X_OFFSET_SHIFT   0
+#       define RADEON_STIPPLE_X_OFFSET_MASK    (0x1f << 0)
+#       define RADEON_STIPPLE_Y_OFFSET_SHIFT   8
+#       define RADEON_STIPPLE_Y_OFFSET_MASK    (0x1f << 8)
+#       define RADEON_STIPPLE_LITTLE_BIT_ORDER (0 << 16)
+#       define RADEON_STIPPLE_BIG_BIT_ORDER    (1 << 16)
+#define RADEON_RE_SOLID_COLOR               0x1c1c
+#define RADEON_RE_TOP_LEFT                  0x26c0
+#       define RADEON_RE_LEFT_SHIFT         0
+#       define RADEON_RE_TOP_SHIFT          16
+#define RADEON_RE_WIDTH_HEIGHT              0x1c44
+#       define RADEON_RE_WIDTH_SHIFT        0
+#       define RADEON_RE_HEIGHT_SHIFT       16
+
+#define RADEON_RB3D_ZPASS_DATA 0x3290
+#define RADEON_RB3D_ZPASS_ADDR 0x3294
+
+#define RADEON_SE_CNTL                      0x1c4c
+#       define RADEON_FFACE_CULL_CW          (0 <<  0)
+#       define RADEON_FFACE_CULL_CCW         (1 <<  0)
+#       define RADEON_FFACE_CULL_DIR_MASK    (1 <<  0)
+#       define RADEON_BFACE_CULL             (0 <<  1)
+#       define RADEON_BFACE_SOLID            (3 <<  1)
+#       define RADEON_FFACE_CULL             (0 <<  3)
+#       define RADEON_FFACE_SOLID            (3 <<  3)
+#       define RADEON_FFACE_CULL_MASK        (3 <<  3)
+#       define RADEON_BADVTX_CULL_DISABLE    (1 <<  5)
+#       define RADEON_FLAT_SHADE_VTX_0       (0 <<  6)
+#       define RADEON_FLAT_SHADE_VTX_1       (1 <<  6)
+#       define RADEON_FLAT_SHADE_VTX_2       (2 <<  6)
+#       define RADEON_FLAT_SHADE_VTX_LAST    (3 <<  6)
+#       define RADEON_DIFFUSE_SHADE_SOLID    (0 <<  8)
+#       define RADEON_DIFFUSE_SHADE_FLAT     (1 <<  8)
+#       define RADEON_DIFFUSE_SHADE_GOURAUD  (2 <<  8)
+#       define RADEON_DIFFUSE_SHADE_MASK     (3 <<  8)
+#       define RADEON_ALPHA_SHADE_SOLID      (0 << 10)
+#       define RADEON_ALPHA_SHADE_FLAT       (1 << 10)
+#       define RADEON_ALPHA_SHADE_GOURAUD    (2 << 10)
+#       define RADEON_ALPHA_SHADE_MASK       (3 << 10)
+#       define RADEON_SPECULAR_SHADE_SOLID   (0 << 12)
+#       define RADEON_SPECULAR_SHADE_FLAT    (1 << 12)
+#       define RADEON_SPECULAR_SHADE_GOURAUD (2 << 12)
+#       define RADEON_SPECULAR_SHADE_MASK    (3 << 12)
+#       define RADEON_FOG_SHADE_SOLID        (0 << 14)
+#       define RADEON_FOG_SHADE_FLAT         (1 << 14)
+#       define RADEON_FOG_SHADE_GOURAUD      (2 << 14)
+#       define RADEON_FOG_SHADE_MASK         (3 << 14)
+#       define RADEON_ZBIAS_ENABLE_POINT     (1 << 16)
+#       define RADEON_ZBIAS_ENABLE_LINE      (1 << 17)
+#       define RADEON_ZBIAS_ENABLE_TRI       (1 << 18)
+#       define RADEON_WIDELINE_ENABLE        (1 << 20)
+#       define RADEON_VPORT_XY_XFORM_ENABLE  (1 << 24)
+#       define RADEON_VPORT_Z_XFORM_ENABLE   (1 << 25)
+#       define RADEON_VTX_PIX_CENTER_D3D     (0 << 27)
+#       define RADEON_VTX_PIX_CENTER_OGL     (1 << 27)
+#       define RADEON_ROUND_MODE_TRUNC       (0 << 28)
+#       define RADEON_ROUND_MODE_ROUND       (1 << 28)
+#       define RADEON_ROUND_MODE_ROUND_EVEN  (2 << 28)
+#       define RADEON_ROUND_MODE_ROUND_ODD   (3 << 28)
+#       define RADEON_ROUND_PREC_16TH_PIX    (0 << 30)
+#       define RADEON_ROUND_PREC_8TH_PIX     (1 << 30)
+#       define RADEON_ROUND_PREC_4TH_PIX     (2 << 30)
+#       define RADEON_ROUND_PREC_HALF_PIX    (3 << 30)
+#define R200_RE_CNTL				0x1c50
+#       define R200_STIPPLE_ENABLE		0x1
+#       define R200_SCISSOR_ENABLE		0x2
+#       define R200_PATTERN_ENABLE		0x4
+#       define R200_PERSPECTIVE_ENABLE		0x8
+#       define R200_POINT_SMOOTH		0x20
+#       define R200_VTX_STQ0_D3D		0x00010000
+#       define R200_VTX_STQ1_D3D		0x00040000
+#       define R200_VTX_STQ2_D3D		0x00100000
+#       define R200_VTX_STQ3_D3D		0x00400000
+#       define R200_VTX_STQ4_D3D		0x01000000
+#       define R200_VTX_STQ5_D3D		0x04000000
+#define RADEON_SE_CNTL_STATUS               0x2140
+#       define RADEON_VC_NO_SWAP            (0 << 0)
+#       define RADEON_VC_16BIT_SWAP         (1 << 0)
+#       define RADEON_VC_32BIT_SWAP         (2 << 0)
+#       define RADEON_VC_HALF_DWORD_SWAP    (3 << 0)
+#       define RADEON_TCL_BYPASS            (1 << 8)
+#define RADEON_SE_COORD_FMT                 0x1c50
+#       define RADEON_VTX_XY_PRE_MULT_1_OVER_W0  (1 <<  0)
+#       define RADEON_VTX_Z_PRE_MULT_1_OVER_W0   (1 <<  1)
+#       define RADEON_VTX_ST0_NONPARAMETRIC      (1 <<  8)
+#       define RADEON_VTX_ST1_NONPARAMETRIC      (1 <<  9)
+#       define RADEON_VTX_ST2_NONPARAMETRIC      (1 << 10)
+#       define RADEON_VTX_ST3_NONPARAMETRIC      (1 << 11)
+#       define RADEON_VTX_W0_NORMALIZE           (1 << 12)
+#       define RADEON_VTX_W0_IS_NOT_1_OVER_W0    (1 << 16)
+#       define RADEON_VTX_ST0_PRE_MULT_1_OVER_W0 (1 << 17)
+#       define RADEON_VTX_ST1_PRE_MULT_1_OVER_W0 (1 << 19)
+#       define RADEON_VTX_ST2_PRE_MULT_1_OVER_W0 (1 << 21)
+#       define RADEON_VTX_ST3_PRE_MULT_1_OVER_W0 (1 << 23)
+#       define RADEON_TEX1_W_ROUTING_USE_W0      (0 << 26)
+#       define RADEON_TEX1_W_ROUTING_USE_Q1      (1 << 26)
+#define RADEON_SE_LINE_WIDTH                0x1db8
+#define RADEON_SE_TCL_LIGHT_MODEL_CTL       0x226c
+#       define RADEON_LIGHTING_ENABLE              (1 << 0)
+#       define RADEON_LIGHT_IN_MODELSPACE          (1 << 1)
+#       define RADEON_LOCAL_VIEWER                 (1 << 2)
+#       define RADEON_NORMALIZE_NORMALS            (1 << 3)
+#       define RADEON_RESCALE_NORMALS              (1 << 4)
+#       define RADEON_SPECULAR_LIGHTS              (1 << 5)
+#       define RADEON_DIFFUSE_SPECULAR_COMBINE     (1 << 6)
+#       define RADEON_LIGHT_ALPHA                  (1 << 7)
+#       define RADEON_LOCAL_LIGHT_VEC_GL           (1 << 8)
+#       define RADEON_LIGHT_NO_NORMAL_AMBIENT_ONLY (1 << 9)
+#       define RADEON_LM_SOURCE_STATE_PREMULT      0
+#       define RADEON_LM_SOURCE_STATE_MULT         1
+#       define RADEON_LM_SOURCE_VERTEX_DIFFUSE     2
+#       define RADEON_LM_SOURCE_VERTEX_SPECULAR    3
+#       define RADEON_EMISSIVE_SOURCE_SHIFT        16
+#       define RADEON_AMBIENT_SOURCE_SHIFT         18
+#       define RADEON_DIFFUSE_SOURCE_SHIFT         20
+#       define RADEON_SPECULAR_SOURCE_SHIFT        22
+#define RADEON_SE_TCL_MATERIAL_AMBIENT_RED     0x2220
+#define RADEON_SE_TCL_MATERIAL_AMBIENT_GREEN   0x2224
+#define RADEON_SE_TCL_MATERIAL_AMBIENT_BLUE    0x2228
+#define RADEON_SE_TCL_MATERIAL_AMBIENT_ALPHA   0x222c
+#define RADEON_SE_TCL_MATERIAL_DIFFUSE_RED     0x2230
+#define RADEON_SE_TCL_MATERIAL_DIFFUSE_GREEN   0x2234
+#define RADEON_SE_TCL_MATERIAL_DIFFUSE_BLUE    0x2238
+#define RADEON_SE_TCL_MATERIAL_DIFFUSE_ALPHA   0x223c
+#define RADEON_SE_TCL_MATERIAL_EMMISSIVE_RED   0x2210
+#define RADEON_SE_TCL_MATERIAL_EMMISSIVE_GREEN 0x2214
+#define RADEON_SE_TCL_MATERIAL_EMMISSIVE_BLUE  0x2218
+#define RADEON_SE_TCL_MATERIAL_EMMISSIVE_ALPHA 0x221c
+#define RADEON_SE_TCL_MATERIAL_SPECULAR_RED    0x2240
+#define RADEON_SE_TCL_MATERIAL_SPECULAR_GREEN  0x2244
+#define RADEON_SE_TCL_MATERIAL_SPECULAR_BLUE   0x2248
+#define RADEON_SE_TCL_MATERIAL_SPECULAR_ALPHA  0x224c
+#define RADEON_SE_TCL_MATRIX_SELECT_0       0x225c
+#       define RADEON_MODELVIEW_0_SHIFT        0
+#       define RADEON_MODELVIEW_1_SHIFT        4
+#       define RADEON_MODELVIEW_2_SHIFT        8
+#       define RADEON_MODELVIEW_3_SHIFT        12
+#       define RADEON_IT_MODELVIEW_0_SHIFT     16
+#       define RADEON_IT_MODELVIEW_1_SHIFT     20
+#       define RADEON_IT_MODELVIEW_2_SHIFT     24
+#       define RADEON_IT_MODELVIEW_3_SHIFT     28
+#define RADEON_SE_TCL_MATRIX_SELECT_1       0x2260
+#       define RADEON_MODELPROJECT_0_SHIFT     0
+#       define RADEON_MODELPROJECT_1_SHIFT     4
+#       define RADEON_MODELPROJECT_2_SHIFT     8
+#       define RADEON_MODELPROJECT_3_SHIFT     12
+#       define RADEON_TEXMAT_0_SHIFT           16
+#       define RADEON_TEXMAT_1_SHIFT           20
+#       define RADEON_TEXMAT_2_SHIFT           24
+#       define RADEON_TEXMAT_3_SHIFT           28
+
+
+#define RADEON_SE_TCL_OUTPUT_VTX_FMT        0x2254
+#       define RADEON_TCL_VTX_W0                 (1 <<  0)
+#       define RADEON_TCL_VTX_FP_DIFFUSE         (1 <<  1)
+#       define RADEON_TCL_VTX_FP_ALPHA           (1 <<  2)
+#       define RADEON_TCL_VTX_PK_DIFFUSE         (1 <<  3)
+#       define RADEON_TCL_VTX_FP_SPEC            (1 <<  4)
+#       define RADEON_TCL_VTX_FP_FOG             (1 <<  5)
+#       define RADEON_TCL_VTX_PK_SPEC            (1 <<  6)
+#       define RADEON_TCL_VTX_ST0                (1 <<  7)
+#       define RADEON_TCL_VTX_ST1                (1 <<  8)
+#       define RADEON_TCL_VTX_Q1                 (1 <<  9)
+#       define RADEON_TCL_VTX_ST2                (1 << 10)
+#       define RADEON_TCL_VTX_Q2                 (1 << 11)
+#       define RADEON_TCL_VTX_ST3                (1 << 12)
+#       define RADEON_TCL_VTX_Q3                 (1 << 13)
+#       define RADEON_TCL_VTX_Q0                 (1 << 14)
+#       define RADEON_TCL_VTX_WEIGHT_COUNT_SHIFT 15
+#       define RADEON_TCL_VTX_NORM0              (1 << 18)
+#       define RADEON_TCL_VTX_XY1                (1 << 27)
+#       define RADEON_TCL_VTX_Z1                 (1 << 28)
+#       define RADEON_TCL_VTX_W1                 (1 << 29)
+#       define RADEON_TCL_VTX_NORM1              (1 << 30)
+#       define RADEON_TCL_VTX_Z0                 (1 << 31)
+
+#define RADEON_SE_TCL_OUTPUT_VTX_SEL        0x2258
+#       define RADEON_TCL_COMPUTE_XYZW           (1 << 0)
+#       define RADEON_TCL_COMPUTE_DIFFUSE        (1 << 1)
+#       define RADEON_TCL_COMPUTE_SPECULAR       (1 << 2)
+#       define RADEON_TCL_FORCE_NAN_IF_COLOR_NAN (1 << 3)
+#       define RADEON_TCL_FORCE_INORDER_PROC     (1 << 4)
+#       define RADEON_TCL_TEX_INPUT_TEX_0        0
+#       define RADEON_TCL_TEX_INPUT_TEX_1        1
+#       define RADEON_TCL_TEX_INPUT_TEX_2        2
+#       define RADEON_TCL_TEX_INPUT_TEX_3        3
+#       define RADEON_TCL_TEX_COMPUTED_TEX_0     8
+#       define RADEON_TCL_TEX_COMPUTED_TEX_1     9
+#       define RADEON_TCL_TEX_COMPUTED_TEX_2     10
+#       define RADEON_TCL_TEX_COMPUTED_TEX_3     11
+#       define RADEON_TCL_TEX_0_OUTPUT_SHIFT     16
+#       define RADEON_TCL_TEX_1_OUTPUT_SHIFT     20
+#       define RADEON_TCL_TEX_2_OUTPUT_SHIFT     24
+#       define RADEON_TCL_TEX_3_OUTPUT_SHIFT     28
+
+#define RADEON_SE_TCL_PER_LIGHT_CTL_0       0x2270
+#       define RADEON_LIGHT_0_ENABLE               (1 <<  0)
+#       define RADEON_LIGHT_0_ENABLE_AMBIENT       (1 <<  1)
+#       define RADEON_LIGHT_0_ENABLE_SPECULAR      (1 <<  2)
+#       define RADEON_LIGHT_0_IS_LOCAL             (1 <<  3)
+#       define RADEON_LIGHT_0_IS_SPOT              (1 <<  4)
+#       define RADEON_LIGHT_0_DUAL_CONE            (1 <<  5)
+#       define RADEON_LIGHT_0_ENABLE_RANGE_ATTEN   (1 <<  6)
+#       define RADEON_LIGHT_0_CONSTANT_RANGE_ATTEN (1 <<  7)
+#       define RADEON_LIGHT_0_SHIFT                0
+#       define RADEON_LIGHT_1_ENABLE               (1 << 16)
+#       define RADEON_LIGHT_1_ENABLE_AMBIENT       (1 << 17)
+#       define RADEON_LIGHT_1_ENABLE_SPECULAR      (1 << 18)
+#       define RADEON_LIGHT_1_IS_LOCAL             (1 << 19)
+#       define RADEON_LIGHT_1_IS_SPOT              (1 << 20)
+#       define RADEON_LIGHT_1_DUAL_CONE            (1 << 21)
+#       define RADEON_LIGHT_1_ENABLE_RANGE_ATTEN   (1 << 22)
+#       define RADEON_LIGHT_1_CONSTANT_RANGE_ATTEN (1 << 23)
+#       define RADEON_LIGHT_1_SHIFT                16
+#define RADEON_SE_TCL_PER_LIGHT_CTL_1       0x2274
+#       define RADEON_LIGHT_2_SHIFT            0
+#       define RADEON_LIGHT_3_SHIFT            16
+#define RADEON_SE_TCL_PER_LIGHT_CTL_2       0x2278
+#       define RADEON_LIGHT_4_SHIFT            0
+#       define RADEON_LIGHT_5_SHIFT            16
+#define RADEON_SE_TCL_PER_LIGHT_CTL_3       0x227c
+#       define RADEON_LIGHT_6_SHIFT            0
+#       define RADEON_LIGHT_7_SHIFT            16
+
+#define RADEON_SE_TCL_SHININESS             0x2250
+
+#define RADEON_SE_TCL_TEXTURE_PROC_CTL      0x2268
+#       define RADEON_TEXGEN_TEXMAT_0_ENABLE      (1 << 0)
+#       define RADEON_TEXGEN_TEXMAT_1_ENABLE      (1 << 1)
+#       define RADEON_TEXGEN_TEXMAT_2_ENABLE      (1 << 2)
+#       define RADEON_TEXGEN_TEXMAT_3_ENABLE      (1 << 3)
+#       define RADEON_TEXMAT_0_ENABLE             (1 << 4)
+#       define RADEON_TEXMAT_1_ENABLE             (1 << 5)
+#       define RADEON_TEXMAT_2_ENABLE             (1 << 6)
+#       define RADEON_TEXMAT_3_ENABLE             (1 << 7)
+#       define RADEON_TEXGEN_INPUT_MASK           0xf
+#       define RADEON_TEXGEN_INPUT_TEXCOORD_0     0
+#       define RADEON_TEXGEN_INPUT_TEXCOORD_1     1
+#       define RADEON_TEXGEN_INPUT_TEXCOORD_2     2
+#       define RADEON_TEXGEN_INPUT_TEXCOORD_3     3
+#       define RADEON_TEXGEN_INPUT_OBJ            4
+#       define RADEON_TEXGEN_INPUT_EYE            5
+#       define RADEON_TEXGEN_INPUT_EYE_NORMAL     6
+#       define RADEON_TEXGEN_INPUT_EYE_REFLECT    7
+#       define RADEON_TEXGEN_INPUT_EYE_NORMALIZED 8
+#       define RADEON_TEXGEN_0_INPUT_SHIFT        16
+#       define RADEON_TEXGEN_1_INPUT_SHIFT        20
+#       define RADEON_TEXGEN_2_INPUT_SHIFT        24
+#       define RADEON_TEXGEN_3_INPUT_SHIFT        28
+
+#define RADEON_SE_TCL_UCP_VERT_BLEND_CTL    0x2264
+#       define RADEON_UCP_IN_CLIP_SPACE            (1 <<  0)
+#       define RADEON_UCP_IN_MODEL_SPACE           (1 <<  1)
+#       define RADEON_UCP_ENABLE_0                 (1 <<  2)
+#       define RADEON_UCP_ENABLE_1                 (1 <<  3)
+#       define RADEON_UCP_ENABLE_2                 (1 <<  4)
+#       define RADEON_UCP_ENABLE_3                 (1 <<  5)
+#       define RADEON_UCP_ENABLE_4                 (1 <<  6)
+#       define RADEON_UCP_ENABLE_5                 (1 <<  7)
+#       define RADEON_TCL_FOG_MASK                 (3 <<  8)
+#       define RADEON_TCL_FOG_DISABLE              (0 <<  8)
+#       define RADEON_TCL_FOG_EXP                  (1 <<  8)
+#       define RADEON_TCL_FOG_EXP2                 (2 <<  8)
+#       define RADEON_TCL_FOG_LINEAR               (3 <<  8)
+#       define RADEON_RNG_BASED_FOG                (1 << 10)
+#       define RADEON_LIGHT_TWOSIDE                (1 << 11)
+#       define RADEON_BLEND_OP_COUNT_MASK          (7 << 12)
+#       define RADEON_BLEND_OP_COUNT_SHIFT         12
+#       define RADEON_POSITION_BLEND_OP_ENABLE     (1 << 16)
+#       define RADEON_NORMAL_BLEND_OP_ENABLE       (1 << 17)
+#       define RADEON_VERTEX_BLEND_SRC_0_PRIMARY   (1 << 18)
+#       define RADEON_VERTEX_BLEND_SRC_0_SECONDARY (1 << 18)
+#       define RADEON_VERTEX_BLEND_SRC_1_PRIMARY   (1 << 19)
+#       define RADEON_VERTEX_BLEND_SRC_1_SECONDARY (1 << 19)
+#       define RADEON_VERTEX_BLEND_SRC_2_PRIMARY   (1 << 20)
+#       define RADEON_VERTEX_BLEND_SRC_2_SECONDARY (1 << 20)
+#       define RADEON_VERTEX_BLEND_SRC_3_PRIMARY   (1 << 21)
+#       define RADEON_VERTEX_BLEND_SRC_3_SECONDARY (1 << 21)
+#       define RADEON_VERTEX_BLEND_WGT_MINUS_ONE   (1 << 22)
+#       define RADEON_CULL_FRONT_IS_CW             (0 << 28)
+#       define RADEON_CULL_FRONT_IS_CCW            (1 << 28)
+#       define RADEON_CULL_FRONT                   (1 << 29)
+#       define RADEON_CULL_BACK                    (1 << 30)
+#       define RADEON_FORCE_W_TO_ONE               (1 << 31)
+
+#define RADEON_SE_VPORT_XSCALE              0x1d98
+#define RADEON_SE_VPORT_XOFFSET             0x1d9c
+#define RADEON_SE_VPORT_YSCALE              0x1da0
+#define RADEON_SE_VPORT_YOFFSET             0x1da4
+#define RADEON_SE_VPORT_ZSCALE              0x1da8
+#define RADEON_SE_VPORT_ZOFFSET             0x1dac
+#define RADEON_SE_ZBIAS_FACTOR              0x1db0
+#define RADEON_SE_ZBIAS_CONSTANT            0x1db4
+
+#define RADEON_SE_VTX_FMT                   0x2080
+#       define RADEON_SE_VTX_FMT_XY         0x00000000
+#       define RADEON_SE_VTX_FMT_W0         0x00000001
+#       define RADEON_SE_VTX_FMT_FPCOLOR    0x00000002
+#       define RADEON_SE_VTX_FMT_FPALPHA    0x00000004
+#       define RADEON_SE_VTX_FMT_PKCOLOR    0x00000008
+#       define RADEON_SE_VTX_FMT_FPSPEC     0x00000010
+#       define RADEON_SE_VTX_FMT_FPFOG      0x00000020
+#       define RADEON_SE_VTX_FMT_PKSPEC     0x00000040
+#       define RADEON_SE_VTX_FMT_ST0        0x00000080
+#       define RADEON_SE_VTX_FMT_ST1        0x00000100
+#       define RADEON_SE_VTX_FMT_Q1         0x00000200
+#       define RADEON_SE_VTX_FMT_ST2        0x00000400
+#       define RADEON_SE_VTX_FMT_Q2         0x00000800
+#       define RADEON_SE_VTX_FMT_ST3        0x00001000
+#       define RADEON_SE_VTX_FMT_Q3         0x00002000
+#       define RADEON_SE_VTX_FMT_Q0         0x00004000
+#       define RADEON_SE_VTX_FMT_BLND_WEIGHT_CNT_MASK  0x00038000
+#       define RADEON_SE_VTX_FMT_N0         0x00040000
+#       define RADEON_SE_VTX_FMT_XY1        0x08000000
+#       define RADEON_SE_VTX_FMT_Z1         0x10000000
+#       define RADEON_SE_VTX_FMT_W1         0x20000000
+#       define RADEON_SE_VTX_FMT_N1         0x40000000
+#       define RADEON_SE_VTX_FMT_Z          0x80000000
+
+#define RADEON_SE_VF_CNTL                             0x2084
+#       define RADEON_VF_PRIM_TYPE_POINT_LIST         1
+#       define RADEON_VF_PRIM_TYPE_LINE_LIST          2
+#       define RADEON_VF_PRIM_TYPE_LINE_STRIP         3
+#       define RADEON_VF_PRIM_TYPE_TRIANGLE_LIST      4
+#       define RADEON_VF_PRIM_TYPE_TRIANGLE_FAN       5
+#       define RADEON_VF_PRIM_TYPE_TRIANGLE_STRIP     6
+#       define RADEON_VF_PRIM_TYPE_TRIANGLE_FLAG      7
+#       define RADEON_VF_PRIM_TYPE_RECTANGLE_LIST     8
+#       define RADEON_VF_PRIM_TYPE_POINT_LIST_3       9
+#       define RADEON_VF_PRIM_TYPE_LINE_LIST_3        10
+#       define RADEON_VF_PRIM_TYPE_SPIRIT_LIST        11
+#       define RADEON_VF_PRIM_TYPE_LINE_LOOP          12
+#       define RADEON_VF_PRIM_TYPE_QUAD_LIST          13
+#       define RADEON_VF_PRIM_TYPE_QUAD_STRIP         14
+#       define RADEON_VF_PRIM_TYPE_POLYGON            15
+#       define RADEON_VF_PRIM_WALK_STATE              (0<<4)
+#       define RADEON_VF_PRIM_WALK_INDEX              (1<<4)
+#       define RADEON_VF_PRIM_WALK_LIST               (2<<4)
+#       define RADEON_VF_PRIM_WALK_DATA               (3<<4)
+#       define RADEON_VF_COLOR_ORDER_RGBA             (1<<6)
+#       define RADEON_VF_RADEON_MODE                  (1<<8)
+#       define RADEON_VF_TCL_OUTPUT_CTL_ENA           (1<<9)
+#       define RADEON_VF_PROG_STREAM_ENA              (1<<10)
+#       define RADEON_VF_INDEX_SIZE_SHIFT             11
+#       define RADEON_VF_NUM_VERTICES_SHIFT           16
+
+#define RADEON_SE_PORT_DATA0			0x2000
+
+#define R200_SE_VAP_CNTL			0x2080
+#       define R200_VAP_TCL_ENABLE		0x00000001
+#       define R200_VAP_SINGLE_BUF_STATE_ENABLE	0x00000010
+#       define R200_VAP_FORCE_W_TO_ONE		0x00010000
+#       define R200_VAP_D3D_TEX_DEFAULT		0x00020000
+#       define R200_VAP_VF_MAX_VTX_NUM__SHIFT	18
+#       define R200_VAP_VF_MAX_VTX_NUM		(9 << 18)
+#       define R200_VAP_DX_CLIP_SPACE_DEF	0x00400000
+#define R200_VF_MAX_VTX_INDX			0x210c
+#define R200_VF_MIN_VTX_INDX			0x2110
+#define R200_SE_VTE_CNTL			0x20b0
+#       define R200_VPORT_X_SCALE_ENA			0x00000001
+#       define R200_VPORT_X_OFFSET_ENA			0x00000002
+#       define R200_VPORT_Y_SCALE_ENA			0x00000004
+#       define R200_VPORT_Y_OFFSET_ENA			0x00000008
+#       define R200_VPORT_Z_SCALE_ENA			0x00000010
+#       define R200_VPORT_Z_OFFSET_ENA			0x00000020
+#       define R200_VTX_XY_FMT				0x00000100
+#       define R200_VTX_Z_FMT				0x00000200
+#       define R200_VTX_W0_FMT				0x00000400
+#       define R200_VTX_W0_NORMALIZE			0x00000800
+#       define R200_VTX_ST_DENORMALIZED		0x00001000
+#define R200_SE_VAP_CNTL_STATUS			0x2140
+#       define R200_VC_NO_SWAP			(0 << 0)
+#       define R200_VC_16BIT_SWAP		(1 << 0)
+#       define R200_VC_32BIT_SWAP		(2 << 0)
+#define R200_PP_TXFILTER_0			0x2c00
+#define R200_PP_TXFILTER_1			0x2c20
+#define R200_PP_TXFILTER_2			0x2c40
+#define R200_PP_TXFILTER_3			0x2c60
+#define R200_PP_TXFILTER_4			0x2c80
+#define R200_PP_TXFILTER_5			0x2ca0
+#       define R200_MAG_FILTER_NEAREST		(0  <<  0)
+#       define R200_MAG_FILTER_LINEAR		(1  <<  0)
+#       define R200_MAG_FILTER_MASK		(1  <<  0)
+#       define R200_MIN_FILTER_NEAREST		(0  <<  1)
+#       define R200_MIN_FILTER_LINEAR		(1  <<  1)
+#       define R200_MIN_FILTER_NEAREST_MIP_NEAREST (2  <<  1)
+#       define R200_MIN_FILTER_NEAREST_MIP_LINEAR (3  <<  1)
+#       define R200_MIN_FILTER_LINEAR_MIP_NEAREST (6  <<  1)
+#       define R200_MIN_FILTER_LINEAR_MIP_LINEAR (7  <<  1)
+#       define R200_MIN_FILTER_ANISO_NEAREST	(8  <<  1)
+#       define R200_MIN_FILTER_ANISO_LINEAR	(9  <<  1)
+#       define R200_MIN_FILTER_ANISO_NEAREST_MIP_NEAREST (10 <<  1)
+#       define R200_MIN_FILTER_ANISO_NEAREST_MIP_LINEAR (11 <<  1)
+#       define R200_MIN_FILTER_MASK		(15 <<  1)
+#       define R200_MAX_ANISO_1_TO_1		(0  <<  5)
+#       define R200_MAX_ANISO_2_TO_1		(1  <<  5)
+#       define R200_MAX_ANISO_4_TO_1		(2  <<  5)
+#       define R200_MAX_ANISO_8_TO_1		(3  <<  5)
+#       define R200_MAX_ANISO_16_TO_1		(4  <<  5)
+#       define R200_MAX_ANISO_MASK		(7  <<  5)
+#       define R200_MAX_MIP_LEVEL_MASK		(0x0f << 16)
+#       define R200_MAX_MIP_LEVEL_SHIFT		16
+#       define R200_YUV_TO_RGB			(1  << 20)
+#       define R200_YUV_TEMPERATURE_COOL	(0  << 21)
+#       define R200_YUV_TEMPERATURE_HOT		(1  << 21)
+#       define R200_YUV_TEMPERATURE_MASK	(1  << 21)
+#       define R200_WRAPEN_S			(1  << 22)
+#       define R200_CLAMP_S_WRAP		(0  << 23)
+#       define R200_CLAMP_S_MIRROR		(1  << 23)
+#       define R200_CLAMP_S_CLAMP_LAST		(2  << 23)
+#       define R200_CLAMP_S_MIRROR_CLAMP_LAST	(3  << 23)
+#       define R200_CLAMP_S_CLAMP_BORDER	(4  << 23)
+#       define R200_CLAMP_S_MIRROR_CLAMP_BORDER	(5  << 23)
+#       define R200_CLAMP_S_CLAMP_GL		(6  << 23)
+#       define R200_CLAMP_S_MIRROR_CLAMP_GL	(7  << 23)
+#       define R200_CLAMP_S_MASK		(7  << 23)
+#       define R200_WRAPEN_T			(1  << 26)
+#       define R200_CLAMP_T_WRAP		(0  << 27)
+#       define R200_CLAMP_T_MIRROR		(1  << 27)
+#       define R200_CLAMP_T_CLAMP_LAST		(2  << 27)
+#       define R200_CLAMP_T_MIRROR_CLAMP_LAST	(3  << 27)
+#       define R200_CLAMP_T_CLAMP_BORDER	(4  << 27)
+#       define R200_CLAMP_T_MIRROR_CLAMP_BORDER	(5  << 27)
+#       define R200_CLAMP_T_CLAMP_GL		(6  << 27)
+#       define R200_CLAMP_T_MIRROR_CLAMP_GL	(7  << 27)
+#       define R200_CLAMP_T_MASK		(7  << 27)
+#       define R200_KILL_LT_ZERO		(1  << 30)
+#       define R200_BORDER_MODE_OGL		(0  << 31)
+#       define R200_BORDER_MODE_D3D		(1  << 31)
+#define R200_PP_TXFORMAT_0			0x2c04
+#define R200_PP_TXFORMAT_1			0x2c24
+#define R200_PP_TXFORMAT_2			0x2c44
+#define R200_PP_TXFORMAT_3			0x2c64
+#define R200_PP_TXFORMAT_4			0x2c84
+#define R200_PP_TXFORMAT_5			0x2ca4
+#       define R200_TXFORMAT_I8			(0 << 0)
+#       define R200_TXFORMAT_AI88		(1 << 0)
+#       define R200_TXFORMAT_RGB332		(2 << 0)
+#       define R200_TXFORMAT_ARGB1555		(3 << 0)
+#       define R200_TXFORMAT_RGB565		(4 << 0)
+#       define R200_TXFORMAT_ARGB4444		(5 << 0)
+#       define R200_TXFORMAT_ARGB8888		(6 << 0)
+#       define R200_TXFORMAT_RGBA8888		(7 << 0)
+#       define R200_TXFORMAT_Y8			(8 << 0)
+#       define R200_TXFORMAT_AVYU4444		(9 << 0)
+#       define R200_TXFORMAT_VYUY422		(10 << 0)
+#       define R200_TXFORMAT_YVYU422		(11 << 0)
+#       define R200_TXFORMAT_DXT1		(12 << 0)
+#       define R200_TXFORMAT_DXT23		(14 << 0)
+#       define R200_TXFORMAT_DXT45		(15 << 0)
+#       define R200_TXFORMAT_DVDU88		(18 << 0)
+#       define R200_TXFORMAT_LDVDU655		(19 << 0)
+#       define R200_TXFORMAT_LDVDU8888		(20 << 0)
+#       define R200_TXFORMAT_GR1616		(21 << 0)
+#       define R200_TXFORMAT_ABGR8888		(22 << 0)
+#       define R200_TXFORMAT_BGR111110		(23 << 0)
+#       define R200_TXFORMAT_FORMAT_MASK	(31 <<	0)
+#       define R200_TXFORMAT_FORMAT_SHIFT	0
+#       define R200_TXFORMAT_ALPHA_IN_MAP	(1 << 6)
+#       define R200_TXFORMAT_NON_POWER2		(1 << 7)
+#       define R200_TXFORMAT_WIDTH_MASK		(15 <<	8)
+#       define R200_TXFORMAT_WIDTH_SHIFT	8
+#       define R200_TXFORMAT_HEIGHT_MASK	(15 << 12)
+#       define R200_TXFORMAT_HEIGHT_SHIFT	12
+#       define R200_TXFORMAT_F5_WIDTH_MASK	(15 << 16)	/* cube face 5 */
+#       define R200_TXFORMAT_F5_WIDTH_SHIFT	16
+#       define R200_TXFORMAT_F5_HEIGHT_MASK	(15 << 20)
+#       define R200_TXFORMAT_F5_HEIGHT_SHIFT	20
+#       define R200_TXFORMAT_ST_ROUTE_STQ0	(0 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_STQ1	(1 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_STQ2	(2 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_STQ3	(3 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_STQ4	(4 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_STQ5	(5 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_MASK	(7 << 24)
+#       define R200_TXFORMAT_ST_ROUTE_SHIFT	24
+#       define R200_TXFORMAT_LOOKUP_DISABLE	(1 << 27)
+#       define R200_TXFORMAT_ALPHA_MASK_ENABLE	(1 << 28)
+#       define R200_TXFORMAT_CHROMA_KEY_ENABLE	(1 << 29)
+#       define R200_TXFORMAT_CUBIC_MAP_ENABLE		(1 << 30)
+#define R200_PP_TXFORMAT_X_0                    0x2c08
+#define R200_PP_TXFORMAT_X_1                    0x2c28
+#define R200_PP_TXFORMAT_X_2                    0x2c48
+#define R200_PP_TXFORMAT_X_3                    0x2c68
+#define R200_PP_TXFORMAT_X_4                    0x2c88
+#define R200_PP_TXFORMAT_X_5                    0x2ca8
+
+#define R200_PP_TXSIZE_0			0x2c0c /* NPOT only */
+#define R200_PP_TXSIZE_1			0x2c2c /* NPOT only */
+#define R200_PP_TXSIZE_2			0x2c4c /* NPOT only */
+#define R200_PP_TXSIZE_3			0x2c6c /* NPOT only */
+#define R200_PP_TXSIZE_4			0x2c8c /* NPOT only */
+#define R200_PP_TXSIZE_5			0x2cac /* NPOT only */
+
+#define R200_PP_TXPITCH_0                       0x2c10 /* NPOT only */
+#define R200_PP_TXPITCH_1			0x2c30 /* NPOT only */
+#define R200_PP_TXPITCH_2			0x2c50 /* NPOT only */
+#define R200_PP_TXPITCH_3			0x2c70 /* NPOT only */
+#define R200_PP_TXPITCH_4			0x2c90 /* NPOT only */
+#define R200_PP_TXPITCH_5			0x2cb0 /* NPOT only */
+
+#define R200_PP_CUBIC_FACES_0			0x2c18
+#define R200_PP_CUBIC_FACES_1			0x2c38
+#define R200_PP_CUBIC_FACES_2			0x2c58
+#define R200_PP_CUBIC_FACES_3			0x2c78
+#define R200_PP_CUBIC_FACES_4			0x2c98
+#define R200_PP_CUBIC_FACES_5			0x2cb8
+
+#define R200_PP_TXOFFSET_0			0x2d00
+#       define R200_TXO_ENDIAN_NO_SWAP		(0 << 0)
+#       define R200_TXO_ENDIAN_BYTE_SWAP	(1 << 0)
+#       define R200_TXO_ENDIAN_WORD_SWAP	(2 << 0)
+#       define R200_TXO_ENDIAN_HALFDW_SWAP	(3 << 0)
+#       define R200_TXO_MACRO_LINEAR		(0 << 2)
+#       define R200_TXO_MACRO_TILE		(1 << 2)
+#       define R200_TXO_MICRO_LINEAR		(0 << 3)
+#       define R200_TXO_MICRO_TILE		(1 << 3)
+#       define R200_TXO_OFFSET_MASK		0xffffffe0
+#       define R200_TXO_OFFSET_SHIFT		5
+#define R200_PP_CUBIC_OFFSET_F1_0         0x2d04
+#define R200_PP_CUBIC_OFFSET_F2_0         0x2d08
+#define R200_PP_CUBIC_OFFSET_F3_0         0x2d0c
+#define R200_PP_CUBIC_OFFSET_F4_0         0x2d10
+#define R200_PP_CUBIC_OFFSET_F5_0         0x2d14
+
+#define R200_PP_TXOFFSET_1			0x2d18
+#define R200_PP_CUBIC_OFFSET_F1_1         0x2d1c
+#define R200_PP_CUBIC_OFFSET_F2_1         0x2d20
+#define R200_PP_CUBIC_OFFSET_F3_1         0x2d24
+#define R200_PP_CUBIC_OFFSET_F4_1         0x2d28
+#define R200_PP_CUBIC_OFFSET_F5_1         0x2d2c
+
+#define R200_PP_TXOFFSET_2			0x2d30
+#define R200_PP_CUBIC_OFFSET_F1_2         0x2d34
+#define R200_PP_CUBIC_OFFSET_F2_2         0x2d38
+#define R200_PP_CUBIC_OFFSET_F3_2         0x2d3c
+#define R200_PP_CUBIC_OFFSET_F4_2         0x2d40
+#define R200_PP_CUBIC_OFFSET_F5_2         0x2d44
+
+#define R200_PP_TXOFFSET_3			0x2d48
+#define R200_PP_CUBIC_OFFSET_F1_3         0x2d4c
+#define R200_PP_CUBIC_OFFSET_F2_3         0x2d50
+#define R200_PP_CUBIC_OFFSET_F3_3         0x2d54
+#define R200_PP_CUBIC_OFFSET_F4_3         0x2d58
+#define R200_PP_CUBIC_OFFSET_F5_3         0x2d5c
+#define R200_PP_TXOFFSET_4			0x2d60
+#define R200_PP_CUBIC_OFFSET_F1_4         0x2d64
+#define R200_PP_CUBIC_OFFSET_F2_4         0x2d68
+#define R200_PP_CUBIC_OFFSET_F3_4         0x2d6c
+#define R200_PP_CUBIC_OFFSET_F4_4         0x2d70
+#define R200_PP_CUBIC_OFFSET_F5_4         0x2d74
+#define R200_PP_TXOFFSET_5			0x2d78
+#define R200_PP_CUBIC_OFFSET_F1_5         0x2d7c
+#define R200_PP_CUBIC_OFFSET_F2_5         0x2d80
+#define R200_PP_CUBIC_OFFSET_F3_5         0x2d84
+#define R200_PP_CUBIC_OFFSET_F4_5         0x2d88
+#define R200_PP_CUBIC_OFFSET_F5_5         0x2d8c
+
+#define R200_PP_TFACTOR_0			0x2ee0
+#define R200_PP_TFACTOR_1			0x2ee4
+#define R200_PP_TFACTOR_2			0x2ee8
+#define R200_PP_TFACTOR_3			0x2eec
+#define R200_PP_TFACTOR_4			0x2ef0
+#define R200_PP_TFACTOR_5			0x2ef4
+
+#define R200_PP_TXCBLEND_0			0x2f00
+#       define R200_TXC_ARG_A_ZERO		(0)
+#       define R200_TXC_ARG_A_CURRENT_COLOR	(2)
+#       define R200_TXC_ARG_A_CURRENT_ALPHA	(3)
+#       define R200_TXC_ARG_A_DIFFUSE_COLOR	(4)
+#       define R200_TXC_ARG_A_DIFFUSE_ALPHA	(5)
+#       define R200_TXC_ARG_A_SPECULAR_COLOR	(6)
+#       define R200_TXC_ARG_A_SPECULAR_ALPHA	(7)
+#       define R200_TXC_ARG_A_TFACTOR_COLOR	(8)
+#       define R200_TXC_ARG_A_TFACTOR_ALPHA	(9)
+#       define R200_TXC_ARG_A_R0_COLOR		(10)
+#       define R200_TXC_ARG_A_R0_ALPHA		(11)
+#       define R200_TXC_ARG_A_R1_COLOR		(12)
+#       define R200_TXC_ARG_A_R1_ALPHA		(13)
+#       define R200_TXC_ARG_A_R2_COLOR		(14)
+#       define R200_TXC_ARG_A_R2_ALPHA		(15)
+#       define R200_TXC_ARG_A_R3_COLOR		(16)
+#       define R200_TXC_ARG_A_R3_ALPHA		(17)
+#       define R200_TXC_ARG_A_R4_COLOR		(18)
+#       define R200_TXC_ARG_A_R4_ALPHA		(19)
+#       define R200_TXC_ARG_A_R5_COLOR		(20)
+#       define R200_TXC_ARG_A_R5_ALPHA		(21)
+#       define R200_TXC_ARG_A_TFACTOR1_COLOR	(26)
+#       define R200_TXC_ARG_A_TFACTOR1_ALPHA	(27)
+#       define R200_TXC_ARG_A_MASK		(31 << 0)
+#       define R200_TXC_ARG_A_SHIFT		0
+#       define R200_TXC_ARG_B_ZERO		(0 << 5)
+#       define R200_TXC_ARG_B_CURRENT_COLOR	(2 << 5)
+#       define R200_TXC_ARG_B_CURRENT_ALPHA	(3 << 5)
+#       define R200_TXC_ARG_B_DIFFUSE_COLOR	(4 << 5)
+#       define R200_TXC_ARG_B_DIFFUSE_ALPHA	(5 << 5)
+#       define R200_TXC_ARG_B_SPECULAR_COLOR	(6 << 5)
+#       define R200_TXC_ARG_B_SPECULAR_ALPHA	(7 << 5)
+#       define R200_TXC_ARG_B_TFACTOR_COLOR	(8 << 5)
+#       define R200_TXC_ARG_B_TFACTOR_ALPHA	(9 << 5)
+#       define R200_TXC_ARG_B_R0_COLOR		(10 << 5)
+#       define R200_TXC_ARG_B_R0_ALPHA		(11 << 5)
+#       define R200_TXC_ARG_B_R1_COLOR		(12 << 5)
+#       define R200_TXC_ARG_B_R1_ALPHA		(13 << 5)
+#       define R200_TXC_ARG_B_R2_COLOR		(14 << 5)
+#       define R200_TXC_ARG_B_R2_ALPHA		(15 << 5)
+#       define R200_TXC_ARG_B_R3_COLOR		(16 << 5)
+#       define R200_TXC_ARG_B_R3_ALPHA		(17 << 5)
+#       define R200_TXC_ARG_B_R4_COLOR		(18 << 5)
+#       define R200_TXC_ARG_B_R4_ALPHA		(19 << 5)
+#       define R200_TXC_ARG_B_R5_COLOR		(20 << 5)
+#       define R200_TXC_ARG_B_R5_ALPHA		(21 << 5)
+#       define R200_TXC_ARG_B_TFACTOR1_COLOR	(26 << 5)
+#       define R200_TXC_ARG_B_TFACTOR1_ALPHA	(27 << 5)
+#       define R200_TXC_ARG_B_MASK		(31 << 5)
+#       define R200_TXC_ARG_B_SHIFT		5
+#       define R200_TXC_ARG_C_ZERO		(0 << 10)
+#       define R200_TXC_ARG_C_CURRENT_COLOR	(2 << 10)
+#       define R200_TXC_ARG_C_CURRENT_ALPHA	(3 << 10)
+#       define R200_TXC_ARG_C_DIFFUSE_COLOR	(4 << 10)
+#       define R200_TXC_ARG_C_DIFFUSE_ALPHA	(5 << 10)
+#       define R200_TXC_ARG_C_SPECULAR_COLOR	(6 << 10)
+#       define R200_TXC_ARG_C_SPECULAR_ALPHA	(7 << 10)
+#       define R200_TXC_ARG_C_TFACTOR_COLOR	(8 << 10)
+#       define R200_TXC_ARG_C_TFACTOR_ALPHA	(9 << 10)
+#       define R200_TXC_ARG_C_R0_COLOR		(10 << 10)
+#       define R200_TXC_ARG_C_R0_ALPHA		(11 << 10)
+#       define R200_TXC_ARG_C_R1_COLOR		(12 << 10)
+#       define R200_TXC_ARG_C_R1_ALPHA		(13 << 10)
+#       define R200_TXC_ARG_C_R2_COLOR		(14 << 10)
+#       define R200_TXC_ARG_C_R2_ALPHA		(15 << 10)
+#       define R200_TXC_ARG_C_R3_COLOR		(16 << 10)
+#       define R200_TXC_ARG_C_R3_ALPHA		(17 << 10)
+#       define R200_TXC_ARG_C_R4_COLOR		(18 << 10)
+#       define R200_TXC_ARG_C_R4_ALPHA		(19 << 10)
+#       define R200_TXC_ARG_C_R5_COLOR		(20 << 10)
+#       define R200_TXC_ARG_C_R5_ALPHA		(21 << 10)
+#       define R200_TXC_ARG_C_TFACTOR1_COLOR	(26 << 10)
+#       define R200_TXC_ARG_C_TFACTOR1_ALPHA	(27 << 10)
+#       define R200_TXC_ARG_C_MASK		(31 << 10)
+#       define R200_TXC_ARG_C_SHIFT		10
+#       define R200_TXC_COMP_ARG_A		(1 << 16)
+#       define R200_TXC_COMP_ARG_A_SHIFT	(16)
+#       define R200_TXC_BIAS_ARG_A		(1 << 17)
+#       define R200_TXC_SCALE_ARG_A		(1 << 18)
+#       define R200_TXC_NEG_ARG_A		(1 << 19)
+#       define R200_TXC_COMP_ARG_B		(1 << 20)
+#       define R200_TXC_COMP_ARG_B_SHIFT	(20)
+#       define R200_TXC_BIAS_ARG_B		(1 << 21)
+#       define R200_TXC_SCALE_ARG_B		(1 << 22)
+#       define R200_TXC_NEG_ARG_B		(1 << 23)
+#       define R200_TXC_COMP_ARG_C		(1 << 24)
+#       define R200_TXC_COMP_ARG_C_SHIFT	(24)
+#       define R200_TXC_BIAS_ARG_C		(1 << 25)
+#       define R200_TXC_SCALE_ARG_C		(1 << 26)
+#       define R200_TXC_NEG_ARG_C		(1 << 27)
+#       define R200_TXC_OP_MADD			(0 << 28)
+#       define R200_TXC_OP_CND0			(2 << 28)
+#       define R200_TXC_OP_LERP			(3 << 28)
+#       define R200_TXC_OP_DOT3			(4 << 28)
+#       define R200_TXC_OP_DOT4			(5 << 28)
+#       define R200_TXC_OP_CONDITIONAL		(6 << 28)
+#       define R200_TXC_OP_DOT2_ADD		(7 << 28)
+#       define R200_TXC_OP_MASK			(7 << 28)
+#define R200_PP_TXCBLEND2_0		0x2f04
+#       define R200_TXC_TFACTOR_SEL_SHIFT	0
+#       define R200_TXC_TFACTOR_SEL_MASK	0x7
+#       define R200_TXC_TFACTOR1_SEL_SHIFT	4
+#       define R200_TXC_TFACTOR1_SEL_MASK	(0x7 << 4)
+#       define R200_TXC_SCALE_SHIFT		8
+#       define R200_TXC_SCALE_MASK		(7 << 8)
+#       define R200_TXC_SCALE_1X		(0 << 8)
+#       define R200_TXC_SCALE_2X		(1 << 8)
+#       define R200_TXC_SCALE_4X		(2 << 8)
+#       define R200_TXC_SCALE_8X		(3 << 8)
+#       define R200_TXC_SCALE_INV2		(5 << 8)
+#       define R200_TXC_SCALE_INV4		(6 << 8)
+#       define R200_TXC_SCALE_INV8		(7 << 8)
+#       define R200_TXC_CLAMP_SHIFT		12
+#       define R200_TXC_CLAMP_MASK		(3 << 12)
+#       define R200_TXC_CLAMP_WRAP		(0 << 12)
+#       define R200_TXC_CLAMP_0_1		(1 << 12)
+#       define R200_TXC_CLAMP_8_8		(2 << 12)
+#       define R200_TXC_OUTPUT_REG_MASK		(7 << 16)
+#       define R200_TXC_OUTPUT_REG_NONE		(0 << 16)
+#       define R200_TXC_OUTPUT_REG_R0		(1 << 16)
+#       define R200_TXC_OUTPUT_REG_R1		(2 << 16)
+#       define R200_TXC_OUTPUT_REG_R2		(3 << 16)
+#       define R200_TXC_OUTPUT_REG_R3		(4 << 16)
+#       define R200_TXC_OUTPUT_REG_R4		(5 << 16)
+#       define R200_TXC_OUTPUT_REG_R5		(6 << 16)
+#       define R200_TXC_OUTPUT_MASK_MASK	(7 << 20)
+#       define R200_TXC_OUTPUT_MASK_RGB		(0 << 20)
+#       define R200_TXC_OUTPUT_MASK_RG		(1 << 20)
+#       define R200_TXC_OUTPUT_MASK_RB		(2 << 20)
+#       define R200_TXC_OUTPUT_MASK_R		(3 << 20)
+#       define R200_TXC_OUTPUT_MASK_GB		(4 << 20)
+#       define R200_TXC_OUTPUT_MASK_G		(5 << 20)
+#       define R200_TXC_OUTPUT_MASK_B		(6 << 20)
+#       define R200_TXC_OUTPUT_MASK_NONE	(7 << 20)
+#       define R200_TXC_REPL_NORMAL		0
+#       define R200_TXC_REPL_RED		1
+#       define R200_TXC_REPL_GREEN		2
+#       define R200_TXC_REPL_BLUE		3
+#       define R200_TXC_REPL_ARG_A_SHIFT	26
+#       define R200_TXC_REPL_ARG_A_MASK		(3 << 26)
+#       define R200_TXC_REPL_ARG_B_SHIFT	28
+#       define R200_TXC_REPL_ARG_B_MASK		(3 << 28)
+#       define R200_TXC_REPL_ARG_C_SHIFT	30
+#       define R200_TXC_REPL_ARG_C_MASK		(3 << 30)
+#define R200_PP_TXABLEND_0			0x2f08
+#       define R200_TXA_ARG_A_ZERO		(0)
+#       define R200_TXA_ARG_A_CURRENT_ALPHA	(2) /* guess */
+#       define R200_TXA_ARG_A_CURRENT_BLUE	(3) /* guess */
+#       define R200_TXA_ARG_A_DIFFUSE_ALPHA	(4)
+#       define R200_TXA_ARG_A_DIFFUSE_BLUE	(5)
+#       define R200_TXA_ARG_A_SPECULAR_ALPHA	(6)
+#       define R200_TXA_ARG_A_SPECULAR_BLUE	(7)
+#       define R200_TXA_ARG_A_TFACTOR_ALPHA	(8)
+#       define R200_TXA_ARG_A_TFACTOR_BLUE	(9)
+#       define R200_TXA_ARG_A_R0_ALPHA		(10)
+#       define R200_TXA_ARG_A_R0_BLUE		(11)
+#       define R200_TXA_ARG_A_R1_ALPHA		(12)
+#       define R200_TXA_ARG_A_R1_BLUE		(13)
+#       define R200_TXA_ARG_A_R2_ALPHA		(14)
+#       define R200_TXA_ARG_A_R2_BLUE		(15)
+#       define R200_TXA_ARG_A_R3_ALPHA		(16)
+#       define R200_TXA_ARG_A_R3_BLUE		(17)
+#       define R200_TXA_ARG_A_R4_ALPHA		(18)
+#       define R200_TXA_ARG_A_R4_BLUE		(19)
+#       define R200_TXA_ARG_A_R5_ALPHA		(20)
+#       define R200_TXA_ARG_A_R5_BLUE		(21)
+#       define R200_TXA_ARG_A_TFACTOR1_ALPHA	(26)
+#       define R200_TXA_ARG_A_TFACTOR1_BLUE	(27)
+#       define R200_TXA_ARG_A_MASK		(31 << 0)
+#       define R200_TXA_ARG_A_SHIFT		0
+#       define R200_TXA_ARG_B_ZERO		(0 << 5)
+#       define R200_TXA_ARG_B_CURRENT_ALPHA	(2 << 5) /* guess */
+#       define R200_TXA_ARG_B_CURRENT_BLUE	(3 << 5) /* guess */
+#       define R200_TXA_ARG_B_DIFFUSE_ALPHA	(4 << 5)
+#       define R200_TXA_ARG_B_DIFFUSE_BLUE	(5 << 5)
+#       define R200_TXA_ARG_B_SPECULAR_ALPHA	(6 << 5)
+#       define R200_TXA_ARG_B_SPECULAR_BLUE	(7 << 5)
+#       define R200_TXA_ARG_B_TFACTOR_ALPHA	(8 << 5)
+#       define R200_TXA_ARG_B_TFACTOR_BLUE	(9 << 5)
+#       define R200_TXA_ARG_B_R0_ALPHA		(10 << 5)
+#       define R200_TXA_ARG_B_R0_BLUE		(11 << 5)
+#       define R200_TXA_ARG_B_R1_ALPHA		(12 << 5)
+#       define R200_TXA_ARG_B_R1_BLUE		(13 << 5)
+#       define R200_TXA_ARG_B_R2_ALPHA		(14 << 5)
+#       define R200_TXA_ARG_B_R2_BLUE		(15 << 5)
+#       define R200_TXA_ARG_B_R3_ALPHA		(16 << 5)
+#       define R200_TXA_ARG_B_R3_BLUE		(17 << 5)
+#       define R200_TXA_ARG_B_R4_ALPHA		(18 << 5)
+#       define R200_TXA_ARG_B_R4_BLUE		(19 << 5)
+#       define R200_TXA_ARG_B_R5_ALPHA		(20 << 5)
+#       define R200_TXA_ARG_B_R5_BLUE		(21 << 5)
+#       define R200_TXA_ARG_B_TFACTOR1_ALPHA	(26 << 5)
+#       define R200_TXA_ARG_B_TFACTOR1_BLUE	(27 << 5)
+#       define R200_TXA_ARG_B_MASK		(31 << 5)
+#       define R200_TXA_ARG_B_SHIFT			5
+#       define R200_TXA_ARG_C_ZERO		(0 << 10)
+#       define R200_TXA_ARG_C_CURRENT_ALPHA	(2 << 10) /* guess */
+#       define R200_TXA_ARG_C_CURRENT_BLUE	(3 << 10) /* guess */
+#       define R200_TXA_ARG_C_DIFFUSE_ALPHA	(4 << 10)
+#       define R200_TXA_ARG_C_DIFFUSE_BLUE	(5 << 10)
+#       define R200_TXA_ARG_C_SPECULAR_ALPHA	(6 << 10)
+#       define R200_TXA_ARG_C_SPECULAR_BLUE	(7 << 10)
+#       define R200_TXA_ARG_C_TFACTOR_ALPHA	(8 << 10)
+#       define R200_TXA_ARG_C_TFACTOR_BLUE	(9 << 10)
+#       define R200_TXA_ARG_C_R0_ALPHA		(10 << 10)
+#       define R200_TXA_ARG_C_R0_BLUE		(11 << 10)
+#       define R200_TXA_ARG_C_R1_ALPHA		(12 << 10)
+#       define R200_TXA_ARG_C_R1_BLUE		(13 << 10)
+#       define R200_TXA_ARG_C_R2_ALPHA		(14 << 10)
+#       define R200_TXA_ARG_C_R2_BLUE		(15 << 10)
+#       define R200_TXA_ARG_C_R3_ALPHA		(16 << 10)
+#       define R200_TXA_ARG_C_R3_BLUE		(17 << 10)
+#       define R200_TXA_ARG_C_R4_ALPHA		(18 << 10)
+#       define R200_TXA_ARG_C_R4_BLUE		(19 << 10)
+#       define R200_TXA_ARG_C_R5_ALPHA		(20 << 10)
+#       define R200_TXA_ARG_C_R5_BLUE		(21 << 10)
+#       define R200_TXA_ARG_C_TFACTOR1_ALPHA	(26 << 10)
+#       define R200_TXA_ARG_C_TFACTOR1_BLUE	(27 << 10)
+#       define R200_TXA_ARG_C_MASK		(31 << 10)
+#       define R200_TXA_ARG_C_SHIFT		10
+#       define R200_TXA_COMP_ARG_A		(1 << 16)
+#       define R200_TXA_COMP_ARG_A_SHIFT	(16)
+#       define R200_TXA_BIAS_ARG_A		(1 << 17)
+#       define R200_TXA_SCALE_ARG_A		(1 << 18)
+#       define R200_TXA_NEG_ARG_A		(1 << 19)
+#       define R200_TXA_COMP_ARG_B		(1 << 20)
+#       define R200_TXA_COMP_ARG_B_SHIFT	(20)
+#       define R200_TXA_BIAS_ARG_B		(1 << 21)
+#       define R200_TXA_SCALE_ARG_B		(1 << 22)
+#       define R200_TXA_NEG_ARG_B		(1 << 23)
+#       define R200_TXA_COMP_ARG_C		(1 << 24)
+#       define R200_TXA_COMP_ARG_C_SHIFT	(24)
+#       define R200_TXA_BIAS_ARG_C		(1 << 25)
+#       define R200_TXA_SCALE_ARG_C		(1 << 26)
+#       define R200_TXA_NEG_ARG_C		(1 << 27)
+#       define R200_TXA_OP_MADD			(0 << 28)
+#       define R200_TXA_OP_CND0			(2 << 28)
+#       define R200_TXA_OP_LERP			(3 << 28)
+#       define R200_TXA_OP_CONDITIONAL		(6 << 28)
+#       define R200_TXA_OP_MASK			(7 << 28)
+#define R200_PP_TXABLEND2_0			0x2f0c
+#       define R200_TXA_TFACTOR_SEL_SHIFT	0
+#       define R200_TXA_TFACTOR_SEL_MASK	0x7
+#       define R200_TXA_TFACTOR1_SEL_SHIFT	4
+#       define R200_TXA_TFACTOR1_SEL_MASK	(0x7 << 4)
+#       define R200_TXA_SCALE_SHIFT		8
+#       define R200_TXA_SCALE_MASK		(7 << 8)
+#       define R200_TXA_SCALE_1X		(0 << 8)
+#       define R200_TXA_SCALE_2X		(1 << 8)
+#       define R200_TXA_SCALE_4X		(2 << 8)
+#       define R200_TXA_SCALE_8X		(3 << 8)
+#       define R200_TXA_SCALE_INV2		(5 << 8)
+#       define R200_TXA_SCALE_INV4		(6 << 8)
+#       define R200_TXA_SCALE_INV8		(7 << 8)
+#       define R200_TXA_CLAMP_SHIFT		12
+#       define R200_TXA_CLAMP_MASK		(3 << 12)
+#       define R200_TXA_CLAMP_WRAP		(0 << 12)
+#       define R200_TXA_CLAMP_0_1		(1 << 12)
+#       define R200_TXA_CLAMP_8_8		(2 << 12)
+#       define R200_TXA_OUTPUT_REG_MASK		(7 << 16)
+#       define R200_TXA_OUTPUT_REG_NONE		(0 << 16)
+#       define R200_TXA_OUTPUT_REG_R0		(1 << 16)
+#       define R200_TXA_OUTPUT_REG_R1		(2 << 16)
+#       define R200_TXA_OUTPUT_REG_R2		(3 << 16)
+#       define R200_TXA_OUTPUT_REG_R3		(4 << 16)
+#       define R200_TXA_OUTPUT_REG_R4		(5 << 16)
+#       define R200_TXA_OUTPUT_REG_R5		(6 << 16)
+#       define R200_TXA_DOT_ALPHA		(1 << 20)
+#       define R200_TXA_REPL_NORMAL		0
+#       define R200_TXA_REPL_RED		1
+#       define R200_TXA_REPL_GREEN		2
+#       define R200_TXA_REPL_ARG_A_SHIFT	26
+#       define R200_TXA_REPL_ARG_A_MASK		(3 << 26)
+#       define R200_TXA_REPL_ARG_B_SHIFT	28
+#       define R200_TXA_REPL_ARG_B_MASK		(3 << 28)
+#       define R200_TXA_REPL_ARG_C_SHIFT	30
+#       define R200_TXA_REPL_ARG_C_MASK		(3 << 30)
+
+#define R200_SE_VTX_FMT_0			0x2088
+#       define R200_VTX_XY			0 /* always have xy */
+#       define R200_VTX_Z0			(1<<0)
+#       define R200_VTX_W0			(1<<1)
+#       define R200_VTX_WEIGHT_COUNT_SHIFT	(2)
+#       define R200_VTX_PV_MATRIX_SEL		(1<<5)
+#       define R200_VTX_N0			(1<<6)
+#       define R200_VTX_POINT_SIZE		(1<<7)
+#       define R200_VTX_DISCRETE_FOG		(1<<8)
+#       define R200_VTX_SHININESS_0		(1<<9)
+#       define R200_VTX_SHININESS_1		(1<<10)
+#       define   R200_VTX_COLOR_NOT_PRESENT	0
+#       define   R200_VTX_PK_RGBA		1
+#       define   R200_VTX_FP_RGB		2
+#       define   R200_VTX_FP_RGBA		3
+#       define   R200_VTX_COLOR_MASK		3
+#       define R200_VTX_COLOR_0_SHIFT		11
+#       define R200_VTX_COLOR_1_SHIFT		13
+#       define R200_VTX_COLOR_2_SHIFT		15
+#       define R200_VTX_COLOR_3_SHIFT		17
+#       define R200_VTX_COLOR_4_SHIFT		19
+#       define R200_VTX_COLOR_5_SHIFT		21
+#       define R200_VTX_COLOR_6_SHIFT		23
+#       define R200_VTX_COLOR_7_SHIFT		25
+#       define R200_VTX_XY1			(1<<28)
+#       define R200_VTX_Z1			(1<<29)
+#       define R200_VTX_W1			(1<<30)
+#       define R200_VTX_N1			(1<<31)
+#define R200_SE_VTX_FMT_1			0x208c
+#       define R200_VTX_TEX0_COMP_CNT_SHIFT	0
+#       define R200_VTX_TEX1_COMP_CNT_SHIFT	3
+#       define R200_VTX_TEX2_COMP_CNT_SHIFT	6
+#       define R200_VTX_TEX3_COMP_CNT_SHIFT	9
+#       define R200_VTX_TEX4_COMP_CNT_SHIFT	12
+#       define R200_VTX_TEX5_COMP_CNT_SHIFT	15
+
+#define R200_SE_TCL_OUTPUT_VTX_FMT_0		0x2090
+#define R200_SE_TCL_OUTPUT_VTX_FMT_1		0x2094
+#define R200_SE_TCL_OUTPUT_VTX_COMP_SEL		0x2250
+#       define R200_OUTPUT_XYZW			(1<<0)
+#       define R200_OUTPUT_COLOR_0		(1<<8)
+#       define R200_OUTPUT_COLOR_1		(1<<9)
+#       define R200_OUTPUT_TEX_0		(1<<16)
+#       define R200_OUTPUT_TEX_1		(1<<17)
+#       define R200_OUTPUT_TEX_2		(1<<18)
+#       define R200_OUTPUT_TEX_3		(1<<19)
+#       define R200_OUTPUT_TEX_4		(1<<20)
+#       define R200_OUTPUT_TEX_5		(1<<21)
+#       define R200_OUTPUT_TEX_MASK		(0x3f<<16)
+#       define R200_OUTPUT_DISCRETE_FOG		(1<<24)
+#       define R200_OUTPUT_PT_SIZE		(1<<25)
+#       define R200_FORCE_INORDER_PROC		(1<<31)
+#define R200_PP_CNTL_X				0x2cc4
+#define R200_PP_TXMULTI_CTL_0			0x2c1c
+#define R200_PP_TXMULTI_CTL_1			0x2c3c
+#define R200_PP_TXMULTI_CTL_2			0x2c5c
+#define R200_PP_TXMULTI_CTL_3			0x2c7c
+#define R200_PP_TXMULTI_CTL_4			0x2c9c
+#define R200_PP_TXMULTI_CTL_5			0x2cbc
+#define R200_SE_VTX_STATE_CNTL			0x2180
+#       define R200_UPDATE_USER_COLOR_0_ENA_MASK (1<<16)
+
+				/* Registers for CP and Microcode Engine */
+#define RADEON_CP_ME_RAM_ADDR               0x07d4
+#define RADEON_CP_ME_RAM_RADDR              0x07d8
+#define RADEON_CP_ME_RAM_DATAH              0x07dc
+#define RADEON_CP_ME_RAM_DATAL              0x07e0
+
+#define RADEON_CP_RB_BASE                   0x0700
+#define RADEON_CP_RB_CNTL                   0x0704
+#	define RADEON_RB_BUFSZ_SHIFT		0
+#	define RADEON_RB_BUFSZ_MASK		(0x3f << 0)
+#	define RADEON_RB_BLKSZ_SHIFT		8
+#	define RADEON_RB_BLKSZ_MASK		(0x3f << 8)
+#	define RADEON_BUF_SWAP_32BIT		(2 << 16)
+#	define RADEON_MAX_FETCH_SHIFT		18
+#	define RADEON_MAX_FETCH_MASK		(0x3 << 18)
+#	define RADEON_RB_NO_UPDATE		(1 << 27)
+#	define RADEON_RB_RPTR_WR_ENA		(1 << 31)
+#define RADEON_CP_RB_RPTR_ADDR              0x070c
+#define RADEON_CP_RB_RPTR                   0x0710
+#define RADEON_CP_RB_WPTR                   0x0714
+#define RADEON_CP_RB_RPTR_WR                0x071c
+
+#define RADEON_SCRATCH_UMSK		    0x0770
+#define RADEON_SCRATCH_ADDR		    0x0774
+
+#define R600_CP_RB_BASE                     0xc100
+#define R600_CP_RB_CNTL                     0xc104
+#       define R600_RB_BUFSZ(x)             ((x) << 0)
+#       define R600_RB_BLKSZ(x)             ((x) << 8)
+#       define R600_RB_NO_UPDATE            (1 << 27)
+#       define R600_RB_RPTR_WR_ENA          (1 << 31)
+#define R600_CP_RB_RPTR_WR                  0xc108
+#define R600_CP_RB_RPTR_ADDR                0xc10c
+#define R600_CP_RB_RPTR_ADDR_HI             0xc110
+#define R600_CP_RB_WPTR                     0xc114
+#define R600_CP_RB_WPTR_ADDR                0xc118
+#define R600_CP_RB_WPTR_ADDR_HI             0xc11c
+#define R600_CP_RB_RPTR                     0x8700
+#define R600_CP_RB_WPTR_DELAY               0x8704
+
+#define RADEON_CP_IB_BASE                   0x0738
+#define RADEON_CP_IB_BUFSZ                  0x073c
+
+#define RADEON_CP_CSQ_CNTL                  0x0740
+#       define RADEON_CSQ_CNT_PRIMARY_MASK     (0xff << 0)
+#       define RADEON_CSQ_PRIDIS_INDDIS        (0    << 28)
+#       define RADEON_CSQ_PRIPIO_INDDIS        (1    << 28)
+#       define RADEON_CSQ_PRIBM_INDDIS         (2    << 28)
+#       define RADEON_CSQ_PRIPIO_INDBM         (3    << 28)
+#       define RADEON_CSQ_PRIBM_INDBM          (4    << 28)
+#       define RADEON_CSQ_PRIPIO_INDPIO        (15   << 28)
+
+#define R300_CP_RESYNC_ADDR                 0x778
+#define R300_CP_RESYNC_DATA                 0x77c
+
+#define RADEON_CP_CSQ_STAT                  0x07f8
+#       define RADEON_CSQ_RPTR_PRIMARY_MASK    (0xff <<  0)
+#       define RADEON_CSQ_WPTR_PRIMARY_MASK    (0xff <<  8)
+#       define RADEON_CSQ_RPTR_INDIRECT_MASK   (0xff << 16)
+#       define RADEON_CSQ_WPTR_INDIRECT_MASK   (0xff << 24)
+#define RADEON_CP_CSQ2_STAT                  0x07fc
+#define RADEON_CP_CSQ_ADDR                  0x07f0
+#define RADEON_CP_CSQ_DATA                  0x07f4
+#define RADEON_CP_CSQ_APER_PRIMARY          0x1000
+#define RADEON_CP_CSQ_APER_INDIRECT         0x1300
+
+#define RADEON_CP_RB_WPTR_DELAY             0x0718
+#       define RADEON_PRE_WRITE_TIMER_SHIFT    0
+#       define RADEON_PRE_WRITE_LIMIT_SHIFT    23
+#define RADEON_CP_CSQ_MODE		0x0744
+#	define RADEON_INDIRECT2_START_SHIFT	0
+#	define RADEON_INDIRECT2_START_MASK	(0x7f << 0)
+#	define RADEON_INDIRECT1_START_SHIFT	8
+#	define RADEON_INDIRECT1_START_MASK	(0x7f << 8)
+
+#define RADEON_AIC_CNTL                     0x01d0
+#       define RADEON_PCIGART_TRANSLATE_EN     (1 << 0)
+#       define RADEON_DIS_OUT_OF_PCI_GART_ACCESS     (1 << 1)
+#	define RS400_MSI_REARM	                (1 << 3) /* rs400/rs480 */
+#define RADEON_AIC_LO_ADDR                  0x01dc
+#define RADEON_AIC_PT_BASE		0x01d8
+#define RADEON_AIC_HI_ADDR		0x01e0
+
+
+
+				/* Constants */
+/* #define RADEON_LAST_FRAME_REG               RADEON_GUI_SCRATCH_REG0 */
+/* efine RADEON_LAST_CLEAR_REG               RADEON_GUI_SCRATCH_REG2 */
+
+
+
+				/* CP packet types */
+#define RADEON_CP_PACKET0                           0x00000000
+#define RADEON_CP_PACKET1                           0x40000000
+#define RADEON_CP_PACKET2                           0x80000000
+#define RADEON_CP_PACKET3                           0xC0000000
+#       define RADEON_CP_PACKET_MASK                0xC0000000
+#       define RADEON_CP_PACKET_COUNT_MASK          0x3fff0000
+#       define RADEON_CP_PACKET_MAX_DWORDS          (1 << 12)
+#       define RADEON_CP_PACKET0_REG_MASK           0x000007ff
+#       define R300_CP_PACKET0_REG_MASK             0x00001fff
+#       define R600_CP_PACKET0_REG_MASK             0x0000ffff
+#       define RADEON_CP_PACKET1_REG0_MASK          0x000007ff
+#       define RADEON_CP_PACKET1_REG1_MASK          0x003ff800
+
+#define RADEON_CP_PACKET0_ONE_REG_WR                0x00008000
+
+#define RADEON_CP_PACKET3_NOP                       0xC0001000
+#define RADEON_CP_PACKET3_NEXT_CHAR                 0xC0001900
+#define RADEON_CP_PACKET3_PLY_NEXTSCAN              0xC0001D00
+#define RADEON_CP_PACKET3_SET_SCISSORS              0xC0001E00
+#define RADEON_CP_PACKET3_3D_RNDR_GEN_INDX_PRIM     0xC0002300
+#define RADEON_CP_PACKET3_LOAD_MICROCODE            0xC0002400
+#define RADEON_CP_PACKET3_WAIT_FOR_IDLE             0xC0002600
+#define RADEON_CP_PACKET3_3D_DRAW_VBUF              0xC0002800
+#define RADEON_CP_PACKET3_3D_DRAW_IMMD              0xC0002900
+#define RADEON_CP_PACKET3_3D_DRAW_INDX              0xC0002A00
+#define RADEON_CP_PACKET3_LOAD_PALETTE              0xC0002C00
+#define R200_CP_PACKET3_3D_DRAW_IMMD_2              0xc0003500
+#define RADEON_CP_PACKET3_3D_LOAD_VBPNTR            0xC0002F00
+#define RADEON_CP_PACKET3_CNTL_PAINT                0xC0009100
+#define RADEON_CP_PACKET3_CNTL_BITBLT               0xC0009200
+#define RADEON_CP_PACKET3_CNTL_SMALLTEXT            0xC0009300
+#define RADEON_CP_PACKET3_CNTL_HOSTDATA_BLT         0xC0009400
+#define RADEON_CP_PACKET3_CNTL_POLYLINE             0xC0009500
+#define RADEON_CP_PACKET3_CNTL_POLYSCANLINES        0xC0009800
+#define RADEON_CP_PACKET3_CNTL_PAINT_MULTI          0xC0009A00
+#define RADEON_CP_PACKET3_CNTL_BITBLT_MULTI         0xC0009B00
+#define RADEON_CP_PACKET3_CNTL_TRANS_BITBLT         0xC0009C00
+
+
+#define RADEON_CP_VC_FRMT_XY                        0x00000000
+#define RADEON_CP_VC_FRMT_W0                        0x00000001
+#define RADEON_CP_VC_FRMT_FPCOLOR                   0x00000002
+#define RADEON_CP_VC_FRMT_FPALPHA                   0x00000004
+#define RADEON_CP_VC_FRMT_PKCOLOR                   0x00000008
+#define RADEON_CP_VC_FRMT_FPSPEC                    0x00000010
+#define RADEON_CP_VC_FRMT_FPFOG                     0x00000020
+#define RADEON_CP_VC_FRMT_PKSPEC                    0x00000040
+#define RADEON_CP_VC_FRMT_ST0                       0x00000080
+#define RADEON_CP_VC_FRMT_ST1                       0x00000100
+#define RADEON_CP_VC_FRMT_Q1                        0x00000200
+#define RADEON_CP_VC_FRMT_ST2                       0x00000400
+#define RADEON_CP_VC_FRMT_Q2                        0x00000800
+#define RADEON_CP_VC_FRMT_ST3                       0x00001000
+#define RADEON_CP_VC_FRMT_Q3                        0x00002000
+#define RADEON_CP_VC_FRMT_Q0                        0x00004000
+#define RADEON_CP_VC_FRMT_BLND_WEIGHT_CNT_MASK      0x00038000
+#define RADEON_CP_VC_FRMT_N0                        0x00040000
+#define RADEON_CP_VC_FRMT_XY1                       0x08000000
+#define RADEON_CP_VC_FRMT_Z1                        0x10000000
+#define RADEON_CP_VC_FRMT_W1                        0x20000000
+#define RADEON_CP_VC_FRMT_N1                        0x40000000
+#define RADEON_CP_VC_FRMT_Z                         0x80000000
+
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_NONE            0x00000000
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_POINT           0x00000001
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_LINE            0x00000002
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_LINE_STRIP      0x00000003
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_TRI_LIST        0x00000004
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_TRI_FAN         0x00000005
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_TRI_STRIP       0x00000006
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_TRI_TYPE_2      0x00000007
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_RECT_LIST       0x00000008
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_3VRT_POINT_LIST 0x00000009
+#define RADEON_CP_VC_CNTL_PRIM_TYPE_3VRT_LINE_LIST  0x0000000a
+#define RADEON_CP_VC_CNTL_PRIM_WALK_IND             0x00000010
+#define RADEON_CP_VC_CNTL_PRIM_WALK_LIST            0x00000020
+#define RADEON_CP_VC_CNTL_PRIM_WALK_RING            0x00000030
+#define RADEON_CP_VC_CNTL_COLOR_ORDER_BGRA          0x00000000
+#define RADEON_CP_VC_CNTL_COLOR_ORDER_RGBA          0x00000040
+#define RADEON_CP_VC_CNTL_MAOS_ENABLE               0x00000080
+#define RADEON_CP_VC_CNTL_VTX_FMT_NON_RADEON_MODE   0x00000000
+#define RADEON_CP_VC_CNTL_VTX_FMT_RADEON_MODE       0x00000100
+#define RADEON_CP_VC_CNTL_TCL_DISABLE               0x00000000
+#define RADEON_CP_VC_CNTL_TCL_ENABLE                0x00000200
+#define RADEON_CP_VC_CNTL_NUM_SHIFT                 16
+
+#define RADEON_VS_MATRIX_0_ADDR                   0
+#define RADEON_VS_MATRIX_1_ADDR                   4
+#define RADEON_VS_MATRIX_2_ADDR                   8
+#define RADEON_VS_MATRIX_3_ADDR                  12
+#define RADEON_VS_MATRIX_4_ADDR                  16
+#define RADEON_VS_MATRIX_5_ADDR                  20
+#define RADEON_VS_MATRIX_6_ADDR                  24
+#define RADEON_VS_MATRIX_7_ADDR                  28
+#define RADEON_VS_MATRIX_8_ADDR                  32
+#define RADEON_VS_MATRIX_9_ADDR                  36
+#define RADEON_VS_MATRIX_10_ADDR                 40
+#define RADEON_VS_MATRIX_11_ADDR                 44
+#define RADEON_VS_MATRIX_12_ADDR                 48
+#define RADEON_VS_MATRIX_13_ADDR                 52
+#define RADEON_VS_MATRIX_14_ADDR                 56
+#define RADEON_VS_MATRIX_15_ADDR                 60
+#define RADEON_VS_LIGHT_AMBIENT_ADDR             64
+#define RADEON_VS_LIGHT_DIFFUSE_ADDR             72
+#define RADEON_VS_LIGHT_SPECULAR_ADDR            80
+#define RADEON_VS_LIGHT_DIRPOS_ADDR              88
+#define RADEON_VS_LIGHT_HWVSPOT_ADDR             96
+#define RADEON_VS_LIGHT_ATTENUATION_ADDR        104
+#define RADEON_VS_MATRIX_EYE2CLIP_ADDR          112
+#define RADEON_VS_UCP_ADDR                      116
+#define RADEON_VS_GLOBAL_AMBIENT_ADDR           122
+#define RADEON_VS_FOG_PARAM_ADDR                123
+#define RADEON_VS_EYE_VECTOR_ADDR               124
+
+#define RADEON_SS_LIGHT_DCD_ADDR                  0
+#define RADEON_SS_LIGHT_SPOT_EXPONENT_ADDR        8
+#define RADEON_SS_LIGHT_SPOT_CUTOFF_ADDR         16
+#define RADEON_SS_LIGHT_SPECULAR_THRESH_ADDR     24
+#define RADEON_SS_LIGHT_RANGE_CUTOFF_ADDR        32
+#define RADEON_SS_VERT_GUARD_CLIP_ADJ_ADDR       48
+#define RADEON_SS_VERT_GUARD_DISCARD_ADJ_ADDR    49
+#define RADEON_SS_HORZ_GUARD_CLIP_ADJ_ADDR       50
+#define RADEON_SS_HORZ_GUARD_DISCARD_ADJ_ADDR    51
+#define RADEON_SS_SHININESS                      60
+
+#define RADEON_TV_MASTER_CNTL                    0x0800
+#       define RADEON_TV_ASYNC_RST               (1 <<  0)
+#       define RADEON_CRT_ASYNC_RST              (1 <<  1)
+#       define RADEON_RESTART_PHASE_FIX          (1 <<  3)
+#	define RADEON_TV_FIFO_ASYNC_RST		 (1 <<  4)
+#	define RADEON_VIN_ASYNC_RST		 (1 <<  5)
+#	define RADEON_AUD_ASYNC_RST		 (1 <<  6)
+#	define RADEON_DVS_ASYNC_RST		 (1 <<  7)
+#       define RADEON_CRT_FIFO_CE_EN             (1 <<  9)
+#       define RADEON_TV_FIFO_CE_EN              (1 << 10)
+#       define RADEON_RE_SYNC_NOW_SEL_MASK       (3 << 14)
+#       define RADEON_TVCLK_ALWAYS_ONb           (1 << 30)
+#	define RADEON_TV_ON			 (1 << 31)
+#define RADEON_TV_PRE_DAC_MUX_CNTL               0x0888
+#       define RADEON_Y_RED_EN                   (1 << 0)
+#       define RADEON_C_GRN_EN                   (1 << 1)
+#       define RADEON_CMP_BLU_EN                 (1 << 2)
+#       define RADEON_DAC_DITHER_EN              (1 << 3)
+#       define RADEON_RED_MX_FORCE_DAC_DATA      (6 << 4)
+#       define RADEON_GRN_MX_FORCE_DAC_DATA      (6 << 8)
+#       define RADEON_BLU_MX_FORCE_DAC_DATA      (6 << 12)
+#       define RADEON_TV_FORCE_DAC_DATA_SHIFT    16
+#define RADEON_TV_RGB_CNTL                           0x0804
+#       define RADEON_SWITCH_TO_BLUE		  (1 <<  4)
+#       define RADEON_RGB_DITHER_EN		  (1 <<  5)
+#       define RADEON_RGB_SRC_SEL_MASK		  (3 <<  8)
+#       define RADEON_RGB_SRC_SEL_CRTC1		  (0 <<  8)
+#       define RADEON_RGB_SRC_SEL_RMX		  (1 <<  8)
+#       define RADEON_RGB_SRC_SEL_CRTC2		  (2 <<  8)
+#       define RADEON_RGB_CONVERT_BY_PASS	  (1 << 10)
+#       define RADEON_UVRAM_READ_MARGIN_SHIFT	  16
+#       define RADEON_FIFORAM_FFMACRO_READ_MARGIN_SHIFT	  20
+#       define RADEON_RGB_ATTEN_SEL(x)            ((x) << 24)
+#       define RADEON_TVOUT_SCALE_EN              (1 << 26)
+#       define RADEON_RGB_ATTEN_VAL(x)            ((x) << 28)
+#define RADEON_TV_SYNC_CNTL                          0x0808
+#       define RADEON_SYNC_OE                     (1 <<  0)
+#       define RADEON_SYNC_OUT                    (1 <<  1)
+#       define RADEON_SYNC_IN                     (1 <<  2)
+#       define RADEON_SYNC_PUB                    (1 <<  3)
+#       define RADEON_SYNC_PD                     (1 <<  4)
+#       define RADEON_TV_SYNC_IO_DRIVE            (1 <<  5)
+#define RADEON_TV_HTOTAL                             0x080c
+#define RADEON_TV_HDISP                              0x0810
+#define RADEON_TV_HSTART                             0x0818
+#define RADEON_TV_HCOUNT                             0x081C
+#define RADEON_TV_VTOTAL                             0x0820
+#define RADEON_TV_VDISP                              0x0824
+#define RADEON_TV_VCOUNT                             0x0828
+#define RADEON_TV_FTOTAL                             0x082c
+#define RADEON_TV_FCOUNT                             0x0830
+#define RADEON_TV_FRESTART                           0x0834
+#define RADEON_TV_HRESTART                           0x0838
+#define RADEON_TV_VRESTART                           0x083c
+#define RADEON_TV_HOST_READ_DATA                     0x0840
+#define RADEON_TV_HOST_WRITE_DATA                    0x0844
+#define RADEON_TV_HOST_RD_WT_CNTL                    0x0848
+#	define RADEON_HOST_FIFO_RD		 (1 << 12)
+#	define RADEON_HOST_FIFO_RD_ACK		 (1 << 13)
+#	define RADEON_HOST_FIFO_WT		 (1 << 14)
+#	define RADEON_HOST_FIFO_WT_ACK		 (1 << 15)
+#define RADEON_TV_VSCALER_CNTL1                      0x084c
+#       define RADEON_UV_INC_MASK                0xffff
+#       define RADEON_UV_INC_SHIFT               0
+#       define RADEON_Y_W_EN			 (1 << 24)
+#       define RADEON_RESTART_FIELD              (1 << 29) /* restart on field 0 */
+#       define RADEON_Y_DEL_W_SIG_SHIFT          26
+#define RADEON_TV_TIMING_CNTL                        0x0850
+#       define RADEON_H_INC_MASK                 0xfff
+#       define RADEON_H_INC_SHIFT                0
+#       define RADEON_REQ_Y_FIRST                (1 << 19)
+#       define RADEON_FORCE_BURST_ALWAYS         (1 << 21)
+#       define RADEON_UV_POST_SCALE_BYPASS       (1 << 23)
+#       define RADEON_UV_OUTPUT_POST_SCALE_SHIFT 24
+#define RADEON_TV_VSCALER_CNTL2                      0x0854
+#       define RADEON_DITHER_MODE                (1 <<  0)
+#       define RADEON_Y_OUTPUT_DITHER_EN         (1 <<  1)
+#       define RADEON_UV_OUTPUT_DITHER_EN        (1 <<  2)
+#       define RADEON_UV_TO_BUF_DITHER_EN        (1 <<  3)
+#define RADEON_TV_Y_FALL_CNTL                        0x0858
+#       define RADEON_Y_FALL_PING_PONG           (1 << 16)
+#       define RADEON_Y_COEF_EN                  (1 << 17)
+#define RADEON_TV_Y_RISE_CNTL                        0x085c
+#       define RADEON_Y_RISE_PING_PONG           (1 << 16)
+#define RADEON_TV_Y_SAW_TOOTH_CNTL                   0x0860
+#define RADEON_TV_UPSAMP_AND_GAIN_CNTL               0x0864
+#	define RADEON_YUPSAMP_EN		 (1 <<  0)
+#	define RADEON_UVUPSAMP_EN		 (1 <<  2)
+#define RADEON_TV_GAIN_LIMIT_SETTINGS                0x0868
+#       define RADEON_Y_GAIN_LIMIT_SHIFT         0
+#       define RADEON_UV_GAIN_LIMIT_SHIFT        16
+#define RADEON_TV_LINEAR_GAIN_SETTINGS               0x086c
+#       define RADEON_Y_GAIN_SHIFT               0
+#       define RADEON_UV_GAIN_SHIFT              16
+#define RADEON_TV_MODULATOR_CNTL1                    0x0870
+#	define RADEON_YFLT_EN			 (1 <<  2)
+#	define RADEON_UVFLT_EN			 (1 <<  3)
+#       define RADEON_ALT_PHASE_EN               (1 <<  6)
+#       define RADEON_SYNC_TIP_LEVEL             (1 <<  7)
+#       define RADEON_BLANK_LEVEL_SHIFT          8
+#       define RADEON_SET_UP_LEVEL_SHIFT         16
+#	define RADEON_SLEW_RATE_LIMIT		 (1 << 23)
+#       define RADEON_CY_FILT_BLEND_SHIFT        28
+#define RADEON_TV_MODULATOR_CNTL2                    0x0874
+#       define RADEON_TV_U_BURST_LEVEL_MASK     0x1ff
+#       define RADEON_TV_V_BURST_LEVEL_MASK     0x1ff
+#       define RADEON_TV_V_BURST_LEVEL_SHIFT    16
+#define RADEON_TV_CRC_CNTL                           0x0890
+#define RADEON_TV_UV_ADR                             0x08ac
+#	define RADEON_MAX_UV_ADR_MASK		 0x000000ff
+#	define RADEON_MAX_UV_ADR_SHIFT		 0
+#	define RADEON_TABLE1_BOT_ADR_MASK	 0x0000ff00
+#	define RADEON_TABLE1_BOT_ADR_SHIFT	 8
+#	define RADEON_TABLE3_TOP_ADR_MASK	 0x00ff0000
+#	define RADEON_TABLE3_TOP_ADR_SHIFT	 16
+#	define RADEON_HCODE_TABLE_SEL_MASK	 0x06000000
+#	define RADEON_HCODE_TABLE_SEL_SHIFT	 25
+#	define RADEON_VCODE_TABLE_SEL_MASK	 0x18000000
+#	define RADEON_VCODE_TABLE_SEL_SHIFT	 27
+#	define RADEON_TV_MAX_FIFO_ADDR		 0x1a7
+#	define RADEON_TV_MAX_FIFO_ADDR_INTERNAL	 0x1ff
+#define RADEON_TV_PLL_FINE_CNTL			     0x0020	/* PLL */
+#define RADEON_TV_PLL_CNTL                           0x0021	/* PLL */
+#       define RADEON_TV_M0LO_MASK               0xff
+#       define RADEON_TV_M0HI_MASK               0x7
+#       define RADEON_TV_M0HI_SHIFT              18
+#       define RADEON_TV_N0LO_MASK               0x1ff
+#       define RADEON_TV_N0LO_SHIFT              8
+#       define RADEON_TV_N0HI_MASK               0x3
+#       define RADEON_TV_N0HI_SHIFT              21
+#       define RADEON_TV_P_MASK                  0xf
+#       define RADEON_TV_P_SHIFT                 24
+#       define RADEON_TV_SLIP_EN                 (1 << 23)
+#       define RADEON_TV_DTO_EN                  (1 << 28)
+#define RADEON_TV_PLL_CNTL1                          0x0022	/* PLL */
+#       define RADEON_TVPLL_RESET                (1 <<  1)
+#       define RADEON_TVPLL_SLEEP                (1 <<  3)
+#       define RADEON_TVPLL_REFCLK_SEL           (1 <<  4)
+#       define RADEON_TVPCP_SHIFT                8
+#       define RADEON_TVPCP_MASK                 (7 << 8)
+#       define RADEON_TVPVG_SHIFT                11
+#       define RADEON_TVPVG_MASK                 (7 << 11)
+#       define RADEON_TVPDC_SHIFT                14
+#       define RADEON_TVPDC_MASK                 (3 << 14)
+#       define RADEON_TVPLL_TEST_DIS             (1 << 31)
+#       define RADEON_TVCLK_SRC_SEL_TVPLL        (1 << 30)
+
+#define RS400_DISP2_REQ_CNTL1			0xe30
+#       define RS400_DISP2_START_REQ_LEVEL_SHIFT   0
+#       define RS400_DISP2_START_REQ_LEVEL_MASK    0x3ff
+#       define RS400_DISP2_STOP_REQ_LEVEL_SHIFT    12
+#       define RS400_DISP2_STOP_REQ_LEVEL_MASK     0x3ff
+#       define RS400_DISP2_ALLOW_FID_LEVEL_SHIFT   22
+#       define RS400_DISP2_ALLOW_FID_LEVEL_MASK    0x3ff
+#define RS400_DISP2_REQ_CNTL2			0xe34
+#       define RS400_DISP2_CRITICAL_POINT_START_SHIFT    12
+#       define RS400_DISP2_CRITICAL_POINT_START_MASK     0x3ff
+#       define RS400_DISP2_CRITICAL_POINT_STOP_SHIFT     22
+#       define RS400_DISP2_CRITICAL_POINT_STOP_MASK      0x3ff
+#define RS400_DMIF_MEM_CNTL1			0xe38
+#       define RS400_DISP2_START_ADR_SHIFT      0
+#       define RS400_DISP2_START_ADR_MASK       0x3ff
+#       define RS400_DISP1_CRITICAL_POINT_START_SHIFT    12
+#       define RS400_DISP1_CRITICAL_POINT_START_MASK     0x3ff
+#       define RS400_DISP1_CRITICAL_POINT_STOP_SHIFT     22
+#       define RS400_DISP1_CRITICAL_POINT_STOP_MASK      0x3ff
+#define RS400_DISP1_REQ_CNTL1			0xe3c
+#       define RS400_DISP1_START_REQ_LEVEL_SHIFT   0
+#       define RS400_DISP1_START_REQ_LEVEL_MASK    0x3ff
+#       define RS400_DISP1_STOP_REQ_LEVEL_SHIFT    12
+#       define RS400_DISP1_STOP_REQ_LEVEL_MASK     0x3ff
+#       define RS400_DISP1_ALLOW_FID_LEVEL_SHIFT   22
+#       define RS400_DISP1_ALLOW_FID_LEVEL_MASK    0x3ff
+
+#define RADEON_PCIE_INDEX               0x0030
+#define RADEON_PCIE_DATA                0x0034
+#define RADEON_PCIE_TX_GART_CNTL	0x10
+#	define RADEON_PCIE_TX_GART_EN		(1 << 0)
+#	define RADEON_PCIE_TX_GART_UNMAPPED_ACCESS_PASS_THRU (0 << 1)
+#	define RADEON_PCIE_TX_GART_UNMAPPED_ACCESS_CLAMP_LO  (1 << 1)
+#	define RADEON_PCIE_TX_GART_UNMAPPED_ACCESS_DISCARD   (3 << 1)
+#	define RADEON_PCIE_TX_GART_MODE_32_128_CACHE	(0 << 3)
+#	define RADEON_PCIE_TX_GART_MODE_8_4_128_CACHE	(1 << 3)
+#	define RADEON_PCIE_TX_GART_CHK_RW_VALID_EN      (1 << 5)
+#	define RADEON_PCIE_TX_GART_INVALIDATE_TLB	(1 << 8)
+#define RADEON_PCIE_TX_DISCARD_RD_ADDR_LO 0x11
+#define RADEON_PCIE_TX_DISCARD_RD_ADDR_HI 0x12
+#define RADEON_PCIE_TX_GART_BASE	0x13
+#define RADEON_PCIE_TX_GART_START_LO	0x14
+#define RADEON_PCIE_TX_GART_START_HI	0x15
+#define RADEON_PCIE_TX_GART_END_LO	0x16
+#define RADEON_PCIE_TX_GART_END_HI	0x17
+#define RADEON_PCIE_TX_GART_ERROR	0x18
+
+#define RADEON_SCRATCH_REG0		0x15e0
+#define RADEON_SCRATCH_REG1		0x15e4
+#define RADEON_SCRATCH_REG2		0x15e8
+#define RADEON_SCRATCH_REG3		0x15ec
+#define RADEON_SCRATCH_REG4		0x15f0
+#define RADEON_SCRATCH_REG5		0x15f4
+
+#define RV530_GB_PIPE_SELECT2           0x4124
+
+#define RADEON_CP_PACKET_GET_TYPE(h) (((h) >> 30) & 3)
+#define RADEON_CP_PACKET_GET_COUNT(h) (((h) >> 16) & 0x3FFF)
+#define RADEON_CP_PACKET0_GET_ONE_REG_WR(h) (((h) >> 15) & 1)
+#define RADEON_CP_PACKET3_GET_OPCODE(h) (((h) >> 8) & 0xFF)
+#define R100_CP_PACKET0_GET_REG(h) (((h) & 0x1FFF) << 2)
+#define R600_CP_PACKET0_GET_REG(h) (((h) & 0xFFFF) << 2)
+#define RADEON_PACKET_TYPE0 0
+#define RADEON_PACKET_TYPE1 1
+#define RADEON_PACKET_TYPE2 2
+#define RADEON_PACKET_TYPE3 3
+
+#define RADEON_PACKET3_NOP 0x10
+
+#define RADEON_VLINE_STAT (1 << 12)
+
+#endif
-- 
2.24.0



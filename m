Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1619C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDA2208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O4Jd1J1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDA2208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4xl-0003yW-7b
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vJ-0001Ko-7c
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vI-000518-3b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vH-0004yW-RY; Thu, 19 Sep 2019 18:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932169; x=1600468169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fm00N2pqx55Z9HSQRjm13vGLCGM5jiG5vv/ccdS4eU0=;
 b=O4Jd1J1gWxI2qLyXbTXCtly1broFWhMDJnXVIZ3Bm5VXlQ+KIuUocjRJ
 zQtuWVNd0rUhbjXmHlyVTj0XrQBM0ulTB0ai7L+5h2z5wJyAJojFeGOEm
 WlKKtXuj7m9WlJhlmb/gieNxdggB8qYOXEpBlPg71OwvSXj/E+18KwQZO
 UpIVk+ZrWWI2y7rrX2Gh0h97xYlaNy0J2hqSEMPM7qxOtWK//d3wde0ph
 vXjJ+9D0IfDCct7Yvka2QtfKOXK0ogjvoKcEhSra6fi3qjOhst4ryFcZg
 zOpy3Ccxsxkn0N3M7ihrnbMctnLZGHwJ9ITu+9C92EjBbXYbKD0YjiHKQ A==;
IronPort-SDR: 2OIaRANq2l5509NAfHRb8DTGGy9dFDYak79fX90FovLLHmEeB9Qdr5/tdynEn5PXVa50kU+M78
 wJmE/TuSqRu02hGM/J+Kwyc0R5NW1X62vYR+a+rOubTDk8d6DJtWwymWboddKkY5ZSyZq1EL89
 WInonXBnRuiyXt/J8ffg7HGsvhROsZSipmtHBxh0qFqp8KufTPcJ/zw0L2hr3ncKlhb0tpegv9
 D03Gqyp2CVdV2zOFDPH4xzx/5CM6AAJ8FN3qNPjcqfX3NFuC+w25YvQPg5hqqe/EeyeEQvvKmQ
 d4o=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="219490592"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:28 +0800
IronPort-SDR: OYluSz2f79BPPRmrc3ArgWPxy3H/j6TgbnDzxxCkiwAoa7bw8CW4DyG4YEjsU7rDKBi+FyjVKv
 oiwMVfmStsaEyaYmDCrTS8AZi4I2B4f0BZauKEgZLED58sY3cmaFLaYsfQw26Gdj+NLixkOoQ6
 vWtim1IJgGL0SJ+X4uf4vbSgTlZnsBl2SgDPT8L2lCdtPC+Gru4it5XcmVhSjAftloQDpq8SlY
 i1rLH2XJi8mqSEhba5AjIYFCxD1NDlEzgBHYtBlPmfBt3OHNnYDgVSiLMPuY5DtQ0k5YtmiOzQ
 yqz0bh7tPtA+Bs2xrJhMgPJF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:43 -0700
IronPort-SDR: 0zxKz3+VDzILValg0v/hUllzghAIwx7bvI/KQXqy7uSpJo3fgDiNWntkMEl7tvc7MIsYKl00Yy
 /YGvHj1s8DQzeHTMleUvW+R/FEpxbeWpqa+CAglbCXCytzl/2NxXSCX3J88XnbVSHBPVtTm08m
 ETOj5QOPoa/m7+mJ/5kYqR0ZzO3SddtpC+Gfuec0orTYIaayYF0HBOwucMa9fj+ZPpGBmYAuxH
 I6siqcRhA6GkeFrdy1v/FKYfgOMmfYmJ/8TqKcIOXP5RJusWga5twIZnbrNwvgj5ybgdOa1piz
 n0o=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 Sep 2019 15:29:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 4/6] riscv/sifive_u: Add the start-in-flash property
Date: Thu, 19 Sep 2019 15:25:03 -0700
Message-Id: <d3357e0b87cce025418f6383ce971246ded547bd.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568931866.git.alistair.francis@wdc.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a property that when set to true QEMU will jump from the ROM code to
the start of flash memory instead of DRAM which is the default
behaviour.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c3949fb316..b7cd3631cd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
                                        /* dtb: */
     };
 
+    if (s->start_in_flash) {
+        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
+    }
+
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
@@ -544,8 +548,31 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
+static bool virt_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
 static void riscv_sifive_u_machine_instance_init(Object *obj)
 {
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
+                             virt_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
 
 }
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index a921079fbe..2656b43c58 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -57,6 +57,8 @@ typedef struct SiFiveUState {
 
     void *fdt;
     int fdt_size;
+
+    bool start_in_flash;
 } SiFiveUState;
 
 enum {
-- 
2.23.0



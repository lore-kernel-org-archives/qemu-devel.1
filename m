Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C492C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF10C20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4eA2l04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF10C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7kT-0004JT-02
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jL-0002XM-1b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jK-0000Iy-F8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jK-0000HH-2E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id x18so6529025wrq.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BESuML9GbRyguxqavl6NTEOE21Pzf9E6NWZj1nNhY7E=;
 b=i4eA2l04wSBKHwxuyED4RfyLAsRhcHtTtzPso8JzKvUBzK+ikIoF5pwJTbT59dOD6n
 xhO6fQ8w7/HbrUg4uJ6w5D9jX/UmVdvIUMBTxizoDxQYsDzmz3ZezZD9Hp7vm7acWlUK
 BqZsYuCtjbhHGR9pxnO+cdhuhslMWbjgCdHxt/Br5Lvg3vFrCrA82E40l44MwV2uvzEf
 xIsphQu/+Rcl9sVAGjqWJ/Y0zo7/zGR08o9ADiYGz3zNVABQiypIoLVdh7GoOt11tZiC
 xq20ql1EJ8FUu22mJA2XC5Sqrtq/IVtrg9FhjdhTXDVPuzhgFqAfOAID4X7fv5cJxEWW
 KWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BESuML9GbRyguxqavl6NTEOE21Pzf9E6NWZj1nNhY7E=;
 b=j7cY7DicDgdQQipKLRreH0/kn6IBtn7m5i2N1q4HHWzWt+hPTjZ7NhOxFe4cu4fV1d
 J5j4wuVq0yA2ZDkcwouqEecUGklQqcZo+y/j4Vj0rvpf4cRbyMWhRylqopIHPdEA0SAO
 Nq3QSACE5IPyMXvPe7/y0y8hEmhGHnBM5uCI136tx1vR6MQgN6T6ZCQoEPG80sCH5tO8
 WdVHgsHvjsX2hAJridLsVMLOnu/YskkWKEf6ifyMos/J14Hu9K6c1Z0bV8LxAACcAP2S
 433fqX9GDeHFsQgJvdsvpF86Ok4ogq6u4+S8LSyLffPR4EZG1174uMk277W6NayX70S1
 +RHQ==
X-Gm-Message-State: AGi0PubWmaFGdzzJA//Gr+ZKDBMArawKkuvFxH4G3efOGFHG/mJ4VOUY
 IcX249opPyU3QdzcuOf+GPR8ESWzfWEvPg==
X-Google-Smtp-Source: APiQypJGCLmYn+OyY8yRHkWZ8BNn+2ubOToE7Lgeja9m+zH+Nr0CqL8tpSQbgi9oD2RSn0Q8vaGr3w==
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr249340wrg.63.1588247506806;
 Thu, 30 Apr 2020 04:51:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/31] dma/xlnx-zdma: Fix descriptor loading (REG) wrt
 endianness
Date: Thu, 30 Apr 2020 12:51:13 +0100
Message-Id: <20200430115142.13430-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix descriptor loading from registers wrt host endianness.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20200404122718.25111-3-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 5f4775f6634..4121a1b489c 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -299,6 +299,14 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigned int basereg, uint64_t addr)
     s->regs[basereg + 1] = addr >> 32;
 }
 
+static void zdma_load_descriptor_reg(XlnxZDMA *s, unsigned int reg,
+                                     XlnxZDMADescr *descr)
+{
+    descr->addr = zdma_get_regaddr64(s, reg);
+    descr->size = s->regs[reg + 2];
+    descr->attr = s->regs[reg + 3];
+}
+
 static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
                                  XlnxZDMADescr *descr)
 {
@@ -324,8 +332,7 @@ static void zdma_load_src_descriptor(XlnxZDMA *s)
     unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
 
     if (ptype == PT_REG) {
-        memcpy(&s->dsc_src, &s->regs[R_ZDMA_CH_SRC_DSCR_WORD0],
-               sizeof(s->dsc_src));
+        zdma_load_descriptor_reg(s, R_ZDMA_CH_SRC_DSCR_WORD0, &s->dsc_src);
         return;
     }
 
@@ -360,8 +367,7 @@ static void zdma_load_dst_descriptor(XlnxZDMA *s)
     bool dst_type;
 
     if (ptype == PT_REG) {
-        memcpy(&s->dsc_dst, &s->regs[R_ZDMA_CH_DST_DSCR_WORD0],
-               sizeof(s->dsc_dst));
+        zdma_load_descriptor_reg(s, R_ZDMA_CH_DST_DSCR_WORD0, &s->dsc_dst);
         return;
     }
 
-- 
2.20.1



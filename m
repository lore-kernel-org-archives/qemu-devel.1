Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6CFECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351792082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXoRk4ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351792082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6CG-0007xv-T7
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5ic-00051M-HC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5ib-0000Ox-5x
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5ia-0000NA-Vz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id y135so7032247wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DQC4XpSmd8PGYvkUObRMkiwdpTVp4qnrLAv8MVPjMfc=;
 b=BXoRk4ipvCCHTzB5RH6mflZFBLDZYC2GIPWZuUYfvFaTPwMcEDViqdxSZo+QUkPufI
 niPgKR7Skh6NKKRwAtfthFcSPc38C0OgDt06iA89Z1tXnDJyBOgXt+wW40OIQI3Dmlj3
 RkcRAWLWjpy6ltoaZrrE8UPBa6VAOdrY+CspInsGbIPB5RC3iXBmRcaNWOhiXDKsNdrU
 93GaLbwRDIQIfnctVCd7SouAj71maxDOBx5purizGDt4zWlOiZpYJyQnW/ExQx9v5uWh
 kFWSMiRc1wtBny+TFLKicoCBYmdO5sfN6YplLZmDpSxFgM6/5tdNEUVYA9O7PmQvFpqB
 6NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DQC4XpSmd8PGYvkUObRMkiwdpTVp4qnrLAv8MVPjMfc=;
 b=RvrOjGWk1C7dL9pzyd8OxFCi4pLbUagFnMcqq2hljDBTATcFNDuzF2M1w7YRCsgWJ5
 cb4PkXhNcLfzqahGjNXqAI4+JrkhoQFHdtjBJMYgnnQb13BQmyI+yqf9opUo/tkpH5Pd
 KfUPOeP6dHTsHtO1KHf4ngwdnG2VLt4TppsQHG9UZ5PU6Su3NG56NryHG4Hiebsimsu4
 pI/7+UdXtrLfM4zJqIo20A7Rtjo4UBx24hOzMT9/bBDtB4oYsWuW7tLHr/aC8MJ7b6AO
 MKraLjKwigLPprpVk80Sfhf4I+9xdwT76w0Hjx8BkXUdJrbo50g8zxdy2POaB/fpe/TJ
 4IvQ==
X-Gm-Message-State: APjAAAXOSueYP2dyia+5jSzJGjkW/FdkTzE9PyCXM8CIqYJd6gZWALKj
 5QqUHi5Jz6/kH2JKDBf1yVaX40nnd8pAKA==
X-Google-Smtp-Source: APXvYqxW/k0kSnsy2TV3ex98SGBPoAJS1zfNU5j5xKsAp0Lr/7nMlCQmKXphXax43zgqOzs7kJQR+Q==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr2915340wmi.49.1571318487648;
 Thu, 17 Oct 2019 06:21:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e9sm11543164wme.3.2019.10.17.06.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:21:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/timer/xilinx_timer.c: Switch to transaction-based
 ptimer API
Date: Thu, 17 Oct 2019 14:21:21 +0100
Message-Id: <20191017132122.4402-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132122.4402-1-peter.maydell@linaro.org>
References: <20191017132122.4402-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the xilinx_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/xilinx_timer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 92dbff304d9..7191ea54f58 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -28,7 +28,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #define D(x)
@@ -52,7 +51,6 @@
 
 struct xlx_timer
 {
-    QEMUBH *bh;
     ptimer_state *ptimer;
     void *parent;
     int nr; /* for debug.  */
@@ -134,6 +132,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
     return r;
 }
 
+/* Must be called inside ptimer transaction block */
 static void timer_enable(struct xlx_timer *xt)
 {
     uint64_t count;
@@ -174,8 +173,11 @@ timer_write(void *opaque, hwaddr addr,
                 value &= ~TCSR_TINT;
 
             xt->regs[addr] = value & 0x7ff;
-            if (value & TCSR_ENT)
+            if (value & TCSR_ENT) {
+                ptimer_transaction_begin(xt->ptimer);
                 timer_enable(xt);
+                ptimer_transaction_commit(xt->ptimer);
+            }
             break;
  
         default:
@@ -220,9 +222,10 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
 
         xt->parent = t;
         xt->nr = i;
-        xt->bh = qemu_bh_new(timer_hit, xt);
-        xt->ptimer = ptimer_init_with_bh(xt->bh, PTIMER_POLICY_DEFAULT);
+        xt->ptimer = ptimer_init(timer_hit, xt, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(xt->ptimer);
         ptimer_set_freq(xt->ptimer, t->freq_hz);
+        ptimer_transaction_commit(xt->ptimer);
     }
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t, "xlnx.xps-timer",
-- 
2.20.1



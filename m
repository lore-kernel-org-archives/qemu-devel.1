Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D8AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA41622283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="PCdz6zyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA41622283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFOS-0003Es-Vf
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMz-0000wR-7T; Sat, 10 Oct 2020 09:57:09 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMv-0004IJ-Pj; Sat, 10 Oct 2020 09:57:08 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 713A4C60159;
 Sat, 10 Oct 2020 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338222;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47VbYAct+c9hftOWPp/AO6VMc8Ptj3zoGkrDEH1t/nk=;
 b=PCdz6zypiqyl3oQEdzb13Qd3tW/SiAMtiwLD/9vEvzURXA9/bcqZB6uxL//zqIlEMWrKuK
 ap9AI2gA1wmsEAMMHVivwEjcEyVb80E4tPNhxAz4Y0/WhHYdn0Z5RjiAZNvTjakAe3eAJx
 TE7gDSeR4XxdW/e4D1EPWdchR8WuB/afYzrz6u9k0wm5CetgGc5d3KmYtG+nUVHLhGVe4v
 NSHhOSUDY9+V7DedkRV6NFI/G+q7KAnoS0ztouQmpfouDF6Mp2kgXDb6B+kOIjBj4Ep+hd
 7e+D9Z4e74eHjaMnqVdHFEvxvXv1clGLlB3oK9LbRSnJzzciDBhmD/nLHbiImw==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/15] hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
Date: Sat, 10 Oct 2020 15:57:45 +0200
Message-Id: <20201010135759.437903-2-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47VbYAct+c9hftOWPp/AO6VMc8Ptj3zoGkrDEH1t/nk=;
 b=IXxYOfNIwtoXcwdehyh1YFHmnbhRtZx9WdjoKBHHX6mwB3/UkSTWcw2yT/mvjUcvfCMQXV
 OH3SjqNyXzRz7f32b4jYMyzjLdOt8gNgcQFaj3lMsdY9T6mLgbyBVCONmbfwmwxOj0aqtl
 dzBwkm6y31ZOyuX4kYAMm5cpENtgPoC/afvduG5eJ8dIJd61z7+gP0HTt8fxXciUbr5CyE
 dlwo/JRDaYV7k4xxSNT4u31YlBtZOuhX4DWzbeeAtsIY70gx8Z2t+pU6XGq6PoFpzA0Im1
 Uf3u79DMIRSZiF3PRxfZl0Lxfd7ykHNs06Q+Je8jewq/G/zkmGZj5m0gXKhrxA==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338223; a=rsa-sha256; cv=none;
 b=Plwbxddqj3Yd0vMelljlNlLGt1EK24nCYE+U7KZYC4BONqLXvqEfEpaATlwerZbVLdb6zAewSXnbi8eUyIX0K8lWkS9U/+Xpq2eiAwlAnDIX7H65Ki6qjK02RBbH7ryThyuCjZOrKLPyeDWPbJhwNbEQ1aAiH7qBOvfx1zdMoFijfJMkOHiZUJB0hmecUVCgpBj+Gqr7VXFdb5U8HeltAS3DMUqbee/Q37HodKnCFcX1DXKW6aHwM4NNeyRrSpCVonl1rmk27MZYNGMNFyxWA/0GSABqjk2/3TPn4vW5hhV/s6OURHhOJ77uPCUYSXow9mvraWRrSE/bXH2Pu1B2Xg==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/clock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index d357594df9..c93e6113cd 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -79,10 +79,15 @@ struct Clock {
 extern const VMStateDescription vmstate_clock;
 #define VMSTATE_CLOCK(field, state) \
     VMSTATE_CLOCK_V(field, state, 0)
 #define VMSTATE_CLOCK_V(field, state, version) \
     VMSTATE_STRUCT_POINTER_V(field, state, version, vmstate_clock, Clock)
+#define VMSTATE_ARRAY_CLOCK(field, state, num) \
+    VMSTATE_ARRAY_CLOCK_V(field, state, num, 0)
+#define VMSTATE_ARRAY_CLOCK_V(field, state, num, version)          \
+    VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(field, state, num, version, \
+                                       vmstate_clock, Clock)
 
 /**
  * clock_setup_canonical_path:
  * @clk: clock
  *
-- 
2.28.0



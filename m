Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB8AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F088921741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="jG7Mlc5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F088921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkow-0002nu-0c
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknD-000131-SW; Fri, 25 Sep 2020 06:17:31 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLkn8-0007QI-Bb; Fri, 25 Sep 2020 06:17:31 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 00207C60F18;
 Fri, 25 Sep 2020 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHG3gOOfzWKUSsScEIEjr33P+R1FlB8vtIzUKO1MkuU=;
 b=jG7Mlc5BbIrGtqCQe2bSsyUPLWmzT8fZ2eFENXB3MSzQuOSNzfP8r9jXebL2e2R+nC4znA
 IIDU3IH90XvoIFJtY2EU5CU3B9V+pi9JWqkeiPoti3U0A2rJCsIsPlVUGPhw6FBNay8y9m
 D6jZRUVAfWK4JxUi3cV1FiX6hwAEQ2JYVQvL106ybXOo5yAbmOijjNZnA5xRfcv8+wugGX
 aQ29yn/ojH8QY2ZaPrWR8Lld1s2PwSlvpzlxK11zc3+ERbl/D7vrjSDEuZe9+WSzmxvNuZ
 n2ilotIRXKhc/TK3Ebch/qblCPZo1YTszDNg0/lV+KKHYGsVwWnsOOTFq74vaQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/14] hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
Date: Fri, 25 Sep 2020 12:17:18 +0200
Message-Id: <20200925101731.2159827-2-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHG3gOOfzWKUSsScEIEjr33P+R1FlB8vtIzUKO1MkuU=;
 b=ZDEbLfzepCVtKAYPvw/E5Wd/Dfqo+sfmNjXfjWnRjQUbtrUBn4a5ISHCf+3kE3GT19/sNF
 R6Tufv32GN5BXpwEO1fIdchuYsyzTBwH2eglrEkCcwevgB5UoNB7C6kpb8aADgSay1kmpP
 i9P44oayX1yEDUCLAKO6PKhYT3B7uFJbcxEGXuz5kkzJPPxp9zKHsWHpSjmwnK0UU869jF
 HGmC39sETRAGEPPlcec7D47K5DIslnGa9ZzidmFT9ISQplZ54UwN5CHHIBJkr+9rAzBSB+
 MVK7uPeGTlXd5+Vl2ZZvttHcYFYOGiLMGuC+T5PMGxLKJTk+I/fDzJGfIo7eow==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=FJmGm+h++qPtwsov66hcRhRWgMNyEIYmlcTupRvfNvvSUxKu3vjMIxhPuuCJQgJbrfrgujKXP7JCHaah2xg2FyPUz0plkq5Ba6CYppzvsBP0o0d+OMfebOGDr9Rfck2rAreG/Jmj/aDUG+SOaQOytQsWpLk9DNTebt5OWHRak7kXjWZ6ocpnqQa1HFICvPlssPcTa2+x4lBHEusHJJTHkm2HWtogEYfYdRvwCnTAEvsbQiksZxPyBknzQI9dU+V8zmGeofQOWhBaHNWu9LP97YVACcE0rn0OqQoQmj98xUBvfk8nWGRp/UVKmBJEDTWNilf2y39Pcky2gpA24AYg4g==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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



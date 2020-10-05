Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0DAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48664212CC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Y4EbZOTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48664212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPWvv-0001VF-9b
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZs-00041N-IX; Mon, 05 Oct 2020 15:55:21 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWZo-0007S4-RO; Mon, 05 Oct 2020 15:55:20 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 5B833C60F18;
 Mon,  5 Oct 2020 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927714;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47VbYAct+c9hftOWPp/AO6VMc8Ptj3zoGkrDEH1t/nk=;
 b=Y4EbZOTqe3klYtUsmPW4UjDX4DhcAneW7OQog5cYbvY4Eh5D88NQ3e6rq/IRLM5x4OrXN8
 m5+B67Bxg3yVBmnlMOWFAaH3zsCTtkl2ZO+37vly8TAssBB0HgcpR+QXzrSlru0Rut/bvI
 OeaSL0kl86xhSj2r+7dIg1PWu4mpl2/w71tV+BCbpTXhZgeZAKrz+zIZpyJsRPzJL2PZkX
 XDE47M8c/GZ2pcBRPt12Y3LuD9WGInGc+65ZeuefAYNYQyVp4pLSkfEp/lPpYf3EEfZvRY
 4RPFMChNSkACjpx+EIbIn9nVMHSYWWaGTzQLpTl2FPtD4oybtza1V+0G0yNN1g==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/15] hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
Date: Mon,  5 Oct 2020 21:55:58 +0200
Message-Id: <20201005195612.1999165-2-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005195612.1999165-1-luc@lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927714;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47VbYAct+c9hftOWPp/AO6VMc8Ptj3zoGkrDEH1t/nk=;
 b=GcPf1PEIDn1EAyackIRZ5Rw54RR+6yaESOEq1F+mfetMLohChGEpY7MNlmyxbIJHHjDGbo
 jKboewXA1w2aupFx4e0FEYmOhy0HoeiCnCwNJGPaX27FY4yPPWrcFsByANC9mG9R3D7KMc
 MKEHm3qTXj6KlEfR6QkDeVLCxAC20gM09hKON+sa2NQPcaCpFEfVOm5Kp0GaCf5HXSZ2Qo
 yus+mZE2gVppNSj7NzNptDnD2LA/LRqeguieTZBzKxC2goDJTxXG25ZJcuwaVp3dAlRBZb
 aZj51QdnE3FH0ZXuOhh5ixnYRu8ZogU8zZNlelGK0sMm8rPwDDrizRfzUStbKw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927714; a=rsa-sha256; cv=none;
 b=REZqpR1egl7XoCo0IHsLa2XkprqUOLDqdwYQFzwIG75mUxIkzvkl7FzeyjGCqdVDYqx2zZ5YUZ7Lja4BaV9LSxaoMNvKJPgG3GJcrkRz9A77cwfuZVBBleATcPbTdaCLgGt1n+KV21W43JqxE1w7pDHlYxBCEyE5DCOcuBlmi06dNsBhIbeHJE090VIEwOb7spxJRuIlCjY07Ny6Goe0kIxADSdTVHyPy6FVyDvUd3YYVPDRvbKtFg0yGfQY3Fp5k85irMeZK7BcpEF0Gdx/qGwty1Iu2qN9ZCGRQii/uS8CnjO+8ixRP6UML5xGM10r73yAY33lTC+Qp+9Qc6zpeQ==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
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



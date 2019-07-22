Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72216C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0E4216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2qGZhKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0E4216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWLt-0004Qt-Cr
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46615)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpWLh-0003wz-UZ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpWLg-0005Ua-Q5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:19:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpWLg-0005TY-GR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:19:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id y4so39021299wrm.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ldvnOqlot+qdpEWUg3Q+YzBAvRrhAotsXklrj4ILSb4=;
 b=y2qGZhKBPAugpPF2oKkNPRH6ut8JLduHFB7e9PiJSklFjug8Iro8CZPKwjx6b/c/Ww
 TSLPZYeaiBukt8FOzQcUvYqxfIkwSzuYwgFaA6PBFI+4VoZjw5CcZ2cvm5iGnNJ+iASE
 BuMGkPAsXKKMUUb2w/u/0JR1YCdGYaFQj85KeRIFz0iHpWHdx20/ivIdDuPEpFzk8UzN
 /5GY2aps9QGLuuxmPF94akAZwV1CFlzFH3DpPECNmnWPXOYmf/mVdb2eatgvAjtayQ7W
 acoBD2HcbBJIgRZbz+BF5HS4c8yKi/izCRgIYTtxze6f+WT2nZi5g32lMl+XEMsWmpIg
 kuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ldvnOqlot+qdpEWUg3Q+YzBAvRrhAotsXklrj4ILSb4=;
 b=MbTib31Ie1a7ESKDRh3BB5qblrKJeAin8N8x2IiZF1DqjnxxHm8NrM1LtirnXtG6nL
 uv0t75vxLgny95ETS8oucySgs5w3yhChU85xIIYZMTJifrAKDIFv1dR7+MtIeZ1L05E/
 3IKyC7w2IDZf4i1WUEeky3Yky7qfz6u10YcjSo6glKifBhjptGDhTwaKOjivwH/Pd/qz
 uTLtO9XbEA7Uw5EHNQ0ajxGJsQtR7pPa3uhPwMCopUuECMRXK/Du9knh42QmhzeadYiW
 dVKPeY1087yFcvKzGrPXZUlFWvi1E/R/L8yVUpXzaIVoUtKnsjkCaKc0mn1EzRkE6vFq
 7Eig==
X-Gm-Message-State: APjAAAVe3Bi7raIGPF3FXQ2E6JiNPmXJBdO1AGDaEKb/aS+AUnO058yl
 MR+8QNQHmwQHPlePLGb4uSIa3w==
X-Google-Smtp-Source: APXvYqxoLap1P3JnKB9gKIrxfWU8lD7jwyhh4FiMekXV2U1OIDKpZ8KuSBQ1ge89sjkKqfRmXeFlWw==
X-Received: by 2002:adf:8364:: with SMTP id 91mr74101423wrd.13.1563794359135; 
 Mon, 22 Jul 2019 04:19:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y18sm38214088wmi.23.2019.07.22.04.19.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 04:19:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 323001FF87;
 Mon, 22 Jul 2019 12:19:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 12:19:14 +0100
Message-Id: <20190722111914.28574-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [RFC PATCH for 4.2] target/arm: generate a custom MIDR
 for -cpu max
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While most features are now detected by probing the ID_* registers
kernels can (and do) use MIDR_EL1 for working out of they have to
apply errata. This can trip up warnings in the kernel as it tries to
work out if it should apply workarounds to features that don't
actually exist in the reported CPU type.

Avoid this problem by synthesising our own MIDR value using the
reserved value of 0 for the implementer and encoding the moving feast
that is the QEMU version string into the other fields.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h   |  6 ++++++
 target/arm/cpu64.c | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7efbb488d9d..61eaef924e4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1605,6 +1605,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
 /*
  * System register ID fields.
  */
+FIELD(MIDR_EL1, REVISION, 0, 4)
+FIELD(MIDR_EL1, PARTNUM, 4, 12)
+FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
+FIELD(MIDR_EL1, VARIENT, 20, 4)
+FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
+
 FIELD(ID_ISAR0, SWAP, 0, 4)
 FIELD(ID_ISAR0, BITCOUNT, 4, 4)
 FIELD(ID_ISAR0, BITFIELD, 8, 4)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b1bb394c6dd..c121d0b37e0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -296,6 +296,16 @@ static void aarch64_max_initfn(Object *obj)
         uint32_t u;
         aarch64_a57_initfn(obj);
 
+        /* reset MIDR so our franken-max-cpu type isn't mistaken for a real one */
+        t = 0;
+        t = FIELD_DP64(t, MIDR_EL1, IMPLEMENTER, 0); /* Reserved for SW */
+        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* See ID_* for details */
+        /* Encode QEMU version details */
+        t = FIELD_DP64(t, MIDR_EL1, VARIENT, QEMU_VERSION_MAJOR);
+        t = FIELD_DP64(t, MIDR_EL1, REVISION, QEMU_VERSION_MINOR);
+        t = FIELD_DP64(t, MIDR_EL1, PARTNUM, QEMU_VERSION_MICRO);
+        cpu->midr = t;
+
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
-- 
2.20.1



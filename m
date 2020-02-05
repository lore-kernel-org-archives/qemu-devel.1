Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BEDC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A541021741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jasg9k4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A541021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOHp-0005nH-QM
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCN-00051e-GS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCM-0005VF-9z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCM-0005Op-1f
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so3688430wru.4
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0OcAvc3GvfdCHlZAucKBYIBgCK/jRDOs/AGpSmh+Usw=;
 b=Jasg9k4PLLluLIv6nW9cQIOdxk+LdeIlAm2pv2dsE7iGL5hXiMGr4X8J8rbQ3BndqF
 brGeITksOO7Bpb4ns3JBUpEv3TltnhUoMGf70KhBBv/nGacv4PhqSaZxQbASnAlJR2ic
 Q0erVxP9kutrPH/XsgOobV2FyMWLrS9r3pi+HLGAkejIOhprTc0qyi92OpN2qHnUd1oq
 bkgZ0bZawxj9pIWhj5Trm1wfXLecbZMGhb/N6/wT963C6F1ee7hYRgU+gjMFImTudtw7
 l2vOoTA7wVHvU/l+JRHBlueVuruR/TC0+MjTci40yIpFqoUmvDKWpvjGZ1N/pGzLsb9i
 JSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0OcAvc3GvfdCHlZAucKBYIBgCK/jRDOs/AGpSmh+Usw=;
 b=irRPmfpSp/IBRT4i/TnVoy7yV9F68AAvZ5OWUtHsWk7vQ1ye5wfzDVduiiB+EBHVZr
 ZzuXdUsk/m52fso3wKZBQGutuhLhuWqvKVB1SWlPIQhPI3ilDvb8er+GPv2E76fFnmoA
 8mtF8t7RWW8xD2mfqegBoRYX4jeD4zhHPFL90SOWzF+KlXP1GZBHQUKPOAPbUrbvfoXQ
 LsavCCdT4PUYGaoCNgM2teFs4I98a+PPtktURpPnu8mNWNRcgg8IXnGOFnQmXGdAhZ4P
 VVhA4CY4+Is62ruscgKCXpEAH/lBJvKiEPV7z5rDezCRs/VPogyVcgC6umh8/wH6+6Ks
 jjIA==
X-Gm-Message-State: APjAAAUqF1pIyrKfuavB1XjqB1627rpIysZf9RCkLCj52WaejcDw8vDF
 8XdAWiZdmASzyh4gr5wpI76t2Q==
X-Google-Smtp-Source: APXvYqz6P0CgL2+yeAGkSzfIj2MLgjYkfepNzRUeLl+t7NvmhcvFyn2kDe1FH5qw6x0BsStJjKAKig==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr25431997wrg.266.1580922645079; 
 Wed, 05 Feb 2020 09:10:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm541865wrx.25.2020.02.05.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:38 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D1C61FF93;
 Wed,  5 Feb 2020 17:10:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 06/22] target/arm: use gdb_get_reg helpers
Date: Wed,  5 Feb 2020 17:10:15 +0000
Message-Id: <20200205171031.22582-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - make sure we pass hi/lo correctly as quads are stored in LE order
---
 target/arm/helper.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a57a17da5..b417b33cd3b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -105,21 +105,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     switch (reg) {
     case 0 ... 31:
-        /* 128 bit FP register */
-        {
-            uint64_t *q = aa64_vfp_qreg(env, reg);
-            stq_le_p(buf, q[0]);
-            stq_le_p(buf + 8, q[1]);
-            return 16;
-        }
+    {
+        /* 128 bit FP register - quads are in LE order */
+        uint64_t *q = aa64_vfp_qreg(env, reg);
+        return gdb_get_reg128(buf, q[1], q[0]);
+    }
     case 32:
         /* FPSR */
-        stl_p(buf, vfp_get_fpsr(env));
-        return 4;
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
     case 33:
         /* FPCR */
-        stl_p(buf, vfp_get_fpcr(env));
-        return 4;
+        return gdb_get_reg32(buf,vfp_get_fpcr(env));
     default:
         return 0;
     }
-- 
2.20.1



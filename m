Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D314C3B186
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352B220661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF4l/ywO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352B220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZaP-0008Sd-Bn
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTv-00069G-08
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTu-0004Zy-30
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTt-0004CX-Td
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:54 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so13475074wrh.5
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=io9bXmaa0QYPJVSqKww1B9uAPmBiSE1Ya1UcsX2Idyc=;
 b=KF4l/ywOty3YpZ9QhWVHm4Sgoe8AApE7/HUdf8rwM94OMyAIsDmZPQCljsjMX1RGJB
 q7M4nl/eyUh6A7za0tysFLuGiY5ukdRJ4UT88c/o53DSU2Nzv3T1Bn3EanNQiAoTME0x
 wumgYLi0fe5anD5kCHKZDX1lC8kXS/QHrs9dM6idCrqO2RO2cOvNaeYXNkF8hnEWdS3q
 K9n0GVu8QUEaEA8ulcfBI3iZEG8z1nYzG3VsWaow0cIT2f875WiaSF/oyBbUXy5eHxiL
 +jHr8jXqHF7EZsjO4CbElFuRzrhYnZ95aarphF0FElA6/YcIFbA6g02tKmVIocD02xIH
 PqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=io9bXmaa0QYPJVSqKww1B9uAPmBiSE1Ya1UcsX2Idyc=;
 b=ZNSqKlFshq49vnvfWAvqHVGA3Iq3Ucr/lmVfibNYn5p+GPzPSojsD1ueVGS4df+Iom
 VjbCY42heu78jpumN+Ecl+00VO43OgxquI7/tuscSGsOV1ruAUhs5dNNjAkdDv7sygKv
 6zdoyATwXHIpuzU9McBvOMyI0h/Cl2nhP/Rm+n3J5HnIkV01Poz3UlaadIM/wp811G9C
 MmQTY1UuL6l4oyLrzVoF6WaAeTeSgujb01dKi4eI1PruxRiSH04hUbA1+SYpDCDrh0o1
 IRzGnm1qFkDsya7Z5DyxO+pcTVYzX45n1S6y0ZRRhKzIRBvc2AgMna5RSOAsZUGQOBCP
 Griw==
X-Gm-Message-State: APjAAAVBjD48+knVIYwmN0cG4z5uBMViCARU1X5f7muudsggW6cOdpNr
 Bs3B78GcfAWP1vkxyKkg0vNjJH2EMIo=
X-Google-Smtp-Source: APXvYqzi/FIoeg7bByd1vdSHp3LUvj3U+Nm4a/Y7hgREMGCqOF6GrK4aHmhyUrcPexURhUzuhF9l0Q==
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr9548904wrr.151.1581442662986; 
 Tue, 11 Feb 2020 09:37:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/13] target/arm: Provide ARMv8.4-PMU in '-cpu max'
Date: Tue, 11 Feb 2020 17:37:24 +0000
Message-Id: <20200211173726.22541-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set the ID register bits to provide ARMv8.4-PMU (and implicitly
also ARMv8.1-PMU) in the 'max' CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4b4b134ef84..5b8b7a9d4b8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -693,6 +693,14 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
+        u = cpu->isar.id_aa64dfr0;
+        u = FIELD_DP32(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
+        cpu->isar.id_aa64dfr0 = u;
+
+        u = cpu->isar.id_dfr0;
+        u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
+        cpu->isar.id_dfr0 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1



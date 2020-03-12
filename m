Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA294C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81B7206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6Ep9VqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81B7206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTtu-0006CW-Tp
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjg-0006pi-JZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTje-0002Pc-Ie
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:15 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTje-0002P3-DE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id l41so3078537pjb.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qowSUw8JkODxrAT/95Utumdgqt7+zNqoGPlNwIcI9dY=;
 b=G6Ep9VqNxI7wLJ9RSdQwi+xiq17SmKOusrDTFlytaN6qVssRu0WtSj8u+1AugJ0jTH
 Wpar/LFslKixRmmDioyUgfWHpUnF/93kHRBhvi+0krkRsC8lVzQqjAeKWQhH2VjgOCFR
 Gvp40iYDkpVeiQ1dwpT9sKT2/HYTyXedrKMVSCA6UZt60/zc8hM8CoMs/itKgD2il0Gr
 KYQg4PJihNYVRpp0b+x+57RIbirDXLQ5Xwv6ataNLOlKxeWfokaUX4TzweDXvnKSz9Fa
 Ps4h3CWIRYMMvPMOHjCZJjeR5OwYfvPqJT1tvZxRJ/NM9mByzAw6Kmo5mwX8XOi09dOb
 Ph3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qowSUw8JkODxrAT/95Utumdgqt7+zNqoGPlNwIcI9dY=;
 b=OTfX/+mQi/JPj4zS0IWYJWhUzjtOGpbLsldroSgaBkE9Py7vx5Efgn1qj6esfT1T/T
 vW8wEaOZ15xz1iQMe18qy237YBUJQnrgTFn2hTw/+X6uEHHfu8sDMGRlGQUjhq25H/fN
 fyjbSiCXXxwugZez/39o/Ri1reX3zXGZHJV5R3uz13tOTwVHh1UyX7uEKzMq4AKdfR/c
 jk4fVu3BIjiiErQySDIroBz61SsRz4Bd/FNNAj0mYOQziVCyCNpKb6xdQ8fO6pyJiRYd
 yshOsrvxpjgGy6jpEYHUSy+4YqbO4bMRl3jNqI5zVQpsKP7cIPoAJfZDPZAkpJzwkClT
 PnpA==
X-Gm-Message-State: ANhLgQ1W93yN8ryKki6Sb9+t+2nSoVi9FsI4Pd/oxBWfe8/spbu8kk26
 3qUMtKGrKEW+64bgXcPU57lvAFoCDec=
X-Google-Smtp-Source: ADFU+vtpaIe6RJNVNUlJL0DNJKduwLIvCnfEClJ0oQlAGCuJ8XiZdQaCwGSkM4m/x4m6OU/VoQxxnA==
X-Received: by 2002:a17:902:7003:: with SMTP id
 y3mr9875557plk.122.1584042193138; 
 Thu, 12 Mar 2020 12:43:13 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 39/42] target/arm: Enable MTE
Date: Thu, 12 Mar 2020 12:42:16 -0700
Message-Id: <20200312194219.24406-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now implement all of the components of MTE, without actually
supporting any tagged memory.  All MTE instructions will work,
trivially, so we can enable support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Delay user-only cpu reset bits to the user-only patch set.
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62d36f9e8d..94e83b8487 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -665,6 +665,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.20.1



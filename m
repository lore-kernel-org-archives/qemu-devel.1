Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9540D2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ha9b2I93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9540D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshuX-0002fx-S4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjH-000528-S6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjF-00046i-Vk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so1070448wmm.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y0AvFK9jDhQslOqQ/+Gd4Ly1wJW6CnLI4eXMz6hvfIk=;
 b=Ha9b2I93IMyiA/qZRUClTEq9hMNYNlV7RFMmE/GrnzS0CDKv0d7t5f96jZ2qknQ4sX
 +fImQQ1b7HpWPKnEqiCkJAxOwK4TaS86K9H2SqMB+MVJz7DH+LfTLT0kpqTcXuAqDHwx
 ztHy3KZDmHqcUxDQMdCdLQ0aN/O3ZRsdCkgL+F+eiMq5HcDuZJ2YE0LILxPR0trGiezP
 F2X84S6Nl5ZS/TDxqLtD1v6En8QyywJm6n6T6b4y7q26nweebo/XcbxSyPYWLlw1CcXn
 IUiYFbnp8VPscIzvIxHPHOJUzOHuywIDNXuBvwJlRjml8yEiPF44DuyXh1C2zaTmLK6+
 Pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y0AvFK9jDhQslOqQ/+Gd4Ly1wJW6CnLI4eXMz6hvfIk=;
 b=K9NHfWoJ8ePWTroaGHJ++gUEsyYziWRdKQl58plZVA5DHyT0kifRpA5yY4INy1VnCC
 pBux3i8SQu0bH7Tgjfi5jD/abx9+Ch/wuA7RaZZUNSWZ7xY+s5Y7UBBdLWUVXkoNQJVF
 NSC+Eka1H6H2yak5jsN7witTKZZdVtr6juo/4Sduq8uUI6h9484ENXl7Q6KZYPP4e73D
 OX4ASZhPyNCrwPHpUOpJ6pFqR29R9O4zMolGWvLGYZ5Ef1dYzuDhhe+edMnrzb90w0No
 KMZGJQnd6t/75j7O1OGahwnFpjdBAJcb4g44upTncLy/0Y0TefV/LPIu454lzhbeJGmy
 rOvg==
X-Gm-Message-State: AOAM5323jhkqiFIkjlj9FLNvhP4XTG6TYpdUM5wU4R/iL6AlXoKalHdv
 LLtiDykJ/tLC1qT0nQ23dL+/uz4BeNI=
X-Google-Smtp-Source: ABdhPJwKFsCTuTNtjG1EsPH+Lg2g69X0JvXXEsXrjl8CVk60wzkuG72cJvlWPgtAHEUAtxEoLZSCUg==
X-Received: by 2002:a1c:303:: with SMTP id 3mr2730816wmd.180.1594105760534;
 Tue, 07 Jul 2020 00:09:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n17sm26170287wrs.2.2020.07.07.00.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F0461FFB5;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 29/41] tests/tcg: add more default compilers to configure.sh
Date: Tue,  7 Jul 2020 08:08:46 +0100
Message-Id: <20200707070858.6622-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were missing a bunch of compilers which we could use if they were
locally installed. The defaults are based on Debian as they seem to be
the best distro for well distributed cross-build compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200701135652.1366-32-alex.bennee@linaro.org>

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 2326f978562f..37e49736ca40 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -46,20 +46,29 @@ fi
 : ${cross_cc_aarch64="aarch64-linux-gnu-gcc"}
 : ${cross_cc_aarch64_be="$cross_cc_aarch64"}
 : ${cross_cc_cflags_aarch64_be="-mbig-endian"}
+: $(cross_cc_alpha="alpha-linux-gnu-gcc")
 : ${cross_cc_arm="arm-linux-gnueabihf-gcc"}
 : ${cross_cc_cflags_armeb="-mbig-endian"}
+: ${cross_cc_hppa="hppa-linux-gnu-gcc"}
 : ${cross_cc_i386="i386-pc-linux-gnu-gcc"}
 : ${cross_cc_cflags_i386="-m32"}
-: ${cross_cc_x86_64="x86_64-pc-linux-gnu-gcc"}
-: ${cross_cc_cflags_x86_64="-m64"}
+: ${cross_cc_m68k="m68k-linux-gnu-gcc"}
+: $(cross_cc_mips64el="mips64el-linux-gnuabi64-gcc")
+: $(cross_cc_mips64="mips64-linux-gnuabi64-gcc")
+: $(cross_cc_mipsel="mipsel-linux-gnu-gcc")
+: $(cross_cc_mips="mips-linux-gnu-gcc")
 : ${cross_cc_ppc="powerpc-linux-gnu-gcc"}
 : ${cross_cc_cflags_ppc="-m32"}
-: ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
-: ${cross_cc_cflags_ppc64="-m64"}
+: ${cross_cc_ppc64="powerpc64-linux-gnu-gcc"}
 : ${cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"}
-: ${cross_cc_cflags_s390x="-m64"}
+: $(cross_cc_riscv64="riscv64-linux-gnu-gcc")
+: ${cross_cc_s390x="s390x-linux-gnu-gcc"}
+: $(cross_cc_sh4="sh4-linux-gnu-gcc")
 : ${cross_cc_cflags_sparc="-m32 -mv8plus -mcpu=ultrasparc"}
+: ${cross_cc_sparc64="sparc64-linux-gnu-gcc"}
 : ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
+: ${cross_cc_x86_64="x86_64-pc-linux-gnu-gcc"}
+: ${cross_cc_cflags_x86_64="-m64"}
 
 for target in $target_list; do
   arch=${target%%-*}
-- 
2.20.1



Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453CFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FFD20675
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ju8BDo3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FFD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdMu-0007xl-5J
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEe-0002Vv-3U
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEb-0005s8-1P
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f18so23375135wml.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=09WbvjBl4qGw2wSB47ZVCDVMGKqWTzjkB82c4wAU+mc=;
 b=ju8BDo3NwSVr5TNwlr3bIE5iIuJiGD1DU6lFRP27OV+UMq/EeHODsa6/LuMMhcc+i9
 qjV67Q0UJg+q9oAc6d1QOofLLLh9ik+DTheqk993Spzg7JrWib/iaISr0rRItv9uzCfe
 w2HEUeSEUIITTreMX5Z3wTXSzNt9XJZsVgzXf8hy9+NFPCpZvk8AjysGIcIuz2lPilJY
 gPaGVZNBpnDHJp1oHaz5uodLXTEnJGzVY+vbhgKcGCWOgcVuO7qawx/qp3KiyvFuXgaV
 AfkDynAyuJJlUeejXvq9qyVszIZPaJj1bs9qLFAdHT0XBoU8/GQ+YmWWYamy9bthMfvh
 HmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=09WbvjBl4qGw2wSB47ZVCDVMGKqWTzjkB82c4wAU+mc=;
 b=klsR4CLy7foHgm5ZOvBzkdrZy9zviF/8NyrXhIlVCnV0w1Lfp7aZuSfmrylepoQK8w
 Ne5BxMqCJ2lvINZubxWFOMsfCj0NZyAcyg/lloZgx8NJcG8qi0SQgJsTBArPd5iC30dk
 jZAzufXI+UvKL3dVSIkykx4j9MaH41fA/SXvDfd3NskcyxRyANKauD6L+xRa6C2pKMbJ
 /Wvs+Cey6tsHBeDpeGj2hjRs5bNdwGbqKXYLRk5r8S5D+x1CVxjvELgD6f5Pff0rPmqt
 khDKoQaAc35/NdaixAR23nI+w/npda6+OvGURPYn+bgtOjA6X1GUsmffGdQ3sJ/1LBBT
 DzGQ==
X-Gm-Message-State: AOAM532n6zu9YVoChnn4DchsQlflTdb1W5w7FIr7APccm8xhe5PlZ76K
 oFs/biNEG5mkbCeQAenq060hMA==
X-Google-Smtp-Source: ABdhPJyBBAqeehgEf6sWoCuXYoEcKVAD2LX5kIFSIbGdciNHERPWYYHAvaoNdXMp53glAPfFDfOpOA==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr26309698wme.50.1593611827633; 
 Wed, 01 Jul 2020 06:57:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm7365977wrq.13.2020.07.01.06.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:57:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC32E1FFA9;
 Wed,  1 Jul 2020 14:56:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/40] gitlab-ci: Fix the change rules after moving the YML
 files
Date: Wed,  1 Jul 2020 14:56:31 +0100
Message-Id: <20200701135652.1366-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The edk2.yml and opensbi.yml files have recently been moved/renamed,
but the change has not been reflected in the rules in the YML files
yet.

Fixes: 922febe2af ("Move edk2 and opensbi YAML files to .gitlab-ci.d folder")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200625151627.24986-1-thuth@redhat.com>
---
 .gitlab-ci.d/edk2.yml    | 2 +-
 .gitlab-ci.d/opensbi.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index 088ba4b43a3..a9990b71475 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -2,7 +2,7 @@ docker-edk2:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-edk2.yml
+   - .gitlab-ci.d/edk2.yml
    - .gitlab-ci.d/edk2/Dockerfile
    when: always
  image: docker:19.03.1
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index dd051c01245..6a1750784ac 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -2,7 +2,7 @@ docker-opensbi:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-opensbi.yml
+   - .gitlab-ci.d/opensbi.yml
    - .gitlab-ci.d/opensbi/Dockerfile
    when: always
  image: docker:19.03.1
-- 
2.20.1



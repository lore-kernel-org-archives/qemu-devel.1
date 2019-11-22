Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0598DC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C974720679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWfs/7Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C974720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY73L-00046t-0Y
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iY71J-00015f-T4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iY71I-0003fV-Oa
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iY71I-0003fH-IN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id n188so5233793wme.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8XN5lSAdaGTeIm39lI5m9A+wqwBipNJIRwjaGXrxFNM=;
 b=OWfs/7BcW3vusyMze2E77PgOZYFT3aeaXvaoC7SgfHyJV/4ysxrs5qyAmD2VMMnu31
 r+BRWWEIyDmQVAE79rnZbfKPQHGuzfCEM2OmOAgHZUOSTultdzHOrPeS6zIR/PYjlVxH
 yocLb31iZ2VbY5iaDb3MejV/8PGqAL4VMKJR+WXnMYwLRsP6L1FGhPJIJxgaTfr1n0Qu
 e1DuB69Ipagd3e/Y9AHY9tGQRYoNKFfmVvMQVfuflhwvs44yHbQPogJSMRXWX/Iv1wtC
 pBlNf5G87FnTgbpQypdrP1RTg0OBjvz3NbKSNgzZBckMRA1uuIcFQlFDriDlI2Ml4IUb
 yBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XN5lSAdaGTeIm39lI5m9A+wqwBipNJIRwjaGXrxFNM=;
 b=Vm2rcFdxsEQ1EAHcBtzNnnJdJLSdysLTXmS/HocDkabe7wULvcIRPHkaxduQXLiL0+
 4RlCiWQjIvaZ9gHcAbSIqE1kpL/m03Dip6gotHyeUcosXrjZzyMBdyyiApRgcjoqLabj
 CxNBkEg8bdLqRCbTYpOH1SmEV96jSpyRRW/zyPsjHSzJSapZUWMnUlTZ6WCtC1AQqS/p
 gQiVt+GkPfNf2umPaAJzfVruweB4W0ntalb9lDi3JjocY8jPqJR6ui10lgbYz51wUJmN
 P7+YEsdtSh+LPxA2LeY8m/GWYGiO+dZQNvUQmc35XHAkGgC/IbD0gQdH0lfLDFQW4XSN
 E+3Q==
X-Gm-Message-State: APjAAAVwbMtk88TcXd0S0nsmiB2KEgd7WVugCJLbX3Qqf4MZkp74tzkd
 IxKNLzDhFvnmMbEfXRkfW8dUAw==
X-Google-Smtp-Source: APXvYqxxRiVyzge6OZJvVF/kBWk0I7IfdMYOp5bLfFhEJMGP5HZlVG9+R6+c3tIUxgtJcD56feQaVw==
X-Received: by 2002:a1c:a78b:: with SMTP id
 q133mr15884499wme.115.1574421755500; 
 Fri, 22 Nov 2019 03:22:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w132sm3402603wma.6.2019.11.22.03.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 03:22:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C72E1FF8C;
 Fri, 22 Nov 2019 11:22:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/3] tests/vm/centos: fix centos build target
Date: Fri, 22 Nov 2019 11:22:29 +0000
Message-Id: <20191122112231.18431-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122112231.18431-1-alex.bennee@linaro.org>
References: <20191122112231.18431-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to run the docker tests centos has here we have to install
python3 as well as the basic tools.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/centos | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index 53976f1c4c9..b9e851f2d33 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -73,7 +73,7 @@ class CentosVM(basevm.BaseVM):
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("yum update -y")
-        self.ssh_root_check("yum install -y docker make git")
+        self.ssh_root_check("yum install -y docker make git python3")
         self.ssh_root_check("systemctl enable docker")
         self.ssh_root("poweroff")
         self.wait()
-- 
2.20.1



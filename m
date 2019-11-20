Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE35AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C3A2071C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUW9qOUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C3A2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSh0-00007L-K5
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXSd2-0005A2-DJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXSd1-0000vQ-4w
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:14:52 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXSd0-0000ug-VD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:14:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id b3so420879wrs.13
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kwA33zpOOP4RgJwwLMgdvrAHvgchXedQ0eREjVhWdF8=;
 b=CUW9qOUDe6fBDPdCvgz8CQryyLidSNxuZ9E8OvgAINWo2VFyzWq06EZL2JLSgkoHHO
 9CGILJYXQpfjH7xDj1Qas83y12WVjJfx6QHWRJYeKZlsP++NmA86Datctv01hzemq+Is
 /e9gYOCSr+QhYZ98iw14c9H3fyEr/d/1RO8xtWYPuDMeQHubOVNRqTqo/Absy4XWZEPg
 jTk2Mbi00G/xL3ZtOLX9dMlVlJTtUfR9VP0Uiof4yf6xyP/aaZEvDS3nhbx6i/thCmRB
 d4i9iI/tQWgGC6Y5rRZChyS2yOxXwf+MPSH8CEjBGDqx4WswtSs51BOPD2kFQESGsYxf
 5zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kwA33zpOOP4RgJwwLMgdvrAHvgchXedQ0eREjVhWdF8=;
 b=G6GOUzxUWzBlJbMkgTXM6Ct8XdOQt2j22EEl6NBoTbPRgMhgMBTU+wMbq0SdLymVvz
 lYOHzXlcc8ZBIkmksK59c3/YUU49+asHHTZNyvA6VpIPTCojlU8NXVxL4uzIXdR//9Rj
 ekr1RDemSKZKq1PyY4st3pw3+6gWR1Ut9U2Dm4zJqD5MdtERcUf7p0lG8ten71UTEQRQ
 9fJlkBNj+BYsEdWbAyO0Cx1gcOFpYM9t3VgjjW5k+Jl+YMCvvNifgXstVF+vZhjJ9+TQ
 /cM1St/1lnADoYCaLOxZL7ZIMRnKQzaTa29PtcnZhYSWqMiVshXrhykYXMO+0Fr/tooD
 n/tQ==
X-Gm-Message-State: APjAAAXSWC1UHAIcsEFTfXcscHDaG0+vZOsZsRYu/i/iLLUnWlc2737l
 ESi7rCnLc5GnpoU2uTHJ0gxDpQ==
X-Google-Smtp-Source: APXvYqwb5erxgPU9k5T5/GjyeJlHRP0YM6yZkMF03YMk6a1UGWhLgUS4Z/r6+QyLXtWUIfNU3n5Q+w==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr4567737wro.314.1574266487827; 
 Wed, 20 Nov 2019 08:14:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j2sm31986047wrt.61.2019.11.20.08.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 08:14:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BAD6D1FF87;
 Wed, 20 Nov 2019 16:14:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2?] tests/vm/centos: fix centos build target
Date: Wed, 20 Nov 2019 16:14:36 +0000
Message-Id: <20191120161436.13937-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to run the docker tests centos has here we have to install
python3 as well as the basic tools.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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



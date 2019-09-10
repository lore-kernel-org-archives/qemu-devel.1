Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BF9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2BF20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSQdQetj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2BF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7buY-0004cg-Jb
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkj-0003Ka-7M
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bki-0006II-4S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkh-0006HO-UW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id a11so8601999wrx.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ecFZo3SIq2Qf/hgLz+PBuSmYc5fnSAsalqfNQ/ik5mE=;
 b=OSQdQetjxPXfUYAoh6rJU+QZXwg65HfCX0FvaiGQX8tAJen+suNgxBvP4cVaeV8Rjo
 umPg2pg6mIZ0iKFW8xH8C3uNDsyGU8QMqAqcWkKChDdGLE04SMpTr7LVi8ngwZiaavvT
 xMHAo0zB1ZE/YD4CB6321H1wz/qKb2lfiMAxP3r7Aywkhb8dmHrPtYgj2MOBwqf26Fh1
 gJCAcMc4tYHTz5Rjn85pD1wlaWfoCop9nSErBrfS6Cia7FAr9J5b5+jM5TnmCzI9Vyvq
 YsAQPvLSD0KQOfq8b8KMOtv/6QRyOtYBJvi1Yj3guf50Xo+05ZC0fJzoo13P7Y18G/LW
 FByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ecFZo3SIq2Qf/hgLz+PBuSmYc5fnSAsalqfNQ/ik5mE=;
 b=iNYCGrB0U2GuE19B8dgNvenHzy78k6j0UKVFSY4zVcr3fupd1aLmRuuky4ACmn9Rfa
 u0wwq6Ak3Cz+AMB8jw39lkMUCT3IHHSqwcNArKbi4FxXZEVvmTr7z216L7y2Zb2+mhk0
 IaIgJW/Z5jzpPjOf0Mr1TK1PzKK5tt5p6OXJUnDdizbeqHN9iaTp1wWObdaFtDDPHqxO
 gz6tHT0eJEOc0Vbf7y4/aeckvg7weIJTTRI5NCLyzoiYL/t+mo4s40fZonUrKRTn9AoL
 EFBypGv3/NmP+ROQWX6c6fJOQ2J8ugoIxve7ee8W04AzfDtc0W3zMrrldx+8EHH6LJmf
 L/HA==
X-Gm-Message-State: APjAAAUjepykhE56PKyHys4h6dI7EeyR7ngW41bLeoczfhaHnQwTcDw9
 UZJ7ZfyY9Y0koT/kLwFf31FXBw==
X-Google-Smtp-Source: APXvYqxAnmnY7w2awcrgSrYHz39+i8Rdb5sGzaSH/XEUPPbGTBo/V054jKZuh/Cs2WlDX6zyhT9qgw==
X-Received: by 2002:adf:b612:: with SMTP id f18mr14163731wre.97.1568105034847; 
 Tue, 10 Sep 2019 01:43:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm28989942wre.40.2019.09.10.01.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DBAD31FF92;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:09 +0100
Message-Id: <20190910084349.28817-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 05/45] tests/docker: handle missing encoding
 keyword for subprocess.check_output
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was only added in Python 3.6 and not all the build hosts have
that recent a python3. However we still need to ensure everything is
returns as a unicode string so checks higher up the call chain don't
barf.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

fixup! tests/docker: handle missing encoding keyword for subprocess.check_output

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 1620293ac84..417b0cdce13 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -258,10 +258,16 @@ class Docker(object):
         return self._do_kill_instances(True)
 
     def _output(self, cmd, **kwargs):
-        return subprocess.check_output(self._command + cmd,
-                                       stderr=subprocess.STDOUT,
-                                       encoding='utf-8',
-                                       **kwargs)
+        if sys.version_info[1] >= 6:
+            return subprocess.check_output(self._command + cmd,
+                                           stderr=subprocess.STDOUT,
+                                           encoding='utf-8',
+                                           **kwargs)
+        else:
+            return subprocess.check_output(self._command + cmd,
+                                           stderr=subprocess.STDOUT,
+                                           **kwargs).decode('utf-8')
+
 
     def inspect_tag(self, tag):
         try:
-- 
2.20.1



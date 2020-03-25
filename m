Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985CC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053B620409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfYzGqV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053B620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7tX-0000lo-5V
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l7-0003i0-V2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l6-00082c-TW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7l6-00081a-N8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id h15so3568257wrx.9
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l7mM2oj13ibfp0JE0ahAZG76SnCWxFa0MFbX0Uuu7f8=;
 b=hfYzGqV3p86O/5DPGWrz+TOrYdhbvvUcMQv4fL0QBq4nhsyh9CcbVGNJF3wYM2q+T2
 OM1iUcGDvpRvBx7FWItk8MMBVRg5RCtzDCo8qRppXNStlYEzdF4J0XLvH1uc1JoYUVa+
 CKYGBVci9Rd69K79Em/OEr/ocjqszJFF0WlIpAf0zAR7Ll6uxhPxjECb+mI5KF/ADO4m
 O+YoXfHgCgv4QXZFnOnoPK31qtHkS1ZCW9veQdGwKw4yopNFO77bF4AQE75kTwxVO76h
 xs+Md5qR+cetPAaErGT4V/Wpt0pnttsg5RI/LMNtGCvwMfhQdD0YBFAxFv27rlexZCZl
 kxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l7mM2oj13ibfp0JE0ahAZG76SnCWxFa0MFbX0Uuu7f8=;
 b=JC1biSylvLuu40wuOccQlGIDulKYD53F3VzMquLzRKfxg2mlxJUjFXER+okK4HmeUn
 1RFeBm2qIq/eTcAwjEk0o1SicbWBzKgyFZufNJoPt1OFAgGfq/9wPAIyTqgQzZDq7GzE
 WgKM376u0lygiEPJkdpwb3SBBIRHwxdvGSDEDsGmPbzsTZy6HyQgXc4YSfVyYro8k/RR
 CHsA1iqrWCLfliOMBucPyl0zHAAGBJ8kzVBF+2Edtv1MHbht6vYfjSyJ3Y6HQQdskQIP
 aaOb2RCzkzULTy+Vt2wCXyhG7rehtFfNQ1GjH+63C7GDPo21Sqzb24zmf2wvlYj676s0
 +D/A==
X-Gm-Message-State: ANhLgQ3XQtVxmRqJBt9SYjGzHCb/lAdjIpTSd873yWFWQoxgQ2pXOxXY
 Pp9pv14xym3Gp6q8sohwnChfbA==
X-Google-Smtp-Source: ADFU+vuzNADqqkzoez7vXhxvFS3dBcqdWpH7DpXqmMo57v5qZZ4gTVnE1NSJAU0iRcNnJF3Y9unPPA==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr3859544wrq.161.1585149354722; 
 Wed, 25 Mar 2020 08:15:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u131sm10078054wmg.41.2020.03.25.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6A791FF91;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/11] tests/vm: fix basevm config
Date: Wed, 25 Mar 2020 15:15:37 +0000
Message-Id: <20200325151543.32478-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

When the patch was merged it was part of a longer series which had
already merged the config changes. Semu-revert the config related
changes for now so things will build.

Fixes: b081986c85fd2
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200323161514.23952-6-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index cffe7c4600e..756ccf7acae 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -358,23 +358,23 @@ class BaseVM(object):
                           "local-hostname: {}-guest\n".format(name)])
         mdata.close()
         udata = open(os.path.join(cidir, "user-data"), "w")
-        print("guest user:pw {}:{}".format(self._config['guest_user'],
-                                           self._config['guest_pass']))
+        print("guest user:pw {}:{}".format(self.GUEST_USER,
+                                           self.GUEST_PASS))
         udata.writelines(["#cloud-config\n",
                           "chpasswd:\n",
                           "  list: |\n",
-                          "    root:%s\n" % self._config['root_pass'],
-                          "    %s:%s\n" % (self._config['guest_user'],
-                                           self._config['guest_pass']),
+                          "    root:%s\n" % self.ROOT_PASS,
+                          "    %s:%s\n" % (self.GUEST_USER,
+                                           self.GUEST_PASS),
                           "  expire: False\n",
                           "users:\n",
-                          "  - name: %s\n" % self._config['guest_user'],
+                          "  - name: %s\n" % self.GUEST_USER,
                           "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "    - %s\n" % SSH_PUB_KEY,
                           "  - name: root\n",
                           "    ssh-authorized-keys:\n",
-                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "    - %s\n" % SSH_PUB_KEY,
                           "locale: en_US.UTF-8\n"])
         proxy = os.environ.get("http_proxy")
         if not proxy is None:
-- 
2.20.1



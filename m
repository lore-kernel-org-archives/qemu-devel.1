Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8852087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjDZo5LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8852087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cQR-0006tC-8H
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3u-0000uZ-Tz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3t-0003Tn-DE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3t-0003Sl-5i
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id y8so185237wrn.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hNdc0bOvReThYAW1J8YFGDoTrvBZD9ylSfMtDKRLzHM=;
 b=UjDZo5LXyP2ofViw8/x2hmCVzuMJzJ/7nMdPSJ/8cu4QEs8pgHlHFUNNmTEMqNDNeJ
 Z0Jz+2wI+RUzQd+nQMPUxzcnsB1mIrPsGDYHUcxc2KL7/2LoYUe+SGIENJLDKOmjwmSC
 e/z/qRmrFN0slVNw2CgrGF+2kgxbMczmsmQjdfw8UrHrAznTlfw+rKZojLG341wF0s20
 5mDdAIScbXz2Qhsh2CvW4w/4cX3l2r94YJumDbME0XNSHgE2I6+iNqkgOSA121U5h1O/
 BrjZ0AGQbjDE4BGT9XNHtNJNU/8r46fsaTcuRY0aAreJ/SbfC6eAsqT4a0bkvElEkV8T
 hk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hNdc0bOvReThYAW1J8YFGDoTrvBZD9ylSfMtDKRLzHM=;
 b=PBgrElex0z6QeIsWQhsP/Q1L/T2a9MvA9ZxAcyhBsdA1G/cSMsfFUu59Tmnn06z1gZ
 /25v7kfKYCEForZKgd377jzSrbqxxNQM5FK4ynXzIpp2ErOoQdcFIgx4+dV6gFtXVWVJ
 Y/GJQaOKotPRyu76fIF9JcSkIQIGYLYZa8AL8wlhng7yR5AcP7Qcb9ZKy5ttzRr3Y/7c
 adhqur6wlh2VLRVmO5quFVmgoWCTIDunp9Lau1TH/m3Luvqs+pnVIhqFWllfz2OEYu0n
 lRN+aFkpYCbeAfiuCshtshImwMo6rCMBznkcj0sQWxjwcEahD9j5e9hjAQRtds2/dv5O
 AAUQ==
X-Gm-Message-State: APjAAAVk+QwpAH2DuTHMKC1Z6xfk1hohV9i321qbH+8ASktNsyoDP5SO
 9AdIOaC4EPaHYA7xgVV9BDMNRw==
X-Google-Smtp-Source: APXvYqxYw0vhLE9hEgCaXsF7xF/TQJB2K3yi3K/L1+i8VLx/dmFfhFE3gtmbRy2K3VOnVBIfmfPWpQ==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr9511609wrr.75.1567629568037; 
 Wed, 04 Sep 2019 13:39:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h32sm29731448wrh.62.2019.09.04.13.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33EAB1FFC2;
 Wed,  4 Sep 2019 21:30:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:13 +0100
Message-Id: <20190904203013.9028-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH v1 42/42] tests/docker: don't always encoding
 for subprocess.check_output
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was only added in Python 3.6 and not all the build hosts have
that recent a python3. However those that do will complain if
everything isn't properly utf-8 clean:

  ./tests/docker/docker.py --engine auto build qemu:debian-amd64 tests/docker/dockerfiles/debian-amd64.docker   --add-current-user
  Sending build context to Docker daemon  3.584kB

  Step 1/16 : FROM qemu:debian9
  pull access denied for qemu, repository does not exist or may require 'docker login'
  Traceback (most recent call last):
    File "./tests/docker/docker.py", line 659, in <module>
      sys.exit(main())
    File "./tests/docker/docker.py", line 655, in main
      return args.cmdobj.run(args, argv)
    File "./tests/docker/docker.py", line 452, in run
      extra_files_cksum=cksum)
    File "./tests/docker/docker.py", line 306, in build_image
      quiet=quiet)
    File "./tests/docker/docker.py", line 231, in _do_check
      return subprocess.check_call(self._command + cmd, **kwargs)
    File "/usr/lib/python3.4/subprocess.py", line 561, in check_call
      raise CalledProcessError(retcode, cmd)
  subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu:debian-amd64', '-f', '/tmp/docker_buildjvzs88tf/tmpyvtj7ub0.docker', '/tmp/docker_buildjvzs88tf']' returned non-zero exit status 1
  Error in atexit._run_exitfuncs:
  Traceback (most recent call last):
    File "./tests/docker/docker.py", line 258, in _kill_instances
      return self._do_kill_instances(True)
    File "./tests/docker/docker.py", line 239, in _do_kill_instances
      labels = json.loads(resp)[0]["Config"]["Labels"]
    File "/usr/lib/python3.4/json/__init__.py", line 312, in loads
      s.__class__.__name__))
  TypeError: the JSON object must be str, not 'bytes'
  make: *** [docker-image-debian-amd64] Error 1

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 8f391eb278b..e5b7632464b 100755
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
+                                           **kwargs)
+
 
     def inspect_tag(self, tag):
         try:
-- 
2.20.1



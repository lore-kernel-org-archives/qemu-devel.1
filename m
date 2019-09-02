Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16DDC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D80D20820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNhkz+Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D80D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jhY-0000it-Sy
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4ja6-0002jc-SA
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4ja5-0000Lb-C2
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:29:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4ja5-0000L9-5b
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:29:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id q12so13413205wrj.12
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BwBZji+5Tt15dNYdrMynPgEvZVN3UGmmOt0ukLNN0s4=;
 b=hNhkz+UrkyVCEgoaNtzioElv610aS3SDbzuMRXLHncK9BDg8nxYWupssBI7cm7oaMS
 zc3Mj9rCWDK02wm72MbmmExpW5SeCR64vAVHaE7521xin1g7vvZ5pMAxSkFHUzrZmwaI
 D7FCrZ36Wvv7iABsD0hm1QOB/0pRKGu0KkArkArD6ipuld75z8lK0FJaDG/506oRwY/U
 +Cn1gKwpWLEYggRpoLLfacuGm/Tn4+S23ooTYN79ktflXm4NmuXiEKMxGKY87Q5w4n9X
 7SSEJQss32wBY9c+tqOiybltnxLnrsCO3ZhnPmPRnFrLy7hTjzEI9rxPp/XvCGGZTBP8
 ubiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BwBZji+5Tt15dNYdrMynPgEvZVN3UGmmOt0ukLNN0s4=;
 b=uJ6mDoNaaZ/gS35Wj89H996YnWCkb5IEyO4bXY3DzTI/6mlD9q0uDq8NZEpWikucJy
 DDQlCJRlfAuMfLCZFeUIn2FfIM8G0hIJl8WhD0Gqkf3G4TAMrSVp7Iuo46WXewBlMPYD
 JozQwoQsvtm3fQ/7tVsINh9ZJK6Mw0vecCeX2j+kDU9VeEaUqkju2I2g2FDSuZ3ImP6V
 BiJPm59GxS/m8GgvS4mLd76gwEv+m35gs1Ub2pQ9Os36bHEBBTpLsUDkZwIQgZmymHu7
 do73ORmAY1mvXxw/JfOfCh7gnmCeiSjk2nh1z3lllkPjIHCkLVZbptmfhU9yMlpLNq8t
 o0QQ==
X-Gm-Message-State: APjAAAW61eFMXHRYxUEA5yYCnXFH+807KnU+/H9i9oAuzHqnR4W+JCJm
 gjzXW2AmLH0+NPCnsKl9mvpKAA==
X-Google-Smtp-Source: APXvYqzSPbterrNbPATqhvjwlBUH7ngIVpAJ3pFEPbHvcQ6/FXXrGQnJVWvmeUFrX9yhVhoTmVx6JQ==
X-Received: by 2002:adf:f482:: with SMTP id l2mr15786055wro.103.1567420143530; 
 Mon, 02 Sep 2019 03:29:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm16556973wra.91.2019.09.02.03.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:29:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 481001FF9C;
 Mon,  2 Sep 2019 11:21:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:22 +0100
Message-Id: <20190902102122.1128-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 12/12] tests/docker: upgrade docker.py to python3
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recent podman changes (9459f754134bb) imported enum which is part
of the python3 standard library but only available as an external
library for python2. This causes problems on the fairly restricted
environment such as shippable. Lets bite the bullet and make the
script a fully python3 one. To that end:

  - drop the from __future__ import (we are there now ;-)
  - avoid the StringIO import hack
  - be consistent with the mode we read/write dockerfiles
  - s/iteritems/items/
  - ensure check_output returns strings for processing

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ac5baab4cad..4bba29e104e 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python3
 #
 # Docker controlling module
 #
@@ -11,7 +11,6 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
-from __future__ import print_function
 import os
 import sys
 import subprocess
@@ -25,10 +24,7 @@ import tempfile
 import re
 import signal
 from tarfile import TarFile, TarInfo
-try:
-    from StringIO import StringIO
-except ImportError:
-    from io import StringIO
+from io import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 from datetime import datetime, timedelta
@@ -62,11 +58,13 @@ USE_ENGINE = EngineEnum.AUTO
 
 def _text_checksum(text):
     """Calculate a digest string unique to the text content"""
-    return hashlib.sha1(text).hexdigest()
+    return hashlib.sha1(text.encode('utf-8')).hexdigest()
 
+def _read_dockerfile(path):
+    return open(path, 'rt', encoding='utf-8').read()
 
 def _file_checksum(filename):
-    return _text_checksum(open(filename, 'rb').read())
+    return _text_checksum(_read_dockerfile(filename))
 
 
 def _guess_engine_command():
@@ -192,7 +190,7 @@ def _read_qemu_dockerfile(img_name):
 
     df = os.path.join(os.path.dirname(__file__), "dockerfiles",
                       img_name + ".docker")
-    return open(df, "r").read()
+    return _read_dockerfile(df)
 
 
 def _dockerfile_preprocess(df):
@@ -262,6 +260,7 @@ class Docker(object):
     def _output(self, cmd, **kwargs):
         return subprocess.check_output(self._command + cmd,
                                        stderr=subprocess.STDOUT,
+                                       encoding='utf-8',
                                        **kwargs)
 
     def inspect_tag(self, tag):
@@ -283,7 +282,9 @@ class Docker(object):
         if argv is None:
             argv = []
 
-        tmp_df = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
+        tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
+                                             encoding='utf-8',
+                                             dir=docker_dir, suffix=".docker")
         tmp_df.write(dockerfile)
 
         if user:
@@ -396,7 +397,7 @@ class BuildCommand(SubCommand):
                             help="Dockerfile name")
 
     def run(self, args, argv):
-        dockerfile = open(args.dockerfile, "rb").read()
+        dockerfile = _read_dockerfile(args.dockerfile)
         tag = args.tag
 
         dkr = Docker()
@@ -442,7 +443,7 @@ class BuildCommand(SubCommand):
                 cksum += [(filename, _file_checksum(filename))]
 
             argv += ["--build-arg=" + k.lower() + "=" + v
-                     for k, v in os.environ.iteritems()
+                     for k, v in os.environ.items()
                      if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=args.quiet, user=args.user, argv=argv,
@@ -611,7 +612,7 @@ class CheckCommand(SubCommand):
                 print("Need a dockerfile for tag:%s" % (tag))
                 return 1
 
-            dockerfile = open(args.dockerfile, "rb").read()
+            dockerfile = _read_dockerfile(args.dockerfile)
 
             if dkr.image_matches_dockerfile(tag, dockerfile):
                 if not args.quiet:
-- 
2.20.1



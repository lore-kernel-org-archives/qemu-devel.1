Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0303C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E10B217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKD2KLpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZ4b-0006HZ-06
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcc-00080r-Ei
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYca-0006aB-Pv
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYca-0006YG-6x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id r19so3898139wmh.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JQLOnxshFGL3OAqcNMrUvWbdHoJ5YAKAymtlNtOWkFE=;
 b=RKD2KLpKzZVFTnslherogIkd2ERCCG9oXG3mp7kl7Gd5O7oh4POdy5sZiyBRAoKxi2
 tZ0QEB1AEd4GjnjlGEC9+c558gYqznivIE2YTlmaP/VCAicB082Alp8YTqv6BSKSJ945
 S472a8xtEHQWz+67MSdN+gSI5fGMj0wfz9wBKvxUCZx0fO/f/gDKx88bz8duxlQyqIV6
 /4JMAGnUQeD3HJ4UuAbc/uN/JQjg8P+rBqSpBjPtrdDykHfIqE4/4HANmpjcGpRkShuY
 B/Qne2HAjmidmFiD8Dmcabl1Zu+jLTIma+MwaPx68eTVHPxKCS68BbNAFPKMeJZfaOLP
 MBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JQLOnxshFGL3OAqcNMrUvWbdHoJ5YAKAymtlNtOWkFE=;
 b=YVoMB93eExE/B0fBpM8OVg/hq1YlkfUY8AQY0xVc3EdLWjYWNHJMu5NqF965TuFhaJ
 KKFMU9WXqX59zqo4M/zogUSUzT1yiM3VNtkcVw8YcSZn+5NB4qBA7h0ICyC0fuwdFdb2
 jgVszj4bhZj9LMY326uSRyQ0xZSwAvdjZBc1jU9LsfrtWMyGR3ITyrWIPrcW9QrBnBaQ
 tNzhjxyme6bsxOtg2EEMb/39h++Je/gt3XHn55kovX0Rx7e5cUOC2yFNagJT4QeENlGx
 Jlg9tRD6mPYqcsu3R3GyAhbXMMRc2OAEEXSA1uhTERa49pc5pdczWfKcVo+ca1kxDkuu
 joAA==
X-Gm-Message-State: APjAAAW7T/BG3oBBwiiPk2GIUf8WnIB5l5rRNlTKPt4GBQ+Pnq53RQlj
 3mVYabcvypMPowEw0UL23NV+7Q==
X-Google-Smtp-Source: APXvYqyuymRYPV/H+A1BCGJdv2TDx9RiJawk7/2bN2ddE5r8274gItjVH4V4UJmuax/Ml6g3Qx36vg==
X-Received: by 2002:a05:600c:2219:: with SMTP id
 z25mr3953203wml.109.1569522966899; 
 Thu, 26 Sep 2019 11:36:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k9sm132257wrd.7.2019.09.26.11.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:36:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CF451FF9C;
 Thu, 26 Sep 2019 19:35:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/28] tests/docker: reduce scary warnings by cleaning up clean
 up
Date: Thu, 26 Sep 2019 19:35:37 +0100
Message-Id: <20190926183553.13895-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There was in the clean-up code caused by attempting to inspect images
which finished before we got there. Clean up the clean up code by:

  - only track the one instance at a time
  - use --filter for docker ps instead of doing it by hand
  - just call docker rm -f to be done with it
  - use uuid.uuid4() for a random uid

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 29613afd48..3112892fdf 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -215,7 +215,7 @@ class Docker(object):
     """ Running Docker commands """
     def __init__(self):
         self._command = _guess_engine_command()
-        self._instances = []
+        self._instance = None
         atexit.register(self._kill_instances)
         signal.signal(signal.SIGTERM, self._kill_instances)
         signal.signal(signal.SIGHUP, self._kill_instances)
@@ -234,21 +234,19 @@ class Docker(object):
         cmd = ["ps", "-q"]
         if not only_active:
             cmd.append("-a")
+
+        filter = "--filter=label=com.qemu.instance.uuid"
+        if only_known:
+            if self._instance:
+                filter += "=%s" % (self._instance)
+            else:
+                # no point trying to kill, we finished
+                return
+
+        print("filter=%s" % (filter))
+        cmd.append(filter)
         for i in self._output(cmd).split():
-            resp = self._output(["inspect", i])
-            labels = json.loads(resp)[0]["Config"]["Labels"]
-            active = json.loads(resp)[0]["State"]["Running"]
-            if not labels:
-                continue
-            instance_uuid = labels.get("com.qemu.instance.uuid", None)
-            if not instance_uuid:
-                continue
-            if only_known and instance_uuid not in self._instances:
-                continue
-            print("Terminating", i)
-            if active:
-                self._do(["kill", i])
-            self._do(["rm", i])
+            self._do(["rm", "-f", i])
 
     def clean(self):
         self._do_kill_instances(False, False)
@@ -325,9 +323,9 @@ class Docker(object):
         return checksum == _text_checksum(_dockerfile_preprocess(dockerfile))
 
     def run(self, cmd, keep, quiet, as_user=False):
-        label = uuid.uuid1().hex
+        label = uuid.uuid4().hex
         if not keep:
-            self._instances.append(label)
+            self._instance = label
 
         if as_user:
             uid = os.getuid()
@@ -340,7 +338,7 @@ class Docker(object):
                              "com.qemu.instance.uuid=" + label] + cmd,
                              quiet=quiet)
         if not keep:
-            self._instances.remove(label)
+            self._instance = None
         return ret
 
     def command(self, cmd, argv, quiet):
-- 
2.20.1



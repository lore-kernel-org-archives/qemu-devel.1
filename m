Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD39C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3083F217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyKYCS0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3083F217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Br-0002Kn-D0
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37j-00025P-8f
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37i-0002d4-2v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37h-0002Zy-Sc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z9so12177883wrs.10
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gg/XtyPCs1CXTqUK/3D+DzFT3m2+PS5I1o/WnkdvJRI=;
 b=oyKYCS0z+xgNk7ImOLEqMWJ/LgRalju3lYTtK8cxJsFs7psIIQEqJXCw7qOokuqgcV
 SBpuVBcbvY0nMZ81VkuqiRfetp+nZpvHyZSAlyRy0JUEl9lzS+t9c5KHXqxhwyRIQpaE
 AkTuvjPCzVKkd381jcG58xNbx53i6Gb2Zr4rwY4VlWxBimCBq6vq4BUT/L/AA+ZIly7e
 X3lY3dbZTroDK0k/F4RWI9CUquxN9/DTmhmKcYNW52o0OU4wVwvZLmmTmL8pplNyAMRM
 9s7eVJFj+KnSc22JeOn7sihmL3NSP/Xf7obb0UGsZmcGnhd6XnWHwvod74QzKcs5M3Um
 fXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gg/XtyPCs1CXTqUK/3D+DzFT3m2+PS5I1o/WnkdvJRI=;
 b=I0/ebDd/1Q5a5v1WcYfe4Sk/iKer4E9MoDa17j77LQbJhR6e1dJmTy+sk8e81p47MR
 nJmO50XwBjJq53C3FW/5n6QAOyLmvS5XE96q8XCSIUg1t4P5MM+uAvxBYa4KWLajWdWC
 C/cnSnbpnIy0HefrnD2mYmYsv8y6NCcSOEpPJZFoYcic1vhLCz2wRKkf5fBmB8X7v5Ht
 FC9LzucQN6OzXKJHT3NOmMn+ceifkN1qVRpskV8y4wiHUsUzD0I4AR+ccr9Lj0ixMk/+
 z4sVXSODFX6XnjEKsLerS1PkRL/SRFn8ISiIIPVlVwLRMLizEvCMdfFNqAPLsUClZH5H
 lJqA==
X-Gm-Message-State: APjAAAUvyAf/AWfUKJAwEyyHHgPUsAbWLA1svYk0SyLnuts7KEjarA6r
 +iT01+rgSsK9ZjkBBpsL9LwQLA==
X-Google-Smtp-Source: APXvYqzk+oX5ozijvMbH/V/3nRmTdPsAjGxaDsu8eyxwAdq9bb/Nmfp/M/sVaJDuULGeeEm7vuRnxQ==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr23563229wrq.206.1580841632902; 
 Tue, 04 Feb 2020 10:40:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v22sm4698925wml.11.2020.02.04.10.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:31 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 98C1C1FF8F;
 Tue,  4 Feb 2020 18:40:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/16] tests/docker: better handle symlinked libs
Date: Tue,  4 Feb 2020 18:40:14 +0000
Message-Id: <20200204184028.13708-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we are copying we want to ensure we grab the first
resolution (the found in path section). However even that binary might
be a symlink so lets make sure we chase the symlinks to copy the right
binary to where it can be found.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Foley <robert.foley@linaro.org>

Message-Id: <20200203090932.19147-3-alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 31d8adf836e..d8268c11117 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -106,18 +106,19 @@ def _get_so_libs(executable):
     """Return a list of libraries associated with an executable.
 
     The paths may be symbolic links which would need to be resolved to
-    ensure theright data is copied."""
+    ensure the right data is copied."""
 
     libs = []
-    ldd_re = re.compile(r"(/.*/)(\S*)")
+    ldd_re = re.compile(r"(?:\S+ => )?(\S*) \(:?0x[0-9a-f]+\)")
     try:
         ldd_output = subprocess.check_output(["ldd", executable]).decode('utf-8')
         for line in ldd_output.split("\n"):
             search = ldd_re.search(line)
-            if search and len(search.groups()) == 2:
-                so_path = search.groups()[0]
-                so_lib = search.groups()[1]
-                libs.append("%s/%s" % (so_path, so_lib))
+            if search:
+                try:
+                    libs.append(s.group(1))
+                except IndexError:
+                    pass
     except subprocess.CalledProcessError:
         print("%s had no associated libraries (static build?)" % (executable))
 
@@ -145,7 +146,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
-            _copy_with_mkdir(l, dest_dir, so_path)
+            real_l = os.path.realpath(l)
+            _copy_with_mkdir(real_l, dest_dir, so_path)
 
 
 def _check_binfmt_misc(executable):
-- 
2.20.1



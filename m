Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC370206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GI7JCyB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC370206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoFM-0006jw-Ja
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDy-00059l-7t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDx-0003Qg-0G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:34144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoDw-0003Mo-Ox
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id f4so4735820wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g3hgguPtL+HaKFSPze+k4Gth0iQFVtrGwoUkM6o8zZk=;
 b=GI7JCyB+Jh2GdQZxhRB8mQNh9m46u8CtZBvK5+XT2YSti5Tnq6vTNCtXNPTlyIJeu1
 oSHWkqd+RALzhrKaYU0WL9tSoDCRtYqtcNNmI0NUKwvv/QDumkMu0Sv78TZCdVeRRBLU
 fI1lYnWk5/RKz+3OZvsOuz85mKvjJNUsBy0GCs8Yr+6TfTiHHAvQAy9YqeSznsMxNvfg
 Kmt+lojm+/F6LvYfySN14nh8PQdpAgVteCranzDmFFcH+U+temkjgcsQOZM58JwI3t4e
 +mptud26jdhDfZwaQiAF6Y5giaktKv4gbCWAKEOESpXuGH+FvvfV9ZCX7tPV9n5ZNPAI
 /WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g3hgguPtL+HaKFSPze+k4Gth0iQFVtrGwoUkM6o8zZk=;
 b=IOOq5vsqv5eQ9wpq7t+f+Ecr4riPvgtgXxsRc7GeupyzKgnLNXWcKX+7KFHNPnKv8B
 1Be3i5igBbkx3weoFNhcW6QQYEly7HEo5uZVX6RxkB9zP9Q2zgJGe43+1V78gkcchqwu
 01v5PbRoW5T26FHSVpR0wvG0FWfC/EAP1ruYE1KJZ9pAu7i/uB/4uGq2eC01Ylt9N9+s
 ROhdnftdrq4T7tpr41KJg07qZ3WinDjcmaauDdlPa9tJB3kMVvJCmlVOpI+3BYzIVNIw
 sfFtNlcdnbzcUX3q1rCE/c1EJ7W4sUhw20EjOD9eSk4SsDWEkrw8kYBeButgB7BtOTTj
 Loag==
X-Gm-Message-State: APjAAAU9NcUkdyKUS6XqdzVCC4fgf4JNaBuKSw+cZF9Tu1Yssqe8WAcu
 r9siKoivSbqRS1BXZszJpvasQg==
X-Google-Smtp-Source: APXvYqzjqTMI8Vzqy7eihoaWO7YQgCvmMfqh73ScTN4U6pUrLe6PFl8ye9HbQJ+m9kDrbHKJo+jMYA==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr8509596wme.177.1576494454347; 
 Mon, 16 Dec 2019 03:07:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u18sm20848261wrt.26.2019.12.16.03.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F5021FF8C;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/16] configure: allow disable of cross compilation
 containers
Date: Mon, 16 Dec 2019 11:07:17 +0000
Message-Id: <20191216110732.24027-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Stefan Weil <sw@weilnetz.de>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our docker infrastructure isn't quite as multiarch as we would wish so
lets allow the user to disable it if they want. This will allow us to
use still run check-tcg on non-x86 CI setups.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
---
 configure              | 8 +++++++-
 tests/tcg/configure.sh | 6 ++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 2c72e04d23f..419e1554978 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,7 @@ audio_win_int=""
 libs_qga=""
 debug_info="yes"
 stack_protector=""
+use_containers="yes"
 
 if test -e "$source_path/.git"
 then
@@ -1539,6 +1540,10 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
+  --enable-containers) use_containers="yes"
+  ;;
+  --disable-containers) use_containers="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1722,6 +1727,7 @@ Advanced options (experts only):
                            track the maximum stack usage of stacks created by qemu_alloc_stack
   --enable-plugins
                            enable plugins via shared library loading
+  --disable-containers     don't use containers for cross-building
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -8023,7 +8029,7 @@ done
 (for i in $cross_cc_vars; do
   export $i
 done
-export target_list source_path
+export target_list source_path use_containers
 $source_path/tests/tcg/configure.sh)
 
 # temporary config to build submodules
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 6c4a471aeae..210e68396f2 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -36,8 +36,10 @@ TMPC="${TMPDIR1}/qemu-conf.c"
 TMPE="${TMPDIR1}/qemu-conf.exe"
 
 container="no"
-if has "docker" || has "podman"; then
-  container=$($python $source_path/tests/docker/docker.py probe)
+if test $use_containers = "yes"; then
+    if has "docker" || has "podman"; then
+        container=$($python $source_path/tests/docker/docker.py probe)
+    fi
 fi
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
-- 
2.20.1



Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB25DC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB25208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A56w0WBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB25208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkE0-00067z-2r
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDb-0004w3-Ol
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDa-0004So-Lb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDa-0004SC-CA
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id y4so24909492wrm.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KXyc4gTTAJaNXf6dtEqbxh/PAibemTFL8L8bZEMcnns=;
 b=A56w0WBTwgshw6Om7Y2cfUU80UEmSFZ0UoHQKNF9MESrLucdnM4yVB1S3yokjNjdZp
 FASVdG3kb0JM8ftwcHR4rllm13aHqQ1NrzThD79o4OY17AxzD6mW9oyd64Xxg1KE7Pi3
 Nqdqc+pV0hP6Fd8K44DITEXX0dehsjvMpHMU6EA22njjjketYCKWX00MbY0NjHi39zNG
 6VwfA4hJXKbWrQGx14GvO1zJelVnAv6gX25y1KP7u2/CxtL6cNbUpK/UnD7y4D5mzlCj
 ie3ZDB8OxQ/rjrHGAP+RebmKiBL96oNCK3Mf9K10nwMo/oRQAppDLTi8t/q7C6xbP3YW
 XhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KXyc4gTTAJaNXf6dtEqbxh/PAibemTFL8L8bZEMcnns=;
 b=IWh9slc9trZdW7d0oqQRpeH5Jcs+tKWrKgv6RXLhgh8iGqZZLLqUXdcgxoCgf8m1qB
 SmQXuuvjHnpiUBIRPsQge4UWgFuUEevAnFnjtt3IQ6UL09FyC+/dUZgunRZXvuZs/Nu5
 m1NoH3bgGsTUzuGnQqeiTTvSPCWeJEFLaXVXUIzEsI7OaTngHAfLahpctpG6nU+G6ixj
 fBt/C8OqrnRwB+KpJ/ktgwHR99S2R/zpIa0/nEyAZqKKiURdAna11B52GTe1D1O7uQRk
 bWW5q2gY94sO8zKIEjkzBZQAq7kAFTlflCTqrxByTbxgI3H0Mp7eCoXiLXxYDnBJpjME
 l0Kg==
X-Gm-Message-State: APjAAAVJ8yb51Dh+ObqBfWjnGQsTXO4yMuS5UEt0O0IYJy8dsUpw9dLR
 Gi5V+QG8tQATbCavHspKEKbBYA==
X-Google-Smtp-Source: APXvYqxCQSa5fCA9MuB4CmD3f4iweRuOnJoJ+/TzIYxrH7TTumh0QKBwdmi/7AylGxora6DaAOd1bA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr44708060wrx.72.1563371016856; 
 Wed, 17 Jul 2019 06:43:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b15sm38821810wrt.77.2019.07.17.06.43.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB31A1FF8C;
 Wed, 17 Jul 2019 14:43:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:13 +0100
Message-Id: <20190717134335.15351-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 01/23] archive-source: also create a stash
 for submodules
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

"git archive" fails when a submodule has a modification, because "git
stash create" doesn't handle submodules. Let's teach our
archive-source.sh to handle modifications in submodules the same way
as qemu tree, by creating a stash.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190708200250.12017-1-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/archive-source.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index ca94e49978f..fb5d6b3918d 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -39,14 +39,16 @@ function cleanup() {
 }
 trap "cleanup" 0 1 2 3 15
 
-if git diff-index --quiet HEAD -- &>/dev/null
-then
-    HEAD=HEAD
-else
-    HEAD=$(git stash create)
-fi
+function tree_ish() {
+    local retval='HEAD'
+    if ! git diff-index --quiet --ignore-submodules=all HEAD -- &>/dev/null
+    then
+        retval=$(git stash create)
+    fi
+    echo "$retval"
+}
 
-git archive --format tar $HEAD > "$tar_file"
+git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 for sm in $submodules; do
     status="$(git submodule status "$sm")"
@@ -62,7 +64,7 @@ for sm in $submodules; do
             echo "WARNING: submodule $sm is out of sync"
             ;;
     esac
-    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
+    (cd $sm; git archive --format tar --prefix "$sm/" $(tree_ish)) > "$sub_file"
     test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
     tar --concatenate --file "$tar_file" "$sub_file"
     test $? -ne 0 && error "failed append submodule $sm to $tar_file"
-- 
2.20.1



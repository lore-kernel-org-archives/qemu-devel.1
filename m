Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F6C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21395208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEuG+GzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21395208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCUp-00088X-DD
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZBOM-0007e4-Ai
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZBOK-0000pO-G7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:42:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZBOK-0000lE-8j
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:42:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n4so1476650wrs.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oJrbPHU6QMM17Z/P//VMEjEn9UEe0UK4q9allOg3/go=;
 b=aEuG+GzNMS4QTFB6KF60Z6oNGIGC5YokL7OlScAPDZ1vFIpphysthLUMfyt3CUp9ha
 72G3QpoEfhmjpxwxyvGU8zkZNOpBscbf4yI5vAHBXE8CgKPhJlGAh0e1MNV3nNYvVhR9
 jfNMmTwf3QRKLyDWaSWWEbSjFIEF6zmKSZq8nkikJLCwURHbiPTHX+8JYfvFL8thLwE3
 MmyAwbcLwWl8iRQEt1t57BC5eB/eKgkCSAoSDqU+EKHcqf5I2p1H7ZYmMyFhLIcXQbM1
 jn7HNakEdNSu2RMABuJxvR+ydO00izMXZ5r1613ALvYMacptQbXX4H9GbmpS/lFOAxxc
 qiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oJrbPHU6QMM17Z/P//VMEjEn9UEe0UK4q9allOg3/go=;
 b=iC15ZwkUY6kwL5WY2RmmfsAVcM6x47v7y02lAIHZEx8CTLevPIMwPdqp6/ZK3mOz/l
 4Wc7xcaSfr7RIGuVQVbjTdvmT6Qv3ZmbTdu395TrjdmZt+W8N03Uanzel099WO1CrDfd
 MxMkIAT2n76MDQbt/TyCxFEVbkd/Vzj7Hg8676b1vFmOMicCUBP3K+zPaSyYa9a/z/e5
 4xGP8AAUr9vpP3Nfw7guGzPUlULSPHIz8fKMiHoP2elUDspPnmLYH1MKccMMrvZRdXUg
 eJTcKv54ekIbhF/TY9j+1kX0zhwsFHbj0N5vEAed5fleoI0Ty19ycr+XqIIiy8ZTfscC
 QovQ==
X-Gm-Message-State: APjAAAUK/xj98VNQYyptqKw7V9uF0NZmv9J5PI9cDwUGGluDNMxunjlE
 4PbTjySXuD2+Cd2sUKt25rzzvA==
X-Google-Smtp-Source: APXvYqzXu68gJ9cQ2zSxQ0MCz9iGNHDpKQQLClmj4OXsPVqHGi3NgU3Hv3TTFevVrn1JbXB+G8upxw==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr35571326wru.184.1559900549537; 
 Fri, 07 Jun 2019 02:42:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k184sm2078868wmk.0.2019.06.07.02.42.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:42:28 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEA631FF9C;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:11 +0100
Message-Id: <20190607090552.12434-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 12/52] scripts: use git archive in archive-source
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Use git archive to create tarballs of qemu and submodules instead of
cloning the repository and the submodules.  This is a order of magnitude
faster because it doesn't fetch the submodules from the internet each
time the script runs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-2-kraxel@redhat.com>
[AJB: fixed up tabs]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 8b89948260..ca94e49978 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -19,16 +19,25 @@ if test $# -lt 1; then
 fi
 
 tar_file=$(realpath "$1")
-list_file="${tar_file}.list"
-vroot_dir="${tar_file}.vroot"
+sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
+sub_file="${sub_tdir}/submodule.tar"
 
 # We want a predictable list of submodules for builds, that is
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
 submodules="dtc slirp ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+sub_deinit=""
 
-trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
+function cleanup() {
+    local status=$?
+    rm -rf "$sub_tdir"
+    if test "$sub_deinit" != ""; then
+        git submodule deinit $sub_deinit
+    fi
+    exit $status
+}
+trap "cleanup" 0 1 2 3 15
 
 if git diff-index --quiet HEAD -- &>/dev/null
 then
@@ -36,45 +45,26 @@ then
 else
     HEAD=$(git stash create)
 fi
-git clone --shared . "$vroot_dir"
-test $? -ne 0 && error "failed to clone into '$vroot_dir'"
-for sm in $submodules; do
-    if test -d "$sm/.git"
-    then
-       git clone --shared "$sm" "$vroot_dir/$sm"
-       test $? -ne 0 && error "failed to clone submodule $sm"
-    fi
-done
-
-cd "$vroot_dir"
-test $? -ne 0 && error "failed to change into '$vroot_dir'"
-
-git checkout $HEAD
-test $? -ne 0 && error "failed to checkout $HEAD revision"
 
+git archive --format tar $HEAD > "$tar_file"
+test $? -ne 0 && error "failed to archive qemu"
 for sm in $submodules; do
-    git submodule update --init $sm
-    test $? -ne 0 && error "failed to init submodule $sm"
+    status="$(git submodule status "$sm")"
+    smhash="${status#[ +-]}"
+    smhash="${smhash%% *}"
+    case "$status" in
+        -*)
+            sub_deinit="$sub_deinit $sm"
+            git submodule update --init "$sm"
+            test $? -ne 0 && error "failed to update submodule $sm"
+            ;;
+        +*)
+            echo "WARNING: submodule $sm is out of sync"
+            ;;
+    esac
+    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
+    test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
+    tar --concatenate --file "$tar_file" "$sub_file"
+    test $? -ne 0 && error "failed append submodule $sm to $tar_file"
 done
-
-if test -n "$submodules"; then
-    {
-        git ls-files || error "git ls-files failed"
-        for sm in $submodules; do
-            (cd $sm; git ls-files) | sed "s:^:$sm/:"
-            if test "${PIPESTATUS[*]}" != "0 0"; then
-                error "git ls-files in submodule $sm failed"
-            fi
-        done
-    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$list_file"
-else
-    git ls-files > "$list_file"
-fi
-
-if test $? -ne 0; then
-    error "failed to generate list file"
-fi
-
-tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
-
 exit 0
-- 
2.20.1



Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C124EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA0920726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1AW8QUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA0920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aZA-0006SL-Ni
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZkY-0003tz-I0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZkX-0004DW-Ge
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZkX-0004BP-AG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:55:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id m3so2870857wmi.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0p1SeaSzVNL+Dpq/RgeGL6vQDYFqS32WjhR7r4VpWNA=;
 b=g1AW8QUjiTQwfFU6v/KGbr5nDgysBSwFzbGn6L1UEg4CFS4y+c6bSiKGUsWVrAEtMy
 tvVUaxch120g0LHI59hlL4ShT5LYTUpIj+fk/1tPjyCmqKIh+k4eRLJqNIEwFZjB5zEz
 uvUTtjSadwQmBQQX8+dsuS1u6q3l866+rYuAAytHE0+6dz/fs06nVHR0Lg3FSShgv+bI
 ZTGadZPvML9y0y7xfnL/Kr27Khc5mpfLJeldQMCUfBwA+X8M9Hd+SB5dm2bcQZCALHNh
 TE68ixFuVlo8jLkE9tQq9lg35EoktX66+y664f35OE6gQLVkoaDRpJVXQ1TcU5pk+A4o
 eoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0p1SeaSzVNL+Dpq/RgeGL6vQDYFqS32WjhR7r4VpWNA=;
 b=YpG4PU5RLwCeE99HNxGlQzFHuvdPnggpRfhpUxeyhEQnBM8zs49bzFGrfjW0sXiICd
 8H3KZLzCiOiyLelyl0ykMrD/V7TeK+0fMg/H91XBAXKYm7wVdbvRr/JIqvyYlscfZhvh
 tPUR5rHO7tSOLgyqUtU4JU0apWC3ibRKRG5026FLoU4iLLWKML24c0hQzqyX7o4ls/aW
 ikV28mnF/yGlsFVXjQqNcLBw36szjZKKLREEEB+RRAzOj+QgxmajfwWQIGcbeB40bBeE
 uOAAWwdRxLTfKgk9+qpGklkQw8bD71O4I1OoxN1rBqAv9cEM0DGzI7aQjZRTEZxzhRlX
 Li7A==
X-Gm-Message-State: APjAAAXmCRXtaN7nvRFH7uqA/vef6emDJ0BWuaWnlOkBC6HK+9oQe4pC
 W2743BhcqzjLgj+rvLsstDqunA==
X-Google-Smtp-Source: APXvYqxgJqRfpodiofSxkq1+iih/TkaFHUnUG1OFVz7G4z7bWqmzP0Xsf9aI5ZAS33pVl7nAgJkRvw==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr5512492wmf.105.1582635344046; 
 Tue, 25 Feb 2020 04:55:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h2sm23945190wrt.45.2020.02.25.04.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:55:37 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E39541FFA9;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 18/19] tests/tcg: fix typo in configure.sh test for v8.3
Date: Tue, 25 Feb 2020 12:47:09 +0000
Message-Id: <20200225124710.14152-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although most people use the docker images this can trip up on
developer systems with actual valid cross-compilers!

Fixes: bb516dfc5b3
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/configure.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 9eb6ba3b7ea..eaaaff6233a 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -228,7 +228,7 @@ for target in $target_list; do
                 echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
             fi
             if do_compiler "$target_compiler" $target_compiler_cflags \
-               -march=-march=armv8.3-a -o $TMPE $TMPC; then
+               -march=armv8.3-a -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
             fi
         ;;
-- 
2.20.1



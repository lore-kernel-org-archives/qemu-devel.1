Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBAA20820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+q7Am+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBAA20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dTL-0001d2-06
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 18:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cWt-0007Ca-Mg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cWs-0004Sk-74
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:09:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cWs-0004Rs-0R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:09:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id q19so290955wmc.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L4odYbRNIesstedT/hIMRAackRtRJmlkYcVFyEsUJv8=;
 b=r+q7Am+7dI6hs3m4n5+Kf+i7VYTz79M76Y4aXg3geXoUjkqFox7QH0ABetCesfQoES
 jVFkYZfskXzKKulYFWJXiuBKgeZmxN7cBErv3foTH27BINXEZzef70zIaclPMAgZ/6bf
 ORGZFRXusLa1EylmWGWrAR2Jw/POX5QrdH16Z8ag5YXMK98+NlQHxjWjvlxYiy5W+zC6
 hvEREiU2H9QZxXqe8eVgGVazrggnkuaTIn/b6EpRlrquiF5S5Omdi6GQxKTPYL3jSgi3
 J7Qmt4oxSvsKiygvqEfmR1ODfI/tj08UL6XeTDh19pqPvxoVKvJWPcx9o33BtA3Jo/4i
 jihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L4odYbRNIesstedT/hIMRAackRtRJmlkYcVFyEsUJv8=;
 b=pLdD8gnuejxzk4z7jW8Ad+KqlBbf/AqLd0+Fpw/HoPcfNJH3lh2JoUGfTW0L2yIawe
 dG+c8PzmKPPzx+4NNtpUS/j5UZ46m1aghqY3cmg5QApzh385zIR5aPP3zat/PI1J0hjT
 1BC9Ap6v7NGBIy/pyIUzZRugChTU++1wsNKa8/uTL5GYhzhH8iEp+Qznd61riKybzT1D
 NIx/G7LUx8ju4csthiNn08CcT7ZWMVHRFeh3t3kBqNxOYjgG9yly3IdpmihaThYrwyCM
 RC++Xm+pB+ZpFUhpqAfZPlXHY8a1GBl27+WXEe9dyks5Oh/ArSU3LjARPXYAOua9bDxr
 3qoQ==
X-Gm-Message-State: APjAAAUgcW1I94nOS9Vn+oyHfGu1Bu0EPlsb5oMCEmY3uYWKVJDxV/7/
 ekmN8phFzWLVgBoc9NDNYoOADw==
X-Google-Smtp-Source: APXvYqzVZTpIsYa6OxgRAlWvvayhkAo4TiSyO4xrzE/5fWmk/hUCovA4brarEvUn26rmyHYG7+gMSw==
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr198570wmj.106.1567631364660; 
 Wed, 04 Sep 2019 14:09:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm38341wrh.20.2019.09.04.14.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 14:09:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8104C1FFBB;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:05 +0100
Message-Id: <20190904203013.9028-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v1 34/42] .travis.yml: Improve ccache use
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Per https://ccache.dev/manual/latest.html:

  By default, ccache tries to give as few false cache hits as
  possible. However, in certain situations it’s possible that
  you know things that ccache can’t take for granted.

  [The CCACHE_SLOPINESS environment variable] makes it possible
  to tell ccache to relax some checks in order to increase the
  hit rate.

We can relax the ctime/mtime header checks:

  - include_file_ctime

    By default, ccache also will not cache a file if it
    includes a header whose ctime is too new. This option
    disables that check.

  - include_file_mtime

    By default, ccache will not cache a file if it includes
    a header whose mtime is too new. This option disables
    that check.

We also add a call to clear the cache statistics before running
the build, and display them when the build finishes.

See https://docs.travis-ci.com/user/caching/#ccache-cache

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 8d2e89da533..5a878ae6ae9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -70,6 +70,9 @@ env:
     - TEST_CMD="make check -j3 V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
+    - CCACHE_MAXSIZE=1G
+
 
 git:
   # we want to do this ourselves
@@ -77,10 +80,13 @@ git:
 
 
 before_script:
+  - command -v ccache && ccache --zero-stats
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && travis_retry ${TEST_CMD}
+after_script:
+  - command -v ccache && ccache --show-stats
 
 
 matrix:
-- 
2.20.1



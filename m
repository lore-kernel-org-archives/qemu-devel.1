Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82947C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E02B20820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqOHHbvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E02B20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jZO-0001RI-2k
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSn-0004kG-Di
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSl-0004IF-6i
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSk-0004HC-W3
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id t17so13943141wmi.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FqjuG3RUHS3JckYSNiYZ0vObZ8wV+Y4/XOCXHmnveCo=;
 b=TqOHHbvCClDHl6VSYqE9nNZYFWu83QoHEE7rROcNBoZPJKgVhutaG3ZUPtulCpCBoD
 83polwalRvyvN+L/i6CDyhTldnFxbmtIh3W/4ABJNDniXAbUS7DNqyCN89tmofYRewt1
 lxJcKJK/8AXyYZo9ocuyE6w16m5LGg5Bv2LEehVfO4d9g9wFy1tmEzifPji2Kip24Mag
 yzC2LO9A/Hrt3Zkroz2bXoXSSVceVmVlzuNo0l4R/mWOHDNLOn+9r6orP3s+7khJv3PT
 dhVCGfWj/cp5HPWpWqxf+fQhdUCySdIKZtJNsNReP5BnzMnz7cTIlLYvmsGbqVVEpQo8
 K0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FqjuG3RUHS3JckYSNiYZ0vObZ8wV+Y4/XOCXHmnveCo=;
 b=arucEsqu5OfUysWgohtJmh1cJWtiZ90XJ2DHph84lh0HFCSLTCXSK17seXzMbZ3rtD
 66HeIpj1y22jArBFSpKAkH6RH9n/E/XGbTGUjJlj+9QCR4qd3I5IPE26WegdyTOzVPHY
 6MHgVVY5LyHQOlbWPN/wNBPS9jRyuQtOG7qmk+LVfv/73WYjSJiKpKY50ujtKqVBp1py
 Cw6eCl0ndvphim+USerzsfFDuqGfK9Osf8ehdPtTbif7TBfCUigH3TmZweKfHxzYRsL3
 lo0DtA6A551aL/TGWlAExY++Z9RM3DOTGGLumTeDlabdrJlCIe5V+6YvU0wn83jztB2o
 aK0Q==
X-Gm-Message-State: APjAAAVvunD5OnadcANbbHRegT+5JE6HUX3t7ytLLbFyGFe34RUYXLMI
 xH1O3lsY0aursn1JrmvXjuQuQg==
X-Google-Smtp-Source: APXvYqwIwV5hxHyaBV9REE+YAskliMSOyrf4ooTz7kJ/V1d0Wg/Nw+CKHiGOc0ZOsB6Q9uk5b59JTA==
X-Received: by 2002:a1c:eb06:: with SMTP id j6mr36437267wmh.76.1567419688772; 
 Mon, 02 Sep 2019 03:21:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f66sm729106wmg.2.2019.09.02.03.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E46641FF98;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:18 +0100
Message-Id: <20190902102122.1128-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 08/12] .mailmap/aliases: add some further
 commentary
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
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The two files are not interchangeable but a change to one *might*
require a change to the other so lets flag that up with an explanation
of what both files are trying to achieve. While we are at it document
the many forms .mailmap can take in the header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

diff --git a/.mailmap b/.mailmap
index d0fc1d793c6..0756a0bf66d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,4 +1,18 @@
 # This mailmap fixes up author names/addresses.
+#
+# If you are adding to this file consider if a similar change needs to
+# be made to contrib/gitdm/aliases. They are not however completely
+# analogous. .mailmap is concerned with fixing up damaged author
+# fields where as the gitdm equivalent is more concerned with making
+# sure multiple email addresses get mapped onto the same author.
+#
+# From man git-shortlog the forms are:
+#
+#  Proper Name <commit@email.xx>
+#  <proper@email.xx> <commit@email.xx>
+#  Proper Name <proper@email.xx> <commit@email.xx>
+#  Proper Name <proper@email.xx> Commit Name <commit@email.xx>
+#
 
 # The first section translates weird addresses from the original git import
 # into proper addresses so that they are counted properly by git shortlog.
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
index 07fd3391a56..c1e744312f5 100644
--- a/contrib/gitdm/aliases
+++ b/contrib/gitdm/aliases
@@ -1,6 +1,22 @@
 #
-# This is the email aliases file, mapping secondary addresses
-# onto a single, canonical address. Duplicates some info from .mailmap
+# This is the email aliases file, mapping secondary addresses onto a
+# single, canonical address. It duplicates some info from .mailmap so
+# if you are adding something here also consider if the .mailmap needs
+# updating.
+#
+# If you just want to avoid gitdm complaining about author fields
+# which are actually email addresses with the message:
+#
+#   "...is an author name, probably not what you want"
+#
+# you can just apply --use-mailmap to you git-log command, e.g:
+#
+#   git log --use-mailmap --numstat --since "last 2 years" | $GITDM
+#
+# however that will have the effect of squashing multiple addresses to
+# a canonical address which will distort the stats of those who
+# contribute in both personal and professional capacities from
+# different addresses.
 #
 
 # weird commits
diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 05e355d30ec..1c847174380 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -2,7 +2,8 @@
 # Individual and personal contributors
 #
 # This is simply to allow prolific developers with no company
-# affiliations to be grouped together in the summary stats.
+# affiliations (or non-company related personal work) to be grouped
+# together in the summary stats.
 #
 
 f4bug@amsat.org
-- 
2.20.1



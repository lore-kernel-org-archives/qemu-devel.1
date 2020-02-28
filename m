Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF3C3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D53B246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNq2eDb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D53B246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hhp-0002G1-Bs
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgi-0000Q9-TM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hgh-0004j5-SO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hgh-0004ij-Mg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id e10so1986074wrr.10
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X9wpHhfsmd3rtWtGyuUFtQWdHkR1Efjq12YGQ0CRiO0=;
 b=tNq2eDb4/yiKo9z5RVP+ghnGiN8+g+vgqXx7ky+92wzEJkCYH097uUxpSLr0VBs+61
 DobwisvygUpUxwd5ICGnJPZ7oR/vc4qlcSMpQQBBhxesydll7qsN8m3+WBWDd6dAVexJ
 7GRWWaX8gFwT4mIc68+p/NTyPU+dO3M8U1Pm2yVX4kxU8zPKyoo8fD2r+SZGXsmATJPq
 8X/dShGxe73ATnbang1JXnzTJQXoG+9pdSaYjk4l28deSVfRY0tGas99N8COquOg4FCD
 VBXzAgd3y0ijAuU8fUUVK8JguobaNa/PjsIYkVJxupNLZ0ZXE8dmI0mQXIkQOrQUS1OA
 1Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X9wpHhfsmd3rtWtGyuUFtQWdHkR1Efjq12YGQ0CRiO0=;
 b=SxKg1lHtHtKCwzdqrLY2dqzoKzzwTCYuTTaOQ+4qlyZn0GHN0rHdihyqmteFUOdjh0
 Sm1zEctXqlRS0RWzg7PJGmo1NCyYky3tVAGJ/2QLF/SDsNhUQwGA/onLwiCo4ca8Ucr+
 ty7NaZ4dvDxpQnAwtVvIXYsR2IW9dROoWZBBALvC8inEVyLbNtUYMtfMbj1rS/gkPZJ1
 VGJoQ8B48xlsl0VafIhOyIQ1FrQBXWpFhsrHWZR2X34OcaMj9Z9exbBsVOoaTip/Oc8B
 vb1H1ewQRMRTuS21gX+yI1EE5XDAC5o09PBop5cpuB0PIW3bVAqTYoZSAg2FOVLNcSgk
 4rQQ==
X-Gm-Message-State: APjAAAVLdDUjDouHKc9LkeSZHY+d0VxREh9v+H2HgdStw/eM8wnT9H1a
 f/FAUM+XL84SzFDT3EPQ/4aaW4vlHZ9Vtw==
X-Google-Smtp-Source: APXvYqw4CpHUacn2f1h1tQVgEz80EpwoX5b/jAqnxyIXRXrqmrZN09/icgQXYcUPh0Hspk2CEhYwKQ==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr5229902wrq.422.1582904186264; 
 Fri, 28 Feb 2020 07:36:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/33] texi2pod: parse @include directives outside "@c man"
 blocks
Date: Fri, 28 Feb 2020 15:35:49 +0000
Message-Id: <20200228153619.9906-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This enables splitting the huge qemu-doc.texi file and keeping parallel
Texinfo and rST versions of the documentation.  texi2pod is not going to
live much longer and hardly anyone cares about its upstream status,
so the temporary fork should be acceptable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20200226113034.6741-4-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/texi2pod.pl | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 839b7917cf7..8bfc6f6f4c4 100755
--- a/scripts/texi2pod.pl
+++ b/scripts/texi2pod.pl
@@ -143,6 +143,24 @@ while(<$inf>) {
 	next;
     };
 
+    # Single line command handlers.
+
+    /^\@include\s+(.+)$/ and do {
+	push @instack, $inf;
+	$inf = gensym();
+	$file = postprocess($1);
+
+	# Try cwd and $ibase, then explicit -I paths.
+	$done = 0;
+	foreach $path ("", $ibase, @ipath) {
+	    $mypath = $file;
+	    $mypath = $path . "/" . $mypath if ($path ne "");
+	    open($inf, "<" . $mypath) and ($done = 1, last);
+	}
+	die "cannot find $file" if !$done;
+	next;
+    };
+
     next unless $output;
 
     # Discard comments.  (Can't do it above, because then we'd never see
@@ -242,24 +260,6 @@ while(<$inf>) {
 	s/>/&GT;/g;
     }
 
-    # Single line command handlers.
-
-    /^\@include\s+(.+)$/ and do {
-	push @instack, $inf;
-	$inf = gensym();
-	$file = postprocess($1);
-
-	# Try cwd and $ibase, then explicit -I paths.
-	$done = 0;
-	foreach $path ("", $ibase, @ipath) {
-	    $mypath = $file;
-	    $mypath = $path . "/" . $mypath if ($path ne "");
-	    open($inf, "<" . $mypath) and ($done = 1, last);
-	}
-	die "cannot find $file" if !$done;
-	next;
-    };
-
     /^\@(?:section|unnumbered|unnumberedsec|center)\s+(.+)$/
 	and $_ = "\n=head2 $1\n";
     /^\@subsection\s+(.+)$/
-- 
2.20.1



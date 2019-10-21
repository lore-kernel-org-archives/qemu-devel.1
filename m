Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E326CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448E220679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYoJFQLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448E220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZC8-00018H-MV
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMZ8v-0006Cg-SF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMZ8u-0004vn-JD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMZ8u-0004vF-BY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:58:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id r19so13718315wmh.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XxSQ2VYSXmZOnya65BQ3cEjKFTIeVI7kTuPBxhyJuKM=;
 b=nYoJFQLNGIsxktPiogLnpGMBPBzBkaziVjN0bI2KCEdkT0VGNGX3SC0gpUpQfkaH5e
 Dog3ilZZjGR9LXgatoW2VUTz+sBvzDQ6vcAfQiP+CayMuzjlDq//H8iiKqgrrRIfFYpa
 O4UQ0+K4bRdOR3N68aQPVg6ryTA1FQpuiC4dKJQYq9T3/uve470IhQAVFTvJZjBy4RYm
 P6SotitC75zoyTPv1bkjiCpUSPqMpb5XeeSukgxkZw5u/A1dD6EQqH8qyY1RGXY+OsxF
 NYMn9dZIs06cxiDXD8Gy12iDsBUbddZw9+6F/ftbyrIofRBGhk910y8qJg7L1gTQg81K
 6ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XxSQ2VYSXmZOnya65BQ3cEjKFTIeVI7kTuPBxhyJuKM=;
 b=Un76rH0p1NofZh4adkTtT27NfhjFahe4FN0CQc6PXAbbBXGt1Gisjq6UdXa6XfAaYy
 +2eRHlXlAIsKkStFmi+m+yfR5zVmnYJ1UcOZyTIGIVVa98qAS6kAihjmAnLhNfJZCiLL
 4S0nBTeRnSUy2JbDzso3YuANewO5DLETQk2G3wl408BvFYKGaBLVI1jbEBAlQZ6OdYyM
 ohwp55AGP1XF3TMcwvg7gZIJo4MUS5F5J0H3kgvcjDA/FMErzGtp1jAUYMFoG8bve9SD
 cyj7sPFu8OBLM08siuiPXZEk8QoilhGpnZt7TuMF205P9AnbPHWyIGdC5e505j5ot/NC
 uF/w==
X-Gm-Message-State: APjAAAUCTdfs9xXbsJL9Kyq5djZL0Pe+YIdR6xzqjZ3QMjh6II8+XCOp
 iwMIYC+EzH311ww0MmKfoEnL/8h4eF4=
X-Google-Smtp-Source: APXvYqw/tT4S68tlubWMU2+bX5ARBm1Hgo397bNhNduQyXzy6F6eARcnO6zfwkrD1piUUs/c8FNaOA==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr19108109wmk.135.1571669922152; 
 Mon, 21 Oct 2019 07:58:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w9sm8271122wrt.85.2019.10.21.07.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 07:58:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
Date: Mon, 21 Oct 2019 15:58:39 +0100
Message-Id: <20191021145839.12684-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Since 2008 the tcg/LICENSE file has not changed: it claims that
everything under tcg/ is BSD-licensed.

This is not true and hasn't been true for years: in 2013 we
accepted the tcg/aarch64 target code under a GPLv2-or-later
license statement. We don't really consider the tcg
subdirectory to be a distinct part of QEMU anyway.

Remove the LICENSE file, since claiming false information
about the license of the code is confusing, and update
the main project LICENSE file also to be clearer about
the license used by TCG.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This patch takes the simple approach of just documenting
the de-facto current reality; does anybody want to argue
for something else? Other possibilities I guess would be
specifically documenting tcg/aarch64 as an accidental
exception to the general licensing rule for tcg/, or even
trying to get it relicensed.

Does having tcg/ be BSD-licensed gain the project anything?
From my point of view I don't really see it as a cleanly
separable module of code -- it's quite tightly integrated
with the rest of QEMU, including code in accel/tcg which
is variously GPL or LGPL.

 LICENSE     | 4 ++--
 tcg/LICENSE | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)
 delete mode 100644 tcg/LICENSE

diff --git a/LICENSE b/LICENSE
index 9389ba614f8..e916360844f 100644
--- a/LICENSE
+++ b/LICENSE
@@ -18,8 +18,8 @@ As of July 2013, contributions under version 2 of the GNU General Public
 License (and no later version) are only accepted for the following files
 or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
 
-3) The Tiny Code Generator (TCG) is released under the BSD license
-   (see license headers in files).
+3) The Tiny Code Generator (TCG) is mostly under the BSD license;
+   but some parts may be GPLv2 (see license headers in files).
 
 4) QEMU is a trademark of Fabrice Bellard.
 
diff --git a/tcg/LICENSE b/tcg/LICENSE
deleted file mode 100644
index be817fa1625..00000000000
--- a/tcg/LICENSE
+++ /dev/null
@@ -1,3 +0,0 @@
-All the files in this directory and subdirectories are released under
-a BSD like license (see header in each file). No other license is
-accepted.
-- 
2.20.1



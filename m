Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C9ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D8021872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcxZGkby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D8021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO23W-0007oh-7V
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zQ-0004Rz-Nq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zP-0000ka-Ga
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:59:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO1zP-0000kK-Ae
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id v9so2931342wrq.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3fRx+H1bDXh1gn+0aN28Y42f87avsW9PJGXXX9/ZiRU=;
 b=XcxZGkbyFma0qczN/uOoCWPuVA5ArFc0vJLXVWYMCkYnOESORU6R4IwFHAiu13yJvw
 /3IgMLXwDc5qZjpfmpmPQ56HEVFZCbG6g5cN+/l6D8l/kVzsuyZuGRwHFD43Hz4DkxHa
 cQlugLAMmg0NBBedSKGIN7IQc3kQIkHmfge7P/WAQS2tT6G0SYk//0pSa/NtJTH8lwrn
 fCFUaekszG8bbEkW7CxsL4SdcbMFao+63P2PuIZWsQ2x9sSvKZD7lyiJDibcQr3NOwk/
 ajbsce6cTXpHzrYEdckjzCAXmOPMtpKUbDjMtXUnv2s6ZjCYfflRkpLeD2v60Iz51c0+
 18Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3fRx+H1bDXh1gn+0aN28Y42f87avsW9PJGXXX9/ZiRU=;
 b=qS6mfMpVBPaCK6bl2xXm5V7cYDgiynClhuwE6d4Wkk921YmWU/RiJ/uZQ7XYlutSnY
 yIXHdqyk66ICJxi7ZYb5ztSB4DICEpP5nZE3EwcwXYDCre6HbRxat9Sb1ooxShtKrmF7
 By7Fi2LucUV58vE3dmWgSDgl4bfj1KK+c16UXqGQWZ2xI9KR5hujJc6NKi34KT1/zA2T
 Y7HMODlYnijtCwpmdgiq77NWF4A46JIY/aasxnBGKAXzfWsB9P7J4CbY4Bu2oEe1dPXP
 +VdaxrFnMio2YQBN21DmtN3jxX1uu7KHTPDl0Ugw8kzms6fBn+WorDSaCH3alhGKODYL
 WZ1Q==
X-Gm-Message-State: APjAAAV6mFPbtdzXKr6DoY2nY7S3nxKVKxcQq+I7+etyQ8WxHU3BncVJ
 szZQPh6oGDvKMY1eoPvnzvHLjOQaYLI=
X-Google-Smtp-Source: APXvYqyESEwWX9MQ5z5QJZdCzl8KWi6aOkiiboPLaxl9iSGt2Tbv+b8bYX6m2i/kr7fZopbxNRhq2g==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr3511723wrp.95.1572019138054;
 Fri, 25 Oct 2019 08:58:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 65sm4218887wrs.9.2019.10.25.08.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 08:58:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] tcg/LICENSE: Remove out of date claim about TCG
 subdirectory licensing
Date: Fri, 25 Oct 2019 16:58:48 +0100
Message-Id: <20191025155848.17362-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025155848.17362-1-peter.maydell@linaro.org>
References: <20191025155848.17362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 2008 the tcg/LICENSE file has not changed: it claims that
everything under tcg/ is BSD-licensed.

This is not true and hasn't been true for years: in 2013 we
accepted the tcg/aarch64 target code under a GPLv2-or-later
license statement. We also have generic vector optimisation
code under the LGPL2.1-or-later, and the TCI backend is
GPLv2-or-later. Further, many of the files are not BSD
licensed but MIT licensed.

We don't really consider the tcg subdirectory to be a distinct part
of QEMU anyway.

Remove the LICENSE file, since claiming false information
about the license of the code is confusing.

Update the main project LICENSE file also to be clearer about
the licenses used by TCG.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2: changed wording of new para 3 in
top level LICENSE file, since I noticed that we actually
have a lot of MIT-licensed code in tcg/ too.
---
 LICENSE     | 5 +++--
 tcg/LICENSE | 3 ---
 2 files changed, 3 insertions(+), 5 deletions(-)
 delete mode 100644 tcg/LICENSE

diff --git a/LICENSE b/LICENSE
index 9389ba614f8..f19b018486a 100644
--- a/LICENSE
+++ b/LICENSE
@@ -18,8 +18,9 @@ As of July 2013, contributions under version 2 of the GNU General Public
 License (and no later version) are only accepted for the following files
 or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
 
-3) The Tiny Code Generator (TCG) is released under the BSD license
-   (see license headers in files).
+3) The Tiny Code Generator (TCG) is mostly under the BSD or MIT licenses;
+   but some parts may be GPLv2 or other licenses. Again, see the
+   specific licensing information in each source file.
 
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



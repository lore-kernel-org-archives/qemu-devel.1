Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4674CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE1B2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBqtBNxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE1B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHxAN-0000Kg-8a
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx59-0003Dm-EL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx58-0000Yr-Cy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx58-0000W8-67
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id u12so5220731pgb.10
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o9JKpzI/epj4oTMvrkZSj1+UhfI0QZGWg+p5R22DKV4=;
 b=eBqtBNxXIBOxeXQY8NqlCB7pb3vAtGykDRG6rNeEQlvdzs36JRFf4qCAm1SVErhlOe
 R6ltlBev+GqfksWLzEVfZ3yqoLuU+npojA1N/XHZPK+owchAdjT0MiFAvAxTI6qgyxt6
 F3XOjwo1Dvs/ATrN+2NfZsEmoyolH99WBbSmmvch5jGsUypTgp2camMIIYQIhlgWZ7c7
 QUCkyulUIxUpC6Sl12L4TT66LgXADmuEnpG9/u+6R4cVYDCaP7bZbrwW2Eyubd+xTLYf
 JQ9E5CVLU9bhG/xkQgBkpnnSQCnQwkUAABgVWWpfNGwzO978/eKUUWXAbahTTENtPAQj
 hdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o9JKpzI/epj4oTMvrkZSj1+UhfI0QZGWg+p5R22DKV4=;
 b=IkMOA9Nvji4ttTLwCI8Lwe2GNeIWLME8AVlC9W8FtL/fqjtZ5riay9nmphrA3FAwsd
 fsltGhlBTJ/L5j+CQ/nkiBkl6uX+w+fF4SiLU9ksG7IVtCCSJAZv+LMoHWHTcyPekLLH
 dChwHcVpSm2GULzdLAqIDxyvp85vhlU8TwhdFBre1t/cpC/EzEIUsQOF+E+IM8HtuFS5
 iO1/L5SGUMxB9d5y+4I9tG+Fk0WgiVVtGgB5Roga0T0zy7pK4B6w8F5FSln0C/NTPpiF
 hNKnn1sPdrsArV2RUYOsQBG5IU2prcCF2GeBQeNVY2O7+qEbRnqepvasjoCcsPQy7us3
 cQyQ==
X-Gm-Message-State: ANhLgQ0XQakGtUTyQ4i20vDQ9PVYmlW3DP6WfxX0xvI0gucQ7jwl64Fr
 VjNz8CjHI/VLO1IzuJ20rZ1VcjZyITU=
X-Google-Smtp-Source: ADFU+vuaKMGLCUG9eAji94bRLpnr6cXWut+tpvChaOmAG8/WFA2zK1CHAeRU8SwP4AGfjaubWX6Ejg==
X-Received: by 2002:a62:1a03:: with SMTP id a3mr1345219pfa.171.1585346639574; 
 Fri, 27 Mar 2020 15:03:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:03:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 3/7] configure: Do not force pie=no for non-x86
Date: Fri, 27 Mar 2020 15:03:49 -0700
Message-Id: <20200327220353.27233-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: dim@FreeBSD.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PIE is supported on many other hosts besides x86.

The default for non-x86 is now the same as x86: pie is used
if supported, and may be forced via --enable/--disable-pie.

The original commit (40d6444e91c) said:

  "Non-x86 are not changed, as they require TCG changes"

but I think that's wrong -- there's nothing about PIE that
affects TCG one way or another.

Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index 2afcae61df..cbde833f6e 100755
--- a/configure
+++ b/configure
@@ -2107,16 +2107,6 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" = ""; then
-  case "$cpu-$targetos" in
-    i386-Linux|x86_64-Linux|x32-Linux|i386-OpenBSD|x86_64-OpenBSD)
-      ;;
-    *)
-      pie="no"
-      ;;
-  esac
-fi
-
 if test "$pie" != "no" ; then
   cat > $TMPC << EOF
 
-- 
2.20.1



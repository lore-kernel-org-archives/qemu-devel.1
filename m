Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C12A20715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4sqalGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C12A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPtd-0005lg-0e
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs2-00044Z-HR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs1-0002hF-KB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:30 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPs1-0002gF-F4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:29 -0500
Received: by mail-pf1-x441.google.com with SMTP id w62so387819pfw.8
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U37ZVea/IPVlUTlCbim6MG1bzwxdwI6SbTuQBxQprmQ=;
 b=O4sqalGrVEpEgA/aYiYZMesdGTR5zzjQ9y+d7OjxUqB7mb0KeKZezCUHmhHRyV6c7P
 QaePnNjrKRMhvBwd7jV0G06PCdsNPsG/w81xR4fC7r+jhZltfHUOcQmi+fbP+ohUoleD
 cBPgegVi3Ua9TlEER7EeS57W/BFaprT4qJ78r07pwe++hLPYR5NwYN7tahvLqUf2+PfL
 ZeelmluZ/DlQiHZyKclSqD2JOIz3IlqWKmvxLN2U41QdvWi3L5u5hO2wX4R7v8rUIwLl
 kTxF2e0PMHKYtzzTG4SO79QnaJHO7at+0NBW3YO9VwqZmup6pUE/pQu+Chdlb8ceftvB
 xs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U37ZVea/IPVlUTlCbim6MG1bzwxdwI6SbTuQBxQprmQ=;
 b=RLDnURzqVYUZNq/Z43poRImuj4fp0nC1dYAxGkOxuv0469HIPN6a5SBFiUsxM5gXd9
 x/G6rSzMwDZCtWG5zTmPBTP9snXFfc9wjzWznv8wRikwj6JGy1Zur7pWZ2pCgmdMYlp3
 uEk5fR3fqt/jACU8cyKgY1NuL6yESSqeNdc+CAbOk1wXfWF09S0wVs2BfthkcF83BtKy
 mymCFpXOYIfWIzpXbmPQrh1m5obPMbJJ/oXpwSbPeSLHBfv9R3B0iKwJhpsWSYCksRbW
 rEI8p2uf8LToFp5R8+keNjinf9JkpkKfQ4QWPJAMdFlEr6XCjLREbJckTs33s5BhW9By
 uvYA==
X-Gm-Message-State: APjAAAUyz4uqET0DkBxJgnQHGTdPmSV7Z/oIYoDdF9pbIffdEJPHS8qc
 O2LblwcywrwIlT70PtjiM2mg/+f5jZ8=
X-Google-Smtp-Source: APXvYqzFBVLJsImdbnJCUrmpE0AC+UmycuXsj28TDd7TV8loQem68Pn1JUl9xOgQWVqnfqxpYpN7tQ==
X-Received: by 2002:a63:3f47:: with SMTP id m68mr276712pga.411.1576639168087; 
 Tue, 17 Dec 2019 19:19:28 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] configure: Do not force pie=no for non-x86
Date: Tue, 17 Dec 2019 17:19:16 -1000
Message-Id: <20191218031920.6414-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PIE is supported on many other hosts besides x86.

The default for non-x86 is now the same as x86: pie is used
if supported, and may be forced via --enable/--disable-pie.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index 255ac432af..2fb4457d7c 100755
--- a/configure
+++ b/configure
@@ -2012,16 +2012,6 @@ if ! compile_prog "-Werror" "" ; then
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



Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2752C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B18820717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HR2MfF44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B18820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhwx-0004td-Hp
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu8-0001TR-TG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu7-0003w1-7C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:52 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhu7-0003vM-1l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:51 -0500
Received: by mail-pj1-x1044.google.com with SMTP id n59so1547428pjb.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0o3CRcHml81TDDyh0N84h3eTIdNUcDVT7umUw0AUs+8=;
 b=HR2MfF44BxE7XuFsa+AGcR4X/1uC7IYEpME0y22N1LeDn3WNWepPKKTh2fXYxUtDvO
 c4gvIIBcxIWCXLYQbSITVbVEeQfCG3IRfWEz1oZnjSv5AsRDdatqvbnaKppLLNIKy5vx
 G3YrMM5akcZyuclfP2sjypwIWZILQQBvm2GlSGVFJuCny2fp3qMixumgb6gdpzidVnGy
 0hLa8cP6MwZ/lVIp/iBu5PNFjF/GT3WzvErYUfj7zSlmN9YErrKw9iGpdIA1DKPRtivG
 AwIShAkgcZ0a8TGeW8m0fLShsShYwAkrvdzPAVEurBCYiIq9G7nzSnBeFfdum3r4AO/G
 KcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0o3CRcHml81TDDyh0N84h3eTIdNUcDVT7umUw0AUs+8=;
 b=ech60G1Ee4M6z6y6kp6ZU4XDzhlwrI5TH5rdlElQoJfkFXCkEh005wI4cqLYFh78cC
 zE7lHpv1Is6SVcjUJqmh11OtX+KhAFEOYOdsBAkCOH1YY/2TXx7RYViAe1NpI5j5s7Cs
 dNJJfQBixtlj9wY4no91VDPk9g1Y7HUA+iTRJhf0ivA/DAysqzsf8zAyhLY3zLRow4Vy
 iQO5U87hktOgk9CGdK6Lq75YCZPo0s7xPggYQRPzQM8zXjA2ju66NGjiHt3NUOgMMYF9
 j/viCx3vR8O2EhODNcxJxX7hIj2tbs4Z5M6wiUxRoMOGO7P0ug8EZSo9MafGtqSvP71n
 Q8hw==
X-Gm-Message-State: APjAAAWlmvXz1vIjWpF75jD/lZ/RgonTZILv+rwYwIjHRLj71asGABjK
 RZtxsrCTuTCpKr4jExWdNJHQX8SI3RA=
X-Google-Smtp-Source: APXvYqw3kL3ECRLQ7wL/n4/DN+3SLMCi8JbA5ZQYCDUmNdtP5WVqRvFypX1JEzEB73kPVoi1NbI3ug==
X-Received: by 2002:a17:90a:5217:: with SMTP id
 v23mr5607953pjh.121.1576708489521; 
 Wed, 18 Dec 2019 14:34:49 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] configure: Do not force pie=no for non-x86
Date: Wed, 18 Dec 2019 12:34:37 -1000
Message-Id: <20191218223441.23852-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

The original commit (40d6444e91c) said:

  "Non-x86 are not changed, as they require TCG changes"

but I think that's wrong -- there's nothing about PIE that
affects TCG one way or another.

Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index 30e3875c6b..99faf64a74 100755
--- a/configure
+++ b/configure
@@ -2018,16 +2018,6 @@ if ! compile_prog "-Werror" "" ; then
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



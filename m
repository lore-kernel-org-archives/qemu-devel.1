Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3CBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D562064A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8jcJe78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D562064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORqk-0007nL-6n
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpV-00062m-NP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpU-0005x1-LP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpU-0005wl-FG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r26so15788406wmh.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Stc4FSJiUzlY3FsuzLYHemmHJ45cRRBL4YVh1lfAAYo=;
 b=W8jcJe78mqjkvE6H+bdu8ofUq0cSwVmy6RU/hV5ucrYJUQjdhYExE1UkzzL8C6U4lk
 ORctGtC8la1fk29F9VFeOX8DNakh0o/HgD5vjlU2FAQdLBKyugjZfjGpsQbJsZ08Xkqy
 9pT5FOgez7s6W3ozydc5zEadWEAL8gDTKkfLjqOrHildDpNZwYGTe6yA1WOQ4ee02DpJ
 52YqE/KjUog3hMh9vttq+wRR4y4osAfxMksh0Ad98YVUL54tNLAA+Vc9d3839lOPgugp
 Tuj1R/MtvGLC2mHqO9d9gFvIx6bldpKB46hwORedIazkKNJS8HnolFykJ+NknNgNWlDQ
 k62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Stc4FSJiUzlY3FsuzLYHemmHJ45cRRBL4YVh1lfAAYo=;
 b=aNdQ7X6dUZGSjuqX9qOimVTGbUSilZjNgf7gTEM86/TYR37EpjrL25HcemldhapMk9
 G7u+wTvK2931JMjDn+0K8ECAu5ax5OkY3hNnUjctHfely4UBAjTrIqXjdQ7b7Ddu4pBM
 eq3asBhnGwnj3qFy7oHQ5LWRQ7tVwuGFkHyZbJzE5PdpdBMCZ84MdMtOaHA9L2r2V2yO
 /Ef2LEjCW4iKxL/Fb2wF8zxcWvfXXpxLyQfnZ+V7eiCfUWfZ5jg7n9n3LM3e68B8YeSK
 LkjqPV+mlNaR8hYlPLSMx82bV6+Qo7+lE0BtevTv6O5Yo3BoifnNg627pNNddO14afqy
 52HA==
X-Gm-Message-State: AGi0PuZT7wy8Xqow7uwXGq1v7Tlr2VG543cIBnCYutukZJYH3Jd4csey
 1u4e8EoIgiJ1FSbq2ALjwQMH56RnTLI=
X-Google-Smtp-Source: APiQypLMedX9vL+LX4Y+IWSMEHYbXa6P79jXySM4B/nf/jT6w4Vg4Rh+Wh9VES0DYml0lDPD0nHxlw==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr1506122wma.89.1586894803480; 
 Tue, 14 Apr 2020 13:06:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm21130075wra.79.2020.04.14.13.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA7FC1FF93;
 Tue, 14 Apr 2020 21:06:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/17] configure: redirect sphinx-build check to config.log
Date: Tue, 14 Apr 2020 21:06:21 +0100
Message-Id: <20200414200631.12799-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise it's hard to debug whats going on.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 9b1f5b33e45..25f7d915720 100755
--- a/configure
+++ b/configure
@@ -4942,7 +4942,9 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" $sphinx_werror -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
+                    -b html "$TMPDIR1/sphinx" \
+                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
 }
 
 # Check if tools are available to build documentation.
-- 
2.20.1



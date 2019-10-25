Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617752070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pr6ppy9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617752070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuQY-0000u9-JE
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtq1-0004jc-Aa
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpz-0007FM-T6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpz-0007ES-Mb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 6so3596141wmf.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=71jlC4Z8g9Q/EoUX8xnqEL9oQfxujIcEuUZtk5+Z8NY=;
 b=Pr6ppy9UpYTjaVN47IQ8zuN+NmWFcUAUJLPDCGsPpJCHXwOjo4FSKpG3I6iw/0wA6D
 zkJfSG5Oow1GkYuJamGx6lm94nmBwDWKs3hk0kG8bYcid4Ogj/+uqX+Mvnezb4bVxkLr
 kb/DNfhRJS6VoiaPPNvAYTRbFxHtEFQn0V7qo4gUXoq5vG9bq/DrS/liqi7XvD4Fhek3
 H5p9yyP/Gd56OClOzxqUBSAK6cP5OTQAAGzlO43ZK/kfgf5nBzMvhNBhezTH4W/WOKUF
 GsiE9EKDlebEifdI+oc5x1HCW6CPgHog1VoLENnkOXM4FvYxZZCsKcnuYGmiXjWUNHPG
 1ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=71jlC4Z8g9Q/EoUX8xnqEL9oQfxujIcEuUZtk5+Z8NY=;
 b=A+EQsVWyGgljmQD8yCoaH3PXz2JLrECEnT1ntdDj+4TwDIHdETymd+DX6DfBalPz9p
 opCeTbLBT35kasQ4ZWkXEYbhbl/nhtlwTAM0bVVfajOFlcp4OjjhZaVQjDFBYspniOm+
 eT63ICGKyK97bezcEe2BqOOTiOSEQXDMXP68pZCuDFBnxQQFwJupEg9DRU8KL7+l7ibQ
 xsmZIw5+YQ1SnXazhiNsI91mdl//48cy49uAAPKNG6/Vtk1pHR7VIKT3b7LQ5OE8G/AM
 4CrUeI6NFegGNgGI1JPNdpuaQSDTkaf+neUmNy7nnxT1PulOWy1aIx3BZjCVemQ6ArL9
 aLmQ==
X-Gm-Message-State: APjAAAWH3eUfeWa5wcI57/SEnYeDEPZJN+9Bsq2uEVZI/HYnvxTkPeU7
 TGAckkTPHOR9cXnyusIl6pU5lA==
X-Google-Smtp-Source: APXvYqxwtVc+Pqw7iqi4lU7MS41j5/6kil8ca1tOKCdlpIk6/VLliNCAQgLvDnOuxx73ZO42KZS+3A==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr1888031wmb.163.1571987802599; 
 Fri, 25 Oct 2019 00:16:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p12sm1201236wrt.7.2019.10.25.00.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 27B0B1FFA3;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 16/73] tests/docker: update Travis image to a more current
 version
Date: Fri, 25 Oct 2019 07:36:16 +0100
Message-Id: <20191025063713.23374-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This isn't the latest one available on hub.docker.com but it does
match the ID reported by the Xenial builds running on Travis:

  instance: ... travis-ci-sardonyx-xenial-1553530528-f909ac5

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index ea14da29d97..e8eb48dccfd 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,4 +1,8 @@
-FROM travisci/ci-sardonyx:packer-1546978056-2c98a19
+#
+# Travis Image - this is broadly the same image that we run our CI
+# tests on.
+#
+FROM travisci/ci-sardonyx:packer-1552557266-f909ac5
 ENV DEBIAN_FRONTEND noninteractive
 ENV LANG en_US.UTF-8
 ENV LC_ALL en_US.UTF-8
-- 
2.20.1



Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF52C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EBD206D8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuvnG18T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EBD206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt9H-000580-P9
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2k-0006Tr-2s
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:20:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2h-00028j-Sk
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604874011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOlQmfFaNvcfnBXreBEQVhcMzqQm6Lj5i87BO0gaUIY=;
 b=JuvnG18TYMUxYqpAgCi6zOU5ZaNVUQMPQKFpKL10Mvpf2pwJOr6QCIw8lOMqhO2JH5vTOH
 rHQE9oFhOeO6F5wtsw990Bi30bhTHgYroL5lmi5eJe1ppAXgTQC2vMhK3AmfyKuopAU2P0
 ukYtZ3uonOOTXn8ho5K0J2E+jKI8/v8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-_fDEa85lMJiypRoiSoTjHg-1; Sun, 08 Nov 2020 17:20:08 -0500
X-MC-Unique: _fDEa85lMJiypRoiSoTjHg-1
Received: by mail-wr1-f72.google.com with SMTP id w17so2732833wrp.11
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tOlQmfFaNvcfnBXreBEQVhcMzqQm6Lj5i87BO0gaUIY=;
 b=D6PhwGGqTW/kxh7c9mblh32yLLqmfJqwI9Lb1B7fGJtGFCotPD4y2HiSIemNJadOY3
 LAPXZXo/jEYJPdB5igiYi8GHdHpFfvbZAlAZPV8BQEwdY8IhZhBSlPR9kaVqowPEiNGq
 v1TAnmLldQzpOBDBMa6XdEInUIGB/iTYI5HDowT/8CdSd8eTPG7lbIMWfk/+I0A5gsEF
 wQqHHRGwToeZaZDc5TgNsyASn0/PYF+ZhXyc03nG4rGbAdesPwoDHxNpfKw6xvVG3Voi
 KOHkjJGzkNVZ2i0PrDkmM0jmPC2tecbw4UZrsCd7SsI17Jn9A3hpp1vF4lmcbFl/w9jm
 jnVQ==
X-Gm-Message-State: AOAM532JyofL0Dee549pvOQ0PltkRrGergiVv7foo7JlXzfz9TG0WjRO
 5ihafMHzvej8eAiW6hj/RRV0KnA601HHbNa9H3PmNFdYHxhiF/cp5GK9rUoS4tferH3sQkeFmZP
 zsphIqQwkeOJ/aAY=
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr11324773wmk.100.1604874006946; 
 Sun, 08 Nov 2020 14:20:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZQUm+sFj9DoS7Tr778LdHf49FKFtfJ6i5n/KzjhiMfTDBccPg8W21lzQWuTjJS+pMpvvqdw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr11324756wmk.100.1604874006800; 
 Sun, 08 Nov 2020 14:20:06 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x6sm4107170wmc.48.2020.11.08.14.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:20:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/11] gitlab-ci: Extract common job definition as
 'native_common_job'
Date: Sun,  8 Nov 2020 23:19:22 +0100
Message-Id: <20201108221925.2344515-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108221925.2344515-1-philmd@redhat.com>
References: <20201108221925.2344515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the common definitions shared by '.native_build_job'
and '.native_test_job' to '.native_common_job'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d4526323169..f708573884e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,9 +13,12 @@ include:
   - local: '/.gitlab-ci.d/containers.yml'
   - local: '/.gitlab-ci.d/crossbuilds.yml'
 
-.native_build_job:
-  stage: build
+.native_common_job:
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+
+.native_build_job:
+  extends: .native_common_job
+  stage: build
   before_script:
     - JOBS=$(expr $(nproc) + 1)
     - sed -i s,git.qemu.org/git,gitlab.com/qemu-project, .gitmodules
@@ -35,8 +38,8 @@ include:
       fi
 
 .native_test_job:
+  extends: .native_common_job
   stage: test
-  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
     - cd build
     - find . -type f -exec touch {} +
-- 
2.26.2



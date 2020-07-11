Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8FA20786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX29BUqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8FA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJ0i-0008CZ-E8
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyZ-0003be-5b
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyX-0006iB-L5
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id a6so8983536wrm.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y5Y/xG6+n8aPwS0ktxj8u/ALjUogUq9BxYjunfv0mhM=;
 b=qX29BUqVf9EXuHAogC3T9QkifcXWXg8j74TR4kL6f4safv8eZqfAZGruR/dD1CDD5y
 IdBSCP79Cm8/isUt0WX7Iz6kkc4KyhBWRKD8reU5PsNGLnrwd3CgfBdfoUD7Y4JWh3h4
 8TlGt7KAFE35l933YP0TLTlY3OQzWiMWKL1vDiXZxlq7Hp3IPeuh04sH4bYALeUQ3nh6
 w6b1NYpMKvnsDNZ5YCv0osYjm+UrPv/SuQD6cVKOXaBqbCLViZhvLx3OZi8xQhsCz9bX
 yM17rMHPET8/b/u7rMqc8h9Lm++QAz7/TY/MPhqoG6zSqKp+ovtOj5D5YLL+FA+wZvTL
 6tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y5Y/xG6+n8aPwS0ktxj8u/ALjUogUq9BxYjunfv0mhM=;
 b=CekxRinTG7Nt/SE1D+n+UG+XGsRSnLkdbkwwPWKDW7en0HWfDmkacOrz1AuJNJzLUd
 U/U6ry6hV9En11HlS6HJ0qHQVojS4hFkSPy49J9sU8ukRASiJqux6ErVztLmNGvQxrzW
 Zhr+OC3vLzQ1aPBb9FIxdnbjGF9yN1lXFr1vxczyXIHr/0Psb5/TH224Y18QSlPsKwFp
 nkPTAc/W5cGe9SuHIBg4AkH3flrNWENgzb8QSX6QbpxckN0HI3YwfjpWXyWrbqHXo8QD
 U5sPi2h6oJeD1JiSDpeWJZaWMmui+sRbjKO+wq8RERRN4a3gQC+6jN40HPr6/5rDQZ5k
 DwgQ==
X-Gm-Message-State: AOAM532nadtjRw4Gw7z9eGknJVv0TxJK2ddovApzS61kU+mVelPQmBOk
 E0B9fE23PMiONbpGQVZiQZMPqQ==
X-Google-Smtp-Source: ABdhPJz0yuqUqgxCALem3VEjP2B3dWjAURnAtMoC2SRUlkZO6WUTcqihTM9dEKOcBHvzz3skzTsuGg==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr69454737wrr.279.1594487264268; 
 Sat, 11 Jul 2020 10:07:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm15922244wme.17.2020.07.11.10.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D40881FF96;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 48/50] tests: fix "make check-qtest" for modular builds
Date: Sat, 11 Jul 2020 18:07:30 +0100
Message-Id: <20200711170732.26213-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200710203652.9708-2-kraxel@redhat.com>

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 98af2c2d93..6a0276fd42 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -277,6 +277,7 @@ tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
 tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
 tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
 tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
+tests/qtest/modules-test$(EXESUF): tests/qtest/modules-test.o
 tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
 tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
 tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
-- 
2.20.1



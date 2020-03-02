Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A9C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C877420842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVNXvTqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C877420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pmS-0006W0-UZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfD-0002We-9Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfC-0001DH-5f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8pfB-00019h-Ut
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id z11so946908wro.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z7tiVgE0/FNumYwGDaf9+n6Hr38jcg9tS9OSWzqMpF0=;
 b=eVNXvTqxkgzp4va17Wq3iQBjA4MXaCuf/mi2kTxN7+BnJfrGJ/LEiv4gChYnjs+J8q
 xN0IZs8pugYKpJk8MnGpicMVLY9uVJ1vkzzplxOFCp16JQ4Ii4stWBZgMaRh19mMA6eZ
 YKPRFiVeAd4QGz+rHbRSyqUCm5UPW8jHnV9DEbtFpl/0LM/20t7uWbtECXgKxpDaoql4
 SCvPXTRDW/k+2CZoj0qT00zaHUj547W+N9oK72FxY5yyrRHeMvZZfPnqIM8BcS2BEAZu
 AxRTw2GCouxpDYNBN5le86ILVCzTFdfEEmVsal3RZIUM7gfIIGslHYjceP6ORWqbc/c1
 b64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z7tiVgE0/FNumYwGDaf9+n6Hr38jcg9tS9OSWzqMpF0=;
 b=FIAKUCTRVklzomC47TZG/YXTVZtxFukHgTg73gStQf8u8gBlhIv9uBmP2b6k3y9ce7
 dDz2e6gL0nVfMPkOLe+Ud+6Onxy1WH+SyO4TaANnMdvtkBdJtpWdnuTE61fKRnbEKwdV
 q7QY2TteHSR0G17yF4BbG6eHK9FmbYnVrCDi3PqTyX+NITXIZZ/VEC3r9kvGShKD0oBA
 PN6folNpbI201qJPIErMbxX31SC+fP0PKHCcXxZjK6QtecGWF4jE/WQ864DLoPiYA8Xj
 DozqL8pW178GZkXbQ3RzafiJEIkqP5laOzuxDGb0LiET4JFyPQ2ZvdooGX3BteIzY2PY
 QmZw==
X-Gm-Message-State: ANhLgQ2eqHyGLsYz/swIAD0CMifOyMDKa6sJgz3E7QU8sEsEofkhshtZ
 eXNpKoHw/f05dpECX0jZGVeXtQ==
X-Google-Smtp-Source: ADFU+vtMYr+oWrgHcMKpJMtAtS93BWI7TmweUrJXGm8P0nqElK1zbMTyPAvVUDTtNGmHYj5MoydHcw==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr758325wrw.47.1583173152151;
 Mon, 02 Mar 2020 10:19:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm318344wme.36.2020.03.02.10.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:09 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4F031FF91;
 Mon,  2 Mar 2020 18:19:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 04/10] tests/vm: give wait_ssh() option to wait for root
Date: Mon,  2 Mar 2020 18:19:01 +0000
Message-Id: <20200302181907.32110-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302181907.32110-1-alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Allow wait_ssh to wait for root user to be ready.
This solves the issue where we perform a wait_ssh()
successfully, but the root user is not yet ready
to be logged in.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200219163537.22098-5-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5ca445e29af..7f268922685 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -312,7 +312,7 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
@@ -320,7 +320,10 @@ class BaseVM(object):
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
         while datetime.datetime.now() < endtime:
-            if self.ssh("exit 0") == 0:
+            if wait_root and self.ssh_root("exit 0") == 0:
+                guest_up = True
+                break
+            elif self.ssh("exit 0") == 0:
                 guest_up = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
-- 
2.20.1


